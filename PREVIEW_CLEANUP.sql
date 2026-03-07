-- ============================================
-- PREVIEW WHAT WILL BE DELETED
-- Run this BEFORE the cleanup migration to see what will be removed
-- ============================================

-- Show both A0 levels
SELECT 
  'A0 Levels' as item,
  id,
  title,
  created_at,
  is_published,
  CASE 
    WHEN title = 'A0 – Breakthrough' THEN '❌ WILL BE DELETED'
    WHEN title = 'A0 Foundations' THEN '✅ WILL BE KEPT'
    ELSE '⚠ UNKNOWN'
  END as action
FROM levels
WHERE cefr_code = 'A0'
ORDER BY created_at;

-- Show units that will be deleted
SELECT 
  'Units to Delete' as item,
  u.id,
  u.title,
  l.title as level_title
FROM units u
JOIN levels l ON u.level_id = l.id
WHERE l.cefr_code = 'A0' 
  AND l.title = 'A0 – Breakthrough'
ORDER BY u.sort_order;

-- Show lessons that will be deleted
SELECT 
  'Lessons to Delete' as item,
  les.id,
  les.title,
  u.title as unit_title
FROM lessons les
JOIN units u ON les.unit_id = u.id
JOIN levels l ON u.level_id = l.id
WHERE l.cefr_code = 'A0' 
  AND l.title = 'A0 – Breakthrough'
ORDER BY u.sort_order, les.sort_order;

-- Show what will remain (A0 Foundations)
SELECT 
  'Units to Keep' as item,
  u.sort_order + 1 as unit_num,
  u.title
FROM units u
JOIN levels l ON u.level_id = l.id
WHERE l.cefr_code = 'A0' 
  AND l.title = 'A0 Foundations'
ORDER BY u.sort_order;

-- Show lessons that will remain
SELECT 
  'Lessons to Keep' as item,
  u.sort_order + 1 as unit_num,
  u.title as unit_title,
  les.sort_order + 1 as lesson_num,
  les.title as lesson_title
FROM lessons les
JOIN units u ON les.unit_id = u.id
JOIN levels l ON u.level_id = l.id
WHERE l.cefr_code = 'A0' 
  AND l.title = 'A0 Foundations'
ORDER BY u.sort_order, les.sort_order;

-- Summary
SELECT 
  'BEFORE CLEANUP' as status,
  (SELECT COUNT(*) FROM levels WHERE cefr_code = 'A0') as a0_levels,
  (SELECT COUNT(*) FROM units u JOIN levels l ON u.level_id = l.id WHERE l.cefr_code = 'A0') as total_units,
  (SELECT COUNT(*) FROM lessons les JOIN units u ON les.unit_id = u.id JOIN levels l ON u.level_id = l.id WHERE l.cefr_code = 'A0') as total_lessons;

-- Expected AFTER cleanup:
-- a0_levels: 1
-- total_units: 6
-- total_lessons: 24
