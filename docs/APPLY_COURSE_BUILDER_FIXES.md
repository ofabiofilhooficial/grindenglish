# How to Apply Course Builder Fixes

## Quick Start

### Step 1: Apply Database Migrations

You need to run 3 new migration files in order:

1. **20260307000000_fix_asset_linking_display.sql**
   - Creates database views for better asset display
   - Run this first

2. **20260307000001_seed_a0_course_structure.sql**
   - Creates the complete A0 level with 6 units and 24 lessons
   - Run this second

3. **20260307000002_link_lesson_1_assets.sql**
   - Links the existing grammar and vocabulary to Lesson 1
   - Run this third

#### Option A: Using Supabase Dashboard (Recommended)
1. Go to your Supabase project dashboard
2. Navigate to SQL Editor
3. Copy the content of each migration file
4. Paste and run them in order
5. Verify no errors appear

#### Option B: Using Supabase CLI
```bash
# If you have Supabase CLI configured
npx supabase db push

# Or manually apply each migration
npx supabase db execute --file supabase/migrations/20260307000000_fix_asset_linking_display.sql
npx supabase db execute --file supabase/migrations/20260307000001_seed_a0_course_structure.sql
npx supabase db execute --file supabase/migrations/20260307000002_link_lesson_1_assets.sql
```

### Step 2: Verify the Fixes

#### Test Course Builder
1. Log in as a content creator
2. Navigate to Course Builder → Levels → A0 Foundations → Unit 1 → Lesson 1
3. Scroll to "Linked Reference Content" section
4. You should now see:
   - ✅ "Verb To Be: I am / I'm" (not just "Grammar")
   - ✅ "Possessive Adjective: My" (not just "Grammar")
   - ✅ "hello" (not just "Vocabulary")
   - ✅ "hi" (not just "Vocabulary")
   - ✅ And 6 more vocabulary items with actual names

#### Test Student View
1. Log in as a student (or switch to student role)
2. Navigate to My Course
3. Click on "A0 Foundations" level
4. You should see 6 units:
   - Unit 1: Hello & Identity
   - Unit 2: Numbers, Time & Dates
   - Unit 3: My World (Home & Objects)
   - Unit 4: Daily Routines
   - Unit 5: Shopping Basics
   - Unit 6: Getting Around
5. Click on Unit 1
6. Click on "Lesson 1: Professional Greetings & Names"
7. Scroll down to see "Reference Content" section
8. You should see 2 grammar chapters and 8 vocabulary entries
9. Click to expand any item - you should see full content:
   - Grammar: Meaning, Form, Use, L1 Contrast, Common Errors
   - Vocabulary: Pronunciation, Definition, Examples, Usage Notes

### Step 3: Test Progress Tracking

1. As a student, view a grammar chapter for 3+ seconds
2. Navigate to Progress page
3. Verify the activity is recorded
4. Check SRS section - the item should be scheduled for review

## What Was Fixed

### 1. Course Builder Display ✅
**Before**: Showed "Grammar" or "Vocabulary" for all linked items
**After**: Shows actual titles like "Verb To Be: I am / I'm" and "hello"

### 2. Student View ✅
**Before**: Students couldn't see linked content
**After**: Students see all grammar and vocabulary linked to lessons

### 3. Course Structure ✅
**Before**: Only had partial A0 structure
**After**: Complete A0 with 6 units and 24 lessons, all published

### 4. Asset Linking ✅
**Before**: Content existed but wasn't linked to lessons
**After**: Lesson 1 has 2 grammar chapters and 8 vocabulary entries linked

## Next Steps for Content Creation

### For Remaining A0 Lessons

You now have the structure for all 24 A0 lessons. For each lesson, you need to:

1. **Create Grammar Chapters** (if not already created)
   - Go to Grammar Manager
   - Create chapters for the lesson's grammar focus
   - Mark as published

2. **Create Vocabulary Entries** (if not already created)
   - Go to Lexicon Manager
   - Create entries for the lesson's vocabulary
   - Mark as published

3. **Link Assets to Lessons**
   - Go to Lesson Editor for the specific lesson
   - Use the "Linked Reference Content" section
   - Search and link the grammar chapters
   - Search and link the vocabulary entries
   - Save

4. **Add Lesson Stages** (optional but recommended)
   - In Lesson Editor, add stages like:
     - Warm-up
     - Lead-in
     - Input
     - Practice
     - Communicative Use
     - Reflection
   - Link stage-specific assets if needed

### Example: Creating Lesson 2 Content

**Lesson 2: Origins & Roles** needs:

**Grammar:**
- Preposition "from" (for stating origin)
- Indefinite articles a/an (for professions)

**Vocabulary:**
- Brazil, city, country
- Job, work
- Common professions: engineer, manager, developer, teacher, student

**Steps:**
1. Create grammar chapter "Preposition: From" (A0.G.03)
2. Create grammar chapter "Articles: A/An" (A0.G.04)
3. Create vocabulary entries for each word above
4. Go to Lesson Editor for A0-U1-L2
5. Link the 2 grammar chapters
6. Link the vocabulary entries
7. Save

## Troubleshooting

### "Lesson not found" error
- Verify migrations ran successfully
- Check that lesson exists in database: `SELECT * FROM lessons WHERE lesson_id = 'A0-U1-L1'`

### Assets still showing as "Grammar" or "Vocabulary"
- Hard refresh browser (Ctrl+Shift+R or Cmd+Shift+R)
- Clear browser cache
- Verify the AssetSelector.tsx changes were saved

### Students can't see content
- Verify lesson is published: `is_published = true`
- Verify assets are published: grammar_chapters and lexicon_entries have `is_published = true`
- Check RLS policies allow students to read

### Progress not tracking
- Verify user is logged in
- Check browser console for errors
- Verify `user_activity` table exists
- Check that `useActivityTracker` hook is working

## Database Verification Queries

Run these in Supabase SQL Editor to verify everything is set up:

```sql
-- Check A0 level exists
SELECT * FROM levels WHERE cefr_code = 'A0';

-- Check all 6 units exist
SELECT id, title, sort_order, is_published 
FROM units 
WHERE level_id = (SELECT id FROM levels WHERE cefr_code = 'A0')
ORDER BY sort_order;

-- Check all 24 lessons exist
SELECT l.lesson_id, l.title, u.title as unit_title, l.is_published
FROM lessons l
JOIN units u ON l.unit_id = u.id
WHERE u.level_id = (SELECT id FROM levels WHERE cefr_code = 'A0')
ORDER BY u.sort_order, l.sort_order;

-- Check Lesson 1 assets
SELECT 
  la.asset_type,
  CASE 
    WHEN la.asset_type = 'grammar' THEN gc.title
    WHEN la.asset_type = 'vocabulary' THEN le.headword
  END as asset_name
FROM lesson_assets la
LEFT JOIN grammar_chapters gc ON la.asset_id = gc.id AND la.asset_type = 'grammar'
LEFT JOIN lexicon_entries le ON la.asset_id = le.id AND la.asset_type = 'vocabulary'
WHERE la.lesson_id = (SELECT id FROM lessons WHERE lesson_id = 'A0-U1-L1')
ORDER BY la.order_index;

-- Check views exist
SELECT * FROM lesson_assets_with_content LIMIT 1;
SELECT * FROM unit_assets_with_content LIMIT 1;
```

## Support

If you encounter issues:
1. Check the browser console for JavaScript errors
2. Check Supabase logs for database errors
3. Verify all migrations ran successfully
4. Review the COURSE_BUILDER_FIX_SUMMARY.md for detailed architecture info
