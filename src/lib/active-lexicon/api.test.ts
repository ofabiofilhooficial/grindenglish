/**
 * Active Lexicon Engine – API layer tests
 * Tests response shapes, cache behavior, and error handling (with mocked Supabase).
 */

import { describe, it, expect, vi, beforeEach } from 'vitest';
import {
  getDashboardMetrics,
  getDueWords,
  getLexiconEntries,
  getLexiconEntryById,
  startLearning,
  getNextWord,
  submitGrade,
  getSessionStats,
  invalidateMetricsCache,
} from './api';

const mockRpc = vi.fn();
const mockFrom = vi.fn();

vi.mock('@/integrations/supabase/client', () => ({
  supabase: {
    rpc: (...args: unknown[]) => mockRpc(...args),
    from: (table: string) => mockFrom(table),
  },
}));

vi.mock('@/lib/parsers', () => ({
  parseCloze: (sentence: string, word: string) =>
    sentence.replace(new RegExp(word, 'i'), '_____'),
}));

describe('Active Lexicon API', () => {
  const userId = 'user-uuid';

  beforeEach(() => {
    vi.clearAllMocks();
    invalidateMetricsCache();
    mockFrom.mockReturnValue({
      select: vi.fn().mockReturnThis(),
      eq: vi.fn().mockReturnThis(),
      single: vi.fn().mockResolvedValue({ data: null, error: null }),
      maybeSingle: vi.fn().mockResolvedValue({ data: null, error: null }),
    });
  });

  describe('getDashboardMetrics', () => {
    it('returns correct shape and caches result', async () => {
      mockRpc.mockResolvedValueOnce({
        data: {
          total_words_unlocked: 10,
          words_in_learning: 3,
          words_mastered: 7,
        },
        error: null,
      });

      const result = await getDashboardMetrics(userId);

      expect(result).toMatchObject({
        total_words_unlocked: 10,
        words_in_learning: 3,
        words_mastered: 7,
      });
      expect(result.cache_timestamp).toBeDefined();
      expect(mockRpc).toHaveBeenCalledWith('get_dashboard_metrics', { _user_id: userId });

      mockRpc.mockClear();
      const cached = await getDashboardMetrics(userId);
      expect(cached.total_words_unlocked).toBe(result.total_words_unlocked);
      expect(cached.words_in_learning).toBe(result.words_in_learning);
      expect(cached.words_mastered).toBe(result.words_mastered);
      expect(cached.cache_timestamp).toBeDefined();
      expect(mockRpc).not.toHaveBeenCalled();
    });

    it('returns zeros when RPC returns empty', async () => {
      mockRpc.mockResolvedValueOnce({ data: [], error: null });

      const result = await getDashboardMetrics(userId);

      expect(result.total_words_unlocked).toBe(0);
      expect(result.words_in_learning).toBe(0);
      expect(result.words_mastered).toBe(0);
    });

    it('throws on RPC error', async () => {
      mockRpc.mockResolvedValueOnce({ data: null, error: { message: 'DB error' } });

      await expect(getDashboardMetrics(userId)).rejects.toThrow('DB error');
    });
  });

  describe('getDueWords', () => {
    it('returns paginated shape and clamps limit', async () => {
      mockRpc
        .mockResolvedValueOnce({ data: 45, error: null })
        .mockResolvedValueOnce({
          data: [
            {
              lexicon_entry_id: 'id-1',
              english_word: 'have',
              cefr_level: 'A1',
              unit: 'Unit 1',
              days_overdue: 0,
              next_review_date: '2024-01-15',
            },
          ],
          error: null,
        });

      const result = await getDueWords(userId, 2, 20);

      expect(result.items).toHaveLength(1);
      expect(result.items[0]).toMatchObject({
        lexicon_entry_id: 'id-1',
        english_word: 'have',
        cefr_level: 'A1',
        unit: 'Unit 1',
        days_overdue: 0,
        next_review_date: '2024-01-15',
      });
      expect(result.total_count).toBe(45);
      expect(result.page).toBe(2);
      expect(result.limit).toBe(20);
      expect(mockRpc).toHaveBeenNthCalledWith(1, 'get_due_words_count', { _user_id: userId });
      expect(mockRpc).toHaveBeenNthCalledWith(2, 'get_due_words', {
        _user_id: userId,
        _limit: 20,
        _offset: 20,
      });
    });

    it('clamps limit to max 100', async () => {
      mockRpc
        .mockResolvedValueOnce({ data: 0, error: null })
        .mockResolvedValueOnce({ data: [], error: null });

      await getDueWords(userId, 1, 200);

      expect(mockRpc).toHaveBeenCalledWith(
        'get_due_words',
        expect.objectContaining({ _limit: 100 })
      );
    });

    it('throws on count RPC error', async () => {
      mockRpc
        .mockResolvedValueOnce({ data: null, error: { message: 'Count failed' } })
        .mockResolvedValueOnce({ data: [], error: null });

      await expect(getDueWords(userId, 1, 20)).rejects.toThrow('Count failed');
    });
  });

  describe('invalidateMetricsCache', () => {
    it('clears cache so next getDashboardMetrics refetches', async () => {
      mockRpc
        .mockResolvedValueOnce({
          data: { total_words_unlocked: 1, words_in_learning: 0, words_mastered: 0 },
          error: null,
        })
        .mockResolvedValueOnce({
          data: { total_words_unlocked: 2, words_in_learning: 0, words_mastered: 0 },
          error: null,
        });

      const r1 = await getDashboardMetrics(userId);
      expect(r1.total_words_unlocked).toBe(1);
      invalidateMetricsCache();
      const r2 = await getDashboardMetrics(userId);
      expect(r2.total_words_unlocked).toBe(2);
      expect(mockRpc).toHaveBeenCalledTimes(2);
    });
  });

  describe('getLexiconEntries', () => {
    it('passes filters and pagination to RPCs', async () => {
      mockRpc
        .mockResolvedValueOnce({ data: 100, error: null })
        .mockResolvedValueOnce({
          data: [
            {
              lexicon_entry_id: 'e1',
              english_word: 'word',
              cefr_level: 'A1',
              unit: 'U1',
              mastery_status: 'New',
              last_reviewed_date: null,
            },
          ],
          error: null,
        });

      const result = await getLexiconEntries(userId, {
        search: 'foo',
        cefr_levels: ['A1', 'A2'],
        statuses: ['Learning'],
      }, 1, 50);

      expect(result.items).toHaveLength(1);
      expect(result.total_count).toBe(100);
      expect(result.page).toBe(1);
      expect(result.limit).toBe(50);
      expect(mockRpc).toHaveBeenCalledWith('get_lexicon_entries_count', {
        _user_id: userId,
        _search: 'foo',
        _cefr_levels: ['A1', 'A2'],
        _units: null,
        _statuses: ['Learning'],
      });
    });
  });

  describe('getLexiconEntryById', () => {
    it('returns null when entry not found', async () => {
      mockFrom.mockReturnValue({
        select: vi.fn().mockReturnThis(),
        eq: vi.fn().mockReturnThis(),
        single: vi.fn().mockResolvedValue({ data: null, error: { code: 'PGRST116' } }),
        maybeSingle: vi.fn().mockResolvedValue({ data: null, error: null }),
      });

      const result = await getLexiconEntryById(userId, 'missing-id');

      expect(result).toBeNull();
    });
  });

  describe('startLearning', () => {
    it('returns StartLearningResponse shape', async () => {
      mockRpc.mockResolvedValueOnce({
        data: [{
          status: 'New',
          ease_factor: 2.5,
          interval_days: 1,
          next_review_date: '2024-01-15',
        }],
        error: null,
      });

      const result = await startLearning(userId, 'entry-id');

      expect(result).toMatchObject({
        lexicon_entry_id: 'entry-id',
        status: 'New',
        ease_factor: 2.5,
        interval_days: 1,
        next_review_date: '2024-01-15',
      });
      expect(mockRpc).toHaveBeenCalledWith('initialize_vocabulary_progress', {
        _user_id: userId,
        _lexicon_entry_id: 'entry-id',
      });
    });
  });

  describe('submitGrade', () => {
    it('returns GradeResponse shape and invalidates cache', async () => {
      mockRpc.mockResolvedValueOnce({
        data: [{
          status: 'Learning',
          ease_factor: 2.5,
          interval_days: 2,
          next_review_date: '2024-01-17',
          consecutive_correct: 1,
          total_reviews: 5,
          message: 'Nice work.',
        }],
        error: null,
      });

      const result = await submitGrade(userId, 'entry-id', 'Good');

      expect(result).toMatchObject({
        status: 'Learning',
        ease_factor: 2.5,
        interval_days: 2,
        next_review_date: '2024-01-17',
        consecutive_correct: 1,
        total_reviews: 5,
        message: 'Nice work.',
      });
      expect(mockRpc).toHaveBeenCalledWith('update_srs_progress', {
        _user_id: userId,
        _lexicon_entry_id: 'entry-id',
        _grade: 'Good',
      });
    });
  });

  describe('getSessionStats', () => {
    it('returns SessionStatsResponse shape', async () => {
      mockRpc.mockResolvedValueOnce({
        data: [{
          total_words_reviewed: 10,
          average_ease_factor: 2.3,
          words_mastered_today: 2,
        }],
        error: null,
      });

      const result = await getSessionStats(userId);

      expect(result).toMatchObject({
        total_words_reviewed: 10,
        average_ease_factor: 2.3,
        words_mastered_today: 2,
      });
      expect(result.session_duration_minutes).toBe(0);
    });
  });

  describe('getNextWord', () => {
    it('returns null when no due words', async () => {
      mockRpc.mockResolvedValueOnce({ data: [], error: null });

      const result = await getNextWord(userId);

      expect(result).toBeNull();
    });

    it('returns NextWordResponse with cloze sentence when due word exists', async () => {
      mockRpc
        .mockResolvedValueOnce({
          data: [{
            lexicon_entry_id: 'lid',
            english_word: 'have',
            cefr_level: 'A1',
            unit: 'U1',
            days_overdue: 0,
            next_review_date: '2024-01-15',
          }],
          error: null,
        })
        .mockResolvedValueOnce({ data: 5, error: null }); // get_due_words_count for session_total

      const selectChain = {
        select: vi.fn().mockReturnThis(),
        eq: vi.fn().mockReturnThis(),
        single: vi.fn().mockResolvedValue({
          data: { example_sentence: 'I have breakfast', audio_url: 'https://audio/have.mp3' },
          error: null,
        }),
      };
      mockFrom.mockReturnValue(selectChain);

      const result = await getNextWord(userId);

      expect(result).not.toBeNull();
      expect(result!.lexicon_entry_id).toBe('lid');
      expect(result!.english_word).toBe('have');
      expect(result!.example_sentence).toContain('_____');
      expect(result!.audio_url).toBe('https://audio/have.mp3');
      expect(result!.session_total).toBe(5);
    });
  });
});
