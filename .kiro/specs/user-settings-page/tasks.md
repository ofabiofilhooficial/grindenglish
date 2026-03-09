# Implementation Plan: User Settings Page

## Overview

This implementation plan creates a personal settings page at `/settings` where authenticated users can update their profile information, starting with their full name. The implementation follows a layered architecture: service layer for data operations, component layer for UI, and route configuration for navigation. The feature includes comprehensive validation, error handling, and security through existing RLS policies.

## Tasks

- [ ] 1. Implement profile service layer
  - [x] 1.1 Create profileService with updateProfile and getProfile methods
    - Create `src/services/profileService.ts`
    - Implement `updateProfile(userId, data)` method that updates the `full_name` column in the profiles table
    - Implement `getProfile(userId)` method that fetches profile data
    - Add error handling and transformation for RLS violations, network errors, and database errors
    - Define TypeScript interfaces: `ProfileUpdateData`, `ProfileServiceError`
    - _Requirements: 3.2, 6.1, 6.2, 6.3_
  
  - [ ]* 1.2 Write property test for profile update round-trip
    - **Property 4: Profile Update Round-Trip**
    - **Validates: Requirements 3.2, 3.4, 6.4**
    - Generate random user and valid full name string (1-255 chars)
    - Test that update persists to database, auth context reflects change, and updated_at timestamp changes
  
  - [ ]* 1.3 Write property test for authorization enforcement
    - **Property 9: Other Profile Update Rejection**
    - **Validates: Requirements 6.2**
    - Generate two random users (user A and user B)
    - Test that user A cannot update user B's profile via service
    - Assert authorization error is returned

- [ ] 2. Implement ProfileForm component
  - [x] 2.1 Create ProfileForm component with form state management
    - Create `src/components/settings/ProfileForm.tsx`
    - Set up react-hook-form with zod schema validation
    - Define form schema: fullName (max 255 chars, trimmed), email (read-only)
    - Implement form fields for full name (editable) and email (read-only display)
    - Add save button with loading state and disabled state when no changes
    - Implement onDirtyChange callback to notify parent of unsaved changes
    - _Requirements: 2.1, 2.3, 3.1, 3.6, 4.1, 4.2, 4.3, 4.5_
  
  - [x] 2.2 Add form submission and feedback handling
    - Implement onSubmit handler that calls profileService.updateProfile
    - Add success toast notification on successful update
    - Add error toast notification on failed update with descriptive message
    - Trim whitespace from full name before submission
    - Reset form dirty state after successful submission
    - _Requirements: 3.2, 3.3, 3.5, 4.5_
  
  - [ ]* 2.3 Write property test for full name length validation
    - **Property 5: Full Name Length Validation**
    - **Validates: Requirements 3.6**
    - Generate random strings longer than 255 characters
    - Test that form validation rejects submission and shows error
  
  - [ ]* 2.4 Write property test for whitespace trimming
    - **Property 7: Whitespace Trimming**
    - **Validates: Requirements 4.5**
    - Generate random valid full names with leading/trailing whitespace
    - Test that submitted value has whitespace trimmed
  
  - [ ]* 2.5 Write unit tests for ProfileForm
    - Test form displays current profile data
    - Test save button disabled when no changes made
    - Test save button shows loading state during submission
    - Test success notification displays after update
    - Test error notification displays on failure
    - Test empty input field when full name is null/empty

- [x] 3. Checkpoint - Ensure service and form components work correctly
  - Ensure all tests pass, ask the user if questions arise.

- [ ] 4. Implement SettingsPage component
  - [x] 4.1 Create SettingsPage with layout and state management
    - Create `src/pages/SettingsPage.tsx`
    - Use AppLayout component with title "Settings" and subtitle "Manage your personal information"
    - Get current user and profile from useAuth hook
    - Implement hasUnsavedChanges state tracking
    - Display loading indicator while profile data loads
    - Render ProfileForm with current profile data
    - _Requirements: 1.1, 2.1, 2.2, 5.1, 5.2, 5.3_
  
  - [x] 4.2 Add navigation guard for unsaved changes
    - Implement beforeunload event listener for browser navigation
    - Add React Router navigation guard using useBlocker or useEffect
    - Display confirmation dialog when user attempts to navigate with unsaved changes
    - _Requirements: 4.4_
  
  - [x] 4.3 Implement profile refresh after update
    - Call refreshProfile method from AuthContext after successful form submission
    - Ensure updated profile data is reflected throughout the application
    - _Requirements: 3.4_
  
  - [ ]* 4.4 Write property test for profile data display
    - **Property 2: Profile Data Display**
    - **Validates: Requirements 2.1**
    - Generate random user with random full name (including null, empty, valid strings)
    - Test that settings page displays the correct full name in form
  
  - [ ]* 4.5 Write property test for email read-only display
    - **Property 3: Email Read-Only Display**
    - **Validates: Requirements 2.4**
    - Generate random user with random email
    - Test that email field is read-only and displays correct email
  
  - [ ]* 4.6 Write unit tests for SettingsPage
    - Test page uses AppLayout with correct title and subtitle
    - Test loading indicator displays while profile loads
    - Test confirmation dialog shows when navigating with unsaved changes
    - Test ProfileForm receives correct profile data

- [ ] 5. Enhance AuthContext with profile refresh
  - [x] 5.1 Add refreshProfile method to AuthContext
    - Modify `src/hooks/useAuth.tsx`
    - Add `refreshProfile` method to AuthContextType interface
    - Implement refreshProfile that calls fetchUserData with current user ID
    - Export refreshProfile from useAuth hook
    - _Requirements: 3.4_
  
  - [ ]* 5.2 Write unit tests for refreshProfile
    - Test refreshProfile fetches updated profile data
    - Test refreshProfile handles errors gracefully

- [ ] 6. Configure settings route
  - [x] 6.1 Add /settings route to application
    - Modify `src/App.tsx`
    - Import SettingsPage component
    - Add route: `/settings` wrapped with ProtectedRoute
    - Ensure route is accessible to all authenticated users (no role restrictions)
    - _Requirements: 1.1, 1.2, 1.3, 1.4_
  
  - [ ]* 6.2 Write property test for role-based access
    - **Property 1: Role-Based Access**
    - **Validates: Requirements 1.3**
    - Generate random user with random role (learner, teacher, curriculum_designer, admin)
    - Test that user can access `/settings` route
    - Assert page renders successfully
  
  - [ ]* 6.3 Write unit tests for settings route
    - Test `/settings` route renders SettingsPage component
    - Test unauthenticated users are redirected to `/login`
    - Test settings link in profile dropdown navigates to `/settings`

- [x] 7. Final checkpoint - End-to-end validation
  - Ensure all tests pass, ask the user if questions arise.

## Notes

- Tasks marked with `*` are optional and can be skipped for faster MVP
- Each task references specific requirements for traceability
- The design uses TypeScript, so all implementation will be in TypeScript/React
- No new database migrations needed - existing profiles table and RLS policies are sufficient
- Property tests use fast-check library with minimum 100 iterations per test
- Unit tests use Vitest and React Testing Library
- All form validation is client-side using zod schema
- Error handling covers authentication, authorization, validation, network, and database errors
