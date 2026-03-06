import { AppLayout } from '@/components/layout/AppLayout';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { UsersRound } from 'lucide-react';

export default function TeachDashboardPage() {
  return (
    <AppLayout title="Cohort Dashboard" subtitle="Manage your teaching groups">
      <div className="p-6">
        <Card>
          <CardHeader>
            <CardTitle className="font-display flex items-center gap-2">
              <UsersRound className="h-5 w-5" />
              Your Cohorts
            </CardTitle>
          </CardHeader>
          <CardContent>
            <p className="text-muted-foreground">Create and manage student cohorts, set pacing calendars, and track group progress. Cohort management is coming in the next phase.</p>
          </CardContent>
        </Card>
      </div>
    </AppLayout>
  );
}
