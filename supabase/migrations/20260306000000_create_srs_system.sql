-- SRS Vocabulary Cards: Track individual word progress per user
CREATE TABLE public.srs_cards (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  word_id UUID NOT NULL REFERENCES public.lexicon_entries(id) ON DELETE CASCADE,
  ease_factor FLOAT NOT NULL DEFAULT 2.5,
  interval INT NOT NULL DEFAULT 0,
  repetitions INT NOT NULL DEFAULT 0,
  next_review_date TIMESTAMPTZ NOT NULL DEFAULT now(),
  last_reviewed_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE(user_id, word_id)
);

CREATE INDEX idx_srs_cards_user ON public.srs_cards(user_id);
CREATE INDEX idx_srs_cards_word ON public.srs_cards(word_id);
CREATE INDEX idx_srs_cards_next_review ON public.srs_cards(next_review_date);
CREATE INDEX idx_srs_cards_user_review ON public.srs_cards(user_id, next_review_date);

ALTER TABLE public.srs_cards ENABLE ROW LEVEL SECURITY;

-- Function: Update SRS card based on user rating (SM-2 Algorithm)
CREATE OR REPLACE FUNCTION public.update_srs_card(
  _card_id UUID,
  _user_rating INT
)
RETURNS TABLE (
  new_ease_factor FLOAT,
  new_interval INT,
  new_repetitions INT,
  new_next_review_date TIMESTAMPTZ
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_ease_factor FLOAT;
  v_interval INT;
  v_repetitions INT;
  v_next_review TIMESTAMPTZ;
BEGIN
  -- Get current values
  SELECT ease_factor, interval, repetitions
  INTO v_ease_factor, v_interval, v_repetitions
  FROM public.srs_cards
  WHERE id = _card_id;

  -- Apply SM-2 algorithm
  IF _user_rating < 3 THEN
    -- Forgot: Reset progress
    v_repetitions := 0;
    v_interval := 1;
    -- EF stays the same for MVP
  ELSE
    -- Remembered: Increment progress
    v_repetitions := v_repetitions + 1;
    
    -- Calculate new interval
    IF v_repetitions = 1 THEN
      v_interval := 1;
    ELSIF v_repetitions = 2 THEN
      v_interval := 6;
    ELSE
      v_interval := ROUND(v_interval * v_ease_factor)::INT;
    END IF;
    
    -- Update ease factor
    v_ease_factor := GREATEST(
      1.3,
      v_ease_factor + (0.1 - (5 - _user_rating) * (0.08 + (5 - _user_rating) * 0.02))
    );
  END IF;

  -- Calculate next review date
  v_next_review := now() + (v_interval || ' days')::INTERVAL;

  -- Update the card
  UPDATE public.srs_cards
  SET 
    ease_factor = v_ease_factor,
    interval = v_interval,
    repetitions = v_repetitions,
    next_review_date = v_next_review,
    last_reviewed_at = now(),
    updated_at = now()
  WHERE id = _card_id;

  -- Return new values
  RETURN QUERY
  SELECT v_ease_factor, v_interval, v_repetitions, v_next_review;
END;
$$;

-- Function: Get or create SRS card for a word
CREATE OR REPLACE FUNCTION public.get_or_create_srs_card(
  _user_id UUID,
  _word_id UUID
)
RETURNS UUID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_card_id UUID;
BEGIN
  -- Try to get existing card
  SELECT id INTO v_card_id
  FROM public.srs_cards
  WHERE user_id = _user_id AND word_id = _word_id;

  -- Create if doesn't exist
  IF v_card_id IS NULL THEN
    INSERT INTO public.srs_cards (user_id, word_id)
    VALUES (_user_id, _word_id)
    RETURNING id INTO v_card_id;
  END IF;

  RETURN v_card_id;
END;
$$;

-- Function: Get due cards count for a user
CREATE OR REPLACE FUNCTION public.get_due_cards_count(_user_id UUID)
RETURNS INT
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT COUNT(*)::INT
  FROM public.srs_cards
  WHERE user_id = _user_id
  AND next_review_date <= now();
$$;

-- Function: Update words_learned counter when card is reviewed
CREATE OR REPLACE FUNCTION public.update_words_learned_counter()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  -- Only count if this is the first time reviewing (repetitions went from 0 to 1+)
  IF OLD.repetitions = 0 AND NEW.repetitions > 0 THEN
    UPDATE public.learner_progress
    SET words_learned = words_learned + 1,
        updated_at = now()
    WHERE user_id = NEW.user_id;
  END IF;

  RETURN NEW;
END;
$$;

-- Trigger: Update words_learned when card is reviewed successfully
CREATE TRIGGER update_words_learned_on_review
  AFTER UPDATE ON public.srs_cards
  FOR EACH ROW
  WHEN (NEW.repetitions > OLD.repetitions)
  EXECUTE FUNCTION public.update_words_learned_counter();

-- RLS Policies: Users can only see their own cards
CREATE POLICY "Users can view own SRS cards"
  ON public.srs_cards FOR SELECT TO authenticated
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own SRS cards"
  ON public.srs_cards FOR INSERT TO authenticated
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own SRS cards"
  ON public.srs_cards FOR UPDATE TO authenticated
  USING (auth.uid() = user_id);

CREATE POLICY "Users can delete own SRS cards"
  ON public.srs_cards FOR DELETE TO authenticated
  USING (auth.uid() = user_id);

-- Content creators can view all cards for analytics
CREATE POLICY "Content creators view all SRS cards"
  ON public.srs_cards FOR SELECT TO authenticated
  USING (public.is_content_creator(auth.uid()));

-- Trigger: Update updated_at on srs_cards
CREATE TRIGGER update_srs_cards_updated_at
  BEFORE UPDATE ON public.srs_cards
  FOR EACH ROW
  EXECUTE FUNCTION public.update_updated_at();
