import { AppLayout } from '@/components/layout/AppLayout';
import { Card, CardContent } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Progress } from '@/components/ui/progress';
import { LevelBadge } from '@/components/ui/level-badge';
import { Badge } from '@/components/ui/badge';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { 
  Lock,
  CheckCircle2,
  ArrowRight,
  ChevronDown,
  Briefcase,
  GraduationCap
} from 'lucide-react';
import { Link } from 'react-router-dom';
import { CEFRLevel } from '@/types/course';
import { CEFR_LEVEL_CONFIG, SEED_UNITS } from '@/data/seedData';
import { cn } from '@/lib/utils';

const userProgress = {
  currentLevel: 'B1' as CEFRLevel,
  currentUnit: 1,
  completedLevels: ['A0', 'A1', 'A2'] as CEFRLevel[],
  completedUnits: {
    A0: [1, 2, 3, 4, 5, 6],
    A1: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
    A2: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
    B1: [],
  },
};

const levels: CEFRLevel[] = ['A0', 'A1', 'A2', 'B1', 'B2', 'C1', 'C2'];

export default function CoursePage() {
  const isLevelAccessible = (level: CEFRLevel): boolean => {
    const levelIndex = levels.indexOf(level);
    const currentIndex = levels.indexOf(userProgress.currentLevel);
    return levelIndex <= currentIndex;
  };

  const getLevelProgress = (level: CEFRLevel): number => {
    if (userProgress.completedLevels.includes(level)) return 100;
    if (level === userProgress.currentLevel) {
      const completed = userProgress.completedUnits[level as keyof typeof userProgress.completedUnits]?.length || 0;
      const total = CEFR_LEVEL_CONFIG[level].unitCount;
      return Math.round((completed / total) * 100);
    }
    return 0;
  };

  return (
    <AppLayout title="My Course" subtitle="Your path to English mastery">
      <div className="p-6 space-y-6">
        {/* Track Selection */}
        <Tabs defaultValue="core" className="w-full">
          <div className="flex items-center justify-between mb-4">
            <TabsList className="bg-secondary">
              <TabsTrigger value="core">Core Track</TabsTrigger>
              <TabsTrigger value="professional" className="flex items-center gap-1.5">
                <Briefcase className="h-3.5 w-3.5" />
                Professional
              </TabsTrigger>
              <TabsTrigger value="academic" className="flex items-center gap-1.5">
                <GraduationCap className="h-3.5 w-3.5" />
                Academic
              </TabsTrigger>
            </TabsList>
          </div>

          <TabsContent value="core" className="space-y-6">
            {/* Level Cards */}
            {levels.map((level) => {
              const config = CEFR_LEVEL_CONFIG[level];
              const accessible = isLevelAccessible(level);
              const progress = getLevelProgress(level);
              const isComplete = progress === 100;
              const isCurrent = level === userProgress.currentLevel;
              const units = SEED_UNITS[level];

              return (
                <Card 
                  key={level}
                  className={cn(
                    "overflow-hidden transition-all duration-300",
                    !accessible && "opacity-60",
                    isCurrent && "ring-2 ring-primary shadow-lg"
                  )}
                >
                  {/* Level Header */}
                  <div className={`p-5 bg-gradient-to-r ${config.gradient} text-white`}>
                    <div className="flex items-center justify-between">
                      <div className="flex items-center gap-4">
                        <div className="flex h-14 w-14 items-center justify-center rounded-xl bg-white/20 backdrop-blur-sm">
                          {isComplete ? (
                            <CheckCircle2 className="h-7 w-7" />
                          ) : !accessible ? (
                            <Lock className="h-7 w-7" />
                          ) : (
                            <span className="font-display text-xl font-bold">{level}</span>
                          )}
                        </div>
                        <div>
                          <h2 className="font-display text-xl font-bold">{config.name}</h2>
                          <p className="text-white/80 text-sm">{config.description}</p>
                        </div>
                      </div>
                      <div className="hidden md:flex items-center gap-4 text-white/80 text-sm">
                        <span>{config.unitCount} units</span>
                        <span>•</span>
                        <span>~{config.hoursEstimate} hours</span>
                        {isCurrent && (
                          <Badge className="bg-white/20 text-white border-0">
                            Current Level
                          </Badge>
                        )}
                      </div>
                    </div>
                    {accessible && (
                      <div className="mt-4">
                        <div className="flex items-center justify-between text-sm mb-1.5">
                          <span>{progress}% complete</span>
                          <span>{Math.round((progress / 100) * config.unitCount)} / {config.unitCount} units</span>
                        </div>
                        <Progress value={progress} className="h-2 bg-white/20" />
                      </div>
                    )}
                  </div>

                  {/* Units Grid */}
                  {accessible && (
                    <CardContent className="p-5">
                      <div className="grid sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-5 gap-3">
                        {units.map((unit, index) => {
                          const unitNum = index + 1;
                          const completedUnits = userProgress.completedUnits[level as keyof typeof userProgress.completedUnits] || [];
                          const isUnitComplete = completedUnits.includes(unitNum);
                          const isCurrentUnit = isCurrent && unitNum === userProgress.currentUnit;
                          const isUnitAccessible = isUnitComplete || (isCurrent && unitNum <= userProgress.currentUnit);

                          return (
                            <Link 
                              key={unitNum}
                              to={isUnitAccessible ? `/course/${level.toLowerCase()}/unit-${unitNum}` : '#'}
                              className={cn(!isUnitAccessible && "pointer-events-none")}
                            >
                              <Card className={cn(
                                "h-full transition-all duration-200 hover:shadow-md",
                                isCurrentUnit && "ring-2 ring-primary bg-primary/5",
                                isUnitComplete && "bg-success/5 border-success/30",
                                !isUnitAccessible && "opacity-50"
                              )}>
                                <CardContent className="p-3">
                                  <div className="flex items-start justify-between mb-2">
                                    <span className="text-xs font-medium text-muted-foreground">
                                      Unit {unitNum}
                                    </span>
                                    {isUnitComplete ? (
                                      <CheckCircle2 className="h-4 w-4 text-success" />
                                    ) : !isUnitAccessible ? (
                                      <Lock className="h-4 w-4 text-muted-foreground" />
                                    ) : isCurrentUnit ? (
                                      <div className="h-4 w-4 rounded-full bg-primary animate-pulse" />
                                    ) : null}
                                  </div>
                                  <h3 className="font-medium text-sm line-clamp-1">{unit.title}</h3>
                                  <p className="text-xs text-muted-foreground line-clamp-2 mt-1">
                                    {unit.theme}
                                  </p>
                                </CardContent>
                              </Card>
                            </Link>
                          );
                        })}
                      </div>

                      {isCurrent && (
                        <div className="mt-4 flex justify-end">
                          <Link to={`/course/${level.toLowerCase()}/unit-${userProgress.currentUnit}`}>
                            <Button className="bg-gradient-primary hover:opacity-90">
                              Continue Learning
                              <ArrowRight className="ml-2 h-4 w-4" />
                            </Button>
                          </Link>
                        </div>
                      )}
                    </CardContent>
                  )}

                  {!accessible && (
                    <CardContent className="p-5">
                      <div className="flex items-center gap-3 text-muted-foreground">
                        <Lock className="h-5 w-5" />
                        <p>Complete {levels[levels.indexOf(level) - 1]} to unlock this level</p>
                      </div>
                    </CardContent>
                  )}
                </Card>
              );
            })}
          </TabsContent>

          <TabsContent value="professional">
            <Card className="p-8 text-center">
              <Briefcase className="h-12 w-12 text-muted-foreground mx-auto mb-4" />
              <h3 className="font-display text-xl font-bold mb-2">Professional Track</h3>
              <p className="text-muted-foreground max-w-md mx-auto mb-4">
                Business English overlay available from B1+. Covers meetings, negotiations, presentations, and workplace communication.
              </p>
              <Badge variant="secondary">Coming at B1</Badge>
            </Card>
          </TabsContent>

          <TabsContent value="academic">
            <Card className="p-8 text-center">
              <GraduationCap className="h-12 w-12 text-muted-foreground mx-auto mb-4" />
              <h3 className="font-display text-xl font-bold mb-2">Academic Track</h3>
              <p className="text-muted-foreground max-w-md mx-auto mb-4">
                Academic English overlay available from B1+. Covers essays, research, seminars, and university-level discourse.
              </p>
              <Badge variant="secondary">Coming at B1</Badge>
            </Card>
          </TabsContent>
        </Tabs>
      </div>
    </AppLayout>
  );
}
