# Migration Fixes Applied

## Issues Found and Fixed

### Issue 1: Missing `description` column in `levels` table
**Error**: `column "description" of relation "levels" does not exist`

**Fix**: Removed the `description` column from the INSERT statement. The `levels` table schema only has:
- id, course_id, title, cefr_code, sort_order, is_published, created_at, updated_at

### Issue 2: Missing unique constraint for ON CONFLICT
**Error**: ON CONFLICT clause referenced non-existent unique constraint

**Fix**: Changed to check if level exists first, then INSERT or UPDATE accordingly.

### Issue 3: Invalid `lesson_type` value 'core'
**Error**: 'core' is not a valid enum value for lesson_type

**Fix**: Changed lesson types to valid values:
- Vocabulary lessons → 'vocabulary'
- Grammar lessons → 'grammar'  
- Speaking lessons → 'speaking'
- Assessment lessons → 'assessment'

Valid lesson_type values are:
- 'listening', 'reading', 'grammar', 'vocabulary', 'pronunciation'
- 'speaking', 'writing', 'fluency', 'mediation', 'review', 'assessment'

### Issue 4: Non-existent `lesson_id` column
**Error**: lessons table doesn't have a `lesson_id` column

**Fix**: 
- Removed `lesson_id` from INSERT statements (only `id` exists as UUID)
- Updated the asset linking migration to find lessons by title and sort order instead

## Corrected Migrations

All three migrations have been fixed:

1. ✅ `20260307000000_fix_asset_linking_display.sql` - No changes needed
2. ✅ `20260307000001_seed_a0_course_structure.sql` - Fixed
3. ✅ `20260307000002_link_lesson_1_assets.sql` - Fixed

## How to Apply Now

### Step 1: Run Migration 2 (Course Structure)
Copy and run the corrected `20260307000001_seed_a0_course_structure.sql` in Supabase SQL Editor.

This will create:
- A0 Foundations level
- 6 units with proper themes and flagship tasks
- 24 lessons with correct lesson types

### Step 2: Run Migration 3 (Link Assets)
Copy and run the corrected `20260307000002_link_lesson_1_assets.sql` in Supabase SQL Editor.

This will link:
- 2 grammar chapters to Lesson 1
- 8 vocabulary entries to Lesson 1

### Step 3: Verify
Run this query to verify everything worked:

```sql
-- Check A0 level exists
SELECT * FROM levels WHERE cefr_code = 'A0';

-- Check all 6 units exist
SELECT id, title, sort_order, is_published 
FROM units 
WHERE level_id = (SELECT id FROM levels WHERE cefr_code = 'A0')
ORDER BY sort_order;

-- Check all 24 lessons exist
SELECT l.id, l.title, l.lesson_type, u.title as unit_title, l.is_published
FROM lessons l
JOIN units u ON l.unit_id = u.id
WHERE u.level_id = (SELECT id FROM levels WHERE cefr_code = 'A0')
ORDER BY u.sort_order, l.sort_order;

-- Check Lesson 1 assets (should show 10 items)
SELECT 
  la.asset_type,
  CASE 
    WHEN la.asset_type = 'grammar' THEN gc.title
    WHEN la.asset_type = 'vocabulary' THEN le.headword
  END as asset_name,
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
)
ORDER BY la.order_index;
```

Expected results:
- 1 A0 level
- 6 units (Hello & Identity, Numbers/Time/Dates, My World, Daily Routines, Shopping, Getting Around)
- 24 lessons (4 per unit)
- 10 assets linked to Lesson 1 (2 grammar + 8 vocabulary)

## What's Next

After successful migration:

1. **Test Course Builder**
   - Go to Course Builder → A0 → Unit 1 → Lesson 1
   - Verify "Currently Linked" shows actual asset names
   - Should see "Verb To Be: I am / I'm" not just "Grammar"

2. **Test Student View**
   - Go to My Course → A0 Foundations
   - Should see 6 units
   - Click Unit 1 → Should see 4 lessons
   - Click Lesson 1 → Should see 10 linked assets with full content

3. **Create Content for Remaining Lessons**
   - Use the template in `docs/LESSON_CONTENT_TEMPLATE.md`
   - Create grammar chapters and vocabulary entries
   - Link them using Course Builder

All migrations are now compatible with your actual database schema! 🎉
