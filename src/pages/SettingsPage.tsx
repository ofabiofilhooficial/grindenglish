import { useState, useEffect } from "react";
import { useLocation, useNavigate, UNSAFE_NavigationContext } from "react-router-dom";
import { useContext } from "react";
import { useAuth } from "@/hooks/useAuth";
import { AppLayout } from "@/components/layout/AppLayout";
import { ProfileForm } from "@/components/settings/ProfileForm";
import { profileService } from "@/services/profileService";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Loader2 } from "lucide-react";

export default function SettingsPage() {
  const { user, profile, refreshProfile } = useAuth();
  const [hasUnsavedChanges, setHasUnsavedChanges] = useState(false);

  // Handle profile save
  const handleSave = async (data: { fullName: string }) => {
    if (!user?.id) {
      throw new Error("User not authenticated");
    }
    
    await profileService.updateProfile(user.id, data);
    await refreshProfile();
  };

  // Navigation guard for unsaved changes
  useEffect(() => {
    const handleBeforeUnload = (e: BeforeUnloadEvent) => {
      if (hasUnsavedChanges) {
        e.preventDefault();
        e.returnValue = "";
      }
    };

    window.addEventListener("beforeunload", handleBeforeUnload);
    return () => window.removeEventListener("beforeunload", handleBeforeUnload);
  }, [hasUnsavedChanges]);

  // Block React Router navigation when there are unsaved changes
  // Using UNSAFE_NavigationContext for compatibility with BrowserRouter
  const navigator = useContext(UNSAFE_NavigationContext).navigator;
  
  useEffect(() => {
    if (!hasUnsavedChanges) return;

    const originalPush = navigator.push;
    const originalReplace = navigator.replace;

    navigator.push = (...args: Parameters<typeof originalPush>) => {
      const shouldProceed = window.confirm(
        "You have unsaved changes. Are you sure you want to leave?"
      );
      if (shouldProceed) {
        originalPush(...args);
      }
    };

    navigator.replace = (...args: Parameters<typeof originalReplace>) => {
      const shouldProceed = window.confirm(
        "You have unsaved changes. Are you sure you want to leave?"
      );
      if (shouldProceed) {
        originalReplace(...args);
      }
    };

    return () => {
      navigator.push = originalPush;
      navigator.replace = originalReplace;
    };
  }, [hasUnsavedChanges, navigator]);

  return (
    <AppLayout title="Settings" subtitle="Manage your personal information">
      <div className="container max-w-4xl py-8">
        <Card>
          <CardHeader>
            <CardTitle>Profile Information</CardTitle>
            <CardDescription>
              Update your personal details and preferences
            </CardDescription>
          </CardHeader>
          <CardContent>
            {!profile || !user ? (
              <div className="flex items-center justify-center py-8">
                <Loader2 className="h-8 w-8 animate-spin text-muted-foreground" />
              </div>
            ) : (
              <ProfileForm
                profile={profile}
                email={user.email || ""}
                onSave={handleSave}
                onDirtyChange={setHasUnsavedChanges}
              />
            )}
          </CardContent>
        </Card>
      </div>
    </AppLayout>
  );
}
