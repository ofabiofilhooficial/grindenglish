import { useState, useEffect } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Badge } from '@/components/ui/badge';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { Checkbox } from '@/components/ui/checkbox';
import { Label } from '@/components/ui/label';
import { ScrollArea } from '@/components/ui/scroll-area';
import { Search, Plus, X, BookOpen, Languages, Mic, MessageSquare } from 'lucide-react';
import { supabase } from '@/integrations/supabase/client';
import { useToast } from '@/hooks/use-toast';
import { LessonAsset } from '@/types/course';

interface AssetSelectorProps {
  lessonId: string;
  linkedAssets: LessonAsset[];
  onAssetsChange: () => void;
}

export function AssetSelector({ lessonId, linkedAssets, onAssetsChange }: AssetSelectorProps) {
  const { toast } = useToast();
  const [searchTerm, setSearchTerm] = useState('');
  const [grammarChapters, setGrammarChapters] = useState<any[]>([]);
  const [lexiconEntries, setLexiconEntries] = useState<any[]>([]);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    fetchAssets();
  }, []);

  const fetchAssets = async () => {
    setLoading(true);
    const [grammarRes, lexiconRes] = await Promise.all([
      supabase
        .from('grammar_chapters')
        .select('*')
        .eq('is_published', true)
        .order('sort_order'),
      supabase
        .from('lexicon_entries')
        .select('*')
        .eq('is_published', true)
        .order('headword'),
    ]);

    if (grammarRes.data) setGrammarChapters(grammarRes.data);
    if (lexiconRes.data) setLexiconEntries(lexiconRes.data);
    setLoading(false);
  };

  const isLinked = (assetType: string, assetId: string) => {
    return linkedAssets.some(
      (a) => a.assetType === assetType && a.assetId === assetId
    );
  };

  const linkAsset = async (
    assetType: 'grammar' | 'vocabulary',
    assetId: string,
    isRequired: boolean = true
  ) => {
    const { error } = await supabase.from('lesson_assets' as any).insert({
      lesson_id: lessonId,
      asset_type: assetType,
      asset_id: assetId,
      is_required: isRequired,
      order_index: linkedAssets.length,
    });

    if (error) {
      toast({
        title: 'Error',
        description: error.message,
        variant: 'destructive',
      });
    } else {
      toast({ title: 'Asset linked successfully' });
      onAssetsChange();
    }
  };

  const unlinkAsset = async (assetLinkId: string) => {
    const { error } = await supabase
      .from('lesson_assets' as any)
      .delete()
      .eq('id', assetLinkId);

    if (error) {
      toast({
        title: 'Error',
        description: error.message,
        variant: 'destructive',
      });
    } else {
      toast({ title: 'Asset unlinked' });
      onAssetsChange();
    }
  };

  const filteredGrammar = grammarChapters.filter(
    (g) =>
      g.title.toLowerCase().includes(searchTerm.toLowerCase()) ||
      g.chapter_code.toLowerCase().includes(searchTerm.toLowerCase())
  );

  const filteredLexicon = lexiconEntries.filter((l) =>
    l.headword.toLowerCase().includes(searchTerm.toLowerCase())
  );

  return (
    <Card>
      <CardHeader>
        <CardTitle className="font-display text-lg flex items-center gap-2">
          <BookOpen className="h-5 w-5" />
          Linked Reference Content
        </CardTitle>
        <p className="text-sm text-muted-foreground">
          Link grammar chapters and vocabulary that students should access during this lesson
        </p>
      </CardHeader>
      <CardContent>
        {/* Currently Linked Assets */}
        {linkedAssets.length > 0 && (
          <div className="mb-4 space-y-2">
            <Label className="text-sm font-medium">Currently Linked</Label>
            <div className="space-y-2">
              {linkedAssets.map((asset) => (
                <div
                  key={asset.id}
                  className="flex items-center justify-between p-2 bg-secondary/50 rounded-lg"
                >
                  <div className="flex items-center gap-2">
                    {asset.assetType === 'grammar' ? (
                      <BookOpen className="h-4 w-4 text-primary" />
                    ) : (
                      <Languages className="h-4 w-4 text-accent" />
                    )}
                    <span className="text-sm font-medium">
                      {asset.assetType === 'grammar' ? 'Grammar' : 'Vocabulary'}
                    </span>
                    <Badge variant={asset.isRequired ? 'default' : 'secondary'} className="text-xs">
                      {asset.isRequired ? 'Required' : 'Optional'}
                    </Badge>
                  </div>
                  <Button
                    variant="ghost"
                    size="icon"
                    onClick={() => unlinkAsset(asset.id)}
                  >
                    <X className="h-4 w-4" />
                  </Button>
                </div>
              ))}
            </div>
          </div>
        )}

        {/* Search */}
        <div className="relative mb-4">
          <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
          <Input
            placeholder="Search grammar chapters or vocabulary..."
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
            className="pl-9"
          />
        </div>

        {/* Asset Browser */}
        <Tabs defaultValue="grammar">
          <TabsList className="grid w-full grid-cols-2">
            <TabsTrigger value="grammar">
              <BookOpen className="h-4 w-4 mr-2" />
              Grammar
            </TabsTrigger>
            <TabsTrigger value="vocabulary">
              <Languages className="h-4 w-4 mr-2" />
              Vocabulary
            </TabsTrigger>
          </TabsList>

          <TabsContent value="grammar">
            <ScrollArea className="h-[300px] pr-4">
              {loading ? (
                <div className="flex justify-center py-8">
                  <div className="h-6 w-6 rounded-full border-2 border-primary border-t-transparent animate-spin" />
                </div>
              ) : filteredGrammar.length === 0 ? (
                <p className="text-center text-muted-foreground py-8">
                  No grammar chapters found
                </p>
              ) : (
                <div className="space-y-2">
                  {filteredGrammar.map((chapter) => {
                    const linked = isLinked('grammar', chapter.id);
                    return (
                      <div
                        key={chapter.id}
                        className="flex items-center justify-between p-3 border border-border rounded-lg hover:bg-secondary/50 transition-colors"
                      >
                        <div className="flex-1 min-w-0">
                          <div className="flex items-center gap-2 mb-1">
                            <Badge variant="outline" className="text-xs">
                              {chapter.chapter_code}
                            </Badge>
                            <Badge variant="secondary" className="text-xs">
                              {chapter.cefr_level}
                            </Badge>
                          </div>
                          <p className="text-sm font-medium truncate">
                            {chapter.title}
                          </p>
                        </div>
                        <Button
                          size="sm"
                          variant={linked ? 'secondary' : 'default'}
                          onClick={() =>
                            linked
                              ? null
                              : linkAsset('grammar', chapter.id)
                          }
                          disabled={linked}
                        >
                          {linked ? (
                            'Linked'
                          ) : (
                            <>
                              <Plus className="h-4 w-4 mr-1" />
                              Link
                            </>
                          )}
                        </Button>
                      </div>
                    );
                  })}
                </div>
              )}
            </ScrollArea>
          </TabsContent>

          <TabsContent value="vocabulary">
            <ScrollArea className="h-[300px] pr-4">
              {loading ? (
                <div className="flex justify-center py-8">
                  <div className="h-6 w-6 rounded-full border-2 border-primary border-t-transparent animate-spin" />
                </div>
              ) : filteredLexicon.length === 0 ? (
                <p className="text-center text-muted-foreground py-8">
                  No vocabulary entries found
                </p>
              ) : (
                <div className="space-y-2">
                  {filteredLexicon.map((entry) => {
                    const linked = isLinked('vocabulary', entry.id);
                    return (
                      <div
                        key={entry.id}
                        className="flex items-center justify-between p-3 border border-border rounded-lg hover:bg-secondary/50 transition-colors"
                      >
                        <div className="flex-1 min-w-0">
                          <div className="flex items-center gap-2 mb-1">
                            <p className="text-sm font-medium">{entry.headword}</p>
                            {entry.pos && (
                              <Badge variant="outline" className="text-xs">
                                {entry.pos}
                              </Badge>
                            )}
                          </div>
                          <p className="text-xs text-muted-foreground truncate">
                            {entry.definition_simple}
                          </p>
                        </div>
                        <Button
                          size="sm"
                          variant={linked ? 'secondary' : 'default'}
                          onClick={() =>
                            linked
                              ? null
                              : linkAsset('vocabulary', entry.id)
                          }
                          disabled={linked}
                        >
                          {linked ? (
                            'Linked'
                          ) : (
                            <>
                              <Plus className="h-4 w-4 mr-1" />
                              Link
                            </>
                          )}
                        </Button>
                      </div>
                    );
                  })}
                </div>
              )}
            </ScrollArea>
          </TabsContent>
        </Tabs>
      </CardContent>
    </Card>
  );
}
