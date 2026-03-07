-- Migration: Add vocabulary practice state persistence
-- This allows students to save their progress in vocabulary exercises

-- Create table for vocabulary practice answers
CREATE TABLE IF NOT EXISTS public.vocabulary_practice_answers (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  lesson_id uuid NOT NULL REFERENCES public.lessons(id) ON DELETE CASCADE,
  stage_id uuid NOT NULL REFERENCES public.lesson_stages(id) ON DELETE CASCADE,
  item_id text NOT NULL, -- The vocabulary item ID (e.g., '1', '2', '3')
  answer text NOT NULL, -- The user's answer
  is_correct boolean NOT NULL DEFAULT false,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE(user_id, stage_id, item_id)
);

-- Add RLS policies
ALTER TABLE public.vocabulary_practice_answers ENABLE ROW LEVEL SECURITY;

-- Users can only see their own answers
CREATE POLICY "Users can view own vocabulary answers"
  ON public.vocabulary_practice_answers
  FOR SELECT
  USING (auth.uid() = user_id);

-- Users can insert their own answers
CREATE POLICY "Users can insert own vocabulary answers"
  ON public.vocabulary_practice_answers
  FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- Users can update their own answers
CREATE POLICY "Users can update own vocabulary answers"
  ON public.vocabulary_practice_answers
  FOR UPDATE
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- Users can delete their own answers (for reset)
CREATE POLICY "Users can delete own vocabulary answers"
  ON public.vocabulary_practice_answers
  FOR DELETE
  USING (auth.uid() = user_id);

-- Create index for faster lookups
CREATE INDEX idx_vocab_answers_user_stage 
  ON public.vocabulary_practice_answers(user_id, stage_id);

-- Function to save vocabulary answer
CREATE OR REPLACE FUNCTION public.save_vocabulary_answer(
  _lesson_id uuid,
  _stage_id uuid,
  _item_id text,
  _answer text,
  _is_correct boolean
)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  INSERT INTO public.vocabulary_practice_answers (
    user_id,
    lesson_id,
    stage_id,
    item_id,
    answer,
    is_correct,
    updated_at
  )
  VALUES (
    auth.uid(),
    _lesson_id,
    _stage_id,
    _item_id,
    _answer,
    _is_correct,
    now()
  )
  ON CONFLICT (user_id, stage_id, item_id)
  DO UPDATE SET
    answer = EXCLUDED.answer,
    is_correct = EXCLUDED.is_correct,
    updated_at = now();
END;
$$;

-- Function to get vocabulary answers for a stage
CREATE OR REPLACE FUNCTION public.get_vocabulary_answers(
  _stage_id uuid
)
RETURNS TABLE (
  item_id text,
  answer text,
  is_correct boolean
)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  RETURN QUERY
  SELECT 
    vpa.item_id,
    vpa.answer,
    vpa.is_correct
  FROM public.vocabulary_practice_answers vpa
  WHERE vpa.user_id = auth.uid()
    AND vpa.stage_id = _stage_id;
END;
$$;

-- Function to reset vocabulary practice (for redo)
CREATE OR REPLACE FUNCTION public.reset_vocabulary_practice(
  _stage_id uuid
)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  DELETE FROM public.vocabulary_practice_answers
  WHERE user_id = auth.uid()
    AND stage_id = _stage_id;
END;
$$;

-- Grant execute permissions
GRANT EXECUTE ON FUNCTION public.save_vocabulary_answer TO authenticated;
GRANT EXECUTE ON FUNCTION public.get_vocabulary_answers TO authenticated;
GRANT EXECUTE ON FUNCTION public.reset_vocabulary_practice TO authenticated;

COMMENT ON TABLE public.vocabulary_practice_answers IS 'Stores student answers for vocabulary practice exercises';
COMMENT ON FUNCTION public.save_vocabulary_answer IS 'Saves or updates a vocabulary practice answer';
COMMENT ON FUNCTION public.get_vocabulary_answers IS 'Retrieves saved vocabulary answers for a stage';
COMMENT ON FUNCTION public.reset_vocabulary_practice IS 'Clears vocabulary answers for a stage (for redo)';
