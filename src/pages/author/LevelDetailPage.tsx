import { useState, useEffect } from 'react';
import { useParams, Link } from 'react-router-dom';
import { AppLayout } from '@/components/layout/AppLayout';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Badge } from '@/components/ui/badge';
import { Plus, ChevronRight, ArrowLeft, GripVertical, Pencil } from 'lucide-react';
import { supabase } from '@/integrations/supabase/client';
import { useToast } from '@/hooks/use-toast';

interface UnitRow {
  id: string;
  title: string;
  theme: string | null;
  flagship_task: string | null;
  is_published: boolean;
  sort_order: number;
  lesson_count: number;
}

export default function LevelDetailPage() {
  const { levelId } = useParams<{ levelId: string }>();
  const { toast } = useToast();
  const [level, setLevel] = useState<{ id: string; title: string; cefr_code: string } | null>(null);
  const [units, setUnits] = useState<UnitRow[]>([]);
  const [loading, setLoading] = useState(true);
  const [newUnitTitle, setNewUnitTitle] = useState('');

  const fetchData = async () => {
    if (!levelId) return;
    setLoading(true);

    const [levelRes, unitsRes, lessonsRes] = await Promise.all([
      supabase.from('levels').select('id, title, cefr_code').eq('id', levelId).single(),
      supabase.from('units').select('*').eq('level_id', levelId).order('sort_order'),
      supabase.from('lessons').select('id, unit_id'),
    ]);

    if (levelRes.data) setLevel(levelRes.data);
    if (unitsRes.data) {
      setUnits(unitsRes.data.map((u) => ({
        ...u,
        lesson_count: (lessonsRes.data || []).filter((l) => l.unit_id === u.id).length,
      })));
    }
    setLoading(false);
  };

  useEffect(() => { fetchData(); }, [levelId]);

  const createUnit = async () => {
    if (!newUnitTitle.trim() || !levelId) return;
    const { error } = await supabase.from('units').insert({
      level_id: levelId,
      title: newUnitTitle.trim(),
      sort_order: units.length,
    });
    if (error) {
      toast({ title: 'Error', description: error.message, variant: 'destructive' });
    } else {
      setNewUnitTitle('');
      fetchData();
    }
  };

  return (
    <AppLayout
      title={level ? `${level.cefr_code} – ${level.title}` : 'Level'}
      subtitle="Manage units in this level"
    >
      <div className="p-6 space-y-6">
        <Link to="/author/courses" className="inline-flex items-center gap-2 text-muted-foreground hover:text-foreground transition-colors">
          <ArrowLeft className="h-4 w-4" />
          Back to courses
        </Link>

        {/* Add Unit */}
        <Card>
          <CardContent className="pt-6">
            <div className="flex gap-3">
              <Input
                placeholder="New unit title..."
                value={newUnitTitle}
                onChange={(e) => setNewUnitTitle(e.target.value)}
                onKeyDown={(e) => e.key === 'Enter' && createUnit()}
              />
              <Button onClick={createUnit} className="bg-gradient-primary hover:opacity-90">
                <Plus className="h-4 w-4 mr-2" />
                Add Unit
              </Button>
            </div>
          </CardContent>
        </Card>

        {loading ? (
          <div className="flex justify-center py-12">
            <div className="h-8 w-8 rounded-full border-2 border-primary border-t-transparent animate-spin" />
          </div>
        ) : units.length === 0 ? (
          <Card className="p-12 text-center">
            <p className="text-muted-foreground">No units yet. Create the first unit above.</p>
          </Card>
        ) : (
          <div className="space-y-3">
            {units.map((unit, index) => (
              <Link key={unit.id} to={`/author/units/${unit.id}`}>
                <Card className="hover:shadow-md transition-shadow cursor-pointer">
                  <CardContent className="p-4 flex items-center gap-4">
                    <GripVertical className="h-5 w-5 text-muted-foreground flex-shrink-0" />
                    <div className="flex-1 min-w-0">
                      <div className="flex items-center gap-2 mb-1">
                        <span className="text-sm font-medium text-muted-foreground">Unit {index + 1}</span>
                        <Badge variant={unit.is_published ? 'default' : 'secondary'} className="text-xs">
                          {unit.is_published ? 'Published' : 'Draft'}
                        </Badge>
                      </div>
                      <h3 className="font-display font-semibold">{unit.title}</h3>
                      {unit.theme && <p className="text-sm text-muted-foreground">{unit.theme}</p>}
                    </div>
                    <div className="text-sm text-muted-foreground">{unit.lesson_count} lessons</div>
                    <ChevronRight className="h-5 w-5 text-muted-foreground" />
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
