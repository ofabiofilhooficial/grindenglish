import { useEffect, useState } from 'react';
import { useParams, Link } from 'react-router-dom';
import { AppLayout } from '@/components/layout/AppLayout';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { LevelBadge } from '@/components/ui/level-badge';
import { Badge } from '@/components/ui/badge';
import { 
  ArrowLeft,
  BookOpen,
  Target,
  FileText,
} from 'lucide-react';
import { supabase } from '@/integrations/supabase/client';

interface UnitData {
  id: string;
  title: string;
  theme: string | null;
  flagship_task: string | null;
  outcomes: any;
  sort_order: number;
}

interface LessonData {
  id: string;
  title: string;
  lesson_type: string;
  sort_order: number;
  is_published: boolean;
}

export default function UnitPage() {
  const { level, unitId } = useParams();
  const [unit, setUnit] = useState<UnitData | null>(null);
  const [lessons, setLessons] = useState<LessonData[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchUnit = async () => {
      if (!unitId) return;
      const cleanId = unitId.startsWith('unit-') ? unitId : unitId;
      
      // Fetch unit (only published for students)
      const { data } = await supabase
        .from('units')
        .select('id, title, theme, flagship_task, outcomes, sort_order, is_published')
        .eq('id', cleanId)
        .eq('is_published', true)
        .single();

      if (data) {
        setUnit(data);
        // Fetch only published lessons
        const { data: lessonData } = await supabase
          .from('lessons')
          .select('id, title, lesson_type, sort_order, is_published')
          .eq('unit_id', data.id)
          .eq('is_published', true)
          .order('sort_order');
        setLessons(lessonData || []);
      }
      setLoading(false);
    };
    fetchUnit();
  }, [unitId]);

  if (loading) {
    return (
      <AppLayout>
        <div className="flex justify-center items-center min-h-[50vh]">
          <div className="h-8 w-8 rounded-full border-2 border-primary border-t-transparent animate-spin" />
        </div>
      </AppLayout>
    );
  }

  if (!unit) {
    return (
      <AppLayout>
        <div className="p-6 space-y-6">
          <Link to="/course" className="inline-flex items-center gap-2 text-muted-foreground hover:text-foreground transition-colors">
            <ArrowLeft className="h-4 w-4" />
            Back to Course
          </Link>
          <Card className="p-12 text-center">
            <BookOpen className="h-16 w-16 text-muted-foreground mx-auto mb-4 opacity-40" />
            <h3 className="font-display text-xl font-bold mb-2">Unit Not Found</h3>
            <p className="text-muted-foreground">This unit doesn't exist or hasn't been published yet.</p>
          </Card>
        </div>
      </AppLayout>
    );
  }

  return (
    <AppLayout>
      <div className="p-6 space-y-6">
        <Link to="/course" className="inline-flex items-center gap-2 text-muted-foreground hover:text-foreground transition-colors">
          <ArrowLeft className="h-4 w-4" />
          Back to Course
        </Link>

        {/* Unit Header */}
        <div className="bg-gradient-to-r from-primary to-primary/80 rounded-2xl p-6 text-primary-foreground">
          <div className="flex items-start justify-between">
            <div className="flex-1">
              {level && (
                <div className="flex items-center gap-2 mb-2">
                  <LevelBadge level={level.toUpperCase() as any} size="sm" />
                  <span className="text-sm font-medium text-primary-foreground/80">Unit {unit.sort_order + 1}</span>
                </div>
              )}
              <h1 className="font-display text-3xl font-bold mb-2">{unit.title}</h1>
              {unit.flagship_task && (
                <p className="text-primary-foreground/80 mb-4 max-w-2xl">{unit.flagship_task}</p>
              )}
            </div>
            {unit.theme && (
              <Badge className="bg-white/20 text-primary-foreground border-0">
                Theme: {unit.theme}
              </Badge>
            )}
          </div>
        </div>

        <div className="grid lg:grid-cols-3 gap-6">
          <div className="lg:col-span-2">
            <Card>
              <CardHeader>
                <CardTitle className="font-display">Lessons</CardTitle>
              </CardHeader>
              <CardContent>
                {lessons.length === 0 ? (
                  <div className="text-center py-8 text-muted-foreground">
                    <FileText className="h-10 w-10 mx-auto mb-3 opacity-40" />
                    <p className="font-medium">No lessons yet</p>
                    <p className="text-sm">Lessons will appear here once they are created and published.</p>
                  </div>
                ) : (
                  <div className="space-y-2">
                    {lessons.map((lesson, index) => (
                      <div key={lesson.id} className="flex items-center gap-4 p-4 rounded-xl bg-secondary/50">
                        <span className="text-sm font-mono text-muted-foreground w-6">{index + 1}</span>
                        <div className="flex-1">
                          <p className="font-medium">{lesson.title}</p>
                          <p className="text-sm text-muted-foreground capitalize">{lesson.lesson_type}</p>
                        </div>
                      </div>
                    ))}
                  </div>
                )}
              </CardContent>
            </Card>
          </div>

          <div>
            <Card>
              <CardHeader className="pb-3">
                <CardTitle className="text-base font-display flex items-center gap-2">
                  <Target className="h-4 w-4" />
                  Flagship Task
                </CardTitle>
              </CardHeader>
              <CardContent>
                <p className="text-sm text-muted-foreground">
                  {unit.flagship_task || 'No flagship task defined yet.'}
                </p>
              </CardContent>
            </Card>
          </div>
        </div>
      </div>
    </AppLayout>
  );
}
