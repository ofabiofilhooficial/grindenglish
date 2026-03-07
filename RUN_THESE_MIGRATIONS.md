# ✅ Ready to Run - Corrected Migrations

## Status
- ✅ Migration 1: Already ran successfully
- ⏳ Migration 2: Ready to run (FIXED)
- ⏳ Migration 3: Ready to run (FIXED)

## What Was Fixed

| Issue | Status |
|-------|--------|
| Missing `description` column | ✅ Fixed |
| Invalid `lesson_type` 'core' | ✅ Fixed |
| Non-existent `lesson_id` column | ✅ Fixed |
| Missing unique constraint | ✅ Fixed |

## Run These Now

### Migration 2: Course Structure
**File**: `supabase/migrations/20260307000001_seed_a0_course_structure.sql`

**What it does**:
- Creates A0 Foundations level
- Creates 6 units (Hello & Identity, Numbers/Time, My World, Daily Routines, Shopping, Getting Around)
- Creates 24 lessons (4 per unit)
- All published and ready for students

**Copy the entire file content and run in Supabase SQL Editor**

---

### Migration 3: Link Assets to Lesson 1
**File**: `supabase/migrations/20260307000002_link_lesson_1_assets.sql`

**What it does**:
- Links 2 grammar chapters to Lesson 1
- Links 8 vocabulary entries to Lesson 1
- Adds context notes for each asset

**Copy the entire file content and run in Supabase SQL Editor**

---

## Verification Query

After running both migrations, run this to verify:

```sql
-- Quick verification
WITH lesson_1 AS (
  SELECT les.id 
  FROM lessons les
  JOIN units u ON les.unit_id = u.id
  JOIN levels l ON u.level_id = l.id
  WHERE l.cefr_code = 'A0' 
    AND u.sort_order = 0 
    AND les.sort_order = 0
  LIMIT 1
)
SELECT 
  'Levels' as table_name,
  COUNT(*) as count
FROM levels WHERE cefr_code = 'A0'
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
WHERE l.cefr_code = 'A0'
UNION ALL
SELECT 
  'Lesson 1 Assets',
  COUNT(*)
FROM lesson_assets la
WHERE la.lesson_id IN (SELECT id FROM lesson_1);
```

**Expected Results**:
```
table_name          | count
--------------------|------
Levels              | 1
Units               | 6
Lessons             | 24
Lesson 1 Assets     | 10
```

If you want to see the actual assets linked to Lesson 1:

```sql
-- View Lesson 1 assets with names
SELECT 
  la.asset_type,
  CASE 
    WHEN la.asset_type = 'grammar' THEN gc.title
    WHEN la.asset_type = 'vocabulary' THEN le.headword
  END as asset_name,
  CASE 
    WHEN la.asset_type = 'grammar' THEN gc.chapter_code
    WHEN la.asset_type = 'vocabulary' THEN le.pos
  END as asset_code,
  la.context_note
FROM lesson_assets la
LEFT JOIN grammar_chapters gc ON la.asset_id = gc.id AND la.asset_type = 'grammar'
LEFT JOIN lexicon_entries le ON la.asset_id = le.id AND la.asset_type = 'vocabulary'
WHERE la.lesson_id = (
  SELECT les.id 
  FROM lessons les
  JOIN units u ON les.unit_id = u.id
  JOIN levels l ON u.level_id = l.id
  WHERE l.cefr_code = 'A0' 
    AND u.sort_order = 0 
    AND les.sort_order = 0
  LIMIT 1
)
ORDER BY la.order_index;
```

**Expected to see**:
- 2 grammar items: "Verb To Be: I am / I'm" and "Possessive Adjective: My"
- 8 vocabulary items: hello, hi, good morning, good afternoon, name, first name, last name, nice to meet you

## After Migration Success

1. **Refresh your browser** (hard refresh: Ctrl+Shift+R or Cmd+Shift+R)

2. **Test Course Builder**:
   - Navigate to Course Builder
   - Go to A0 → Unit 1 → Lesson 1
   - Check "Currently Linked" section
   - Should see actual names like "Verb To Be: I am / I'm"

3. **Test Student View**:
   - Navigate to My Course
   - Click on A0 Foundations
   - Should see 6 units
   - Click Unit 1 → Should see 4 lessons
   - Click Lesson 1 → Should see grammar and vocabulary content

## Troubleshooting

### If Migration 2 fails:
- Check if A0 level already exists: `SELECT * FROM levels WHERE cefr_code = 'A0'`
- If it exists, the migration will update it to published
- Check error message for specific column/constraint issues

### If Migration 3 fails:
- Verify Migration 2 ran successfully first
- Check if grammar chapters exist: `SELECT * FROM grammar_chapters WHERE chapter_code LIKE 'A0.G.%'`
- Check if vocabulary exists: `SELECT * FROM lexicon_entries WHERE headword IN ('hello', 'hi', 'name')`

### If assets still show as "Grammar"/"Vocabulary":
- Hard refresh browser
- Clear browser cache
- Verify the AssetSelector.tsx changes were deployed
- Check browser console for JavaScript errors

## Need Help?

Check these docs:
- `MIGRATION_FIX_APPLIED.md` - Detailed explanation of fixes
- `docs/APPLY_COURSE_BUILDER_FIXES.md` - Complete application guide
- `docs/COURSE_BUILDER_FIX_SUMMARY.md` - Technical architecture details

All migrations are now schema-compatible! 🚀
