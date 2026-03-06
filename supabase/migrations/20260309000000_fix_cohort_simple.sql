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
