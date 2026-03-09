-- =====================================================
-- JWT Claims Injection Hook
-- =====================================================
-- This migration creates a custom access token hook that injects
-- the user's role into the JWT claims at token generation time.
--
-- IMPORTANT: After running this migration, you MUST manually configure
-- the hook in Supabase Dashboard:
--   1. Navigate to: Authentication > Hooks
--   2. Select: Custom Access Token Hook
--   3. Set Hook Name: custom_access_token_hook
--   4. Set Function: public.custom_access_token_hook
--   5. Enable the hook
--
-- This ensures that all JWT tokens include the 'user_role' claim,
-- enabling role-based authorization throughout the application.
-- =====================================================

CREATE OR REPLACE FUNCTION public.custom_access_token_hook(event jsonb)
RETURNS jsonb
LANGUAGE plpgsql
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  claims jsonb;
  user_role public.app_role;
BEGIN
  -- Fetch the user's primary role
  SELECT role INTO user_role
  FROM public.user_roles
  WHERE user_id = (event->>'user_id')::uuid
  ORDER BY created_at ASC
  LIMIT 1;

  -- Extract existing claims
  claims := event->'claims';

  -- Add custom claim
  IF user_role IS NOT NULL THEN
    claims := jsonb_set(claims, '{user_role}', to_jsonb(user_role::text));
  END IF;

  -- Update the event
  event := jsonb_set(event, '{claims}', claims);

  RETURN event;
END;
$$;

-- Add comment for documentation
COMMENT ON FUNCTION public.custom_access_token_hook(jsonb) IS 
'Custom access token hook that injects user role into JWT claims. Must be registered in Supabase Dashboard under Authentication > Hooks > Custom Access Token Hook.';
