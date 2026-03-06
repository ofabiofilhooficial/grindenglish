# Progress Tracking & Cohort Management Fixes

## Issues Identified

### Issue 1: Cohort Creation Failing
**Problem**: Users couldn't create cohorts because the RLS policy required the `teacher` role, but new users only get the `learner` role by default.

**Root Cause**: The policy `"Teachers can create cohorts"` checked `public.is_teacher(auth.uid())`, but users weren't assigned the teacher role.

### Issue 2: Progress Tracking Resetting to Zero
**Problem**: Streak counter and words_learned were resetting to 0 after working correctly.

**Root Causes**:
1. The `update_user_streak()` function had logic issues with NULL handling
2. Potential timezone inconsistencies when comparing dates
3. The streak calculation wasn't properly handling the "same day" vs "consecutive day" scenarios

## Solutions Implemented

### Migration 1: `20260308000000_fix_progress_and_cohort_issues.sql`

#### Fix 1: Improved Streak Calculation
Rewrote `update_user_streak()` function with:
- Better NULL handling for first-time users
- Explicit date casting to avoid timezone issues
- Clearer logic for consecutive days vs broken streaks
- Safety check to prevent multiple updates on the same day

**Logic Flow**:
```
IF last_activity_date IS NULL:
  → First activity ever → streak = 1

ELSE IF last_activity_date = yesterday:
  → Consecutive day → streak = streak + 1

ELSE IF last_activity_date < yesterday:
  → Streak broken → streak = 1

ELSE (same day):
  → No change to streak
```

#### Fix 2: Teacher Role Assignment (Development)
Created two functions:

1. **`become_teacher()`** - Self-service function (DEVELOPMENT ONLY)
   - Allows any authenticated user to assign themselves the teacher role
   - Used for testing without admin intervention
   - **MUST BE REMOVED IN PRODUCTION**

2. **`grant_teacher_role(_user_id)`** - Admin-only function
   - Allows admins to grant teacher role to specific users
   - Proper production-ready approach
   - Requires admin role to execute

#### Fix 3: Relaxed RLS Policy (Temporary)
Modified the cohort creation policy to allow cohort creation without explicit teacher role check during development:

```sql
-- Before (strict):
WITH CHECK (auth.uid() = teacher_id AND public.is_teacher(auth.uid()))

-- After (relaxed for dev):
WITH CHECK (auth.uid() = teacher_id)
```

**Note**: Re-enable the `is_teacher()` check in production!

### Migration 2: `20260308000001_fix_words_learned_counter.sql`

#### Fix 4: Robust Words Learned Counter
Improved the `update_words_learned_counter()` trigger to:
- Use `ON CONFLICT` to ensure learner_progress record exists
- Only count words that have been successfully reviewed (repetitions >= 1)
- Prevent counter from being decremented

#### Fix 5: Recalculation Utilities
Added two utility functions for fixing corrupted counters:

1. **`recalculate_words_learned(_user_id)`** - Fix counter for specific user
   - Counts actual SRS cards with repetitions > 0
   - Updates learner_progress with correct count
   - Creates record if it doesn't exist

2. **`fix_all_words_learned_counters()`** - Fix all users (admin utility)
   - Scans all users and recalculates their counters
   - Returns list of users whose counts were corrected
   - Useful after data migration or corruption

**Usage Example**:
```sql
-- Fix your own counter
SELECT public.recalculate_words_learned(auth.uid());

-- Admin: Fix all users
SELECT * FROM public.fix_all_words_learned_counters();
```

## How to Use

### For Development/Testing

1. **Run both migrations**:
   ```bash
   # Via Lovable or Supabase CLI
   # 20260308000000_fix_progress_and_cohort_issues.sql
   # 20260308000001_fix_words_learned_counter.sql
   ```

2. **Fix your words_learned counter** (if it's showing 0):
   - Open Supabase SQL Editor
   - Run: `SELECT public.recalculate_words_learned(auth.uid());`
   - Refresh your dashboard to see the corrected count

3. **Assign yourself teacher role**:
   - Navigate to `/teach` page
   - Click the "Become Teacher (Dev)" button
   - Page will refresh automatically
   - You can now create cohorts

4. **Test progress tracking**:
   - Visit the dashboard daily
   - Check that streak increments correctly
   - Verify words_learned persists across sessions

### For Production

1. **Remove development shortcuts**:
   ```sql
   -- Drop the self-service function
   DROP FUNCTION IF EXISTS public.become_teacher();
   
   -- Restore strict RLS policy
   DROP POLICY IF EXISTS "Teachers can create cohorts" ON public.cohorts;
   
   CREATE POLICY "Teachers can create cohorts"
     ON public.cohorts FOR INSERT TO authenticated
     WITH CHECK (
       auth.uid() = teacher_id 
       AND public.is_teacher(auth.uid())
     );
   ```

2. **Use admin function to assign roles**:
   ```sql
   -- As an admin user, grant teacher role
   SELECT public.grant_teacher_role('user-uuid-here');
   ```

3. **Remove the BecomeTeacherButton component**:
   - Delete `src/components/dev/BecomeTeacherButton.tsx`
   - Remove import from `TeachDashboardPage.tsx`

## Testing Checklist

### Progress Tracking
- [ ] New user starts with streak = 0
- [ ] First activity sets streak = 1
- [ ] Activity on consecutive day increments streak
- [ ] Activity after gap resets streak to 1
- [ ] Multiple activities same day don't change streak
- [ ] words_learned persists across sessions
- [ ] Longest streak updates correctly

### Cohort Management
- [ ] User can assign themselves teacher role (dev mode)
- [ ] Teacher can create cohorts
- [ ] Teacher can view their cohorts
- [ ] Teacher can add students to cohorts
- [ ] Non-teachers cannot create cohorts (production mode)
- [ ] Admin can grant teacher role to users

## Database Functions Reference

### Progress Tracking
- `update_user_streak(_user_id UUID)` - Updates streak based on activity
- `log_activity_event(_user_id, _event_type, _event_data)` - Logs event and updates streak

### Role Management
- `has_role(_user_id UUID, _role app_role)` - Check if user has specific role
- `is_teacher(_user_id UUID)` - Check if user is a teacher
- `become_teacher()` - Self-assign teacher role (DEV ONLY)
- `grant_teacher_role(_user_id UUID)` - Admin grants teacher role (PRODUCTION)

## Known Limitations

1. **Timezone Handling**: Uses `CURRENT_DATE` which is server timezone. Consider using user's timezone for international deployments.

2. **Streak Calculation**: Only counts "any activity" per day. Doesn't distinguish between 5 minutes vs 2 hours of study.

3. **Words Learned**: Currently incremented by SRS system. Ensure SRS properly updates this counter.

## Next Steps

1. Test the fixes in development
2. Monitor progress tracking for 3-5 days to ensure stability
3. Create proper admin UI for role management
4. Plan production deployment with proper role assignment workflow
5. Consider adding more granular activity tracking (time spent, specific actions)
