import { useEffect } from "react";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { z } from "zod";
import { Loader2 } from "lucide-react";
import { Button } from "@/components/ui/button";
import {
  Form,
  FormControl,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from "@/components/ui/form";
import { Input } from "@/components/ui/input";
import { useToast } from "@/hooks/use-toast";

// Form schema with validation
const profileFormSchema = z.object({
  fullName: z
    .string()
    .max(255, "Full name must not exceed 255 characters")
    .transform((val) => val.trim()),
  email: z.string().email(), // Read-only, for display
});

type ProfileFormData = z.infer<typeof profileFormSchema>;

interface Profile {
  id: string;
  full_name: string | null;
  avatar_url: string | null;
}

interface ProfileFormProps {
  profile: Profile;
  email: string;
  onSave: (data: { fullName: string }) => Promise<void>;
  onDirtyChange: (isDirty: boolean) => void;
}

export function ProfileForm({
  profile,
  email,
  onSave,
  onDirtyChange,
}: ProfileFormProps) {
  const { toast } = useToast();
  const form = useForm<ProfileFormData>({
    resolver: zodResolver(profileFormSchema),
    defaultValues: {
      fullName: profile.full_name || "",
      email: email,
    },
  });

  const {
    formState: { isDirty, isSubmitting },
  } = form;

  // Notify parent of dirty state changes
  useEffect(() => {
    onDirtyChange(isDirty);
  }, [isDirty, onDirtyChange]);

  const handleSubmit = async (data: ProfileFormData) => {
    try {
      await onSave({ fullName: data.fullName });
      // Reset form with new values to clear dirty state
      form.reset(data);
      // Show success notification
      toast({
        title: "Profile updated",
        description: "Your profile has been updated successfully.",
      });
    } catch (error: any) {
      // Show error notification with descriptive message
      toast({
        title: "Update failed",
        description: error.message || "Failed to update profile. Please try again.",
        variant: "destructive",
      });
    }
  };

  return (
    <Form {...form}>
      <form onSubmit={form.handleSubmit(handleSubmit)} className="space-y-6">
        <FormField
          control={form.control}
          name="fullName"
          render={({ field }) => (
            <FormItem>
              <FormLabel>Full Name</FormLabel>
              <FormControl>
                <Input
                  placeholder="Enter your full name"
                  {...field}
                  disabled={isSubmitting}
                />
              </FormControl>
              <FormMessage />
            </FormItem>
          )}
        />

        <FormField
          control={form.control}
          name="email"
          render={({ field }) => (
            <FormItem>
              <FormLabel>Email</FormLabel>
              <FormControl>
                <Input
                  {...field}
                  disabled
                  className="bg-muted cursor-not-allowed"
                />
              </FormControl>
              <FormMessage />
            </FormItem>
          )}
        />

        <Button type="submit" disabled={!isDirty || isSubmitting}>
          {isSubmitting && <Loader2 className="mr-2 h-4 w-4 animate-spin" />}
          {isSubmitting ? "Saving..." : "Save Changes"}
        </Button>
      </form>
    </Form>
  );
}
