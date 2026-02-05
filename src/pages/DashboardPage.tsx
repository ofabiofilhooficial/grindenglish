import { AppLayout } from '@/components/layout/AppLayout';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Progress } from '@/components/ui/progress';
import { LevelBadge } from '@/components/ui/level-badge';
import { ProgressRing } from '@/components/ui/progress-ring';
import { SkillIcon } from '@/components/ui/skill-icon';
import { 
  Play, 
  Clock, 
  Target, 
  Flame, 
  TrendingUp, 
  BookOpen, 
  Mic, 
  PenTool, 
  RefreshCw,
  ArrowRight,
  CheckCircle2,
  Circle
} from 'lucide-react';
import { Link } from 'react-router-dom';
import { SEED_UNITS } from '@/data/seedData';

const todaysTasks = [
  { id: 1, title: 'Complete Lesson 3: Storytelling Techniques', type: 'lesson', status: 'in_progress', skill: 'speaking' as const },
  { id: 2, title: 'Review 15 vocabulary cards', type: 'review', status: 'pending', skill: 'vocabulary' as const },
  { id: 3, title: 'Submit writing draft: Email complaint', type: 'submission', status: 'pending', skill: 'writing' as const },
  { id: 4, title: 'Practice shadowing: Dialogue 3', type: 'pronunciation', status: 'done', skill: 'pronunciation' as const },
];

const recentProgress = [
  { unit: 'Storytelling', level: 'B1', progress: 65 },
  { unit: 'Making Decisions', level: 'B1', progress: 100 },
  { unit: 'Past Experiences', level: 'A2', progress: 100 },
];

export default function DashboardPage() {
  const currentUnit = SEED_UNITS.B1[0];

  return (
    <AppLayout title="Dashboard" subtitle="Welcome back, Jane! Let's continue learning.">
      <div className="p-6 space-y-6">
        {/* Stats Row */}
        <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
          <Card className="bg-gradient-to-br from-primary/10 to-primary/5 border-primary/20">
            <CardContent className="p-4 flex items-center gap-4">
              <div className="flex h-12 w-12 items-center justify-center rounded-xl bg-primary/20">
                <Flame className="h-6 w-6 text-primary" />
              </div>
              <div>
                <p className="text-2xl font-bold text-primary">7</p>
                <p className="text-sm text-muted-foreground">Day streak</p>
              </div>
            </CardContent>
          </Card>

          <Card className="bg-gradient-to-br from-accent/10 to-accent/5 border-accent/20">
            <CardContent className="p-4 flex items-center gap-4">
              <div className="flex h-12 w-12 items-center justify-center rounded-xl bg-accent/20">
                <Clock className="h-6 w-6 text-accent" />
              </div>
              <div>
                <p className="text-2xl font-bold text-accent">42h</p>
                <p className="text-sm text-muted-foreground">Total time</p>
              </div>
            </CardContent>
          </Card>

          <Card className="bg-gradient-to-br from-success/10 to-success/5 border-success/20">
            <CardContent className="p-4 flex items-center gap-4">
              <div className="flex h-12 w-12 items-center justify-center rounded-xl bg-success/20">
                <Target className="h-6 w-6 text-success" />
              </div>
              <div>
                <p className="text-2xl font-bold text-success">156</p>
                <p className="text-sm text-muted-foreground">Words learned</p>
              </div>
            </CardContent>
          </Card>

          <Card className="bg-gradient-to-br from-info/10 to-info/5 border-info/20">
            <CardContent className="p-4 flex items-center gap-4">
              <div className="flex h-12 w-12 items-center justify-center rounded-xl bg-info/20">
                <TrendingUp className="h-6 w-6 text-info" />
              </div>
              <div>
                <p className="text-2xl font-bold text-info">85%</p>
                <p className="text-sm text-muted-foreground">SRS retention</p>
              </div>
            </CardContent>
          </Card>
        </div>

        <div className="grid lg:grid-cols-3 gap-6">
          {/* Main Content - Current Unit */}
          <div className="lg:col-span-2 space-y-6">
            {/* Continue Learning Card */}
            <Card className="overflow-hidden">
              <div className="bg-gradient-to-r from-level-b1 to-emerald-600 p-6 text-white">
                <div className="flex items-start justify-between">
                  <div className="flex-1">
                    <div className="flex items-center gap-2 mb-2">
                      <LevelBadge level="B1" size="sm" />
                      <span className="text-sm font-medium text-white/80">Unit 1 of 10</span>
                    </div>
                    <h2 className="font-display text-2xl font-bold mb-2">{currentUnit.title}</h2>
                    <p className="text-white/80 mb-4">{currentUnit.flagshipTask}</p>
                    <div className="flex items-center gap-4 text-sm text-white/70">
                      <span>6 lessons</span>
                      <span>•</span>
                      <span>~2.5 hours</span>
                      <span>•</span>
                      <span>65% complete</span>
                    </div>
                  </div>
                  <ProgressRing progress={65} size={80} strokeWidth={6} variant="accent">
                    <span className="text-lg font-bold text-white">65%</span>
                  </ProgressRing>
                </div>
              </div>
              <CardContent className="p-4">
                <div className="flex items-center justify-between">
                  <div className="flex items-center gap-3">
                    <div className="flex h-10 w-10 items-center justify-center rounded-lg bg-primary/10">
                      <Play className="h-5 w-5 text-primary" />
                    </div>
                    <div>
                      <p className="font-medium">Continue: Lesson 3 - Telling Stories</p>
                      <p className="text-sm text-muted-foreground">Speaking focus • 25 min remaining</p>
                    </div>
                  </div>
                  <Link to="/course/b1/unit-1/lesson-3">
                    <Button className="bg-gradient-primary hover:opacity-90">
                      Continue
                      <ArrowRight className="ml-2 h-4 w-4" />
                    </Button>
                  </Link>
                </div>
              </CardContent>
            </Card>

            {/* Today's Tasks */}
            <Card>
              <CardHeader>
                <CardTitle className="font-display">Today's Tasks</CardTitle>
              </CardHeader>
              <CardContent className="space-y-3">
                {todaysTasks.map((task) => (
                  <div 
                    key={task.id} 
                    className="flex items-center gap-4 p-3 rounded-lg hover:bg-secondary/50 transition-colors"
                  >
                    {task.status === 'done' ? (
                      <CheckCircle2 className="h-5 w-5 text-success flex-shrink-0" />
                    ) : task.status === 'in_progress' ? (
                      <div className="h-5 w-5 rounded-full border-2 border-primary border-t-transparent animate-spin" />
                    ) : (
                      <Circle className="h-5 w-5 text-muted-foreground flex-shrink-0" />
                    )}
                    <SkillIcon skill={task.skill} size={16} />
                    <div className="flex-1 min-w-0">
                      <p className={`font-medium truncate ${task.status === 'done' ? 'text-muted-foreground line-through' : ''}`}>
                        {task.title}
                      </p>
                    </div>
                    {task.status !== 'done' && (
                      <Button variant="ghost" size="sm">
                        Start
                      </Button>
                    )}
                  </div>
                ))}
              </CardContent>
            </Card>

            {/* Skills Progress */}
            <Card>
              <CardHeader>
                <CardTitle className="font-display">Skills This Week</CardTitle>
              </CardHeader>
              <CardContent>
                <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
                  <div className="text-center">
                    <SkillIcon skill="listening" className="mx-auto mb-2" />
                    <p className="text-sm font-medium">Listening</p>
                    <p className="text-xs text-muted-foreground">45 min</p>
                  </div>
                  <div className="text-center">
                    <SkillIcon skill="speaking" className="mx-auto mb-2" />
                    <p className="text-sm font-medium">Speaking</p>
                    <p className="text-xs text-muted-foreground">32 min</p>
                  </div>
                  <div className="text-center">
                    <SkillIcon skill="reading" className="mx-auto mb-2" />
                    <p className="text-sm font-medium">Reading</p>
                    <p className="text-xs text-muted-foreground">28 min</p>
                  </div>
                  <div className="text-center">
                    <SkillIcon skill="writing" className="mx-auto mb-2" />
                    <p className="text-sm font-medium">Writing</p>
                    <p className="text-xs text-muted-foreground">15 min</p>
                  </div>
                </div>
              </CardContent>
            </Card>
          </div>

          {/* Sidebar */}
          <div className="space-y-6">
            {/* Review Due */}
            <Card className="bg-accent/5 border-accent/20">
              <CardContent className="p-4">
                <div className="flex items-center gap-3 mb-4">
                  <div className="flex h-10 w-10 items-center justify-center rounded-lg bg-accent/20">
                    <RefreshCw className="h-5 w-5 text-accent" />
                  </div>
                  <div>
                    <p className="font-semibold">12 reviews due</p>
                    <p className="text-sm text-muted-foreground">Keep your streak!</p>
                  </div>
                </div>
                <Link to="/review">
                  <Button className="w-full" variant="outline">
                    Start Review
                  </Button>
                </Link>
              </CardContent>
            </Card>

            {/* Submissions Pending */}
            <Card>
              <CardHeader className="pb-2">
                <CardTitle className="text-base font-display">Submissions</CardTitle>
              </CardHeader>
              <CardContent className="space-y-3">
                <div className="flex items-center gap-3 p-2 rounded-lg bg-secondary/50">
                  <Mic className="h-5 w-5 text-skill-speaking" />
                  <div className="flex-1">
                    <p className="text-sm font-medium">Story narration</p>
                    <p className="text-xs text-muted-foreground">Draft ready</p>
                  </div>
                </div>
                <div className="flex items-center gap-3 p-2 rounded-lg bg-secondary/50">
                  <PenTool className="h-5 w-5 text-skill-writing" />
                  <div className="flex-1">
                    <p className="text-sm font-medium">Complaint email</p>
                    <p className="text-xs text-muted-foreground">Due in 2 days</p>
                  </div>
                </div>
                <Link to="/portfolio">
                  <Button variant="ghost" size="sm" className="w-full">
                    View Portfolio
                  </Button>
                </Link>
              </CardContent>
            </Card>

            {/* Recent Progress */}
            <Card>
              <CardHeader className="pb-2">
                <CardTitle className="text-base font-display">Recent Progress</CardTitle>
              </CardHeader>
              <CardContent className="space-y-3">
                {recentProgress.map((item, i) => (
                  <div key={i} className="space-y-1.5">
                    <div className="flex items-center justify-between text-sm">
                      <span className="font-medium">{item.unit}</span>
                      <div className="flex items-center gap-2">
                        <LevelBadge level={item.level as any} size="sm" />
                        <span className="text-muted-foreground">{item.progress}%</span>
                      </div>
                    </div>
                    <Progress value={item.progress} className="h-2" />
                  </div>
                ))}
              </CardContent>
            </Card>

            {/* Quick Links */}
            <Card>
              <CardHeader className="pb-2">
                <CardTitle className="text-base font-display">Quick Access</CardTitle>
              </CardHeader>
              <CardContent className="space-y-1">
                <Link to="/lexicon">
                  <Button variant="ghost" className="w-full justify-start" size="sm">
                    <BookOpen className="mr-2 h-4 w-4" />
                    Course Vocabulary
                  </Button>
                </Link>
                <Link to="/grammar">
                  <Button variant="ghost" className="w-full justify-start" size="sm">
                    <BookOpen className="mr-2 h-4 w-4" />
                    Grammar Reference
                  </Button>
                </Link>
                <Link to="/pronunciation">
                  <Button variant="ghost" className="w-full justify-start" size="sm">
                    <Mic className="mr-2 h-4 w-4" />
                    My Sound Map
                  </Button>
                </Link>
              </CardContent>
            </Card>
          </div>
        </div>
      </div>
    </AppLayout>
  );
}
