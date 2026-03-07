import { useState, useEffect } from 'react';
import { useParams, Link } from 'react-router-dom';
import { AppLayout } from '@/components/layout/AppLayout';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Progress } from '@/components/ui/progress';
import { LevelBadge } from '@/components/ui/level-badge';
import { Badge } from '@/components/ui/badge';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { Separator } from '@/components/ui/separator';
import { RadioGroup, RadioGroupItem } from '@/components/ui/radio-group';
import { Label } from '@/components/ui/label';
import { Textarea } from '@/components/ui/textarea';
import { LinkedAssetViewer } from '@/components/lesson/LinkedAssetViewer';
import { StageAssetViewer } from '@/components/lesson/StageAssetViewer';
import { supabase } from '@/integrations/supabase/client';
import { 
  ArrowLeft,
  ArrowRight,
  Play,
  Pause,
  Volume2,
  CheckCircle2,
  Circle,
  Lightbulb,
  ChevronRight,
  Clock,
  Target,
  RotateCcw,
  Mic,
  Square
} from 'lucide-react';
import { cn } from '@/lib/utils';

type StageStatus = 'locked' | 'current' | 'complete';

const lessonStages = [
  { id: 1, name: 'Warm-up', duration: 3, status: 'complete' as StageStatus },
  { id: 2, name: 'Lead-in', duration: 5, status: 'complete' as StageStatus },
  { id: 3, name: 'Listening', duration: 10, status: 'current' as StageStatus },
  { id: 4, name: 'Comprehension', duration: 8, status: 'locked' as StageStatus },
  { id: 5, name: 'Language Focus', duration: 10, status: 'locked' as StageStatus },
  { id: 6, name: 'Practice', duration: 12, status: 'locked' as StageStatus },
  { id: 7, name: 'Speaking Task', duration: 15, status: 'locked' as StageStatus },
  { id: 8, name: 'Reflection', duration: 5, status: 'locked' as StageStatus },
];

const comprehensionQuestions = [
  {
    id: 1,
    question: "Where did Maya go on her memorable trip?",
    options: [
      "To the Swiss Alps",
      "To the Scottish Highlands", 
      "To the Norwegian fjords",
      "To the Austrian mountains"
    ],
    correct: 1
  },
  {
    id: 2,
    question: "What unexpected thing happened during her trip?",
    options: [
      "She lost her passport",
      "The weather changed suddenly",
      "She met a famous person",
      "Her car broke down"
    ],
    correct: 1
  },
];

export default function LessonPlayerPage() {
  const { level, unitId, lessonId } = useParams();
  const [lesson, setLesson] = useState<any>(null);
  const [stages, setStages] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [currentStage, setCurrentStage] = useState(0);
  const [isPlaying, setIsPlaying] = useState(false);
  const [answers, setAnswers] = useState<Record<number, number>>({});
  const [showTranscript, setShowTranscript] = useState(false);
  const [isRecording, setIsRecording] = useState(false);

  useEffect(() => {
    const fetchLesson = async () => {
      if (!lessonId) return;
      
      setLoading(true);
      
      try {
        // Fetch lesson data
        const { data: lessonData, error: lessonError } = await supabase
          .from('lessons')
          .select('*')
          .eq('id', lessonId)
          .single();
        
        console.log('Lesson query result:', { lessonData, lessonError });

        if (lessonError) {
          console.error('Error fetching lesson:', lessonError);
        }

        if (lessonData) {
          // Fetch unit data separately
          const { data: unitData } = await supabase
            .from('units')
            .select('title, level_id, levels!inner(cefr_level)')
            .eq('id', lessonData.unit_id)
            .single();
          
          console.log('Unit data:', unitData);

          // Combine the data
          setLesson({
            ...lessonData,
            units: unitData
          });

          // Fetch stages
          const { data: stagesData, error: stagesError } = await supabase
            .from('lesson_stages')
            .select('*')
            .eq('lesson_id', lessonId)
            .order('sort_order');

          console.log('Stages query result:', { stagesData, stagesError });

          if (stagesData) {
            setStages(stagesData);
          }
        }
      } catch (error) {
        console.error('Error in fetchLesson:', error);
      }
      
      setLoading(false);
    };

    fetchLesson();
  }, [lessonId]);

  if (loading) {
    return (
      <div className="min-h-screen bg-background flex items-center justify-center">
        <div className="h-8 w-8 rounded-full border-2 border-primary border-t-transparent animate-spin" />
      </div>
    );
  }

  if (!lesson) {
    return (
      <AppLayout>
        <div className="p-6 space-y-6">
          <Link to={`/course/${level}/${unitId}`} className="inline-flex items-center gap-2 text-muted-foreground hover:text-foreground transition-colors">
            <ArrowLeft className="h-4 w-4" />
            Back to Unit
          </Link>
          <Card className="p-12 text-center">
            <h3 className="font-display text-xl font-bold mb-2">Lesson Not Found</h3>
            <p className="text-muted-foreground mb-4">
              This lesson doesn't exist or there was an error loading it.
            </p>
            <p className="text-xs text-muted-foreground font-mono">
              Lesson ID: {lessonId}
            </p>
            <p className="text-xs text-muted-foreground mt-2">
              Check the browser console for more details.
            </p>
          </Card>
        </div>
      </AppLayout>
    );
  }

  const completedStages = stages.filter((s, i) => i < currentStage).length;
  const progress = stages.length > 0 ? Math.round((completedStages / stages.length) * 100) : 0;

  return (
    <div className="min-h-screen bg-background">
      {/* Top Navigation */}
      <header className="sticky top-0 z-50 border-b border-border bg-background/95 backdrop-blur">
        <div className="flex items-center justify-between px-4 h-14">
          <Link 
            to={`/course/${level}/${unitId}`}
            className="flex items-center gap-2 text-muted-foreground hover:text-foreground transition-colors"
          >
            <ArrowLeft className="h-4 w-4" />
            <span className="hidden sm:inline">Back to Unit</span>
          </Link>

          <div className="flex items-center gap-3">
            {lesson.units?.levels?.cefr_level && (
              <LevelBadge level={lesson.units.levels.cefr_level as any} size="sm" />
            )}
            <span className="text-sm font-medium">{lesson.title}</span>
          </div>

          <div className="flex items-center gap-2">
            <div className="hidden sm:flex items-center gap-2 text-sm text-muted-foreground">
              <Clock className="h-4 w-4" />
              <span>{stages.length} stages</span>
            </div>
            <Progress value={progress} className="w-24 h-2" />
          </div>
        </div>
      </header>

      <div className="flex">
        {/* Sidebar - Stage Navigation */}
        <aside className="hidden lg:block w-72 border-r border-border bg-secondary/30 min-h-[calc(100vh-3.5rem)]">
          <div className="p-4">
            <h3 className="font-display font-semibold mb-4">Lesson Stages</h3>
            {stages.length === 0 ? (
              <p className="text-sm text-muted-foreground text-center py-8">No stages defined yet</p>
            ) : (
              <div className="space-y-1">
                {stages.map((stage, index) => {
                  const status = index < currentStage ? 'complete' : index === currentStage ? 'current' : 'locked';
                  return (
                    <button
                      key={stage.id}
                      onClick={() => status !== 'locked' && setCurrentStage(index)}
                      disabled={status === 'locked'}
                      className={cn(
                        "w-full flex items-center gap-3 px-3 py-2.5 rounded-lg text-left transition-all",
                        status === 'current' && "bg-primary/10 text-primary",
                        status === 'complete' && "text-muted-foreground hover:bg-secondary",
                        status === 'locked' && "text-muted-foreground/50 cursor-not-allowed"
                      )}
                    >
                      <div className={cn(
                        "flex h-6 w-6 items-center justify-center rounded-full text-xs font-medium",
                        status === 'complete' && "bg-success text-white",
                        status === 'current' && "bg-primary text-white",
                        status === 'locked' && "bg-muted text-muted-foreground"
                      )}>
                        {status === 'complete' ? (
                          <CheckCircle2 className="h-4 w-4" />
                        ) : (
                          index + 1
                        )}
                      </div>
                      <div className="flex-1 min-w-0">
                        <p className="text-sm font-medium truncate">{stage.title}</p>
                        {stage.timing_minutes && (
                          <p className="text-xs text-muted-foreground">{stage.timing_minutes} min</p>
                        )}
                      </div>
                    </button>
                  );
                })}
              </div>
            )}
          </div>
        </aside>

        {/* Main Content */}
        <main className="flex-1 p-6 max-w-4xl mx-auto">
          {/* Stage Header */}
          {stages.length > 0 && stages[currentStage] && (
            <>
              <div className="mb-6">
                <Badge variant="outline" className="mb-2">Stage {currentStage + 1} of {stages.length}</Badge>
                <h1 className="font-display text-2xl font-bold mb-2">{stages[currentStage].title}</h1>
                {stages[currentStage].instructions && (
                  <p className="text-muted-foreground">
                    {stages[currentStage].instructions}
                  </p>
                )}
              </div>

              {/* Learning Goals */}
              {lesson.goal && (
                <Card className="mb-6 bg-primary/5 border-primary/20">
                  <CardContent className="p-4 flex items-start gap-3">
                    <Target className="h-5 w-5 text-primary mt-0.5" />
                    <div>
                      <p className="font-medium text-sm">Learning Goal</p>
                      <p className="text-sm text-muted-foreground">
                        {lesson.goal}
                      </p>
                    </div>
                  </CardContent>
                </Card>
              )}

              {/* Stage Content */}
              <Card className="mb-6">
                <CardContent className="p-6">
                  {stages[currentStage].instructions ? (
                    <div className="prose prose-sm max-w-none">
                      <div className="whitespace-pre-wrap text-foreground">
                        {stages[currentStage].instructions}
                      </div>
                    </div>
                  ) : (
                    <p className="text-muted-foreground text-center py-8">
                      No content defined for this stage yet.
                    </p>
                  )}
                </CardContent>
              </Card>

              {/* Stage-Specific Assets */}
              {stages[currentStage].id && (
                <div className="mb-6">
                  <StageAssetViewer 
                    lessonId={lessonId!} 
                    stageId={stages[currentStage].id}
                  />
                </div>
              )}
            </>
          )}

          {stages.length === 0 && (
            <Card className="mb-6">
              <CardContent className="p-12 text-center">
                <p className="text-muted-foreground">This lesson doesn't have any stages defined yet.</p>
              </CardContent>
            </Card>
          )}

          {/* Lesson-Level Assets (shown at bottom for reference) */}
          {lessonId && (
            <div className="mb-6">
              <LinkedAssetViewer lessonId={lessonId} />
            </div>
          )}

          {/* Navigation */}
          <div className="flex items-center justify-between pt-4 border-t border-border">
            <Button 
              variant="outline" 
              disabled={currentStage === 0}
              onClick={() => setCurrentStage(Math.max(0, currentStage - 1))}
            >
              <ArrowLeft className="mr-2 h-4 w-4" />
              Previous
            </Button>
            <Button 
              className="bg-gradient-primary hover:opacity-90"
              disabled={currentStage >= stages.length - 1}
              onClick={() => setCurrentStage(Math.min(stages.length - 1, currentStage + 1))}
            >
              {currentStage >= stages.length - 1 ? 'Complete Lesson' : 'Next Stage'}
              <ArrowRight className="ml-2 h-4 w-4" />
            </Button>
          </div>
        </main>
      </div>
    </div>
  );
}
