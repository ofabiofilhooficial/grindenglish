import { useState, useEffect } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import { BookOpen, Languages, ChevronDown, ChevronUp } from 'lucide-react';
import { supabase } from '@/integrations/supabase/client';
import { cn } from '@/lib/utils';

interface UnitAssetViewerProps {
  unitId: string;
}

export function UnitAssetViewer({ unitId }: UnitAssetViewerProps) {
  const [assets, setAssets] = useState<any[]>([]);
  const [expandedAsset, setExpandedAsset] = useState<string | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchUnitAssets();
  }, [unitId]);

  const fetchUnitAssets = async () => {
    setLoading(true);
    try {
      // Use the new view that properly joins asset data
      const { data, error } = await supabase
        .from('unit_assets_with_content' as any)
        .select('*')
        .eq('unit_id', unitId)
        .order('order_index');

      if (data && !error) {
        setAssets(data);
      }
    } catch (error) {
      console.error('Error fetching unit assets:', error);
    }
    setLoading(false);
  };

  const handleAssetExpand = (assetId: string) => {
    const isExpanding = expandedAsset !== assetId;
    setExpandedAsset(isExpanding ? assetId : null);
  };

  if (loading) {
    return (
      <Card>
        <CardContent className="p-6">
          <div className="flex justify-center">
            <div className="h-6 w-6 rounded-full border-2 border-primary border-t-transparent animate-spin" />
          </div>
        </CardContent>
      </Card>
    );
  }

  if (assets.length === 0) {
    return null; // Don't show anything if no assets
  }

  return (
    <Card>
      <CardHeader className="pb-3">
        <CardTitle className="text-base font-display flex items-center gap-2">
          <BookOpen className="h-4 w-4" />
          Pre-Study Resources
        </CardTitle>
        <p className="text-xs text-muted-foreground">
          Review these before starting the unit lessons
        </p>
      </CardHeader>
      <CardContent className="space-y-2">
        {assets.map((asset) => {
          const isExpanded = expandedAsset === asset.id;
          const isGrammar = asset.asset_type === 'grammar';
          const assetData = isGrammar ? asset.grammar_chapter : asset.lexicon_entry;

          if (!assetData) return null;

          return (
            <div
              key={asset.id}
              className={cn(
                'rounded-lg border transition-all',
                isExpanded ? 'bg-secondary/30' : 'bg-background'
              )}
            >
              <button
                onClick={() => handleAssetExpand(asset.id)}
                className="w-full p-3 flex items-center justify-between hover:bg-secondary/50 transition-colors rounded-lg"
              >
                <div className="flex items-center gap-3">
                  {isGrammar ? (
                    <BookOpen className="h-4 w-4 text-primary flex-shrink-0" />
                  ) : (
                    <Languages className="h-4 w-4 text-accent flex-shrink-0" />
                  )}
                  <div className="text-left">
                    <p className="font-medium text-sm">
                      {asset.asset_title}
                    </p>
                    {asset.asset_code && (
                      <p className="text-xs text-muted-foreground">{asset.asset_code}</p>
                    )}
                  </div>
                </div>
                <div className="flex items-center gap-2">
                  <Badge variant="outline" className="text-xs">
                    {isGrammar ? 'Grammar' : 'Vocabulary'}
                  </Badge>
                  {isExpanded ? (
                    <ChevronUp className="h-4 w-4 text-muted-foreground" />
                  ) : (
                    <ChevronDown className="h-4 w-4 text-muted-foreground" />
                  )}
                </div>
              </button>

              {isExpanded && (
                <div className="px-3 pb-3 space-y-3 text-sm">
                  {isGrammar ? (
                    <>
                      {assetData.meaning_content && (
                        <div>
                          <p className="font-semibold text-xs text-primary mb-1">Meaning</p>
                          <p className="text-muted-foreground whitespace-pre-wrap">
                            {assetData.meaning_content}
                          </p>
                        </div>
                      )}
                      {assetData.form_content && (
                        <div>
                          <p className="font-semibold text-xs text-primary mb-1">Form</p>
                          <p className="text-muted-foreground whitespace-pre-wrap">
                            {assetData.form_content}
                          </p>
                        </div>
                      )}
                      {assetData.use_content && (
                        <div>
                          <p className="font-semibold text-xs text-primary mb-1">Use</p>
                          <p className="text-muted-foreground whitespace-pre-wrap">
                            {assetData.use_content}
                          </p>
                        </div>
                      )}
                      {assetData.contrast_notes && (
                        <div>
                          <p className="font-semibold text-xs text-accent mb-1">
                            L1 Contrast (Portuguese)
                          </p>
                          <p className="text-muted-foreground whitespace-pre-wrap">
                            {assetData.contrast_notes}
                          </p>
                        </div>
                      )}
                      {assetData.common_errors && (
                        <div>
                          <p className="font-semibold text-xs text-destructive mb-1">
                            Common Errors
                          </p>
                          <p className="text-muted-foreground whitespace-pre-wrap">
                            {assetData.common_errors}
                          </p>
                        </div>
                      )}
                    </>
                  ) : (
                    <>
                      {assetData.ipa && (
                        <div>
                          <p className="font-semibold text-xs text-primary mb-1">Pronunciation</p>
                          <p className="text-muted-foreground">/{assetData.ipa}/</p>
                        </div>
                      )}
                      {assetData.definition_simple && (
                        <div>
                          <p className="font-semibold text-xs text-primary mb-1">Definition</p>
                          <p className="text-muted-foreground">{assetData.definition_simple}</p>
                        </div>
                      )}
                      {assetData.examples && assetData.examples.length > 0 && (
                        <div>
                          <p className="font-semibold text-xs text-primary mb-1">Examples</p>
                          <ul className="list-disc list-inside space-y-1 text-muted-foreground">
                            {assetData.examples.map((ex: string, idx: number) => (
                              <li key={idx}>{ex}</li>
                            ))}
                          </ul>
                        </div>
                      )}
                      {assetData.usage_notes && (
                        <div>
                          <p className="font-semibold text-xs text-accent mb-1">Usage Notes</p>
                          <p className="text-muted-foreground whitespace-pre-wrap">
                            {assetData.usage_notes}
                          </p>
                        </div>
                      )}
                    </>
                  )}
                </div>
              )}
            </div>
          );
        })}
      </CardContent>
    </Card>
  );
}
