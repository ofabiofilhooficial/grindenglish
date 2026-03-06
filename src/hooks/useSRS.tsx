import { useState, useEffect, useCallback } from 'react';
import { supabase } from '@/integrations/supabase/client';
import { useAuth } from './useAuth';
import { SRSCard, SRSCardWithWord, UserRating } from '@/lib/srs';

export function useSRS() {
  const { user } = useAuth();
  const [dueCount, setDueCount] = useState<number>(0);
  const [loading, setLoading] = useState(false);

  const fetchDueCount = useCallback(async () => {
    if (!user) {
      setDueCount(0);
      return;
    }
    try {
      const { data, error } = await supabase.rpc('get_due_cards_count' as any, {
        _user_id: user.id,
      });
      if (error) {
        console.error('Error fetching due count:', error);
        return;
      }
      setDueCount((data as number) || 0);
    } catch (err) {
      console.error('Error fetching due count:', err);
    }
  }, [user]);

  const getOrCreateCard = useCallback(
    async (wordId: string): Promise<string | null> => {
      if (!user) return null;
      try {
        const { data, error } = await supabase.rpc('get_or_create_srs_card' as any, {
          _user_id: user.id,
          _word_id: wordId,
        });
        if (error) {
          console.error('Error getting/creating card:', error);
          return null;
        }
        return data as string;
      } catch (err) {
        console.error('Error getting/creating card:', err);
        return null;
      }
    },
    [user]
  );

  const reviewCard = useCallback(
    async (cardId: string, rating: UserRating): Promise<boolean> => {
      try {
        const { error } = await supabase.rpc('update_srs_card' as any, {
          _card_id: cardId,
          _user_rating: rating,
        });
        if (error) {
          console.error('Error updating card:', error);
          return false;
        }
        await fetchDueCount();
        return true;
      } catch (err) {
        console.error('Error updating card:', err);
        return false;
      }
    },
    [fetchDueCount]
  );

  const getCardForWord = useCallback(
    async (wordId: string): Promise<SRSCard | null> => {
      if (!user) return null;
      try {
        const { data, error } = await supabase
          .from('srs_cards' as any)
          .select('*')
          .eq('user_id', user.id)
          .eq('word_id', wordId)
          .single();
        if (error && error.code !== 'PGRST116') {
          console.error('Error fetching card:', error);
          return null;
        }
        return data as unknown as SRSCard | null;
      } catch (err) {
        console.error('Error fetching card:', err);
        return null;
      }
    },
    [user]
  );

  const needsReview = useCallback(
    async (wordId: string): Promise<boolean> => {
      const card = await getCardForWord(wordId);
      if (!card) return true;
      return new Date(card.next_review_date) <= new Date();
    },
    [getCardForWord]
  );

  const fetchDueCards = useCallback(async (): Promise<SRSCardWithWord[]> => {
    if (!user) return [];
    setLoading(true);
    try {
      const { data, error } = await supabase
        .from('srs_cards' as any)
        .select(`
          *,
          word:lexicon_entries(
            id, headword, ipa, definition_simple, definition_teacher,
            pos, cefr_receptive, cefr_productive, examples, collocations
          )
        `)
        .eq('user_id', user.id)
        .lte('next_review_date', new Date().toISOString())
        .order('next_review_date', { ascending: true });
      if (error) {
        console.error('Error fetching due cards:', error);
        return [];
      }
      return (data || []) as unknown as SRSCardWithWord[];
    } catch (err) {
      console.error('Error fetching due cards:', err);
      return [];
    } finally {
      setLoading(false);
    }
  }, [user]);

  useEffect(() => {
    fetchDueCount();
  }, [fetchDueCount]);

  return {
    dueCount, loading, fetchDueCount, getOrCreateCard,
    reviewCard, getCardForWord, needsReview, fetchDueCards,
  };
}
