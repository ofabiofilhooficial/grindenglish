# Implementation Plan: Active Lexicon Engine

## Overview

The Active Lexicon Engine is a comprehensive Spaced Repetition System (SRS) that transforms vocabulary learning through intelligent scheduling, contextual practice, and progress tracking. This implementation plan breaks down the feature into sequenced, actionable tasks organized by component and dependency.

The implementation follows a logical sequence: database setup → core algorithms → API layer → frontend components → advanced features → testing and optimization.

## Phase 1: Database Schema and Core Data Models

- [x] 1. Set up database schema and migrations
  - Create Master_Lexicon table with UUID primary key and all required columns
  - Create User_Vocabulary_Progress table with composite index on (user_id, next_review_date)
  - Create Audit_Log table for tracking all grade submissions and status changes
  - Create database indexes for performance optimization (CEFR level, unit, english_word)
  - _Requirements: 1.1, 1.2, 2.1, 18.1_

  - [ ]* 1.1 Write property test for Master Lexicon UUID stability
    - **Property 1: Master Lexicon UUID Stability**
    - **Validates: Requirements 1.2**

  - [ ]* 1.2 Write property test for Master Lexicon complete retrieval
    - **Property 2: Master Lexicon Complete Retrieval**
    - **Validates: Requirements 1.5**

- [-] 2. Implement database connection pooling and transaction management
  - Set up connection pool with 20-50 connections
  - Implement transaction wrapper for atomic operations
  - Add retry logic with exponential backoff (1s, 2s, 4s, 8s)
  - Configure SERIALIZABLE isolation level for SRS updates
  - _Requirements: 18.1, 18.2_

## Phase 2: Core SRS Algorithm Implementation

- [~] 3. Implement Spaced Repetition System (SRS) algorithm
  - Create updateProgress function handling Hard, Good, Easy grades
  - Implement ease factor calculation (1.3-2.5 bounds)
  - Implement interval_days calculation with rounding
  - Implement status transitions (New → Learning → Mastered)
  - Implement mastery demotion logic (Mastered → Learning on Hard grade)
  - _Requirements: 3.1, 3.2, 3.3, 3.4, 3.5, 3.6, 20.1, 20.2, 20.3_

  - [ ]* 3.1 Write property test for Hard grade behavior
    - **Property 4: Hard Grade Reduces Ease Factor**
    - **Validates: Requirements 3.1**

  - [ ]* 3.2 Write property test for Good grade behavior
    - **Property 5: Good Grade Maintains Ease Factor**
    - **Validates: Requirements 3.2**

  - [ ]* 3.3 Write property test for Easy grade behavior
    - **Property 6: Easy Grade Increases Ease Factor**
    - **Validates: Requirements 3.3**

  - [ ]* 3.4 Write property test for interval days positivity
    - **Property 7: Interval Days Always Positive**
    - **Validates: Requirements 3.5**

  - [ ]* 3.5 Write property test for next review date calculation
    - **Property 8: Next Review Date Calculation**
    - **Validates: Requirements 3.6, 2.6**

  - [ ]* 3.6 Write property test for mastery transition threshold
    - **Property 29: Mastery Transition Threshold**
    - **Validates: Requirements 2.4, 20.1, 20.2**

- [~] 4. Implement vocabulary item initialization logic
  - Create initializeVocabularyProgress function
  - Set initial values: status=New, ease_factor=2.5, interval_days=1, consecutive_correct=0
  - Prevent duplicate initialization (check existing entries)
  - _Requirements: 2.2, 19.1, 19.2, 19.3_

  - [ ]* 4.1 Write property test for user progress initialization
    - **Property 3: User Progress Initialization**
    - **Validates: Requirements 2.2**

  - [ ]* 4.2 Write property test for duplicate prevention
    - **Property 46: Vocabulary Item Duplicate Prevention**
    - **Validates: Requirements 19.3**

## Phase 3: Parser and Serializer Implementation

- [~] 5. Implement Cloze Parser and Serializer
  - Create parseCloze function to replace target word with blank
  - Handle edge cases: punctuation, capitalization, multiple occurrences
  - Create serializeCloze function to restore complete sentence
  - Implement error handling for missing target words
  - _Requirements: 21.1, 21.2, 21.4_

  - [ ]* 5.1 Write property test for cloze sentence generation
    - **Property 20: Cloze Sentence Generation**
    - **Validates: Requirements 9.2, 21.1, 21.2**

  - [ ]* 5.2 Write property test for cloze round trip
    - **Property 21: Cloze Sentence Round Trip**
    - **Validates: Requirements 21.4**

- [~] 6. Implement L1 Notes Parser and Serializer
  - Create parseL1Notes function to extract term1, term2, explanation
  - Validate format: "term1 vs. term2: explanation"
  - Create serializeL1Notes function to format back to text
  - Implement error handling for invalid formats
  - _Requirements: 22.1, 22.2, 22.4_

  - [ ]* 6.1 Write property test for L1 notes format validation
    - **Property 22: L1 Notes Format Validation**
    - **Validates: Requirements 22.2**

  - [ ]* 6.2 Write property test for L1 notes round trip
    - **Property 23: L1 Notes Round Trip**
    - **Validates: Requirements 22.4**

## Phase 4: Backend API Implementation

- [~] 7. Implement Authentication API
  - Create login endpoint with JWT token generation (24-hour expiration)
  - Create logout endpoint with token invalidation
  - Create token refresh endpoint with 7-day refresh token
  - Implement session timeout (30 minutes idle, 24 hours absolute)
  - Implement password hashing with bcrypt (salt rounds = 12)
  - _Requirements: 16.1, 16.2, 16.4_

- [~] 8. Implement Dashboard API
  - Create GET /api/dashboard/metrics endpoint
  - Implement metrics calculation: total_words_unlocked, words_in_learning, words_mastered
  - Implement 30-second caching with cache invalidation on updates
  - Create GET /api/dashboard/due-words endpoint with pagination (20 items/page)
  - Implement composite index query for performance (< 100ms target)
  - _Requirements: 5.1, 5.2, 5.3, 5.4, 5.5, 6.1, 6.2, 6.3, 6.4, 6.5, 17.1, 17.2, 17.3, 17.4_

  - [ ]* 8.1 Write property test for metrics calculation accuracy
    - **Property 11: Metrics Calculation Accuracy**
    - **Validates: Requirements 5.2, 5.3, 5.4**

  - [ ]* 8.2 Write property test for metrics refresh responsiveness
    - **Property 12: Metrics Refresh Responsiveness**
    - **Validates: Requirements 5.5**

  - [ ]* 8.3 Write property test for due words query correctness
    - **Property 9: Due Words Query Correctness**
    - **Validates: Requirements 4.1, 4.5**

  - [ ]* 8.4 Write property test for due words query performance
    - **Property 10: Due Words Query Performance**
    - **Validates: Requirements 4.2**

  - [ ]* 8.5 Write property test for due words queue pagination
    - **Property 13: Due Words Queue Pagination**
    - **Validates: Requirements 6.3**

  - [ ]* 8.6 Write property test for queue item removal after review
    - **Property 14: Queue Item Removal After Review**
    - **Validates: Requirements 6.4**

- [~] 9. Implement Lexicon API
  - Create GET /api/lexicon/entries endpoint with search and filtering
  - Implement search on english_word (case-insensitive, partial match)
  - Implement filters: CEFR level, unit, mastery status (AND logic)
  - Create GET /api/lexicon/entries/:id endpoint for detail view
  - Create POST /api/lexicon/entries/:id/start-learning endpoint
  - _Requirements: 8.1, 8.2, 8.3, 8.4, 8.5, 8.6, 8.7, 8.8, 8.9, 19.1, 19.2_

  - [ ]* 9.1 Write property test for search filtering
    - **Property 18: Lexicon Hub Search Filtering**
    - **Validates: Requirements 8.3**

  - [ ]* 9.2 Write property test for multi-filter AND logic
    - **Property 19: Lexicon Hub Multi-Filter AND Logic**
    - **Validates: Requirements 8.7**

- [~] 10. Implement Practice API
  - Create GET /api/practice/next-word endpoint
  - Return cloze sentence (target word replaced with blank)
  - Do NOT return definition or L1_Notes initially
  - Create POST /api/practice/grade endpoint
  - Execute SRS algorithm and update User_Vocabulary_Progress atomically
  - Implement transaction retry logic (up to 3 retries with exponential backoff)
  - Create GET /api/practice/session-stats endpoint
  - _Requirements: 9.1, 9.2, 11.1, 11.2, 11.3, 12.1, 18.1, 18.2, 18.3_

  - [ ]* 10.1 Write property test for grade recording and progress update
    - **Property 28: Grade Recording and Progress Update**
    - **Validates: Requirements 11.2, 11.3**

  - [ ]* 10.2 Write property test for grade persistence latency
    - **Property 31: Grade Persistence Latency**
    - **Validates: Requirements 12.1**

  - [ ]* 10.3 Write property test for atomic SRS updates
    - **Property 43: Atomic SRS Updates**
    - **Validates: Requirements 18.1**

  - [ ]* 10.4 Write property test for transaction retry logic
    - **Property 44: Transaction Retry Logic**
    - **Validates: Requirements 18.2**

  - [ ]* 10.5 Write property test for mastery transition validation
    - **Property 45: Mastery Transition Validation**
    - **Validates: Requirements 18.3**

- [~] 11. Implement error handling and input validation
  - Add parameterized queries to prevent SQL injection
  - Implement input sanitization for search terms
  - Validate grade input (Hard, Good, Easy only)
  - Implement error logging with unique error IDs
  - Create user-friendly error messages for network failures, timeouts, server errors
  - _Requirements: 18.5, 25.1, 25.2, 25.3, 25.4, 25.5_

- [~] 12. Implement offline support and local queueing
  - Create local storage mechanism for queued grades
  - Implement sync logic when connectivity restored
  - Maintain order of grades during sync
  - Display user-friendly messages for offline state
  - _Requirements: 12.2, 12.4, 12.5_

  - [ ]* 12.1 Write property test for offline grade queueing
    - **Property 32: Offline Grade Queueing**
    - **Validates: Requirements 12.4, 12.5**

  - [ ]* 12.2 Write property test for session resumption
    - **Property 33: Session Resumption**
    - **Validates: Requirements 12.3**

## Phase 5: Frontend Components - Progress Dashboard

- [~] 13. Implement Progress Dashboard component
  - Create MetricsSection displaying total_words_unlocked, words_in_learning, words_mastered
  - Create DueWordsQueue component with pagination
  - Create "Grind Due Words" primary CTA button
  - Implement auto-refresh every 30 seconds
  - Implement cache invalidation on progress updates
  - _Requirements: 5.1, 5.2, 5.3, 5.4, 5.5, 5.6, 6.1, 6.2, 6.3, 6.4, 6.5, 6.6, 7.1, 7.2, 7.3, 7.4_

  - [ ]* 13.1 Write property test for grind button conditional display
    - **Property 15: Grind Button Conditional Display**
    - **Validates: Requirements 7.1, 7.3**

  - [ ]* 13.2 Write property test for grind button navigation
    - **Property 16: Grind Button Navigation**
    - **Validates: Requirements 7.2**

- [~] 14. Implement mobile responsiveness for Dashboard
  - Implement responsive layout for mobile (< 768px)
  - Ensure "Grind Due Words" button occupies 80% viewport width on mobile
  - Implement 44px minimum touch target size for all buttons
  - Stack metrics vertically on mobile
  - _Requirements: 7.5, 13.1, 13.2_

  - [ ]* 14.1 Write property test for mobile button width
    - **Property 17: Mobile Button Width**
    - **Validates: Requirements 7.5**

## Phase 6: Frontend Components - Lexicon Hub

- [~] 15. Implement Lexicon Hub component
  - Create SearchBar with case-insensitive search
  - Create FilterPanel with CEFR level, unit, and status filters
  - Create VocabularyTable with columns: English_Word, CEFR_Level, Unit, Mastery_Status, Last_Reviewed_Date
  - Implement pagination (50 items per page)
  - Create DetailPanel showing full vocabulary entry information
  - _Requirements: 8.1, 8.2, 8.3, 8.4, 8.5, 8.6, 8.7, 8.8, 8.9_

- [~] 16. Implement keyboard navigation for Lexicon Hub
  - Implement Tab key cycling through interactive elements
  - Implement "S" shortcut to focus search field
  - Implement "F" shortcut to open filter panel
  - Implement Enter key to open detail panel
  - Implement Escape key to close detail panel
  - _Requirements: 23.1, 23.2, 23.3, 23.5_

  - [ ]* 16.1 Write property test for keyboard tab navigation
    - **Property 47: Keyboard Tab Navigation**
    - **Validates: Requirements 23.1**

  - [ ]* 16.2 Write property test for keyboard escape handling
    - **Property 49: Keyboard Escape Handling**
    - **Validates: Requirements 23.3**

## Phase 7: Frontend Components - Practice Arena

- [~] 17. Implement Practice Arena cloze flashcard component
  - Create ClozeCard displaying cloze sentence with blank
  - Create RevealButton to show answer
  - Display English_Word, Definition, and L1_Notes on reveal
  - Implement audio button for pronunciation
  - Create GradingButtons (Hard, Good, Easy)
  - Display feedback messages based on grade
  - _Requirements: 9.1, 9.2, 9.3, 9.4, 9.5, 9.6, 9.7, 10.1, 10.2, 10.4, 10.5, 10.6, 11.1, 11.2, 11.3, 11.4, 11.5, 11.6, 11.7_

  - [ ]* 17.1 Write property test for reveal button hides answer initially
    - **Property 24: Reveal Button Hides Answer Initially**
    - **Validates: Requirements 9.4**

  - [ ]* 17.2 Write property test for reveal button shows all content
    - **Property 25: Reveal Button Shows All Content**
    - **Validates: Requirements 9.6**

- [~] 18. Implement audio playback and caching
  - Create audio pre-fetching logic for current + next 3 words
  - Store audio in browser cache (Service Worker or IndexedDB)
  - Implement audio playback from cache
  - Handle audio loading errors gracefully
  - Implement priority pre-fetching on slow networks (< 2 Mbps)
  - Clear cache on session end
  - _Requirements: 10.1, 10.2, 10.3, 10.4, 10.5, 10.6, 14.1, 14.2, 14.3, 14.4, 14.5, 14.6_

  - [ ]* 18.1 Write property test for audio pre-fetching
    - **Property 26: Audio Pre-fetching**
    - **Validates: Requirements 10.3, 14.1**

  - [ ]* 18.2 Write property test for audio playback from cache
    - **Property 27: Audio Playback from Cache**
    - **Validates: Requirements 10.2, 14.2**

- [~] 19. Implement L1 Notes display and highlighting
  - Display L1_Notes prominently after reveal
  - Highlight L1_Notes when graded as "Hard"
  - Increase prominence on second consecutive "Hard" grade
  - Hide L1_Notes section if not present
  - _Requirements: 15.1, 15.2, 15.3, 15.4, 15.5_

  - [ ]* 19.1 Write property test for L1 notes highlighting on hard grade
    - **Property 38: L1 Notes Highlighting on Hard Grade**
    - **Validates: Requirements 15.2**

  - [ ]* 19.2 Write property test for L1 notes progressive emphasis
    - **Property 39: L1 Notes Progressive Emphasis**
    - **Validates: Requirements 15.3**

- [~] 20. Implement session persistence and resumption
  - Save current progress to local storage on grade submission
  - Implement session resumption from last ungraded word
  - Display session statistics on completion
  - _Requirements: 12.1, 12.2, 12.3_

- [~] 21. Implement mobile responsiveness for Practice Arena
  - Implement single column layout for mobile (< 768px)
  - Position cloze sentence in upper half of viewport
  - Position grading buttons in lower half for thumb access
  - Ensure 44px minimum touch target size
  - Use 18px minimum font for cloze sentence on mobile
  - Hide non-essential UI elements on mobile
  - _Requirements: 13.1, 13.2, 13.3, 13.4, 13.5, 13.6_

  - [ ]* 21.1 Write property test for mobile single column layout
    - **Property 34: Mobile Single Column Layout**
    - **Validates: Requirements 13.1**

  - [ ]* 21.2 Write property test for mobile touch target size
    - **Property 35: Mobile Touch Target Size**
    - **Validates: Requirements 13.2**

  - [ ]* 21.3 Write property test for mobile cloze positioning
    - **Property 36: Mobile Cloze Positioning**
    - **Validates: Requirements 13.3, 13.4**

  - [ ]* 21.4 Write property test for mobile font size
    - **Property 37: Mobile Font Size**
    - **Validates: Requirements 13.5**

- [~] 22. Implement keyboard shortcuts for Practice Arena
  - Implement "R" shortcut to reveal answer
  - Implement "H" shortcut to grade as Hard
  - Implement "G" shortcut to grade as Good
  - Implement "E" shortcut to grade as Easy
  - _Requirements: 23.4_

  - [ ]* 22.1 Write property test for practice arena keyboard shortcuts
    - **Property 50: Practice Arena Keyboard Shortcuts**
    - **Validates: Requirements 23.4**

## Phase 8: Accessibility Implementation

- [~] 23. Implement keyboard navigation across all components
  - Implement Tab key cycling through all interactive elements
  - Implement Enter key activation for buttons
  - Implement Escape key to close modals
  - Test tab order on all pages
  - _Requirements: 23.1, 23.2, 23.3_

  - [ ]* 23.1 Write property test for keyboard enter activation
    - **Property 48: Keyboard Enter Activation**
    - **Validates: Requirements 23.2**

- [~] 24. Implement screen reader support
  - Add ARIA labels to all interactive elements
  - Add ARIA descriptions for buttons and form fields
  - Implement live regions for dynamic content updates
  - Add semantic HTML (button, form, table, section, nav)
  - Implement skip links for main content
  - _Requirements: 24.1, 24.2, 24.3, 24.4, 24.5_

  - [ ]* 24.1 Write property test for screen reader cloze announcement
    - **Property 52: Screen Reader Cloze Announcement**
    - **Validates: Requirements 24.1**

  - [ ]* 24.2 Write property test for screen reader reveal button announcement
    - **Property 53: Screen Reader Reveal Button Announcement**
    - **Validates: Requirements 24.2**

  - [ ]* 24.3 Write property test for screen reader grading buttons announcement
    - **Property 54: Screen Reader Grading Buttons Announcement**
    - **Validates: Requirements 24.3**

- [~] 25. Implement color contrast and focus indicators
  - Ensure 4.5:1 contrast ratio for normal text
  - Ensure 3:1 contrast ratio for large text
  - Implement visible focus indicators (3px outline minimum)
  - Test with WCAG contrast checker
  - _Requirements: 23.1, 23.2_

## Phase 9: Security Implementation

- [~] 26. Implement authentication and authorization
  - Implement JWT token generation and validation
  - Implement role-based access control (learner, admin, instructor)
  - Implement session timeout (30 minutes idle, 24 hours absolute)
  - Implement password hashing with bcrypt
  - Implement password reset flow with email verification
  - _Requirements: 16.1, 16.2, 16.3, 16.4_

  - [ ]* 26.1 Write property test for user authentication session isolation
    - **Property 40: User Authentication Session Isolation**
    - **Validates: Requirements 16.3**

- [~] 27. Implement data encryption and HTTPS
  - Enable HTTPS/TLS 1.2+ for all endpoints
  - Implement database encryption at rest (AES-256)
  - Implement encrypted backups
  - Implement HSTS header
  - _Requirements: 16.4, 18.4_

- [~] 28. Implement rate limiting and CORS
  - Implement rate limiting (100 req/min for dashboard, 1000 for practice, 500 for lexicon, 10 for auth)
  - Implement CORS configuration
  - Implement request timeout handling (30s for queries, 10s for API, 5s for audio)
  - _Requirements: 18.5_

- [~] 29. Implement audit logging
  - Log all grade submissions with timestamp and user context
  - Log status transitions
  - Log login/logout events
  - Log failed authentication attempts
  - _Requirements: 16.5, 18.5_

## Phase 10: Testing and Optimization

- [~] 30. Checkpoint - Ensure all core functionality tests pass
  - Run all unit tests for SRS algorithm
  - Run all unit tests for parsers and serializers
  - Run all unit tests for API endpoints
  - Verify all property-based tests pass (minimum 100 iterations each)
  - Ensure all tests pass, ask the user if questions arise.

- [~] 31. Implement performance optimization
  - Verify dashboard metrics load in < 500ms
  - Verify due words query executes in < 100ms
  - Implement query result caching (30 seconds for metrics)
  - Implement lazy loading for lexicon hub
  - Implement connection pooling optimization
  - _Requirements: 17.1, 17.2, 17.3, 17.4_

  - [ ]* 31.1 Write property test for dashboard metrics caching
    - **Property 41: Dashboard Metrics Caching**
    - **Validates: Requirements 17.3**

  - [ ]* 31.2 Write property test for cache invalidation on update
    - **Property 42: Cache Invalidation on Update**
    - **Validates: Requirements 17.4**

- [~] 32. Implement comprehensive error handling
  - Test network timeout scenarios
  - Test database connection failures
  - Test audio loading failures
  - Test authentication failures
  - Verify error messages are user-friendly
  - Verify error IDs are logged for support
  - _Requirements: 25.1, 25.2, 25.3, 25.4, 25.5_

  - [ ]* 32.1 Write property test for unauthenticated access redirect
    - **Property 55: Unauthenticated Access Redirect**
    - **Validates: Requirements 25.4**

  - [ ]* 32.2 Write property test for offline grade persistence message
    - **Property 56: Offline Grade Persistence Message**
    - **Validates: Requirements 25.3**

- [~] 33. Final checkpoint - Ensure all tests pass and system is production-ready
  - Run full test suite (unit tests + property-based tests)
  - Verify all accessibility requirements met
  - Verify all security requirements implemented
  - Verify all performance targets met
  - Ensure all tests pass, ask the user if questions arise.

## Notes

- Tasks marked with `*` are optional property-based tests and can be skipped for faster MVP
- Each task references specific requirements for traceability
- Property-based tests validate universal correctness properties across all inputs
- Unit tests validate specific examples and edge cases
- Checkpoints ensure incremental validation and early error detection
- All API endpoints require authentication except login
- All database operations use parameterized queries to prevent SQL injection
- All user input is validated and sanitized before processing
