import { AppLayout } from '@/components/layout/AppLayout';
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from '@/components/ui/card';
import { Progress } from '@/components/ui/progress';
import { ProgressRing } from '@/components/ui/progress-ring';
import { Badge } from '@/components/ui/badge';
import { Separator } from '@/components/ui/separator';
import { BookOpen, Languages, Target, TrendingUp, Award, Zap } from 'lucide-react';
import { useSRSMetrics } from '@/hooks/useSRSMetrics';
import { usePageViewTracker } from '@/hooks/useActivityTracker';

export default function ProgressDashboardPage() {
  const { metrics, loading } = useSRSMetrics();
  
  // Track page view
  usePageViewTracker('progress_view');

  if (loading) {
    return (
      <AppLayout title="Progress" subtitle="Track your language mastery">
        <div className="flex items-center justify-center h-96">
          <div className="h-12 w-12 rounded-full border-4 border-primary border-t-transparent animate-spin" />
        </div>
      </AppLayout>
    );
  }

  return (
    <AppLayout title="Progress" subtitle="Your journey to English mastery">
      <div className="p-6 space-y-8 max-w-7xl mx-auto">
        
        {/* Section 1: The A0 Horizon (Current Level) */}
        <Card className="border-2 border-[#0B1630] bg-gradient-to-br from-[#F3EBDD] to-white">
          <CardHeader className="text-center pb-2">
            <div className="flex items-center justify-center gap-2 mb-2">
              <Target className="h-6 w-6 text-[#0B1630]" />
              <CardTitle className="text-2xl font-display uppercase tracking-wide text-[#0B1630]">
                The A0 Horizon
              </CardTitle>
            </div>
            <CardDescription className="text-base">
              Your current level mastery
            </CardDescription>
          </CardHeader>
          <CardContent className="flex flex-col items-center pt-6 pb-8">
            <ProgressRing 
              progress={metrics?.a0Progress || 0} 
              size={200} 
              strokeWidth={12}
              variant="default"
            >
              <div className="text-center">
                <div className="text-5xl font-display font-bold text-[#0B1630]">
                  {Math.round(metrics?.a0Progress || 0)}%
                </div>
                <div className="text-sm text-muted-foreground mt-1">
                  A0 Complete
                </div>
              </div>
            </ProgressRing>
            
            <div className="mt-6 flex items-center gap-4 text-sm text-muted-foreground">
              <div className="flex items-center gap-2">
                <div className="h-3 w-3 rounded-full bg-primary" />
                <span>{metrics?.a0MasteredItems || 0} mastered</span>
              </div>
              <Separator orientation="vertical" className="h-4" />
              <div className="flex items-center gap-2">
                <div className="h-3 w-3 rounded-full bg-muted" />
                <span>{(metrics?.a0TotalItems || 0) - (metrics?.a0MasteredItems || 0)} remaining</span>
              </div>
            </div>

            {metrics && metrics.a0Progress >= 80 && (
              <div className="mt-6 flex items-center gap-2 px-4 py-2 bg-green-50 border border-green-200 rounded-lg">
                <Award className="h-5 w-5 text-green-600" />
                <span className="text-sm font-medium text-green-700">
                  Almost there! You're crushing A0!
                </span>
              </div>
            )}
          </CardContent>
        </Card>

        {/* Section 2: The Asset Trackers (Granular) */}
        <div className="space-y-4">
          <div className="flex items-center gap-2 mb-4">
            <Zap className="h-5 w-5 text-[#0B1630]" />
            <h2 className="text-xl font-display font-semibold uppercase tracking-wide text-[#0B1630]">
              Asset Trackers
            </h2>
          </div>

          {/* Vocabulary Progress */}
          <Card>
            <CardContent className="pt-6">
              <div className="flex items-center justify-between mb-3">
                <div className="flex items-center gap-3">
                  <div className="h-10 w-10 rounded-lg bg-green-100 flex items-center justify-center">
                    <BookOpen className="h-5 w-5 text-green-600" />
                  </div>
                  <div>
                    <h3 className="font-semibold text-foreground">Vocabulary</h3>
                    <p className="text-sm text-muted-foreground">
                      {metrics?.a0VocabMastered || 0} of {metrics?.a0VocabTotal || 0} words mastered
                    </p>
                  </div>
                </div>
                <Badge variant="outline" className="text-lg font-bold px-3 py-1">
                  {Math.round(metrics?.a0VocabProgress || 0)}%
                </Badge>
              </div>
              <Progress 
                value={metrics?.a0VocabProgress || 0} 
                className="h-3 [&>div]:bg-green-600 bg-green-100"
              />
              <p className="text-xs text-muted-foreground mt-2">
                Words with 3+ successful reviews count as mastered
              </p>
            </CardContent>
          </Card>

          {/* Grammar Progress */}
          <Card>
            <CardContent className="pt-6">
              <div className="flex items-center justify-between mb-3">
                <div className="flex items-center gap-3">
                  <div className="h-10 w-10 rounded-lg bg-blue-100 flex items-center justify-center">
                    <Languages className="h-5 w-5 text-blue-600" />
                  </div>
                  <div>
                    <h3 className="font-semibold text-foreground">Grammar</h3>
                    <p className="text-sm text-muted-foreground">
                      {metrics?.a0GrammarMastered || 0} of {metrics?.a0GrammarTotal || 0} chapters reviewed
                    </p>
                  </div>
                </div>
                <Badge variant="outline" className="text-lg font-bold px-3 py-1">
                  {Math.round(metrics?.a0GrammarProgress || 0)}%
                </Badge>
              </div>
              <Progress 
                value={metrics?.a0GrammarProgress || 0} 
                className="h-3 [&>div]:bg-blue-600 bg-blue-100"
              />
              <p className="text-xs text-muted-foreground mt-2">
                Chapters you've opened and studied
              </p>
            </CardContent>
          </Card>
        </div>

        {/* Section 3: The Master Grind (Overall Platform) */}
        <Card className="border-2 border-muted bg-muted/30">
          <CardHeader>
            <div className="flex items-center gap-2">
              <TrendingUp className="h-5 w-5 text-muted-foreground" />
              <CardTitle className="text-lg font-display uppercase tracking-wide text-muted-foreground">
                The Master Grind
              </CardTitle>
            </div>
            <CardDescription>
              Your overall platform progress (A0 → C2)
            </CardDescription>
          </CardHeader>
          <CardContent>
            <div className="space-y-3">
              <div className="flex items-center justify-between">
                <span className="text-sm font-medium text-muted-foreground">
                  {metrics?.platformMasteredItems || 0} of {metrics?.platformTotalItems || 0} total items
                </span>
                <span className="text-2xl font-bold text-muted-foreground">
                  {Math.round(metrics?.platformProgress || 0)}%
                </span>
              </div>
              <Progress 
                value={metrics?.platformProgress || 0} 
                className="h-2 [&>div]:bg-muted-foreground bg-muted"
              />
              <p className="text-xs text-muted-foreground italic">
                The journey is long. Stay disciplined. Keep grinding.
              </p>
            </div>
          </CardContent>
        </Card>

        {/* Motivational Footer */}
        <div className="text-center py-8">
          <p className="text-sm text-muted-foreground italic">
            "Progress is not about perfection. It's about consistency."
          </p>
          <p className="text-xs text-muted-foreground mt-2">
            Every review, every lesson, every word—it all counts.
          </p>
        </div>
      </div>
    </AppLayout>
  );
}
