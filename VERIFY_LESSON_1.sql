-- Verify Lesson 1 Stages Were Created

-- Check lesson metadata was updated
SELECT 
  'Lesson 1 Metadata' as check_type,
  l.title,
  l.goal,
  l.success_criteria,
  l.homework->>'title' as homework_title
FROM lessons l
JOIN units u ON l.unit_id = u.id
JOIN levels lv ON u.level_id = lv.id
WHERE lv.cefr_code = 'A0'
  AND u.sort_order = 0
  AND l.sort_order = 0;

-- Check stages were created
SELECT 
  'Lesson 1 Stages' as check_type,
  COUNT(*) as stage_count
FROM lesson_stages ls
JOIN lessons l ON ls.lesson_id = l.id
JOIN units u ON l.unit_id = u.id
JOIN levels lv ON u.level_id = lv.id
WHERE lv.cefr_code = 'A0'
  AND u.sort_order = 0
  AND l.sort_order = 0;
-- Expected: 6 stages

-- List all stages
SELECT 
  ls.sort_order + 1 as stage_num,
  ls.stage_type,
  ls.title,
  ls.timing_minutes,
  CASE 
    WHEN ls.content IS NOT NULL AND jsonb_typeof(ls.content) = 'object' 
    THEN 'Has structured content'
    ELSE 'No content'
  END as content_status
FROM lesson_stages ls
JOIN lessons l ON ls.lesson_id = l.id
JOIN units u ON l.unit_id = u.id
JOIN levels lv ON u.level_id = lv.id
WHERE lv.cefr_code = 'A0'
  AND u.sort_order = 0
  AND l.sort_order = 0
ORDER BY ls.sort_order;

-- Check content structure of Stage 2 (should have rich content)
SELECT 
  ls.title,
  ls.content->>'objective' as objective,
  ls.content->>'key_teaching_point' as key_point,
  CASE 
    WHEN ls.content->'grammar_focus'->'examples' IS NOT NULL 
    THEN jsonb_array_length(ls.content->'grammar_focus'->'examples')
    ELSE 0
  END as example_count
FROM lesson_stages ls
JOIN lessons l ON ls.lesson_id = l.id
JOIN units u ON l.unit_id = u.id
JOIN levels lv ON u.level_id = lv.id
WHERE lv.cefr_code = 'A0'
  AND u.sort_order = 0
  AND l.sort_order = 0
  AND ls.sort_order = 2;
-- Should show Stage 2 with objective and key teaching point

-- Summary
SELECT 
  'Summary' as item,
  (SELECT COUNT(*) FROM lesson_stages ls 
   JOIN lessons l ON ls.lesson_id = l.id 
   JOIN units u ON l.unit_id = u.id 
   JOIN levels lv ON u.level_id = lv.id 
   WHERE lv.cefr_code = 'A0' AND u.sort_order = 0 AND l.sort_order = 0) as stages,
  (SELECT COUNT(*) FROM lesson_assets la 
   WHERE la.lesson_id = (
     SELECT l.id FROM lessons l 
     JOIN units u ON l.unit_id = u.id 
     JOIN levels lv ON u.level_id = lv.id 
     WHERE lv.cefr_code = 'A0' AND u.sort_order = 0 AND l.sort_order = 0 LIMIT 1
   )) as assets;
-- Expected: stages=6, assets=10
