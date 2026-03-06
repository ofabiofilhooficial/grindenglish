# Cohort Management System Guide

## Overview

The Cohort Management System allows teachers to group students, track their progress, assign content, and manually trigger vocabulary into students' SRS queues based on live class performance.

## Database Schema

### Tables

#### `cohorts`
Groups of students managed by a teacher.
- `id` (UUID): Primary key
- `name` (TEXT): Cohort name (e.g., "João Private", "Maria & Ana B1")
- `description` (TEXT): Optional description
- `teacher_id` (UUID): Foreign key to auth.users
- `is_active` (BOOLEAN): Active status
- `created_at`, `updated_at` (TIMESTAMPTZ): Timestamps

#### `cohort_members`
Junction table linking students to cohorts.
- `id` (UUID): Primary key
- `cohort_id` (UUID): Foreign key to cohorts
- `student_id` (UUID): Foreign key to auth.users
- `joined_at` (TIMESTAMPTZ): When student joined
- Unique constraint on (cohort_id, student_id)

#### `assignments`
Content assigned to students or cohorts.
- `id` (UUID): Primary key
- `cohort_id` (UUID): Optional, for cohort-wide assignments
- `student_id` (UUID): Optional, for individual assignments
- `teacher_id` (UUID): Foreign key to auth.users
- `content_type` (TEXT): 'grammar', 'vocabulary', 'lesson', 'unit'
- `content_id` (UUID): References the content item
- `status` (TEXT): 'pending', 'in_progress', 'completed'
- `due_date` (TIMESTAMPTZ): Optional due date
- `assigned_at`, `completed_at` (TIMESTAMPTZ): Timestamps
- `notes` (TEXT): Optional notes for students
- Check constraint: Either cohort_id OR student_id must be set

### Helper Functions

#### `is_teacher(_user_id UUID) → BOOLEAN`
Checks if a user has the teacher role.

#### `get_teacher_students(_teacher_id UUID)`
Returns all students across a teacher's cohorts with:
- student_id, full_name, avatar_url, cohort_count

#### `get_cohort_progress(_cohort_id UUID)`
Returns progress summary for all students in a cohort:
- student_id, full_name
- current_streak, words_learned, lessons_completed
- last_activity_date
- pending_assignments, completed_assignments

#### `teacher_add_words_to_srs(_student_ids UUID[], _word_ids UUID[], _teacher_id UUID)`
Bulk adds vocabulary words to students' SRS queues. Used for live class vocabulary injection.

#### `get_student_assignments(_student_id UUID)`
Returns all assignments for a student (both individual and cohort-wide).

### Row Level Security (RLS)

All tables have comprehensive RLS policies:

**Teachers can:**
- View/create/update/delete their own cohorts
- View/add/remove members from their cohorts
- View/create/update/delete assignments they created
- View their students' SRS cards and progress

**Students can:**
- View cohorts they belong to
- View their own cohort memberships
- View their assignments
- Update assignment status (to 'in_progress' or 'completed')

**Admins can:**
- View all cohorts, members, and assignments

## Frontend Implementation

### Custom Hooks

#### `useCohorts()`
Manages cohort operations.

**State:**
- `cohorts`: Array of cohorts with member counts
- `loading`: Loading state

**Methods:**
- `fetchCohorts()`: Reload cohorts
- `createCohort(name, description)`: Create new cohort
- `updateCohort(cohortId, updates)`: Update cohort details
- `deleteCohort(cohortId)`: Delete cohort
- `getTeacherStudents()`: Get all students across cohorts
- `getCohortMembers(cohortId)`: Get members of a cohort
- `addStudentToCohort(cohortId, studentId)`: Add student
- `removeStudentFromCohort(cohortId, studentId)`: Remove student
- `getCohortProgress(cohortId)`: Get progress summary

#### `useAssignments()`
Manages assignment operations.

**State:**
- `assignments`: Array of assignments
- `loading`: Loading state

**Methods:**
- `fetchAssignments()`: Reload assignments
- `createAssignment(contentType, contentId, options)`: Create assignment
- `updateAssignment(assignmentId, updates)`: Update assignment
- `deleteAssignment(assignmentId)`: Delete assignment
- `getCohortAssignments(cohortId)`: Get cohort's assignments
- `getStudentAssignments(studentId)`: Get student's assignments
- `addWordsToStudentSRS(studentIds, wordIds)`: Bulk add words to SRS

### Pages

#### TeachDashboardPage (`/teach/dashboard`)
Overview of all cohorts.

**Features:**
- List all active cohorts with member counts
- Create new cohorts
- Navigate to cohort details
- View cohort status and creation date

#### CohortDetailPage (`/teach/cohorts/:cohortId`)
Detailed view of a single cohort with three tabs.

**Progress Tab:**
- View all students in the cohort
- See each student's:
  - Current streak
  - Words learned
  - Lessons completed
  - Last activity date
  - Pending/completed assignments
- Add students to cohort
- Remove students from cohort

**Assignments Tab:**
- View all assignments for the cohort
- Create new grammar chapter assignments
- Set due dates and notes
- Track assignment status
- Delete assignments

**Live Class Tab:**
- Search vocabulary from lexicon
- Select multiple words
- Bulk add selected words to all students' SRS queues
- Used during/after live classes to trigger vocabulary review

## Usage Workflows

### Creating a Cohort

1. Navigate to `/teach/dashboard`
2. Click "New Cohort"
3. Enter cohort name (e.g., "João Private")
4. Optionally add description
5. Click "Create Cohort"

### Adding Students

1. Open cohort detail page
2. Go to "Progress" tab
3. Click "Add Student"
4. Select student from dropdown
5. Click "Add Student"

### Assigning Grammar

1. Open cohort detail page
2. Go to "Assignments" tab
3. Click "Assign Grammar"
4. Select grammar chapter
5. Optionally set due date and notes
6. Click "Assign"

### Live Class Vocabulary Injection

1. Open cohort detail page
2. Go to "Live Class" tab
3. Search for vocabulary words covered in class
4. Select relevant words from search results
5. Click "Add to SRS"
6. All students in the cohort will have these words added to their SRS queue

## Integration with Existing Systems

### Progress Tracking
- Cohort progress view uses existing `learner_progress` table
- Teachers can see real-time streak, words learned, and lessons completed
- Leverages existing progress tracking infrastructure

### SRS System
- Live class feature uses existing `srs_cards` table
- `teacher_add_words_to_srs()` function calls `get_or_create_srs_card()`
- Words appear in students' daily review queue
- Follows same SM-2 algorithm as student-initiated reviews

### Authentication & Authorization
- Uses existing `user_roles` table
- Teachers identified by 'teacher' role
- RLS policies ensure data isolation
- Admins have full visibility

## Deployment Checklist

### Database Migration

1. **Run Migration:**
   ```bash
   # Via Supabase CLI
   supabase db push
   
   # Or via Lovable/Supabase Dashboard
   # Copy contents of 20260307000000_create_cohort_management.sql
   # Run in SQL Editor
   ```

2. **Verify Tables:**
   ```sql
   SELECT * FROM cohorts LIMIT 1;
   SELECT * FROM cohort_members LIMIT 1;
   SELECT * FROM assignments LIMIT 1;
   ```

3. **Test Functions:**
   ```sql
   SELECT is_teacher('your-teacher-user-id');
   SELECT * FROM get_teacher_students('your-teacher-user-id');
   ```

### Frontend Deployment

1. **Install Dependencies:**
   ```bash
   npm install
   # or
   bun install
   ```

2. **Type Generation:**
   ```bash
   # Generate updated Supabase types
   supabase gen types typescript --local > src/integrations/supabase/types.ts
   ```

3. **Build & Deploy:**
   ```bash
   npm run build
   # Deploy via Lovable or your hosting platform
   ```

### Testing

1. **Create Test Teacher:**
   - Sign up new user
   - Assign 'teacher' role in `user_roles` table

2. **Create Test Cohort:**
   - Log in as teacher
   - Navigate to `/teach/dashboard`
   - Create cohort

3. **Add Test Student:**
   - Create student user
   - Add to cohort via UI

4. **Test Assignment:**
   - Assign grammar chapter
   - Log in as student
   - Verify assignment appears

5. **Test Live Class:**
   - Search vocabulary
   - Add words to SRS
   - Log in as student
   - Verify words in review queue

## Troubleshooting

### "Cohorts not loading"
- Check user has 'teacher' role in `user_roles` table
- Verify RLS policies are enabled
- Check browser console for errors

### "Cannot add student to cohort"
- Verify student user exists
- Check student is not already in cohort
- Verify teacher owns the cohort

### "Assignment not appearing for student"
- Check assignment status is not 'completed'
- Verify student is in the cohort (for cohort assignments)
- Check RLS policies allow student to view

### "Words not added to SRS"
- Verify word IDs are valid (exist in `lexicon_entries`)
- Check teacher has access to students
- Verify `teacher_add_words_to_srs()` function exists

## Future Enhancements

- **Pacing Calendars:** Schedule content delivery over time
- **Bulk Operations:** Assign multiple chapters at once
- **Student Analytics:** Detailed per-student performance graphs
- **Assignment Templates:** Save common assignment patterns
- **Cohort Cloning:** Duplicate cohort structure for new groups
- **Parent/Guardian Access:** View student progress
- **Automated Reminders:** Email/notification for due assignments

## Related Documentation

- [Progress Tracking Guide](./PROGRESS_TRACKING_GUIDE.md)
- [SRS System Guide](./SRS_SYSTEM_GUIDE.md)
- [Project Status](./PROJECT_STATUS.md)
