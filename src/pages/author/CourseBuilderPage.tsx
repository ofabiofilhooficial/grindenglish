import { useState, useEffect } from 'react';
import { AppLayout } from '@/components/layout/AppLayout';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Badge } from '@/components/ui/badge';
import { Plus, ChevronRight, GraduationCap, FolderOpen } from 'lucide-react';
import { supabase } from '@/integrations/supabase/client';
import { useAuth } from '@/hooks/useAuth';
import { useToast } from '@/hooks/use-toast';
import { Link } from 'react-router-dom';

interface CourseWithLevels {
  id: string;
  title: string;
  description: string | null;
  is_published: boolean;
  levels: {
    id: string;
    title: string;
    cefr_code: string;
    sort_order: number;
    is_published: boolean;
    unit_count: number;
  }[];
}

export default function CourseBuilderPage() {
  const { toast } = useToast();
  const { user } = useAuth();
  const [courses, setCourses] = useState<CourseWithLevels[]>([]);
  const [loading, setLoading] = useState(true);
  const [newCourseTitle, setNewCourseTitle] = useState('');

  const fetchCourses = async () => {
    setLoading(true);
    const { data: coursesData } = await supabase.from('courses').select('*').order('created_at');
    const { data: levelsData } = await supabase.from('levels').select('*').order('sort_order');
    const { data: unitsData } = await supabase.from('units').select('id, level_id');

    if (coursesData) {
      const mapped: CourseWithLevels[] = coursesData.map((c) => ({
        id: c.id,
        title: c.title,
        description: c.description,
        is_published: c.is_published,
        levels: (levelsData || [])
          .filter((l) => l.course_id === c.id)
          .map((l) => ({
            id: l.id,
            title: l.title,
            cefr_code: l.cefr_code,
            sort_order: l.sort_order,
            is_published: l.is_published,
            unit_count: (unitsData || []).filter((u) => u.level_id === l.id).length,
          })),
      }));
      setCourses(mapped);
    }
    setLoading(false);
  };

  useEffect(() => { fetchCourses(); }, []);

  const createCourse = async () => {
    if (!newCourseTitle.trim()) return;
    const { data, error } = await supabase.from('courses').insert({
      title: newCourseTitle.trim(),
      created_by: user?.id,
    }).select().single();

    if (error) {
      toast({ title: 'Error', description: error.message, variant: 'destructive' });
      return;
    }

    // Auto-create CEFR levels
    const cefrLevels = [
      { cefr_code: 'A0', title: 'A0 – Breakthrough', sort_order: 0 },
      { cefr_code: 'A1', title: 'A1 – Beginner', sort_order: 1 },
      { cefr_code: 'A2', title: 'A2 – Elementary', sort_order: 2 },
      { cefr_code: 'B1', title: 'B1 – Intermediate', sort_order: 3 },
      { cefr_code: 'B2', title: 'B2 – Upper Intermediate', sort_order: 4 },
      { cefr_code: 'C1', title: 'C1 – Advanced', sort_order: 5 },
      { cefr_code: 'C2', title: 'C2 – Mastery', sort_order: 6 },
    ];

    await supabase.from('levels').insert(
      cefrLevels.map((l) => ({ ...l, course_id: data.id }))
    );

    setNewCourseTitle('');
    toast({ title: 'Course created', description: 'Course with all CEFR levels has been created.' });
    fetchCourses();
  };

  return (
    <AppLayout title="Course Builder" subtitle="Create and manage your courses">
      <div className="p-6 space-y-6">
        {/* Create Course */}
        <Card>
          <CardContent className="pt-6">
            <div className="flex gap-3">
              <Input
                placeholder="New course title..."
                value={newCourseTitle}
                onChange={(e) => setNewCourseTitle(e.target.value)}
                onKeyDown={(e) => e.key === 'Enter' && createCourse()}
              />
              <Button onClick={createCourse} className="bg-gradient-primary hover:opacity-90">
                <Plus className="h-4 w-4 mr-2" />
                Create Course
              </Button>
            </div>
          </CardContent>
        </Card>

        {loading ? (
          <div className="flex justify-center py-12">
            <div className="h-8 w-8 rounded-full border-2 border-primary border-t-transparent animate-spin" />
          </div>
        ) : courses.length === 0 ? (
          <Card className="p-12 text-center">
            <GraduationCap className="h-12 w-12 text-muted-foreground mx-auto mb-4" />
            <h3 className="font-display text-xl font-bold mb-2">No courses yet</h3>
            <p className="text-muted-foreground">Create your first course to get started.</p>
          </Card>
        ) : (
          courses.map((course) => (
            <Card key={course.id}>
              <CardHeader>
                <div className="flex items-center justify-between">
                  <CardTitle className="font-display flex items-center gap-2">
                    <GraduationCap className="h-5 w-5" />
                    {course.title}
                  </CardTitle>
                  <Badge variant={course.is_published ? 'default' : 'secondary'}>
                    {course.is_published ? 'Published' : 'Draft'}
                  </Badge>
                </div>
              </CardHeader>
              <CardContent>
                <div className="grid sm:grid-cols-2 lg:grid-cols-4 gap-3">
                  {course.levels.map((level) => (
                    <Link key={level.id} to={`/author/levels/${level.id}`}>
                      <Card className="hover:shadow-md transition-shadow cursor-pointer">
                        <CardContent className="p-4">
                          <div className="flex items-center justify-between mb-2">
                            <Badge variant="outline">{level.cefr_code}</Badge>
                            <ChevronRight className="h-4 w-4 text-muted-foreground" />
                          </div>
                          <p className="font-medium text-sm">{level.title}</p>
                          <p className="text-xs text-muted-foreground mt-1">
                            {level.unit_count} units
                          </p>
                        </CardContent>
                      </Card>
                    </Link>
                  ))}
                </div>
              </CardContent>
            </Card>
          ))
        )}
      </div>
    </AppLayout>
  );
}
