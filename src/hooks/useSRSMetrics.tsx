import { useState, useEffect, useCallback } from 'react';
import { supabase } from '@/integrations/supabase/client';
import { useAuth } from './useAuth';

export interface SRSMetrics {
  // A0 Level Metrics
  a0VocabTotal: number;
  a0VocabMastered: number;
  a0VocabProgress: number;
  
  a0GrammarTotal: number;
  a0GrammarMastered: number;
  a0GrammarProgress: number;
  
  a0TotalItems: number;
  a0MasteredItems: number;
  a0Progress: number;
  
  // Platform-wide Metrics
  platformTotalItems: number;
  platformMasteredItems: number;
  platformProgress: number;
}

export function useSRSMetrics() {
  const { user } = useAuth();
  const [metrics, setMetrics] = useState<SRSMetrics | null>(null);
  const [loading, setLoading] = useState(true);

  const fetchMetrics = useCallback(async () => {
    if (!user) {
      setMetrics(null);
      setLoading(false);
      return;
    }

    try {
      setLoading(true);

      // Count total A0 vocabulary items (from first 12 lessons)
      const { count: a0VocabTotal } = await supabase
        .from('lexicon_entries' as any)
        .select('*', { count: 'exact', head: true })
        .eq('cefr_receptive', 'A0')
        .limit(1000);

      // Count mastered A0 vocabulary (repetitions >= 3 indicates mastery)
      const { data: masteredVocab } = await supabase
        .from('srs_cards' as any)
        .select('word_id, lexicon_entries!inner(cefr_receptive)')
        .eq('user_id', user.id)
        .gte('repetitions', 3)
        .eq('lexicon_entries.cefr_receptive', 'A0');

      const a0VocabMastered = masteredVocab?.length || 0;

      // Count total A0 grammar chapters
      const { count: a0GrammarTotal } = await supabase
        .from('grammar_chapters' as any)
        .select('*', { count: 'exact', head: true })
        .eq('cefr_level', 'A0')
        .eq('is_published', true);

      // Count viewed A0 grammar chapters (from learner_progress or activity log)
      // For now, we'll use a simple count of grammar chapters the user has interacted with
      const { data: viewedGrammar } = await supabase
        .from('activity_log' as any)
        .select('metadata')
        .eq('user_id', user.id)
        .eq('verb', 'grammar_view')
        .eq('metadata->>cefr_level', 'A0');

      // Get unique grammar chapters viewed
      const uniqueGrammarIds = new Set(
        viewedGrammar?.map((log: any) => log.metadata?.chapter_id).filter(Boolean) || []
      );
      const a0GrammarMastered = uniqueGrammarIds.size;

      // Calculate A0 totals
      const a0TotalItems = (a0VocabTotal || 0) + (a0GrammarTotal || 0);
      const a0MasteredItems = a0VocabMastered + a0GrammarMastered;
      const a0Progress = a0TotalItems > 0 ? (a0MasteredItems / a0TotalItems) * 100 : 0;

      // Calculate vocabulary progress
      const a0VocabProgress = (a0VocabTotal || 0) > 0 ? (a0VocabMastered / (a0VocabTotal || 1)) * 100 : 0;

      // Calculate grammar progress
      const a0GrammarProgress = (a0GrammarTotal || 0) > 0 ? (a0GrammarMastered / (a0GrammarTotal || 1)) * 100 : 0;

      // Count total platform vocabulary items (all CEFR levels)
      const { count: platformVocabTotal } = await supabase
        .from('lexicon_entries' as any)
        .select('*', { count: 'exact', head: true });

      // Count total platform grammar chapters
      const { count: platformGrammarTotal } = await supabase
        .from('grammar_chapters' as any)
        .select('*', { count: 'exact', head: true })
        .eq('is_published', true);

      // Count all mastered vocabulary (all levels)
      const { data: allMasteredVocab } = await supabase
        .from('srs_cards' as any)
        .select('word_id')
        .eq('user_id', user.id)
        .gte('repetitions', 3);

      const platformVocabMastered = allMasteredVocab?.length || 0;

      // Count all viewed grammar chapters (all levels)
      const { data: allViewedGrammar } = await supabase
        .from('activity_log' as any)
        .select('metadata')
        .eq('user_id', user.id)
        .eq('verb', 'grammar_view');

      const allUniqueGrammarIds = new Set(
        allViewedGrammar?.map((log: any) => log.metadata?.chapter_id).filter(Boolean) || []
      );
      const platformGrammarMastered = allUniqueGrammarIds.size;

      // Calculate platform totals
      const platformTotalItems = (platformVocabTotal || 0) + (platformGrammarTotal || 0);
      const platformMasteredItems = platformVocabMastered + platformGrammarMastered;
      const platformProgress = platformTotalItems > 0 ? (platformMasteredItems / platformTotalItems) * 100 : 0;

      setMetrics({
        a0VocabTotal: a0VocabTotal || 0,
        a0VocabMastered,
        a0VocabProgress,
        
        a0GrammarTotal: a0GrammarTotal || 0,
        a0GrammarMastered,
        a0GrammarProgress,
        
        a0TotalItems,
        a0MasteredItems,
        a0Progress,
        
        platformTotalItems,
        platformMasteredItems,
        platformProgress,
      });
    } catch (error) {
      console.error('Error fetching SRS metrics:', error);
      setMetrics(null);
    } finally {
      setLoading(false);
    }
  }, [user]);

  useEffect(() => {
    fetchMetrics();
  }, [fetchMetrics]);

  return { metrics, loading, refetch: fetchMetrics };
}
