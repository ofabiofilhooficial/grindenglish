# Active Lexicon Engine - Database Setup Guide

## Overview

This guide explains the database schema and migrations for the Active Lexicon Engine, a comprehensive Spaced Repetition System (SRS) for vocabulary learning.

## Migration Files

### 1. `20260313000000_create_active_lexicon_engine_schema.sql`

**Purpose**: Creates the core database tables and indexes for the Active Lexicon Engine.

**Tables Created**:

#### Master_Lexicon
- **Purpose**: Immutable, centralized repository of vocabulary entries
- **Key Features**:
  - Stable UUID primary key (never changes)
  - Unique constraint on `english_word`
  - CEFR level validation (A1-C2)
  - Stores: definition, example_sentence, audio_url, l1_notes
- **Indexes**:
  - `idx_master_lexicon_cefr`: For filtering by difficulty level
  - `idx_master_lexicon_unit`: For filtering by thematic unit
  - `idx_master_lexicon_word`: For full-text search on vocabulary

#### User_Vocabulary_Progress
- **Purpose**: Tracks individual user progress for each vocabulary item
- **Key Features**:
  - Foreign keys to both `auth.users` and `Master_Lexicon`
  - Status tracking: New → Learning → Mastered
  - Ease factor bounds: 1.3 - 2.5
  - Interval days: Always positive integer
  - Unique constraint on (user_id, lexicon_entry_id)
- **Indexes**:
  - `idx_uvp_user_next_review`: **CRITICAL** - Composite index for due words query (< 100ms target)
  - `idx_uvp_user_status`: For status-based queries
  - `idx_uvp_user_id`: For user-specific queries

#### Audit_Log
- **Purpose**: Tracks all grade submissions and status changes for audit purposes
- **Key Features**:
  - Records: action, grade, status changes, ease factor changes, interval changes
  - Timestamps all events
  - Stores IP address and user agent for security
- **Indexes**:
  - `idx_audit_log_user`: For user-specific audit trails
  - `idx_audit_log_lexicon`: For word-specific audit trails
  - `idx_audit_log_timestamp`: For time-based queries
  - `idx_audit_log_action`: For action-type filtering

**Row Level Security (RLS)**:
- Master_Lexicon: Public read, admin write
- User_Vocabulary_Progress: Users see only their own data
- Audit_Log: Users see their own logs, admins see all

**Helper Functions**:
- `initialize_vocabulary_progress()`: Creates or retrieves vocabulary progress entry
- `get_due_words()`: Retrieves paginated due words for a user
- `get_due_words_count()`: Gets count of due words
- `get_dashboard_metrics()`: Calculates dashboard metrics (total_words_unlocked, words_in_learning, words_mastered)

### 2. `20260313000001_create_srs_algorithm_functions.sql`

**Purpose**: Creates the SRS algorithm implementation and parser/serializer functions.

**Functions Created**:

#### `update_srs_progress()`
- **Purpose**: Implements the Spaced Repetition System algorithm
- **Input**: user_id, lexicon_entry_id, grade (Hard/Good/Easy)
- **Algorithm**:
  - **Hard**: ease_factor -= 0.2 (min 1.3), interval = 1, consecutive_correct = 0
  - **Good**: ease_factor unchanged, interval *= ease_factor, consecutive_correct += 1
  - **Easy**: ease_factor += 0.1 (max 2.5), interval *= ease_factor * 1.3, consecutive_correct += 1
- **Status Transitions**:
  - New → Learning (on first grade)
  - Learning → Mastered (when consecutive_correct >= 3, interval = 30)
  - Mastered → Learning (on Hard grade)
- **Output**: Updated status, ease_factor, interval_days, next_review_date, consecutive_correct, total_reviews, message
- **Atomicity**: All updates happen in a single transaction
- **Audit**: Automatically logs to Audit_Log table

#### `parse_cloze()`
- **Purpose**: Generates cloze flashcard by replacing target word with blank
- **Input**: example_sentence, target_word
- **Output**: cloze_sentence with "_____ " replacing the target word
- **Edge Cases Handled**:
  - Case-insensitive matching
  - Multiple occurrences (replaces first only)
  - Attached punctuation (e.g., "have," → "_____ ,")
  - Raises error if target word not found

#### `serialize_cloze()`
- **Purpose**: Restores cloze sentence to complete sentence
- **Input**: cloze_sentence, target_word
- **Output**: complete_sentence with target word restored
- **Cleans up**: Extra spaces

#### `parse_l1_notes()`
- **Purpose**: Parses structured L1_Notes
- **Format**: "term1 vs. term2: explanation"
- **Output**: term1, term2, explanation (as separate fields)
- **Validation**: Raises error if format is invalid

#### `serialize_l1_notes()`
- **Purpose**: Formats parsed L1_Notes back to text
- **Input**: term1, term2, explanation
- **Output**: Formatted L1_Notes string

## Schema Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                    Master_Lexicon                           │
├─────────────────────────────────────────────────────────────┤
│ id (UUID, PK)                                               │
│ english_word (VARCHAR, UNIQUE)                              │
│ cefr_level (A1-C2)                                          │
│ unit (VARCHAR)                                              │
│ definition (TEXT)                                           │
│ example_sentence (TEXT)                                     │
│ audio_url (VARCHAR)                                         │
│ l1_notes (TEXT)                                             │
│ created_at, updated_at (TIMESTAMP)                          │
└─────────────────────────────────────────────────────────────┘
                            ▲
                            │ FK
                            │
┌─────────────────────────────────────────────────────────────┐
│              User_Vocabulary_Progress                        │
├─────────────────────────────────────────────────────────────┤
│ id (UUID, PK)                                               │
│ user_id (UUID, FK → auth.users)                             │
│ lexicon_entry_id (UUID, FK → Master_Lexicon)                │
│ status (New/Learning/Mastered)                              │
│ ease_factor (1.3-2.5)                                       │
│ interval_days (≥1)                                          │
│ next_review_date (DATE)                                     │
│ total_reviews (≥0)                                          │
│ consecutive_correct (≥0)                                    │
│ created_at, updated_at (TIMESTAMP)                          │
│ UNIQUE(user_id, lexicon_entry_id)                           │
│ INDEX: (user_id, next_review_date) ← CRITICAL              │
└─────────────────────────────────────────────────────────────┘
                            ▲
                            │ FK
                            │
┌─────────────────────────────────────────────────────────────┐
│                     Audit_Log                               │
├─────────────────────────────────────────────────────────────┤
│ id (UUID, PK)                                               │
│ user_id (UUID, FK → auth.users)                             │
│ lexicon_entry_id (UUID, FK → Master_Lexicon)                │
│ action (grade_submitted/status_changed/etc)                 │
│ grade (Hard/Good/Easy)                                      │
│ previous_status, new_status                                 │
│ previous_ease_factor, new_ease_factor                       │
│ previous_interval_days, new_interval_days                   │
│ timestamp (TIMESTAMP)                                       │
│ ip_address, user_agent                                      │
└─────────────────────────────────────────────────────────────┘
```

## Execution Instructions

### Prerequisites
- Supabase project set up and configured
- PostgreSQL 13+ (Supabase default)
- Proper authentication and authorization

### Running the Migrations

#### Option 1: Using Supabase CLI
```bash
# Apply all migrations
supabase migration up

# Or apply specific migration
supabase migration up --version 20260313000000
supabase migration up --version 20260313000001
```

#### Option 2: Using Supabase Dashboard
1. Go to SQL Editor in Supabase Dashboard
2. Copy and paste the migration SQL
3. Execute

#### Option 3: Using psql (Direct Database Access)
```bash
psql -h [host] -U [user] -d [database] -f 20260313000000_create_active_lexicon_engine_schema.sql
psql -h [host] -U [user] -d [database] -f 20260313000001_create_srs_algorithm_functions.sql
psql -h [host] -U [user] -d [database] -f 20260315000000_create_get_lexicon_entries.sql
```

### Seeding Master_Lexicon

After migrations, seed sample vocabulary so the Lexicon Hub and Practice Arena have data:

```bash
# Using Supabase CLI (from project root)
supabase db execute -f supabase/seed/active_lexicon_seed.sql
```

Or in Supabase Dashboard: SQL Editor → paste contents of `supabase/seed/active_lexicon_seed.sql` → Run.  
Re-running is safe (ON CONFLICT DO NOTHING).

### Verification Checklist

To verify schema, indexes, RLS, and functions:

```bash
supabase db execute -f supabase/migrations/VERIFICATION_CHECKLIST.sql
```

Or run sections of `VERIFICATION_CHECKLIST.sql` in the SQL Editor. Expected: 3 tables, 12 functions, 2 triggers, RLS policies on all tables.

## Key Performance Considerations

### Composite Index Strategy
The composite index on `(user_id, next_review_date)` is critical:
- Enables fast retrieval of due words for a specific user
- Supports sorting by next_review_date in a single pass
- Target: < 100ms query time for users with 5000+ items

### Query Optimization
```sql
-- Due words query (uses composite index)
SELECT * FROM User_Vocabulary_Progress 
WHERE user_id = ? AND next_review_date <= TODAY 
ORDER BY next_review_date ASC
LIMIT 20;

-- Metrics query (uses aggregation)
SELECT 
  COUNT(CASE WHEN status != 'New' THEN 1 END) AS total_words_unlocked,
  COUNT(CASE WHEN status = 'Learning' THEN 1 END) AS words_in_learning,
  COUNT(CASE WHEN status = 'Mastered' THEN 1 END) AS words_mastered
FROM User_Vocabulary_Progress
WHERE user_id = ?;
```

## Data Consistency Guarantees

1. **Atomic Updates**: All SRS updates happen in a single transaction
2. **Referential Integrity**: Foreign key constraints ensure data consistency
3. **Unique Constraints**: Prevent duplicate user-vocabulary pairs
4. **Check Constraints**: Enforce valid ranges (ease_factor, interval_days, status)
5. **Audit Trail**: All changes logged for compliance and debugging

## Initialization Workflow

When a user starts learning a vocabulary item:

```sql
-- 1. Initialize vocabulary progress
SELECT initialize_vocabulary_progress(user_id, lexicon_entry_id);

-- 2. Get cloze sentence for practice
SELECT parse_cloze(example_sentence, english_word) 
FROM Master_Lexicon 
WHERE id = lexicon_entry_id;

-- 3. Record grade and update progress
SELECT update_srs_progress(user_id, lexicon_entry_id, 'Good');

-- 4. Get next due word
SELECT * FROM get_due_words(user_id, 1, 0);
```

## Troubleshooting

### Issue: "Composite index not being used"
- Ensure queries filter by user_id first, then next_review_date
- Check query plan with EXPLAIN ANALYZE
- Consider VACUUM ANALYZE to update statistics

### Issue: "RLS policies blocking access"
- Verify user is authenticated (auth.uid() returns valid UUID)
- Check is_content_creator() function exists
- Ensure policies are correctly scoped

### Issue: "Constraint violations"
- Verify ease_factor is between 1.3 and 2.5
- Verify interval_days is >= 1
- Verify status is one of: New, Learning, Mastered

## Next Steps

After running these migrations:

1. **Seed Master_Lexicon**: Load vocabulary entries from curriculum
2. **Implement API Layer**: Create REST endpoints for dashboard, lexicon, practice
3. **Implement Frontend**: Build React components for dashboard, hub, arena
4. **Add Caching**: Implement 30-second cache for metrics
5. **Add Monitoring**: Set up performance monitoring for query times

## References

- Requirements: `.kiro/specs/active-lexicon-engine/requirements.md`
- Design Document: `.kiro/specs/active-lexicon-engine/design.md`
- Tasks: `.kiro/specs/active-lexicon-engine/tasks.md`
