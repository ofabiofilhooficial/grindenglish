import { AppLayout } from '@/components/layout/AppLayout';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { ClipboardList } from 'lucide-react';

export default function FeedbackQueuePage() {
  return (
    <AppLayout title="Feedback Queue" subtitle="Review student submissions">
      <div className="p-6">
        <Card>
          <CardHeader>
            <CardTitle className="font-display flex items-center gap-2">
              <ClipboardList className="h-5 w-5" />
              Pending Submissions
            </CardTitle>
          </CardHeader>
          <CardContent>
            <p className="text-muted-foreground">Review speaking recordings and writing drafts submitted by students. Feedback workspace is coming in the next phase.</p>
          </CardContent>
        </Card>
      </div>
    </AppLayout>
  );
}
