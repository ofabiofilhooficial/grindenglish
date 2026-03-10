import { useState } from 'react';
import { AppLayout } from '@/components/layout/AppLayout';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Switch } from '@/components/ui/switch';
import { Button } from '@/components/ui/button';
import { Separator } from '@/components/ui/separator';
import { Badge } from '@/components/ui/badge';
import { Settings, Globe, Bell, Shield, Database, Palette } from 'lucide-react';
import { useToast } from '@/hooks/use-toast';

export default function AdminSettingsPage() {
  const { toast } = useToast();

  // Local state for settings (will be persisted to DB in a future step)
  const [platformName, setPlatformName] = useState('English Mastery Lab');
  const [allowSignups, setAllowSignups] = useState(true);
  const [requireEmailVerification, setRequireEmailVerification] = useState(true);
  const [defaultRole, setDefaultRole] = useState('learner');
  const [maintenanceMode, setMaintenanceMode] = useState(false);
  const [emailNotifications, setEmailNotifications] = useState(true);

  const handleSave = () => {
    toast({ title: 'Settings saved', description: 'Platform settings have been updated. (Note: persistence coming soon.)' });
  };

  return (
    <AppLayout title="Organization Settings" subtitle="Configure platform-wide settings">
      <div className="p-6 space-y-6 max-w-3xl">
        {/* General */}
        <Card>
          <CardHeader>
            <CardTitle className="font-display flex items-center gap-2">
              <Globe className="h-5 w-5" />
              General
            </CardTitle>
            <CardDescription>Basic platform configuration</CardDescription>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="platformName">Platform Name</Label>
              <Input id="platformName" value={platformName} onChange={(e) => setPlatformName(e.target.value)} />
            </div>
            <div className="flex items-center justify-between">
              <div>
                <Label>Maintenance Mode</Label>
                <p className="text-sm text-muted-foreground">Temporarily restrict access to admins only</p>
              </div>
              <Switch checked={maintenanceMode} onCheckedChange={setMaintenanceMode} />
            </div>
          </CardContent>
        </Card>

        {/* Authentication */}
        <Card>
          <CardHeader>
            <CardTitle className="font-display flex items-center gap-2">
              <Shield className="h-5 w-5" />
              Authentication
            </CardTitle>
            <CardDescription>Control how users access the platform</CardDescription>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="flex items-center justify-between">
              <div>
                <Label>Allow New Signups</Label>
                <p className="text-sm text-muted-foreground">When disabled, only existing users can log in</p>
              </div>
              <Switch checked={allowSignups} onCheckedChange={setAllowSignups} />
            </div>
            <Separator />
            <div className="flex items-center justify-between">
              <div>
                <Label>Require Email Verification</Label>
                <p className="text-sm text-muted-foreground">Users must verify their email before accessing the platform</p>
              </div>
              <Switch checked={requireEmailVerification} onCheckedChange={setRequireEmailVerification} />
            </div>
            <Separator />
            <div className="space-y-2">
              <Label>Default Role for New Users</Label>
              <div className="flex gap-2">
                {['learner', 'teacher'].map((role) => (
                  <Badge
                    key={role}
                    variant={defaultRole === role ? 'default' : 'outline'}
                    className="cursor-pointer capitalize"
                    onClick={() => setDefaultRole(role)}
                  >
                    {role}
                  </Badge>
                ))}
              </div>
              <p className="text-xs text-muted-foreground">Currently: new users are assigned the <strong>{defaultRole}</strong> role on signup.</p>
            </div>
          </CardContent>
        </Card>

        {/* Notifications */}
        <Card>
          <CardHeader>
            <CardTitle className="font-display flex items-center gap-2">
              <Bell className="h-5 w-5" />
              Notifications
            </CardTitle>
            <CardDescription>Manage notification preferences</CardDescription>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="flex items-center justify-between">
              <div>
                <Label>Email Notifications</Label>
                <p className="text-sm text-muted-foreground">Send email notifications for important events</p>
              </div>
              <Switch checked={emailNotifications} onCheckedChange={setEmailNotifications} />
            </div>
          </CardContent>
        </Card>

        {/* Platform Info */}
        <Card>
          <CardHeader>
            <CardTitle className="font-display flex items-center gap-2">
              <Database className="h-5 w-5" />
              Platform Info
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="grid grid-cols-2 gap-4 text-sm">
              <div>
                <p className="text-muted-foreground">Version</p>
                <p className="font-medium">1.0.0-alpha</p>
              </div>
              <div>
                <p className="text-muted-foreground">Environment</p>
                <Badge variant="outline">Development</Badge>
              </div>
              <div>
                <p className="text-muted-foreground">Backend</p>
                <Badge variant="outline" className="bg-primary/10 text-primary border-primary/30">Supabase</Badge>
              </div>
              <div>
                <p className="text-muted-foreground">Database</p>
                <Badge variant="outline">PostgreSQL</Badge>
              </div>
            </div>
          </CardContent>
        </Card>

        <div className="flex justify-end">
          <Button onClick={handleSave} size="lg">
            Save Settings
          </Button>
        </div>
      </div>
    </AppLayout>
  );
}
