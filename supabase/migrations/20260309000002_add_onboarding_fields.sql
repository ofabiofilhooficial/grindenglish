-- Add onboarding fields to profiles table
-- Requirements: 8.3, 9.2, 9.3

-- Add l1_language column with default 'pt-BR' (Brazilian Portuguese)
ALTER TABLE public.profiles 
  ADD COLUMN l1_language TEXT DEFAULT 'pt-BR';

-- Add professional_goals column for user's learning objectives
ALTER TABLE public.profiles 
  ADD COLUMN professional_goals TEXT;

-- Add onboarding_completed flag to track onboarding flow completion
ALTER TABLE public.profiles 
  ADD COLUMN onboarding_completed BOOLEAN DEFAULT false;

-- Add comment for documentation
COMMENT ON COLUMN public.profiles.l1_language IS 'User''s native language (L1), defaults to Brazilian Portuguese';
COMMENT ON COLUMN public.profiles.professional_goals IS 'User''s professional learning goals captured during onboarding';
COMMENT ON COLUMN public.profiles.onboarding_completed IS 'Tracks whether user has completed the initial onboarding flow';
