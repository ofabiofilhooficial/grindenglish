# Cleanup Duplicate A0 Content

## Problem Identified

You have **2 A0 levels** in your database:
1. **"A0 – Breakthrough"** (old test data) - 3 units, 15 lessons
2. **"A0 Foundations"** (correct structure) - 6 units, 24 lessons

This is causing:
- 9 total units (should be 6)
- 39 total lessons (should be 24)
- Confusion in the course builder and student view

## Solution

Delete the old "A0 – Breakthrough" level and keep only "A0 Foundations" with the proper 6-unit structure from your document.

## Step-by-Step Instructions

### Step 1: Preview What Will Be Deleted (Optional but Recommended)

Run the queries in `PREVIEW_CLEANUP.sql` to see:
- Which A0 level will be deleted (A0 – Breakthrough)
- Which units and lessons will be removed
- What will remain (A0 Foundations with 6 units)

### Step 2: Run the Cleanup Migration

Copy and run the entire content of:
```
supabase/migrations/20260307000003_cleanup_duplicate_a0_content.sql
```

This will:
1. Find the old "A0 – Breakthrough" level
2. Delete it (CASCADE will remove all its units, lessons, stages, and assets)
3. Keep "A0 Foundations" intact
4. Verify the cleanup was successful

### Step 3: Verify the Cleanup

Run the queries in `SIMPLE_VERIFICATION.sql` again:

**Expected Results:**
- Query 1: 1 A0 level (A0 Foundations)
- Query 2: 6 units
- Query 3: 6 units listed (Hello & Identity through Getting Around)
- Query 4: 24 lessons
- Query 5: 10 assets in Lesson 1
- Query 6: 10 asset names displayed

### Step 4: Test the Application

After cleanup:

1. **Course Builder**
   - Navigate to Course Builder → Levels
   - Should see only 1 A0 level: "A0 Foundations"
   - Click on it → Should see 6 units
   - Click Unit 1 → Should see 4 lessons
   - Click Lesson 1 → Should see actual asset names in "Currently Linked"

2. **Student View**
   - Navigate to My Course
   - Should see "A0 Foundations" with 6 units
   - Click Unit 1 → Should see 4 lessons
   - Click Lesson 1 → Should see grammar and vocabulary content

## What Gets Deleted

The cleanup will remove:
- Old A0 level: "A0 – Breakthrough"
- All units under that level (3 units)
- All lessons under those units (~15 lessons)
- All lesson stages under those lessons
- All asset links for those lessons

## What Gets Kept

Everything under "A0 Foundations":
- 1 A0 level
- 6 units:
  1. Hello & Identity
  2. Numbers, Time & Dates
  3. My World (Home & Objects)
  4. Daily Routines
  5. Shopping Basics
  6. Getting Around
- 24 lessons (4 per unit)
- 10 assets linked to Lesson 1

## Safety Notes

- The cleanup uses CASCADE DELETE, so all related data is automatically removed
- Grammar chapters and vocabulary entries are NOT deleted (they're independent)
- Only the old A0 level structure is removed
- The migration includes verification to confirm success

## Troubleshooting

### If you see errors during cleanup:
- Check if there are foreign key constraints preventing deletion
- Verify you have proper permissions
- Check the error message for specific issues

### If counts are still wrong after cleanup:
- Re-run the verification queries
- Check if there are other duplicate levels
- Verify the "A0 Foundations" level has the correct structure

### If you accidentally delete the wrong level:
- Re-run migration `20260307000001_seed_a0_course_structure.sql`
- Re-run migration `20260307000002_link_lesson_1_assets.sql`
- This will recreate the proper A0 Foundations structure

## After Cleanup

Once cleanup is complete and verified:
1. The course builder will show clean, organized content
2. Students will see the proper 6-unit A0 course
3. Asset names will display correctly
4. You can continue creating content for the remaining 23 lessons

Ready to proceed? Run the cleanup migration! 🧹
