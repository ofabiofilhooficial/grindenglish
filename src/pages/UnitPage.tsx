import { useState } from 'react';
import { useParams, Link } from 'react-router-dom';
import { AppLayout } from '@/components/layout/AppLayout';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Progress } from '@/components/ui/progress';
import { LevelBadge } from '@/components/ui/level-badge';
import { SkillIcon } from '@/components/ui/skill-icon';
import { Badge } from '@/components/ui/badge';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { Separator } from '@/components/ui/separator';
import { 
  ArrowLeft,
  Play,
  CheckCircle2,
  Circle,
  Lock,
  Target,
  BookOpen,
  Languages,
  Mic,
  Speech,
  Download,
  FileText,
  PenTool
} from 'lucide-react';
import { cn } from '@/lib/utils';
import { SEED_UNITS } from '@/data/seedData';
import { LessonType, SkillType } from '@/types/course';

const sampleLessons = [
  { id: 1, type: 'listening' as LessonType, title: 'Listening: A Traveler\'s Story', duration: 20, status: 'complete' },
  { id: 2, type: 'vocabulary' as LessonType, title: 'Vocabulary: Narrative Language', duration: 15, status: 'complete' },
  { id: 3, type: 'grammar' as LessonType, title: 'Grammar: Past Tenses Review', duration: 25, status: 'in_progress' },
  { id: 4, type: 'speaking' as LessonType, title: 'Speaking: Tell Your Story', duration: 30, status: 'locked' },
  { id: 5, type: 'reading' as LessonType, title: 'Reading: Travel Blog Excerpt', duration: 20, status: 'locked' },
  { id: 6, type: 'writing' as LessonType, title: 'Writing: Narrative Email', duration: 35, status: 'locked' },
];

const lessonTypeToSkill: Record<LessonType, SkillType> = {
  listening: 'listening',
  reading: 'reading',
  grammar: 'grammar',
  vocabulary: 'vocabulary',
  pronunciation: 'pronunciation',
  speaking: 'speaking',
  writing: 'writing',
  fluency: 'fluency',
  mediation: 'mediation',
  integrated: 'listening',
};

export default function UnitPage() {
  const { level, unitId } = useParams();
  const levelUpper = (level?.toUpperCase() || 'B1') as keyof typeof SEED_UNITS;
  const unitIndex = parseInt(unitId?.replace('unit-', '') || '1') - 1;
  const unit = SEED_UNITS[levelUpper]?.[unitIndex] || SEED_UNITS.B1[0];

  const completedLessons = sampleLessons.filter(l => l.status === 'complete').length;
  const totalLessons = sampleLessons.length;
  const progress = Math.round((completedLessons / totalLessons) * 100);

  return (
    <AppLayout>
      <div className="p-6 space-y-6">
        {/* Back Navigation */}
        <Link to="/course" className="inline-flex items-center gap-2 text-muted-foreground hover:text-foreground transition-colors">
          <ArrowLeft className="h-4 w-4" />
          Back to Course
        </Link>

        {/* Unit Header */}
        <div className="bg-gradient-to-r from-level-b1 to-emerald-600 rounded-2xl p-6 text-white">
          <div className="flex items-start justify-between">
            <div className="flex-1">
              <div className="flex items-center gap-2 mb-2">
                <LevelBadge level={levelUpper as any} size="sm" />
                <span className="text-sm font-medium text-white/80">Unit {unitIndex + 1}</span>
              </div>
              <h1 className="font-display text-3xl font-bold mb-2">{unit.title}</h1>
              <p className="text-white/80 mb-4 max-w-2xl">{unit.flagshipTask}</p>
              <div className="flex flex-wrap items-center gap-4 text-sm text-white/70">
                <span>{totalLessons} lessons</span>
                <span>•</span>
                <span>~2.5 hours</span>
                <span>•</span>
                <span>{progress}% complete</span>
              </div>
            </div>
            <div className="hidden md:flex flex-col items-end gap-3">
              <Badge className="bg-white/20 text-white border-0">
                Theme: {unit.theme}
              </Badge>
              <Progress value={progress} className="w-48 h-2 bg-white/20" />
            </div>
          </div>
        </div>

        <div className="grid lg:grid-cols-3 gap-6">
          {/* Main Content */}
          <div className="lg:col-span-2 space-y-6">
            {/* Lessons List */}
            <Card>
              <CardHeader>
                <CardTitle className="font-display">Lessons</CardTitle>
              </CardHeader>
              <CardContent className="space-y-2">
                {sampleLessons.map((lesson, index) => {
                  const isLocked = lesson.status === 'locked';
                  const isComplete = lesson.status === 'complete';
                  const isInProgress = lesson.status === 'in_progress';

                  return (
                    <Link 
                      key={lesson.id}
                      to={!isLocked ? `/course/${level}/unit-${unitIndex + 1}/lesson-${lesson.id}` : '#'}
                      className={cn(isLocked && "pointer-events-none")}
                    >
                      <div className={cn(
                        "flex items-center gap-4 p-4 rounded-xl transition-all duration-200",
                        "hover:bg-secondary/50",
                        isComplete && "bg-success/5",
                        isInProgress && "bg-primary/5 ring-1 ring-primary/20",
                        isLocked && "opacity-50"
                      )}>
                        <div className="flex h-10 w-10 items-center justify-center rounded-lg bg-secondary">
                          {isComplete ? (
                            <CheckCircle2 className="h-5 w-5 text-success" />
                          ) : isLocked ? (
                            <Lock className="h-5 w-5 text-muted-foreground" />
                          ) : isInProgress ? (
                            <Play className="h-5 w-5 text-primary" />
                          ) : (
                            <Circle className="h-5 w-5 text-muted-foreground" />
                          )}
                        </div>
                        
                        <SkillIcon skill={lessonTypeToSkill[lesson.type]} size={18} />
                        
                        <div className="flex-1 min-w-0">
                          <p className="font-medium">{lesson.title}</p>
                          <p className="text-sm text-muted-foreground">{lesson.duration} min</p>
                        </div>

                        {!isLocked && (
                          <Button 
                            variant={isInProgress ? "default" : "ghost"} 
                            size="sm"
                            className={isInProgress ? "bg-gradient-primary hover:opacity-90" : ""}
                          >
                            {isComplete ? 'Review' : isInProgress ? 'Continue' : 'Start'}
                          </Button>
                        )}
                      </div>
                    </Link>
                  );
                })}
              </CardContent>
            </Card>
          </div>

          {/* Sidebar - Unit Details */}
          <div className="space-y-6">
            {/* Targets */}
            <Card>
              <CardHeader className="pb-3">
                <CardTitle className="text-base font-display flex items-center gap-2">
                  <Target className="h-4 w-4" />
                  Learning Targets
                </CardTitle>
              </CardHeader>
              <CardContent className="space-y-4">
                <div>
                  <div className="flex items-center gap-2 text-sm font-medium mb-2">
                    <BookOpen className="h-4 w-4 text-skill-vocabulary" />
                    Vocabulary
                  </div>
                  <div className="flex flex-wrap gap-1.5">
                    {['narrative', 'sequence', 'describe', 'memorable'].map((word) => (
                      <Badge key={word} variant="secondary" className="text-xs">{word}</Badge>
                    ))}
                  </div>
                </div>

                <Separator />

                <div>
                  <div className="flex items-center gap-2 text-sm font-medium mb-2">
                    <Languages className="h-4 w-4 text-skill-grammar" />
                    Grammar
                  </div>
                  <p className="text-sm text-muted-foreground">
                    Past simple vs. past continuous • Time expressions
                  </p>
                </div>

                <Separator />

                <div>
                  <div className="flex items-center gap-2 text-sm font-medium mb-2">
                    <Mic className="h-4 w-4 text-skill-pronunciation" />
                    Pronunciation
                  </div>
                  <p className="text-sm text-muted-foreground">
                    -ed endings • Sentence stress in narratives
                  </p>
                </div>

                <Separator />

                <div>
                  <div className="flex items-center gap-2 text-sm font-medium mb-2">
                    <Speech className="h-4 w-4 text-skill-pragmatics" />
                    Pragmatics
                  </div>
                  <p className="text-sm text-muted-foreground">
                    Engaging listeners • Showing interest
                  </p>
                </div>
              </CardContent>
            </Card>

            {/* Deliverables */}
            <Card>
              <CardHeader className="pb-3">
                <CardTitle className="text-base font-display flex items-center gap-2">
                  <FileText className="h-4 w-4" />
                  Deliverables
                </CardTitle>
              </CardHeader>
              <CardContent className="space-y-3">
                <div className="flex items-start gap-3 p-3 rounded-lg bg-secondary/50">
                  <Mic className="h-5 w-5 text-skill-speaking mt-0.5" />
                  <div>
                    <p className="font-medium text-sm">Speaking Artifact</p>
                    <p className="text-xs text-muted-foreground">
                      Record a 2-minute personal story
                    </p>
                  </div>
                </div>
                <div className="flex items-start gap-3 p-3 rounded-lg bg-secondary/50">
                  <PenTool className="h-5 w-5 text-skill-writing mt-0.5" />
                  <div>
                    <p className="font-medium text-sm">Writing Artifact</p>
                    <p className="text-xs text-muted-foreground">
                      Email sharing a travel experience
                    </p>
                  </div>
                </div>
              </CardContent>
            </Card>

            {/* Resources */}
            <Card>
              <CardHeader className="pb-3">
                <CardTitle className="text-base font-display flex items-center gap-2">
                  <Download className="h-4 w-4" />
                  Resources
                </CardTitle>
              </CardHeader>
              <CardContent className="space-y-2">
                <Button variant="ghost" className="w-full justify-start text-sm h-9">
                  <FileText className="mr-2 h-4 w-4" />
                  Unit vocabulary list (PDF)
                </Button>
                <Button variant="ghost" className="w-full justify-start text-sm h-9">
                  <FileText className="mr-2 h-4 w-4" />
                  Grammar reference (PDF)
                </Button>
                <Button variant="ghost" className="w-full justify-start text-sm h-9">
                  <FileText className="mr-2 h-4 w-4" />
                  Model texts
                </Button>
              </CardContent>
            </Card>
          </div>
        </div>
      </div>
    </AppLayout>
  );
}
