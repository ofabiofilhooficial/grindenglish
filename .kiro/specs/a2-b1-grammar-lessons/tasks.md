# Implementation Plan: A2-B1 Grammar Lessons

## Overview

This implementation adds 60 intermediate-level grammar lessons (28 A2 and 32 B1) to the existing grammar_chapters table via two separate idempotent SQL migrations. The migrations follow the established pattern from A0 and A1 lessons, using WHERE NOT EXISTS checks to ensure safe re-execution. All lessons include comprehensive pedagogical content across nine sections (functional goals, form, meaning, use, contrast, common errors, task upgrades, micro-practice, and cross-links) extracted from the source document at docs/philosophy/complete-efl-grammar-theory.md (lines 1946-4491).

## Tasks

- [x] 1. Extract A2 lesson content from source document
  - [x] 1.1 Extract content for A2.G.01 through A2.G.14 (first half)
    - Extract all nine sections for each lesson from source document
    - Map sections to database columns: diagnostic_hook (section 1), form_content (section 2), meaning_content (section 3), use_content (section 4), contrast_notes (section 5), common_errors (section 6), task_upgrades (section 7), micro_practice (section 8), cross_links (section 9)
    - Preserve formatting including tables, lists, and examples
    - Escape all apostrophes for SQL (double single quotes)
    - _Requirements: 13.1, 13.3, 13.4, 15.1_
  
  - [x] 1.2 Extract content for A2.G.15 through A2.G.28 (second half)
    - Continue extraction for remaining 14 A2 lessons
    - Maintain consistent formatting and escaping
    - Verify all 28 A2 lessons extracted completely
    - _Requirements: 13.1, 13.3, 13.4, 15.1_
  
  - [x] 1.3 Convert micro-practice exercises to JSONB format
    - Transform section 8 content into structured JSON arrays
    - Support exercise types: fill_blank, multiple_choice, correction, transformation
    - Include fields: type, prompt, answer, options (if applicable), feedback
    - Validate JSON syntax for all 28 A2 lessons
    - _Requirements: 11.1, 11.2, 13.5_
  
  - [x] 1.4 Convert cross-links to JSONB format
    - Transform section 9 content into structured JSON arrays
    - Include fields: type (prerequisite/related/advanced), chapter_code, note (optional)
    - Map "Prerequisites" to type "prerequisite", "Next steps" to type "advanced"
    - Validate JSON syntax for all 28 A2 lessons
    - _Requirements: 9.1, 9.2, 13.6_

- [x] 2. Create A2 migration file with all 28 lessons
  - [x] 2.1 Create migration file structure
    - Create file: supabase/migrations/20260312000000_add_a2_grammar_chapters.sql
    - Add header comment documenting purpose, lesson count, and idempotency
    - Set up idempotent INSERT pattern using SELECT/VALUES/WHERE NOT EXISTS
    - _Requirements: 10.1, 10.3, 10.5_
  
  - [x] 2.2 Add INSERT statements for A2.G.01 through A2.G.10
    - Include all required fields: chapter_code, title, cefr_level, form_content, meaning_content, use_content, is_published, sort_order
    - Include optional fields: contrast_notes, common_errors, diagnostic_hook, task_upgrades, micro_practice, cross_links
    - Set is_published=true and sort_order=1-10
    - Verify SQL syntax and escaping
    - _Requirements: 1.1, 1.2, 1.3, 1.4, 1.5, 5.1-5.10, 10.4_
  
  - [x] 2.3 Add INSERT statements for A2.G.11 through A2.G.20
    - Continue with lessons 11-20
    - Set sort_order=11-20
    - Maintain consistent formatting
    - _Requirements: 1.1, 1.2, 1.3, 1.4, 1.5, 5.1-5.10, 10.4_
  
  - [x] 2.4 Add INSERT statements for A2.G.21 through A2.G.28
    - Complete final 8 A2 lessons
    - Set sort_order=21-28
    - Verify all 28 lessons included
    - _Requirements: 1.1, 1.2, 1.3, 1.4, 1.5, 5.1-5.10, 10.4_
  
  - [ ]* 2.5 Write property test for A2 required fields completeness
    - **Property 1: Required Fields Completeness**
    - **Validates: Requirements 1.3**
    - Test that all A2 chapters have non-null required fields
    - Use fast-check to generate chapter numbers 1-28
    - Run 100 iterations minimum

- [x] 3. Checkpoint - Verify A2 migration syntax and test execution
  - [x] Run A2 migration in development environment
  - [x] Verify exactly 28 A2 chapters inserted successfully
  - [x] Check for SQL syntax errors or constraint violations
  - [x] Verify JSONB fields parse correctly
  - [x] Fixed duplicate A2.G.10 entry and re-ran migration successfully

- [x] 4. Extract B1 lesson content from source document
  - [x] 4.1 Extract content for B1.G.01 through B1.G.16 (first half)
    - Extract all nine sections for each lesson from source document
    - Map sections to database columns following same pattern as A2
    - Preserve formatting and escape apostrophes
    - _Requirements: 13.2, 13.3, 13.4, 15.1_
  
  - [x] 4.2 Extract content for B1.G.17 through B1.G.32 (second half)
    - Continue extraction for remaining 16 B1 lessons
    - Maintain consistent formatting and escaping
    - Verify all 32 B1 lessons extracted completely
    - _Requirements: 13.2, 13.3, 13.4, 15.1_
  
  - [x] 4.3 Convert micro-practice exercises to JSONB format
    - Transform section 8 content into structured JSON arrays
    - Support same exercise types as A2
    - Validate JSON syntax for all 32 B1 lessons
    - _Requirements: 11.1, 11.2, 13.5_
  
  - [x] 4.4 Convert cross-links to JSONB format
    - Transform section 9 content into structured JSON arrays
    - Include references to A0, A1, A2 prerequisites
    - Validate JSON syntax for all 32 B1 lessons
    - _Requirements: 9.1, 9.2, 9.4, 13.6_

- [x] 5. Create B1 migration file with all 32 lessons
  - [x] 5.1 Create migration file structure
    - Create file: supabase/migrations/20260312000001_add_b1_grammar_chapters.sql
    - Add header comment documenting purpose, lesson count, and idempotency
    - Set up idempotent INSERT pattern using SELECT/VALUES/WHERE NOT EXISTS
    - _Requirements: 10.2, 10.3, 10.5_
  
  - [x] 5.2 Add INSERT statements for B1.G.01 through B1.G.10
    - Include all required and optional fields
    - Set is_published=true and sort_order=1-10
    - Verify SQL syntax and escaping
    - _Requirements: 2.1, 2.2, 2.3, 2.4, 2.5, 6.1-6.10, 10.4_
  
  - [x] 5.3 Add INSERT statements for B1.G.11 through B1.G.20
    - Continue with lessons 11-20
    - Set sort_order=11-20
    - Maintain consistent formatting
    - _Requirements: 2.1, 2.2, 2.3, 2.4, 2.5, 6.1-6.10, 10.4_
  
  - [x] 5.4 Add INSERT statements for B1.G.21 through B1.G.32
    - Complete final 12 B1 lessons
    - Set sort_order=21-32
    - Verify all 32 lessons included
    - _Requirements: 2.1, 2.2, 2.3, 2.4, 2.5, 6.1-6.10, 10.4_
  
  - [ ]* 5.5 Write property test for B1 required fields completeness
    - **Property 1: Required Fields Completeness**
    - **Validates: Requirements 2.3**
    - Test that all B1 chapters have non-null required fields
    - Use fast-check to generate chapter numbers 1-32
    - Run 100 iterations minimum

- [-] 6. Checkpoint - Verify B1 migration syntax and test execution
  - Run B1 migration in development environment
  - Verify exactly 32 B1 chapters inserted successfully
  - Check for SQL syntax errors or constraint violations
  - Verify JSONB fields parse correctly
  - Ensure all tests pass, ask the user if questions arise

- [ ] 7. Write unit tests for migration execution
  - [ ]* 7.1 Write unit test for A2 chapter count and codes
    - Test that exactly 28 A2 chapters exist after migration
    - Verify chapter codes A2.G.01 through A2.G.28 in correct order
    - _Requirements: 1.1, 1.2_
  
  - [ ]* 7.2 Write unit test for B1 chapter count and codes
    - Test that exactly 32 B1 chapters exist after migration
    - Verify chapter codes B1.G.01 through B1.G.32 in correct order
    - _Requirements: 2.1, 2.2_
  
  - [ ]* 7.3 Write unit test for existing chapter preservation
    - Test that all A0 chapters (12) remain after migrations
    - Test that all A1 chapters (24) remain after migrations
    - Verify total chapter count: 12 + 24 + 28 + 32 = 96
    - _Requirements: 3.1_
  
  - [ ]* 7.4 Write unit test for migration idempotency
    - Run both migrations twice in test environment
    - Verify chapter counts remain unchanged after second run
    - Test that no duplicate chapters created
    - _Requirements: 10.5, 10.6_
  
  - [ ]* 7.5 Write unit test for specific topic coverage
    - Test A2 includes required topics (past continuous, present perfect, conditionals, passive voice, relative clauses)
    - Test B1 includes required topics (present perfect continuous, narrative tenses, mixed conditionals, causative)
    - _Requirements: 5.1-5.10, 6.1-6.10_

- [ ] 8. Write property-based tests for correctness properties
  - [ ]* 8.1 Write property test for sort order sequence alignment
    - **Property 2: Sort Order Sequence Alignment**
    - **Validates: Requirements 1.5, 2.5, 12.2**
    - Test that sort_order matches chapter_code numeric suffix
    - Verify A2.G.XX has sort_order=XX and B1.G.XX has sort_order=XX
    - Run across all A2 and B1 chapters with 100 iterations
  
  - [ ]* 8.2 Write property test for chapter code uniqueness
    - **Property 3: Chapter Code Uniqueness**
    - **Validates: Requirements 3.3, 12.1**
    - Test that no two chapters share the same chapter_code
    - Verify across all CEFR levels (A0, A1, A2, B1)
    - Run 100 iterations
  
  - [ ]* 8.3 Write property test for sort order uniqueness within level
    - **Property 4: Sort Order Uniqueness Within Level**
    - **Validates: Requirements 12.4**
    - Test that all chapters within same CEFR level have unique sort_order
    - Verify for A2 (28 unique values) and B1 (32 unique values)
    - Run 100 iterations
  
  - [ ]* 8.4 Write property test for CEFR level independence
    - **Property 5: CEFR Level Independence**
    - **Validates: Requirements 3.2**
    - Test that different CEFR levels can have overlapping sort_order values
    - Verify A2 and B1 both have sort_order 1-28
    - Run 100 iterations
  
  - [ ]* 8.5 Write property test for JSONB validity (micro-practice)
    - **Property 6: JSONB Validity for Micro-Practice**
    - **Validates: Requirements 11.1, 11.3**
    - Test that all micro_practice fields contain valid parseable JSON arrays
    - Verify each exercise has required fields: type, prompt, answer, feedback
    - Test JSON serialization doesn't throw errors
    - Run across all A2 and B1 chapters with 100 iterations
  
  - [ ]* 8.6 Write property test for JSONB validity (cross-links)
    - **Property 7: JSONB Validity for Cross-Links**
    - **Validates: Requirements 9.1, 9.2**
    - Test that all cross_links fields contain valid parseable JSON arrays
    - Verify each link has required fields: type, chapter_code
    - Verify type is one of: prerequisite, related, advanced
    - Run across all A2 and B1 chapters with 100 iterations
  
  - [ ]* 8.7 Write property test for publication status
    - **Property 8: Publication Status**
    - **Validates: Requirements 10.4**
    - Test that all A2 and B1 chapters have is_published=true
    - Run across all 60 chapters with 100 iterations
  
  - [ ]* 8.8 Write property test for database compatibility preservation
    - **Property 10: Database Compatibility Preservation**
    - **Validates: Requirements 8.3, 8.4**
    - Test that RLS policies apply correctly to A2 and B1 chapters
    - Test that updated_at trigger fires on A2 and B1 chapter updates
    - Verify constraints and indexes work correctly
    - Run 100 iterations

- [ ] 9. Manual verification and final testing
  - [ ] 9.1 Verify content formatting in database
    - Check that tables display correctly (quantifiers, verb forms)
    - Verify line breaks and paragraph spacing preserved
    - Test special characters and apostrophes render correctly
    - _Requirements: 13.4_
  
  - [ ] 9.2 Verify cross-link references
    - Check that all prerequisite cross-links reference existing chapters
    - Verify forward references to B2/C1 chapters are acceptable
    - Test that cross-links display correctly in UI
    - _Requirements: 9.3, 9.4, 9.5_
  
  - [ ] 9.3 Verify L1 transfer notes included
    - Check that Portuguese-specific notes appear in common_errors field
    - Verify L1 transfer notes provide actionable guidance
    - _Requirements: 14.1, 14.2, 14.3_
  
  - [ ] 9.4 Test grammar reference UI display
    - Verify all 28 A2 lessons display in correct order
    - Verify all 32 B1 lessons display in correct order
    - Check that all nine sections render correctly for sample chapters
    - Test micro-practice exercises render and function correctly
    - Verify cross-links are clickable and navigate correctly
    - _Requirements: 7.1, 7.2, 7.3_

- [ ] 10. Final checkpoint - Execute all tests and verify deployment readiness
  - Run both migrations in development environment
  - Execute all unit tests (7.1-7.5)
  - Execute all property-based tests (8.1-8.8) with 100+ iterations each
  - Verify total chapter count: 96 chapters (12 A0 + 24 A1 + 28 A2 + 32 B1)
  - Complete manual verification checklist (9.1-9.4)
  - Ensure all tests pass, ask the user if questions arise

## Notes

- Tasks marked with `*` are optional and can be skipped for faster MVP
- Each task references specific requirements for traceability
- Both migrations use idempotent pattern (WHERE NOT EXISTS) for safe re-execution
- All text content requires SQL escaping (double single quotes for apostrophes)
- JSONB fields must be valid JSON arrays with proper structure
- Property tests use fast-check library with minimum 100 iterations
- Unit tests verify specific scenarios and edge cases
- Source content is in docs/philosophy/complete-efl-grammar-theory.md lines 1946-4491
- A2 lessons cover 28 topics (sort_order 1-28)
- B1 lessons cover 32 topics (sort_order 1-32)
- Cross-links should reference A0/A1 prerequisites and can include forward references to B2/C1
- Micro-practice exercises should include diverse exercise types (fill_blank, multiple_choice, correction, transformation)
- L1 transfer notes for Portuguese speakers should be preserved in common_errors field
- Final verification includes both automated tests and manual UI testing
