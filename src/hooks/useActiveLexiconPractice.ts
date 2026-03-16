import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { useAuth } from '@/hooks/useAuth';
import {
  getNextWord,
  submitGrade,
  getSessionStats,
  getDueWords,
  invalidateMetricsCache,
} from '@/lib/active-lexicon/api';
import type { Grade } from '@/lib/active-lexicon/types';

const NEXT_WORD_KEY = ['active-lexicon', 'practice', 'next-word'] as const;
const SESSION_STATS_KEY = ['active-lexicon', 'practice', 'session-stats'] as const;

export function useActiveLexiconPractice() {
  const { user } = useAuth();
  const queryClient = useQueryClient();
  const userId = user?.id ?? '';

  const nextWordQuery = useQuery({
    queryKey: [...NEXT_WORD_KEY, userId],
    queryFn: () => getNextWord(userId),
    enabled: !!userId,
  });

  const sessionStatsQuery = useQuery({
    queryKey: [...SESSION_STATS_KEY, userId],
    queryFn: () => getSessionStats(userId),
    enabled: !!userId,
  });

  const gradeMutation = useMutation({
    mutationFn: ({ entryId, grade }: { entryId: string; grade: Grade }) =>
      submitGrade(userId, entryId, grade),
    onSuccess: () => {
      invalidateMetricsCache();
      queryClient.invalidateQueries({ queryKey: NEXT_WORD_KEY });
      queryClient.invalidateQueries({ queryKey: SESSION_STATS_KEY });
    },
  });

  const refetchNextWord = () => queryClient.invalidateQueries({ queryKey: NEXT_WORD_KEY });

  return {
    nextWord: nextWordQuery.data ?? null,
    nextWordLoading: nextWordQuery.isLoading,
    nextWordError: nextWordQuery.error,
    refetchNextWord: nextWordQuery.refetch,
    sessionStats: sessionStatsQuery.data ?? null,
    submitGrade: gradeMutation.mutateAsync,
    gradeLoading: gradeMutation.isPending,
    gradeError: gradeMutation.error,
  };
}
