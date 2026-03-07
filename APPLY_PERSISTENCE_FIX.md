# Apply Vocabulary Persistence Fix - Quick Guide

## What This Fixes

1. ✅ Vocabulary answers now persist when you leave and return
2. ✅ Stage unlocks properly after completing vocabulary practice
3. ✅ Progress is saved automatically

## Step-by-Step Instructions

### Step 1: Apply Database Migration (2 minutes)

1. Open Supabase Dashboard
2. Go to SQL Editor
3. Click "New Query"
4. Copy and paste the entire contents of:
   ```
   supabase/migrations/20260307000006_add_vocabulary_practice_state.sql
   ```
5. Click "Run" button
6. Wait for "Success" message

### Step 2: Verify Migration (30 seconds)

Run this query in SQL Editor:
```sql
-- Should return 0 (table exists but empty)
SELECT COUNT(*) FROM vocabulary_practice_answers;

-- Should return 3 functions
SELECT proname FROM pg_proc 
WHERE proname IN (
  'save_vocabulary_answer',
  'get_vocabulary_answers',
  'reset_vocabulary_practice'
);
```

### Step 3: Test in Browser (2 minutes)

1. **Navigate to Lesson 1**
   - Home → My Courses → A0 Foundations → Unit 1 → Lesson 1

2. **Complete Vocabulary Practice**
   - Type "hi" for "Oi" → Click "Check" → See checkmark ✓
   - Type "good morning" for "Bom dia" → Click "Check" → See checkmark ✓
   - Type "good afternoon" for "Boa tarde" → Click "Check" → See checkmark ✓

3. **Leave and Return**
   - Click "Back to Unit" or navigate away
   - Return to Lesson 1
   - ✅ All answers should still be there with checkmarks

4. **Complete Stage**
   - Click "Complete Stage" button
   - ✅ Stage 1 should unlock
   - ✅ Should navigate to Stage 1
   - ✅ Progress bar should update

## Expected Results

### Before Fix
- ❌ Answers disappeared when leaving page
- ❌ Had to redo vocabulary every time
- ❌ Stage didn't unlock after completion

### After Fix
- ✅ Answers persist across sessions
- ✅ Checkmarks show for completed items
- ✅ "Complete Stage" button visible if all correct
- ✅ Stage unlocks after clicking "Complete Stage"
- ✅ Progress saved automatically

## Troubleshooting

### Problem: Migration fails
**Error**: "relation already exists"
**Solution**: Table already created, skip to Step 2

### Problem: Answers not saving
**Check**: Browser console for errors
**Solution**: Verify migration ran successfully

### Problem: Stage not unlocking
**Check**: Click "Complete Stage" button (not just getting all correct)
**Solution**: Button must be clicked to mark stage complete

### Problem: Answers not loading
**Check**: Network tab for 401/403 errors
**Solution**: Ensure you're logged in

## Quick Test Commands

### Reset Your Progress (for re-testing)
```sql
-- In Supabase SQL Editor
DELETE FROM vocabulary_practice_answers WHERE user_id = auth.uid();
DELETE FROM user_stage_completions WHERE user_id = auth.uid();
```

### Check Your Saved Answers
```sql
SELECT item_id, answer, is_correct, updated_at
FROM vocabulary_practice_answers
WHERE user_id = auth.uid()
ORDER BY updated_at DESC;
```

### Check Your Completed Stages
```sql
SELECT ls.title, usc.completed_at
FROM user_stage_completions usc
JOIN lesson_stages ls ON ls.id = usc.stage_id
WHERE usc.user_id = auth.uid()
ORDER BY usc.completed_at DESC;
```

## What Happens Behind the Scenes

### When You Type and Check an Answer
1. Answer is validated (correct/incorrect)
2. Answer saved to `vocabulary_practice_answers` table
3. SRS tracking recorded for spaced repetition
4. Visual feedback shown (checkmark or error)

### When You Return to the Lesson
1. Component loads saved answers from database
2. Restores answer text in input fields
3. Shows checkmarks for correct answers
4. If all correct, shows "Complete Stage" button

### When You Click "Complete Stage"
1. Stage marked as complete in `user_stage_completions` table
2. Next stage unlocks
3. Progress bar updates
4. Navigates to next stage

## Files Changed

- ✅ `supabase/migrations/20260307000006_add_vocabulary_practice_state.sql` (NEW)
- ✅ `src/components/lesson/VocabularyPractice.tsx` (UPDATED)
- ✅ `src/components/lesson/StageContentViewer.tsx` (UPDATED)

## Documentation

- **Detailed Guide**: `VOCABULARY_PERSISTENCE_FIX.md`
- **Implementation**: `IMPLEMENTATION_COMPLETE.md`
- **Testing**: `TEST_LESSON_1_FLOW.md`

---

**Time Required**: 5 minutes
**Difficulty**: Easy
**Status**: Ready to apply
