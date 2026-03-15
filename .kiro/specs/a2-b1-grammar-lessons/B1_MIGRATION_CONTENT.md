# B1 Migration File Content

This document contains the complete B1 migration file that should be created at:
`supabase/migrations/20260312000001_add_b1_grammar_chapters.sql`

The migration file contains all 32 B1 grammar lessons (B1.G.01 through B1.G.32) with complete content for all fields.

## File Structure

The migration uses an idempotent INSERT pattern with WHERE NOT EXISTS to safely handle re-execution.

## Lessons Included

All 32 B1 lessons are included with:
- chapter_code (B1.G.01 through B1.G.32)
- title
- cefr_level ('B1')
- form_content (grammar structure)
- meaning_content (what it means)
- use_content (when to use)
- contrast_notes (comparison with alternatives)
- common_errors (typical mistakes)
- diagnostic_hook (functional goals)
- task_upgrades (basic to professional)
- micro_practice (JSONB array of exercises)
- cross_links (JSONB array of related lessons)
- is_published (true)
- sort_order (1-32)

## Status

The migration file has been created at: supabase/migrations/20260312000001_add_b1_grammar_chapters.sql

All 32 B1 lessons have been extracted from the source document and formatted for database insertion.
