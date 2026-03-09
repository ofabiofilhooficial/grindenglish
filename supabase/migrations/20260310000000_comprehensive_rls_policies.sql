-- Comprehensive RLS Policies for Enhanced Auth & Roles System
-- This migration adds comprehensive RLS policies to enforce role-based access control
-- Requirements: 2.1, 2.2, 2.3, 2.4, 2.5, 2.6

-- ============================================================================
-- PROGRESS TRACKING TABLES - Enhanced Policies
-- ============================================================================

-- Progress Events: Add admin full access
-- Admins can view all progress events for system monitoring and analytics
CREATE POLICY "Admins have full access to progress events"
  ON public.progress_events FOR ALL TO authenticated
  USING (public.has_role(auth.uid(), 'admin'))
  WITH CHECK (public.has_role(auth.uid(), 'admin'));

-- Learner Progress: Add admin full access
-- Admins can manage all learner progress records
CREATE POLICY "Admins have full access to learner progress"
  ON public.learner_progress FOR ALL TO authenticated
  USING (public.has_role(auth.uid(), 'admin'))
  WITH CHECK (public.has_role(auth.uid(), 'admin'));

-- ============================================================================
-- PROFILES TABLE - Enhanced Policies
-- ============================================================================

-- Admins can view all profiles for user management
CREATE POLICY "Admins can view all profiles"
  ON public.profiles FOR SELECT TO authenticated
  USING (public.has_role(auth.uid(), 'admin'));

-- Admins can update any profile for user management
CREATE POLICY "Admins can update all profiles"
  ON public.profiles FOR UPDATE TO authenticated
  USING (public.has_role(auth.uid(), 'admin'))
  WITH CHECK (public.has_role(auth.uid(), 'admin'));

-- Admins can insert profiles (for manual user creation)
CREATE POLICY "Admins can insert profiles"
  ON public.profiles FOR INSERT TO authenticated
  WITH CHECK (public.has_role(auth.uid(), 'admin'));

-- Admins can delete profiles (for user removal)
CREATE POLICY "Admins can delete profiles"
  ON public.profiles FOR DELETE TO authenticated
  USING (public.has_role(auth.uid(), 'admin'));

-- ============================================================================
-- LESSONS TABLE - Teacher Assignment Scoping
-- ============================================================================

-- Note: Teacher assignment scoping requires a teacher_assignments or cohort_members table
-- to track which lessons are assigned to which teachers. The policies below are prepared
-- for when such a table exists. For now, teachers can view all published lessons.

-- Teachers can view all published lessons
-- This policy allows teachers to browse available lessons for their teaching
CREATE POLICY "Teachers can view published lessons"
  ON public.lessons FOR SELECT TO authenticated
  USING (
    public.has_role(auth.uid(), 'teacher') 
    AND is_published = true
  );

-- Future enhancement: When teacher_assignments table exists, replace above with:
-- CREATE POLICY "Teachers can view assigned lessons"
--   ON public.lessons FOR SELECT TO authenticated
--   USING (
--     public.has_role(auth.uid(), 'teacher')
--     AND (
--       is_published = true
--       OR id IN (
--         SELECT lesson_id FROM teacher_assignments WHERE teacher_id = auth.uid()
--       )
--     )
--   );

-- Admins have full access to all lessons
CREATE POLICY "Admins have full access to lessons"
  ON public.lessons FOR ALL TO authenticated
  USING (public.has_role(auth.uid(), 'admin'))
  WITH CHECK (public.has_role(auth.uid(), 'admin'));

-- ============================================================================
-- LESSON STAGES - Consistent with Lessons
-- ============================================================================

-- Teachers can view stages for published lessons
CREATE POLICY "Teachers can view published lesson stages"
  ON public.lesson_stages FOR SELECT TO authenticated
  USING (
    public.has_role(auth.uid(), 'teacher')
    AND EXISTS (
      SELECT 1 FROM public.lessons 
      WHERE id = lesson_id AND is_published = true
    )
  );

-- Admins have full access to all lesson stages
CREATE POLICY "Admins have full access to lesson stages"
  ON public.lesson_stages FOR ALL TO authenticated
  USING (public.has_role(auth.uid(), 'admin'))
  WITH CHECK (public.has_role(auth.uid(), 'admin'));

-- ============================================================================
-- COURSES, LEVELS, UNITS - Admin Full Access
-- ============================================================================

-- Admins have full access to courses
CREATE POLICY "Admins have full access to courses"
  ON public.courses FOR ALL TO authenticated
  USING (public.has_role(auth.uid(), 'admin'))
  WITH CHECK (public.has_role(auth.uid(), 'admin'));

-- Admins have full access to levels
CREATE POLICY "Admins have full access to levels"
  ON public.levels FOR ALL TO authenticated
  USING (public.has_role(auth.uid(), 'admin'))
  WITH CHECK (public.has_role(auth.uid(), 'admin'));

-- Admins have full access to units
CREATE POLICY "Admins have full access to units"
  ON public.units FOR ALL TO authenticated
  USING (public.has_role(auth.uid(), 'admin'))
  WITH CHECK (public.has_role(auth.uid(), 'admin'));

-- ============================================================================
-- ASSETS - Admin Full Access
-- ============================================================================

-- Admins have full access to assets
CREATE POLICY "Admins have full access to assets"
  ON public.assets FOR ALL TO authenticated
  USING (public.has_role(auth.uid(), 'admin'))
  WITH CHECK (public.has_role(auth.uid(), 'admin'));

-- ============================================================================
-- LEXICON, GRAMMAR, PRONUNCIATION, PRAGMATICS - Admin Full Access
-- ============================================================================

-- Admins have full access to lexicon entries
CREATE POLICY "Admins have full access to lexicon"
  ON public.lexicon_entries FOR ALL TO authenticated
  USING (public.has_role(auth.uid(), 'admin'))
  WITH CHECK (public.has_role(auth.uid(), 'admin'));

-- Admins have full access to grammar chapters
CREATE POLICY "Admins have full access to grammar"
  ON public.grammar_chapters FOR ALL TO authenticated
  USING (public.has_role(auth.uid(), 'admin'))
  WITH CHECK (public.has_role(auth.uid(), 'admin'));

-- Admins have full access to pronunciation scripts
CREATE POLICY "Admins have full access to pronunciation"
  ON public.pronunciation_scripts FOR ALL TO authenticated
  USING (public.has_role(auth.uid(), 'admin'))
  WITH CHECK (public.has_role(auth.uid(), 'admin'));

-- Admins have full access to pragmatics packs
CREATE POLICY "Admins have full access to pragmatics packs"
  ON public.pragmatics_packs FOR ALL TO authenticated
  USING (public.has_role(auth.uid(), 'admin'))
  WITH CHECK (public.has_role(auth.uid(), 'admin'));

-- Admins have full access to pragmatics items
CREATE POLICY "Admins have full access to pragmatics items"
  ON public.pragmatics_items FOR ALL TO authenticated
  USING (public.has_role(auth.uid(), 'admin'))
  WITH CHECK (public.has_role(auth.uid(), 'admin'));

-- ============================================================================
-- TAGS AND TAGGINGS - Admin Full Access
-- ============================================================================

-- Admins have full access to tags
CREATE POLICY "Admins have full access to tags"
  ON public.tags FOR ALL TO authenticated
  USING (public.has_role(auth.uid(), 'admin'))
  WITH CHECK (public.has_role(auth.uid(), 'admin'));

-- Admins have full access to taggings
CREATE POLICY "Admins have full access to taggings"
  ON public.taggings FOR ALL TO authenticated
  USING (public.has_role(auth.uid(), 'admin'))
  WITH CHECK (public.has_role(auth.uid(), 'admin'));

-- ============================================================================
-- SRS CARDS - Admin Full Access
-- ============================================================================

-- Admins have full access to SRS cards for system monitoring
CREATE POLICY "Admins have full access to srs cards"
  ON public.srs_cards FOR ALL TO authenticated
  USING (public.has_role(auth.uid(), 'admin'))
  WITH CHECK (public.has_role(auth.uid(), 'admin'));

-- ============================================================================
-- USER STAGE COMPLETIONS - Admin Full Access
-- ============================================================================

-- Admins can view all user stage completions
CREATE POLICY "Admins can view all stage completions"
  ON public.user_stage_completions FOR SELECT TO authenticated
  USING (public.has_role(auth.uid(), 'admin'));

-- Admins can manage all stage completions
CREATE POLICY "Admins can manage all stage completions"
  ON public.user_stage_completions FOR ALL TO authenticated
  USING (public.has_role(auth.uid(), 'admin'))
  WITH CHECK (public.has_role(auth.uid(), 'admin'));

-- ============================================================================
-- VOCABULARY PRACTICE ANSWERS - Admin Full Access
-- ============================================================================

-- Admins can view all vocabulary practice answers
CREATE POLICY "Admins can view all vocabulary answers"
  ON public.vocabulary_practice_answers FOR SELECT TO authenticated
  USING (public.has_role(auth.uid(), 'admin'));

-- Admins can manage all vocabulary practice answers
CREATE POLICY "Admins can manage all vocabulary answers"
  ON public.vocabulary_practice_answers FOR ALL TO authenticated
  USING (public.has_role(auth.uid(), 'admin'))
  WITH CHECK (public.has_role(auth.uid(), 'admin'));

-- ============================================================================
-- COHORTS AND COHORT MEMBERS - Admin Full Access
-- ============================================================================

-- Admins have full access to cohorts
CREATE POLICY "Admins have full access to cohorts"
  ON public.cohorts FOR ALL TO authenticated
  USING (public.has_role(auth.uid(), 'admin'))
  WITH CHECK (public.has_role(auth.uid(), 'admin'));

-- Admins have full access to cohort members
CREATE POLICY "Admins have full access to cohort members"
  ON public.cohort_members FOR ALL TO authenticated
  USING (public.has_role(auth.uid(), 'admin'))
  WITH CHECK (public.has_role(auth.uid(), 'admin'));

-- ============================================================================
-- UNIT ASSETS AND LESSON ASSETS - Admin Full Access
-- ============================================================================

-- Admins have full access to unit assets
CREATE POLICY "Admins have full access to unit assets"
  ON public.unit_assets FOR ALL TO authenticated
  USING (public.has_role(auth.uid(), 'admin'))
  WITH CHECK (public.has_role(auth.uid(), 'admin'));

-- Admins have full access to lesson assets
CREATE POLICY "Admins have full access to lesson assets"
  ON public.lesson_assets FOR ALL TO authenticated
  USING (public.has_role(auth.uid(), 'admin'))
  WITH CHECK (public.has_role(auth.uid(), 'admin'));

-- ============================================================================
-- COMMENTS
-- ============================================================================

-- This migration implements comprehensive RLS policies following these principles:
--
-- 1. LEARNER ISOLATION (Requirement 2.2, 2.5):
--    - Learners can only view/modify their own progress_tracking records
--    - Existing policies on progress_events and learner_progress enforce this
--    - Learners can view published content (lessons, courses, etc.)
--
-- 2. TEACHER ASSIGNMENT SCOPING (Requirement 2.3, 2.5):
--    - Teachers can view published lessons and related content
--    - Future enhancement: Scope to assigned lessons when teacher_assignments table exists
--    - Teachers can manage their own cohorts (existing policies)
--
-- 3. ADMIN FULL ACCESS (Requirement 2.4):
--    - Admins have full CRUD access to all protected resources
--    - This enables system administration, user management, and content oversight
--    - Admin policies added to all major tables
--
-- 4. DEFENSE IN DEPTH (Requirement 2.1, 2.6):
--    - RLS policies enforce access control at the database level
--    - Even if frontend code is bypassed, unauthorized queries return zero rows
--    - All policies use SECURITY DEFINER functions (has_role, is_content_creator)
--
-- 5. CONTENT CREATOR ACCESS:
--    - Existing policies allow admins and curriculum_designers full content access
--    - is_content_creator() function checks for admin or curriculum_designer role
--
-- Note: Some tables may have multiple policies that apply to the same role.
-- PostgreSQL RLS uses OR logic - if ANY policy grants access, the query succeeds.
-- This allows layered policies (e.g., "own records" OR "admin access").
