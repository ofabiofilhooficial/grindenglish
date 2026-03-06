-- Add new columns for the 9-section pedagogical structure
-- This migration adds optional fields to support the enhanced grammar chapter UI

ALTER TABLE public.grammar_chapters
  ADD COLUMN IF NOT EXISTS diagnostic_hook TEXT,
  ADD COLUMN IF NOT EXISTS task_upgrades TEXT;

-- Update existing chapters to ensure they work with the new structure
-- The existing columns (form_content, meaning_content, use_content, contrast_notes, common_errors)
-- are already mapped to the new structure, so no data migration is needed

COMMENT ON COLUMN public.grammar_chapters.diagnostic_hook IS 'Optional. A brief scenario or "Notice the Gap" challenge';
COMMENT ON COLUMN public.grammar_chapters.task_upgrades IS 'Basic vs. Professional phrases (side-by-side comparison)';
