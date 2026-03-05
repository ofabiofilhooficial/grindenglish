import { useState, useEffect } from 'react';
import { AppLayout } from '@/components/layout/AppLayout';
import { Card, CardContent } from '@/components/ui/card';
import { Input } from '@/components/ui/input';
import { Badge } from '@/components/ui/badge';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Dialog, DialogContent, DialogHeader, DialogTitle } from '@/components/ui/dialog';
import { Search, BookOpen, Volume2 } from 'lucide-react';
import { supabase } from '@/integrations/supabase/client';
import { usePageViewTracker, useActivityTracker } from '@/hooks/useActivityTracker';

export default function VocabularyReferencePage() {
  const [entries, setEntries] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [search, setSearch] = useState('');
  const [levelFilter, setLevelFilter] = useState('all');
  const [selected, setSelected] = useState<any>(null);
  const { logActivity } = useActivityTracker();

  // Track page view
  usePageViewTracker('vocab_view');

  // Track when a word is opened
  const handleWordClick = (entry: any) => {
    setSelected(entry);
    logActivity('vocab_view', { 
      entry_id: entry.id, 
      headword: entry.headword,
      cefr_level: entry.cefr_receptive || entry.cefr_productive 
    });
  };

  useEffect(() => {
    const fetch = async () => {
      setLoading(true);
      const { data } = await supabase.from('lexicon_entries').select('*').eq('is_published', true).order('headword');
      if (data) setEntries(data);
      setLoading(false);
    };
    fetch();
  }, []);

  const filtered = entries.filter((e) => {
    const matchSearch = e.headword.toLowerCase().includes(search.toLowerCase());
    const matchLevel = levelFilter === 'all' || e.cefr_receptive === levelFilter || e.cefr_productive === levelFilter;
    return matchSearch && matchLevel;
  });

  return (
    <AppLayout title="Vocabulary" subtitle="Browse the course lexicon">
      <div className="p-6 space-y-6">
        <div className="flex items-center gap-4">
          <div className="relative flex-1 max-w-sm">
            <Search className="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-muted-foreground" />
            <Input placeholder="Search words..." value={search} onChange={(e) => setSearch(e.target.value)} className="pl-9" />
          </div>
          <Select value={levelFilter} onValueChange={setLevelFilter}>
            <SelectTrigger className="w-32"><SelectValue placeholder="Level" /></SelectTrigger>
            <SelectContent>
              <SelectItem value="all">All Levels</SelectItem>
              {['A0','A1','A2','B1','B2','C1','C2'].map((l) => <SelectItem key={l} value={l}>{l}</SelectItem>)}
            </SelectContent>
          </Select>
        </div>

        {loading ? (
          <div className="flex justify-center py-12"><div className="h-8 w-8 rounded-full border-2 border-primary border-t-transparent animate-spin" /></div>
        ) : filtered.length === 0 ? (
          <Card className="p-12 text-center">
            <BookOpen className="h-12 w-12 text-muted-foreground mx-auto mb-4" />
            <p className="text-muted-foreground">No vocabulary entries found.</p>
          </Card>
        ) : (
          <div className="grid gap-2 sm:grid-cols-2 lg:grid-cols-3">
            {filtered.map((e) => (
              <Card key={e.id} className="cursor-pointer hover:shadow-md transition-shadow" onClick={() => handleWordClick(e)}>
                <CardContent className="p-4">
                  <div className="flex items-start justify-between">
                    <div>
                      <p className="font-display font-semibold text-foreground">{e.headword}</p>
                      {e.ipa && <p className="text-xs text-muted-foreground font-mono">{e.ipa}</p>}
                    </div>
                    <Badge variant="outline" className="text-xs">{e.cefr_receptive || e.cefr_productive}</Badge>
                  </div>
                  <p className="text-sm text-muted-foreground mt-1 line-clamp-2">{e.definition_simple}</p>
                  {e.pos && <Badge variant="secondary" className="text-xs mt-2">{e.pos}</Badge>}
                </CardContent>
              </Card>
            ))}
          </div>
        )}

        <Dialog open={!!selected} onOpenChange={() => setSelected(null)}>
          <DialogContent className="max-w-lg">
            {selected && (
              <>
                <DialogHeader>
                  <DialogTitle className="font-display flex items-center gap-2">
                    {selected.headword}
                    {selected.ipa && <span className="text-sm font-mono text-muted-foreground font-normal">{selected.ipa}</span>}
                  </DialogTitle>
                </DialogHeader>
                <div className="space-y-4">
                  <div className="flex gap-2 flex-wrap">
                    {selected.pos && <Badge variant="secondary">{selected.pos}</Badge>}
                    {selected.register && <Badge variant="outline">{selected.register}</Badge>}
                    {selected.cefr_receptive && <Badge className="bg-gradient-primary text-primary-foreground">{selected.cefr_receptive}</Badge>}
                  </div>
                  {selected.definition_simple && <div><p className="text-sm font-medium text-foreground">Definition</p><p className="text-sm text-muted-foreground">{selected.definition_simple}</p></div>}
                  {selected.definition_teacher && <div><p className="text-sm font-medium text-foreground">Teacher's Note</p><p className="text-sm text-muted-foreground">{selected.definition_teacher}</p></div>}
                  {selected.examples && Array.isArray(selected.examples) && selected.examples.length > 0 && (
                    <div>
                      <p className="text-sm font-medium text-foreground mb-1">Examples</p>
                      <ul className="space-y-1">{selected.examples.map((ex: string, i: number) => <li key={i} className="text-sm text-muted-foreground italic">"{ex}"</li>)}</ul>
                    </div>
                  )}
                  {selected.collocations && Array.isArray(selected.collocations) && selected.collocations.length > 0 && (
                    <div>
                      <p className="text-sm font-medium text-foreground mb-1">Collocations</p>
                      <div className="flex gap-1 flex-wrap">{selected.collocations.map((c: string, i: number) => <Badge key={i} variant="outline" className="text-xs">{c}</Badge>)}</div>
                    </div>
                  )}
                </div>
              </>
            )}
          </DialogContent>
        </Dialog>
      </div>
    </AppLayout>
  );
}
