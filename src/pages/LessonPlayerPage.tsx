import { useState } from 'react';
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
  const [currentStage, setCurrentStage] = useState(2);
  const [isPlaying, setIsPlaying] = useState(false);
  const [answers, setAnswers] = useState<Record<number, number>>({});
  const [showTranscript, setShowTranscript] = useState(false);
  const [isRecording, setIsRecording] = useState(false);

  const completedStages = lessonStages.filter(s => s.status === 'complete').length;
  const progress = Math.round((completedStages / lessonStages.length) * 100);

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
            <LevelBadge level={(level?.toUpperCase() || 'B1') as any} size="sm" />
            <span className="text-sm font-medium">Listening: A Traveler's Story</span>
          </div>

          <div className="flex items-center gap-2">
            <div className="hidden sm:flex items-center gap-2 text-sm text-muted-foreground">
              <Clock className="h-4 w-4" />
              <span>18 min left</span>
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
            <div className="space-y-1">
              {lessonStages.map((stage, index) => (
                <button
                  key={stage.id}
                  onClick={() => stage.status !== 'locked' && setCurrentStage(index)}
                  disabled={stage.status === 'locked'}
                  className={cn(
                    "w-full flex items-center gap-3 px-3 py-2.5 rounded-lg text-left transition-all",
                    stage.status === 'current' && "bg-primary/10 text-primary",
                    stage.status === 'complete' && "text-muted-foreground hover:bg-secondary",
                    stage.status === 'locked' && "text-muted-foreground/50 cursor-not-allowed"
                  )}
                >
                  <div className={cn(
                    "flex h-6 w-6 items-center justify-center rounded-full text-xs font-medium",
                    stage.status === 'complete' && "bg-success text-white",
                    stage.status === 'current' && "bg-primary text-white",
                    stage.status === 'locked' && "bg-muted text-muted-foreground"
                  )}>
                    {stage.status === 'complete' ? (
                      <CheckCircle2 className="h-4 w-4" />
                    ) : (
                      index + 1
                    )}
                  </div>
                  <div className="flex-1 min-w-0">
                    <p className="text-sm font-medium truncate">{stage.name}</p>
                    <p className="text-xs text-muted-foreground">{stage.duration} min</p>
                  </div>
                </button>
              ))}
            </div>
          </div>
        </aside>

        {/* Main Content */}
        <main className="flex-1 p-6 max-w-4xl mx-auto">
          {/* Stage Header */}
          <div className="mb-6">
            <Badge variant="outline" className="mb-2">Stage 3 of 8</Badge>
            <h1 className="font-display text-2xl font-bold mb-2">Listening: Maya's Adventure</h1>
            <p className="text-muted-foreground">
              Listen to Maya describe her memorable trip and answer the comprehension questions.
            </p>
          </div>

          {/* Learning Goals */}
          <Card className="mb-6 bg-primary/5 border-primary/20">
            <CardContent className="p-4 flex items-start gap-3">
              <Target className="h-5 w-5 text-primary mt-0.5" />
              <div>
                <p className="font-medium text-sm">Learning Goal</p>
                <p className="text-sm text-muted-foreground">
                  Understand main ideas and specific details in a personal narrative about travel.
                </p>
              </div>
            </CardContent>
          </Card>

          {/* Audio Player */}
          <Card className="mb-6">
            <CardContent className="p-6">
              <div className="flex items-center gap-4 mb-4">
                <Button 
                  size="lg" 
                  className={cn(
                    "h-14 w-14 rounded-full",
                    isPlaying ? "bg-primary" : "bg-gradient-primary"
                  )}
                  onClick={() => setIsPlaying(!isPlaying)}
                >
                  {isPlaying ? (
                    <Pause className="h-6 w-6" />
                  ) : (
                    <Play className="h-6 w-6 ml-0.5" />
                  )}
                </Button>
                <div className="flex-1">
                  <Progress value={35} className="h-2 mb-2" />
                  <div className="flex items-center justify-between text-sm text-muted-foreground">
                    <span>1:24</span>
                    <span>3:45</span>
                  </div>
                </div>
                <Button variant="ghost" size="icon">
                  <Volume2 className="h-5 w-5" />
                </Button>
                <Button variant="ghost" size="icon">
                  <RotateCcw className="h-5 w-5" />
                </Button>
              </div>

              <Button 
                variant="outline" 
                size="sm"
                onClick={() => setShowTranscript(!showTranscript)}
              >
                {showTranscript ? 'Hide' : 'Show'} Transcript
              </Button>

              {showTranscript && (
                <div className="mt-4 p-4 bg-secondary/50 rounded-lg text-sm leading-relaxed">
                  <p className="mb-3">
                    <strong>Maya:</strong> "So, last summer I went on this trip to the Scottish Highlands that I'll never forget. 
                    I'd been planning it for months, you know, looking at hiking trails and booking cozy little B&Bs..."
                  </p>
                  <p className="mb-3">
                    "The first few days were absolutely perfect. Clear skies, stunning views of the lochs. 
                    But then, on day three, everything changed. I was hiking up Ben Nevis when the weather 
                    turned completely—I mean, one minute it was sunny, the next I couldn't see five meters ahead..."
                  </p>
                  <p className="text-muted-foreground italic">
                    [Transcript continues...]
                  </p>
                </div>
              )}
            </CardContent>
          </Card>

          {/* Comprehension Questions */}
          <Card className="mb-6">
            <CardHeader>
              <CardTitle className="font-display text-lg">Comprehension Check</CardTitle>
            </CardHeader>
            <CardContent className="space-y-6">
              {comprehensionQuestions.map((q, index) => (
                <div key={q.id} className="space-y-3">
                  <p className="font-medium">{index + 1}. {q.question}</p>
                  <RadioGroup 
                    value={answers[q.id]?.toString()} 
                    onValueChange={(v) => setAnswers({...answers, [q.id]: parseInt(v)})}
                  >
                    {q.options.map((option, optIndex) => (
                      <div key={optIndex} className="flex items-center space-x-3 p-3 rounded-lg hover:bg-secondary/50 transition-colors">
                        <RadioGroupItem value={optIndex.toString()} id={`q${q.id}-opt${optIndex}`} />
                        <Label htmlFor={`q${q.id}-opt${optIndex}`} className="flex-1 cursor-pointer">
                          {option}
                        </Label>
                      </div>
                    ))}
                  </RadioGroup>
                </div>
              ))}
            </CardContent>
          </Card>

          {/* Tip Card */}
          <Card className="mb-6 bg-accent/10 border-accent/30">
            <CardContent className="p-4 flex items-start gap-3">
              <Lightbulb className="h-5 w-5 text-accent mt-0.5" />
              <div>
                <p className="font-medium text-sm">Listening Tip</p>
                <p className="text-sm text-muted-foreground">
                  Don't worry about understanding every word. Focus on the main ideas first, 
                  then listen again for specific details.
                </p>
              </div>
            </CardContent>
          </Card>

          {/* Navigation */}
          <div className="flex items-center justify-between pt-4 border-t border-border">
            <Button variant="outline" disabled={currentStage === 0}>
              <ArrowLeft className="mr-2 h-4 w-4" />
              Previous
            </Button>
            <Button className="bg-gradient-primary hover:opacity-90">
              Check Answers
              <ArrowRight className="ml-2 h-4 w-4" />
            </Button>
          </div>
        </main>
      </div>
    </div>
  );
}
