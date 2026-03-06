# Cohort Student Management - Implementation & Testing

## What Was Fixed

### Issue: Students Added But Not Showing
**Root Cause**: The `fetchMembers` query had incorrect join syntax for Supabase.

**Fixes Applied**:
1. ✅ Fixed `fetchMembers` query in `useCohorts.tsx` - proper foreign key join syntax
2. ✅ Improved `loadLearners` to only fetch users with 'learner' role
3. ✅ Added better logging to track the add student flow
4. ✅ Added `.select()` to insert query to verify data was inserted
5. ✅ Made `loadCohort` await properly to ensure refresh completes

### Changes Made

#### `src/hooks/useCohorts.tsx`
- Fixed `fetchMembers` query syntax
- Added logging to `addMember` function
- Added `.select()` to verify insert

#### `src/pages/teach/CohortDetailPage.tsx`
- Improved `loadLearners` to filter by role
- Added logging to `handleAddMember`
- Made reload await properly

## How to Test

### 1. Check Browser Console
Open browser console (F12) to see logs:
- "Adding student: [id] to cohort: [id]"
- "Inserting cohort member: {cohortId, studentId}"
- "Insert successful: [data]"
- "Student added successfully, reloading cohort..."

### 2. Test Adding a Student

1. **Go to cohort detail page**
   - Navigate to `/teach`
   - Click on a cohort

2. **Click "Add Student"**
   - Dialog should open
   - Should show list of learners (users with 'learner' role)

3. **Search for a student**
   - Type in search box
   - List should filter

4. **Click on a student**
   - Should see "Student added" toast
   - Dialog should close
   - Student should appear in the list immediately

5. **Check the student list**
   - Student should be visible
   - Should show their name
   - Should show progress data (if available)

### 3. Verify in Database

Check Supabase directly:
```sql
-- See all cohort members
SELECT 
  cm.cohort_id,
  cm.student_id,
  p.full_name,
  c.name as cohort_name
FROM cohort_members cm
JOIN profiles p ON cm.student_id = p.id
JOIN cohorts c ON cm.cohort_id = c.id;
```

## Troubleshooting

### Student Still Not Showing

**Check 1: Was the insert successful?**
- Look in browser console for "Insert successful"
- If you see an error, check the error message

**Check 2: Does the student have a profile?**
```sql
SELECT * FROM profiles WHERE id = 'student-id-here';
```

**Check 3: Is the foreign key correct?**
```sql
-- Check the foreign key name
SELECT
  tc.constraint_name,
  tc.table_name,
  kcu.column_name,
  ccu.table_name AS foreign_table_name,
  ccu.column_name AS foreign_column_name
FROM information_schema.table_constraints AS tc
JOIN information_schema.key_column_usage AS kcu
  ON tc.constraint_name = kcu.constraint_name
JOIN information_schema.constraint_column_usage AS ccu
  ON ccu.constraint_name = tc.constraint_name
WHERE tc.table_name = 'cohort_members';
```

If the foreign key name is different, update the query in `useCohorts.tsx`:
```typescript
.select('student_id, profiles!YOUR_FK_NAME_HERE(full_name, avatar_url)')
```

**Check 4: RLS Policies**
Make sure the policies allow reading:
```sql
-- Test if you can read cohort_members
SELECT * FROM cohort_members LIMIT 5;
```

### Common Errors

**"duplicate key value violates unique constraint"**
- Student is already in the cohort
- Check the database to confirm

**"insert or update on table violates foreign key constraint"**
- Student ID doesn't exist in profiles table
- Check: `SELECT * FROM profiles WHERE id = 'student-id';`

**"permission denied for table cohort_members"**
- RLS policy issue
- Run the fix migration again

## Next Steps

Once students are showing correctly:

1. **Test removing students**
   - Click trash icon next to student
   - Should remove and refresh

2. **Test progress display**
   - Add students who have used the app
   - Should show streak, words learned, lessons completed

3. **Test assignments**
   - Go to Assignments tab
   - Assign a grammar chapter
   - Should appear in list

4. **Test SRS trigger**
   - Go to SRS Trigger tab
   - Search for words
   - Select words
   - Click "Inject into SRS"
   - Should add to all students' SRS queues

## Current Features

✅ Create cohorts
✅ List cohorts
✅ Delete cohorts
✅ View cohort details
✅ Add students to cohorts (FIXED)
✅ Remove students from cohorts
✅ View student progress
✅ Assign grammar chapters
✅ Inject vocabulary into SRS

## Known Limitations

- Progress data may show 0 if student hasn't used the app
- SRS injection requires students to be in cohort first
- Only shows users with 'learner' role in add student dialog

## Production Checklist

Before deploying:
- [ ] Test adding students locally
- [ ] Verify students appear in list
- [ ] Test removing students
- [ ] Check browser console for errors
- [ ] Verify database has correct data
- [ ] Test with multiple students
- [ ] Test with students who have progress data
