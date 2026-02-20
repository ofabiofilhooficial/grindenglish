import { useState, useEffect } from 'react';
import { AppLayout } from '@/components/layout/AppLayout';
import { Card, CardContent } from '@/components/ui/card';
import { Input } from '@/components/ui/input';
import { Badge } from '@/components/ui/badge';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Dialog, DialogContent, DialogHeader, DialogTitle } from '@/components/ui/dialog';
import { Search, Headphones } from 'lucide-react';
import { supabase } from '@/integrations/supabase/client';
import { VoiceRecorder } from '@/components/ui/voice-recorder';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';

export default function PronunciationReferencePage() {
  const [scripts, setScripts] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [search, setSearch] = useState('');
  const [levelFilter, setLevelFilter] = useState('all');
  const [selected, setSelected] = useState<any>(null);

  useEffect(() => {
    const fetch = async () => {
      setLoading(true);
      const { data } = await supabase.from('pronunciation_scripts').select('*').eq('is_published', true).order('created_at', { ascending: false });
      if (data) setScripts(data);
      setLoading(false);
    };
    fetch();
  }, []);

  const filtered = scripts.filter((s) => {
    const matchSearch = s.title.toLowerCase().includes(search.toLowerCase());
    const matchLevel = levelFilter === 'all' || s.cefr_level === levelFilter;
    return matchSearch && matchLevel;
  });

  return (
    <AppLayout title="Pronunciation" subtitle="Shadowing scripts and drills">
      <div className="p-6 space-y-6">
        <div className="flex items-center gap-4">
          <div className="relative flex-1 max-w-sm">
            <Search className="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-muted-foreground" />
            <Input placeholder="Search scripts..." value={search} onChange={(e) => setSearch(e.target.value)} className="pl-9" />
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
            <Headphones className="h-12 w-12 text-muted-foreground mx-auto mb-4" />
            <p className="text-muted-foreground">No pronunciation scripts found.</p>
          </Card>
        ) : (
          <div className="space-y-2">
            {filtered.map((s) => (
              <Card key={s.id} className="cursor-pointer hover:shadow-md transition-shadow" onClick={() => setSelected(s)}>
                <CardContent className="p-4 flex items-center gap-4">
                  <Badge variant="outline">{s.cefr_level}</Badge>
                  <Badge variant="secondary" className="text-xs capitalize">{s.script_type.replace(/_/g, ' ')}</Badge>
                  <span className="font-medium flex-1 text-foreground">{s.title}</span>
                </CardContent>
              </Card>
            ))}
          </div>
        )}

        <Dialog open={!!selected} onOpenChange={() => setSelected(null)}>
          <DialogContent className="max-w-2xl max-h-[80vh] overflow-y-auto">
            {selected && (
              <>
                <DialogHeader>
                  <DialogTitle className="font-display">{selected.title}</DialogTitle>
                  <div className="flex gap-2 mt-1">
                    <Badge variant="outline">{selected.cefr_level}</Badge>
                    <Badge variant="secondary" className="capitalize text-xs">{selected.script_type.replace(/_/g, ' ')}</Badge>
                  </div>
                </DialogHeader>
                <Tabs defaultValue="text" className="mt-4">
                  <TabsList className="w-full">
                    <TabsTrigger value="text" className="flex-1">Text</TabsTrigger>
                    <TabsTrigger value="chunked" className="flex-1">Chunked</TabsTrigger>
                    <TabsTrigger value="stress" className="flex-1">Stress</TabsTrigger>
                  </TabsList>
                  <TabsContent value="text" className="mt-4">
                    <pre className="whitespace-pre-wrap text-sm text-foreground bg-muted rounded-lg p-4">{selected.text_content || 'No text content.'}</pre>
                  </TabsContent>
                  <TabsContent value="chunked" className="mt-4">
                    <pre className="whitespace-pre-wrap text-sm text-foreground bg-muted rounded-lg p-4">{selected.chunked_content || 'No chunked version.'}</pre>
                  </TabsContent>
                  <TabsContent value="stress" className="mt-4">
                    <pre className="whitespace-pre-wrap text-sm text-foreground bg-muted rounded-lg p-4">{selected.stress_marked_content || 'No stress-marked version.'}</pre>
                  </TabsContent>
                </Tabs>
                {selected.speed_plan && (
                  <div className="mt-4">
                    <p className="text-sm font-medium text-foreground mb-2">Speed Plan</p>
                    <pre className="whitespace-pre-wrap text-sm text-muted-foreground bg-muted rounded-lg p-4">{selected.speed_plan}</pre>
                  </div>
                )}
                <div className="mt-4">
                  <p className="text-sm font-medium text-foreground mb-2">Practice Recording</p>
                  <VoiceRecorder label="Shadow the script above" maxDuration={30} />
                </div>
              </>
            )}
          </DialogContent>
        </Dialog>
      </div>
    </AppLayout>
  );
}
