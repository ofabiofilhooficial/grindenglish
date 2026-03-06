# Apply SRS System - Checklist

Follow these steps to apply the Spaced Repetition System to your GrindEnglish instance.

## Prerequisites

- [ ] Progress tracking system already applied
- [ ] Access to Supabase dashboard
- [ ] Project deployed to Lovable/production
- [ ] At least one vocabulary word published

## Step 1: Apply Database Migration

1. [ ] Open your Supabase project dashboard
2. [ ] Navigate to SQL Editor
3. [ ] Click "New Query"
4. [ ] Open `supabase/migrations/20260306000000_create_srs_system.sql`
5. [ ] Copy the entire contents
6. [ ] Paste into Supabase SQL Editor
7. [ ] Click "Run" or press Ctrl+Enter
8. [ ] Verify success message (no errors)

### Verify Table Created

Run this query to confirm table exists:

```sql
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' 
AND table_name = 'srs_cards';
```

Expected result: 1 row showing `srs_cards`.

## Step 2: Verify Database Functions

Run this query to confirm functions exist:

```sql
SELECT routine_name 
FROM information_schema.routines 
WHERE routine_schema = 'public' 
AND routine_name IN (
  'get_or_create_srs_card',
  'update_srs_card',
  'get_due_cards_count',
  'update_words_learned_counter'
);
```

Expected result: 4 rows showing all functions.

## Step 3: Verify Trigger

Run this query to confirm trigger exists:

```sql
SELECT tgname 
FROM pg_trigger 
WHERE tgname = 'update_words_learned_on_review';
```

Expected result: 1 row showing the trigger.

## Step 4: Test Database Functions

### Test Card Creation

```sql
-- Replace 'your-user-id' and 'word-id' with actual UUIDs
SELECT get_or_create_srs_card(
  'your-user-id'::uuid,
  'word-id'::uuid
);
```

Expected result: Returns a UUID (the card ID).

### Verify Card Created

```sql
SELECT * FROM srs_cards 
WHERE user_id = 'your-user-id'::uuid 
ORDER BY created_at DESC 
LIMIT 1;
```

Expected result: Shows card with default values:
- ease_factor: 2.5
- interval: 0
- repetitions: 0
- next_review_date: now()

### Test SM-2 Algorithm

```sql
-- Test "Good" rating (4)
SELECT * FROM update_srs_card('card-id'::uuid, 4);
```

Expected result: Returns table with:
- new_ease_factor: ~2.5
- new_interval: 1
- new_repetitions: 1
- new_next_review_date: tomorrow

### Test Due Count

```sql
SELECT get_due_cards_count('your-user-id'::uuid);
```

Expected result: Returns integer (0 or more).

## Step 5: Deploy Frontend Code

1. [ ] Commit all changes to git
2. [ ] Push to your repository
3. [ ] Deploy to Lovable (or your hosting platform)
4. [ ] Wait for deployment to complete

### Files to Verify in Deployment

- [ ] `src/lib/srs.ts`
- [ ] `src/hooks/useSRS.tsx`
- [ ] `src/components/srs/SRSReviewModal.tsx`
- [ ] `src/components/srs/SRSReviewQueue.tsx`
- [ ] `src/pages/reference/VocabularyReferencePage.tsx` (updated)
- [ ] `src/pages/DashboardPage.tsx` (updated)

## Step 6: Test Vocabulary Integration

### Test Card Creation from UI

1. [ ] Log in to your application
2. [ ] Navigate to Vocabulary Reference
3. [ ] Click on any published word
4. [ ] Read the definition
5. [ ] Click X or outside to close
6. [ ] Assessment modal should appear
7. [ ] Should show 4 rating buttons
8. [ ] Click "Good" (🟢)
9. [ ] Should see toast: "Review scheduled!"
10. [ ] Modal should close

### Verify Card in Database

```sql
SELECT 
  c.*,
  l.headword
FROM srs_cards c
JOIN lexicon_entries l ON c.word_id = l.id
WHERE c.user_id = 'your-user-id'::uuid
ORDER BY c.created_at DESC
LIMIT 1;
```

Expected result: Shows card with:
- ease_factor: ~2.5
- interval: 1
- repetitions: 1
- next_review_date: tomorrow
- headword: the word you reviewed

### Verify Words Learned Counter

```sql
SELECT words_learned 
FROM learner_progress 
WHERE user_id = 'your-user-id'::uuid;
```

Expected result: Should be 1 (or incremented by 1).

## Step 7: Test Review Queue

### Make Card Due

```sql
UPDATE srs_cards 
SET next_review_date = now() - INTERVAL '1 hour'
WHERE user_id = 'your-user-id'::uuid;
```

### Test Dashboard Display

1. [ ] Navigate to Dashboard
2. [ ] Should see "Time to Review: 1 Word" card
3. [ ] Card should have Brain icon
4. [ ] Should show bilingual text (EN/PT)
5. [ ] Should have "Start Review" button

### Test Review Session

1. [ ] Click "Start Review" button
2. [ ] Review dialog should open
3. [ ] Should show progress: "0 / 1"
4. [ ] Should show progress bar
5. [ ] Should display word with:
   - [ ] Headword (large text)
   - [ ] IPA pronunciation (if available)
   - [ ] Part of speech badge
   - [ ] Definition
   - [ ] Examples (if available)
   - [ ] Collocations (if available)
6. [ ] Click "Rate Your Recall" button
7. [ ] Assessment modal should appear
8. [ ] Click any rating
9. [ ] Should see toast confirmation
10. [ ] Should show completion screen
11. [ ] Click "Close"
12. [ ] Dashboard should update (no due words)

## Step 8: Test Different Ratings

Create multiple cards and test each rating:

### Test "Forgot" (🔴)

1. [ ] Create a card
2. [ ] Make it due
3. [ ] Review and rate "Forgot"
4. [ ] Check database:

```sql
SELECT ease_factor, interval, repetitions, next_review_date
FROM srs_cards 
WHERE id = 'card-id'::uuid;
```

Expected:
- ease_factor: 2.5 (unchanged)
- interval: 1
- repetitions: 0 (reset)
- next_review_date: tomorrow

### Test "Hard" (🟠)

1. [ ] Create a card
2. [ ] Make it due
3. [ ] Review and rate "Hard"
4. [ ] Check database

Expected:
- ease_factor: ~2.36 (decreased slightly)
- interval: 1
- repetitions: 1
- next_review_date: tomorrow

### Test "Good" (🟢)

1. [ ] Create a card
2. [ ] Make it due
3. [ ] Review and rate "Good"
4. [ ] Check database

Expected:
- ease_factor: ~2.5 (maintained)
- interval: 1
- repetitions: 1
- next_review_date: tomorrow

### Test "Easy" (🔵)

1. [ ] Create a card
2. [ ] Make it due
3. [ ] Review and rate "Easy"
4. [ ] Check database

Expected:
- ease_factor: ~2.6 (increased)
- interval: 1
- repetitions: 1
- next_review_date: tomorrow

## Step 9: Test Progression

Test the interval progression:

1. [ ] Create a card
2. [ ] Review 1st time (Good): interval = 1 day
3. [ ] Wait/update next_review_date
4. [ ] Review 2nd time (Good): interval = 6 days
5. [ ] Wait/update next_review_date
6. [ ] Review 3rd time (Good): interval = ~15 days (6 × 2.5)
7. [ ] Verify exponential growth

```sql
-- View review history
SELECT 
  last_reviewed_at,
  ease_factor,
  interval,
  repetitions,
  next_review_date
FROM srs_cards
WHERE id = 'card-id'::uuid;
```

## Step 10: Test Multiple Users

1. [ ] Create a test user account
2. [ ] Log in as test user
3. [ ] Create SRS cards
4. [ ] Verify original user's cards are separate
5. [ ] Verify RLS policies working

```sql
-- This should only show YOUR cards
SELECT COUNT(*) FROM srs_cards;
```

## Step 11: Verify Security (RLS)

Test that users can only see their own data:

```sql
-- Should return only YOUR cards
SELECT * FROM srs_cards;

-- Should return only YOUR due count
SELECT get_due_cards_count(auth.uid());
```

If you see other users' data, RLS policies are not working correctly.

## Step 12: Monitor for Errors

### Check Browser Console

- [ ] No JavaScript errors
- [ ] No failed API requests
- [ ] SRS modals opening/closing correctly
- [ ] Toast notifications appearing

### Check Supabase Logs

1. [ ] Open Supabase Dashboard
2. [ ] Navigate to Logs
3. [ ] Check for database errors
4. [ ] Verify RPC calls succeeding
5. [ ] Check trigger execution

## Step 13: Performance Check

### Test with Multiple Cards

1. [ ] Create 10+ vocabulary cards
2. [ ] Make them all due
3. [ ] Start review session
4. [ ] Verify smooth performance
5. [ ] Check loading times
6. [ ] Verify progress updates

### Check Query Performance

```sql
-- Should be fast (< 100ms)
EXPLAIN ANALYZE
SELECT * FROM srs_cards
WHERE user_id = 'your-user-id'::uuid
AND next_review_date <= now();
```

## Troubleshooting

### Assessment modal not appearing

**Possible causes:**
- Card already reviewed today
- Word not in lexicon_entries
- JavaScript error

**Solution:**
1. Check browser console
2. Verify word exists in database
3. Check next_review_date is in past

### Review queue not showing

**Possible causes:**
- No due cards
- RLS blocking access
- Component not imported

**Solution:**
1. Verify due cards exist:
```sql
SELECT COUNT(*) FROM srs_cards
WHERE user_id = 'your-user-id'::uuid
AND next_review_date <= now();
```
2. Check browser console
3. Verify component imported in Dashboard

### Words learned not incrementing

**Possible causes:**
- Trigger not installed
- Rating < 3 (forgot/hard on first try)
- Card already had repetitions > 0

**Solution:**
1. Verify trigger exists (Step 3)
2. Check rating value
3. Verify card repetitions went from 0 to 1+

### Intervals not calculating correctly

**Possible causes:**
- Function error
- Wrong rating value
- Database function not updated

**Solution:**
1. Test function directly:
```sql
SELECT * FROM update_srs_card('card-id'::uuid, 4);
```
2. Check function definition
3. Re-run migration if needed

## Success Criteria

✅ All checklist items completed
✅ Assessment modal appears when closing definitions
✅ Four rating buttons work correctly
✅ Review queue shows on dashboard
✅ Review session works smoothly
✅ Words learned counter increments
✅ Different ratings produce different intervals
✅ Progression follows SM-2 algorithm
✅ No errors in browser console
✅ No errors in Supabase logs
✅ Multiple users have separate data
✅ RLS policies working correctly

## Next Steps

After successful deployment:

1. Monitor user engagement with SRS
2. Collect feedback on review experience
3. Analyze retention data
4. Plan statistics dashboard
5. Consider adding audio to reviews
6. Plan bulk vocabulary import

## Support

If you encounter issues:

1. Check [SRS_SYSTEM_GUIDE.md](./SRS_SYSTEM_GUIDE.md#troubleshooting)
2. Review [SRS_IMPLEMENTATION_SUMMARY.md](./SRS_IMPLEMENTATION_SUMMARY.md)
3. Check Supabase documentation
4. Review browser console and network logs

## Rollback Plan

If you need to rollback:

```sql
-- Remove trigger
DROP TRIGGER IF EXISTS update_words_learned_on_review ON public.srs_cards;

-- Remove functions
DROP FUNCTION IF EXISTS public.update_words_learned_counter CASCADE;
DROP FUNCTION IF EXISTS public.get_due_cards_count CASCADE;
DROP FUNCTION IF EXISTS public.update_srs_card CASCADE;
DROP FUNCTION IF EXISTS public.get_or_create_srs_card CASCADE;

-- Remove table (WARNING: Deletes all SRS data)
DROP TABLE IF EXISTS public.srs_cards CASCADE;
```

Then redeploy previous frontend version.

**Note:** This will delete all SRS data. Only use if absolutely necessary.
