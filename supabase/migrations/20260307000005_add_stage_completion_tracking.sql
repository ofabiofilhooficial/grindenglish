-- Add Stage Completion Tracking
-- Tracks when students complete lesson stages

CREATE TABLE IF NOT EXISTS public.user_stage_completions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  lesson_id UUID NOT NULL REFERENCES public.lessons(id) ON DELETE CASCADE,
  stage_id UUID NOT NULL REFERENCES public.lesson_stages(id) ON DELETE CASCADE,
  completed_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE(user_id, stage_id)
);

CREATE INDEX idx_user_stage_completions_user ON public.user_stage_completions(user_id);
CREATE INDEX idx_user_stage_completions_lesson ON public.user_stage_completions(lesson_id);
CREATE INDEX idx_user_stage_completions_stage ON public.user_stage_completions(stage_id);

ALTER TABLE public.user_stage_completions ENABLE ROW LEVEL SECURITY;

-- RLS Policies
CREATE POLICY "Users can view own stage completions"
  ON public.user_stage_completions FOR SELECT
  TO authenticated
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own stage completions"
  ON public.user_stage_completions FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

-- Function to mark stage as complete
CREATE OR REPLACE FUNCTION public.complete_stage(
  _stage_id UUID
)
RETURNS BOOLEAN
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  _lesson_id UUID;
BEGIN
  -- Get lesson_id from stage
  SELECT lesson_id INTO _lesson_id
  FROM lesson_stages
  WHERE id = _stage_id;

  IF _lesson_id IS NULL THEN
    RETURN FALSE;
  END IF;

  -- Insert or update completion
  INSERT INTO user_stage_completions (user_id, lesson_id, stage_id)
  VALUES (auth.uid(), _lesson_id, _stage_id)
  ON CONFLICT (user_id, stage_id) DO UPDATE
  SET completed_at = now();

  RETURN TRUE;
END;
$$;

-- Function to check if stage is complete
CREATE OR REPLACE FUNCTION public.is_stage_complete(
  _user_id UUID,
  _stage_id UUID
)
RETURNS BOOLEAN
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1 FROM user_stage_completions
    WHERE user_id = _user_id AND stage_id = _stage_id
  );
END;
$$;

-- Function to get completed stages for a lesson
CREATE OR REPLACE FUNCTION public.get_completed_stages(
  _user_id UUID,
  _lesson_id UUID
)
RETURNS TABLE (stage_id UUID, completed_at TIMESTAMPTZ)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  RETURN QUERY
  SELECT usc.stage_id, usc.completed_at
  FROM user_stage_completions usc
  WHERE usc.user_id = _user_id AND usc.lesson_id = _lesson_id;
END;
$$;

COMMENT ON TABLE public.user_stage_completions IS 'Tracks student completion of lesson stages for progressive unlocking';
COMMENT ON FUNCTION public.complete_stage IS 'Marks a stage as complete for the current user';
COMMENT ON FUNCTION public.is_stage_complete IS 'Checks if a user has completed a specific stage';
COMMENT ON FUNCTION public.get_completed_stages IS 'Gets all completed stages for a user in a lesson';
