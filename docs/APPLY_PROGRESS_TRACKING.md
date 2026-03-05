# Apply Progress Tracking System - Checklist

Follow these steps to apply the progress tracking system to your GrindEnglish instance.

## Prerequisites

- [ ] Access to Supabase dashboard
- [ ] Project deployed to Lovable/production
- [ ] Database migrations from previous features applied

## Step 1: Apply Database Migration

1. [ ] Open your Supabase project dashboard
2. [ ] Navigate to SQL Editor
3. [ ] Click "New Query"
4. [ ] Open `supabase/migrations/20260305000000_create_progress_tracking.sql`
5. [ ] Copy the entire contents
6. [ ] Paste into Supabase SQL Editor
7. [ ] Click "Run" or press Ctrl+Enter
8. [ ] Verify success message (no errors)

### Verify Tables Created

Run this query to confirm tables exist:

```sql
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' 
AND table_name IN ('progress_events', 'learner_progress');
```

Expected result: 2 rows showing both tables.

## Step 2: Verify Database Functions

Run this query to confirm functions exist:

```sql
SELECT routine_name 
FROM information_schema.routines 
WHERE routine_schema = 'public' 
AND routine_name IN ('log_activity_event', 'update_user_streak');
```

Expected result: 2 rows showing both functions.

## Step 3: Test Database Functions

Test the activity logging function:

```sql
-- Replace 'your-user-id' with your actual user ID
SELECT log_activity_event(
  'your-user-id'::uuid,
  'dashboard_view',
  '{}'::jsonb
);
```

Expected result: Returns a UUID (the event ID).

Verify the event was logged:

```sql
SELECT * FROM progress_events 
WHERE user_id = 'your-user-id'::uuid 
ORDER BY created_at DESC 
LIMIT 1;
```

Expected result: Shows your test event.

Verify progress record was created:

```sql
SELECT * FROM learner_progress 
WHERE user_id = 'your-user-id'::uuid;
```

Expected result: Shows a record with current_streak = 1.

## Step 4: Deploy Frontend Code

1. [ ] Commit all changes to git
2. [ ] Push to your repository
3. [ ] Deploy to Lovable (or your hosting platform)
4. [ ] Wait for deployment to complete

### Files to Verify in Deployment

- [ ] `src/hooks/useActivityTracker.tsx`
- [ ] `src/hooks/useProgress.tsx`
- [ ] `src/pages/DashboardPage.tsx` (updated)
- [ ] `src/pages/reference/GrammarReferencePage.tsx` (updated)
- [ ] `src/pages/reference/VocabularyReferencePage.tsx` (updated)

## Step 5: Test in Browser

### Test Dashboard

1. [ ] Log in to your application
2. [ ] Navigate to dashboard
3. [ ] Open browser DevTools (F12)
4. [ ] Check Console for errors
5. [ ] Verify streak shows "1" (not "0")
6. [ ] Refresh page - streak should still show "1"

### Test Grammar Tracking

1. [ ] Navigate to Grammar Reference page
2. [ ] Open a grammar chapter
3. [ ] Check browser Console for errors
4. [ ] Verify in Supabase:

```sql
SELECT * FROM progress_events 
WHERE user_id = 'your-user-id'::uuid 
AND event_type = 'grammar_view'
ORDER BY created_at DESC 
LIMIT 1;
```

Expected result: Shows grammar_view event with chapter details.

### Test Vocabulary Tracking

1. [ ] Navigate to Vocabulary Reference page
2. [ ] Click on a vocabulary word
3. [ ] Check browser Console for errors
4. [ ] Verify in Supabase:

```sql
SELECT * FROM progress_events 
WHERE user_id = 'your-user-id'::uuid 
AND event_type = 'vocab_view'
ORDER BY created_at DESC 
LIMIT 1;
```

Expected result: Shows vocab_view event with word details.

## Step 6: Test Streak Logic

### Test Same Day (No Change)

1. [ ] Visit dashboard multiple times
2. [ ] Verify streak remains "1"
3. [ ] Check `learner_progress` table:

```sql
SELECT current_streak, last_activity_date 
FROM learner_progress 
WHERE user_id = 'your-user-id'::uuid;
```

Expected result: current_streak = 1, last_activity_date = today.

### Test Next Day (Increment)

Option A: Wait until tomorrow and visit dashboard
- [ ] Visit dashboard the next day
- [ ] Verify streak shows "2"

Option B: Manually test (for immediate verification)
- [ ] Run this SQL to simulate yesterday:

```sql
UPDATE learner_progress 
SET last_activity_date = CURRENT_DATE - INTERVAL '1 day'
WHERE user_id = 'your-user-id'::uuid;
```

- [ ] Visit dashboard
- [ ] Verify streak shows "2"

### Test Broken Streak (Reset)

1. [ ] Run this SQL to simulate 3 days ago:

```sql
UPDATE learner_progress 
SET last_activity_date = CURRENT_DATE - INTERVAL '3 days',
    current_streak = 5
WHERE user_id = 'your-user-id'::uuid;
```

2. [ ] Visit dashboard
3. [ ] Verify streak shows "1" (reset)
4. [ ] Verify longest_streak still shows "5"

## Step 7: Test with Multiple Users

1. [ ] Create a test user account
2. [ ] Log in as test user
3. [ ] Visit dashboard
4. [ ] Verify streak shows "1"
5. [ ] Verify original user's data is separate

## Step 8: Verify Security (RLS)

Test that users can only see their own data:

```sql
-- This should return only YOUR progress
SELECT * FROM learner_progress;

-- This should return only YOUR events
SELECT * FROM progress_events;
```

If you see other users' data, RLS policies are not working correctly.

## Step 9: Monitor for Errors

### Check Browser Console

- [ ] No JavaScript errors
- [ ] No failed API requests
- [ ] Activity events logging successfully

### Check Supabase Logs

1. [ ] Open Supabase Dashboard
2. [ ] Navigate to Logs
3. [ ] Check for database errors
4. [ ] Verify RPC calls are succeeding

## Step 10: Document Completion

- [ ] Update team on deployment
- [ ] Note any issues encountered
- [ ] Document any custom modifications
- [ ] Update internal wiki/docs if applicable

## Troubleshooting

### Streak shows "0" instead of "1"

**Possible causes:**
- Migration not applied
- RLS policies blocking access
- User not authenticated

**Solution:**
1. Verify migration applied (Step 1)
2. Check browser console for errors
3. Verify user is logged in
4. Check Supabase logs

### "Function does not exist" error

**Cause:** Migration not fully applied

**Solution:**
1. Re-run migration SQL
2. Verify functions exist (Step 2)
3. Clear browser cache
4. Redeploy frontend

### Progress data not updating

**Possible causes:**
- Supabase subscriptions not working
- Network issues
- RLS policies blocking updates

**Solution:**
1. Check browser Network tab
2. Verify Supabase connection
3. Test RLS policies (Step 8)
4. Check Supabase logs

### Events logging but streak not updating

**Cause:** `update_user_streak()` function issue

**Solution:**
1. Manually call function:

```sql
SELECT update_user_streak('your-user-id'::uuid);
```

2. Check for errors
3. Verify `learner_progress` table exists
4. Re-run migration if needed

## Success Criteria

✅ All checklist items completed
✅ Dashboard shows real streak data (not "0")
✅ Streak increments on consecutive days
✅ Streak resets after missed days
✅ Grammar and vocabulary views tracked
✅ No errors in browser console
✅ No errors in Supabase logs
✅ Multiple users have separate data
✅ RLS policies working correctly

## Next Steps

After successful deployment:

1. Monitor user engagement metrics
2. Plan study time tracking implementation
3. Plan words learned counter integration
4. Design dedicated Progress page
5. Consider achievement/badge system

## Support

If you encounter issues:

1. Check [PROGRESS_TRACKING_GUIDE.md](./PROGRESS_TRACKING_GUIDE.md#troubleshooting)
2. Review [PROGRESS_TRACKING_IMPLEMENTATION.md](./PROGRESS_TRACKING_IMPLEMENTATION.md)
3. Check Supabase documentation
4. Review browser console and network logs

## Rollback Plan

If you need to rollback:

```sql
-- Remove tables (WARNING: Deletes all progress data)
DROP TABLE IF EXISTS public.progress_events CASCADE;
DROP TABLE IF EXISTS public.learner_progress CASCADE;

-- Remove functions
DROP FUNCTION IF EXISTS public.log_activity_event CASCADE;
DROP FUNCTION IF EXISTS public.update_user_streak CASCADE;
```

Then redeploy previous frontend version.

**Note:** This will delete all progress data. Only use if absolutely necessary.
