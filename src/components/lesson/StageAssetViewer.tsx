import { useState, useEffect } from 'react';
import { Card, CardContent } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import { BookOpen, Languages, ChevronDown, ChevronUp, CheckCircle2 } from 'lucide-react';
import { supabase } from '@/integrations/supabase/client';
import { useActivityTracker } from '@/hooks/useActivityTracker';
import { cn } from '@/lib/utils';

interface StageAssetViewerProps {
  lessonId: string;
  stageId: string;
  onAssetViewed?: (assetId: string) => void;
}

export function StageAssetViewer({ lessonId, stageId, onAssetViewed }: StageAssetViewerProps) {
  const { trackAssetView } = useActivityTracker();
  const [assets, setAssets] = useState<any[]>([]);
  const [expandedAsset, setExpandedAsset] = useState<string | null>(null);
  const [viewedAssets, setViewedAssets] = useState<Set<string>>(new Set());
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchStageAssets();
  }, [lessonId, stageId]);

  const fetchStageAssets = async () => {
    setLoading(true);
    try {
      const { data, error } = await supabase
        .from('lesson_assets' as any)
        .select(`
          *,
          grammar_chapters:asset_id (
            id,
            chapter_code,
            title,
            cefr_level,
            meaning_content,
            form_content,
            use_content,
            contrast_notes,
            common_errors
          ),
          lexicon_entries:asset_id (
            id,
            headword,
            pos,
            definition_simple,
            definition_teacher,
            examples,
            ipa,
            usage_notes
          )
        `)
        .eq('lesson_id', lessonId)
        .eq('stage_id', stageId)
        .order('order_index');

      if (data && !error) {
        setAssets(data);
      }
    } catch (error) {
      console.error('Error fetching stage assets:', error);
    }
    setLoading(false);
  };

  const handleAssetExpand = (assetId: string) => {
    const isExpanding = expandedAsset !== assetId;
    setExpandedAsset(isExpanding ? assetId : null);

    if (isExpanding && !viewedAssets.has(assetId)) {
      setTimeout(() => {
        markAssetAsViewed(assetId);
      }, 3000);
    }
  };

  const markAssetAsViewed = async (assetId: string) => {
    const asset = assets.find((a) => a.asset_id === assetId);
    if (!asset || viewedAssets.has(assetId)) return;

    await trackAssetView(lessonId, assetId, asset.asset_type, 3);
    setViewedAssets((prev) => new Set(prev).add(assetId));
    onAssetViewed?.(assetId);
  };

  if (loading) {
    return (
      <div className="flex justify-center py-4">
        <div className="h-5 w-5 rounded-full border-2 border-primary border-t-transparent animate-spin" />
      </div>
    );
  }

  if (assets.length === 0) {
    return null;
  }

  return (
    <div className="space-y-3">
      <div className="flex items-center gap-2 text-sm font-medium text-muted-foreground">
        <BookOpen className="h-4 w-4" />
        <span>Resources for this stage</span>
      </div>
      {assets.map((asset) => {
        const isGrammar = asset.asset_type === 'grammar';
        const content = isGrammar ? asset.grammar_chapters : asset.lexicon_entries;
        const isExpanded = expandedAsset === asset.asset_id;
        const isViewed = viewedAssets.has(asset.asset_id);

        return (
          <Card
            key={asset.id}
            className={cn(
              'border transition-all',
              isExpanded && 'border-primary/50 shadow-md',
              isViewed && 'bg-success/5 border-success/30'
            )}
          >
            <CardContent className="p-3">
              <div
                className="flex items-center justify-between cursor-pointer"
                onClick={() => handleAssetExpand(asset.asset_id)}
              >
                <div className="flex items-center gap-2 flex-1">
                  {isGrammar ? (
                    <BookOpen className="h-4 w-4 text-primary" />
                  ) : (
                    <Languages className="h-4 w-4 text-accent" />
                  )}
                  <div className="flex-1 min-w-0">
                    <div className="flex items-center gap-2">
                      <p className="text-sm font-medium truncate">
                        {isGrammar ? content?.title : content?.headword}
                      </p>
                      {isGrammar && content?.chapter_code && (
                        <Badge variant="outline" className="text-xs">
                          {content.chapter_code}
                        </Badge>
                      )}
                      {!isGrammar && content?.pos && (
                        <Badge variant="outline" className="text-xs">
                          {content.pos}
                        </Badge>
                      )}
                    </div>
                  </div>
                  {isViewed && (
                    <CheckCircle2 className="h-4 w-4 text-success" />
                  )}
                  {isExpanded ? (
                    <ChevronUp className="h-4 w-4 text-muted-foreground" />
                  ) : (
                    <ChevronDown className="h-4 w-4 text-muted-foreground" />
                  )}
                </div>
              </div>

              {isExpanded && content && (
                <div className="mt-3 pt-3 border-t border-border space-y-3">
                  {isGrammar ? (
                    <>
                      {content.meaning_content && (
                        <div>
                          <h4 className="font-medium text-xs mb-1">Meaning</h4>
                          <p className="text-sm text-muted-foreground">
                            {content.meaning_content}
                          </p>
                        </div>
                      )}
                      {content.form_content && (
                        <div>
                          <h4 className="font-medium text-xs mb-1">Form</h4>
                          <p className="text-sm text-muted-foreground">
                            {content.form_content}
                          </p>
                        </div>
                      )}
                      {content.use_content && (
                        <div>
                          <h4 className="font-medium text-xs mb-1">Use</h4>
                          <p className="text-sm text-muted-foreground">
                            {content.use_content}
                          </p>
                        </div>
                      )}
                    </>
                  ) : (
                    <>
                      {content.ipa && (
                        <div>
                          <h4 className="font-medium text-xs mb-1">Pronunciation</h4>
                          <p className="text-sm text-muted-foreground font-mono">
                            /{content.ipa}/
                          </p>
                        </div>
                      )}
                      {content.definition_simple && (
                        <div>
                          <h4 className="font-medium text-xs mb-1">Definition</h4>
                          <p className="text-sm text-muted-foreground">
                            {content.definition_simple}
                          </p>
                        </div>
                      )}
                      {content.examples && content.examples.length > 0 && (
                        <div>
                          <h4 className="font-medium text-xs mb-1">Examples</h4>
                          <ul className="space-y-1">
                            {content.examples.slice(0, 2).map((ex: string, i: number) => (
                              <li key={i} className="text-sm text-muted-foreground">
                                • {ex}
                              </li>
                            ))}
                          </ul>
                        </div>
                      )}
                    </>
                  )}

                  {!isViewed && (
                    <Button
                      size="sm"
                      className="w-full bg-gradient-primary hover:opacity-90 h-8 text-xs"
                      onClick={() => markAssetAsViewed(asset.asset_id)}
                    >
                      <CheckCircle2 className="h-3 w-3 mr-2" />
                      Mark as Understood
                    </Button>
                  )}
                </div>
              )}
            </CardContent>
          </Card>
        );
      })}
    </div>
  );
}
