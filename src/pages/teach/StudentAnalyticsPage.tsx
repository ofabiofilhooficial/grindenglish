import { AppLayout } from '@/components/layout/AppLayout';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { LineChart } from 'lucide-react';

export default function StudentAnalyticsPage() {
  return (
    <AppLayout title="Student Analytics" subtitle="Track learner progress and engagement">
      <div className="p-6">
        <Card>
          <CardHeader>
            <CardTitle className="font-display flex items-center gap-2">
              <LineChart className="h-5 w-5" />
              Analytics
            </CardTitle>
          </CardHeader>
          <CardContent>
            <p className="text-muted-foreground">Per-cohort completion rates, time-on-task, submission counts, and content drop-off analytics. Coming in the next phase.</p>
          </CardContent>
        </Card>
      </div>
    </AppLayout>
  );
}
