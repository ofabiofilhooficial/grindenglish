# Fix Cohorts - Action Plan

## The Problem
- ❌ "Failed to load cohorts" error
- ❌ "Infinite recursion detected in policy" when creating cohorts

## The Solution
Run one simple SQL migration to fix the RLS policies.

## Step-by-Step Fix

### 1. Open Supabase SQL Editor
- Go to your Supabase Dashboard
- Click "SQL Editor" in the left sidebar

### 2. Copy and Run This SQL

```sql
-- Simple Cohort System Fix
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

CREATE POLICY "Teachers manage own cohorts"
  ON public.cohorts FOR ALL TO authenticated
  USING (auth.uid() = teacher_id)
  WITH CHECK (auth.uid() = teacher_id);

CREATE POLICY "Teachers manage cohort members"
  ON public.cohort_members FOR ALL TO authenticated
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

CREATE POLICY "Students view own memberships"
  ON public.cohort_members FOR SELECT TO authenticated
  USING (student_id = auth.uid());
```

### 3. Test It
- Go to your app: `/teach`
- Try creating a cohort
- Should work without errors! ✅

## What This Does

- Removes all the broken policies
- Creates simple, working policies
- No more infinite recursion
- Cohorts will load and create successfully

## If It Still Doesn't Work

Check if the tables exist:
```sql
SELECT * FROM public.cohorts LIMIT 1;
SELECT * FROM public.cohort_members LIMIT 1;
```

If you get "relation does not exist", you need to create the tables first. Let me know and I'll provide that SQL.

## After This Works

We can then:
1. Add student management
2. Fix progress tracking
3. Display student progress in cohorts

But first, let's get cohorts working!
