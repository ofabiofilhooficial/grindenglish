import { AppLayout } from '@/components/layout/AppLayout';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Settings } from 'lucide-react';

export default function AdminSettingsPage() {
  return (
    <AppLayout title="Organization Settings" subtitle="Configure platform-wide settings">
      <div className="p-6">
        <Card>
          <CardHeader>
            <CardTitle className="font-display flex items-center gap-2">
              <Settings className="h-5 w-5" />
              Settings
            </CardTitle>
          </CardHeader>
          <CardContent>
            <p className="text-muted-foreground">Organization settings will be available here. Configure platform name, default modes, and integrations.</p>
          </CardContent>
        </Card>
      </div>
    </AppLayout>
  );
}
