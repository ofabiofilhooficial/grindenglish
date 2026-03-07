-- ============================================
-- SIMPLE VERIFICATION - Run each query separately
-- ============================================

-- Query 1: Check A0 Level
SELECT * FROM levels WHERE cefr_code = 'A0';
-- Expected: 1 row, is_published = true

-- Query 2: Count Units
SELECT COUNT(*) as unit_count 
FROM units u
JOIN levels l ON u.level_id = l.id
WHERE l.cefr_code = 'A0';
-- Expected: 6

-- Query 3: List Units
SELECT 
  u.sort_order + 1 as unit_num,
  u.title
FROM units u
JOIN levels l ON u.level_id = l.id
WHERE l.cefr_code = 'A0'
ORDER BY u.sort_order;
-- Expected: 6 units listed

-- Query 4: Count Lessons
SELECT COUNT(*) as lesson_count
FROM lessons les
JOIN units u ON les.unit_id = u.id
JOIN levels l ON u.level_id = l.id
WHERE l.cefr_code = 'A0';
-- Expected: 24

-- Query 5: Count Lesson 1 Assets
SELECT COUNT(*) as asset_count
FROM lesson_assets la
WHERE la.lesson_id = (
  SELECT l.id 
  FROM lessons l
  JOIN units u ON l.unit_id = u.id
  JOIN levels lv ON u.level_id = lv.id
  WHERE lv.cefr_code = 'A0' 
    AND u.sort_order = 0 
    AND l.sort_order = 0
  LIMIT 1
);
-- Expected: 10

-- Query 6: View Lesson 1 Assets with Names
SELECT 
  la.order_index,
  la.asset_type,
  CASE 
    WHEN la.asset_type = 'grammar' THEN gc.title
    WHEN la.asset_type = 'vocabulary' THEN le.headword
  END as asset_name
FROM lesson_assets la
LEFT JOIN grammar_chapters gc ON la.asset_id = gc.id AND la.asset_type = 'grammar'
LEFT JOIN lexicon_entries le ON la.asset_id = le.id AND la.asset_type = 'vocabulary'
WHERE la.lesson_id = (
  SELECT l.id 
  FROM lessons l
  JOIN units u ON l.unit_id = u.id
  JOIN levels lv ON u.level_id = lv.id
  WHERE lv.cefr_code = 'A0' 
    AND u.sort_order = 0 
    AND l.sort_order = 0
  LIMIT 1
)
ORDER BY la.order_index;
-- Expected: 10 rows with actual names

-- ============================================
-- QUICK SUMMARY
-- ============================================
SELECT 
  'A0 Levels' as item,
  COUNT(*) as count
FROM levels 
WHERE cefr_code = 'A0'
UNION ALL
SELECT 
  'Units',
  COUNT(*)
FROM units u
JOIN levels l ON u.level_id = l.id
WHERE l.cefr_code = 'A0'
UNION ALL
SELECT 
  'Lessons',
  COUNT(*)
FROM lessons les
JOIN units u ON les.unit_id = u.id
JOIN levels l ON u.level_id = l.id
WHERE l.cefr_code = 'A0';

-- Expected Results:
-- A0 Levels: 1
-- Units: 6
-- Lessons: 24
