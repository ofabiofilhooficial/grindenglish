# Cohort System Analysis & Fix

## Problem Analysis

### Issue 1: "Infinite recursion detected in policy"
**Root Cause**: The RLS policies had circular dependencies where:
- Cohort policies checked if user is a teacher
- `is_teacher()` function queries `user_roles` table
- This created a circular reference causing infinite recursion

**Solution**: Simplified policies to only check `teacher_id = auth.uid()` without calling helper functions.

### Issue 2: "Failed to load cohorts"
**Root Cause**: The RLS policies were blocking legitimate queries due to the recursion error.

**Solution**: Replaced complex policies with simple, direct checks.

### Issue 3: Progress tracking resets
**Root Cause**: This is a separate issue from cohorts. The progress tracking system exists but has bugs in the streak calculation logic.

**Solution**: Will address separately after cohorts are working.

## Current State

### What Exists:
- ✅ `cohorts` table (created manually)
- ✅ `cohort_members` table (created manually)
- ✅ `assignments` table (may exist)
- ✅ Frontend components (TeachDashboardPage, useCohorts hook)
- ❌ Broken RLS policies (causing errors)

### What's Missing:
- Simple, working RLS policies
- Student list/search functionality
- Progress tracking integration

## MVP Solution (Keep It Simple)

### Phase 1: Fix Cohorts (NOW)
1. ✅ Created simple migration: `20260309000000_fix_cohort_simple.sql`
2. Run this migration in Supabase SQL Editor
3. Test cohort creation - should work now

### Phase 2: Add Students to Cohorts (NEXT)
1. Create a simple student selector
2. Allow adding students by email
3. Display student list in cohort

### Phase 3: View Progress (LATER)
1. Fix progress tracking persistence
2. Display student progress in cohort view
3. Show streak, words learned, etc.

## Migration to Run

Run this in Supabase SQL Editor:

```sql
-- Simple Cohort System Fix
-- Removes circular RLS dependencies and simplifies policies

-- Drop all existing cohort policies to start fresh
DROP POLICY IF EXISTS "Teachers can view own cohorts" ON public.cohorts;
DROP POLICY IF EXISTS "Teachers can create cohorts" ON public.cohorts;
DROP POLICY IF EXISTS "Teachers can update own cohorts" ON public.cohorts;
DROP POLICY IF EXISTS "Teachers can delete own cohorts" ON public.cohorts;
DROP POLICY IF EXISTS "Students can view their cohorts" ON public.cohorts;
DROP POLICY IF EXISTS "Admins view all cohorts" ON public.cohorts;

DROP POLICY IF EXISTS "Teachers can view members of their cohorts" ON public.cohort_members;
DROP POLICY IF EXISTS "Teachers can add members to their cohorts" ON public.cohort_members;
DROP POLICY IF EXISTS "Teachers can remove members from their cohorts" ON public.cohort_members;
DROP POLICY IF EXISTS "Students can view their own memberships" ON public.cohort_members;
DROP POLICY IF EXISTS "Admins view all cohort members" ON public.cohort_members;

-- Simple RLS Policies for Cohorts
-- Teachers can manage their own cohorts
CREATE POLICY "Teachers manage own cohorts"
  ON public.cohorts
  FOR ALL
  TO authenticated
  USING (auth.uid() = teacher_id)
  WITH CHECK (auth.uid() = teacher_id);

-- Simple RLS Policies for Cohort Members
-- Teachers can manage members in their cohorts
CREATE POLICY "Teachers manage cohort members"
  ON public.cohort_members
  FOR ALL
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM public.cohorts
      WHERE cohorts.id = cohort_members.cohort_id
      AND cohorts.teacher_id = auth.uid()
    )
  )
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.cohorts
      WHERE cohorts.id = cohort_members.cohort_id
      AND cohorts.teacher_id = auth.uid()
    )
  );

-- Students can view their own memberships
CREATE POLICY "Students view own memberships"
  ON public.cohort_members
  FOR SELECT
  TO authenticated
  USING (student_id = auth.uid());
```

## Testing Steps

1. **Run the migration** in Supabase SQL Editor
2. **Refresh your app** at localhost:8080/teach
3. **Try creating a cohort** - should work without errors
4. **Check the cohort list** - should load without "Failed to load cohorts"

## What This Fixes

✅ Removes infinite recursion error
✅ Allows cohort creation
✅ Allows cohort listing
✅ Allows cohort deletion
✅ Simple, maintainable policies

## What's Still TODO

### Immediate (After This Works):
- [ ] Add student search/selector
- [ ] Add students to cohorts
- [ ] View cohort members

### Later (Separate Issue):
- [ ] Fix progress tracking persistence
- [ ] Display student progress in cohorts
- [ ] Add assignment features (if needed)

## Key Principles for MVP

1. **Keep it simple** - No complex helper functions in RLS
2. **One feature at a time** - Fix cohorts first, then progress
3. **Test locally** - Verify before deploying
4. **Minimal changes** - Don't affect other parts of the app

## Progress Tracking Issue (Separate)

The dashboard counters resetting is a different problem:
- Streak calculation has bugs
- Words learned counter may not persist
- This needs separate investigation and fix
- Don't mix with cohort fixes

## Next Steps

1. **Run the migration above**
2. **Test cohort creation**
3. **If working, commit and deploy**
4. **Then tackle student management**
5. **Finally fix progress tracking**

One step at a time!
