import { useEffect, useState } from 'react';
import { AppLayout } from '@/components/layout/AppLayout';
import { Card, CardContent } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { 
  Lock,
  ArrowRight,
  Briefcase,
  GraduationCap,
  BookOpen,
  ChevronRight
} from 'lucide-react';
import { Link } from 'react-router-dom';
import { CEFRLevel } from '@/types/course';
import { CEFR_LEVEL_CONFIG } from '@/data/seedData';
import { supabase } from '@/integrations/supabase/client';
import { useAuth } from '@/hooks/useAuth';

const levels: CEFRLevel[] = ['A0', 'A1', 'A2', 'B1', 'B2', 'C1', 'C2'];

interface LevelWithUnits {
  id: string;
  cefr_code: string;
  title: string;
  is_published: boolean;
  unit_count: number;
}

export default function CoursePage() {
  const { isContentCreator } = useAuth();
  const [courseExists, setCourseExists] = useState<boolean | null>(null);
  const [publishedLevels, setPublishedLevels] = useState<LevelWithUnits[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchData = async () => {
      // Check if any courses exist
      const { count } = await supabase.from('courses').select('id', { count: 'exact', head: true });
      setCourseExists((count || 0) > 0);

      // Fetch published levels with their unit counts
      const { data: levelsData } = await supabase
        .from('levels')
        .select('id, cefr_code, title, is_published')
        .eq('is_published', true)
        .order('sort_order');

      if (levelsData) {
        // Get unit counts for each level
        const { data: unitsData } = await supabase
          .from('units')
          .select('id, level_id, is_published')
          .eq('is_published', true);

        const levelsWithCounts: LevelWithUnits[] = levelsData.map((level) => ({
          ...level,
          unit_count: (unitsData || []).filter((u) => u.level_id === level.id).length,
        }));

        setPublishedLevels(levelsWithCounts);
      }
      setLoading(false);
    };

    fetchData();
  }, []);

  return (
    <AppLayout title="My Course" subtitle="Your path to English mastery">
      <div className="p-6 space-y-6">
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
            {loading ? (
              <div className="flex justify-center py-12">
                <div className="h-8 w-8 rounded-full border-2 border-primary border-t-transparent animate-spin" />
              </div>
            ) : courseExists === false ? (
              <Card className="p-12 text-center">
                <BookOpen className="h-16 w-16 text-muted-foreground mx-auto mb-4 opacity-40" />
                <h3 className="font-display text-xl font-bold mb-2">No Course Available Yet</h3>
                <p className="text-muted-foreground max-w-md mx-auto mb-6">
                  {isContentCreator
                    ? 'Head to the Course Builder to create your first course and start adding levels, units, and lessons.'
                    : 'Your teachers are still preparing course content. Check back soon!'}
                </p>
                {isContentCreator && (
                  <Link to="/author/courses">
                    <Button className="bg-gradient-primary hover:opacity-90 gap-2">
                      Open Course Builder <ArrowRight className="h-4 w-4" />
                    </Button>
                  </Link>
                )}
              </Card>
            ) : publishedLevels.length === 0 ? (
              <Card className="p-12 text-center">
                <Lock className="h-16 w-16 text-muted-foreground mx-auto mb-4 opacity-40" />
                <h3 className="font-display text-xl font-bold mb-2">No Published Content Yet</h3>
                <p className="text-muted-foreground max-w-md mx-auto mb-6">
                  {isContentCreator
                    ? 'You have courses created, but no levels have been published yet. Go to the Course Builder to publish content.'
                    : 'Your teachers are still preparing course content. Check back soon!'}
                </p>
                {isContentCreator && (
                  <Link to="/author/courses">
                    <Button className="bg-gradient-primary hover:opacity-90 gap-2">
                      Open Course Builder <ArrowRight className="h-4 w-4" />
                    </Button>
                  </Link>
                )}
              </Card>
            ) : (
              levels.map((level) => {
                const config = CEFR_LEVEL_CONFIG[level];
                const publishedLevel = publishedLevels.find((l) => l.cefr_code === level);
                
                if (!publishedLevel) {
                  // Show locked card for unpublished levels
                  return (
                    <Card key={level} className="overflow-hidden opacity-60">
                      <div className={`p-5 bg-gradient-to-r ${config.gradient} text-white`}>
                        <div className="flex items-center gap-4">
                          <div className="flex h-14 w-14 items-center justify-center rounded-xl bg-white/20 backdrop-blur-sm">
                            <Lock className="h-7 w-7" />
                          </div>
                          <div>
                            <h2 className="font-display text-xl font-bold">{config.name}</h2>
                            <p className="text-white/80 text-sm">{config.description}</p>
                          </div>
                        </div>
                      </div>
                      <CardContent className="p-5">
                        <div className="flex items-center gap-3 text-muted-foreground">
                          <Lock className="h-5 w-5" />
                          <p>Content not yet published for this level</p>
                        </div>
                      </CardContent>
                    </Card>
                  );
                }

                // Show active card for published levels
                return (
                  <Link key={level} to={`/course/level/${publishedLevel.id}`}>
                    <Card className="overflow-hidden hover:shadow-lg transition-shadow cursor-pointer">
                      <div className={`p-5 bg-gradient-to-r ${config.gradient} text-white`}>
                        <div className="flex items-center justify-between">
                          <div className="flex items-center gap-4">
                            <div className="flex h-14 w-14 items-center justify-center rounded-xl bg-white/20 backdrop-blur-sm">
                              <GraduationCap className="h-7 w-7" />
                            </div>
                            <div>
                              <h2 className="font-display text-xl font-bold">{config.name}</h2>
                              <p className="text-white/80 text-sm">{config.description}</p>
                            </div>
                          </div>
                          <ChevronRight className="h-6 w-6" />
                        </div>
                      </div>
                      <CardContent className="p-5">
                        <div className="flex items-center justify-between">
                          <div className="flex items-center gap-3">
                            <BookOpen className="h-5 w-5 text-primary" />
                            <p className="font-medium">{publishedLevel.unit_count} {publishedLevel.unit_count === 1 ? 'unit' : 'units'} available</p>
                          </div>
                          <Badge variant="secondary">Start Learning</Badge>
                        </div>
                      </CardContent>
                    </Card>
                  </Link>
                );
              })
            )}
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
