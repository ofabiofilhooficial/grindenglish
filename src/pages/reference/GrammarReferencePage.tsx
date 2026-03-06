import { useState, useEffect } from 'react';
import { AppLayout } from '@/components/layout/AppLayout';
import { Card, CardContent } from '@/components/ui/card';
import { Input } from '@/components/ui/input';
import { Badge } from '@/components/ui/badge';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Search, Languages } from 'lucide-react';
import { supabase } from '@/integrations/supabase/client';
import { usePageViewTracker, useActivityTracker } from '@/hooks/useActivityTracker';
import { GrammarPlaybookDrawer } from '@/components/grammar/GrammarPlaybookDrawer';

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

        <GrammarPlaybookDrawer
          chapter={selected}
          open={!!selected}
          onOpenChange={(open) => !open && setSelected(null)}
        />
      </div>
    </AppLayout>
  );
}
