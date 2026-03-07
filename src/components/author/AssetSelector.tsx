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
  lessonId?: string; // Optional: for lesson-level assets
  unitId?: string; // Optional: for unit-level assets
  stageId?: string; // Optional: if provided, assets are linked to this stage
  linkedAssets: LessonAsset[];
  onAssetsChange: () => void;
  compact?: boolean; // Optional: compact mode for inline display
}

export function AssetSelector({ lessonId, unitId, stageId, linkedAssets, onAssetsChange, compact = false }: AssetSelectorProps) {
  const { toast } = useToast();
  const [searchTerm, setSearchTerm] = useState('');
  const [grammarChapters, setGrammarChapters] = useState<any[]>([]);
  const [lexiconEntries, setLexiconEntries] = useState<any[]>([]);
  const [loading, setLoading] = useState(false);

  const tableName = unitId ? 'unit_assets' : 'lesson_assets';
  const idField = unitId ? 'unit_id' : 'lesson_id';
  const idValue = unitId || lessonId;

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
    if (!idValue) return;
    
    const insertData: any = {
      [idField]: idValue,
      asset_type: assetType,
      asset_id: assetId,
      is_required: isRequired,
      order_index: linkedAssets.length,
    };
    
    // Only add stage_id for lesson assets
    if (lessonId && stageId) {
      insertData.stage_id = stageId;
    }
    
    const { error } = await supabase.from(tableName as any).insert(insertData);

    if (error) {
      toast({
        title: 'Error',
        description: error.message,
        variant: 'destructive',
      });
    } else {
      const context = unitId ? 'unit' : stageId ? 'stage' : 'lesson';
      toast({ title: `Asset linked to ${context}` });
      onAssetsChange();
    }
  };

  const unlinkAsset = async (assetLinkId: string) => {
    const { error } = await supabase
      .from(tableName as any)
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
    <Card className={compact ? 'border-dashed' : ''}>
      <CardHeader className={compact ? 'p-3' : ''}>
        <CardTitle className={`font-display flex items-center gap-2 ${compact ? 'text-sm' : 'text-lg'}`}>
          <BookOpen className={compact ? 'h-4 w-4' : 'h-5 w-5'} />
          {compact ? 'Stage Resources' : 'Linked Reference Content'}
        </CardTitle>
        {!compact && (
          <p className="text-sm text-muted-foreground">
            Link grammar chapters and vocabulary that students should access during this lesson
          </p>
        )}
      </CardHeader>
      <CardContent className={compact ? 'p-3 pt-0' : ''}>
        {/* Currently Linked Assets */}
        {linkedAssets.length > 0 && (
          <div className="mb-4 space-y-2">
            <Label className="text-xs font-medium">Currently Linked</Label>
            <div className="space-y-1">
              {linkedAssets.map((asset) => (
                <div
                  key={asset.id}
                  className={`flex items-center justify-between bg-secondary/50 rounded-lg ${compact ? 'p-1.5' : 'p-2'}`}
                >
                  <div className="flex items-center gap-2">
                    {asset.assetType === 'grammar' ? (
                      <BookOpen className="h-3 w-3 text-primary" />
                    ) : (
                      <Languages className="h-3 w-3 text-accent" />
                    )}
                    <span className="text-xs font-medium">
                      {asset.assetType === 'grammar' ? 'Grammar' : 'Vocabulary'}
                    </span>
                  </div>
                  <Button
                    variant="ghost"
                    size="icon"
                    className="h-6 w-6"
                    onClick={() => unlinkAsset(asset.id)}
                  >
                    <X className="h-3 w-3" />
                  </Button>
                </div>
              ))}
            </div>
          </div>
        )}

        {/* Search */}
        <div className="relative mb-3">
          <Search className={`absolute left-3 top-1/2 -translate-y-1/2 text-muted-foreground ${compact ? 'h-3 w-3' : 'h-4 w-4'}`} />
          <Input
            placeholder="Search resources..."
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
            className={`pl-9 ${compact ? 'h-8 text-xs' : ''}`}
          />
        </div>

        {/* Asset Browser */}
        <Tabs defaultValue="grammar">
          <TabsList className={`grid w-full grid-cols-2 ${compact ? 'h-8' : ''}`}>
            <TabsTrigger value="grammar" className={compact ? 'text-xs py-1' : ''}>
              <BookOpen className={`mr-2 ${compact ? 'h-3 w-3' : 'h-4 w-4'}`} />
              Grammar
            </TabsTrigger>
            <TabsTrigger value="vocabulary" className={compact ? 'text-xs py-1' : ''}>
              <Languages className={`mr-2 ${compact ? 'h-3 w-3' : 'h-4 w-4'}`} />
              Vocabulary
            </TabsTrigger>
          </TabsList>

          <TabsContent value="grammar">
            <ScrollArea className={compact ? 'h-[200px] pr-2' : 'h-[300px] pr-4'}>
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
                        className={`flex items-center justify-between border border-border rounded-lg hover:bg-secondary/50 transition-colors ${compact ? 'p-2' : 'p-3'}`}
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
                          <p className={`font-medium truncate ${compact ? 'text-xs' : 'text-sm'}`}>
                            {chapter.title}
                          </p>
                        </div>
                        <Button
                          size={compact ? 'sm' : 'sm'}
                          variant={linked ? 'secondary' : 'default'}
                          onClick={() =>
                            linked
                              ? null
                              : linkAsset('grammar', chapter.id)
                          }
                          disabled={linked}
                          className={compact ? 'h-7 text-xs' : ''}
                        >
                          {linked ? (
                            'Linked'
                          ) : (
                            <>
                              <Plus className={`mr-1 ${compact ? 'h-3 w-3' : 'h-4 w-4'}`} />
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
            <ScrollArea className={compact ? 'h-[200px] pr-2' : 'h-[300px] pr-4'}>
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
                        className={`flex items-center justify-between border border-border rounded-lg hover:bg-secondary/50 transition-colors ${compact ? 'p-2' : 'p-3'}`}
                      >
                        <div className="flex-1 min-w-0">
                          <div className="flex items-center gap-2 mb-1">
                            <p className={`font-medium ${compact ? 'text-xs' : 'text-sm'}`}>{entry.headword}</p>
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
                          size={compact ? 'sm' : 'sm'}
                          variant={linked ? 'secondary' : 'default'}
                          onClick={() =>
                            linked
                              ? null
                              : linkAsset('vocabulary', entry.id)
                          }
                          disabled={linked}
                          className={compact ? 'h-7 text-xs' : ''}
                        >
                          {linked ? (
                            'Linked'
                          ) : (
                            <>
                              <Plus className={`mr-1 ${compact ? 'h-3 w-3' : 'h-4 w-4'}`} />
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
