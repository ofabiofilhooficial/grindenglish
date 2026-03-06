-- Fix words_learned counter to be more robust
-- Issue: The counter might reset or not increment properly

-- Improved trigger: Only count unique words that have been successfully reviewed at least once
CREATE OR REPLACE FUNCTION public.update_words_learned_counter()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  -- Count if this is the first successful review (repetitions went from 0 to 1+)
  -- This means the user successfully recalled the word for the first time
  IF OLD.repetitions = 0 AND NEW.repetitions >= 1 THEN
    -- Ensure learner_progress record exists
    INSERT INTO public.learner_progress (user_id, words_learned)
    VALUES (NEW.user_id, 1)
    ON CONFLICT (user_id) DO UPDATE
    SET words_learned = public.learner_progress.words_learned + 1,
        updated_at = now();
  END IF;

  RETURN NEW;
END;
$$;

-- Function: Recalculate words_learned from scratch (for fixing corrupted data)
CREATE OR REPLACE FUNCTION public.recalculate_words_learned(_user_id UUID)
RETURNS INT
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_count INT;
BEGIN
  -- Count unique words that have been successfully reviewed at least once
  SELECT COUNT(*)::INT INTO v_count
  FROM public.srs_cards
  WHERE user_id = _user_id
  AND repetitions > 0;

  -- Update learner_progress
  UPDATE public.learner_progress
  SET words_learned = v_count,
      updated_at = now()
  WHERE user_id = _user_id;

  -- If no record exists, create one
  IF NOT FOUND THEN
    INSERT INTO public.learner_progress (user_id, words_learned)
    VALUES (_user_id, v_count);
  END IF;

  RETURN v_count;
END;
$$;

-- Function: Fix all users' words_learned counters (admin utility)
CREATE OR REPLACE FUNCTION public.fix_all_words_learned_counters()
RETURNS TABLE (
  user_id UUID,
  old_count INT,
  new_count INT
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  RETURN QUERY
  WITH user_counts AS (
    SELECT 
      sc.user_id,
      COUNT(*)::INT as actual_count
    FROM public.srs_cards sc
    WHERE sc.repetitions > 0
    GROUP BY sc.user_id
  ),
  updates AS (
    UPDATE public.learner_progress lp
    SET words_learned = uc.actual_count,
        updated_at = now()
    FROM user_counts uc
    WHERE lp.user_id = uc.user_id
    AND lp.words_learned != uc.actual_count
    RETURNING lp.user_id, lp.words_learned as old_count, uc.actual_count as new_count
  )
  SELECT * FROM updates;
END;
$$;

COMMENT ON FUNCTION public.recalculate_words_learned(_user_id UUID) IS 
  'Recalculates words_learned counter for a specific user based on SRS cards with repetitions > 0';

COMMENT ON FUNCTION public.fix_all_words_learned_counters() IS 
  'Admin utility to fix words_learned counters for all users. Returns users whose counts were corrected.';
