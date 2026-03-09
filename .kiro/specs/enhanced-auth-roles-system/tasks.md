# Implementation Plan: Enhanced Auth & Roles System

## Overview

This implementation transforms the Grind English authentication system into an enterprise-ready solution with database-enforced access control, social authentication, and intelligent user onboarding. The implementation follows a 7-phase approach, building from database hardening through to production migration.

## Tasks

- [x] 1. Phase 1: Database Hardening
  - [x] 1.1 Create database migration for onboarding fields
    - Add l1_language, professional_goals, and onboarding_completed columns to profiles table
    - Set appropriate defaults (l1_language='pt-BR', onboarding_completed=false)
    - Create migration file: `supabase/migrations/YYYYMMDD_add_onboarding_fields.sql`
    - _Requirements: 8.3, 9.2, 9.3_
  
  - [x] 1.2 Create JWT claims injection function
    - Implement `custom_access_token_hook` Postgres function
    - Query user_roles table for user's role
    - Inject 'user_role' claim into JWT payload
    - Set function as SECURITY DEFINER with proper search_path
    - Create migration file: `supabase/migrations/YYYYMMDD_create_jwt_claims_hook.sql`
    - _Requirements: 1.2, 1.4, 10.1, 10.2, 10.3, 10.4_
  
  - [ ]* 1.3 Write property test for JWT claims injection
    - **Property 1: JWT Role Claim Injection**
    - **Validates: Requirements 1.2, 1.4, 10.2, 10.3, 10.4**
    - Test that authenticated users receive correct 'user_role' claim in JWT
    - Use fast-check to test all role types (admin, curriculum_designer, teacher, learner)
    - Minimum 100 iterations
  
  - [x] 1.4 Implement comprehensive RLS policies
    - Create RLS policies for progress_tracking table (learner isolation)
    - Create RLS policies for lessons table (teacher assignment scoping)
    - Create RLS policies for admin full access to all protected resources
    - Create RLS policies for profiles table (own profile + admin access)
    - Create migration file: `supabase/migrations/YYYYMMDD_comprehensive_rls_policies.sql`
    - _Requirements: 2.1, 2.2, 2.3, 2.4, 2.5, 2.6_
  
  - [ ]* 1.5 Write property tests for RLS policies
    - **Property 3: Learner Data Isolation**
    - **Validates: Requirements 2.2, 2.5**
    - **Property 4: Teacher Assignment Scoping**
    - **Validates: Requirements 2.3, 2.5**
    - **Property 5: Admin Full Access**
    - **Validates: Requirements 2.4**
    - Test data isolation across different user roles
    - Minimum 100 iterations per property
  
  - [ ]* 1.6 Write unit tests for single role constraint
    - **Property 2: Single Role Per User Constraint**
    - **Validates: Requirements 1.3**
    - Test that duplicate role insertion fails with unique constraint violation
    - Test error handling for constraint violations

- [x] 2. Checkpoint - Database layer verification
  - Ensure all migrations run successfully
  - Verify JWT claims appear in tokens for test users
  - Verify RLS policies block unauthorized access
  - Ask the user if questions arise

- [-] 3. Phase 2: Social Login Integration
  - [x] 3.1 Create SocialAuthButtons component
    - Implement Google sign-in button with existing design pattern
    - Implement LinkedIn sign-in button with similar styling
    - Add loading states and disabled prop support
    - Handle OAuth click events with proper error boundaries
    - Create file: `src/components/auth/SocialAuthButtons.tsx`
    - _Requirements: 3.4, 4.4_
  
  - [x] 3.2 Enhance useAuth hook with social login methods
    - Add `signInWithGoogle()` method calling supabase.auth.signInWithOAuth()
    - Add `signInWithLinkedIn()` method calling supabase.auth.signInWithOAuth()
    - Configure OAuth redirect URLs
    - Handle OAuth callback errors
    - Update file: `src/hooks/useAuth.tsx`
    - _Requirements: 3.2, 4.2, 11.4_
  
  - [x] 3.3 Update LandingPage with social login buttons
    - Import and render SocialAuthButtons component
    - Position buttons above email/password form
    - Add "or" divider between social and email auth
    - Update file: `src/pages/LandingPage.tsx`
    - _Requirements: 3.4, 4.4_
  
  - [x] 3.4 Update LoginPage and SignupPage with social login
    - Add SocialAuthButtons to both pages
    - Maintain consistent styling with LandingPage
    - Update files: `src/pages/LoginPage.tsx`, `src/pages/SignupPage.tsx`
    - _Requirements: 3.4, 4.4, 11.3_
  
  - [ ]* 3.5 Write property test for OAuth trigger consistency
    - **Property 6: OAuth Trigger Consistency**
    - **Validates: Requirements 3.5, 4.5, 8.2, 8.3**
    - Test that new OAuth users get profile and role created
    - Verify default values (l1_language='pt-BR', role='learner')
    - Minimum 100 iterations
  
  - [ ]* 3.6 Write unit tests for social auth UI
    - Test Google button renders correctly
    - Test LinkedIn button renders correctly
    - Test loading states and disabled prop
    - Test error message display for OAuth failures

- [ ] 4. Phase 3: Intelligent Routing
  - [ ] 4.1 Create routing utilities module
    - Implement `getPreLoginDestination()` function
    - Implement `setPreLoginDestination(url)` function
    - Implement `clearPreLoginDestination()` function
    - Implement `getRoleDashboardRoute(role)` function with role mapping
    - Use sessionStorage key: 'grind_english_pre_login_destination'
    - Create file: `src/lib/routing-utils.ts`
    - _Requirements: 6.1, 6.5, 7.1, 7.2, 7.3, 7.4_
  
  - [ ] 4.2 Enhance useAuth hook with token refresh handling
    - Subscribe to `onAuthStateChange` on mount
    - Handle TOKEN_REFRESHED event by updating state silently
    - Handle SIGNED_OUT event by redirecting to login
    - Fetch updated user data on token refresh
    - Update file: `src/hooks/useAuth.tsx`
    - _Requirements: 5.1, 5.2, 5.3, 5.4, 5.5_
  
  - [ ] 4.3 Update ProtectedRoute with pre-login destination tracking
    - Store requested URL in sessionStorage when unauthenticated
    - Check onboarding_completed flag and redirect to onboarding if needed
    - Clear pre-login destination after successful navigation
    - Update file: `src/components/auth/ProtectedRoute.tsx`
    - _Requirements: 6.1, 6.2, 6.4, 6.5_
  
  - [ ] 4.4 Implement role-based dashboard routing logic
    - After authentication, check for pre-login destination first
    - If no pre-login destination, use getRoleDashboardRoute(role)
    - Redirect to appropriate dashboard based on role
    - Update file: `src/hooks/useAuth.tsx`
    - _Requirements: 6.3, 7.1, 7.2, 7.3, 7.4, 7.5_
  
  - [ ]* 4.5 Write property test for pre-login destination
    - **Property 7: Pre-Login Destination Storage**
    - **Validates: Requirements 6.1, 6.2, 6.4**
    - Test that unauthenticated route access stores URL
    - Test that authentication redirects to stored URL
    - Minimum 100 iterations
  
  - [ ]* 4.6 Write property test for role-based routing
    - **Property 8: Role-Based Default Routing**
    - **Validates: Requirements 6.3, 7.1, 7.2, 7.3, 7.4, 7.5**
    - Test all role types redirect to correct dashboard
    - Test pre-login destination takes precedence over role routing
    - Minimum 100 iterations
  
  - [ ]* 4.7 Write unit tests for routing utilities
    - Test sessionStorage operations
    - Test role-to-dashboard mapping
    - Test edge cases (null role, invalid URLs)

- [ ] 5. Checkpoint - Authentication flow verification
  - Test complete OAuth flow end-to-end
  - Test token refresh during active session
  - Test pre-login destination redirect
  - Ensure all tests pass, ask the user if questions arise

- [ ] 6. Phase 4: Onboarding Flow
  - [ ] 6.1 Create OnboardingForm component
    - Implement L1 language dropdown (pt-BR, en, es options)
    - Implement professional goals textarea with localized placeholder
    - Add skip button with confirmation
    - Add form validation and error handling
    - Create file: `src/components/auth/OnboardingForm.tsx`
    - _Requirements: 9.1, 9.2, 9.3, 9.6_
  
  - [ ] 6.2 Create OnboardingPage
    - Render OnboardingForm component
    - Handle form submission by calling updateProfile
    - Handle skip action with default values
    - Redirect to role-based dashboard after completion
    - Create file: `src/pages/OnboardingPage.tsx`
    - _Requirements: 9.1, 9.5, 9.6_
  
  - [ ] 6.3 Add updateProfile method to useAuth hook
    - Implement profile update API call to Supabase
    - Update onboarding_completed flag to true
    - Refresh local profile state after update
    - Handle update errors with user feedback
    - Update file: `src/hooks/useAuth.tsx`
    - _Requirements: 9.4, 9.5_
  
  - [ ] 6.4 Add onboarding completion check to routing
    - Check profile.onboarding_completed in ProtectedRoute
    - Redirect to OnboardingPage if onboarding incomplete
    - Allow skipping onboarding for specific routes (logout, etc.)
    - Update file: `src/components/auth/ProtectedRoute.tsx`
    - _Requirements: 9.1, 9.5_
  
  - [ ]* 6.5 Write property test for onboarding data persistence
    - **Property 9: Onboarding Data Persistence**
    - **Validates: Requirements 9.4, 9.5**
    - Test that submitted onboarding data saves to profile
    - Test that onboarding_completed flag updates correctly
    - Minimum 100 iterations
  
  - [ ]* 6.6 Write unit tests for onboarding UI
    - Test form renders with correct default values
    - Test form validation
    - Test skip functionality
    - Test error message display

- [ ] 7. Phase 5: Admin Role Management
  - [ ] 7.1 Create role audit log table
    - Create audit_log table with columns: id, admin_user_id, target_user_id, old_role, new_role, timestamp
    - Add RLS policy restricting access to admins only
    - Create migration file: `supabase/migrations/YYYYMMDD_create_role_audit_log.sql`
    - _Requirements: 12.5_
  
  - [ ] 7.2 Create RoleManagement component
    - Display user list with current roles
    - Implement role selection dropdown for each user
    - Add confirmation dialog for role changes
    - Show audit log for selected user
    - Restrict component rendering to admin users only
    - Create file: `src/components/admin/RoleManagement.tsx`
    - _Requirements: 12.1, 12.2_
  
  - [ ] 7.3 Create AdminUsersPage
    - Render RoleManagement component
    - Add search and filter functionality
    - Display user count and role distribution
    - Create file: `src/pages/AdminUsersPage.tsx`
    - _Requirements: 12.1_
  
  - [ ] 7.4 Implement role update API with authorization
    - Create Supabase RPC function for role updates
    - Verify caller has admin role before allowing update
    - Insert audit log entry on successful role change
    - Return error if non-admin attempts role change
    - Create migration file: `supabase/migrations/YYYYMMDD_create_role_update_function.sql`
    - _Requirements: 12.2, 12.3, 12.5_
  
  - [ ]* 7.5 Write property test for admin authorization
    - **Property 12: Admin Role Assignment Authorization**
    - **Validates: Requirements 12.2, 12.3**
    - Test that only admins can access role management
    - Test that non-admins receive access denied
    - Minimum 100 iterations
  
  - [ ]* 7.6 Write property test for audit logging
    - **Property 13: Role Assignment Audit Logging**
    - **Validates: Requirements 12.5**
    - Test that all role changes create audit log entries
    - Verify audit log contains all required fields
    - Minimum 100 iterations
  
  - [ ]* 7.7 Write unit tests for role management UI
    - Test user list renders correctly
    - Test role dropdown functionality
    - Test confirmation dialog
    - Test admin-only access control

- [ ] 8. Phase 6: Error Handling & Security
  - [ ] 8.1 Create auth errors utility module
    - Implement error message mapping for common auth errors
    - Add localized messages (pt-BR and en)
    - Map Supabase error codes to user-friendly messages
    - Create file: `src/lib/auth-errors.ts`
    - _Requirements: 14.1, 14.2, 14.3, 14.4_
  
  - [ ] 8.2 Add comprehensive error handling to useAuth hook
    - Catch and map authentication errors
    - Display localized error messages
    - Log errors to console for debugging
    - Handle network errors with retry logic
    - Update file: `src/hooks/useAuth.tsx`
    - _Requirements: 14.1, 14.2, 14.3, 14.4, 14.5_
  
  - [ ] 8.3 Add error handling to all auth components
    - Update LoginPage with error display
    - Update SignupPage with error display
    - Update SocialAuthButtons with OAuth error handling
    - Update OnboardingForm with validation errors
    - _Requirements: 14.1, 14.2, 14.3, 14.4_
  
  - [ ] 8.4 Configure session security settings
    - Document Supabase Dashboard settings for JWT expiry (1 hour)
    - Document refresh token expiry (30 days)
    - Document HTTPS-only and httpOnly cookie settings
    - Create configuration guide: `docs/SUPABASE_AUTH_CONFIG.md`
    - _Requirements: 13.1, 13.2, 13.4, 13.5_
  
  - [ ]* 8.5 Write property test for authentication method parity
    - **Property 10: Authentication Method Parity**
    - **Validates: Requirements 11.4**
    - Test that email/password and OAuth produce identical session behavior
    - Test token refresh works identically for both methods
    - Minimum 100 iterations
  
  - [ ]* 8.6 Write unit tests for error handling
    - Test invalid credentials error message
    - Test OAuth failure error message
    - Test token expiry error message
    - Test network error message
    - Test error logging functionality
  
  - [ ]* 8.7 Write unit test for password strength enforcement
    - **Property 11: Password Strength Enforcement**
    - **Validates: Requirements 11.5**
    - Test that weak passwords are rejected
    - Test minimum 8 characters requirement
    - Test at least one number requirement

- [ ] 9. Checkpoint - Security and error handling verification
  - Test all error scenarios produce correct messages
  - Verify session security settings in Supabase Dashboard
  - Test password strength validation
  - Ensure all tests pass, ask the user if questions arise

- [ ] 10. Phase 7: Migration & Deployment
  - [ ] 10.1 Create migration script for existing users
    - Assign default 'learner' role to users without roles
    - Create profile records for users without profiles
    - Set default l1_language='pt-BR' for new profiles
    - Make script idempotent (safe to re-run)
    - Create migration file: `supabase/migrations/YYYYMMDD_migrate_existing_users.sql`
    - _Requirements: 15.1, 15.2, 15.3, 15.5_
  
  - [ ] 10.2 Create migration verification script
    - Query all users and verify each has a role
    - Query all users and verify each has a profile
    - Report any users missing role or profile
    - Create verification file: `supabase/migrations/verify_migration.sql`
    - _Requirements: 15.4_
  
  - [ ] 10.3 Create rollback script
    - Document steps to revert database changes
    - Create script to remove new columns if needed
    - Document how to restore from backup
    - Create file: `docs/ROLLBACK_PLAN.md`
    - _Requirements: 15.3_
  
  - [ ] 10.4 Create deployment runbook
    - Document pre-deployment backup steps
    - Document migration execution order
    - Document Supabase Dashboard configuration steps
    - Document post-deployment verification steps
    - Document monitoring and alerting setup
    - Create file: `docs/DEPLOYMENT_RUNBOOK.md`
    - _Requirements: 15.1, 15.2, 15.3, 15.4_
  
  - [ ]* 10.5 Test migration on staging database
    - Create test database with sample existing users
    - Run migration script
    - Verify all users have roles and profiles
    - Test idempotency by running migration again
    - Verify no data loss or corruption
    - _Requirements: 15.1, 15.2, 15.3, 15.4, 15.5_

- [ ] 11. Final checkpoint - Production readiness
  - Review all migration scripts
  - Verify all documentation is complete
  - Confirm Supabase Dashboard configuration steps
  - Ensure all tests pass, ask the user if questions arise

## Notes

- Tasks marked with `*` are optional and can be skipped for faster MVP
- Each task references specific requirements for traceability
- Checkpoints ensure incremental validation at phase boundaries
- Property tests validate universal correctness properties using fast-check
- Unit tests validate specific examples, UI behavior, and edge cases
- All database changes use migrations for version control and rollback capability
- OAuth configuration requires Supabase Dashboard access (cannot be automated)
- Migration testing should be performed on staging before production deployment
