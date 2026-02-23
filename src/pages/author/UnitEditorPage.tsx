import { useState, useEffect } from 'react';
import { useParams, Link } from 'react-router-dom';
import { AppLayout } from '@/components/layout/AppLayout';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Textarea } from '@/components/ui/textarea';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { Badge } from '@/components/ui/badge';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { ArrowLeft, Save, Plus, GripVertical, ChevronRight, Eye, EyeOff } from 'lucide-react';
import { supabase } from '@/integrations/supabase/client';
import { useToast } from '@/hooks/use-toast';

export default function UnitEditorPage() {
  const { unitId } = useParams<{ unitId: string }>();
  const { toast } = useToast();
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [unit, setUnit] = useState<any>(null);
  const [lessons, setLessons] = useState<any[]>([]);
  const [newLessonTitle, setNewLessonTitle] = useState('');
  const [newLessonType, setNewLessonType] = useState('listening');

  const fetchData = async () => {
    if (!unitId) return;
    setLoading(true);
    const [unitRes, lessonsRes] = await Promise.all([
      supabase.from('units').select('*').eq('id', unitId).single(),
      supabase.from('lessons').select('*').eq('unit_id', unitId).order('sort_order'),
    ]);
    if (unitRes.data) setUnit(unitRes.data);
    if (lessonsRes.data) setLessons(lessonsRes.data);
    setLoading(false);
  };

  useEffect(() => { fetchData(); }, [unitId]);

  const saveUnit = async () => {
    if (!unit) return;
    setSaving(true);
    const { error } = await supabase.from('units').update({
      title: unit.title,
      theme: unit.theme,
      flagship_task: unit.flagship_task,
      secondary_tasks: unit.secondary_tasks,
      outcomes: unit.outcomes,
      estimated_time_minutes: unit.estimated_time_minutes,
      track: unit.track,
    }).eq('id', unit.id);

    if (error) {
      toast({ title: 'Error', description: error.message, variant: 'destructive' });
    } else {
      toast({ title: 'Saved', description: 'Unit updated successfully.' });
    }
    setSaving(false);
  };

  const createLesson = async () => {
    if (!newLessonTitle.trim() || !unitId) return;
    const { error } = await supabase.from('lessons').insert({
      unit_id: unitId,
      title: newLessonTitle.trim(),
      lesson_type: newLessonType as any,
      sort_order: lessons.length,
    });
    if (error) {
      toast({ title: 'Error', description: error.message, variant: 'destructive' });
    } else {
      setNewLessonTitle('');
      fetchData();
    }
  };

  const toggleUnitPublish = async () => {
    if (!unit) return;
    const { error } = await supabase
      .from('units')
      .update({ is_published: !unit.is_published })
      .eq('id', unit.id);

    if (error) {
      toast({ title: 'Error', description: error.message, variant: 'destructive' });
    } else {
      toast({ 
        title: !unit.is_published ? 'Published' : 'Unpublished', 
        description: `Unit ${!unit.is_published ? 'is now visible to students' : 'is now hidden from students'}.` 
      });
      setUnit({ ...unit, is_published: !unit.is_published });
    }
  };

  const toggleLessonPublish = async (lessonId: string, currentStatus: boolean) => {
    const { error } = await supabase
      .from('lessons')
      .update({ is_published: !currentStatus })
      .eq('id', lessonId);

    if (error) {
      toast({ title: 'Error', description: error.message, variant: 'destructive' });
    } else {
      toast({ 
        title: !currentStatus ? 'Published' : 'Unpublished', 
        description: `Lesson ${!currentStatus ? 'is now visible to students' : 'is now hidden from students'}.` 
      });
      fetchData();
    }
  };

  if (loading) {
    return (
      <AppLayout title="Unit Editor">
        <div className="flex justify-center py-12">
          <div className="h-8 w-8 rounded-full border-2 border-primary border-t-transparent animate-spin" />
        </div>
      </AppLayout>
    );
  }

  if (!unit) {
    return (
      <AppLayout title="Unit not found">
        <div className="p-6">
          <p className="text-muted-foreground">This unit could not be found.</p>
        </div>
      </AppLayout>
    );
  }

  return (
    <AppLayout title={unit.title} subtitle="Edit unit details">
      <div className="p-6 space-y-6">
        <div className="flex items-center justify-between">
          <Link to={`/author/courses`} className="inline-flex items-center gap-2 text-muted-foreground hover:text-foreground transition-colors">
            <ArrowLeft className="h-4 w-4" />
            Back
          </Link>
          <div className="flex items-center gap-2">
            <Badge variant={unit.is_published ? 'default' : 'secondary'}>
              {unit.is_published ? 'Published' : 'Draft'}
            </Badge>
            <Button
              variant={unit.is_published ? 'outline' : 'default'}
              size="sm"
              onClick={toggleUnitPublish}
            >
              {unit.is_published ? (
                <>
                  <EyeOff className="h-4 w-4 mr-2" />
                  Unpublish
                </>
              ) : (
                <>
                  <Eye className="h-4 w-4 mr-2" />
                  Publish
                </>
              )}
            </Button>
            <Button onClick={saveUnit} disabled={saving} className="bg-gradient-primary hover:opacity-90">
              <Save className="h-4 w-4 mr-2" />
              {saving ? 'Saving...' : 'Save'}
            </Button>
          </div>
        </div>

        <Tabs defaultValue="overview" className="w-full">
          <TabsList className="bg-secondary">
            <TabsTrigger value="overview">Overview</TabsTrigger>
            <TabsTrigger value="outcomes">Outcomes</TabsTrigger>
            <TabsTrigger value="targets">Targets</TabsTrigger>
            <TabsTrigger value="lessons">Lessons</TabsTrigger>
            <TabsTrigger value="deliverables">Deliverables</TabsTrigger>
          </TabsList>

          <TabsContent value="overview" className="space-y-4 mt-4">
            <Card>
              <CardContent className="pt-6 space-y-4">
                <div className="grid grid-cols-2 gap-4">
                  <div className="space-y-2">
                    <Label>Title</Label>
                    <Input value={unit.title} onChange={(e) => setUnit({ ...unit, title: e.target.value })} />
                  </div>
                  <div className="space-y-2">
                    <Label>Track</Label>
                    <Select value={unit.track} onValueChange={(v) => setUnit({ ...unit, track: v })}>
                      <SelectTrigger><SelectValue /></SelectTrigger>
                      <SelectContent>
                        <SelectItem value="core">Core</SelectItem>
                        <SelectItem value="professional">Professional</SelectItem>
                        <SelectItem value="academic">Academic</SelectItem>
                      </SelectContent>
                    </Select>
                  </div>
                </div>
                <div className="space-y-2">
                  <Label>Theme</Label>
                  <Input value={unit.theme || ''} onChange={(e) => setUnit({ ...unit, theme: e.target.value })} placeholder="e.g., Identity & Greetings" />
                </div>
                <div className="space-y-2">
                  <Label>Flagship Task</Label>
                  <Textarea value={unit.flagship_task || ''} onChange={(e) => setUnit({ ...unit, flagship_task: e.target.value })} placeholder="The main real-world task students complete" />
                </div>
                <div className="space-y-2">
                  <Label>Estimated Time (minutes)</Label>
                  <Input type="number" value={unit.estimated_time_minutes || ''} onChange={(e) => setUnit({ ...unit, estimated_time_minutes: parseInt(e.target.value) || null })} />
                </div>
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="outcomes" className="space-y-4 mt-4">
            <Card>
              <CardContent className="pt-6 space-y-4">
                {['listening', 'reading', 'speaking', 'writing', 'grammar', 'vocabulary', 'pronunciation', 'pragmatics'].map((skill) => (
                  <div key={skill} className="space-y-2">
                    <Label className="capitalize">{skill}</Label>
                    <Textarea
                      value={unit.outcomes?.[skill] || ''}
                      onChange={(e) => setUnit({
                        ...unit,
                        outcomes: { ...unit.outcomes, [skill]: e.target.value }
                      })}
                      placeholder={`${skill} outcomes for this unit...`}
                      rows={2}
                    />
                  </div>
                ))}
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="targets" className="space-y-4 mt-4">
            <Card>
              <CardContent className="pt-6">
                <p className="text-muted-foreground">Link vocabulary, grammar chapters, pronunciation targets, and pragmatics packs to this unit. Create content in the respective managers first, then link them here.</p>
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="lessons" className="space-y-4 mt-4">
            <Card>
              <CardContent className="pt-6">
                <div className="flex gap-3 mb-6">
                  <Input
                    placeholder="New lesson title..."
                    value={newLessonTitle}
                    onChange={(e) => setNewLessonTitle(e.target.value)}
                    onKeyDown={(e) => e.key === 'Enter' && createLesson()}
                  />
                  <Select value={newLessonType} onValueChange={setNewLessonType}>
                    <SelectTrigger className="w-[160px]"><SelectValue /></SelectTrigger>
                    <SelectContent>
                      {['listening', 'reading', 'grammar', 'vocabulary', 'pronunciation', 'speaking', 'writing', 'fluency', 'mediation', 'review'].map((t) => (
                        <SelectItem key={t} value={t}>{t}</SelectItem>
                      ))}
                    </SelectContent>
                  </Select>
                  <Button onClick={createLesson}>
                    <Plus className="h-4 w-4 mr-2" />
                    Add
                  </Button>
                </div>
                {lessons.length === 0 ? (
                  <p className="text-muted-foreground text-center py-8">No lessons yet. Add one above.</p>
                ) : (
                  <div className="space-y-2">
                    {lessons.map((lesson, i) => (
                      <div key={lesson.id} className="relative group">
                        <Link to={`/author/lessons/${lesson.id}`}>
                          <Card className="hover:shadow-md transition-shadow cursor-pointer">
                            <CardContent className="p-3 flex items-center gap-3">
                              <GripVertical className="h-4 w-4 text-muted-foreground" />
                              <span className="text-sm text-muted-foreground w-8">#{i + 1}</span>
                              <Badge variant="outline" className="text-xs capitalize">{lesson.lesson_type}</Badge>
                              <span className="font-medium flex-1">{lesson.title}</span>
                              <Badge variant={lesson.is_published ? 'default' : 'secondary'} className="text-xs">
                                {lesson.is_published ? 'Published' : 'Draft'}
                              </Badge>
                              <ChevronRight className="h-4 w-4 text-muted-foreground" />
                            </CardContent>
                          </Card>
                        </Link>
                        <Button
                          variant="ghost"
                          size="sm"
                          className="absolute top-2 right-8 opacity-0 group-hover:opacity-100 transition-opacity"
                          onClick={(e) => {
                            e.preventDefault();
                            e.stopPropagation();
                            toggleLessonPublish(lesson.id, lesson.is_published);
                          }}
                        >
                          {lesson.is_published ? <EyeOff className="h-3 w-3" /> : <Eye className="h-3 w-3" />}
                        </Button>
                      </div>
                    ))}
                  </div>
                )}
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="deliverables" className="space-y-4 mt-4">
            <Card>
              <CardContent className="pt-6">
                <p className="text-muted-foreground">Define speaking artifact, writing artifact, and reflection requirements for this unit. Coming soon.</p>
              </CardContent>
            </Card>
          </TabsContent>
        </Tabs>
      </div>
    </AppLayout>
  );
}
