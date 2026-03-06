-- Lesson Assets Linking System
-- This migration creates the infrastructure to link grammar chapters and vocabulary
-- to lessons for integrated content delivery and progress tracking

-- Create lesson_assets table to link lessons with grammar/vocab content
CREATE TABLE public.lesson_assets (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  lesson_id UUID NOT NULL REFERENCES public.lessons(id) ON DELETE CASCADE,
  asset_type TEXT NOT NULL CHECK (asset_type IN ('grammar', 'vocabulary', 'pronunciation', 'pragmatics')),
  asset_id UUID NOT NULL, -- References grammar_chapters.id or lexicon_entries.id
  order_index INT NOT NULL DEFAULT 0,
  is_required BOOLEAN NOT NULL DEFAULT true, -- Whether viewing this asset is required for lesson completion
  context_note TEXT, -- Optional note about why this asset is linked (e.g., "Needed for Stage 3")
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE(lesson_id, asset_type, asset_id)
);

CREATE INDEX idx_lesson_assets_lesson ON public.lesson_assets(lesson_id);
CREATE INDEX idx_lesson_assets_type ON public.lesson_assets(asset_type);
CREATE INDEX idx_lesson_assets_asset ON public.lesson_assets(asset_id);

ALTER TABLE public.lesson_assets ENABLE ROW LEVEL SECURITY;

-- Add comment for documentation
COMMENT ON TABLE public.lesson_assets IS 'Links lessons to reference content (grammar chapters, vocabulary entries, etc.) for integrated learning and progress tracking';
COMMENT ON COLUMN public.lesson_assets.asset_type IS 'Type of linked asset: grammar, vocabulary, pronunciation, or pragmatics';
COMMENT ON COLUMN public.lesson_assets.is_required IS 'If true, student must view this asset for lesson completion';
COMMENT ON COLUMN public.lesson_assets.context_note IS 'Pedagogical note about when/why this asset should be accessed';

-- Function to check if all required assets have been viewed for a lesson
CREATE OR REPLACE FUNCTION public.check_lesson_assets_completion(
  _user_id UUID,
  _lesson_id UUID
)
RETURNS BOOLEAN
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_required_count INT;
  v_viewed_count INT;
BEGIN
  -- Count required assets for this lesson
  SELECT COUNT(*)
  INTO v_required_count
  FROM public.lesson_assets
  WHERE lesson_id = _lesson_id AND is_required = true;

  -- If no required assets, return true
  IF v_required_count = 0 THEN
    RETURN true;
  END IF;

  -- Count how many required assets the user has viewed
  SELECT COUNT(DISTINCT la.id)
  INTO v_viewed_count
  FROM public.lesson_assets la
  INNER JOIN public.progress_events pe ON 
    pe.event_type = 'lesson_asset_viewed' AND
    pe.event_data->>'lesson_id' = _lesson_id::text AND
    pe.event_data->>'asset_id' = la.asset_id::text AND
    pe.user_id = _user_id
  WHERE la.lesson_id = _lesson_id AND la.is_required = true;

  -- Return true if all required assets have been viewed
  RETURN v_viewed_count >= v_required_count;
END;
$$;

COMMENT ON FUNCTION public.check_lesson_assets_completion IS 'Checks if a user has viewed all required assets for a lesson';

-- Function to get lesson completion status including asset requirements
CREATE OR REPLACE FUNCTION public.get_lesson_completion_status(
  _user_id UUID,
  _lesson_id UUID
)
RETURNS TABLE(
  is_complete BOOLEAN,
  assets_complete BOOLEAN,
  required_assets_count INT,
  viewed_assets_count INT
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  RETURN QUERY
  WITH required_assets AS (
    SELECT COUNT(*) as total
    FROM public.lesson_assets
    WHERE lesson_id = _lesson_id AND is_required = true
  ),
  viewed_assets AS (
    SELECT COUNT(DISTINCT la.id) as total
    FROM public.lesson_assets la
    INNER JOIN public.progress_events pe ON 
      pe.event_type = 'lesson_asset_viewed' AND
      pe.event_data->>'lesson_id' = _lesson_id::text AND
      pe.event_data->>'asset_id' = la.asset_id::text AND
      pe.user_id = _user_id
    WHERE la.lesson_id = _lesson_id AND la.is_required = true
  ),
  lesson_complete AS (
    SELECT EXISTS(
      SELECT 1 FROM public.progress_events
      WHERE user_id = _user_id 
        AND event_type = 'lesson_complete'
        AND event_data->>'lesson_id' = _lesson_id::text
    ) as complete
  )
  SELECT 
    lc.complete,
    CASE 
      WHEN ra.total = 0 THEN true
      ELSE va.total >= ra.total
    END as assets_complete,
    COALESCE(ra.total, 0)::INT as required_assets_count,
    COALESCE(va.total, 0)::INT as viewed_assets_count
  FROM required_assets ra, viewed_assets va, lesson_complete lc;
END;
$$;

COMMENT ON FUNCTION public.get_lesson_completion_status IS 'Returns comprehensive completion status for a lesson including asset viewing requirements';

-- RLS Policies
CREATE POLICY "Users can view lesson assets for published lessons"
  ON public.lesson_assets FOR SELECT TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM public.lessons l
      WHERE l.id = lesson_id AND l.is_published = true
    )
  );

CREATE POLICY "Content creators can manage lesson assets"
  ON public.lesson_assets FOR ALL TO authenticated
  USING (public.is_content_creator(auth.uid()))
  WITH CHECK (public.is_content_creator(auth.uid()));

-- Grant execute permissions on functions
GRANT EXECUTE ON FUNCTION public.check_lesson_assets_completion TO authenticated;
GRANT EXECUTE ON FUNCTION public.get_lesson_completion_status TO authenticated;
