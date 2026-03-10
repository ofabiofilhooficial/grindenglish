# Implementation Plan: A1 Grammar Lessons

## Overview

This implementation adds 24 A1-level grammar lessons to the existing grammar_chapters table via a single idempotent SQL migration. The migration follows the established pattern from A0 lessons, using WHERE NOT EXISTS checks to ensure safe re-execution. All lessons include comprehensive pedagogical content (form, meaning, use, contrast, errors, task upgrades) along with JSONB-structured micro-practice exercises and cross-links to related lessons.

## Tasks

- [x] 1. Create migration file structure and idempotent INSERT pattern
  - Create file: supabase/migrations/20260311000000_add_a1_grammar_chapters.sql
  - Set up idempotent INSERT pattern using SELECT/VALUES/WHERE NOT EXISTS
  - Add migration header comment documenting purpose and idempotency
  - _Requirements: 8.1, 8.2, 8.4, 8.5_

- [x] 2. Implement A1.G.01 through A1.G.06 (Present tense and pronouns)
  - [x] 2.1 Add INSERT statements for chapters A1.G.01-A1.G.06
    - A1.G.01: Simple Present - Affirmative
    - A1.G.02: Simple Present - Negative
    - A1.G.03: Simple Present - Questions
    - A1.G.04: Possessive 's
    - A1.G.05: Possessive Pronouns
    - A1.G.06: Object Pronouns
    - Escape all apostrophes in content (double single quotes)
    - Format JSONB for micro_practice and cross_links arrays
    - Set is_published=true and sort_order=1-6
    - _Requirements: 1.1, 1.2, 1.3, 1.4, 1.5, 4.1, 4.2, 4.3, 8.3_
  
  - [ ]* 2.2 Write property test for chapters A1.G.01-A1.G.06
    - **Property 1: Required Fields Completeness**
    - **Validates: Requirements 1.3, 3.1, 3.2, 3.3**
    - Test that all required fields are non-null and non-empty
    - Use fast-check to generate chapter numbers 1-6
    - Run 100 iterations minimum

- [x] 3. Implement A1.G.07 through A1.G.10 (Nouns and present continuous)
  - [x] 3.1 Add INSERT statements for chapters A1.G.07-A1.G.10
    - A1.G.07: Count and Noncount Nouns
    - A1.G.08: Quantifiers (some, any, much, many)
    - A1.G.09: Present Continuous - Affirmative
    - A1.G.10: Present Continuous - Negative and Questions
    - Include table formatting for quantifier rules
    - Set sort_order=7-10
    - _Requirements: 1.1, 1.2, 1.3, 1.4, 1.5, 4.4, 4.5_
  
  - [ ]* 3.2 Write property test for JSONB validity
    - **Property 2: JSONB Validity**
    - **Validates: Requirements 3.8, 3.9, 7.1, 9.1**
    - Test that micro_practice and cross_links are valid JSON arrays
    - Verify JSON serialization doesn't throw errors
    - Test across all 24 chapters

- [x] 4. Implement A1.G.11 through A1.G.15 (Past and future tenses)
  - [x] 4.1 Add INSERT statements for chapters A1.G.11-A1.G.15
    - A1.G.11: Simple Past - Regular Verbs
    - A1.G.12: Simple Past - Irregular Verbs
    - A1.G.13: Simple Past - Negative and Questions
    - A1.G.14: Future with 'going to'
    - A1.G.15: Future with 'will'
    - Include irregular verb tables in A1.G.12
    - Set sort_order=11-15
    - _Requirements: 1.1, 1.2, 1.3, 1.4, 1.5, 4.6, 4.7_
  
  - [ ]* 4.2 Write property test for chapter code uniqueness
    - **Property 3: Chapter Code Uniqueness**
    - **Validates: Requirements 2.3, 10.1**
    - Test that no two chapters share the same chapter_code
    - Verify across all CEFR levels (A0 and A1)

- [x] 5. Checkpoint - Verify migration syntax and test database insertion
  - Run migration in development environment
  - Verify 15 chapters inserted successfully
  - Check for SQL syntax errors or constraint violations
  - Ensure all tests pass, ask the user if questions arise

- [x] 6. Implement A1.G.16 through A1.G.20 (Comparatives and modals)
  - [x] 6.1 Add INSERT statements for chapters A1.G.16-A1.G.20
    - A1.G.16: Comparative Adjectives
    - A1.G.17: Superlative Adjectives
    - A1.G.18: Modal: must / have to
    - A1.G.19: Modal: should
    - A1.G.20: Modal: would like
    - Include comparison tables for adjectives
    - Set sort_order=16-20
    - _Requirements: 1.1, 1.2, 1.3, 1.4, 1.5, 4.8, 4.9_
  
  - [ ]* 6.2 Write property test for sort order alignment
    - **Property 4: Sort Order Sequence Alignment**
    - **Validates: Requirements 10.2**
    - Test that sort_order matches chapter_code numeric suffix
    - Verify A1.G.XX has sort_order=XX

- [x] 7. Implement A1.G.21 through A1.G.24 (Prepositions, adverbs, questions)
  - [x] 7.1 Add INSERT statements for chapters A1.G.21-A1.G.24
    - A1.G.21: Prepositions of Time
    - A1.G.22: Prepositions of Movement
    - A1.G.23: Adverbs of Frequency and Manner
    - A1.G.24: Questions with How much/many and Whose
    - Include preposition usage tables
    - Set sort_order=21-24
    - _Requirements: 1.1, 1.2, 1.3, 1.4, 1.5, 4.10, 4.11, 4.12_
  
  - [ ]* 7.2 Write property test for sort order uniqueness
    - **Property 5: Sort Order Uniqueness Within Level**
    - **Validates: Requirements 10.4**
    - Test that all A1 chapters have unique sort_order values
    - Verify 24 distinct sort_order values exist

- [x] 8. Add cross-links between A1 chapters and A0 prerequisites
  - [x] 8.1 Update cross_links JSONB for all 24 chapters
    - Add prerequisite links to relevant A0 chapters
    - Add related links to other A1 chapters
    - Format as JSONB arrays with type, chapter_code, and note fields
    - _Requirements: 7.1, 7.2, 7.4_
  
  - [ ]* 8.2 Write property test for publication status
    - **Property 6: Publication Status**
    - **Validates: Requirements 8.3**
    - Test that all A1 chapters have is_published=true
    - Verify across all 24 chapters

- [x] 9. Implement micro-practice exercises for all chapters
  - [x] 9.1 Add micro_practice JSONB for all 24 chapters
    - Include 2-3 exercises per chapter
    - Support fill_blank and multiple_choice types
    - Include prompt, answer, options (if applicable), and feedback
    - Format as valid JSONB arrays
    - _Requirements: 3.8, 9.1, 9.2, 9.3_
  
  - [ ]* 9.2 Write property test for CEFR level independence
    - **Property 7: CEFR Level Independence**
    - **Validates: Requirements 2.2**
    - Test that A0 and A1 can have overlapping sort_order values
    - Verify sort_order is scoped by cefr_level

- [ ] 10. Add unit tests for migration execution
  - [ ]* 10.1 Write unit test for chapter count
    - Test that exactly 24 A1 chapters exist after migration
    - Verify chapter codes A1.G.01 through A1.G.24
    - _Requirements: 1.1, 1.2_
  
  - [ ]* 10.2 Write unit test for A0 preservation
    - Test that all 12 A0 chapters remain after migration
    - Verify A0 chapter count unchanged
    - _Requirements: 2.1_
  
  - [ ]* 10.3 Write unit test for idempotency
    - Run migration twice in test environment
    - Verify chapter count remains 24 after second run
    - Test that no duplicate chapters created
    - _Requirements: 8.4, 8.5_
  
  - [ ]* 10.4 Write unit test for content validation
    - Test that micro_practice fields contain valid arrays
    - Test that cross_links reference valid chapter codes
    - Verify JSONB structure matches expected format
    - _Requirements: 3.8, 3.9, 7.3, 9.3_

- [ ] 11. Add property test for database compatibility
  - [ ]* 11.1 Write property test for RLS and triggers
    - **Property 8: Database Compatibility Preservation**
    - **Validates: Requirements 6.3, 6.4**
    - Test that RLS policies apply to A1 chapters
    - Test that updated_at trigger fires on A1 chapter updates
    - Verify constraints and indexes work correctly

- [x] 12. Final checkpoint - Execute migration and verify all tests
  - Run complete migration in development environment
  - Execute all property-based tests (100+ iterations each)
  - Execute all unit tests
  - Verify 24 A1 chapters + 12 A0 chapters = 36 total
  - Check that all chapters display correctly in grammar reference UI
  - Ensure all tests pass, ask the user if questions arise

## Notes

- Tasks marked with `*` are optional and can be skipped for faster MVP
- Each task references specific requirements for traceability
- Migration uses idempotent pattern (WHERE NOT EXISTS) for safe re-execution
- All text content requires SQL escaping (double single quotes for apostrophes)
- JSONB fields must be valid JSON arrays with proper structure
- Property tests use fast-check library with minimum 100 iterations
- Unit tests verify specific scenarios and edge cases
- Cross-links should reference both A0 prerequisites and related A1 chapters
- Micro-practice exercises should include diverse exercise types
- Final verification includes both automated tests and manual UI testing
