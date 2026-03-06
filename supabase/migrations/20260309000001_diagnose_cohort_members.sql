-- Diagnostic: Check what's in cohort_members and get foreign key name

-- See what data exists
SELECT 
  cm.id,
  cm.cohort_id,
  cm.student_id,
  cm.joined_at,
  p.full_name,
  c.name as cohort_name
FROM cohort_members cm
LEFT JOIN profiles p ON cm.student_id = p.id
LEFT JOIN cohorts c ON cm.cohort_id = c.id
ORDER BY cm.joined_at DESC
LIMIT 10;

-- Get the actual foreign key constraint name
SELECT
  tc.constraint_name,
  kcu.column_name,
  ccu.table_name AS foreign_table_name,
  ccu.column_name AS foreign_column_name
FROM information_schema.table_constraints AS tc
JOIN information_schema.key_column_usage AS kcu
  ON tc.constraint_name = kcu.constraint_name
JOIN information_schema.constraint_column_usage AS ccu
  ON ccu.constraint_name = tc.constraint_name
WHERE tc.table_name = 'cohort_members'
AND tc.constraint_type = 'FOREIGN KEY'
AND kcu.column_name = 'student_id';
