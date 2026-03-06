import { useState, useEffect, useCallback } from 'react';
import { supabase } from '@/integrations/supabase/client';
import { useAuth } from './useAuth';
import { SRSCard, SRSCardWithWord, UserRating } from '@/lib/srs';

export function useSRS() {
  const { user } = useAuth();
  const [dueCount, setDueCount] = useState<number>(0);
  const [loading, setLoading] = useState(false);

  // Fetch due cards count
  const fetchDueCount = useCallback(async () => {
    if (!user) {
      setDueCount(0);
      return;
    }

    try {
      const { data, error } = await supabase.rpc('get_due_cards_count', {
        _user_id: user.id,
      });

      if (error) {
        console.error('Error fetching due count:', error);
        return;
      }

      setDueCount(data || 0);
    } catch (err) {
      console.error('Error fetching due count:', err);
    }
  }, [user]);

  // Get or create SRS card for a word
  const getOrCreateCard = useCallback(
    async (wordId: string): Promise<string | null> => {
      if (!user) return null;

      try {
        const { data, error } = await supabase.rpc('get_or_create_srs_card', {
          _user_id: user.id,
          _word_id: wordId,
        });

        if (error) {
          console.error('Error getting/creating card:', error);
          return null;
        }

        return data;
      } catch (err) {
        console.error('Error getting/creating card:', err);
        return null;
      }
    },
    [user]
  );

  // Update SRS card with user rating
  const reviewCard = useCallback(
    async (cardId: string, rating: UserRating): Promise<boolean> => {
      try {
        const { error } = await supabase.rpc('update_srs_card', {
          _card_id: cardId,
          _user_rating: rating,
        });

        if (error) {
          console.error('Error updating card:', error);
          return false;
        }

        // Refresh due count after review
        await fetchDueCount();
        return true;
      } catch (err) {
        console.error('Error updating card:', err);
        return false;
      }
    },
    [fetchDueCount]
  );

  // Get card for a specific word
  const getCardForWord = useCallback(
    async (wordId: string): Promise<SRSCard | null> => {
      if (!user) return null;

      try {
        const { data, error } = await supabase
          .from('srs_cards')
          .select('*')
          .eq('user_id', user.id)
          .eq('word_id', wordId)
          .single();

        if (error && error.code !== 'PGRST116') {
          console.error('Error fetching card:', error);
          return null;
        }

        return data;
      } catch (err) {
        console.error('Error fetching card:', err);
        return null;
      }
    },
    [user]
  );

  // Check if a word needs review
  const needsReview = useCallback(
    async (wordId: string): Promise<boolean> => {
      const card = await getCardForWord(wordId);
      if (!card) return true; // New word needs review
      return new Date(card.next_review_date) <= new Date();
    },
    [getCardForWord]
  );

  // Fetch due cards with word details
  const fetchDueCards = useCallback(async (): Promise<SRSCardWithWord[]> => {
    if (!user) return [];

    setLoading(true);
    try {
      const { data, error } = await supabase
        .from('srs_cards')
        .select(
          `
          *,
          word:lexicon_entries(
            id,
            headword,
            ipa,
            definition_simple,
            definition_teacher,
            pos,
            cefr_receptive,
            cefr_productive,
            examples,
            collocations
          )
        `
        )
        .eq('user_id', user.id)
        .lte('next_review_date', new Date().toISOString())
        .order('next_review_date', { ascending: true });

      if (error) {
        console.error('Error fetching due cards:', error);
        return [];
      }

      return (data || []) as SRSCardWithWord[];
    } catch (err) {
      console.error('Error fetching due cards:', err);
      return [];
    } finally {
      setLoading(false);
    }
  }, [user]);

  // Initial fetch
  useEffect(() => {
    fetchDueCount();
  }, [fetchDueCount]);

  return {
    dueCount,
    loading,
    fetchDueCount,
    getOrCreateCard,
    reviewCard,
    getCardForWord,
    needsReview,
    fetchDueCards,
  };
}
