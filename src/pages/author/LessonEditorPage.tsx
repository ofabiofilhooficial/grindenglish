import { useState, useEffect } from 'react';
import { useParams, Link } from 'react-router-dom';
import { AppLayout } from '@/components/layout/AppLayout';
import { Card, CardContent } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Textarea } from '@/components/ui/textarea';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Badge } from '@/components/ui/badge';
import { ArrowLeft, Save, Plus, GripVertical, Trash2, Eye, EyeOff } from 'lucide-react';
import { supabase } from '@/integrations/supabase/client';
import { useToast } from '@/hooks/use-toast';

const STAGE_TYPES = [
  'warm_up', 'lead_in', 'input', 'comprehension', 'noticing',
  'practice', 'communicative_use', 'feedback', 'assignment', 'reflection'
];

export default function LessonEditorPage() {
  const { lessonId } = useParams<{ lessonId: string }>();
  const { toast } = useToast();
  const [lesson, setLesson] = useState<any>(null);
  const [stages, setStages] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);

  const fetchData = async () => {
    if (!lessonId) return;
    setLoading(true);
    const [lessonRes, stagesRes] = await Promise.all([
      supabase.from('lessons').select('*').eq('id', lessonId).single(),
      supabase.from('lesson_stages').select('*').eq('lesson_id', lessonId).order('sort_order'),
    ]);
    if (lessonRes.data) setLesson(lessonRes.data);
    if (stagesRes.data) setStages(stagesRes.data);
    setLoading(false);
  };

  useEffect(() => { fetchData(); }, [lessonId]);

  const saveLesson = async () => {
    if (!lesson) return;
    setSaving(true);
    const { error } = await supabase.from('lessons').update({
      title: lesson.title,
      goal: lesson.goal,
      success_criteria: lesson.success_criteria,
      interaction_pattern: lesson.interaction_pattern,
      support_track: lesson.support_track,
      challenge_track: lesson.challenge_track,
    }).eq('id', lesson.id);

    if (error) {
      toast({ title: 'Error', description: error.message, variant: 'destructive' });
    } else {
      toast({ title: 'Saved' });
    }
    setSaving(false);
  };

  const addStage = async (stageType: string) => {
    if (!lessonId) return;
    await supabase.from('lesson_stages').insert({
      lesson_id: lessonId,
      stage_type: stageType,
      title: stageType.replace(/_/g, ' ').replace(/\b\w/g, (l) => l.toUpperCase()),
      sort_order: stages.length,
    });
    fetchData();
  };

  const deleteStage = async (stageId: string) => {
    await supabase.from('lesson_stages').delete().eq('id', stageId);
    fetchData();
  };

  const updateStage = async (stageId: string, field: string, value: any) => {
    await supabase.from('lesson_stages').update({ [field]: value }).eq('id', stageId);
  };

  const toggleLessonPublish = async () => {
    if (!lesson) return;
    const { error } = await supabase
      .from('lessons')
      .update({ is_published: !lesson.is_published })
      .eq('id', lesson.id);

    if (error) {
      toast({ title: 'Error', description: error.message, variant: 'destructive' });
    } else {
      toast({ 
        title: !lesson.is_published ? 'Published' : 'Unpublished', 
        description: `Lesson ${!lesson.is_published ? 'is now visible to students' : 'is now hidden from students'}.` 
      });
      setLesson({ ...lesson, is_published: !lesson.is_published });
    }
  };

  if (loading) {
    return <AppLayout title="Lesson Editor"><div className="flex justify-center py-12"><div className="h-8 w-8 rounded-full border-2 border-primary border-t-transparent animate-spin" /></div></AppLayout>;
  }

  if (!lesson) {
    return <AppLayout title="Lesson not found"><div className="p-6"><p className="text-muted-foreground">Lesson not found.</p></div></AppLayout>;
  }

  return (
    <AppLayout title={lesson.title} subtitle={`${lesson.lesson_type} lesson`}>
      <div className="p-6 space-y-6">
        <div className="flex items-center justify-between">
          <Link to={`/author/units/${lesson.unit_id}`} className="inline-flex items-center gap-2 text-muted-foreground hover:text-foreground transition-colors">
            <ArrowLeft className="h-4 w-4" />
            Back to unit
          </Link>
          <div className="flex items-center gap-2">
            <Badge variant={lesson.is_published ? 'default' : 'secondary'}>
              {lesson.is_published ? 'Published' : 'Draft'}
            </Badge>
            <Button
              variant={lesson.is_published ? 'outline' : 'default'}
              size="sm"
              onClick={toggleLessonPublish}
            >
              {lesson.is_published ? (
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
            <Button onClick={saveLesson} disabled={saving} className="bg-gradient-primary hover:opacity-90">
              <Save className="h-4 w-4 mr-2" />
              {saving ? 'Saving...' : 'Save'}
            </Button>
          </div>
        </div>

        {/* Lesson Meta */}
        <Card>
          <CardContent className="pt-6 space-y-4">
            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label>Title</Label>
                <Input value={lesson.title} onChange={(e) => setLesson({ ...lesson, title: e.target.value })} />
              </div>
              <div className="space-y-2">
                <Label>Interaction Pattern</Label>
                <Select value={lesson.interaction_pattern || ''} onValueChange={(v) => setLesson({ ...lesson, interaction_pattern: v })}>
                  <SelectTrigger><SelectValue placeholder="Select..." /></SelectTrigger>
                  <SelectContent>
                    <SelectItem value="solo">Solo</SelectItem>
                    <SelectItem value="pair">Pair</SelectItem>
                    <SelectItem value="group">Group</SelectItem>
                    <SelectItem value="async">Async</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </div>
            <div className="space-y-2">
              <Label>Goal</Label>
              <Textarea value={lesson.goal || ''} onChange={(e) => setLesson({ ...lesson, goal: e.target.value })} rows={2} />
            </div>
            <div className="space-y-2">
              <Label>Success Criteria</Label>
              <Textarea value={lesson.success_criteria || ''} onChange={(e) => setLesson({ ...lesson, success_criteria: e.target.value })} rows={2} />
            </div>
          </CardContent>
        </Card>

        {/* Stages */}
        <Card>
          <CardContent className="pt-6">
            <div className="flex items-center justify-between mb-4">
              <h3 className="font-display font-semibold">Lesson Stages</h3>
              <Select onValueChange={addStage}>
                <SelectTrigger className="w-[200px]">
                  <SelectValue placeholder="Add stage..." />
                </SelectTrigger>
                <SelectContent>
                  {STAGE_TYPES.map((t) => (
                    <SelectItem key={t} value={t}>{t.replace(/_/g, ' ')}</SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>
            {stages.length === 0 ? (
              <p className="text-muted-foreground text-center py-8">No stages yet. Add one above.</p>
            ) : (
              <div className="space-y-3">
                {stages.map((stage, i) => (
                  <Card key={stage.id} className="border-border/50">
                    <CardContent className="p-4 space-y-3">
                      <div className="flex items-center gap-3">
                        <GripVertical className="h-4 w-4 text-muted-foreground" />
                        <Badge variant="outline" className="text-xs capitalize">{stage.stage_type.replace(/_/g, ' ')}</Badge>
                        <Input
                          value={stage.title}
                          onChange={(e) => {
                            const updated = [...stages];
                            updated[i] = { ...stage, title: e.target.value };
                            setStages(updated);
                          }}
                          onBlur={() => updateStage(stage.id, 'title', stages[i].title)}
                          className="flex-1"
                        />
                        <Input
                          type="number"
                          value={stage.timing_minutes || ''}
                          onChange={(e) => {
                            const updated = [...stages];
                            updated[i] = { ...stage, timing_minutes: parseInt(e.target.value) || null };
                            setStages(updated);
                          }}
                          onBlur={() => updateStage(stage.id, 'timing_minutes', stages[i].timing_minutes)}
                          className="w-20"
                          placeholder="min"
                        />
                        <Button variant="ghost" size="icon" onClick={() => deleteStage(stage.id)}>
                          <Trash2 className="h-4 w-4 text-destructive" />
                        </Button>
                      </div>
                      <Textarea
                        value={stage.instructions || ''}
                        onChange={(e) => {
                          const updated = [...stages];
                          updated[i] = { ...stage, instructions: e.target.value };
                          setStages(updated);
                        }}
                        onBlur={() => updateStage(stage.id, 'instructions', stages[i].instructions)}
                        placeholder="Instructions for this stage..."
                        rows={2}
                      />
                    </CardContent>
                  </Card>
                ))}
              </div>
            )}
          </CardContent>
        </Card>
      </div>
    </AppLayout>
  );
}
