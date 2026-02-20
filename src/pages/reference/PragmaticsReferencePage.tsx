import { useState, useEffect } from 'react';
import { AppLayout } from '@/components/layout/AppLayout';
import { Card, CardContent } from '@/components/ui/card';
import { Input } from '@/components/ui/input';
import { Badge } from '@/components/ui/badge';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Dialog, DialogContent, DialogHeader, DialogTitle } from '@/components/ui/dialog';
import { Search, MessageSquare } from 'lucide-react';
import { supabase } from '@/integrations/supabase/client';

export default function PragmaticsReferencePage() {
  const [packs, setPacks] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [search, setSearch] = useState('');
  const [levelFilter, setLevelFilter] = useState('all');
  const [selected, setSelected] = useState<any>(null);
  const [items, setItems] = useState<any[]>([]);

  useEffect(() => {
    const fetch = async () => {
      setLoading(true);
      const { data } = await supabase.from('pragmatics_packs').select('*').eq('is_published', true).order('created_at', { ascending: false });
      if (data) setPacks(data);
      setLoading(false);
    };
    fetch();
  }, []);

  const openPack = async (pack: any) => {
    setSelected(pack);
    const { data } = await supabase.from('pragmatics_items').select('*').eq('pack_id', pack.id).order('sort_order');
    if (data) setItems(data);
  };

  const filtered = packs.filter((p) => {
    const matchSearch = p.title.toLowerCase().includes(search.toLowerCase());
    const matchLevel = levelFilter === 'all' || p.cefr_level === levelFilter;
    return matchSearch && matchLevel;
  });

  return (
    <AppLayout title="Pragmatics" subtitle="Speech acts, register, and communication strategies">
      <div className="p-6 space-y-6">
        <div className="flex items-center gap-4">
          <div className="relative flex-1 max-w-sm">
            <Search className="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-muted-foreground" />
            <Input placeholder="Search packs..." value={search} onChange={(e) => setSearch(e.target.value)} className="pl-9" />
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
            <MessageSquare className="h-12 w-12 text-muted-foreground mx-auto mb-4" />
            <p className="text-muted-foreground">No pragmatics packs found.</p>
          </Card>
        ) : (
          <div className="grid gap-3 sm:grid-cols-2 lg:grid-cols-3">
            {filtered.map((p) => (
              <Card key={p.id} className="cursor-pointer hover:shadow-md transition-shadow" onClick={() => openPack(p)}>
                <CardContent className="p-4">
                  <div className="flex items-center gap-2 mb-2">
                    <Badge variant="outline">{p.cefr_level}</Badge>
                    <Badge variant="secondary" className="text-xs capitalize">{p.pack_type.replace(/_/g, ' ')}</Badge>
                  </div>
                  <p className="font-display font-semibold text-foreground">{p.title}</p>
                  {p.description && <p className="text-sm text-muted-foreground mt-1 line-clamp-2">{p.description}</p>}
                </CardContent>
              </Card>
            ))}
          </div>
        )}

        <Dialog open={!!selected} onOpenChange={() => { setSelected(null); setItems([]); }}>
          <DialogContent className="max-w-2xl max-h-[80vh] overflow-y-auto">
            {selected && (
              <>
                <DialogHeader>
                  <DialogTitle className="font-display">{selected.title}</DialogTitle>
                  <div className="flex gap-2 mt-1">
                    <Badge variant="outline">{selected.cefr_level}</Badge>
                    <Badge variant="secondary" className="capitalize text-xs">{selected.pack_type.replace(/_/g, ' ')}</Badge>
                  </div>
                  {selected.description && <p className="text-sm text-muted-foreground mt-2">{selected.description}</p>}
                </DialogHeader>
                <div className="space-y-3 mt-4">
                  {items.map((item) => (
                    <Card key={item.id} className="bg-muted/50">
                      <CardContent className="p-4">
                        <p className="font-medium text-sm text-foreground mb-2">{item.label}</p>
                        {item.content && typeof item.content === 'object' && (
                          <pre className="whitespace-pre-wrap text-xs text-muted-foreground bg-background rounded p-3">
                            {JSON.stringify(item.content, null, 2)}
                          </pre>
                        )}
                      </CardContent>
                    </Card>
                  ))}
                  {items.length === 0 && <p className="text-sm text-muted-foreground text-center py-4">No items in this pack yet.</p>}
                </div>
              </>
            )}
          </DialogContent>
        </Dialog>
      </div>
    </AppLayout>
  );
}
