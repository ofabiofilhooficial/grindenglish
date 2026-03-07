# Test Lesson 1 Flow - Quick Guide

## Prerequisites
✅ Migration `20260307000005_add_stage_completion_tracking.sql` applied
✅ Lesson 1 stages populated (6 stages with content)
✅ Vocabulary assets linked to Lesson 1

## Test Flow

### 1. Navigate to Lesson 1
```
Home → My Courses → A0 Foundations → Unit 1 → Lesson 1: Professional Greetings & Names
```

**Expected**:
- Lesson page loads
- Left sidebar shows 6 stages
- Only Stage 0 is clickable (others show lock icons)
- Stage 0 content is displayed

### 2. Complete Stage 0 - Vocabulary Practice
**Stage 0: Retrieval (Warm-up)**

**Expected Content**:
- Objective: "Assess prior knowledge"
- Three vocabulary items to translate:
  1. Oi → (type "hi" or "hello")
  2. Bom dia → (type "good morning")
  3. Boa tarde → (type "good afternoon")

**Test Steps**:
1. Type "hi" in first input, press Enter or click "Check"
   - ✅ Should show green checkmark
   - ✅ Should show "Correct! 'hi' will be added to your review schedule"
   
2. Type "wrong" in second input, click "Check"
   - ❌ Should show red X
   - ❌ Should show hint: "Not quite. Try again! Hint: g..."
   - Try again with "good morning"
   - ✅ Should show green checkmark

3. Complete third item with "good afternoon"
   - ✅ Should show green checkmark

4. After all correct:
   - ✅ Should show success message: "Excellent work! You got all translations correct..."
   - ✅ Should show "Complete Stage" button at bottom
   - ✅ Progress indicator shows "3 / 3 correct"

5. Click "Complete Stage" button
   - ✅ Stage 1 should unlock in sidebar
   - ✅ Should automatically navigate to Stage 1
   - ✅ Progress bar at top should update (1/6 = ~17%)

### 3. Navigate Through Stages
**Stage 1: The Hook - "Notice the Gap"**

**Expected**:
- Stage 1 content displays
- Scenario: Zoom meeting introduction
- Diagnostic task visible
- "Complete Stage" button at bottom

**Test Steps**:
1. Read through stage content
2. Click "Complete Stage"
   - ✅ Stage 2 unlocks
   - ✅ Navigates to Stage 2
   - ✅ Progress bar updates (2/6 = ~33%)

**Repeat for Stages 2-5**:
- Stage 2: Targeted Input
- Stage 3: Focused Practice
- Stage 4: Communicative Task
- Stage 5: Debrief & Upgrade

### 4. Complete Final Stage
**Stage 5: Debrief & Upgrade**

**Test Steps**:
1. Read through stage content
2. Click "Complete Stage"
   - ✅ All stages show checkmarks
   - ✅ Progress bar shows 100%
   - ✅ "Finish Lesson" button appears

3. Click "Finish Lesson"
   - ✅ Navigates back to Unit 1 page
   - ✅ Lesson 1 shows as complete

### 5. Test Asset Expansion
**Additional Reference Materials (at bottom of lesson)**

**Test Steps**:
1. Scroll to bottom of any stage
2. Find "Additional Reference Materials" section
3. Click on a grammar asset (e.g., "Verb To Be")
   - ✅ Content expands
   - ✅ Shows grammar chapter details
   - ✅ "Mark as Understood" button appears

4. Click on a vocabulary asset (e.g., "Greetings")
   - ✅ Content expands
   - ✅ Shows lexicon entry details
   - ✅ "Mark as Understood" button appears

### 6. Test Stage Resources
**Resources for This Stage**

**Test Steps**:
1. In Stage 1, look for "Resources for This Stage" section
2. Click on any linked asset
   - ✅ Content expands
   - ✅ Shows full asset details
   - ✅ Can collapse by clicking again

### 7. Test Lock Behavior
**Locked Stages**

**Test Steps**:
1. Start a new lesson (or reset completion)
2. Try clicking on Stage 2 (should be locked)
   - ✅ Nothing happens (disabled)
   - ✅ Lock icon visible
   - ✅ Grayed out appearance

3. Complete Stage 0
4. Try clicking on Stage 2 (should still be locked)
   - ✅ Nothing happens
   - ✅ Only Stage 1 is unlocked

### 8. Test SRS Integration
**Verify Vocabulary in Review Schedule**

**Test Steps**:
1. Complete Stage 0 vocabulary practice
2. Navigate to Progress section
3. Click on "Review Schedule" or "SRS Reviews"
   - ✅ Should see vocabulary items:
     - "hi"
     - "good morning"
     - "good afternoon"
   - ✅ Each should have next review date
   - ✅ Quality scores recorded

### 9. Test Progress Tracking
**Progress Dashboard**

**Test Steps**:
1. Navigate to Progress section
2. Check lesson completion
   - ✅ Lesson 1 shows as complete
   - ✅ Stage completion count: 6/6
   - ✅ Vocabulary learned: +3

### 10. Test Course Builder (Admin)
**Asset Linking in Course Builder**

**Test Steps**:
1. Navigate to Course Builder
2. Open Lesson 1
3. Check linked assets
   - ✅ Shows actual asset names (not "Grammar"/"Vocabulary")
   - ✅ Can expand to see content
   - ✅ Can add/remove assets

## Expected Results Summary

### Visual Indicators
- ✅ Lock icons on locked stages
- ✅ Checkmarks on completed stages
- ✅ Current stage highlighted
- ✅ Progress bar updates in real-time

### Functionality
- ✅ Can only access unlocked stages
- ✅ Vocabulary practice works correctly
- ✅ Stage completion persists
- ✅ Assets expand/collapse properly
- ✅ SRS integration tracks vocabulary

### Data Persistence
- ✅ Completion saved to database
- ✅ Refresh page maintains progress
- ✅ Different users have separate progress
- ✅ RLS policies enforce security

## Common Issues & Solutions

### Issue: Stages don't unlock
**Solution**: Check browser console for errors. Verify migration applied.

### Issue: Vocabulary practice doesn't show
**Solution**: Check Stage 0 has `stage_type = 'warm_up'` in database.

### Issue: Assets don't expand
**Solution**: Verify database views exist: `lesson_assets_with_content`, `unit_assets_with_content`

### Issue: SRS not tracking
**Solution**: Check `record_srs_review` function exists and user is authenticated.

### Issue: Progress bar doesn't update
**Solution**: Verify `getCompletionCount()` is being called correctly.

## Browser Console Checks

### Expected Console Logs
```
Lesson query result: { lessonData: {...}, lessonError: null }
Stages query result: { stagesData: [...6 stages], stagesError: null }
```

### No Errors Expected
- No 404s for missing assets
- No RLS policy violations
- No undefined property errors

## Performance Checks

### Load Times
- Lesson page: < 1 second
- Stage navigation: Instant
- Asset expansion: < 500ms
- Completion tracking: < 500ms

### Database Queries
- Efficient use of views
- No N+1 query problems
- Proper indexing on foreign keys

## Security Checks

### RLS Policies
- Users can only see their own completions
- Users cannot modify other users' data
- Anonymous users cannot access completion data

### Data Validation
- Stage IDs validated before completion
- User authentication required
- SQL injection prevented

## Success Criteria

✅ All 6 stages can be completed in sequence
✅ Vocabulary practice works correctly
✅ Assets expand and show content
✅ Progress persists across sessions
✅ SRS integration tracks vocabulary
✅ No console errors
✅ Smooth user experience

---

**Test Status**: Ready for testing
**Estimated Test Time**: 10-15 minutes
**Priority**: High - Core feature
