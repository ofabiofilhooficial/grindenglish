-- Add stage_id column to lesson_assets for stage-specific asset linking
-- This allows assets to be linked to specific lesson stages OR to the entire lesson

-- Add the stage_id column (nullable to support both stage-specific and lesson-level assets)
ALTER TABLE public.lesson_assets
ADD COLUMN stage_id UUID REFERENCES public.lesson_stages(id) ON DELETE CASCADE;

-- Add indexes for performance
CREATE INDEX idx_lesson_assets_stage_id ON public.lesson_assets(stage_id);
CREATE INDEX idx_lesson_assets_lesson_stage ON public.lesson_assets(lesson_id, stage_id);

-- Add comment for documentation
COMMENT ON COLUMN public.lesson_assets.stage_id IS 'Optional: If set, asset is linked to a specific stage. If NULL, asset is available throughout the lesson.';

-- Update the unique constraint to allow same asset in different stages
ALTER TABLE public.lesson_assets DROP CONSTRAINT IF EXISTS lesson_assets_lesson_id_asset_type_asset_id_key;

-- Add new unique constraint that includes stage_id
ALTER TABLE public.lesson_assets 
ADD CONSTRAINT lesson_assets_lesson_stage_type_asset_unique 
UNIQUE(lesson_id, stage_id, asset_type, asset_id);

-- Note: This allows the same asset to be linked to:
-- 1. Multiple different stages (different stage_id values)
-- 2. The lesson level (stage_id = NULL)
-- 3. But prevents duplicate links within the same stage or lesson level
