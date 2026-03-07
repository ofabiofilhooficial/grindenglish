-- ============================================
-- VERIFICATION QUERIES FOR A0 COURSE SETUP
-- Run these one by one to verify everything worked
-- ============================================

-- 1. Check A0 Level exists
SELECT 
  'A0 Level Check' as verification,
  id, 
  title, 
  cefr_code, 
  is_published
FROM levels 
WHERE cefr_code = 'A0';
-- Expected: 1 row with title "A0 Foundations", is_published = true

-- 2. Check all 6 units exist
SELECT 
  'Units Check' as verification,
  u.sort_order + 1 as unit_number,
  u.title,
  u.is_published
FROM units u
JOIN levels l ON u.level_id = l.id
WHERE l.cefr_code = 'A0'
ORDER BY u.sort_order;
-- Expected: 6 rows
-- Unit 1: Hello & Identity
-- Unit 2: Numbers, Time & Dates
-- Unit 3: My World (Home & Objects)
-- Unit 4: Daily Routines
-- Unit 5: Shopping Basics
-- Unit 6: Getting Around

-- 3. Check all 24 lessons exist
SELECT 
  'Lessons Check' as verification,
  u.sort_order + 1 as unit_number,
  u.title as unit_title,
  l.sort_order + 1 as lesson_number,
  l.title as lesson_title,
  l.lesson_type,
  l.is_published
FROM lessons l
JOIN units u ON l.unit_id = u.id
JOIN levels lv ON u.level_id = lv.id
WHERE lv.cefr_code = 'A0'
ORDER BY u.sort_order, l.sort_order;
-- Expected: 24 rows (4 lessons per unit)

-- 4. Count lessons per unit
SELECT 
  'Lesson Count per Unit' as verification,
  u.sort_order + 1 as unit_number,
  u.title as unit_title,
  COUNT(l.id) as lesson_count
FROM units u
JOIN levels lv ON u.level_id = lv.id
LEFT JOIN lessons l ON l.unit_id = u.id
WHERE lv.cefr_code = 'A0'
GROUP BY u.id, u.sort_order, u.title
ORDER BY u.sort_order;
-- Expected: 6 rows, each with lesson_count = 4

-- 5. Check Lesson 1 assets (should be 10 total)
SELECT 
  'Lesson 1 Assets' as verification,
  la.order_index,
  la.asset_type,
  CASE 
    WHEN la.asset_type = 'grammar' THEN gc.title
    WHEN la.asset_type = 'vocabulary' THEN le.headword
  END as asset_name,
  CASE 
    WHEN la.asset_type = 'grammar' THEN gc.chapter_code
    WHEN la.asset_type = 'vocabulary' THEN le.pos
  END as asset_code,
  la.is_required,
  la.context_note
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
    AND l.title = 'Professional Greetings & Names'
  LIMIT 1
)
ORDER BY la.order_index;
-- Expected: 10 rows
-- 2 grammar: "Verb To Be: I am / I'm" (A0.G.01), "Possessive Adjective: My" (A0.G.02)
-- 8 vocabulary: hello, hi, good morning, good afternoon, name, first name, last name, nice to meet you

-- 6. Summary counts
SELECT 
  'Summary' as verification,
  (SELECT COUNT(*) FROM levels WHERE cefr_code = 'A0') as levels_count,
  (SELECT COUNT(*) FROM units u JOIN levels l ON u.level_id = l.id WHERE l.cefr_code = 'A0') as units_count,
  (SELECT COUNT(*) FROM lessons les JOIN units u ON les.unit_id = u.id JOIN levels l ON u.level_id = l.id WHERE l.cefr_code = 'A0') as lessons_count,
  (SELECT COUNT(*) FROM lesson_assets la WHERE la.lesson_id = (
    SELECT l.id FROM lessons l JOIN units u ON l.unit_id = u.id JOIN levels lv ON u.level_id = lv.id 
    WHERE lv.cefr_code = 'A0' AND u.sort_order = 0 AND l.sort_order = 0 LIMIT 1
  )) as lesson_1_assets_count;
-- Expected: levels_count=1, units_count=6, lessons_count=24, lesson_1_assets_count=10

-- 7. Check grammar chapters exist
SELECT 
  'Grammar Chapters' as verification,
  chapter_code,
  title,
  is_published
FROM grammar_chapters
WHERE chapter_code IN ('A0.G.01', 'A0.G.02')
ORDER BY chapter_code;
-- Expected: 2 rows, both published

-- 8. Check vocabulary entries exist
SELECT 
  'Vocabulary Entries' as verification,
  headword,
  pos,
  is_published
FROM lexicon_entries
WHERE headword IN ('hello', 'hi', 'good morning', 'good afternoon', 'name', 'first name', 'last name', 'nice to meet you')
ORDER BY headword;
-- Expected: 8 rows, all published

-- ============================================
-- ALL CHECKS COMPLETE
-- If all queries return expected results, migrations were successful!
-- ============================================
