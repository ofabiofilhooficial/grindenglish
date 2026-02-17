import { useState, useEffect } from 'react';
import { AppLayout } from '@/components/layout/AppLayout';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Textarea } from '@/components/ui/textarea';
import { Badge } from '@/components/ui/badge';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from '@/components/ui/dialog';
import { Plus, Search, BookOpen, Pencil } from 'lucide-react';
import { supabase } from '@/integrations/supabase/client';
import { useToast } from '@/hooks/use-toast';

export default function LexiconManagerPage() {
  const { toast } = useToast();
  const [entries, setEntries] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [search, setSearch] = useState('');
  const [dialogOpen, setDialogOpen] = useState(false);
  const [editEntry, setEditEntry] = useState<any>(null);

  const emptyEntry = {
    headword: '', entry_type: 'lemma', pos: '', cefr_receptive: '', cefr_productive: '',
    ipa: '', definition_simple: '', definition_teacher: '', usage_notes: '',
    register: '', variety: 'international', frequency_band: '',
  };

  const fetchEntries = async () => {
    setLoading(true);
    const { data } = await supabase.from('lexicon_entries').select('*').order('headword');
    if (data) setEntries(data);
    setLoading(false);
  };

  useEffect(() => { fetchEntries(); }, []);

  const saveEntry = async () => {
    if (!editEntry?.headword?.trim()) return;
    const payload = { ...editEntry };
    delete payload.id;
    delete payload.created_at;
    delete payload.updated_at;

    if (editEntry.id) {
      const { error } = await supabase.from('lexicon_entries').update(payload).eq('id', editEntry.id);
      if (error) { toast({ title: 'Error', description: error.message, variant: 'destructive' }); return; }
    } else {
      const { error } = await supabase.from('lexicon_entries').insert(payload);
      if (error) { toast({ title: 'Error', description: error.message, variant: 'destructive' }); return; }
    }

    toast({ title: 'Saved' });
    setDialogOpen(false);
    setEditEntry(null);
    fetchEntries();
  };

  const filtered = entries.filter((e) =>
    e.headword.toLowerCase().includes(search.toLowerCase())
  );

  return (
    <AppLayout title="Lexicon Manager" subtitle="Manage course vocabulary">
      <div className="p-6 space-y-6">
        <div className="flex items-center justify-between">
          <div className="relative w-64">
            <Search className="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-muted-foreground" />
            <Input placeholder="Search entries..." value={search} onChange={(e) => setSearch(e.target.value)} className="pl-9" />
          </div>
          <Button onClick={() => { setEditEntry({ ...emptyEntry }); setDialogOpen(true); }} className="bg-gradient-primary hover:opacity-90">
            <Plus className="h-4 w-4 mr-2" />
            Add Entry
          </Button>
        </div>

        <Card>
          <CardContent className="pt-6">
            {loading ? (
              <div className="flex justify-center py-12"><div className="h-8 w-8 rounded-full border-2 border-primary border-t-transparent animate-spin" /></div>
            ) : filtered.length === 0 ? (
              <div className="text-center py-12">
                <BookOpen className="h-12 w-12 text-muted-foreground mx-auto mb-4" />
                <p className="text-muted-foreground">{search ? 'No matching entries.' : 'No vocabulary entries yet.'}</p>
              </div>
            ) : (
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>Headword</TableHead>
                    <TableHead>Type</TableHead>
                    <TableHead>POS</TableHead>
                    <TableHead>CEFR</TableHead>
                    <TableHead>Register</TableHead>
                    <TableHead></TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {filtered.map((entry) => (
                    <TableRow key={entry.id} className="cursor-pointer" onClick={() => { setEditEntry(entry); setDialogOpen(true); }}>
                      <TableCell className="font-medium">{entry.headword}</TableCell>
                      <TableCell><Badge variant="outline" className="text-xs">{entry.entry_type}</Badge></TableCell>
                      <TableCell className="text-muted-foreground">{entry.pos || '–'}</TableCell>
                      <TableCell className="text-muted-foreground">{entry.cefr_receptive || '–'}</TableCell>
                      <TableCell className="text-muted-foreground">{entry.register || '–'}</TableCell>
                      <TableCell><Pencil className="h-4 w-4 text-muted-foreground" /></TableCell>
                    </TableRow>
                  ))}
                </TableBody>
              </Table>
            )}
          </CardContent>
        </Card>

        <Dialog open={dialogOpen} onOpenChange={setDialogOpen}>
          <DialogContent className="max-w-2xl max-h-[80vh] overflow-y-auto">
            <DialogHeader>
              <DialogTitle>{editEntry?.id ? 'Edit Entry' : 'New Entry'}</DialogTitle>
            </DialogHeader>
            {editEntry && (
              <div className="space-y-4">
                <div className="grid grid-cols-2 gap-4">
                  <div className="space-y-2">
                    <Label>Headword</Label>
                    <Input value={editEntry.headword} onChange={(e) => setEditEntry({ ...editEntry, headword: e.target.value })} />
                  </div>
                  <div className="space-y-2">
                    <Label>Type</Label>
                    <Select value={editEntry.entry_type} onValueChange={(v) => setEditEntry({ ...editEntry, entry_type: v })}>
                      <SelectTrigger><SelectValue /></SelectTrigger>
                      <SelectContent>
                        {['lemma', 'phrase', 'collocation', 'discourse_marker', 'routine'].map((t) => (
                          <SelectItem key={t} value={t}>{t}</SelectItem>
                        ))}
                      </SelectContent>
                    </Select>
                  </div>
                  <div className="space-y-2">
                    <Label>Part of Speech</Label>
                    <Input value={editEntry.pos || ''} onChange={(e) => setEditEntry({ ...editEntry, pos: e.target.value })} placeholder="noun, verb, adj..." />
                  </div>
                  <div className="space-y-2">
                    <Label>IPA</Label>
                    <Input value={editEntry.ipa || ''} onChange={(e) => setEditEntry({ ...editEntry, ipa: e.target.value })} />
                  </div>
                  <div className="space-y-2">
                    <Label>CEFR Receptive</Label>
                    <Input value={editEntry.cefr_receptive || ''} onChange={(e) => setEditEntry({ ...editEntry, cefr_receptive: e.target.value })} placeholder="A1, A2, B1..." />
                  </div>
                  <div className="space-y-2">
                    <Label>CEFR Productive</Label>
                    <Input value={editEntry.cefr_productive || ''} onChange={(e) => setEditEntry({ ...editEntry, cefr_productive: e.target.value })} placeholder="A2, B1..." />
                  </div>
                </div>
                <div className="space-y-2">
                  <Label>Simple Definition</Label>
                  <Textarea value={editEntry.definition_simple || ''} onChange={(e) => setEditEntry({ ...editEntry, definition_simple: e.target.value })} rows={2} />
                </div>
                <div className="space-y-2">
                  <Label>Teacher Definition</Label>
                  <Textarea value={editEntry.definition_teacher || ''} onChange={(e) => setEditEntry({ ...editEntry, definition_teacher: e.target.value })} rows={2} />
                </div>
                <div className="space-y-2">
                  <Label>Usage Notes</Label>
                  <Textarea value={editEntry.usage_notes || ''} onChange={(e) => setEditEntry({ ...editEntry, usage_notes: e.target.value })} rows={2} />
                </div>
                <div className="grid grid-cols-3 gap-4">
                  <div className="space-y-2">
                    <Label>Register</Label>
                    <Input value={editEntry.register || ''} onChange={(e) => setEditEntry({ ...editEntry, register: e.target.value })} placeholder="formal, informal..." />
                  </div>
                  <div className="space-y-2">
                    <Label>Variety</Label>
                    <Select value={editEntry.variety || 'international'} onValueChange={(v) => setEditEntry({ ...editEntry, variety: v })}>
                      <SelectTrigger><SelectValue /></SelectTrigger>
                      <SelectContent>
                        <SelectItem value="international">International</SelectItem>
                        <SelectItem value="US">US</SelectItem>
                        <SelectItem value="UK">UK</SelectItem>
                      </SelectContent>
                    </Select>
                  </div>
                  <div className="space-y-2">
                    <Label>Frequency Band</Label>
                    <Input value={editEntry.frequency_band || ''} onChange={(e) => setEditEntry({ ...editEntry, frequency_band: e.target.value })} />
                  </div>
                </div>
                <div className="flex justify-end gap-3">
                  <Button variant="outline" onClick={() => setDialogOpen(false)}>Cancel</Button>
                  <Button onClick={saveEntry} className="bg-gradient-primary hover:opacity-90">Save</Button>
                </div>
              </div>
            )}
          </DialogContent>
        </Dialog>
      </div>
    </AppLayout>
  );
}
