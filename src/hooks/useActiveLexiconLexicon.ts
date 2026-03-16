import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { useAuth } from '@/hooks/useAuth';
import {
  getLexiconEntries,
  getLexiconEntryById,
  startLearning,
  invalidateMetricsCache,
} from '@/lib/active-lexicon/api';
import type { LexiconFilters } from '@/lib/active-lexicon/types';

const ENTRIES_KEY = ['active-lexicon', 'entries'] as const;
const ENTRY_DETAIL_KEY = ['active-lexicon', 'entry'] as const;

export function useActiveLexiconLexicon(
  filters: LexiconFilters = {},
  page: number = 1,
  limit: number = 50
) {
  const { user } = useAuth();
  const queryClient = useQueryClient();
  const userId = user?.id ?? '';

  const entriesQuery = useQuery({
    queryKey: [...ENTRIES_KEY, userId, filters, page, limit],
    queryFn: () => getLexiconEntries(userId, filters, page, limit),
    enabled: !!userId,
  });

  const invalidate = () => {
    queryClient.invalidateQueries({ queryKey: ENTRIES_KEY });
    queryClient.invalidateQueries({ queryKey: ENTRY_DETAIL_KEY });
    invalidateMetricsCache();
  };

  return {
    data: entriesQuery.data,
    loading: entriesQuery.isLoading,
    error: entriesQuery.error,
    refetch: entriesQuery.refetch,
    invalidate,
  };
}

export function useActiveLexiconEntryDetail(entryId: string | null) {
  const { user } = useAuth();
  const userId = user?.id ?? '';

  return useQuery({
    queryKey: [...ENTRY_DETAIL_KEY, userId, entryId],
    queryFn: () => getLexiconEntryById(userId!, entryId!),
    enabled: !!userId && !!entryId,
  });
}

export function useStartLearning() {
  const queryClient = useQueryClient();
  const { user } = useAuth();
  const userId = user?.id ?? '';

  const mutation = useMutation({
    mutationFn: (entryId: string) => startLearning(userId, entryId),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ENTRIES_KEY });
      queryClient.invalidateQueries({ queryKey: ENTRY_DETAIL_KEY });
      invalidateMetricsCache();
    },
  });

  return mutation;
}
