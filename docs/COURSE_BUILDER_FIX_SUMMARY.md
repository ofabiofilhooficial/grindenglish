# Course Builder & Student View Fix Summary

## Issues Identified and Fixed

### 1. AssetSelector Display Bug ✅ FIXED
**Problem**: The "Currently Linked" section in the course builder only showed "Grammar" or "Vocabulary" text instead of the actual asset names (e.g., "Verb To Be: I am / I'm" or "hello").

**Root Cause**: The component was displaying `asset.assetType` instead of fetching and displaying the actual asset title from the grammar_chapters or lexicon_entries tables.

**Solution**: 
- Modified `src/components/author/AssetSelector.tsx` to look up the actual asset data
- Now displays the full title for grammar chapters and headword for vocabulary
- Shows additional metadata (chapter_code for grammar, POS for vocabulary)

### 2. Asset Data Fetching Issues ✅ FIXED
**Problem**: LinkedAssetViewer and StageAssetViewer were using complex joins that sometimes failed to return proper data.

**Solution**:
- Created database views `lesson_assets_with_content` and `unit_assets_with_content` in migration `20260307000000_fix_asset_linking_display.sql`
- These views properly join lesson_assets with grammar_chapters and lexicon_entries
- Updated LinkedAssetViewer and StageAssetViewer to use these views
- Provides better performance and more reliable data fetching

### 3. Missing Unit-Level Asset Display ✅ FIXED
**Problem**: Students couldn't see unit-level learning targets/resources that should be reviewed before starting lessons.

**Solution**:
- Created new component `src/components/lesson/UnitAssetViewer.tsx`
- Updated `src/pages/UnitPage.tsx` to display unit-level assets
- Shows "Pre-Study Resources" section with expandable grammar and vocabulary items

### 4. Missing A0 Course Structure ✅ FIXED
**Problem**: The A0 level and its 6 units with 24 lessons weren't created in the database.

**Solution**:
- Created migration `20260307000001_seed_a0_course_structure.sql`
- Seeds complete A0 Foundations level with:
  - Unit 1: Hello & Identity (4 lessons)
  - Unit 2: Numbers, Time & Dates (4 lessons)
  - Unit 3: My World (Home & Objects) (4 lessons)
  - Unit 4: Daily Routines (4 lessons)
  - Unit 5: Shopping Basics (4 lessons)
  - Unit 6: Getting Around (4 lessons)
- All units and lessons are published and ready for content

### 5. Lesson 1 Asset Linking ✅ FIXED
**Problem**: The grammar and vocabulary seeded for Lesson 1 weren't linked to the actual lesson.

**Solution**:
- Created migration `20260307000002_link_lesson_1_assets.sql`
- Links 2 grammar chapters and 8 vocabulary entries to A0-U1-L1
- Includes context notes explaining why each asset is linked

## Files Created

### Database Migrations
1. `supabase/migrations/20260307000000_fix_asset_linking_display.sql`
   - Creates views for proper asset data joining
   - Improves query performance

2. `supabase/migrations/20260307000001_seed_a0_course_structure.sql`
   - Creates complete A0 level structure
   - 6 units with 4 lessons each (24 total lessons)
   - All published and ready

3. `supabase/migrations/20260307000002_link_lesson_1_assets.sql`
   - Links existing grammar and vocabulary to Lesson 1
   - Provides foundation for other lessons

### Components
1. `src/components/lesson/UnitAssetViewer.tsx`
   - New component for displaying unit-level resources
   - Expandable cards showing grammar and vocabulary
   - Integrated into UnitPage

### Modified Files
1. `src/components/author/AssetSelector.tsx`
   - Fixed "Currently Linked" display to show actual asset names
   - Added asset code/metadata display
   - Better visual hierarchy

2. `src/components/lesson/LinkedAssetViewer.tsx`
   - Updated to use new database view
   - More reliable data fetching

3. `src/components/lesson/StageAssetViewer.tsx`
   - Updated to use new database view
   - Consistent with LinkedAssetViewer

4. `src/pages/UnitPage.tsx`
   - Added UnitAssetViewer component
   - Shows pre-study resources to students

## How the System Works Now

### For Content Creators (Course Builder)
1. Navigate to Lesson Editor
2. Use AssetSelector to link grammar chapters and vocabulary
3. See actual asset names in "Currently Linked" section
4. Can link assets at lesson-level or stage-specific level
5. Assets show proper icons (BookOpen for grammar, Languages for vocabulary)

### For Students (My Course)
1. Navigate to My Course → A0 Foundations
2. See 6 units available
3. Click on a unit to see:
   - Unit flagship task
   - Pre-study resources (unit-level assets)
   - List of 4 lessons
4. Click on a lesson to see:
   - Lesson stages
   - Stage-specific assets (in each stage)
   - Lesson-level assets (at bottom)
5. Expand assets to see full content
6. Viewing assets triggers:
   - Activity tracking (3-second threshold)
   - SRS system (for spaced repetition)
   - Progress tracking

## Progress Tracking Integration

When students view grammar or vocabulary content:
1. `useActivityTracker` hook records the view
2. After 3 seconds of viewing, marks as "viewed"
3. Data flows to `user_activity` table
4. SRS system schedules reviews based on algorithm
5. Progress dashboard shows:
   - Lessons completed
   - Assets viewed
   - SRS items due for review
   - Overall progress percentage

## Next Steps for Full Implementation

### Immediate (You can do now)
1. Run the migrations to create the structure
2. Use Course Builder to review Lesson 1 assets
3. Test student view by navigating to My Course → A0 → Unit 1 → Lesson 1

### Short-term (Next lessons)
1. Create grammar chapters for Units 1-6 remaining lessons
2. Create vocabulary entries for Units 1-6 remaining lessons
3. Use Course Builder to link assets to each lesson
4. Add lesson stages for structured learning flow

### Medium-term (Content expansion)
1. Create A1 level structure (similar to A0)
2. Seed A1 grammar and vocabulary
3. Link A1 assets to lessons
4. Publish A1 for students

## Database Schema Reference

### Key Tables
- `courses` - Top-level course container
- `levels` - CEFR levels (A0, A1, A2, B1, B2, C1, C2)
- `units` - Thematic units within a level
- `lessons` - Individual lessons within a unit
- `lesson_stages` - Stages within a lesson (optional)
- `grammar_chapters` - Grammar reference content
- `lexicon_entries` - Vocabulary entries
- `lesson_assets` - Links lessons to grammar/vocabulary
- `unit_assets` - Links units to grammar/vocabulary

### Key Views
- `lesson_assets_with_content` - Lesson assets with full grammar/vocab data
- `unit_assets_with_content` - Unit assets with full grammar/vocab data

## Testing Checklist

### Course Builder
- [ ] Open Lesson Editor for A0-U1-L1
- [ ] Verify "Currently Linked" shows actual asset names
- [ ] Verify grammar shows with BookOpen icon
- [ ] Verify vocabulary shows with Languages icon
- [ ] Try linking a new asset
- [ ] Try unlinking an asset

### Student View
- [ ] Navigate to My Course
- [ ] Verify A0 Foundations is visible
- [ ] Click on Unit 1: Hello & Identity
- [ ] Verify "Pre-Study Resources" section appears (if unit assets exist)
- [ ] Verify 4 lessons are listed
- [ ] Click on Lesson 1: Professional Greetings & Names
- [ ] Verify lesson-level assets appear at bottom
- [ ] Expand a grammar chapter - verify full content shows
- [ ] Expand a vocabulary entry - verify definition, examples, etc.
- [ ] Wait 3 seconds - verify asset marked as viewed

### Progress Tracking
- [ ] After viewing assets, go to Progress page
- [ ] Verify activity is recorded
- [ ] Check SRS section for scheduled reviews
- [ ] Verify progress percentage updates

## Troubleshooting

### Assets not showing in Course Builder
- Check that grammar_chapters and lexicon_entries have `is_published = true`
- Verify the migration ran successfully
- Check browser console for errors

### Assets not showing for students
- Verify lesson is published (`is_published = true`)
- Verify assets are linked in `lesson_assets` table
- Check that the view `lesson_assets_with_content` exists
- Verify RLS policies allow students to read

### Asset names still showing as "Grammar" or "Vocabulary"
- Clear browser cache
- Verify AssetSelector changes were applied
- Check that grammar/vocabulary data exists in database

## Architecture Improvements Made

1. **Database Views**: Centralized asset joining logic for consistency
2. **Component Reusability**: UnitAssetViewer follows same pattern as LinkedAssetViewer
3. **Type Safety**: Using proper TypeScript types throughout
4. **Performance**: Views reduce complex joins in application code
5. **Maintainability**: Clear separation between unit/lesson/stage assets

## Future Enhancements

1. **Bulk Asset Linking**: Allow linking multiple assets at once
2. **Asset Preview**: Show asset content preview before linking
3. **Asset Search**: Filter assets by CEFR level, type, or keyword
4. **Asset Analytics**: Track which assets are most viewed/helpful
5. **Asset Recommendations**: Suggest related assets based on lesson content
6. **Asset Versioning**: Track changes to grammar/vocabulary over time
