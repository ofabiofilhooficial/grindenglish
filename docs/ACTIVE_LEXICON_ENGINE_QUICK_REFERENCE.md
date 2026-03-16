# Active Lexicon Engine - Quick Reference Guide

## Database Schema Quick Reference

### Master_Lexicon (Immutable Vocabulary Repository)
```sql
-- Create a vocabulary entry
INSERT INTO Master_Lexicon (
  english_word, cefr_level, unit, definition, 
  example_sentence, audio_url, l1_notes
) VALUES (
  'have', 'A1', 'Unit 1', 'to possess or own',
  'I have breakfast at 7 AM', 'https://audio.example.com/have.mp3',
  'make vs. do: Use have for possession'
);

-- Query vocabulary
SELECT * FROM Master_Lexicon WHERE cefr_level = 'A1' LIMIT 10;
```

### User_Vocabulary_Progress (User Learning State)
```sql
-- Initialize vocabulary for a user
SELECT initialize_vocabulary_progress(user_id, lexicon_entry_id);

-- Get user's due words
SELECT * FROM get_due_words(user_id, 20, 0);

-- Get dashboard metrics
SELECT * FROM get_dashboard_metrics(user_id);
```

## SRS Algorithm Quick Reference

### Grade a Vocabulary Item
```sql
-- Record user's grade and update progress
SELECT * FROM update_srs_progress(
  user_id, 
  lexicon_entry_id, 
  'Good'  -- or 'Hard' or 'Easy'
);
```

### Algorithm Behavior

| Grade | Ease Factor | Interval | Consecutive | Status Change |
|-------|-------------|----------|-------------|---------------|
| Hard  | -0.2 (min 1.3) | 1 day | Reset to 0 | Learning → Learning |
| Good  | Unchanged | × ease_factor | +1 | New → Learning |
| Easy  | +0.1 (max 2.5) | × ease_factor × 1.3 | +1 | New → Learning |

### Status Transitions
- **New → Learning**: On first grade
- **Learning → Mastered**: When consecutive_correct >= 3 (interval becomes 30 days)
- **Mastered → Learning**: On Hard grade (resets consecutive_correct)

## Cloze Sentence Handling

### Generate Cloze Sentence
```sql
-- Parse example sentence to create cloze flashcard
SELECT parse_cloze(
  'I have breakfast at 7 AM',  -- example_sentence
  'have'                        -- target_word
);
-- Returns: 'I _____ breakfast at 7 AM'
```

### Restore Complete Sentence
```sql
-- Serialize cloze back to complete sentence
SELECT serialize_cloze(
  'I _____ breakfast at 7 AM',  -- cloze_sentence
  'have'                         -- target_word
);
-- Returns: 'I have breakfast at 7 AM'
```

## L1 Notes Handling

### Parse L1 Notes
```sql
-- Extract structured interference pattern
SELECT * FROM parse_l1_notes(
  'make vs. do: Use make for creating; use do for actions'
);
-- Returns: term1='make', term2='do', explanation='Use make for creating; use do for actions'
```

### Serialize L1 Notes
```sql
-- Format L1 notes back to text
SELECT serialize_l1_notes(
  'make',                                    -- term1
  'do',                                      -- term2
  'Use make for creating; use do for actions' -- explanation
);
-- Returns: 'make vs. do: Use make for creating; use do for actions'
```

## Common Queries

### Get Due Words for Dashboard
```sql
SELECT 
  lexicon_entry_id,
  english_word,
  cefr_level,
  unit,
  days_overdue,
  next_review_date
FROM get_due_words(auth.uid(), 20, 0)
ORDER BY next_review_date ASC;
```

### Get Dashboard Metrics
```sql
SELECT 
  total_words_unlocked,
  words_in_learning,
  words_mastered
FROM get_dashboard_metrics(auth.uid());
```

### Get Vocabulary Details
```sql
SELECT 
  ml.id,
  ml.english_word,
  ml.definition,
  ml.example_sentence,
  ml.cefr_level,
  ml.unit,
  ml.audio_url,
  ml.l1_notes,
  COALESCE(uvp.status, 'New') AS mastery_status,
  uvp.next_review_date
FROM Master_Lexicon ml
LEFT JOIN User_Vocabulary_Progress uvp 
  ON ml.id = uvp.lexicon_entry_id 
  AND uvp.user_id = auth.uid()
WHERE ml.english_word ILIKE '%have%'
LIMIT 50;
```

### Get Audit Trail for a Word
```sql
SELECT 
  action,
  grade,
  previous_status,
  new_status,
  previous_ease_factor,
  new_ease_factor,
  timestamp
FROM Audit_Log
WHERE user_id = auth.uid() 
  AND lexicon_entry_id = ?
ORDER BY timestamp DESC
LIMIT 50;
```

## API Endpoint Patterns

### Dashboard API
```
GET /api/dashboard/metrics
  → Returns: total_words_unlocked, words_in_learning, words_mastered

GET /api/dashboard/due-words?page=1&limit=20
  → Returns: Paginated due words with days_overdue
```

### Practice API
```
GET /api/practice/next-word
  → Returns: Cloze sentence (NOT definition or L1_Notes yet)

POST /api/practice/grade
  Body: { lexicon_entry_id, grade: "Hard|Good|Easy" }
  → Returns: Updated progress, message, next word

GET /api/practice/session-stats
  → Returns: total_words_reviewed, average_ease_factor, words_mastered_today
```

### Lexicon API
```
GET /api/lexicon/entries?search=have&cefr_levels=A1,A2&page=1&limit=50
  → Returns: Paginated vocabulary with mastery status

GET /api/lexicon/entries/:id
  → Returns: Full vocabulary details

POST /api/lexicon/entries/:id/start-learning
  → Returns: Initialized progress entry
```

## Performance Targets

| Operation | Target | Index Used |
|-----------|--------|-----------|
| Get due words | < 100ms | (user_id, next_review_date) |
| Get metrics | < 500ms | Aggregation |
| Search vocabulary | < 500ms | Full-text search |
| Grade word | < 1s | Transaction |

## Row Level Security (RLS)

### Master_Lexicon
- **SELECT**: Public (everyone can read)
- **INSERT/UPDATE**: Content creators only
- **DELETE**: Content creators only

### User_Vocabulary_Progress
- **SELECT**: Users see only their own data
- **INSERT/UPDATE/DELETE**: Users can only modify their own data

### Audit_Log
- **SELECT**: Users see their own logs, admins see all
- **INSERT**: System only (automatic)

## Error Handling

### Common Errors

```sql
-- Error: Target word not found in example sentence
SELECT parse_cloze('I eat breakfast', 'have');
-- Exception: Target word not found in example sentence

-- Error: Invalid L1 Notes format
SELECT parse_l1_notes('make and do: explanation');
-- Exception: Invalid L1_Notes format. Expected 'term1 vs. term2: explanation'

-- Error: Invalid grade
SELECT update_srs_progress(user_id, lexicon_entry_id, 'Maybe');
-- Exception: Invalid grade. Must be Hard, Good, or Easy.

-- Error: Vocabulary not initialized
SELECT update_srs_progress(user_id, non_existent_id, 'Good');
-- Exception: Vocabulary progress entry not found
```

## Initialization Checklist

- [ ] Run migration: `20260313000000_create_active_lexicon_engine_schema.sql`
- [ ] Run migration: `20260313000001_create_srs_algorithm_functions.sql`
- [ ] Seed Master_Lexicon with vocabulary entries
- [ ] Verify indexes are created: `\d+ User_Vocabulary_Progress`
- [ ] Test RLS policies with authenticated user
- [ ] Test SRS algorithm with sample grades
- [ ] Verify audit logging works
- [ ] Set up caching for metrics (30-second TTL)
- [ ] Configure connection pooling (20-50 connections)
- [ ] Set up monitoring for query performance

## Useful SQL Commands

```sql
-- Check table sizes
SELECT 
  schemaname,
  tablename,
  pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) AS size
FROM pg_tables
WHERE schemaname = 'public'
ORDER BY pg_total_relation_size(schemaname||'.'||tablename) DESC;

-- Check index usage
SELECT 
  schemaname,
  tablename,
  indexname,
  idx_scan,
  idx_tup_read,
  idx_tup_fetch
FROM pg_stat_user_indexes
WHERE schemaname = 'public'
ORDER BY idx_scan DESC;

-- Analyze query performance
EXPLAIN ANALYZE
SELECT * FROM User_Vocabulary_Progress 
WHERE user_id = ? AND next_review_date <= CURRENT_DATE
ORDER BY next_review_date ASC
LIMIT 20;

-- Vacuum and analyze
VACUUM ANALYZE public.User_Vocabulary_Progress;
VACUUM ANALYZE public.Master_Lexicon;
```

## Troubleshooting

### Query is slow
1. Check if composite index is being used: `EXPLAIN ANALYZE`
2. Run `VACUUM ANALYZE` to update statistics
3. Verify user_id is filtered first in WHERE clause
4. Check for missing indexes

### RLS policy blocking access
1. Verify user is authenticated: `SELECT auth.uid();`
2. Check if `is_content_creator()` function exists
3. Verify policy syntax is correct
4. Test with direct SQL first, then through API

### Constraint violations
1. Verify ease_factor is 1.3-2.5
2. Verify interval_days is >= 1
3. Verify status is New/Learning/Mastered
4. Check for duplicate (user_id, lexicon_entry_id) pairs

## Monitoring and observability

- **Metrics to watch**: Due-words query time (target &lt; 100 ms), dashboard metrics query (target &lt; 500 ms), and `update_srs_progress` latency (target &lt; 1 s).
- **Client-side**: The Active Lexicon API layer (`src/lib/active-lexicon/api.ts`) can log call duration in development when `VITE_ACTIVE_LEXICON_LOG_TIMING=true` is set in `.env`; use this to spot slow RPCs.
- **Database**: Use `EXPLAIN ANALYZE` on `get_due_words` and `get_dashboard_metrics` (or their underlying queries) to confirm index usage. Monitor `pg_stat_user_indexes` for index scans on `idx_uvp_user_next_review`.
- **Audit**: All grades are written to `Audit_Log`; query by `user_id` and `timestamp` for debugging and analytics.

## References

- Full Schema: `supabase/migrations/ACTIVE_LEXICON_ENGINE_SETUP.md`
- Requirements: `.kiro/specs/active-lexicon-engine/requirements.md`
- Design: `.kiro/specs/active-lexicon-engine/design.md`
- Seeding: `supabase/seed/active_lexicon_seed.sql`
- Verification: `supabase/migrations/VERIFICATION_CHECKLIST.sql`
