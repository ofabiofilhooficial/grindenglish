-- Progress Events: Log all user activity
CREATE TABLE public.progress_events (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  event_type TEXT NOT NULL, -- login, lesson_start, lesson_complete, grammar_view, vocab_view, etc.
  event_data JSONB DEFAULT '{}',
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_progress_events_user ON public.progress_events(user_id);
CREATE INDEX idx_progress_events_type ON public.progress_events(event_type);
CREATE INDEX idx_progress_events_created ON public.progress_events(created_at);

ALTER TABLE public.progress_events ENABLE ROW LEVEL SECURITY;

-- Learner Progress: Aggregated stats per user
CREATE TABLE public.learner_progress (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL UNIQUE REFERENCES auth.users(id) ON DELETE CASCADE,
  current_streak INT NOT NULL DEFAULT 0,
  longest_streak INT NOT NULL DEFAULT 0,
  last_activity_date DATE,
  total_study_time_minutes INT NOT NULL DEFAULT 0,
  words_learned INT NOT NULL DEFAULT 0,
  grammar_chapters_viewed INT NOT NULL DEFAULT 0,
  lessons_completed INT NOT NULL DEFAULT 0,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_learner_progress_user ON public.learner_progress(user_id);

ALTER TABLE public.learner_progress ENABLE ROW LEVEL SECURITY;

-- Function: Update streak on activity
CREATE OR REPLACE FUNCTION public.update_user_streak(_user_id UUID)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_last_activity DATE;
  v_current_streak INT;
  v_longest_streak INT;
  v_today DATE := CURRENT_DATE;
BEGIN
  -- Get or create learner_progress record
  INSERT INTO public.learner_progress (user_id, last_activity_date, current_streak, longest_streak)
  VALUES (_user_id, v_today, 1, 1)
  ON CONFLICT (user_id) DO NOTHING;

  -- Get current values
  SELECT last_activity_date, current_streak, longest_streak
  INTO v_last_activity, v_current_streak, v_longest_streak
  FROM public.learner_progress
  WHERE user_id = _user_id;

  -- Update streak logic
  IF v_last_activity IS NULL OR v_last_activity < v_today THEN
    -- First activity or new day
    IF v_last_activity = v_today - INTERVAL '1 day' THEN
      -- Consecutive day
      v_current_streak := v_current_streak + 1;
    ELSIF v_last_activity < v_today - INTERVAL '1 day' THEN
      -- Streak broken
      v_current_streak := 1;
    END IF;

    -- Update longest streak if needed
    IF v_current_streak > v_longest_streak THEN
      v_longest_streak := v_current_streak;
    END IF;

    -- Update the record
    UPDATE public.learner_progress
    SET 
      last_activity_date = v_today,
      current_streak = v_current_streak,
      longest_streak = v_longest_streak,
      updated_at = now()
    WHERE user_id = _user_id;
  END IF;
END;
$$;

-- Function: Log activity event and update streak
CREATE OR REPLACE FUNCTION public.log_activity_event(
  _user_id UUID,
  _event_type TEXT,
  _event_data JSONB DEFAULT '{}'
)
RETURNS UUID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_event_id UUID;
BEGIN
  -- Insert event
  INSERT INTO public.progress_events (user_id, event_type, event_data)
  VALUES (_user_id, _event_type, _event_data)
  RETURNING id INTO v_event_id;

  -- Update streak
  PERFORM public.update_user_streak(_user_id);

  RETURN v_event_id;
END;
$$;

-- RLS Policies: Users can only see their own progress
CREATE POLICY "Users can view own progress events"
  ON public.progress_events FOR SELECT TO authenticated
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own progress events"
  ON public.progress_events FOR INSERT TO authenticated
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can view own learner progress"
  ON public.learner_progress FOR SELECT TO authenticated
  USING (auth.uid() = user_id);

CREATE POLICY "Users can update own learner progress"
  ON public.learner_progress FOR UPDATE TO authenticated
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own learner progress"
  ON public.learner_progress FOR INSERT TO authenticated
  WITH CHECK (auth.uid() = user_id);

-- Content creators can view all progress for analytics
CREATE POLICY "Content creators view all progress events"
  ON public.progress_events FOR SELECT TO authenticated
  USING (public.is_content_creator(auth.uid()));

CREATE POLICY "Content creators view all learner progress"
  ON public.learner_progress FOR SELECT TO authenticated
  USING (public.is_content_creator(auth.uid()));

-- Trigger: Update updated_at on learner_progress
CREATE TRIGGER update_learner_progress_updated_at
  BEFORE UPDATE ON public.learner_progress
  FOR EACH ROW
  EXECUTE FUNCTION public.update_updated_at();
