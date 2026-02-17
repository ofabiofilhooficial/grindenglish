import { useState, useEffect } from 'react';
import { AppLayout } from '@/components/layout/AppLayout';
import { Card, CardContent } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Badge } from '@/components/ui/badge';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Plus, Tags, X } from 'lucide-react';
import { supabase } from '@/integrations/supabase/client';
import { useToast } from '@/hooks/use-toast';

const CATEGORIES = ['cefr', 'skill', 'theme', 'grammar', 'lexicon', 'pronunciation', 'speech_act', 'medium', 'register'];

export default function TagManagerPage() {
  const { toast } = useToast();
  const [tags, setTags] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [newName, setNewName] = useState('');
  const [newCategory, setNewCategory] = useState('theme');

  const fetchTags = async () => {
    setLoading(true);
    const { data } = await supabase.from('tags').select('*').order('category').order('name');
    if (data) setTags(data);
    setLoading(false);
  };

  useEffect(() => { fetchTags(); }, []);

  const addTag = async () => {
    if (!newName.trim()) return;
    const { error } = await supabase.from('tags').insert({ name: newName.trim(), category: newCategory });
    if (error) { toast({ title: 'Error', description: error.message, variant: 'destructive' }); return; }
    setNewName('');
    fetchTags();
  };

  const deleteTag = async (id: string) => {
    await supabase.from('tags').delete().eq('id', id);
    fetchTags();
  };

  const grouped = tags.reduce((acc: Record<string, any[]>, t) => {
    const cat = t.category || 'uncategorized';
    (acc[cat] = acc[cat] || []).push(t);
    return acc;
  }, {});

  return (
    <AppLayout title="Tags" subtitle="Manage content tags">
      <div className="p-6 space-y-6">
        <Card>
          <CardContent className="pt-6">
            <div className="flex gap-3">
              <Input placeholder="Tag name..." value={newName} onChange={(e) => setNewName(e.target.value)} onKeyDown={(e) => e.key === 'Enter' && addTag()} />
              <Select value={newCategory} onValueChange={setNewCategory}>
                <SelectTrigger className="w-[160px]"><SelectValue /></SelectTrigger>
                <SelectContent>
                  {CATEGORIES.map((c) => (<SelectItem key={c} value={c}>{c}</SelectItem>))}
                </SelectContent>
              </Select>
              <Button onClick={addTag}><Plus className="h-4 w-4 mr-2" /> Add</Button>
            </div>
          </CardContent>
        </Card>

        {loading ? (
          <div className="flex justify-center py-12"><div className="h-8 w-8 rounded-full border-2 border-primary border-t-transparent animate-spin" /></div>
        ) : Object.keys(grouped).length === 0 ? (
          <Card className="p-12 text-center">
            <Tags className="h-12 w-12 text-muted-foreground mx-auto mb-4" />
            <p className="text-muted-foreground">No tags yet.</p>
          </Card>
        ) : (
          Object.entries(grouped).sort().map(([cat, tagList]) => (
            <div key={cat}>
              <h3 className="font-display font-semibold capitalize mb-2">{cat}</h3>
              <div className="flex flex-wrap gap-2 mb-4">
                {(tagList as any[]).map((t) => (
                  <Badge key={t.id} variant="secondary" className="gap-1 pr-1">
                    {t.name}
                    <button onClick={() => deleteTag(t.id)} className="ml-1 hover:text-destructive">
                      <X className="h-3 w-3" />
                    </button>
                  </Badge>
                ))}
              </div>
            </div>
          ))
        )}
      </div>
    </AppLayout>
  );
}
