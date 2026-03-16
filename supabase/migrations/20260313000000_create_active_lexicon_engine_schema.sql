-- Active Lexicon Engine - Database Schema and Migrations
-- This migration creates the core tables for the Spaced Repetition System (SRS)
-- as specified in the Active Lexicon Engine requirements

-- ============================================================================
-- Master_Lexicon Table
-- ============================================================================
-- Immutable, centralized repository of vocabulary entries
-- Each entry has a stable UUID that never changes

CREATE TABLE IF NOT EXISTS public.Master_Lexicon (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  english_word VARCHAR(255) NOT NULL UNIQUE,
  cefr_level VARCHAR(2) NOT NULL CHECK (cefr_level IN ('A1', 'A2', 'B1', 'B2', 'C1', 'C2')),
  unit VARCHAR(255) NOT NULL,
  definition TEXT NOT NULL,
  example_sentence TEXT NOT NULL,
  audio_url VARCHAR(2048),
  l1_notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for performance optimization
CREATE INDEX IF NOT EXISTS idx_master_lexicon_cefr ON public.Master_Lexicon(cefr_level);
CREATE INDEX IF NOT EXISTS idx_master_lexicon_unit ON public.Master_Lexicon(unit);
CREATE INDEX IF NOT EXISTS idx_master_lexicon_word ON public.Master_Lexicon(english_word);

-- ============================================================================
-- User_Vocabulary_Progress Table
-- ============================================================================
-- Tracks individual user progress for each vocabulary item
-- This is the mutable counterpart to Master_Lexicon

CREATE TABLE IF NOT EXISTS public.User_Vocabulary_Progress (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  lexicon_entry_id UUID NOT NULL REFERENCES public.Master_Lexicon(id) ON DELETE CASCADE,
  status VARCHAR(20) NOT NULL DEFAULT 'New' CHECK (status IN ('New', 'Learning', 'Mastered')),
  ease_factor DECIMAL(3, 2) NOT NULL DEFAULT 2.5 CHECK (ease_factor >= 1.3 AND ease_factor <= 2.5),
  interval_days INTEGER NOT NULL DEFAULT 1 CHECK (interval_days >= 1),
  next_review_date DATE NOT NULL DEFAULT CURRENT_DATE,
  total_reviews INTEGER NOT NULL DEFAULT 0 CHECK (total_reviews >= 0),
  consecutive_correct INTEGER NOT NULL DEFAULT 0 CHECK (consecutive_correct >= 0),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE(user_id, lexicon_entry_id)
);

-- Composite index for due words query (critical for performance)
CREATE INDEX IF NOT EXISTS idx_uvp_user_next_review ON public.User_Vocabulary_Progress(user_id, next_review_date);

-- Additional indexes for common queries
CREATE INDEX IF NOT EXISTS idx_uvp_user_status ON public.User_Vocabulary_Progress(user_id, status);
CREATE INDEX IF NOT EXISTS idx_uvp_user_id ON public.User_Vocabulary_Progress(user_id);

-- ============================================================================
-- Audit_Log Table
-- ============================================================================
-- Tracks all grade submissions and status changes for audit purposes

CREATE TABLE IF NOT EXISTS public.Audit_Log (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  lexicon_entry_id UUID NOT NULL REFERENCES public.Master_Lexicon(id) ON DELETE CASCADE,
  action VARCHAR(50) NOT NULL CHECK (action IN ('grade_submitted', 'status_changed', 'initialized', 'mastered', 'demoted')),
  grade VARCHAR(10) CHECK (grade IN ('Hard', 'Good', 'Easy', NULL)),
  previous_status VARCHAR(20),
  new_status VARCHAR(20),
  previous_ease_factor DECIMAL(3, 2),
  new_ease_factor DECIMAL(3, 2),
  previous_interval_days INTEGER,
  new_interval_days INTEGER,
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  ip_address VARCHAR(45),
  user_agent TEXT
);

-- Indexes for audit log queries
CREATE INDEX IF NOT EXISTS idx_audit_log_user ON public.Audit_Log(user_id);
CREATE INDEX IF NOT EXISTS idx_audit_log_lexicon ON public.Audit_Log(lexicon_entry_id);
CREATE INDEX IF NOT EXISTS idx_audit_log_timestamp ON public.Audit_Log(timestamp);
CREATE INDEX IF NOT EXISTS idx_audit_log_action ON public.Audit_Log(action);

-- ============================================================================
-- Row Level Security (RLS) Policies
-- ============================================================================

-- Enable RLS on all tables
ALTER TABLE public.Master_Lexicon ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.User_Vocabulary_Progress ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.Audit_Log ENABLE ROW LEVEL SECURITY;

-- Master_Lexicon: Everyone can read, only admins can write
CREATE POLICY "Master_Lexicon read policy"
  ON public.Master_Lexicon FOR SELECT
  USING (true);

CREATE POLICY "Master_Lexicon write policy"
  ON public.Master_Lexicon FOR INSERT
  WITH CHECK (public.is_content_creator(auth.uid()));

CREATE POLICY "Master_Lexicon update policy"
  ON public.Master_Lexicon FOR UPDATE
  USING (public.is_content_creator(auth.uid()));

-- User_Vocabulary_Progress: Users can only see their own progress
CREATE POLICY "User_Vocabulary_Progress read policy"
  ON public.User_Vocabulary_Progress FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "User_Vocabulary_Progress insert policy"
  ON public.User_Vocabulary_Progress FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "User_Vocabulary_Progress update policy"
  ON public.User_Vocabulary_Progress FOR UPDATE
  USING (auth.uid() = user_id);

CREATE POLICY "User_Vocabulary_Progress delete policy"
  ON public.User_Vocabulary_Progress FOR DELETE
  USING (auth.uid() = user_id);

-- Audit_Log: Users can read their own logs, admins can read all
CREATE POLICY "Audit_Log read own policy"
  ON public.Audit_Log FOR SELECT
  USING (auth.uid() = user_id OR public.is_content_creator(auth.uid()));

CREATE POLICY "Audit_Log insert policy"
  ON public.Audit_Log FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- ============================================================================
-- Helper Functions
-- ============================================================================

-- Function to initialize vocabulary progress for a user
CREATE OR REPLACE FUNCTION public.initialize_vocabulary_progress(
  _user_id UUID,
  _lexicon_entry_id UUID
)
RETURNS TABLE (
  id UUID,
  status VARCHAR,
  ease_factor DECIMAL,
  interval_days INTEGER,
  next_review_date DATE
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_entry_id UUID;
BEGIN
  -- Check if entry already exists
  SELECT id INTO v_entry_id
  FROM public.User_Vocabulary_Progress
  WHERE user_id = _user_id AND lexicon_entry_id = _lexicon_entry_id;

  -- If exists, return existing entry
  IF v_entry_id IS NOT NULL THEN
    RETURN QUERY
    SELECT 
      User_Vocabulary_Progress.id,
      User_Vocabulary_Progress.status,
      User_Vocabulary_Progress.ease_factor,
      User_Vocabulary_Progress.interval_days,
      User_Vocabulary_Progress.next_review_date
    FROM public.User_Vocabulary_Progress
    WHERE User_Vocabulary_Progress.id = v_entry_id;
    RETURN;
  END IF;

  -- Create new entry with initialization values
  INSERT INTO public.User_Vocabulary_Progress (
    user_id,
    lexicon_entry_id,
    status,
    ease_factor,
    interval_days,
    next_review_date,
    total_reviews,
    consecutive_correct
  )
  VALUES (
    _user_id,
    _lexicon_entry_id,
    'New',
    2.5,
    1,
    CURRENT_DATE,
    0,
    0
  )
  RETURNING 
    User_Vocabulary_Progress.id,
    User_Vocabulary_Progress.status,
    User_Vocabulary_Progress.ease_factor,
    User_Vocabulary_Progress.interval_days,
    User_Vocabulary_Progress.next_review_date
  INTO v_entry_id, v_entry_id, v_entry_id, v_entry_id, v_entry_id;

  RETURN QUERY
  SELECT 
    User_Vocabulary_Progress.id,
    User_Vocabulary_Progress.status,
    User_Vocabulary_Progress.ease_factor,
    User_Vocabulary_Progress.interval_days,
    User_Vocabulary_Progress.next_review_date
  FROM public.User_Vocabulary_Progress
  WHERE User_Vocabulary_Progress.user_id = _user_id 
    AND User_Vocabulary_Progress.lexicon_entry_id = _lexicon_entry_id;
END;
$$;

-- Function to get due words for a user
CREATE OR REPLACE FUNCTION public.get_due_words(
  _user_id UUID,
  _limit INTEGER DEFAULT 20,
  _offset INTEGER DEFAULT 0
)
RETURNS TABLE (
  lexicon_entry_id UUID,
  english_word VARCHAR,
  cefr_level VARCHAR,
  unit VARCHAR,
  days_overdue INTEGER,
  next_review_date DATE
)
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT 
    uvp.lexicon_entry_id,
    ml.english_word,
    ml.cefr_level,
    ml.unit,
    (CURRENT_DATE - uvp.next_review_date)::INTEGER AS days_overdue,
    uvp.next_review_date
  FROM public.User_Vocabulary_Progress uvp
  INNER JOIN public.Master_Lexicon ml ON uvp.lexicon_entry_id = ml.id
  WHERE uvp.user_id = _user_id 
    AND uvp.next_review_date <= CURRENT_DATE
  ORDER BY uvp.next_review_date ASC
  LIMIT _limit OFFSET _offset;
$$;

-- Function to get due words count for a user
CREATE OR REPLACE FUNCTION public.get_due_words_count(_user_id UUID)
RETURNS INTEGER
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT COUNT(*)::INTEGER
  FROM public.User_Vocabulary_Progress
  WHERE user_id = _user_id
    AND next_review_date <= CURRENT_DATE;
$$;

-- Function to get metrics for dashboard
CREATE OR REPLACE FUNCTION public.get_dashboard_metrics(_user_id UUID)
RETURNS TABLE (
  total_words_unlocked BIGINT,
  words_in_learning BIGINT,
  words_mastered BIGINT
)
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT 
    COUNT(CASE WHEN status != 'New' THEN 1 END) AS total_words_unlocked,
    COUNT(CASE WHEN status = 'Learning' THEN 1 END) AS words_in_learning,
    COUNT(CASE WHEN status = 'Mastered' THEN 1 END) AS words_mastered
  FROM public.User_Vocabulary_Progress
  WHERE user_id = _user_id;
$$;

-- ============================================================================
-- Triggers for automatic timestamp updates
-- ============================================================================

CREATE OR REPLACE FUNCTION public.update_updated_at()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
  NEW.updated_at = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$;

CREATE TRIGGER update_master_lexicon_updated_at
  BEFORE UPDATE ON public.Master_Lexicon
  FOR EACH ROW
  EXECUTE FUNCTION public.update_updated_at();

CREATE TRIGGER update_user_vocabulary_progress_updated_at
  BEFORE UPDATE ON public.User_Vocabulary_Progress
  FOR EACH ROW
  EXECUTE FUNCTION public.update_updated_at();

-- ============================================================================
-- Comments for documentation
-- ============================================================================

COMMENT ON TABLE public.Master_Lexicon IS 'Immutable, centralized repository of vocabulary entries with stable UUIDs';
COMMENT ON TABLE public.User_Vocabulary_Progress IS 'Tracks individual user progress for each vocabulary item';
COMMENT ON TABLE public.Audit_Log IS 'Audit trail for all grade submissions and status changes';

COMMENT ON COLUMN public.Master_Lexicon.id IS 'Stable UUID assigned at creation, never changes';
COMMENT ON COLUMN public.Master_Lexicon.english_word IS 'The vocabulary word (unique constraint ensures no duplicates)';
COMMENT ON COLUMN public.Master_Lexicon.cefr_level IS 'Difficulty level (A1-C2)';
COMMENT ON COLUMN public.Master_Lexicon.l1_notes IS 'Structured interference pattern notes (format: "term1 vs. term2: explanation")';

COMMENT ON COLUMN public.User_Vocabulary_Progress.status IS 'Current learning phase (New, Learning, Mastered)';
COMMENT ON COLUMN public.User_Vocabulary_Progress.ease_factor IS 'Adjustment factor for interval calculation (1.3-2.5)';
COMMENT ON COLUMN public.User_Vocabulary_Progress.interval_days IS 'Days until next review';
COMMENT ON COLUMN public.User_Vocabulary_Progress.next_review_date IS 'Calculated date for next review';
COMMENT ON COLUMN public.User_Vocabulary_Progress.consecutive_correct IS 'Count of consecutive successful recalls';
