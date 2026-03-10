-- Fix RLS Policies for Lexicon Entries
-- Issue: Anonymous users cannot read vocabulary entries
-- Solution: Add policy to allow anonymous SELECT on published entries

-- Drop existing restrictive policy if it exists
DROP POLICY IF EXISTS "Admins have full access to lexicon" ON public.lexicon_entries;

-- Recreate admin policy
CREATE POLICY "Admins have full access to lexicon"
  ON public.lexicon_entries FOR ALL TO authenticated
  USING (public.has_role(auth.uid(), 'admin'))
  WITH CHECK (public.has_role(auth.uid(), 'admin'));

-- Add policy for content creators (if function exists)
DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM pg_proc WHERE proname = 'is_content_creator') THEN
    EXECUTE 'CREATE POLICY "Content creators full access to lexicon" 
      ON public.lexicon_entries FOR ALL TO authenticated 
      USING (public.is_content_creator(auth.uid())) 
      WITH CHECK (public.is_content_creator(auth.uid()))';
  END IF;
END $$;

-- CRITICAL: Allow anonymous users to read published vocabulary
-- This is needed for:
-- 1. Vocabulary reference page (public access)
-- 2. Lesson content (students viewing vocabulary)
-- 3. Validation scripts (using anon key)
CREATE POLICY "Anonymous read published lexicon"
  ON public.lexicon_entries FOR SELECT TO anon
  USING (is_published = true);

-- Also allow authenticated users to read published entries
CREATE POLICY "Authenticated read published lexicon"
  ON public.lexicon_entries FOR SELECT TO authenticated
  USING (is_published = true);

-- Verify policies were created
DO $$
DECLARE
  policy_count INTEGER;
BEGIN
  SELECT COUNT(*) INTO policy_count
  FROM pg_policies
  WHERE tablename = 'lexicon_entries';
  
  RAISE NOTICE 'Total RLS policies on lexicon_entries: %', policy_count;
END $$;
