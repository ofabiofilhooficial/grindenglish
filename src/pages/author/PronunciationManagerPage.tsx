import { useState, useEffect } from 'react';
import { AppLayout } from '@/components/layout/AppLayout';
import { Card, CardContent } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Textarea } from '@/components/ui/textarea';
import { Badge } from '@/components/ui/badge';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Dialog, DialogContent, DialogHeader, DialogTitle } from '@/components/ui/dialog';
import { Plus, Search, Headphones } from 'lucide-react';
import { supabase } from '@/integrations/supabase/client';
import { useToast } from '@/hooks/use-toast';

export default function PronunciationManagerPage() {
  const { toast } = useToast();
  const [scripts, setScripts] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [search, setSearch] = useState('');
  const [dialogOpen, setDialogOpen] = useState(false);
  const [editScript, setEditScript] = useState<any>(null);

  const emptyScript = {
    title: '', script_type: 'micro_shadow', text_content: '', chunked_content: '',
    stress_marked_content: '', speed_plan: '', cefr_level: 'A0',
  };

  const fetchScripts = async () => {
    setLoading(true);
    const { data } = await supabase.from('pronunciation_scripts').select('*').order('created_at', { ascending: false });
    if (data) setScripts(data);
    setLoading(false);
  };

  useEffect(() => { fetchScripts(); }, []);

  const saveScript = async () => {
    if (!editScript?.title?.trim()) return;
    const payload = { ...editScript };
    delete payload.id; delete payload.created_at; delete payload.updated_at;

    if (editScript.id) {
      const { error } = await supabase.from('pronunciation_scripts').update(payload).eq('id', editScript.id);
      if (error) { toast({ title: 'Error', description: error.message, variant: 'destructive' }); return; }
    } else {
      const { error } = await supabase.from('pronunciation_scripts').insert(payload);
      if (error) { toast({ title: 'Error', description: error.message, variant: 'destructive' }); return; }
    }

    toast({ title: 'Saved' });
    setDialogOpen(false);
    fetchScripts();
  };

  const filtered = scripts.filter((s) => s.title.toLowerCase().includes(search.toLowerCase()));

  return (
    <AppLayout title="Pronunciation Lab" subtitle="Manage shadowing scripts and audio resources">
      <div className="p-6 space-y-6">
        <div className="flex items-center justify-between">
          <div className="relative w-64">
            <Search className="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-muted-foreground" />
            <Input placeholder="Search scripts..." value={search} onChange={(e) => setSearch(e.target.value)} className="pl-9" />
          </div>
          <Button onClick={() => { setEditScript({ ...emptyScript }); setDialogOpen(true); }} className="bg-gradient-primary hover:opacity-90">
            <Plus className="h-4 w-4 mr-2" /> Add Script
          </Button>
        </div>

        {loading ? (
          <div className="flex justify-center py-12"><div className="h-8 w-8 rounded-full border-2 border-primary border-t-transparent animate-spin" /></div>
        ) : filtered.length === 0 ? (
          <Card className="p-12 text-center">
            <Headphones className="h-12 w-12 text-muted-foreground mx-auto mb-4" />
            <p className="text-muted-foreground">No pronunciation scripts yet.</p>
          </Card>
        ) : (
          <div className="space-y-2">
            {filtered.map((s) => (
              <Card key={s.id} className="cursor-pointer hover:shadow-md transition-shadow" onClick={() => { setEditScript(s); setDialogOpen(true); }}>
                <CardContent className="p-4 flex items-center gap-4">
                  <Badge variant="outline">{s.cefr_level}</Badge>
                  <Badge variant="secondary" className="text-xs capitalize">{s.script_type.replace(/_/g, ' ')}</Badge>
                  <span className="font-medium flex-1">{s.title}</span>
                </CardContent>
              </Card>
            ))}
          </div>
        )}

        <Dialog open={dialogOpen} onOpenChange={setDialogOpen}>
          <DialogContent className="max-w-2xl max-h-[80vh] overflow-y-auto">
            <DialogHeader><DialogTitle>{editScript?.id ? 'Edit Script' : 'New Script'}</DialogTitle></DialogHeader>
            {editScript && (
              <div className="space-y-4">
                <div className="grid grid-cols-3 gap-4">
                  <div className="space-y-2"><Label>Title</Label><Input value={editScript.title} onChange={(e) => setEditScript({ ...editScript, title: e.target.value })} /></div>
                  <div className="space-y-2">
                    <Label>Type</Label>
                    <Select value={editScript.script_type} onValueChange={(v) => setEditScript({ ...editScript, script_type: v })}>
                      <SelectTrigger><SelectValue /></SelectTrigger>
                      <SelectContent>
                        {['micro_shadow', 'chunk', 'dialogue', 'monologue'].map((t) => (<SelectItem key={t} value={t}>{t.replace(/_/g, ' ')}</SelectItem>))}
                      </SelectContent>
                    </Select>
                  </div>
                  <div className="space-y-2"><Label>CEFR Level</Label><Input value={editScript.cefr_level || ''} onChange={(e) => setEditScript({ ...editScript, cefr_level: e.target.value })} /></div>
                </div>
                <div className="space-y-2"><Label>Text</Label><Textarea value={editScript.text_content || ''} onChange={(e) => setEditScript({ ...editScript, text_content: e.target.value })} rows={4} /></div>
                <div className="space-y-2"><Label>Chunked Version</Label><Textarea value={editScript.chunked_content || ''} onChange={(e) => setEditScript({ ...editScript, chunked_content: e.target.value })} rows={3} /></div>
                <div className="space-y-2"><Label>Stress-Marked Version</Label><Textarea value={editScript.stress_marked_content || ''} onChange={(e) => setEditScript({ ...editScript, stress_marked_content: e.target.value })} rows={3} /></div>
                <div className="space-y-2"><Label>Speed Plan</Label><Textarea value={editScript.speed_plan || ''} onChange={(e) => setEditScript({ ...editScript, speed_plan: e.target.value })} rows={2} /></div>
                <div className="flex justify-end gap-3">
                  <Button variant="outline" onClick={() => setDialogOpen(false)}>Cancel</Button>
                  <Button onClick={saveScript} className="bg-gradient-primary hover:opacity-90">Save</Button>
                </div>
              </div>
            )}
          </DialogContent>
        </Dialog>
      </div>
    </AppLayout>
  );
}
