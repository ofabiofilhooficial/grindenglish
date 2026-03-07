import { useState, useEffect, useRef } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Separator } from '@/components/ui/separator';
import { ScrollArea } from '@/components/ui/scroll-area';
import { BookOpen, Languages, CheckCircle2, ChevronDown, ChevronUp } from 'lucide-react';
import { supabase } from '@/integrations/supabase/client';
import { useActivityTracker } from '@/hooks/useActivityTracker';
import { LessonAsset } from '@/types/course';
import { cn } from '@/lib/utils';

interface LinkedAssetViewerProps {
  lessonId: string;
  onAssetViewed?: (assetId: string) => void;
}

export function LinkedAssetViewer({ lessonId, onAssetViewed }: LinkedAssetViewerProps) {
  const { trackAssetView } = useActivityTracker();
  const [assets, setAssets] = useState<any[]>([]);
  const [expandedAsset, setExpandedAsset] = useState<string | null>(null);
  const [viewedAssets, setViewedAssets] = useState<Set<string>>(new Set());
  const [loading, setLoading] = useState(true);
  const observerRefs = useRef<Map<string, IntersectionObserver>>(new Map());
  const viewTimers = useRef<Map<string, { start: number; timer: NodeJS.Timeout }>>(new Map());

  useEffect(() => {
    fetchLinkedAssets();
    return () => {
      // Cleanup observers and timers
      observerRefs.current.forEach((observer) => observer.disconnect());
      viewTimers.current.forEach(({ timer }) => clearTimeout(timer));
    };
  }, [lessonId]);

  const fetchLinkedAssets = async () => {
    setLoading(true);
    try {
      // Use the new view that properly joins asset data
      const { data, error } = await supabase
        .from('lesson_assets_with_content' as any)
        .select('*')
        .eq('lesson_id', lessonId)
        .is('stage_id', null) // Only fetch lesson-level assets (not stage-specific)
        .order('order_index');

      if (data && !error) {
        setAssets(data);
      }
    } catch (error) {
      console.error('Error fetching linked assets:', error);
    }
    setLoading(false);
  };

  const handleAssetExpand = (assetId: string) => {
    const isExpanding = expandedAsset !== assetId;
    setExpandedAsset(isExpanding ? assetId : null);

    if (isExpanding && !viewedAssets.has(assetId)) {
      // Start tracking view time
      const startTime = Date.now();
      const timer = setTimeout(() => {
        markAssetAsViewed(assetId);
      }, 3000); // Mark as viewed after 3 seconds

      viewTimers.current.set(assetId, { start: startTime, timer });
    }
  };

  const markAssetAsViewed = async (assetId: string) => {
    const asset = assets.find((a) => a.asset_id === assetId);
    if (!asset || viewedAssets.has(assetId)) return;

    const viewTimer = viewTimers.current.get(assetId);
    const duration = viewTimer ? Math.floor((Date.now() - viewTimer.start) / 1000) : 0;

    // Track the view
    await trackAssetView(lessonId, assetId, asset.asset_type, duration);

    // Update local state
    setViewedAssets((prev) => new Set(prev).add(assetId));
    onAssetViewed?.(assetId);

    // Clear timer
    if (viewTimer) {
      clearTimeout(viewTimer.timer);
      viewTimers.current.delete(assetId);
    }
  };

  const handleMarkAsUnderstood = async (assetId: string) => {
    await markAssetAsViewed(assetId);
  };

  if (loading) {
    return (
      <Card>
        <CardContent className="p-6 flex justify-center">
          <div className="h-6 w-6 rounded-full border-2 border-primary border-t-transparent animate-spin" />
        </CardContent>
      </Card>
    );
  }

  if (assets.length === 0) {
    return null;
  }

  return (
    <Card className="bg-accent/5 border-accent/20">
      <CardHeader>
        <CardTitle className="font-display text-lg flex items-center gap-2">
          <BookOpen className="h-5 w-5 text-accent" />
          Additional Reference Materials
        </CardTitle>
        <p className="text-sm text-muted-foreground">
          General resources for this lesson (available across all stages)
        </p>
      </CardHeader>
      <CardContent className="space-y-3">
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
              <CardContent className="p-4">
                <div
                  className="flex items-center justify-between cursor-pointer"
                  onClick={() => handleAssetExpand(asset.asset_id)}
                >
                  <div className="flex items-center gap-3 flex-1">
                    {isGrammar ? (
                      <BookOpen className="h-5 w-5 text-primary" />
                    ) : (
                      <Languages className="h-5 w-5 text-accent" />
                    )}
                    <div className="flex-1 min-w-0">
                      <div className="flex items-center gap-2 mb-1">
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
                        {asset.is_required && (
                          <Badge variant="secondary" className="text-xs">
                            Required
                          </Badge>
                        )}
                      </div>
                      {asset.context_note && (
                        <p className="text-xs text-muted-foreground">
                          {asset.context_note}
                        </p>
                      )}
                    </div>
                    {isViewed && (
                      <CheckCircle2 className="h-5 w-5 text-success" />
                    )}
                    {isExpanded ? (
                      <ChevronUp className="h-5 w-5 text-muted-foreground" />
                    ) : (
                      <ChevronDown className="h-5 w-5 text-muted-foreground" />
                    )}
                  </div>
                </div>

                {isExpanded && content && (
                  <div className="mt-4 pt-4 border-t border-border space-y-4">
                    {isGrammar ? (
                      <>
                        {content.meaning_content && (
                          <div>
                            <h4 className="font-medium text-sm mb-2">Meaning</h4>
                            <p className="text-sm text-muted-foreground">
                              {content.meaning_content}
                            </p>
                          </div>
                        )}
                        {content.form_content && (
                          <div>
                            <h4 className="font-medium text-sm mb-2">Form</h4>
                            <p className="text-sm text-muted-foreground">
                              {content.form_content}
                            </p>
                          </div>
                        )}
                        {content.use_content && (
                          <div>
                            <h4 className="font-medium text-sm mb-2">Use</h4>
                            <p className="text-sm text-muted-foreground">
                              {content.use_content}
                            </p>
                          </div>
                        )}
                        {content.common_errors && (
                          <div>
                            <h4 className="font-medium text-sm mb-2">Common Errors</h4>
                            <p className="text-sm text-muted-foreground">
                              {content.common_errors}
                            </p>
                          </div>
                        )}
                      </>
                    ) : (
                      <>
                        {content.ipa && (
                          <div>
                            <h4 className="font-medium text-sm mb-1">Pronunciation</h4>
                            <p className="text-sm text-muted-foreground font-mono">
                              /{content.ipa}/
                            </p>
                          </div>
                        )}
                        {content.definition_simple && (
                          <div>
                            <h4 className="font-medium text-sm mb-1">Definition</h4>
                            <p className="text-sm text-muted-foreground">
                              {content.definition_simple}
                            </p>
                          </div>
                        )}
                        {content.examples && content.examples.length > 0 && (
                          <div>
                            <h4 className="font-medium text-sm mb-2">Examples</h4>
                            <ul className="space-y-1">
                              {content.examples.map((ex: string, i: number) => (
                                <li key={i} className="text-sm text-muted-foreground">
                                  • {ex}
                                </li>
                              ))}
                            </ul>
                          </div>
                        )}
                        {content.usage_notes && (
                          <div>
                            <h4 className="font-medium text-sm mb-1">Usage Notes</h4>
                            <p className="text-sm text-muted-foreground">
                              {content.usage_notes}
                            </p>
                          </div>
                        )}
                      </>
                    )}

                    {!isViewed && (
                      <Button
                        size="sm"
                        className="w-full bg-gradient-primary hover:opacity-90"
                        onClick={() => handleMarkAsUnderstood(asset.asset_id)}
                      >
                        <CheckCircle2 className="h-4 w-4 mr-2" />
                        Mark as Understood
                      </Button>
                    )}
                  </div>
                )}
              </CardContent>
            </Card>
          );
        })}
      </CardContent>
    </Card>
  );
}
