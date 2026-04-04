import { Link } from 'react-router-dom';
import { AppLayout } from '@/components/layout/AppLayout';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';

export default function OnboardingIntroPage() {
  return (
    <AppLayout title="Welcome to your onboarding" subtitle="Let’s place you at the right level and set your learning goals.">
      <div className="p-6 space-y-6">
        <Card>
          <CardHeader>
            <CardTitle className="font-display text-xl">Why placement matters</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4 text-sm text-muted-foreground">
            <p>Placement ensures you start with content that is neither too easy nor too hard.</p>
            <p>We use your answers to recommend the best CEFR level and learning path.</p>
            <p>The process takes only a few minutes and guides your first course experience.</p>
          </CardContent>
        </Card>

        <Card className="border-dashed border-primary/40">
          <CardContent className="space-y-4">
            <div>
              <h2 className="text-lg font-semibold">What happens next</h2>
              <p className="text-sm text-muted-foreground">We will ask a few questions about your English experience and learning goals.</p>
            </div>
            <ul className="space-y-3 text-sm text-muted-foreground">
              <li>• Your current comfort with reading, speaking, and listening</li>
              <li>• Your learning priorities</li>
              <li>• A quick sample question to check your level</li>
            </ul>
          </CardContent>
        </Card>

        <div className="flex flex-col gap-3 sm:flex-row">
          <Link to="/onboarding/placement">
            <Button className="bg-gradient-primary hover:opacity-90">Start placement</Button>
          </Link>
          <Link to="/dashboard">
            <Button variant="outline">Skip for now</Button>
          </Link>
        </div>
      </div>
    </AppLayout>
  );
}
