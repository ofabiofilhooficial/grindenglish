import { useState, useEffect } from 'react';
import { AppLayout } from '@/components/layout/AppLayout';
import { Card, CardContent } from '@/components/ui/card';
import { Input } from '@/components/ui/input';
import { Badge } from '@/components/ui/badge';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Dialog, DialogContent, DialogHeader, DialogTitle } from '@/components/ui/dialog';
import { Search, Languages, AlertTriangle } from 'lucide-react';
import { supabase } from '@/integrations/supabase/client';
import { Separator } from '@/components/ui/separator';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { usePageViewTracker, useActivityTracker } from '@/hooks/useActivityTracker';

export default function GrammarReferencePage() {
  const [chapters, setChapters] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [search, setSearch] = useState('');
  const [levelFilter, setLevelFilter] = useState('all');
  const [selected, setSelected] = useState<any>(null);
  const { logActivity } = useActivityTracker();

  // Track page view
  usePageViewTracker('grammar_view');

  // Track when a chapter is opened
  const handleChapterClick = (chapter: any) => {
    setSelected(chapter);
    logActivity('grammar_view', { 
      chapter_id: chapter.id, 
      chapter_code: chapter.chapter_code,
      chapter_title: chapter.title 
    });
  };

  useEffect(() => {
    const fetch = async () => {
      setLoading(true);
      const { data } = await supabase.from('grammar_chapters').select('*').eq('is_published', true).order('sort_order');
      if (data) setChapters(data);
      setLoading(false);
    };
    fetch();
  }, []);

  const filtered = chapters.filter((c) => {
    const matchSearch = c.title.toLowerCase().includes(search.toLowerCase());
    const matchLevel = levelFilter === 'all' || c.cefr_level === levelFilter;
    return matchSearch && matchLevel;
  });

  return (
    <AppLayout title="Grammar" subtitle="Browse grammar chapters">
      <div className="p-6 space-y-6">
        <div className="flex items-center gap-4">
          <div className="relative flex-1 max-w-sm">
            <Search className="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-muted-foreground" />
            <Input placeholder="Search grammar..." value={search} onChange={(e) => setSearch(e.target.value)} className="pl-9" />
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
            <Languages className="h-12 w-12 text-muted-foreground mx-auto mb-4" />
            <p className="text-muted-foreground">No grammar chapters found.</p>
          </Card>
        ) : (
          <div className="space-y-2">
            {filtered.map((c) => (
              <Card key={c.id} className="cursor-pointer hover:shadow-md transition-shadow" onClick={() => handleChapterClick(c)}>
                <CardContent className="p-4 flex items-center gap-4">
                  <Badge variant="outline">{c.cefr_level}</Badge>
                  <Badge variant="secondary" className="text-xs font-mono">{c.chapter_code}</Badge>
                  <span className="font-medium flex-1 text-foreground">{c.title}</span>
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
                    <Badge variant="secondary" className="font-mono text-xs">{selected.chapter_code}</Badge>
                  </div>
                </DialogHeader>
                <Tabs defaultValue="form" className="mt-4">
                  <TabsList className="w-full">
                    <TabsTrigger value="form" className="flex-1">Form</TabsTrigger>
                    <TabsTrigger value="meaning" className="flex-1">Meaning</TabsTrigger>
                    <TabsTrigger value="use" className="flex-1">Use</TabsTrigger>
                  </TabsList>
                  <TabsContent value="form" className="mt-4">
                    <pre className="whitespace-pre-wrap text-sm text-foreground bg-muted rounded-lg p-4">{selected.form_content || 'No content yet.'}</pre>
                  </TabsContent>
                  <TabsContent value="meaning" className="mt-4">
                    <p className="text-sm text-foreground whitespace-pre-wrap">{selected.meaning_content || 'No content yet.'}</p>
                  </TabsContent>
                  <TabsContent value="use" className="mt-4">
                    <p className="text-sm text-foreground whitespace-pre-wrap">{selected.use_content || 'No content yet.'}</p>
                  </TabsContent>
                </Tabs>
                {selected.common_errors && (
                  <>
                    <Separator className="my-4" />
                    <div>
                      <p className="text-sm font-medium text-foreground flex items-center gap-2 mb-2">
                        <AlertTriangle className="h-4 w-4 text-warning" /> Common Errors
                      </p>
                      <pre className="whitespace-pre-wrap text-sm text-destructive/80 bg-destructive/5 rounded-lg p-4">{selected.common_errors}</pre>
                    </div>
                  </>
                )}
                {selected.contrast_notes && (
                  <div className="mt-4">
                    <p className="text-sm font-medium text-foreground mb-2">L1 Contrast (Portuguese)</p>
                    <pre className="whitespace-pre-wrap text-sm text-muted-foreground bg-muted rounded-lg p-4">{selected.contrast_notes}</pre>
                  </div>
                )}
              </>
            )}
          </DialogContent>
        </Dialog>
      </div>
    </AppLayout>
  );
}
