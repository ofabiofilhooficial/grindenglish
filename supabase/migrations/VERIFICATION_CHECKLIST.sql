-- Active Lexicon Engine - Verification Checklist
-- Run these queries to verify that all migrations have been applied correctly

-- ============================================================================
-- 1. Verify Tables Exist
-- ============================================================================

-- Check Master_Lexicon table
SELECT 
  table_name,
  column_name,
  data_type,
  is_nullable
FROM information_schema.columns
WHERE table_name = 'Master_Lexicon'
ORDER BY ordinal_position;

-- Check User_Vocabulary_Progress table
SELECT 
  table_name,
  column_name,
  data_type,
  is_nullable
FROM information_schema.columns
WHERE table_name = 'User_Vocabulary_Progress'
ORDER BY ordinal_position;

-- Check Audit_Log table
SELECT 
  table_name,
  column_name,
  data_type,
  is_nullable
FROM information_schema.columns
WHERE table_name = 'Audit_Log'
ORDER BY ordinal_position;

-- ============================================================================
-- 2. Verify Indexes Exist
-- ============================================================================

-- List all indexes on Master_Lexicon
SELECT 
  indexname,
  indexdef
FROM pg_indexes
WHERE tablename = 'Master_Lexicon'
ORDER BY indexname;

-- List all indexes on User_Vocabulary_Progress
SELECT 
  indexname,
  indexdef
FROM pg_indexes
WHERE tablename = 'User_Vocabulary_Progress'
ORDER BY indexname;

-- List all indexes on Audit_Log
SELECT 
  indexname,
  indexdef
FROM pg_indexes
WHERE tablename = 'Audit_Log'
ORDER BY indexname;

-- Verify composite index exists (CRITICAL)
SELECT 
  indexname,
  indexdef
FROM pg_indexes
WHERE tablename = 'User_Vocabulary_Progress'
  AND indexname = 'idx_uvp_user_next_review';

-- ============================================================================
-- 3. Verify Constraints
-- ============================================================================

-- Check constraints on Master_Lexicon
SELECT 
  constraint_name,
  constraint_type,
  table_name
FROM information_schema.table_constraints
WHERE table_name = 'Master_Lexicon'
ORDER BY constraint_name;

-- Check constraints on User_Vocabulary_Progress
SELECT 
  constraint_name,
  constraint_type,
  table_name
FROM information_schema.table_constraints
WHERE table_name = 'User_Vocabulary_Progress'
ORDER BY constraint_name;

-- Check check constraints
SELECT 
  constraint_name,
  check_clause
FROM information_schema.check_constraints
WHERE constraint_schema = 'public'
ORDER BY constraint_name;

-- ============================================================================
-- 4. Verify Foreign Keys
-- ============================================================================

-- Check foreign keys on User_Vocabulary_Progress
SELECT 
  constraint_name,
  table_name,
  column_name,
  foreign_table_name,
  foreign_column_name
FROM information_schema.key_column_usage
WHERE table_name = 'User_Vocabulary_Progress'
  AND foreign_table_name IS NOT NULL
ORDER BY constraint_name;

-- Check foreign keys on Audit_Log
SELECT 
  constraint_name,
  table_name,
  column_name,
  foreign_table_name,
  foreign_column_name
FROM information_schema.key_column_usage
WHERE table_name = 'Audit_Log'
  AND foreign_table_name IS NOT NULL
ORDER BY constraint_name;

-- ============================================================================
-- 5. Verify RLS Policies
-- ============================================================================

-- Check RLS policies on Master_Lexicon
SELECT 
  schemaname,
  tablename,
  policyname,
  permissive,
  roles,
  qual,
  with_check
FROM pg_policies
WHERE tablename = 'Master_Lexicon'
ORDER BY policyname;

-- Check RLS policies on User_Vocabulary_Progress
SELECT 
  schemaname,
  tablename,
  policyname,
  permissive,
  roles,
  qual,
  with_check
FROM pg_policies
WHERE tablename = 'User_Vocabulary_Progress'
ORDER BY policyname;

-- Check RLS policies on Audit_Log
SELECT 
  schemaname,
  tablename,
  policyname,
  permissive,
  roles,
  qual,
  with_check
FROM pg_policies
WHERE tablename = 'Audit_Log'
ORDER BY policyname;

-- ============================================================================
-- 6. Verify Functions Exist
-- ============================================================================

-- Check helper functions
SELECT 
  routine_name,
  routine_type,
  data_type
FROM information_schema.routines
WHERE routine_schema = 'public'
  AND routine_name IN (
    'initialize_vocabulary_progress',
    'get_due_words',
    'get_due_words_count',
    'get_dashboard_metrics',
    'get_lexicon_entries',
    'get_lexicon_entries_count',
    'get_practice_session_stats',
    'update_srs_progress',
    'parse_cloze',
    'serialize_cloze',
    'parse_l1_notes',
    'serialize_l1_notes'
  )
ORDER BY routine_name;

-- ============================================================================
-- 7. Verify Triggers
-- ============================================================================

-- Check triggers
SELECT 
  trigger_name,
  event_manipulation,
  event_object_table,
  action_statement
FROM information_schema.triggers
WHERE trigger_schema = 'public'
ORDER BY trigger_name;

-- ============================================================================
-- 8. Test Basic Functionality
-- ============================================================================

-- Test 1: Insert into Master_Lexicon
INSERT INTO Master_Lexicon (
  english_word,
  cefr_level,
  unit,
  definition,
  example_sentence,
  audio_url,
  l1_notes
) VALUES (
  'test_word_' || NOW()::TEXT,
  'A1',
  'Test Unit',
  'A test definition',
  'This is a test sentence with test_word in it',
  'https://example.com/test.mp3',
  'test vs. example: test is for checking'
)
RETURNING id, english_word, created_at;

-- Test 2: Parse cloze sentence
SELECT parse_cloze(
  'This is a test sentence with test_word in it',
  'test_word'
);

-- Test 3: Parse L1 notes
SELECT * FROM parse_l1_notes(
  'test vs. example: test is for checking'
);

-- Test 4: Serialize L1 notes
SELECT serialize_l1_notes(
  'test',
  'example',
  'test is for checking'
);

-- ============================================================================
-- 9. Performance Verification
-- ============================================================================

-- Check table sizes
SELECT 
  schemaname,
  tablename,
  pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) AS size
FROM pg_tables
WHERE schemaname = 'public'
  AND tablename IN ('Master_Lexicon', 'User_Vocabulary_Progress', 'Audit_Log')
ORDER BY tablename;

-- Check index sizes
SELECT 
  schemaname,
  tablename,
  indexname,
  pg_size_pretty(pg_relation_size(indexrelid)) AS size
FROM pg_stat_user_indexes
WHERE schemaname = 'public'
  AND tablename IN ('Master_Lexicon', 'User_Vocabulary_Progress', 'Audit_Log')
ORDER BY tablename, indexname;

-- ============================================================================
-- 10. Verification Summary
-- ============================================================================

-- Summary query to verify all components
SELECT 
  'Master_Lexicon' AS component,
  COUNT(*) AS count,
  'Table' AS type
FROM information_schema.tables
WHERE table_name = 'Master_Lexicon'

UNION ALL

SELECT 
  'User_Vocabulary_Progress' AS component,
  COUNT(*) AS count,
  'Table' AS type
FROM information_schema.tables
WHERE table_name = 'User_Vocabulary_Progress'

UNION ALL

SELECT 
  'Audit_Log' AS component,
  COUNT(*) AS count,
  'Table' AS type
FROM information_schema.tables
WHERE table_name = 'Audit_Log'

UNION ALL

SELECT 
  'Indexes' AS component,
  COUNT(*) AS count,
  'Index' AS type
FROM pg_indexes
WHERE tablename IN ('Master_Lexicon', 'User_Vocabulary_Progress', 'Audit_Log')

UNION ALL

SELECT 
  'Functions' AS component,
  COUNT(*) AS count,
  'Function' AS type
FROM information_schema.routines
WHERE routine_schema = 'public'
  AND routine_name IN (
    'initialize_vocabulary_progress',
    'get_due_words',
    'get_due_words_count',
    'get_dashboard_metrics',
    'get_lexicon_entries',
    'get_lexicon_entries_count',
    'get_practice_session_stats',
    'update_srs_progress',
    'parse_cloze',
    'serialize_cloze',
    'parse_l1_notes',
    'serialize_l1_notes'
  )

UNION ALL

SELECT 
  'RLS Policies' AS component,
  COUNT(*) AS count,
  'Policy' AS type
FROM pg_policies
WHERE tablename IN ('Master_Lexicon', 'User_Vocabulary_Progress', 'Audit_Log');

-- ============================================================================
-- Expected Results
-- ============================================================================
--
-- Tables: 3 (Master_Lexicon, User_Vocabulary_Progress, Audit_Log)
-- Indexes: 10+ (3 on Master_Lexicon, 3 on User_Vocabulary_Progress, 4 on Audit_Log)
-- Functions: 12 (initialize_vocabulary_progress, get_due_words, get_due_words_count,
--                get_dashboard_metrics, get_lexicon_entries, get_lexicon_entries_count,
--                get_practice_session_stats, update_srs_progress, parse_cloze,
--                serialize_cloze, parse_l1_notes, serialize_l1_notes)
-- Triggers: 2 (update_master_lexicon_updated_at, update_user_vocabulary_progress_updated_at)
-- RLS Policies: 11 (3 on Master_Lexicon, 4 on User_Vocabulary_Progress, 2 on Audit_Log)
--
-- To run this checklist: supabase db execute -f supabase/migrations/VERIFICATION_CHECKLIST.sql
-- Or run sections in Supabase SQL Editor.
--
-- ============================================================================
