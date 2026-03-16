-- Active Lexicon Engine - SRS Algorithm Functions
-- This migration creates the core SRS algorithm implementation

-- ============================================================================
-- SRS Algorithm Update Function
-- ============================================================================
-- Implements the Spaced Repetition System algorithm that adjusts review
-- intervals based on user performance (Hard, Good, Easy grades)

CREATE OR REPLACE FUNCTION public.update_srs_progress(
  _user_id UUID,
  _lexicon_entry_id UUID,
  _grade VARCHAR
)
RETURNS TABLE (
  status VARCHAR,
  ease_factor DECIMAL,
  interval_days INTEGER,
  next_review_date DATE,
  consecutive_correct INTEGER,
  total_reviews INTEGER,
  message TEXT
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_current_state RECORD;
  v_new_ease_factor DECIMAL(3, 2);
  v_new_interval_days INTEGER;
  v_new_consecutive_correct INTEGER;
  v_new_status VARCHAR(20);
  v_new_next_review_date DATE;
  v_message TEXT;
BEGIN
  -- Validate grade input
  IF _grade NOT IN ('Hard', 'Good', 'Easy') THEN
    RAISE EXCEPTION 'Invalid grade. Must be Hard, Good, or Easy.';
  END IF;

  -- Get current state
  SELECT 
    status,
    ease_factor,
    interval_days,
    consecutive_correct,
    total_reviews
  INTO v_current_state
  FROM public.User_Vocabulary_Progress
  WHERE user_id = _user_id AND lexicon_entry_id = _lexicon_entry_id
  FOR UPDATE;

  IF v_current_state IS NULL THEN
    RAISE EXCEPTION 'Vocabulary progress entry not found for user % and lexicon entry %', _user_id, _lexicon_entry_id;
  END IF;

  -- Apply SRS algorithm based on grade
  IF _grade = 'Hard' THEN
    -- Hard grade: Reset progress
    v_new_ease_factor := GREATEST(1.3, v_current_state.ease_factor - 0.2);
    v_new_interval_days := 1;
    v_new_consecutive_correct := 0;
    v_message := 'Keep practicing this word. It will appear again soon.';
  
  ELSIF _grade = 'Good' THEN
    -- Good grade: Maintain ease factor, increase interval
    v_new_ease_factor := v_current_state.ease_factor;
    v_new_interval_days := GREATEST(1, ROUND(v_current_state.interval_days * v_current_state.ease_factor)::INTEGER);
    v_new_consecutive_correct := v_current_state.consecutive_correct + 1;
    v_message := 'Nice work. You''ll see this word again in a few days.';
  
  ELSIF _grade = 'Easy' THEN
    -- Easy grade: Increase ease factor and interval
    v_new_ease_factor := LEAST(2.5, v_current_state.ease_factor + 0.1);
    v_new_interval_days := GREATEST(1, ROUND(v_current_state.interval_days * v_current_state.ease_factor * 1.3)::INTEGER);
    v_new_consecutive_correct := v_current_state.consecutive_correct + 1;
    v_message := 'Excellent. You''ve mastered this word.';
  END IF;

  -- Ensure interval_days is positive integer
  v_new_interval_days := GREATEST(1, v_new_interval_days);

  -- Calculate next review date
  v_new_next_review_date := CURRENT_DATE + (v_new_interval_days || ' days')::INTERVAL;

  -- Check for status transition to Mastered
  IF v_new_consecutive_correct >= 3 AND v_current_state.status != 'Mastered' THEN
    v_new_status := 'Mastered';
    v_new_interval_days := 30;
    v_new_next_review_date := CURRENT_DATE + INTERVAL '30 days';
  
  -- Handle demotion from Mastered
  ELSIF v_current_state.status = 'Mastered' AND _grade = 'Hard' THEN
    v_new_status := 'Learning';
    v_new_consecutive_correct := 0;
    v_new_interval_days := 1;
    v_new_next_review_date := CURRENT_DATE + INTERVAL '1 day';
  
  -- Transition from New to Learning
  ELSIF v_current_state.status = 'New' THEN
    v_new_status := 'Learning';
  
  ELSE
    v_new_status := v_current_state.status;
  END IF;

  -- Update User_Vocabulary_Progress atomically
  UPDATE public.User_Vocabulary_Progress
  SET 
    status = v_new_status,
    ease_factor = v_new_ease_factor,
    interval_days = v_new_interval_days,
    next_review_date = v_new_next_review_date,
    consecutive_correct = v_new_consecutive_correct,
    total_reviews = total_reviews + 1,
    updated_at = CURRENT_TIMESTAMP
  WHERE user_id = _user_id AND lexicon_entry_id = _lexicon_entry_id;

  -- Log to audit trail
  INSERT INTO public.Audit_Log (
    user_id,
    lexicon_entry_id,
    action,
    grade,
    previous_status,
    new_status,
    previous_ease_factor,
    new_ease_factor,
    previous_interval_days,
    new_interval_days
  )
  VALUES (
    _user_id,
    _lexicon_entry_id,
    'grade_submitted',
    _grade,
    v_current_state.status,
    v_new_status,
    v_current_state.ease_factor,
    v_new_ease_factor,
    v_current_state.interval_days,
    v_new_interval_days
  );

  -- Return updated state
  RETURN QUERY
  SELECT 
    v_new_status::VARCHAR,
    v_new_ease_factor,
    v_new_interval_days,
    v_new_next_review_date,
    v_new_consecutive_correct,
    v_current_state.total_reviews + 1,
    v_message;
END;
$$;

-- ============================================================================
-- Cloze Parser Function
-- ============================================================================
-- Parses Example_Sentence to generate cloze flashcard by replacing target word with blank

CREATE OR REPLACE FUNCTION public.parse_cloze(
  _example_sentence TEXT,
  _target_word TEXT
)
RETURNS TEXT
LANGUAGE plpgsql
IMMUTABLE
AS $$
DECLARE
  v_sentence_lower TEXT;
  v_target_lower TEXT;
  v_index INTEGER;
  v_start_index INTEGER;
  v_end_index INTEGER;
  v_cloze_sentence TEXT;
BEGIN
  -- Normalize for case-insensitive matching
  v_sentence_lower := LOWER(_example_sentence);
  v_target_lower := LOWER(_target_word);

  -- Find first occurrence of target word
  v_index := POSITION(v_target_lower IN v_sentence_lower);

  IF v_index = 0 THEN
    RAISE EXCEPTION 'Target word not found in example sentence';
  END IF;

  -- Calculate start and end positions (1-indexed in PostgreSQL)
  v_start_index := v_index;
  v_end_index := v_index + LENGTH(_target_word);

  -- Check for attached punctuation
  WHILE v_end_index <= LENGTH(_example_sentence) + 1 AND 
        SUBSTRING(_example_sentence, v_end_index, 1) IN ('.', ',', '!', '?', ';', ':') LOOP
    v_end_index := v_end_index + 1;
  END LOOP;

  -- Replace with blank
  v_cloze_sentence := SUBSTRING(_example_sentence, 1, v_start_index - 1) || 
                      '_____ ' || 
                      SUBSTRING(_example_sentence, v_end_index);

  RETURN v_cloze_sentence;
END;
$$;

-- ============================================================================
-- Cloze Serializer Function
-- ============================================================================
-- Restores cloze sentence to complete sentence for verification

CREATE OR REPLACE FUNCTION public.serialize_cloze(
  _cloze_sentence TEXT,
  _target_word TEXT
)
RETURNS TEXT
LANGUAGE plpgsql
IMMUTABLE
AS $$
DECLARE
  v_blank_index INTEGER;
  v_complete_sentence TEXT;
BEGIN
  -- Find blank placeholder
  v_blank_index := POSITION('_____' IN _cloze_sentence);

  IF v_blank_index = 0 THEN
    RAISE EXCEPTION 'Cloze blank not found';
  END IF;

  -- Replace blank with target word
  v_complete_sentence := SUBSTRING(_cloze_sentence, 1, v_blank_index - 1) ||
                         _target_word ||
                         SUBSTRING(_cloze_sentence, v_blank_index + 5);

  -- Clean up extra spaces
  v_complete_sentence := TRIM(REGEXP_REPLACE(v_complete_sentence, '\s+', ' ', 'g'));

  RETURN v_complete_sentence;
END;
$$;

-- ============================================================================
-- L1 Notes Parser Function
-- ============================================================================
-- Parses structured L1_Notes to extract interference pattern and explanation
-- Format: "term1 vs. term2: explanation"

CREATE OR REPLACE FUNCTION public.parse_l1_notes(
  _l1_notes_text TEXT
)
RETURNS TABLE (
  term1 TEXT,
  term2 TEXT,
  explanation TEXT
)
LANGUAGE plpgsql
IMMUTABLE
AS $$
DECLARE
  v_parts TEXT[];
  v_terms_part TEXT;
  v_explanation TEXT;
  v_terms TEXT[];
BEGIN
  -- Check for required separator
  IF POSITION(':' IN _l1_notes_text) = 0 THEN
    RAISE EXCEPTION 'Invalid L1_Notes format. Expected ''term1 vs. term2: explanation''';
  END IF;

  -- Split on colon
  v_parts := STRING_TO_ARRAY(_l1_notes_text, ':');
  v_terms_part := TRIM(v_parts[1]);
  v_explanation := TRIM(v_parts[2]);

  -- Parse terms
  IF POSITION(' vs. ' IN v_terms_part) = 0 THEN
    RAISE EXCEPTION 'Invalid L1_Notes format. Expected ''term1 vs. term2: explanation''';
  END IF;

  v_terms := STRING_TO_ARRAY(v_terms_part, ' vs. ');

  RETURN QUERY
  SELECT 
    TRIM(v_terms[1])::TEXT,
    TRIM(v_terms[2])::TEXT,
    v_explanation::TEXT;
END;
$$;

-- ============================================================================
-- L1 Notes Serializer Function
-- ============================================================================
-- Formats parsed L1_Notes back into human-readable text

CREATE OR REPLACE FUNCTION public.serialize_l1_notes(
  _term1 TEXT,
  _term2 TEXT,
  _explanation TEXT
)
RETURNS TEXT
LANGUAGE plpgsql
IMMUTABLE
AS $$
BEGIN
  RETURN _term1 || ' vs. ' || _term2 || ': ' || _explanation;
END;
$$;

-- ============================================================================
-- Comments for documentation
-- ============================================================================

COMMENT ON FUNCTION public.update_srs_progress IS 'Implements the Spaced Repetition System algorithm that adjusts review intervals based on user performance';
COMMENT ON FUNCTION public.parse_cloze IS 'Parses Example_Sentence to generate cloze flashcard by replacing target word with blank';
COMMENT ON FUNCTION public.serialize_cloze IS 'Restores cloze sentence to complete sentence for verification';
COMMENT ON FUNCTION public.parse_l1_notes IS 'Parses structured L1_Notes to extract interference pattern and explanation';
COMMENT ON FUNCTION public.serialize_l1_notes IS 'Formats parsed L1_Notes back into human-readable text';
