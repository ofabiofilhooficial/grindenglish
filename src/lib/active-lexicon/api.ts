/**
 * Active Lexicon Engine – API layer
 * Calls Supabase RPCs and tables as specified in design.md.
 */

import { supabase } from '@/integrations/supabase/client';
import { parseCloze } from '@/lib/parsers';

const LOG_TIMING =
  typeof import.meta !== 'undefined' &&
  import.meta.env &&
  String(import.meta.env.VITE_ACTIVE_LEXICON_LOG_TIMING) === 'true';

async function withTiming<T>(label: string, fn: () => Promise<T>): Promise<T> {
  if (!LOG_TIMING) return fn();
  const start = performance.now();
  try {
    const result = await fn();
    const ms = Math.round(performance.now() - start);
    console.log(`[Active Lexicon] ${label}: ${ms}ms`);
    return result;
  } catch (e) {
    const ms = Math.round(performance.now() - start);
    console.warn(`[Active Lexicon] ${label}: ${ms}ms (error)`);
    throw e;
  }
}
import type {
  DashboardMetrics,
  DueWordsResponse,
  LexiconEntriesResponse,
  LexiconEntryDetail,
  LexiconFilters,
  NextWordResponse,
  GradeResponse,
  SessionStatsResponse,
  StartLearningResponse,
} from './types';

const CACHE_TTL_MS = 30_000;

// In-memory cache for dashboard metrics (per user)
let metricsCache: { userId: string; data: DashboardMetrics; at: number } | null = null;

function getCachedMetrics(userId: string): DashboardMetrics | null {
  if (!metricsCache || metricsCache.userId !== userId) return null;
  if (Date.now() - metricsCache.at > CACHE_TTL_MS) return null;
  return { ...metricsCache.data, cache_timestamp: new Date(metricsCache.at).toISOString() };
}

function setCachedMetrics(userId: string, data: DashboardMetrics): void {
  metricsCache = { userId, data, at: Date.now() };
}

export function invalidateMetricsCache(): void {
  metricsCache = null;
}

// ─── Dashboard API ───────────────────────────────────────────────────────────

export async function getDashboardMetrics(userId: string): Promise<DashboardMetrics> {
  const cached = getCachedMetrics(userId);
  if (cached) return cached;

  return withTiming('get_dashboard_metrics', async () => {
  const { data, error } = await supabase.rpc('get_dashboard_metrics', {
    _user_id: userId,
  });

  if (error) throw new Error(error.message);

  const row = Array.isArray(data) ? data[0] : data;
  if (!row) {
    const empty: DashboardMetrics = {
      total_words_unlocked: 0,
      words_in_learning: 0,
      words_mastered: 0,
      cache_timestamp: new Date().toISOString(),
    };
    setCachedMetrics(userId, empty);
    return empty;
  }

  const result: DashboardMetrics = {
    total_words_unlocked: Number(row.total_words_unlocked ?? 0),
    words_in_learning: Number(row.words_in_learning ?? 0),
    words_mastered: Number(row.words_mastered ?? 0),
    cache_timestamp: new Date().toISOString(),
  };
  setCachedMetrics(userId, result);
  return result;
  });
}

export async function getDueWords(
  userId: string,
  page: number = 1,
  limit: number = 20
): Promise<DueWordsResponse> {
  return withTiming('get_due_words', async () => {
  const safeLimit = Math.min(100, Math.max(1, limit));
  const offset = (Math.max(1, page) - 1) * safeLimit;

  const [{ data: countData, error: countError }, { data: itemsData, error: itemsError }] =
    await Promise.all([
      supabase.rpc('get_due_words_count', { _user_id: userId }),
      supabase.rpc('get_due_words', {
        _user_id: userId,
        _limit: safeLimit,
        _offset: offset,
      }),
    ]);

  if (countError) throw new Error(countError.message);
  if (itemsError) throw new Error(itemsError.message);

  const totalCount = Number(countData ?? 0);
  const items = (itemsData ?? []).map((row: Record<string, unknown>) => ({
    lexicon_entry_id: String(row.lexicon_entry_id),
    english_word: String(row.english_word),
    cefr_level: String(row.cefr_level),
    unit: String(row.unit),
    days_overdue: Number(row.days_overdue ?? 0),
    next_review_date: String(row.next_review_date),
  }));

  return {
    items,
    total_count: totalCount,
    page: Math.max(1, page),
    limit: safeLimit,
  };
  });
}

// ─── Lexicon API ─────────────────────────────────────────────────────────────

export async function getLexiconEntries(
  userId: string,
  filters: LexiconFilters = {},
  page: number = 1,
  limit: number = 50
): Promise<LexiconEntriesResponse> {
  const safeLimit = Math.min(100, Math.max(1, limit));
  const offset = (Math.max(1, page) - 1) * safeLimit;

  const params = {
    _user_id: userId,
    _search: filters.search?.trim() || null,
    _cefr_levels: filters.cefr_levels?.length ? filters.cefr_levels : null,
    _units: filters.units?.length ? filters.units : null,
    _statuses: filters.statuses?.length ? filters.statuses : null,
    _limit: safeLimit,
    _offset: offset,
  };

  const countParams = {
    _user_id: userId,
    _search: params._search,
    _cefr_levels: params._cefr_levels,
    _units: params._units,
    _statuses: params._statuses,
  };

  const [{ data: countData, error: countError }, { data: itemsData, error: itemsError }] =
    await Promise.all([
      supabase.rpc('get_lexicon_entries_count', countParams),
      supabase.rpc('get_lexicon_entries', params),
    ]);

  if (countError) throw new Error(countError.message);
  if (itemsError) throw new Error(itemsError.message);

  const totalCount = Number(countData ?? 0);
  const items = (itemsData ?? []).map((row: Record<string, unknown>) => ({
    lexicon_entry_id: String(row.lexicon_entry_id),
    english_word: String(row.english_word),
    cefr_level: String(row.cefr_level),
    unit: String(row.unit),
    mastery_status: String(row.mastery_status ?? 'New'),
    last_reviewed_date: row.last_reviewed_date != null ? String(row.last_reviewed_date) : null,
  }));

  return {
    items,
    total_count: totalCount,
    page: Math.max(1, page),
    limit: safeLimit,
  };
}

export async function getLexiconEntryById(
  userId: string,
  entryId: string
): Promise<LexiconEntryDetail | null> {
  const { data: lex, error: lexError } = await (supabase as any)
    .from('master_lexicon')
    .select('id, english_word, definition, example_sentence, cefr_level, unit, audio_url, l1_notes')
    .eq('id', entryId)
    .single();

  if (lexError || !lex) return null;

  const { data: progress } = await (supabase as any)
    .from('user_vocabulary_progress')
    .select('status')
    .eq('user_id', userId)
    .eq('lexicon_entry_id', entryId)
    .maybeSingle();

  return {
    lexicon_entry_id: lex.id,
    english_word: lex.english_word,
    definition: lex.definition,
    example_sentence: lex.example_sentence,
    cefr_level: lex.cefr_level,
    unit: lex.unit,
    audio_url: lex.audio_url ?? null,
    l1_notes: lex.l1_notes ?? null,
    mastery_status: (progress?.status ?? 'New') as 'New' | 'Learning' | 'Mastered',
  };
}

export async function startLearning(
  userId: string,
  entryId: string
): Promise<StartLearningResponse> {
  const { data, error } = await supabase.rpc('initialize_vocabulary_progress', {
    _user_id: userId,
    _lexicon_entry_id: entryId,
  });

  if (error) throw new Error(error.message);

  const row = Array.isArray(data) ? data[0] : data;
  if (!row) throw new Error('Failed to initialize vocabulary progress');

  return {
    lexicon_entry_id: entryId,
    status: String(row.status ?? 'New') as 'New' | 'Learning' | 'Mastered',
    ease_factor: Number(row.ease_factor ?? 2.5),
    interval_days: Number(row.interval_days ?? 1),
    next_review_date: String(row.next_review_date),
  };
}

// ─── Practice API ─────────────────────────────────────────────────────────────

export async function getNextWord(userId: string): Promise<NextWordResponse | null> {
  const { data, error } = await supabase.rpc('get_due_words', {
    _user_id: userId,
    _limit: 1,
    _offset: 0,
  });

  if (error) throw new Error(error.message);

  const rows = data ?? [];
  if (rows.length === 0) return null;

  const row = rows[0] as Record<string, unknown>;
  const lexiconEntryId = String(row.lexicon_entry_id);
  const englishWord = String(row.english_word);

  const { data: fullEntry } = await (supabase as any)
    .from('master_lexicon')
    .select('example_sentence, audio_url')
    .eq('id', lexiconEntryId)
    .single();

  const exampleSentence = fullEntry?.example_sentence ?? '';
  const clozeSentence =
    exampleSentence && englishWord
      ? parseCloze(exampleSentence, englishWord)
      : '_____';

  const { data: countData } = await supabase.rpc('get_due_words_count', { _user_id: userId });
  const sessionTotal = Number(countData ?? 0);

  return {
    lexicon_entry_id: lexiconEntryId,
    english_word: englishWord,
    example_sentence: clozeSentence,
    audio_url: fullEntry?.audio_url ?? null,
    session_position: 1,
    session_total: sessionTotal,
  };
}

export async function submitGrade(
  userId: string,
  lexiconEntryId: string,
  grade: 'Hard' | 'Good' | 'Easy'
): Promise<GradeResponse> {
  return withTiming('update_srs_progress', async () => {
  const { data, error } = await supabase.rpc('update_srs_progress', {
    _user_id: userId,
    _lexicon_entry_id: lexiconEntryId,
    _grade: grade,
  });

  if (error) throw new Error(error.message);
  invalidateMetricsCache();

  const row = Array.isArray(data) ? data[0] : data;
  if (!row) throw new Error('Failed to update progress');

  return {
    status: String(row.status) as 'New' | 'Learning' | 'Mastered',
    ease_factor: Number(row.ease_factor),
    interval_days: Number(row.interval_days),
    next_review_date: String(row.next_review_date),
    consecutive_correct: Number(row.consecutive_correct),
    total_reviews: Number(row.total_reviews),
    message: String(row.message ?? ''),
  };
  });
}

export async function getSessionStats(userId: string): Promise<SessionStatsResponse> {
  const { data, error } = await supabase.rpc('get_practice_session_stats', {
    _user_id: userId,
  });

  if (error) throw new Error(error.message);

  const row = Array.isArray(data) ? data[0] : data;
  if (!row) {
    return {
      total_words_reviewed: 0,
      average_ease_factor: 0,
      words_mastered_today: 0,
      session_duration_minutes: 0,
    };
  }

  return {
    total_words_reviewed: Number(row.total_words_reviewed ?? 0),
    average_ease_factor: Number(row.average_ease_factor ?? 0),
    words_mastered_today: Number(row.words_mastered_today ?? 0),
    session_duration_minutes: Number(row.session_duration_minutes ?? 0),
  };
}
