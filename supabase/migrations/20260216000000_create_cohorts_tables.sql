-- Create Cohorts Tables
-- This migration creates the cohorts and cohort_members tables that are referenced
-- by other migrations but were never created.

-- Cohorts table
CREATE TABLE IF NOT EXISTS public.cohorts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  description TEXT,
  teacher_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  start_date DATE,
  end_date DATE,
  is_active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

ALTER TABLE public.cohorts ENABLE ROW LEVEL SECURITY;

COMMENT ON TABLE public.cohorts IS 'Teacher-managed groups of students';
COMMENT ON COLUMN public.cohorts.teacher_id IS 'The teacher who manages this cohort';

-- Cohort Members table
CREATE TABLE IF NOT EXISTS public.cohort_members (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  cohort_id UUID NOT NULL REFERENCES public.cohorts(id) ON DELETE CASCADE,
  student_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  joined_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  status TEXT NOT NULL DEFAULT 'active', -- active, inactive, completed
  UNIQUE(cohort_id, student_id)
);

ALTER TABLE public.cohort_members ENABLE ROW LEVEL SECURITY;

COMMENT ON TABLE public.cohort_members IS 'Students enrolled in cohorts';
COMMENT ON COLUMN public.cohort_members.student_id IS 'The student user in this cohort';

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_cohorts_teacher_id ON public.cohorts(teacher_id);
CREATE INDEX IF NOT EXISTS idx_cohort_members_cohort_id ON public.cohort_members(cohort_id);
CREATE INDEX IF NOT EXISTS idx_cohort_members_student_id ON public.cohort_members(student_id);
