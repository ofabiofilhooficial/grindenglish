/**
 * Active Lexicon Engine – API types
 * Matches design.md response/request shapes.
 */

export type CefrLevel = 'A1' | 'A2' | 'B1' | 'B2' | 'C1' | 'C2';
export type MasteryStatus = 'New' | 'Learning' | 'Mastered';
export type Grade = 'Hard' | 'Good' | 'Easy';

// ─── Dashboard API ───────────────────────────────────────────────────────────

export interface DashboardMetrics {
  total_words_unlocked: number;
  words_in_learning: number;
  words_mastered: number;
  cache_timestamp?: string;
}

export interface DueWordQueueItem {
  lexicon_entry_id: string;
  english_word: string;
  cefr_level: string;
  unit: string;
  days_overdue: number;
  next_review_date: string;
}

export interface DueWordsResponse {
  items: DueWordQueueItem[];
  total_count: number;
  page: number;
  limit: number;
}

// ─── Lexicon API ─────────────────────────────────────────────────────────────

export interface LexiconEntryListItem {
  lexicon_entry_id: string;
  english_word: string;
  cefr_level: string;
  unit: string;
  mastery_status: MasteryStatus;
  last_reviewed_date: string | null;
}

export interface LexiconEntriesResponse {
  items: LexiconEntryListItem[];
  total_count: number;
  page: number;
  limit: number;
}

export interface LexiconEntryDetail {
  lexicon_entry_id: string;
  english_word: string;
  definition: string;
  example_sentence: string;
  cefr_level: string;
  unit: string;
  audio_url: string | null;
  l1_notes: string | null;
  mastery_status: MasteryStatus;
}

export interface StartLearningResponse {
  lexicon_entry_id: string;
  status: MasteryStatus;
  ease_factor: number;
  interval_days: number;
  next_review_date: string;
}

// ─── Practice API ─────────────────────────────────────────────────────────────

export interface NextWordResponse {
  lexicon_entry_id: string;
  english_word: string;
  example_sentence: string; // cloze (blank)
  audio_url: string | null;
  session_position: number;
  session_total: number;
}

export interface GradeResponse {
  status: MasteryStatus;
  ease_factor: number;
  interval_days: number;
  next_review_date: string;
  consecutive_correct: number;
  total_reviews: number;
  message: string;
}

export interface SessionStatsResponse {
  total_words_reviewed: number;
  average_ease_factor: number;
  words_mastered_today: number;
  session_duration_minutes: number;
}

// ─── Filters ────────────────────────────────────────────────────────────────

export interface LexiconFilters {
  search?: string;
  cefr_levels?: CefrLevel[];
  units?: string[];
  statuses?: MasteryStatus[];
}
