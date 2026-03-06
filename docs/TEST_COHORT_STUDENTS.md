# Test Cohort Students - Quick Guide

## What Was Fixed

### Issue 1: Students Not Showing
**Problem**: Foreign key join syntax was database-specific
**Solution**: Changed to two-step query (get IDs, then get profiles)

### Issue 2: Duplicate Key Error
**Problem**: Students already in cohort were showing in "Add Student" list
**Solution**: 
- Better filtering to exclude existing members
- Check for duplicates before inserting
- Friendly error message if duplicate

### Issue 3: Only One Student Showing
**Problem**: The filtering was working, but the two students already in the cohort weren't showing
**Solution**: Fixed the `fetchMembers` query to properly retrieve existing members

## Test Steps

### 1. Refresh Your App
Close and reopen, or hard refresh (Ctrl+Shift+R)

### 2. Open Browser Console (F12)
You'll see helpful logs

### 3. Go to Your Cohort
- Navigate to `/teach`
- Click on your cohort
- **Expected**: Should now see the 2 students that are already in it

### 4. Check the Console
Should see logs like:
```
Found student IDs: ["uuid1", "uuid2"]
Found profiles: [{id: "uuid1", full_name: "Student 1"}, ...]
```

### 5. Try Adding a Student
- Click "Add Student"
- **Expected**: Should NOT see the 2 students already in cohort
- **Expected**: Should see other learners (if any exist)

### 6. If You Try to Add an Existing Student
- Should see friendly message: "Already added"
- Dialog should close
- No error

## What You Should See

### Cohort Dashboard (`/teach`)
```
Your Cohort Name
Description here
👥 2 students          [View Details →]
```

### Cohort Detail Page
```
Students (2)                    [Add Student]

┌─────────────────────────────────────┐
│ Student Name 1                   🗑️ │
│ Streak: 0 days · Words: 0 · ...    │
└─────────────────────────────────────┘

┌─────────────────────────────────────┐
│ Student Name 2                   🗑️ │
│ Streak: 0 days · Words: 0 · ...    │
└─────────────────────────────────────┘
```

### Add Student Dialog
```
Add Student to Cohort

[Search by name...]

┌─────────────────────────────────────┐
│ 👤 Other Student 1                  │
│ 👤 Other Student 2                  │
│ 👤 Other Student 3                  │
└─────────────────────────────────────┘
```

(Should NOT show the 2 students already in cohort)

## Troubleshooting

### Students Still Not Showing

**Check Console Logs**:
- "Found student IDs: []" → No members in database
- "Found student IDs: [...]" but "Found profiles: []" → Profile data missing

**Check Database**:
```sql
-- See what's actually in cohort_members
SELECT * FROM cohort_members;

-- See if profiles exist
SELECT * FROM profiles WHERE id IN (
  SELECT student_id FROM cohort_members
);
```

### No Students in "Add Student" List

**Possible reasons**:
1. No other users with 'learner' role exist
2. All learners are already in the cohort

**Check**:
```sql
-- See all learners
SELECT p.id, p.full_name, ur.role
FROM profiles p
JOIN user_roles ur ON p.id = ur.user_id
WHERE ur.role = 'learner';
```

### Still Getting Duplicate Error

The check should prevent this, but if it happens:
- Check console for the error details
- The student is definitely already in the cohort
- Try refreshing the page

## Clean Up Test Data (If Needed)

If you want to start fresh:

```sql
-- Remove all members from a specific cohort
DELETE FROM cohort_members 
WHERE cohort_id = 'your-cohort-id-here';

-- Or remove a specific student from a cohort
DELETE FROM cohort_members 
WHERE cohort_id = 'cohort-id' 
AND student_id = 'student-id';
```

## Next Steps

Once students are showing correctly:

1. ✅ Test removing a student (click trash icon)
2. ✅ Test adding a new student
3. ✅ Verify count updates on dashboard
4. ✅ Check progress data displays (if students have activity)
5. ✅ Ready to deploy!

## Files Changed

- `src/hooks/useCohorts.tsx` - Fixed fetchMembers, improved addMember
- `src/pages/teach/CohortDetailPage.tsx` - Better filtering, more logging
- `supabase/migrations/20260309000001_diagnose_cohort_members.sql` - Diagnostic queries
