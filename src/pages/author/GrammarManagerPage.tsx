import { useState, useEffect } from 'react';
import { AppLayout } from '@/components/layout/AppLayout';
import { Card, CardContent } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Textarea } from '@/components/ui/textarea';
import { Badge } from '@/components/ui/badge';
import { Dialog, DialogContent, DialogHeader, DialogTitle } from '@/components/ui/dialog';
import { Plus, Search, Languages } from 'lucide-react';
import { supabase } from '@/integrations/supabase/client';
import { useToast } from '@/hooks/use-toast';

export default function GrammarManagerPage() {
  const { toast } = useToast();
  const [chapters, setChapters] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [search, setSearch] = useState('');
  const [dialogOpen, setDialogOpen] = useState(false);
  const [editChapter, setEditChapter] = useState<any>(null);

  const emptyChapter = {
    chapter_code: '', title: '', cefr_level: 'A0', form_content: '',
    meaning_content: '', use_content: '', contrast_notes: '', common_errors: '',
  };

  const fetchChapters = async () => {
    setLoading(true);
    const { data } = await supabase.from('grammar_chapters').select('*').order('sort_order');
    if (data) setChapters(data);
    setLoading(false);
  };

  useEffect(() => { fetchChapters(); }, []);

  const saveChapter = async () => {
    if (!editChapter?.chapter_code?.trim() || !editChapter?.title?.trim()) return;
    const payload = { ...editChapter };
    delete payload.id; delete payload.created_at; delete payload.updated_at;

    if (editChapter.id) {
      const { error } = await supabase.from('grammar_chapters').update(payload).eq('id', editChapter.id);
      if (error) { toast({ title: 'Error', description: error.message, variant: 'destructive' }); return; }
    } else {
      const { error } = await supabase.from('grammar_chapters').insert({ ...payload, sort_order: chapters.length });
      if (error) { toast({ title: 'Error', description: error.message, variant: 'destructive' }); return; }
    }

    toast({ title: 'Saved' });
    setDialogOpen(false);
    fetchChapters();
  };

  const filtered = chapters.filter((c) =>
    c.title.toLowerCase().includes(search.toLowerCase()) || c.chapter_code.toLowerCase().includes(search.toLowerCase())
  );

  const grouped = filtered.reduce((acc: Record<string, any[]>, ch) => {
    (acc[ch.cefr_level] = acc[ch.cefr_level] || []).push(ch);
    return acc;
  }, {});

  return (
    <AppLayout title="Grammar Chapters" subtitle="Manage the Grammar Reference Book">
      <div className="p-6 space-y-6">
        <div className="flex items-center justify-between">
          <div className="relative w-64">
            <Search className="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-muted-foreground" />
            <Input placeholder="Search chapters..." value={search} onChange={(e) => setSearch(e.target.value)} className="pl-9" />
          </div>
          <Button onClick={() => { setEditChapter({ ...emptyChapter }); setDialogOpen(true); }} className="bg-gradient-primary hover:opacity-90">
            <Plus className="h-4 w-4 mr-2" /> Add Chapter
          </Button>
        </div>

        {loading ? (
          <div className="flex justify-center py-12"><div className="h-8 w-8 rounded-full border-2 border-primary border-t-transparent animate-spin" /></div>
        ) : Object.keys(grouped).length === 0 ? (
          <Card className="p-12 text-center">
            <Languages className="h-12 w-12 text-muted-foreground mx-auto mb-4" />
            <p className="text-muted-foreground">No grammar chapters yet.</p>
          </Card>
        ) : (
          Object.entries(grouped).sort().map(([level, chs]) => (
            <div key={level}>
              <h2 className="font-display font-bold text-lg mb-3">{level}</h2>
              <div className="space-y-2 mb-6">
                {(chs as any[]).map((ch) => (
                  <Card key={ch.id} className="cursor-pointer hover:shadow-md transition-shadow" onClick={() => { setEditChapter(ch); setDialogOpen(true); }}>
                    <CardContent className="p-4 flex items-center gap-4">
                      <Badge variant="outline">{ch.chapter_code}</Badge>
                      <span className="font-medium flex-1">{ch.title}</span>
                    </CardContent>
                  </Card>
                ))}
              </div>
            </div>
          ))
        )}

        <Dialog open={dialogOpen} onOpenChange={setDialogOpen}>
          <DialogContent className="max-w-2xl max-h-[80vh] overflow-y-auto">
            <DialogHeader><DialogTitle>{editChapter?.id ? 'Edit Chapter' : 'New Chapter'}</DialogTitle></DialogHeader>
            {editChapter && (
              <div className="space-y-4">
                <div className="grid grid-cols-3 gap-4">
                  <div className="space-y-2"><Label>Code</Label><Input value={editChapter.chapter_code} onChange={(e) => setEditChapter({ ...editChapter, chapter_code: e.target.value })} placeholder="A0.G.01" /></div>
                  <div className="space-y-2"><Label>Title</Label><Input value={editChapter.title} onChange={(e) => setEditChapter({ ...editChapter, title: e.target.value })} /></div>
                  <div className="space-y-2"><Label>CEFR Level</Label><Input value={editChapter.cefr_level} onChange={(e) => setEditChapter({ ...editChapter, cefr_level: e.target.value })} /></div>
                </div>
                <div className="space-y-2"><Label>Form</Label><Textarea value={editChapter.form_content || ''} onChange={(e) => setEditChapter({ ...editChapter, form_content: e.target.value })} rows={3} /></div>
                <div className="space-y-2"><Label>Meaning</Label><Textarea value={editChapter.meaning_content || ''} onChange={(e) => setEditChapter({ ...editChapter, meaning_content: e.target.value })} rows={3} /></div>
                <div className="space-y-2"><Label>Use</Label><Textarea value={editChapter.use_content || ''} onChange={(e) => setEditChapter({ ...editChapter, use_content: e.target.value })} rows={3} /></div>
                <div className="space-y-2"><Label>Contrast Notes</Label><Textarea value={editChapter.contrast_notes || ''} onChange={(e) => setEditChapter({ ...editChapter, contrast_notes: e.target.value })} rows={2} /></div>
                <div className="space-y-2"><Label>Common Errors</Label><Textarea value={editChapter.common_errors || ''} onChange={(e) => setEditChapter({ ...editChapter, common_errors: e.target.value })} rows={2} /></div>
                <div className="flex justify-end gap-3">
                  <Button variant="outline" onClick={() => setDialogOpen(false)}>Cancel</Button>
                  <Button onClick={saveChapter} className="bg-gradient-primary hover:opacity-90">Save</Button>
                </div>
              </div>
            )}
          </DialogContent>
        </Dialog>
      </div>
    </AppLayout>
  );
}
