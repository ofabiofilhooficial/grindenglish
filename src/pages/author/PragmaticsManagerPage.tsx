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
import { Plus, Search, MessageSquare } from 'lucide-react';
import { supabase } from '@/integrations/supabase/client';
import { useToast } from '@/hooks/use-toast';

export default function PragmaticsManagerPage() {
  const { toast } = useToast();
  const [packs, setPacks] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [search, setSearch] = useState('');
  const [dialogOpen, setDialogOpen] = useState(false);
  const [editPack, setEditPack] = useState<any>(null);

  const emptyPack = { title: '', pack_type: 'speech_act', description: '', cefr_level: 'A0' };

  const fetchPacks = async () => {
    setLoading(true);
    const { data } = await supabase.from('pragmatics_packs').select('*').order('created_at', { ascending: false });
    if (data) setPacks(data);
    setLoading(false);
  };

  useEffect(() => { fetchPacks(); }, []);

  const savePack = async () => {
    if (!editPack?.title?.trim()) return;
    const payload = { ...editPack };
    delete payload.id; delete payload.created_at; delete payload.updated_at;

    if (editPack.id) {
      const { error } = await supabase.from('pragmatics_packs').update(payload).eq('id', editPack.id);
      if (error) { toast({ title: 'Error', description: error.message, variant: 'destructive' }); return; }
    } else {
      const { error } = await supabase.from('pragmatics_packs').insert(payload);
      if (error) { toast({ title: 'Error', description: error.message, variant: 'destructive' }); return; }
    }

    toast({ title: 'Saved' });
    setDialogOpen(false);
    fetchPacks();
  };

  const filtered = packs.filter((p) => p.title.toLowerCase().includes(search.toLowerCase()));

  return (
    <AppLayout title="Pragmatics Lab" subtitle="Manage speech act packs and case studies">
      <div className="p-6 space-y-6">
        <div className="flex items-center justify-between">
          <div className="relative w-64">
            <Search className="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-muted-foreground" />
            <Input placeholder="Search packs..." value={search} onChange={(e) => setSearch(e.target.value)} className="pl-9" />
          </div>
          <Button onClick={() => { setEditPack({ ...emptyPack }); setDialogOpen(true); }} className="bg-gradient-primary hover:opacity-90">
            <Plus className="h-4 w-4 mr-2" /> Add Pack
          </Button>
        </div>

        {loading ? (
          <div className="flex justify-center py-12"><div className="h-8 w-8 rounded-full border-2 border-primary border-t-transparent animate-spin" /></div>
        ) : filtered.length === 0 ? (
          <Card className="p-12 text-center">
            <MessageSquare className="h-12 w-12 text-muted-foreground mx-auto mb-4" />
            <p className="text-muted-foreground">No pragmatics packs yet.</p>
          </Card>
        ) : (
          <div className="space-y-2">
            {filtered.map((p) => (
              <Card key={p.id} className="cursor-pointer hover:shadow-md transition-shadow" onClick={() => { setEditPack(p); setDialogOpen(true); }}>
                <CardContent className="p-4 flex items-center gap-4">
                  <Badge variant="outline">{p.cefr_level}</Badge>
                  <Badge variant="secondary" className="text-xs capitalize">{p.pack_type.replace(/_/g, ' ')}</Badge>
                  <span className="font-medium flex-1">{p.title}</span>
                </CardContent>
              </Card>
            ))}
          </div>
        )}

        <Dialog open={dialogOpen} onOpenChange={setDialogOpen}>
          <DialogContent className="max-w-lg">
            <DialogHeader><DialogTitle>{editPack?.id ? 'Edit Pack' : 'New Pack'}</DialogTitle></DialogHeader>
            {editPack && (
              <div className="space-y-4">
                <div className="space-y-2"><Label>Title</Label><Input value={editPack.title} onChange={(e) => setEditPack({ ...editPack, title: e.target.value })} /></div>
                <div className="grid grid-cols-2 gap-4">
                  <div className="space-y-2">
                    <Label>Type</Label>
                    <Select value={editPack.pack_type} onValueChange={(v) => setEditPack({ ...editPack, pack_type: v })}>
                      <SelectTrigger><SelectValue /></SelectTrigger>
                      <SelectContent>
                        {['speech_act', 'register_ladder', 'medium_guide', 'case_study'].map((t) => (<SelectItem key={t} value={t}>{t.replace(/_/g, ' ')}</SelectItem>))}
                      </SelectContent>
                    </Select>
                  </div>
                  <div className="space-y-2"><Label>CEFR Level</Label><Input value={editPack.cefr_level || ''} onChange={(e) => setEditPack({ ...editPack, cefr_level: e.target.value })} /></div>
                </div>
                <div className="space-y-2"><Label>Description</Label><Textarea value={editPack.description || ''} onChange={(e) => setEditPack({ ...editPack, description: e.target.value })} rows={3} /></div>
                <div className="flex justify-end gap-3">
                  <Button variant="outline" onClick={() => setDialogOpen(false)}>Cancel</Button>
                  <Button onClick={savePack} className="bg-gradient-primary hover:opacity-90">Save</Button>
                </div>
              </div>
            )}
          </DialogContent>
        </Dialog>
      </div>
    </AppLayout>
  );
}
