# Implementation Plan: Comprehensive Vocabulary Data

## Overview

This implementation plan transforms the existing GSL vocabulary database from a minimal word list into a comprehensive pedagogical resource. The approach uses batched SQL migrations (100-200 words per batch) to populate IPA pronunciations, definitions, usage notes, examples, collocations, patterns, register, and variety information for 1000 GSL words. TypeScript will be used for validation scripts and property-based testing.

## Tasks

- [x] 1. Set up testing infrastructure and validation utilities
  - [x] 1.1 Create TypeScript test configuration for database testing
    - Set up test database connection utilities
    - Configure fast-check for property-based testing
    - Create test data generators for vocabulary entries
    - _Requirements: 9.5, 10.3, 11.3_
  
  - [x] 1.2 Implement validation query utilities in TypeScript
    - Create function to check for missing required fields
    - Create function to validate register and variety enumerations
    - Create function to validate JSONB structure and cardinality
    - Create function to check IPA format compliance
    - _Requirements: 11.1, 11.2, 11.3, 11.4, 11.5_
  
  - [x] 1.3 Create batch tracking and progress monitoring utilities
    - Implement query to show completion status by CEFR level
    - Create function to count populated vs unpopulated fields
    - Add reporting for migration batch progress
    - _Requirements: 12.4_

- [x] 2. Create migration batch 1 (A0 pronouns and basic verbs, ~150 words)
  - [x] 2.1 Write SQL migration for first A0 batch
    - Create migration file with sequential timestamp
    - Write UPDATE statements for pronouns (I, you, he, she, it, we, they)
    - Write UPDATE statements for basic verbs (be, have, do, go, come, get, make, take, etc.)
    - Include IPA, definitions, usage notes, examples, collocations, patterns, register, variety
    - Ensure idempotent WHERE clauses on headword
    - _Requirements: 1.1, 1.3, 2.1, 2.2, 2.3, 3.1, 4.1, 5.1, 5.2, 5.3, 5.4, 6.1, 6.2, 7.1, 8.1, 9.1, 9.2, 9.5_
  
  - [ ]* 2.2 Write property test for required field completeness
    - **Property 1: Required Field Completeness**
    - **Validates: Requirements 1.1, 2.1, 3.1, 4.1, 5.1, 5.3**
  
  - [ ]* 2.3 Write property test for IPA format validation
    - **Property 2: IPA Format Validation**
    - **Validates: Requirements 1.3**
  
  - [ ]* 2.4 Write unit tests for batch 1 migration
    - Test migration executes successfully
    - Test specific examples with special characters
    - Test rollback procedure for batch 1
    - _Requirements: 9.5, 10.4, 12.3_

- [x] 3. Create migration batch 2 (A0 common nouns and adjectives, ~150 words)
  - [x] 3.1 Write SQL migration for second A0 batch
    - Create migration file with sequential timestamp
    - Write UPDATE statements for common nouns (time, person, year, way, day, thing, man, world, etc.)
    - Write UPDATE statements for basic adjectives (good, new, first, last, long, great, little, own, etc.)
    - Include all linguistic data fields
    - _Requirements: 1.1, 2.1, 3.1, 4.1, 5.1, 6.1, 7.1, 8.1, 9.1, 9.2_
  
  - [ ]* 3.2 Write property test for definition length constraints
    - **Property 3: Simple Definition Length Constraint**
    - **Validates: Requirements 2.3**
  
  - [ ]* 3.3 Write property test for enumerated field validation
    - **Property 4: Enumerated Field Validation**
    - **Validates: Requirements 5.2, 5.4**

- [x] 4. Create migration batch 3 (A0 prepositions, determiners, conjunctions, ~100 words)
  - [x] 4.1 Write SQL migration for third A0 batch
    - Create migration file with sequential timestamp
    - Write UPDATE statements for prepositions (in, on, at, to, from, with, for, about, etc.)
    - Write UPDATE statements for determiners (the, a, an, this, that, these, those, etc.)
    - Write UPDATE statements for conjunctions (and, but, or, because, if, when, etc.)
    - Include all linguistic data fields
    - _Requirements: 1.1, 2.1, 3.1, 4.1, 5.1, 6.1, 7.1, 8.1, 9.1, 9.2_
  
  - [ ]* 4.2 Write property test for JSONB structure validation
    - **Property 5: JSONB Field Structure Validation**
    - **Validates: Requirements 6.1, 7.1, 8.1, 10.3**
  
  - [ ]* 4.3 Write property test for examples cardinality
    - **Property 6: Examples Cardinality Constraint**
    - **Validates: Requirements 6.2**

- [x] 5. Checkpoint - Validate A0 vocabulary completion
  - Run validation queries to check A0 data completeness
  - Verify all required fields are populated for A0 words
  - Ensure all tests pass, ask the user if questions arise

- [x] 6. Create migration batch 4 (A1 work and business vocabulary, ~150 words)
  - [x] 6.1 Write SQL migration for first A1 batch
    - Create migration file with sequential timestamp
    - Write UPDATE statements for work-related words (work, job, business, company, office, meeting, etc.)
    - Write UPDATE statements for professional verbs (manage, organize, plan, present, discuss, etc.)
    - Prioritize professional English contexts in usage notes and examples
    - Include all linguistic data fields
    - _Requirements: 1.1, 2.1, 3.1, 4.1, 4.2, 5.1, 6.1, 6.3, 7.1, 7.3, 8.1, 9.1, 9.2_
  
  - [ ]* 6.2 Write property test for collocations cardinality
    - **Property 7: Collocations Cardinality Constraint**
    - **Validates: Requirements 7.2**
  
  - [ ]* 6.3 Write property test for patterns cardinality
    - **Property 8: Patterns Cardinality Constraint**
    - **Validates: Requirements 8.2**

- [x] 7. Create migration batch 5 (A1 communication and technology, ~150 words)
  - [x] 7.1 Write SQL migration for second A1 batch
    - Create migration file with sequential timestamp
    - Write UPDATE statements for communication words (say, tell, speak, talk, ask, answer, call, etc.)
    - Write UPDATE statements for technology words (computer, phone, email, internet, website, etc.)
    - Include all linguistic data fields
    - _Requirements: 1.1, 2.1, 3.1, 4.1, 5.1, 6.1, 7.1, 8.1, 9.1, 9.2_
  
  - [ ]* 7.2 Write property test for migration idempotency
    - **Property 9: Migration Idempotency**
    - **Validates: Requirements 9.5, 12.5**
  
  - [ ]* 7.3 Write unit tests for idempotent migration execution
    - Test running same migration multiple times produces same result
    - Test UPDATE statements don't create duplicates
    - _Requirements: 9.5_

- [x] 8. Create migration batch 6 (A1 time and quantity, ~150 words)
  - [x] 8.1 Write SQL migration for third A1 batch
    - Create migration file with sequential timestamp
    - Write UPDATE statements for time words (today, tomorrow, yesterday, week, month, hour, etc.)
    - Write UPDATE statements for quantity words (many, much, few, little, some, all, every, etc.)
    - Include all linguistic data fields
    - _Requirements: 1.1, 2.1, 3.1, 4.1, 5.1, 6.1, 7.1, 8.1, 9.1, 9.2_
  
  - [ ]* 8.2 Write property test for field preservation during updates
    - **Property 10: Field Preservation During Updates**
    - **Validates: Requirements 10.1**
  
  - [ ]* 8.3 Write property test for timestamp updates
    - **Property 11: Timestamp Update on Modification**
    - **Validates: Requirements 10.2**

- [x] 9. Create migration batch 7 (A1 remaining high-frequency words, ~150 words)
  - [x] 9.1 Write SQL migration for fourth A1 batch
    - Create migration file with sequential timestamp
    - Write UPDATE statements for remaining A1 words
    - Ensure coverage of all A1 GSL words
    - Include all linguistic data fields
    - _Requirements: 1.1, 2.1, 3.1, 4.1, 5.1, 6.1, 7.1, 8.1, 9.1, 9.2_
  
  - [ ]* 9.2 Write property test for special character preservation
    - **Property 12: Special Character Preservation**
    - **Validates: Requirements 10.4**
  
  - [ ]* 9.3 Write unit tests for special character handling
    - Test quotes, apostrophes, accented characters
    - Test round-trip insert and retrieve
    - _Requirements: 10.4_

- [-] 10. Checkpoint - Validate A1 vocabulary completion
  - Run validation queries to check A1 data completeness
  - Verify all required fields are populated for A1 words
  - Ensure all tests pass, ask the user if questions arise

- [x] 11. Implement rollback procedures and batch independence testing
  - [x] 11.1 Create rollback scripts for each migration batch
    - Write SQL scripts to revert individual batches
    - Write SQL script for full rollback of all enhancements
    - Test rollback procedures don't affect other batches
    - _Requirements: 12.3_
  
  - [ ]* 11.2 Write property test for batch migration independence
    - **Property 13: Batch Migration Independence**
    - **Validates: Requirements 12.1**
  
  - [ ]* 11.3 Write property test for rollback isolation
    - **Property 14: Rollback Isolation**
    - **Validates: Requirements 12.3**
  
  - [ ]* 11.4 Write unit tests for rollback procedures
    - Test individual batch rollback
    - Test full rollback
    - Test rollback doesn't affect unrelated batches
    - _Requirements: 12.3_

- [x] 12. Create comprehensive validation and monitoring dashboard
  - [x] 12.1 Implement TypeScript validation report generator
    - Create script that runs all validation queries
    - Generate report showing data completeness by CEFR level
    - Identify missing or invalid data
    - Export results in JSON and human-readable formats
    - _Requirements: 11.1, 11.2, 11.4, 11.5, 12.4_
  
  - [x] 12.2 Create migration progress tracking script
    - Show which batches have been applied
    - Display completion percentage for each CEFR level
    - Identify words still needing enhancement
    - _Requirements: 12.2, 12.4_
  
  - [ ]* 12.3 Write integration tests for validation utilities
    - Test validation report generator with sample data
    - Test progress tracking with partial migrations
    - _Requirements: 11.1, 11.2_

- [ ] 13. Final checkpoint - Complete system validation
  - Run all property-based tests (minimum 100 iterations each)
  - Run all unit tests
  - Execute comprehensive validation report
  - Verify all 1000 GSL words have complete data
  - Ensure all tests pass, ask the user if questions arise

## Notes

- Tasks marked with `*` are optional and can be skipped for faster MVP
- Each migration batch is independent and can be deployed incrementally
- Property tests validate universal correctness properties across all data
- Unit tests validate specific examples, edge cases, and error conditions
- Validation utilities provide ongoing data quality monitoring
- Rollback procedures enable safe experimentation and error recovery
- All migrations are idempotent and can be safely re-run
