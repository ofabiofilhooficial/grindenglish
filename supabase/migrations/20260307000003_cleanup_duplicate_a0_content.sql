-- Cleanup Duplicate A0 Content
-- This removes the old test A0 level and keeps only the proper A0 Foundations structure

DO $$
DECLARE
  v_old_a0_id UUID;
  v_new_a0_id UUID;
BEGIN
  -- Identify the OLD A0 level (the one titled "A0 – Breakthrough")
  SELECT id INTO v_old_a0_id
  FROM public.levels
  WHERE cefr_code = 'A0' 
    AND title = 'A0 – Breakthrough';

  -- Identify the NEW A0 level (the one titled "A0 Foundations")
  SELECT id INTO v_new_a0_id
  FROM public.levels
  WHERE cefr_code = 'A0' 
    AND title = 'A0 Foundations';

  IF v_old_a0_id IS NOT NULL THEN
    RAISE NOTICE 'Found old A0 level: %', v_old_a0_id;
    RAISE NOTICE 'Deleting old A0 level and all its units/lessons...';
    
    -- Delete the old A0 level (CASCADE will delete all units, lessons, stages, and assets)
    DELETE FROM public.levels WHERE id = v_old_a0_id;
    
    RAISE NOTICE 'Old A0 content deleted successfully';
  ELSE
    RAISE NOTICE 'No old A0 level found (already clean)';
  END IF;

  IF v_new_a0_id IS NOT NULL THEN
    RAISE NOTICE 'New A0 Foundations level exists: %', v_new_a0_id;
  ELSE
    RAISE WARNING 'A0 Foundations level not found! You may need to re-run migration 20260307000001';
  END IF;

END $$;

-- Verify cleanup
DO $$
DECLARE
  v_level_count INT;
  v_unit_count INT;
  v_lesson_count INT;
BEGIN
  -- Count A0 levels (should be 1)
  SELECT COUNT(*) INTO v_level_count
  FROM public.levels
  WHERE cefr_code = 'A0';

  -- Count A0 units (should be 6)
  SELECT COUNT(*) INTO v_unit_count
  FROM public.units u
  JOIN public.levels l ON u.level_id = l.id
  WHERE l.cefr_code = 'A0';

  -- Count A0 lessons (should be 24)
  SELECT COUNT(*) INTO v_lesson_count
  FROM public.lessons les
  JOIN public.units u ON les.unit_id = u.id
  JOIN public.levels l ON u.level_id = l.id
  WHERE l.cefr_code = 'A0';

  RAISE NOTICE '=== CLEANUP VERIFICATION ===';
  RAISE NOTICE 'A0 Levels: % (expected: 1)', v_level_count;
  RAISE NOTICE 'A0 Units: % (expected: 6)', v_unit_count;
  RAISE NOTICE 'A0 Lessons: % (expected: 24)', v_lesson_count;

  IF v_level_count = 1 AND v_unit_count = 6 AND v_lesson_count = 24 THEN
    RAISE NOTICE '✓ Cleanup successful! A0 structure is correct.';
  ELSE
    RAISE WARNING '⚠ Unexpected counts. Please verify the data.';
  END IF;
END $$;

COMMENT ON SCHEMA public IS 'Cleaned up duplicate A0 content - keeping only A0 Foundations structure';
