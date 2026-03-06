# Cohort Management System - Deployment Checklist

## Pre-Deployment

### 1. Database Migration
- [ ] Review migration file: `supabase/migrations/20260307000000_create_cohort_management.sql`
- [ ] Ensure existing migrations are applied (progress tracking, SRS system)
- [ ] Backup database before applying migration

### 2. Run Migration

**Option A: Via Supabase CLI**
```bash
supabase db push
```

**Option B: Via Lovable/Supabase Dashboard**
1. Open Supabase SQL Editor
2. Copy contents of `20260307000000_create_cohort_management.sql`
3. Execute the SQL
4. Verify no errors

### 3. Verify Database

Run these queries in SQL Editor:

```sql
-- Check tables exist
SELECT table_name FROM information_schema.tables 
WHERE table_schema = 'public' 
AND table_name IN ('cohorts', 'cohort_members', 'assignments');

-- Check functions exist
SELECT routine_name FROM information_schema.routines 
WHERE routine_schema = 'public' 
AND routine_name IN ('is_teacher', 'get_teacher_students', 'get_cohort_progress', 'teacher_add_words_to_srs', 'get_student_assignments');

-- Check RLS is enabled
SELECT tablename, rowsecurity FROM pg_tables 
WHERE schemaname = 'public' 
AND tablename IN ('cohorts', 'cohort_members', 'assignments');
```

All queries should return results.

## Frontend Deployment

### 4. Install Dependencies
```bash
npm install
# or
bun install
```

### 5. Generate Types (Optional but Recommended)
```bash
supabase gen types typescript --local > src/integrations/supabase/types.ts
```

This will update TypeScript types to include new tables. If you skip this, the app will still work but you'll see TypeScript warnings.

### 6. Build Application
```bash
npm run build
# or
bun run build
```

### 7. Deploy
Deploy via your hosting platform (Lovable, Vercel, Netlify, etc.)

## Post-Deployment Testing

### 8. Create Test Teacher

**Option A: Via SQL**
```sql
-- Get user ID from auth.users
SELECT id, email FROM auth.users WHERE email = 'teacher@example.com';

-- Add teacher role
INSERT INTO public.user_roles (user_id, role)
VALUES ('user-id-here', 'teacher');
```

**Option B: Via Admin UI**
1. Go to `/admin/users`
2. Find user
3. Assign 'teacher' role

### 9. Test Cohort Creation

1. Log in as teacher
2. Navigate to `/teach/dashboard`
3. Click "New Cohort"
4. Enter name: "Test Cohort"
5. Click "Create Cohort"
6. Verify cohort appears in list

### 10. Test Student Addition

1. Create a test student user (or use existing)
2. Ensure student has 'learner' role
3. In cohort detail page, click "Add Student"
4. Select student from dropdown
5. Click "Add Student"
6. Verify student appears in Progress tab

### 11. Test Assignment Creation

1. In cohort detail page, go to "Assignments" tab
2. Click "Assign Grammar"
3. Select a grammar chapter
4. Optionally set due date
5. Click "Assign"
6. Verify assignment appears in list

### 12. Test Live Class SRS

1. In cohort detail page, go to "Live Class" tab
2. Search for a word (e.g., "hello")
3. Select word from results
4. Click "Add to SRS"
5. Log in as student
6. Check dashboard - word should appear in review queue

### 13. Test Student View

1. Log in as student
2. Navigate to `/dashboard`
3. Verify no errors
4. Check if assignments appear (future feature)

## Troubleshooting

### Migration Fails

**Error: "relation already exists"**
- Tables already created, migration already ran
- Check if tables exist: `SELECT * FROM cohorts LIMIT 1;`

**Error: "function already exists"**
- Functions already created
- Safe to ignore or drop and recreate

**Error: "permission denied"**
- Check database user has proper permissions
- Verify you're connected to correct database

### Cohorts Not Loading

**Check 1: User has teacher role**
```sql
SELECT * FROM user_roles WHERE user_id = 'your-user-id';
```

**Check 2: RLS policies are working**
```sql
-- Should return true
SELECT is_teacher('your-teacher-user-id');
```

**Check 3: Browser console**
- Open DevTools → Console
- Look for errors
- Check Network tab for failed requests

### Cannot Add Student

**Check 1: Student exists**
```sql
SELECT id, email FROM auth.users WHERE email = 'student@example.com';
```

**Check 2: Student not already in cohort**
```sql
SELECT * FROM cohort_members 
WHERE cohort_id = 'cohort-id' AND student_id = 'student-id';
```

**Check 3: Teacher owns cohort**
```sql
SELECT * FROM cohorts WHERE id = 'cohort-id' AND teacher_id = 'teacher-id';
```

### Words Not Added to SRS

**Check 1: Word exists in lexicon**
```sql
SELECT * FROM lexicon_entries WHERE id = 'word-id';
```

**Check 2: Function works**
```sql
SELECT * FROM teacher_add_words_to_srs(
  ARRAY['student-id']::uuid[],
  ARRAY['word-id']::uuid[],
  'teacher-id'::uuid
);
```

**Check 3: SRS card created**
```sql
SELECT * FROM srs_cards 
WHERE user_id = 'student-id' AND word_id = 'word-id';
```

## Rollback Plan

If something goes wrong:

### 1. Rollback Database
```sql
-- Drop tables (in reverse order due to foreign keys)
DROP TABLE IF EXISTS public.assignments CASCADE;
DROP TABLE IF EXISTS public.cohort_members CASCADE;
DROP TABLE IF EXISTS public.cohorts CASCADE;

-- Drop functions
DROP FUNCTION IF EXISTS public.is_teacher(uuid);
DROP FUNCTION IF EXISTS public.get_teacher_students(uuid);
DROP FUNCTION IF EXISTS public.get_cohort_progress(uuid);
DROP FUNCTION IF EXISTS public.teacher_add_words_to_srs(uuid[], uuid[], uuid);
DROP FUNCTION IF EXISTS public.get_student_assignments(uuid);
DROP FUNCTION IF EXISTS public.set_assignment_completed_at();

-- Drop RLS policies on SRS and progress tables
DROP POLICY IF EXISTS "Teachers can view students SRS cards" ON public.srs_cards;
DROP POLICY IF EXISTS "Teachers can create SRS cards for students" ON public.srs_cards;
DROP POLICY IF EXISTS "Teachers view students progress events" ON public.progress_events;
DROP POLICY IF EXISTS "Teachers view students learner progress" ON public.learner_progress;
```

### 2. Rollback Frontend
```bash
git revert HEAD
git push
```

Or redeploy previous version via hosting platform.

## Success Criteria

- [ ] Migration runs without errors
- [ ] All tables and functions exist
- [ ] RLS policies are enabled
- [ ] Teacher can create cohorts
- [ ] Teacher can add students to cohorts
- [ ] Teacher can view student progress
- [ ] Teacher can create assignments
- [ ] Teacher can add words to student SRS
- [ ] Students can view their cohorts (future)
- [ ] No errors in browser console
- [ ] No errors in Supabase logs

## Next Steps After Deployment

1. **Create Teacher Accounts**
   - Assign teacher role to appropriate users
   - Provide training on cohort management

2. **Populate Content**
   - Ensure grammar chapters are published
   - Verify lexicon entries exist
   - Test assignment workflow

3. **Monitor Usage**
   - Check Supabase logs for errors
   - Monitor database performance
   - Gather teacher feedback

4. **Plan Enhancements**
   - Pacing calendars
   - Bulk operations
   - Student analytics
   - Assignment templates

## Support

For issues or questions:
- Check [COHORT_MANAGEMENT_GUIDE.md](./COHORT_MANAGEMENT_GUIDE.md)
- Review [PROJECT_STATUS.md](./PROJECT_STATUS.md)
- Check Supabase logs
- Review browser console errors
