-- Active Lexicon Engine - get_lexicon_entries for Lexicon API
-- Returns paginated Master_Lexicon with optional User_Vocabulary_Progress for a user

CREATE OR REPLACE FUNCTION public.get_lexicon_entries(
  _user_id UUID,
  _search TEXT DEFAULT NULL,
  _cefr_levels TEXT[] DEFAULT NULL,
  _units TEXT[] DEFAULT NULL,
  _statuses TEXT[] DEFAULT NULL,
  _limit INTEGER DEFAULT 50,
  _offset INTEGER DEFAULT 0
)
RETURNS TABLE (
  lexicon_entry_id UUID,
  english_word VARCHAR,
  cefr_level VARCHAR,
  unit VARCHAR,
  mastery_status VARCHAR,
  last_reviewed_date TIMESTAMP
)
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT
    ml.id AS lexicon_entry_id,
    ml.english_word,
    ml.cefr_level,
    ml.unit,
    COALESCE(uvp.status, 'New')::VARCHAR AS mastery_status,
    uvp.updated_at AS last_reviewed_date
  FROM public.Master_Lexicon ml
  LEFT JOIN public.User_Vocabulary_Progress uvp
    ON uvp.lexicon_entry_id = ml.id AND uvp.user_id = _user_id
  WHERE
    (_search IS NULL OR _search = '' OR ml.english_word ILIKE '%' || _search || '%')
    AND (_cefr_levels IS NULL OR array_length(_cefr_levels, 1) IS NULL OR ml.cefr_level = ANY(_cefr_levels))
    AND (_units IS NULL OR array_length(_units, 1) IS NULL OR ml.unit = ANY(_units))
    AND (
      _statuses IS NULL OR array_length(_statuses, 1) IS NULL
      OR COALESCE(uvp.status, 'New') = ANY(_statuses)
    )
  ORDER BY ml.english_word ASC
  LIMIT _limit OFFSET _offset;
$$;

-- Count for pagination (same filters)
CREATE OR REPLACE FUNCTION public.get_lexicon_entries_count(
  _user_id UUID,
  _search TEXT DEFAULT NULL,
  _cefr_levels TEXT[] DEFAULT NULL,
  _units TEXT[] DEFAULT NULL,
  _statuses TEXT[] DEFAULT NULL
)
RETURNS BIGINT
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT COUNT(*)::BIGINT
  FROM public.Master_Lexicon ml
  LEFT JOIN public.User_Vocabulary_Progress uvp
    ON uvp.lexicon_entry_id = ml.id AND uvp.user_id = _user_id
  WHERE
    (_search IS NULL OR _search = '' OR ml.english_word ILIKE '%' || _search || '%')
    AND (_cefr_levels IS NULL OR array_length(_cefr_levels, 1) IS NULL OR ml.cefr_level = ANY(_cefr_levels))
    AND (_units IS NULL OR array_length(_units, 1) IS NULL OR ml.unit = ANY(_units))
    AND (
      _statuses IS NULL OR array_length(_statuses, 1) IS NULL
      OR COALESCE(uvp.status, 'New') = ANY(_statuses)
    );
$$;

COMMENT ON FUNCTION public.get_lexicon_entries IS 'Returns paginated lexicon entries with user progress for Lexicon Hub';
COMMENT ON FUNCTION public.get_lexicon_entries_count IS 'Returns total count for lexicon entries with same filters';

-- Session stats for practice (today's activity from audit log)
CREATE OR REPLACE FUNCTION public.get_practice_session_stats(
  _user_id UUID
)
RETURNS TABLE (
  total_words_reviewed BIGINT,
  average_ease_factor NUMERIC,
  words_mastered_today BIGINT
)
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT
    COUNT(*)::BIGINT AS total_words_reviewed,
    COALESCE(AVG(new_ease_factor), 0)::NUMERIC AS average_ease_factor,
    COUNT(*) FILTER (WHERE new_status = 'Mastered')::BIGINT AS words_mastered_today
  FROM public.Audit_Log
  WHERE user_id = _user_id
    AND action = 'grade_submitted'
    AND timestamp::DATE = CURRENT_DATE;
$$;

COMMENT ON FUNCTION public.get_practice_session_stats IS 'Returns today''s practice session stats for the user';
