-- Cohort Management & Assignment System
-- Allows teachers to group students, track progress, and assign content

-- Helper function: Check if user is a teacher
CREATE OR REPLACE FUNCTION public.is_teacher(_user_id UUID)
RETURNS BOOLEAN
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT EXISTS (
    SELECT 1 FROM public.user_roles
    WHERE user_id = _user_id AND role = 'teacher'
  )
$$;

-- Cohorts: Groups of students managed by a teacher
CREATE TABLE public.cohorts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  description TEXT,
  teacher_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  is_active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_cohorts_teacher ON public.cohorts(teacher_id);
CREATE INDEX idx_cohorts_active ON public.cohorts(is_active);

ALTER TABLE public.cohorts ENABLE ROW LEVEL SECURITY;

-- Cohort Members: Junction table linking students to cohorts
CREATE TABLE public.cohort_members (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  cohort_id UUID NOT NULL REFERENCES public.cohorts(id) ON DELETE CASCADE,
  student_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  joined_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE(cohort_id, student_id)
);

CREATE INDEX idx_cohort_members_cohort ON public.cohort_members(cohort_id);
CREATE INDEX idx_cohort_members_student ON public.cohort_members(student_id);

ALTER TABLE public.cohort_members ENABLE ROW LEVEL SECURITY;

-- Assignments: Content assigned to students or cohorts
CREATE TABLE public.assignments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  cohort_id UUID REFERENCES public.cohorts(id) ON DELETE CASCADE,
  student_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  teacher_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  content_type TEXT NOT NULL, -- 'grammar', 'vocabulary', 'lesson', 'unit'
  content_id UUID NOT NULL, -- References lexicon_entries, grammar_chapters, lessons, or units
  status TEXT NOT NULL DEFAULT 'pending', -- 'pending', 'in_progress', 'completed'
  due_date TIMESTAMPTZ,
  assigned_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  completed_at TIMESTAMPTZ,
  notes TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  CHECK (cohort_id IS NOT NULL OR student_id IS NOT NULL)
);

CREATE INDEX idx_assignments_cohort ON public.assignments(cohort_id);
CREATE INDEX idx_assignments_student ON public.assignments(student_id);
CREATE INDEX idx_assignments_teacher ON public.assignments(teacher_id);
CREATE INDEX idx_assignments_status ON public.assignments(status);
CREATE INDEX idx_assignments_content ON public.assignments(content_type, content_id);

ALTER TABLE public.assignments ENABLE ROW LEVEL SECURITY;

-- Function: Get teacher's students (from all their cohorts)
CREATE OR REPLACE FUNCTION public.get_teacher_students(_teacher_id UUID)
RETURNS TABLE (
  student_id UUID,
  full_name TEXT,
  avatar_url TEXT,
  cohort_count BIGINT
)
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT DISTINCT
    u.id as student_id,
    p.full_name,
    p.avatar_url,
    COUNT(DISTINCT cm.cohort_id) as cohort_count
  FROM auth.users u
  JOIN public.profiles p ON u.id = p.id
  JOIN public.cohort_members cm ON u.id = cm.student_id
  JOIN public.cohorts c ON cm.cohort_id = c.id
  WHERE c.teacher_id = _teacher_id
  GROUP BY u.id, p.full_name, p.avatar_url
  ORDER BY p.full_name;
$$;

-- Function: Get cohort progress summary
CREATE OR REPLACE FUNCTION public.get_cohort_progress(_cohort_id UUID)
RETURNS TABLE (
  student_id UUID,
  full_name TEXT,
  current_streak INT,
  words_learned INT,
  lessons_completed INT,
  last_activity_date DATE,
  pending_assignments BIGINT,
  completed_assignments BIGINT
)
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT
    cm.student_id,
    p.full_name,
    COALESCE(lp.current_streak, 0) as current_streak,
    COALESCE(lp.words_learned, 0) as words_learned,
    COALESCE(lp.lessons_completed, 0) as lessons_completed,
    lp.last_activity_date,
    COUNT(DISTINCT a.id) FILTER (WHERE a.status = 'pending') as pending_assignments,
    COUNT(DISTINCT a.id) FILTER (WHERE a.status = 'completed') as completed_assignments
  FROM public.cohort_members cm
  JOIN public.profiles p ON cm.student_id = p.id
  LEFT JOIN public.learner_progress lp ON cm.student_id = lp.user_id
  LEFT JOIN public.assignments a ON (
    (a.student_id = cm.student_id OR a.cohort_id = cm.cohort_id)
  )
  WHERE cm.cohort_id = _cohort_id
  GROUP BY cm.student_id, p.full_name, lp.current_streak, lp.words_learned, 
           lp.lessons_completed, lp.last_activity_date
  ORDER BY p.full_name;
$$;

-- Function: Bulk add words to student SRS (for live class)
CREATE OR REPLACE FUNCTION public.teacher_add_words_to_srs(
  _student_ids UUID[],
  _word_ids UUID[],
  _teacher_id UUID
)
RETURNS TABLE (
  student_id UUID,
  word_id UUID,
  card_id UUID,
  success BOOLEAN
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_student_id UUID;
  v_word_id UUID;
  v_card_id UUID;
BEGIN
  -- Verify teacher has access to these students
  IF NOT EXISTS (
    SELECT 1 FROM public.cohort_members cm
    JOIN public.cohorts c ON cm.cohort_id = c.id
    WHERE c.teacher_id = _teacher_id
    AND cm.student_id = ANY(_student_ids)
  ) THEN
    RAISE EXCEPTION 'Teacher does not have access to one or more students';
  END IF;

  -- Loop through students and words
  FOREACH v_student_id IN ARRAY _student_ids
  LOOP
    FOREACH v_word_id IN ARRAY _word_ids
    LOOP
      BEGIN
        -- Get or create SRS card
        v_card_id := public.get_or_create_srs_card(v_student_id, v_word_id);
        
        RETURN QUERY SELECT v_student_id, v_word_id, v_card_id, true;
      EXCEPTION WHEN OTHERS THEN
        RETURN QUERY SELECT v_student_id, v_word_id, NULL::UUID, false;
      END;
    END LOOP;
  END LOOP;
END;
$$;

-- Function: Get student's assignments (for student view)
CREATE OR REPLACE FUNCTION public.get_student_assignments(_student_id UUID)
RETURNS TABLE (
  id UUID,
  content_type TEXT,
  content_id UUID,
  status TEXT,
  due_date TIMESTAMPTZ,
  assigned_at TIMESTAMPTZ,
  teacher_name TEXT,
  cohort_name TEXT,
  notes TEXT
)
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT
    a.id,
    a.content_type,
    a.content_id,
    a.status,
    a.due_date,
    a.assigned_at,
    p.full_name as teacher_name,
    c.name as cohort_name,
    a.notes
  FROM public.assignments a
  JOIN public.profiles p ON a.teacher_id = p.id
  LEFT JOIN public.cohorts c ON a.cohort_id = c.id
  WHERE a.student_id = _student_id
     OR a.cohort_id IN (
       SELECT cohort_id FROM public.cohort_members WHERE student_id = _student_id
     )
  ORDER BY 
    CASE WHEN a.due_date IS NULL THEN 1 ELSE 0 END,
    a.due_date ASC,
    a.assigned_at DESC;
$$;

-- RLS Policies: Cohorts
CREATE POLICY "Teachers can view own cohorts"
  ON public.cohorts FOR SELECT TO authenticated
  USING (auth.uid() = teacher_id);

CREATE POLICY "Teachers can create cohorts"
  ON public.cohorts FOR INSERT TO authenticated
  WITH CHECK (
    auth.uid() = teacher_id 
    AND public.is_teacher(auth.uid())
  );

CREATE POLICY "Teachers can update own cohorts"
  ON public.cohorts FOR UPDATE TO authenticated
  USING (auth.uid() = teacher_id);

CREATE POLICY "Teachers can delete own cohorts"
  ON public.cohorts FOR DELETE TO authenticated
  USING (auth.uid() = teacher_id);

CREATE POLICY "Students can view their cohorts"
  ON public.cohorts FOR SELECT TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM public.cohort_members
      WHERE cohort_id = cohorts.id AND student_id = auth.uid()
    )
  );

-- RLS Policies: Cohort Members
CREATE POLICY "Teachers can view members of their cohorts"
  ON public.cohort_members FOR SELECT TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM public.cohorts
      WHERE id = cohort_members.cohort_id AND teacher_id = auth.uid()
    )
  );

CREATE POLICY "Teachers can add members to their cohorts"
  ON public.cohort_members FOR INSERT TO authenticated
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.cohorts
      WHERE id = cohort_members.cohort_id AND teacher_id = auth.uid()
    )
  );

CREATE POLICY "Teachers can remove members from their cohorts"
  ON public.cohort_members FOR DELETE TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM public.cohorts
      WHERE id = cohort_members.cohort_id AND teacher_id = auth.uid()
    )
  );

CREATE POLICY "Students can view their own memberships"
  ON public.cohort_members FOR SELECT TO authenticated
  USING (student_id = auth.uid());

-- RLS Policies: Assignments
CREATE POLICY "Teachers can view assignments they created"
  ON public.assignments FOR SELECT TO authenticated
  USING (teacher_id = auth.uid());

CREATE POLICY "Teachers can create assignments"
  ON public.assignments FOR INSERT TO authenticated
  WITH CHECK (
    teacher_id = auth.uid()
    AND public.is_teacher(auth.uid())
    AND (
      -- If assigning to cohort, must own the cohort
      (cohort_id IS NOT NULL AND EXISTS (
        SELECT 1 FROM public.cohorts WHERE id = cohort_id AND teacher_id = auth.uid()
      ))
      OR
      -- If assigning to student, must have student in a cohort
      (student_id IS NOT NULL AND EXISTS (
        SELECT 1 FROM public.cohort_members cm
        JOIN public.cohorts c ON cm.cohort_id = c.id
        WHERE cm.student_id = assignments.student_id AND c.teacher_id = auth.uid()
      ))
    )
  );

CREATE POLICY "Teachers can update their assignments"
  ON public.assignments FOR UPDATE TO authenticated
  USING (teacher_id = auth.uid());

CREATE POLICY "Teachers can delete their assignments"
  ON public.assignments FOR DELETE TO authenticated
  USING (teacher_id = auth.uid());

CREATE POLICY "Students can view their assignments"
  ON public.assignments FOR SELECT TO authenticated
  USING (
    student_id = auth.uid()
    OR cohort_id IN (
      SELECT cohort_id FROM public.cohort_members WHERE student_id = auth.uid()
    )
  );

CREATE POLICY "Students can update status of their assignments"
  ON public.assignments FOR UPDATE TO authenticated
  USING (
    student_id = auth.uid()
    OR cohort_id IN (
      SELECT cohort_id FROM public.cohort_members WHERE student_id = auth.uid()
    )
  )
  WITH CHECK (
    -- Students can only update status and completed_at
    status IN ('in_progress', 'completed')
  );

-- Admins can view all
CREATE POLICY "Admins view all cohorts"
  ON public.cohorts FOR SELECT TO authenticated
  USING (public.has_role(auth.uid(), 'admin'));

CREATE POLICY "Admins view all cohort members"
  ON public.cohort_members FOR SELECT TO authenticated
  USING (public.has_role(auth.uid(), 'admin'));

CREATE POLICY "Admins view all assignments"
  ON public.assignments FOR SELECT TO authenticated
  USING (public.has_role(auth.uid(), 'admin'));

-- Triggers: Update updated_at
CREATE TRIGGER update_cohorts_updated_at
  BEFORE UPDATE ON public.cohorts
  FOR EACH ROW
  EXECUTE FUNCTION public.update_updated_at();

CREATE TRIGGER update_assignments_updated_at
  BEFORE UPDATE ON public.assignments
  FOR EACH ROW
  EXECUTE FUNCTION public.update_updated_at();

-- Trigger: Auto-set completed_at when status changes to completed
CREATE OR REPLACE FUNCTION public.set_assignment_completed_at()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
  IF NEW.status = 'completed' AND OLD.status != 'completed' THEN
    NEW.completed_at := now();
  END IF;
  RETURN NEW;
END;
$$;

CREATE TRIGGER set_assignment_completed_at_trigger
  BEFORE UPDATE ON public.assignments
  FOR EACH ROW
  WHEN (NEW.status = 'completed' AND OLD.status IS DISTINCT FROM 'completed')
  EXECUTE FUNCTION public.set_assignment_completed_at();

-- Enhanced SRS RLS: Teachers can view their students' SRS cards
CREATE POLICY "Teachers can view students SRS cards"
  ON public.srs_cards FOR SELECT TO authenticated
  USING (
    public.is_teacher(auth.uid())
    AND user_id IN (
      SELECT cm.student_id
      FROM public.cohort_members cm
      JOIN public.cohorts c ON cm.cohort_id = c.id
      WHERE c.teacher_id = auth.uid()
    )
  );

-- Enhanced SRS RLS: Teachers can insert SRS cards for their students
CREATE POLICY "Teachers can create SRS cards for students"
  ON public.srs_cards FOR INSERT TO authenticated
  WITH CHECK (
    public.is_teacher(auth.uid())
    AND user_id IN (
      SELECT cm.student_id
      FROM public.cohort_members cm
      JOIN public.cohorts c ON cm.cohort_id = c.id
      WHERE c.teacher_id = auth.uid()
    )
  );

-- Enhanced Progress RLS: Teachers can view their students' progress
CREATE POLICY "Teachers view students progress events"
  ON public.progress_events FOR SELECT TO authenticated
  USING (
    public.is_teacher(auth.uid())
    AND user_id IN (
      SELECT cm.student_id
      FROM public.cohort_members cm
      JOIN public.cohorts c ON cm.cohort_id = c.id
      WHERE c.teacher_id = auth.uid()
    )
  );

CREATE POLICY "Teachers view students learner progress"
  ON public.learner_progress FOR SELECT TO authenticated
  USING (
    public.is_teacher(auth.uid())
    AND user_id IN (
      SELECT cm.student_id
      FROM public.cohort_members cm
      JOIN public.cohorts c ON cm.cohort_id = c.id
      WHERE c.teacher_id = auth.uid()
    )
  );
