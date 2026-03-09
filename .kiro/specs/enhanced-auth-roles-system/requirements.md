# Requirements Document

## Introduction

This document specifies the requirements for upgrading the Grind English authentication and roles system from a basic MVP implementation to an enterprise-ready solution. The system serves Brazilian corporate professionals (aged 25-45) learning English, requiring robust security, frictionless authentication, and intelligent user onboarding that connects to personalized learning journeys.

The upgrade transforms the current frontend-only role checking into database-enforced access control, adds social login options to reduce friction, implements intelligent session management, and creates automated onboarding workflows that connect authentication to the pedagogical system.

## Glossary

- **Auth_System**: The Supabase authentication service managing user identity and sessions
- **User_Roles_Table**: Database table linking Supabase auth.uid() to application roles
- **JWT_Claims**: JSON Web Token payload containing user identity and role information
- **RLS_Policy**: Row Level Security policy enforcing database-level access control
- **Protected_Resource**: Database table or API endpoint requiring authenticated access
- **Social_Provider**: OAuth authentication provider (Google, LinkedIn)
- **Auth_Hook**: React hook (useAuth.tsx) managing authentication state in the frontend
- **Protected_Route**: React component enforcing authentication requirements for routes
- **Session_Token**: JWT token representing an authenticated user session
- **Token_Refresh**: Process of obtaining a new session token before expiration
- **Pre_Login_Destination**: URL the user attempted to access before authentication
- **User_Profile**: Database record in public.profiles containing user metadata
- **L1_Language**: User's native language (default: pt-BR for Brazilian Portuguese)
- **Onboarding_Trigger**: Database trigger creating profile on user signup
- **Role**: User permission level (Learner, Teacher, Admin, Author)
- **Dashboard_Route**: Role-specific landing page after authentication

## Requirements

### Requirement 1: Database-Level Role Management

**User Story:** As a system administrator, I want user roles stored and managed at the database level, so that role-based access control cannot be bypassed by frontend manipulation.

#### Acceptance Criteria

1. THE Auth_System SHALL create a User_Roles_Table linking auth.uid() to Role values
2. WHEN a user authenticates, THE Auth_System SHALL inject Role information into JWT_Claims
3. THE User_Roles_Table SHALL enforce exactly one Role per user through database constraints
4. WHEN a Role is assigned to a user, THE Auth_System SHALL include the Role in the next Session_Token
5. THE User_Roles_Table SHALL support Role values: Learner, Teacher, Admin, and Author

### Requirement 2: Row Level Security Enforcement

**User Story:** As a security engineer, I want database access controlled by RLS policies, so that users can only access data appropriate for their Role.

#### Acceptance Criteria

1. FOR ALL Protected_Resources, THE Auth_System SHALL create RLS_Policy rules based on JWT_Claims
2. WHEN a Learner queries progress_tracking, THE RLS_Policy SHALL return only records where user_id matches auth.uid()
3. WHEN a Teacher queries lessons, THE RLS_Policy SHALL return lessons assigned to that Teacher
4. WHEN an Admin queries any Protected_Resource, THE RLS_Policy SHALL grant full access
5. IF a user attempts to access data outside their Role permissions, THEN THE RLS_Policy SHALL deny the query and return zero rows
6. THE Auth_System SHALL enforce RLS_Policy rules at the database level before returning query results

### Requirement 3: Google OAuth Integration

**User Story:** As a busy corporate professional, I want to sign in with my Google account, so that I can access the platform without creating another password.

#### Acceptance Criteria

1. THE Auth_System SHALL enable Google as a Social_Provider in Supabase configuration
2. WHEN a user clicks the Google sign-in button, THE Auth_System SHALL initiate supabase.auth.signInWithOAuth() with provider 'google'
3. WHEN Google authentication succeeds, THE Auth_System SHALL create or link a user account with the Google email
4. THE Auth_System SHALL display a Google sign-in button on both login and signup pages
5. WHEN a user signs in with Google for the first time, THE Auth_System SHALL trigger the Onboarding_Trigger

### Requirement 4: LinkedIn OAuth Integration

**User Story:** As a corporate professional, I want to sign in with my LinkedIn account, so that I can quickly access the platform using my professional identity.

#### Acceptance Criteria

1. THE Auth_System SHALL enable LinkedIn as a Social_Provider in Supabase configuration
2. WHEN a user clicks the LinkedIn sign-in button, THE Auth_System SHALL initiate supabase.auth.signInWithOAuth() with provider 'linkedin'
3. WHEN LinkedIn authentication succeeds, THE Auth_System SHALL create or link a user account with the LinkedIn email
4. THE Auth_System SHALL display a LinkedIn sign-in button on both login and signup pages
5. WHEN a user signs in with LinkedIn for the first time, THE Auth_System SHALL trigger the Onboarding_Trigger

### Requirement 5: Silent Token Refresh

**User Story:** As a learner, I want my session to remain active while I'm using the platform, so that I don't lose my progress or get unexpectedly logged out.

#### Acceptance Criteria

1. THE Auth_Hook SHALL subscribe to supabase.auth.onAuthStateChange() on component mount
2. WHEN a Session_Token approaches expiration, THE Auth_System SHALL automatically request a Token_Refresh
3. WHEN Token_Refresh succeeds, THE Auth_Hook SHALL update the session state without user interaction
4. WHEN Token_Refresh fails due to expired refresh token, THE Auth_Hook SHALL redirect the user to the login page
5. THE Auth_Hook SHALL maintain authentication state across browser tab refreshes

### Requirement 6: Pre-Login Destination Tracking

**User Story:** As a user, I want to be redirected to my intended page after logging in, so that I don't have to navigate back to where I was trying to go.

#### Acceptance Criteria

1. WHEN an unauthenticated user attempts to access a Protected_Route, THE Protected_Route SHALL store the requested URL as Pre_Login_Destination
2. WHEN authentication completes successfully, THE Auth_System SHALL redirect the user to the Pre_Login_Destination
3. IF no Pre_Login_Destination exists, THEN THE Auth_System SHALL redirect based on the user's Role
4. WHEN the user navigates to Pre_Login_Destination, THE Protected_Route SHALL clear the stored destination
5. THE Protected_Route SHALL store Pre_Login_Destination in sessionStorage to persist across page reloads

### Requirement 7: Role-Based Dashboard Routing

**User Story:** As a user, I want to land on the appropriate dashboard for my role after logging in, so that I immediately see relevant content and actions.

#### Acceptance Criteria

1. WHEN a Learner completes authentication, THE Auth_System SHALL redirect to the DashboardPage route
2. WHEN a Teacher completes authentication, THE Auth_System SHALL redirect to the TeachDashboardPage route
3. WHEN an Admin completes authentication, THE Auth_System SHALL redirect to the CourseBuilderPage route
4. WHEN an Author completes authentication, THE Auth_System SHALL redirect to the CourseBuilderPage route
5. IF a Pre_Login_Destination exists, THEN THE Auth_System SHALL redirect to Pre_Login_Destination instead of the Dashboard_Route

### Requirement 8: Automatic Profile Creation

**User Story:** As a new user, I want my profile automatically created when I sign up, so that I can immediately start using the platform without manual setup steps.

#### Acceptance Criteria

1. THE Auth_System SHALL create an Onboarding_Trigger that executes when a new user record is inserted into auth.users
2. WHEN the Onboarding_Trigger executes, THE Auth_System SHALL insert a User_Profile record in public.profiles with the user's auth.uid()
3. THE User_Profile SHALL include default values: L1_Language set to 'pt-BR', created_at timestamp, and user email
4. IF the Onboarding_Trigger fails, THEN THE Auth_System SHALL log the error and allow authentication to proceed
5. THE Onboarding_Trigger SHALL execute within the same database transaction as user creation

### Requirement 9: Onboarding Data Capture

**User Story:** As a learner, I want to provide my native language and professional goals during signup, so that the platform can personalize my learning experience.

#### Acceptance Criteria

1. THE Auth_System SHALL display an onboarding form after first-time authentication
2. THE onboarding form SHALL capture L1_Language with pt-BR as the default selection
3. THE onboarding form SHALL capture professional goals as free-text input
4. WHEN the user submits the onboarding form, THE Auth_System SHALL update the User_Profile with the captured data
5. WHEN onboarding data is saved, THE Auth_System SHALL redirect the user to their Dashboard_Route
6. IF the user skips onboarding, THEN THE Auth_System SHALL use default values and allow access to the platform

### Requirement 10: JWT Claims Function

**User Story:** As a backend developer, I want user roles automatically included in JWT tokens, so that role-based authorization works seamlessly across the application.

#### Acceptance Criteria

1. THE Auth_System SHALL create a Postgres function that queries User_Roles_Table for the authenticated user's Role
2. WHEN a user authenticates, THE Auth_System SHALL execute the Postgres function to retrieve the user's Role
3. THE Postgres function SHALL return the Role as a custom JWT claim named 'user_role'
4. WHEN the Session_Token is generated, THE Auth_System SHALL include the 'user_role' claim in the JWT payload
5. THE Postgres function SHALL return NULL if no Role is assigned, allowing the application to handle unassigned users

### Requirement 11: Email/Password Authentication Preservation

**User Story:** As a user without social media accounts, I want to continue using email and password authentication, so that I can access the platform using traditional credentials.

#### Acceptance Criteria

1. THE Auth_System SHALL maintain support for email and password authentication alongside social login options
2. WHEN a user submits email and password credentials, THE Auth_System SHALL validate them using Supabase Auth
3. THE Auth_System SHALL display email/password input fields on both login and signup pages
4. WHEN email/password authentication succeeds, THE Auth_System SHALL apply the same session management and routing as social login
5. THE Auth_System SHALL enforce password strength requirements: minimum 8 characters, at least one number

### Requirement 12: Role Assignment Interface

**User Story:** As an administrator, I want to assign roles to users through a secure interface, so that I can manage user permissions without direct database access.

#### Acceptance Criteria

1. THE Auth_System SHALL provide an admin interface for viewing all users and their assigned Roles
2. WHEN an Admin selects a user and a Role, THE Auth_System SHALL update the User_Roles_Table
3. THE Auth_System SHALL restrict access to the role assignment interface to users with Admin Role
4. WHEN a Role is changed, THE Auth_System SHALL require the user to re-authenticate to receive updated JWT_Claims
5. THE Auth_System SHALL log all Role assignment changes with timestamp and admin user ID

### Requirement 13: Session Security

**User Story:** As a security engineer, I want sessions to be secure and properly invalidated, so that unauthorized access is prevented.

#### Acceptance Criteria

1. THE Auth_System SHALL set Session_Token expiration to 1 hour
2. THE Auth_System SHALL set refresh token expiration to 30 days
3. WHEN a user logs out, THE Auth_System SHALL invalidate the Session_Token and refresh token
4. THE Auth_System SHALL transmit Session_Token only over HTTPS connections
5. THE Auth_System SHALL store Session_Token in httpOnly cookies to prevent XSS attacks
6. WHEN a user changes their password, THE Auth_System SHALL invalidate all existing sessions for that user

### Requirement 14: Error Handling and User Feedback

**User Story:** As a user, I want clear error messages when authentication fails, so that I understand what went wrong and how to fix it.

#### Acceptance Criteria

1. WHEN authentication fails due to invalid credentials, THE Auth_System SHALL display "Email ou senha incorretos" (Invalid email or password)
2. WHEN Social_Provider authentication fails, THE Auth_System SHALL display the specific error reason
3. WHEN Token_Refresh fails, THE Auth_System SHALL display "Sua sessão expirou. Por favor, faça login novamente" (Your session expired. Please log in again)
4. WHEN network errors occur during authentication, THE Auth_System SHALL display "Erro de conexão. Verifique sua internet" (Connection error. Check your internet)
5. THE Auth_System SHALL log all authentication errors to the console for debugging purposes

### Requirement 15: Migration Path for Existing Users

**User Story:** As an existing user, I want my account to work seamlessly after the upgrade, so that I don't lose access or have to recreate my account.

#### Acceptance Criteria

1. THE Auth_System SHALL create a migration script that assigns default Learner Role to all existing users without roles
2. THE migration script SHALL create User_Profile records for existing users who don't have profiles
3. THE migration script SHALL preserve all existing authentication credentials and session data
4. WHEN the migration completes, THE Auth_System SHALL verify that all users have both a Role and a User_Profile
5. THE migration script SHALL execute idempotently, allowing safe re-execution if needed
