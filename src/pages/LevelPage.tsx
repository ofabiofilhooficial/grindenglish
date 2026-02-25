import { useEffect, useState } from 'react';
import { useParams, Link } from 'react-router-dom';
import { AppLayout } from '@/components/layout/AppLayout';
import { Card, CardContent } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { 
  ArrowLeft,
  BookOpen,
  ChevronRight,
  Lock
} from 'lucide-react';
import { supabase } from '@/integrations/supabase/client';
import { LevelBadge } from '@/components/ui/level-badge';
import { CEFRLevel } from '@/types/course';

interface UnitData {
  id: string;
  title: string;
  theme: string | null;
  sort_order: number;
  is_published: boolean;
  lesson_count: number;
}

export default function LevelPage() {
  const { levelId } = useParams();
  const [level, setLevel] = useState<{ id: string; title: string; cefr_code: string } | null>(null);
  const [units, setUnits] = useState<UnitData[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchData = async () => {
      if (!levelId) return;
      setLoading(true);

      // Fetch level
      const { data: levelData } = await supabase
        .from('levels')
        .select('id, title, cefr_code')
        .eq('id', levelId)
        .eq('is_published', true)
        .single();

      if (levelData) {
        setLevel(levelData);

        // Fetch published units
        const { data: unitsData } = await supabase
          .from('units')
          .select('id, title, theme, sort_order, is_published')
          .eq('level_id', levelId)
          .eq('is_published', true)
          .order('sort_order');

        if (unitsData) {
          // Get lesson counts for each unit
          const { data: lessonsData } = await supabase
            .from('lessons')
            .select('id, unit_id, is_published')
            .eq('is_published', true);

          const unitsWithCounts: UnitData[] = unitsData.map((unit) => ({
            ...unit,
            lesson_count: (lessonsData || []).filter((l) => l.unit_id === unit.id).length,
          }));

          setUnits(unitsWithCounts);
        }
      }
      setLoading(false);
    };

    fetchData();
  }, [levelId]);

  if (loading) {
    return (
      <AppLayout>
        <div className="flex justify-center items-center min-h-[50vh]">
          <div className="h-8 w-8 rounded-full border-2 border-primary border-t-transparent animate-spin" />
        </div>
      </AppLayout>
    );
  }

  if (!level) {
    return (
      <AppLayout>
        <div className="p-6 space-y-6">
          <Link to="/course" className="inline-flex items-center gap-2 text-muted-foreground hover:text-foreground transition-colors">
            <ArrowLeft className="h-4 w-4" />
            Back to Course
          </Link>
          <Card className="p-12 text-center">
            <Lock className="h-16 w-16 text-muted-foreground mx-auto mb-4 opacity-40" />
            <h3 className="font-display text-xl font-bold mb-2">Level Not Available</h3>
            <p className="text-muted-foreground">This level hasn't been published yet or doesn't exist.</p>
          </Card>
        </div>
      </AppLayout>
    );
  }

  return (
    <AppLayout title={level.title} subtitle={`${level.cefr_code} Level`}>
      <div className="p-6 space-y-6">
        <Link to="/course" className="inline-flex items-center gap-2 text-muted-foreground hover:text-foreground transition-colors">
          <ArrowLeft className="h-4 w-4" />
          Back to Course
        </Link>

        {units.length === 0 ? (
          <Card className="p-12 text-center">
            <BookOpen className="h-16 w-16 text-muted-foreground mx-auto mb-4 opacity-40" />
            <h3 className="font-display text-xl font-bold mb-2">No Units Available</h3>
            <p className="text-muted-foreground">Units will appear here once they are published.</p>
          </Card>
        ) : (
          <div className="space-y-3">
            {units.map((unit, index) => (
              <Link key={unit.id} to={`/course/${level.cefr_code.toLowerCase()}/${unit.id}`}>
                <Card className="hover:shadow-lg transition-shadow cursor-pointer">
                  <CardContent className="p-5 flex items-center gap-4">
                    <div className="flex h-12 w-12 items-center justify-center rounded-xl bg-primary/10 flex-shrink-0">
                      <span className="font-bold text-primary">{index + 1}</span>
                    </div>
                    <div className="flex-1 min-w-0">
                      <div className="flex items-center gap-2 mb-1">
                        <LevelBadge level={level.cefr_code as CEFRLevel} size="sm" />
                        <span className="text-sm text-muted-foreground">Unit {unit.sort_order + 1}</span>
                      </div>
                      <h3 className="font-display font-semibold text-lg">{unit.title}</h3>
                      {unit.theme && <p className="text-sm text-muted-foreground">{unit.theme}</p>}
                    </div>
                    <div className="flex items-center gap-3">
                      <div className="text-right">
                        <p className="text-sm font-medium">{unit.lesson_count} {unit.lesson_count === 1 ? 'lesson' : 'lessons'}</p>
                        <Badge className="text-xs">Start</Badge>
                      </div>
                      <ChevronRight className="h-5 w-5 text-muted-foreground" />
                    </div>
                  </CardContent>
                </Card>
              </Link>
            ))}
          </div>
        )}
      </div>
    </AppLayout>
  );
}
