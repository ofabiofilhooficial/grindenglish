import { useQuery, useQueryClient } from '@tanstack/react-query';
import { useAuth } from '@/hooks/useAuth';
import {
  getDashboardMetrics,
  getDueWords,
  invalidateMetricsCache,
} from '@/lib/active-lexicon/api';

const METRICS_KEY = ['active-lexicon', 'metrics'] as const;
const DUE_WORDS_KEY = ['active-lexicon', 'due-words'] as const;

export function useActiveLexiconDashboard(page: number = 1, limit: number = 20) {
  const { user } = useAuth();
  const queryClient = useQueryClient();
  const userId = user?.id ?? '';

  const metricsQuery = useQuery({
    queryKey: [...METRICS_KEY, userId],
    queryFn: () => getDashboardMetrics(userId),
    enabled: !!userId,
    staleTime: 30_000,
  });

  const dueWordsQuery = useQuery({
    queryKey: [...DUE_WORDS_KEY, userId, page, limit],
    queryFn: () => getDueWords(userId, page, limit),
    enabled: !!userId,
    staleTime: 30_000,
  });

  const refetchAll = () => {
    invalidateMetricsCache();
    queryClient.invalidateQueries({ queryKey: METRICS_KEY });
    queryClient.invalidateQueries({ queryKey: DUE_WORDS_KEY });
  };

  return {
    metrics: metricsQuery.data,
    metricsLoading: metricsQuery.isLoading,
    metricsError: metricsQuery.error,
    refetchMetrics: metricsQuery.refetch,
    dueWords: dueWordsQuery.data,
    dueWordsLoading: dueWordsQuery.isLoading,
    dueWordsError: dueWordsQuery.error,
    refetchDueWords: dueWordsQuery.refetch,
    refetchAll,
  };
}
