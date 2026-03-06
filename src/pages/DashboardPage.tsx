import { useEffect, useState } from 'react';
import { AppLayout } from '@/components/layout/AppLayout';
import { useAuth } from '@/hooks/useAuth';
import { useProgress } from '@/hooks/useProgress';
import { usePageViewTracker } from '@/hooks/useActivityTracker';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { LevelBadge } from '@/components/ui/level-badge';
import { SRSReviewQueue } from '@/components/srs/SRSReviewQueue';
import { 
  Play, 
  Clock, 
  Target, 
  Flame, 
  TrendingUp, 
  BookOpen, 
  Mic, 
  ArrowRight,
  GraduationCap,
  Sparkles
} from 'lucide-react';
import { Link } from 'react-router-dom';
import { supabase } from '@/integrations/supabase/client';

export default function DashboardPage() {
  const { profile, isContentCreator, isAdmin } = useAuth();
  const { progress, loading: progressLoading } = useProgress();
  const firstName = profile?.full_name?.split(' ')[0] || 'there';
  const [courseCount, setCourseCount] = useState(0);

  // Track dashboard view
  usePageViewTracker('dashboard_view');

  useEffect(() => {
    supabase.from('courses').select('id', { count: 'exact', head: true }).then(({ count }) => {
      setCourseCount(count || 0);
    });
  }, []);

  // Format study time
  const formatStudyTime = (minutes: number) => {
    if (minutes < 60) return `${minutes}m`;
    const hours = Math.floor(minutes / 60);
    const mins = minutes % 60;
    return mins > 0 ? `${hours}h ${mins}m` : `${hours}h`;
  };

  return (
    <AppLayout title="Dashboard" subtitle={`Welcome back, ${firstName}!`}>
      <div className="p-6 space-y-6">
        {/* Welcome Card */}
        <Card className="overflow-hidden">
          <div className="bg-gradient-to-r from-primary to-primary/80 p-8 text-primary-foreground">
            <div className="flex items-start gap-4">
              <div className="flex h-14 w-14 items-center justify-center rounded-xl bg-white/20 backdrop-blur-sm">
                <Sparkles className="h-7 w-7" />
              </div>
              <div>
                <h2 className="font-display text-2xl font-bold mb-2">
                  Welcome to English Mastery Lab
                </h2>
                <p className="text-primary-foreground/80 max-w-xl">
                  {courseCount > 0
                    ? 'Your learning journey awaits. Head to your course to continue where you left off.'
                    : isContentCreator
                      ? 'No courses have been created yet. Head to the Course Builder to start creating content.'
                      : 'No courses are available yet. Check back soon — your teachers are preparing content for you.'}
                </p>
                <div className="mt-4">
                  {courseCount > 0 ? (
                    <Link to="/course">
                      <Button variant="secondary" className="gap-2">
                        Go to Course <ArrowRight className="h-4 w-4" />
                      </Button>
                    </Link>
                  ) : isContentCreator ? (
                    <Link to="/author/courses">
                      <Button variant="secondary" className="gap-2">
                        Open Course Builder <ArrowRight className="h-4 w-4" />
                      </Button>
                    </Link>
                  ) : null}
                </div>
              </div>
            </div>
          </div>
        </Card>

        {/* SRS Review Queue */}
        <SRSReviewQueue />

        {/* Quick Stats */}
        <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
          <Card>
            <CardContent className="p-4 flex items-center gap-4">
              <div className="flex h-12 w-12 items-center justify-center rounded-xl bg-primary/10">
                <Flame className="h-6 w-6 text-primary" />
              </div>
              <div>
                <p className="text-2xl font-bold">
                  {progressLoading ? '...' : progress?.currentStreak || 0}
                </p>
                <p className="text-sm text-muted-foreground">Day streak</p>
              </div>
            </CardContent>
          </Card>
          <Card>
            <CardContent className="p-4 flex items-center gap-4">
              <div className="flex h-12 w-12 items-center justify-center rounded-xl bg-accent/10">
                <Clock className="h-6 w-6 text-accent-foreground" />
              </div>
              <div>
                <p className="text-2xl font-bold">
                  {progressLoading ? '...' : formatStudyTime(progress?.totalStudyTimeMinutes || 0)}
                </p>
                <p className="text-sm text-muted-foreground">Total time</p>
              </div>
            </CardContent>
          </Card>
          <Card>
            <CardContent className="p-4 flex items-center gap-4">
              <div className="flex h-12 w-12 items-center justify-center rounded-xl bg-secondary">
                <Target className="h-6 w-6 text-secondary-foreground" />
              </div>
              <div>
                <p className="text-2xl font-bold">
                  {progressLoading ? '...' : progress?.wordsLearned || 0}
                </p>
                <p className="text-sm text-muted-foreground">Words learned</p>
              </div>
            </CardContent>
          </Card>
          <Card>
            <CardContent className="p-4 flex items-center gap-4">
              <div className="flex h-12 w-12 items-center justify-center rounded-xl bg-muted">
                <TrendingUp className="h-6 w-6 text-muted-foreground" />
              </div>
              <div>
                <p className="text-2xl font-bold">—</p>
                <p className="text-sm text-muted-foreground">SRS retention</p>
              </div>
            </CardContent>
          </Card>
        </div>

        {/* Quick Links */}
        <div className="grid sm:grid-cols-2 lg:grid-cols-3 gap-4">
          <Link to="/course">
            <Card className="h-full hover:shadow-md transition-shadow cursor-pointer">
              <CardContent className="p-5 flex items-center gap-4">
                <GraduationCap className="h-8 w-8 text-primary" />
                <div>
                  <p className="font-semibold">My Course</p>
                  <p className="text-sm text-muted-foreground">View levels and units</p>
                </div>
              </CardContent>
            </Card>
          </Link>
          <Link to="/lexicon">
            <Card className="h-full hover:shadow-md transition-shadow cursor-pointer">
              <CardContent className="p-5 flex items-center gap-4">
                <BookOpen className="h-8 w-8 text-primary" />
                <div>
                  <p className="font-semibold">Vocabulary</p>
                  <p className="text-sm text-muted-foreground">Browse the lexicon</p>
                </div>
              </CardContent>
            </Card>
          </Link>
          <Link to="/pronunciation">
            <Card className="h-full hover:shadow-md transition-shadow cursor-pointer">
              <CardContent className="p-5 flex items-center gap-4">
                <Mic className="h-8 w-8 text-primary" />
                <div>
                  <p className="font-semibold">Pronunciation</p>
                  <p className="text-sm text-muted-foreground">Practice your sounds</p>
                </div>
              </CardContent>
            </Card>
          </Link>
        </div>

        {/* Admin/Author Quick Access */}
        {isContentCreator && (
          <Card>
            <CardHeader>
              <CardTitle className="font-display text-base">Author Tools</CardTitle>
            </CardHeader>
            <CardContent className="flex flex-wrap gap-2">
              <Link to="/author/courses"><Button variant="outline" size="sm">Course Builder</Button></Link>
              <Link to="/author/lexicon"><Button variant="outline" size="sm">Lexicon</Button></Link>
              <Link to="/author/grammar"><Button variant="outline" size="sm">Grammar</Button></Link>
              <Link to="/author/pronunciation"><Button variant="outline" size="sm">Pronunciation</Button></Link>
              <Link to="/author/pragmatics"><Button variant="outline" size="sm">Pragmatics</Button></Link>
              <Link to="/author/tags"><Button variant="outline" size="sm">Tags</Button></Link>
              {isAdmin && <Link to="/admin/users"><Button variant="outline" size="sm">User Management</Button></Link>}
            </CardContent>
          </Card>
        )}
      </div>
    </AppLayout>
  );
}
