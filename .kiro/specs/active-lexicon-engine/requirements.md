# Active Lexicon Engine - Requirements Document

## Introduction

The Active Lexicon Engine transforms the vocabulary platform into an integrated Spaced Repetition System (SRS) that drives adult learners from passive recognition to automatic retrieval of English vocabulary. The system algorithmically schedules review intervals based on user recall difficulty, presents vocabulary in contextual cloze sentences, and anticipates L1 (Brazilian Portuguese) interference through targeted notes. The engine comprises three core components: a Progress Dashboard displaying global metrics and actionable review queues, a Vocabulary Page with dual states (Lexicon Hub for discovery and Practice Arena for active study), and a data model tracking user progress through mastery phases.

## Glossary

- **Active Lexicon Engine**: The complete SRS system integrating vocabulary discovery, spaced repetition scheduling, and progress tracking.
- **Spaced Repetition System (SRS)**: An algorithm that schedules review intervals based on user recall difficulty to optimize long-term retention.
- **Ease Factor**: A numerical value (typically 1.3–2.5) that adjusts review interval length based on user performance; higher values indicate easier recall.
- **Interval Days**: The number of days until the next scheduled review for a vocabulary item.
- **Next Review Date**: The calculated date when a vocabulary item is due for review.
- **Cloze Sentence**: A sentence with a blank space where the target vocabulary word should be filled in (e.g., "I _____ breakfast at 7 AM" for "have").
- **L1 Notes**: Contextual notes highlighting Brazilian Portuguese interference patterns (e.g., distinguishing "make" vs. "do").
- **Mastery Status**: The current learning phase of a vocabulary item: "New", "Learning", or "Mastered".
- **CEFR Level**: Common European Framework of Reference level (A1, A2, B1, B2, C1, C2) indicating vocabulary difficulty.
- **Unit**: A thematic grouping of vocabulary items within the curriculum.
- **Lexicon Hub**: The discovery and browsing interface for vocabulary items with filtering and search.
- **Practice Arena**: The active study interface presenting cloze flashcards with grading options.
- **Due Words**: Vocabulary items scheduled for review on or before the current date.
- **Recall Difficulty**: User self-assessment of recall quality (Hard, Good, Easy).
- **Master Lexicon**: The immutable, centralized repository of vocabulary entries with stable UUIDs and properties.
- **User Vocabulary Progress**: The dynamic junction table tracking individual user progress for each vocabulary item.
- **Consecutive Correct**: The count of consecutive successful recalls for a vocabulary item.
- **Total Reviews**: The cumulative count of review attempts for a vocabulary item.

## Requirements

### Requirement 1: Master Lexicon Data Model

**User Story:** As a curriculum designer, I want a centralized, immutable repository of vocabulary entries, so that all users learn from consistent, stable word definitions and properties.

#### Acceptance Criteria

1. THE Master_Lexicon SHALL store vocabulary entries with the following immutable properties: UUID, English_Word, CEFR_Level, Unit, Definition, Example_Sentence, Audio_URL, and L1_Notes.
2. WHEN a vocabulary entry is created, THE Master_Lexicon SHALL assign a stable UUID that remains unchanged throughout the system's lifetime.
3. THE Master_Lexicon SHALL support at least 2000 vocabulary entries without performance degradation.
4. WHERE a vocabulary entry includes L1_Notes, THE Master_Lexicon SHALL store the notes as structured text distinguishing interference patterns (e.g., "make vs. do", "have vs. there is").
5. WHEN the system retrieves a vocabulary entry, THE Master_Lexicon SHALL return all properties in a single query without requiring additional lookups.

### Requirement 2: User Vocabulary Progress Tracking

**User Story:** As a learner, I want the system to track my individual progress for each vocabulary item, so that my learning state is preserved and my review schedule is personalized.

#### Acceptance Criteria

1. THE User_Vocabulary_Progress table SHALL store the following mutable properties for each user-vocabulary pair: user_id, lexicon_entry_id, status, ease_factor, interval_days, next_review_date, total_reviews, and consecutive_correct.
2. WHEN a user first encounters a vocabulary item, THE User_Vocabulary_Progress SHALL initialize the entry with status="New", ease_factor=2.5, interval_days=1, next_review_date=today, total_reviews=0, and consecutive_correct=0.
3. WHILE a vocabulary item is in "Learning" status, THE User_Vocabulary_Progress SHALL update interval_days and next_review_date based on the user's recall difficulty (Hard, Good, Easy).
4. WHEN a user achieves consecutive_correct >= 3, THE User_Vocabulary_Progress SHALL transition the status to "Mastered".
5. WHERE a vocabulary item is in "Mastered" status, THE User_Vocabulary_Progress SHALL schedule reviews at extended intervals (e.g., 30 days) to maintain retention.
6. WHEN the system updates next_review_date, THE User_Vocabulary_Progress SHALL calculate the new date as: next_review_date = today + interval_days.

### Requirement 3: Spaced Repetition Algorithm

**User Story:** As a learner, I want the system to intelligently schedule my vocabulary reviews based on my performance, so that I focus effort on words I find difficult and spend less time on words I know well.

#### Acceptance Criteria

1. WHEN a user grades a vocabulary item as "Hard", THE SRS_Algorithm SHALL set interval_days = 1 and ease_factor = max(1.3, ease_factor - 0.2).
2. WHEN a user grades a vocabulary item as "Good", THE SRS_Algorithm SHALL set interval_days = interval_days * ease_factor and ease_factor remains unchanged.
3. WHEN a user grades a vocabulary item as "Easy", THE SRS_Algorithm SHALL set interval_days = interval_days * ease_factor * 1.3 and ease_factor = ease_factor + 0.1.
4. WHEN a vocabulary item transitions to "Mastered" status, THE SRS_Algorithm SHALL set interval_days = 30 to schedule long-term retention reviews.
5. THE SRS_Algorithm SHALL ensure interval_days is always a positive integer rounded to the nearest whole number.
6. WHEN calculating next_review_date, THE SRS_Algorithm SHALL use the formula: next_review_date = today + interval_days.

### Requirement 4: Due Words Query and Indexing

**User Story:** As a learner, I want the system to quickly retrieve my vocabulary items due for review today, so that I can immediately start studying without delays.

#### Acceptance Criteria

1. WHEN the system queries for due words, THE Due_Words_Query SHALL retrieve all vocabulary items where next_review_date <= today AND user_id = [current_user].
2. THE Due_Words_Query SHALL execute in under 100ms for users with up to 5000 vocabulary items in progress.
3. THE User_Vocabulary_Progress table SHALL maintain a composite index on (user_id, next_review_date) to optimize the due words query.
4. WHEN a user has no due words, THE Due_Words_Query SHALL return an empty result set without error.
5. WHEN the system retrieves due words, THE Due_Words_Query SHALL return results sorted by next_review_date in ascending order (oldest due first).

### Requirement 5: Progress Dashboard - Global Metrics Display

**User Story:** As a learner, I want to see my overall learning progress at a glance, so that I understand my vocabulary mastery and stay motivated.

#### Acceptance Criteria

1. THE Progress_Dashboard SHALL display three global metrics: Total_Words_Unlocked, Words_In_Learning, and Words_Mastered.
2. WHEN the dashboard loads, THE Progress_Dashboard SHALL calculate Total_Words_Unlocked as the count of distinct vocabulary items where status != "New".
3. WHEN the dashboard loads, THE Progress_Dashboard SHALL calculate Words_In_Learning as the count of vocabulary items where status = "Learning".
4. WHEN the dashboard loads, THE Progress_Dashboard SHALL calculate Words_Mastered as the count of vocabulary items where status = "Mastered".
5. WHEN a user updates a vocabulary item's status, THE Progress_Dashboard SHALL refresh the affected metrics within 2 seconds.
6. THE Progress_Dashboard SHALL display metrics in a visually prominent section above the due words queue.

### Requirement 6: Progress Dashboard - Due Words Queue

**User Story:** As a learner, I want to see which vocabulary items are due for review today, so that I can prioritize my study session.

#### Acceptance Criteria

1. THE Due_Words_Queue SHALL display all vocabulary items where next_review_date <= today, sorted by next_review_date ascending.
2. FOR EACH item in the Due_Words_Queue, THE Queue SHALL display: English_Word, CEFR_Level, Unit, and days_overdue (calculated as today - next_review_date).
3. WHEN the queue contains more than 20 items, THE Due_Words_Queue SHALL paginate results with 20 items per page.
4. WHEN a user completes a review, THE Due_Words_Queue SHALL remove the item from the queue if next_review_date > today.
5. WHEN the queue is empty, THE Due_Words_Queue SHALL display a message: "No words due today. Great job staying on top of your reviews."
6. THE Due_Words_Queue SHALL refresh automatically every 30 seconds to reflect completed reviews.

### Requirement 7: Progress Dashboard - Primary Call-to-Action

**User Story:** As a learner, I want a clear, prominent button to start my daily review session, so that I can quickly transition from dashboard to active study.

#### Acceptance Criteria

1. THE Progress_Dashboard SHALL display a primary CTA button labeled "Grind Due Words" when due words exist.
2. WHEN a user clicks "Grind Due Words", THE Dashboard SHALL route the user to the Practice_Arena with the first due word loaded.
3. WHEN no due words exist, THE Progress_Dashboard SHALL display the CTA button in a disabled state with the label "No Words Due Today".
4. THE "Grind Due Words" button SHALL be visually prominent (e.g., contrasting color, larger size) to encourage engagement.
5. WHEN a user is on mobile, THE "Grind Due Words" button SHALL occupy at least 80% of the viewport width for easy one-handed interaction.

### Requirement 8: Lexicon Hub - Vocabulary Discovery Interface

**User Story:** As a learner, I want to browse and search the complete vocabulary list with filtering options, so that I can discover new words and review my progress across the curriculum.

#### Acceptance Criteria

1. THE Lexicon_Hub SHALL display a datatable with the following columns: English_Word, CEFR_Level, Unit, Mastery_Status, and Last_Reviewed_Date.
2. WHEN the Lexicon_Hub loads, THE Hub SHALL display all vocabulary entries from the Master_Lexicon with pagination (50 items per page by default).
3. WHEN a user enters a search term, THE Lexicon_Hub SHALL filter the datatable to show only entries where English_Word contains the search term (case-insensitive).
4. WHERE a user selects a CEFR_Level filter, THE Lexicon_Hub SHALL display only entries matching the selected level(s).
5. WHERE a user selects a Unit filter, THE Lexicon_Hub SHALL display only entries matching the selected unit(s).
6. WHERE a user selects a Mastery_Status filter, THE Lexicon_Hub SHALL display only entries with status "New", "Learning", or "Mastered".
7. WHEN a user applies multiple filters, THE Lexicon_Hub SHALL apply all filters in conjunction (AND logic).
8. WHEN a user clicks on a vocabulary entry in the Lexicon_Hub, THE Hub SHALL display a detail panel showing: English_Word, Definition, Example_Sentence, CEFR_Level, Unit, Audio_URL, L1_Notes, and current Mastery_Status.
9. WHEN a user clicks "Start Learning" on a detail panel, THE Hub SHALL initialize the vocabulary item in User_Vocabulary_Progress (if not already present) and route to the Practice_Arena.

### Requirement 9: Practice Arena - Cloze Flashcard Presentation

**User Story:** As a learner, I want to see vocabulary in contextual cloze sentences during practice, so that I learn words in realistic usage patterns rather than in isolation.

#### Acceptance Criteria

1. THE Practice_Arena SHALL display a cloze sentence with a blank space where the target vocabulary word should be filled in.
2. WHEN the Practice_Arena loads a vocabulary item, THE Arena SHALL retrieve the Example_Sentence from the Master_Lexicon and replace the target word with a blank (e.g., "I _____ breakfast at 7 AM").
3. THE Practice_Arena SHALL display the cloze sentence in a large, readable font (minimum 18px on mobile, 24px on desktop).
4. WHEN a user views a cloze flashcard, THE Practice_Arena SHALL NOT display the English_Word, Definition, or L1_Notes until the user explicitly requests a reveal.
5. THE Practice_Arena SHALL display a "Reveal" button below the cloze sentence to show the English_Word, Definition, and L1_Notes on demand.
6. WHEN a user clicks "Reveal", THE Practice_Arena SHALL display the English_Word, Definition, and L1_Notes in a visually distinct section below the cloze sentence.
7. WHERE a vocabulary item includes L1_Notes, THE Practice_Arena SHALL display the notes prominently after the English_Word and Definition to highlight interference patterns.

### Requirement 10: Practice Arena - Audio Playback

**User Story:** As a learner, I want to hear the pronunciation of vocabulary words during practice, so that I develop accurate listening and speaking skills.

#### Acceptance Criteria

1. THE Practice_Arena SHALL display an audio playback button next to the English_Word after the user clicks "Reveal".
2. WHEN a user clicks the audio button, THE Practice_Arena SHALL play the audio file from Audio_URL without requiring additional loading time.
3. THE Practice_Arena SHALL pre-fetch audio files for the next 3 vocabulary items in the queue to minimize playback latency.
4. WHEN audio playback completes, THE Practice_Arena SHALL remain on the current flashcard without advancing automatically.
5. IF an audio file fails to load, THE Practice_Arena SHALL display an error message: "Audio unavailable for this word" and allow the user to continue without audio.
6. WHEN a user is on mobile, THE audio button SHALL be large enough for one-handed interaction (minimum 44px diameter).

### Requirement 11: Practice Arena - Grading Interface

**User Story:** As a learner, I want to self-assess my recall difficulty after viewing a word, so that the system can adjust my review schedule based on my actual performance.

#### Acceptance Criteria

1. THE Practice_Arena SHALL display three grading buttons after the user clicks "Reveal": "Hard", "Good", and "Easy".
2. WHEN a user clicks a grading button, THE Practice_Arena SHALL record the grade and update the User_Vocabulary_Progress entry with the new ease_factor, interval_days, and next_review_date.
3. WHEN a user clicks a grading button, THE Practice_Arena SHALL advance to the next due word in the queue.
4. WHEN a user grades a word as "Hard", THE Practice_Arena SHALL display a message: "Keep practicing this word. It will appear again soon."
5. WHEN a user grades a word as "Good", THE Practice_Arena SHALL display a message: "Nice work. You'll see this word again in a few days."
6. WHEN a user grades a word as "Easy", THE Practice_Arena SHALL display a message: "Excellent. You've mastered this word."
7. WHEN all due words have been graded, THE Practice_Arena SHALL display a completion screen with session statistics: Total_Words_Reviewed, Average_Ease_Factor, and Words_Mastered_Today.
8. WHEN a user is on mobile, THE grading buttons SHALL be arranged horizontally and occupy at least 80% of the viewport width for easy one-handed interaction.

### Requirement 12: Practice Arena - Session Persistence

**User Story:** As a learner, I want my progress to be saved automatically during a study session, so that I don't lose my work if I close the app or lose connection.

#### Acceptance Criteria

1. WHEN a user grades a vocabulary item, THE Practice_Arena SHALL persist the grade to the database within 1 second.
2. IF the user closes the Practice_Arena before completing all due words, THE Practice_Arena SHALL save the current progress and allow the user to resume from the next ungraded word.
3. WHEN a user resumes a session, THE Practice_Arena SHALL display the first ungraded due word from the previous session.
4. IF a network error occurs during grade persistence, THE Practice_Arena SHALL queue the grade locally and retry persistence when connectivity is restored.
5. WHEN connectivity is restored, THE Practice_Arena SHALL persist all queued grades in the order they were recorded.

### Requirement 13: Mobile Responsiveness - One-Handed Interaction

**User Story:** As a mobile learner, I want the Practice Arena to be optimized for one-handed use, so that I can study comfortably while commuting or multitasking.

#### Acceptance Criteria

1. WHEN the Practice_Arena is displayed on a mobile device (viewport width < 768px), THE Arena SHALL arrange all interactive elements (Reveal button, grading buttons, audio button) in a single column layout.
2. WHEN the Practice_Arena is displayed on mobile, THE Arena SHALL ensure all buttons have a minimum touch target size of 44px x 44px.
3. WHEN the Practice_Arena is displayed on mobile, THE Arena SHALL position the cloze sentence and Reveal button in the upper half of the viewport to minimize scrolling.
4. WHEN the Practice_Arena is displayed on mobile, THE Arena SHALL position the grading buttons in the lower half of the viewport for thumb-friendly access.
5. WHEN the Practice_Arena is displayed on mobile, THE Arena SHALL use a font size of at least 18px for the cloze sentence to ensure readability.
6. WHEN the Practice_Arena is displayed on mobile, THE Arena SHALL hide non-essential UI elements (e.g., session statistics) until the user explicitly requests them.

### Requirement 14: Audio Caching and Pre-fetching

**User Story:** As a learner, I want audio files to load seamlessly during practice, so that I experience no delays or interruptions during my study session.

#### Acceptance Criteria

1. WHEN a user enters the Practice_Arena, THE Audio_Cache SHALL pre-fetch audio files for the current due word and the next 3 words in the queue.
2. WHEN a user clicks the audio button, THE Audio_Cache SHALL play the audio from the local cache without requiring a network request.
3. WHEN an audio file is pre-fetched, THE Audio_Cache SHALL store it in the browser's local storage or service worker cache for the duration of the session.
4. WHEN a user completes a study session, THE Audio_Cache SHALL clear cached audio files to free up storage space.
5. IF an audio file fails to pre-fetch, THE Audio_Cache SHALL log the error and continue pre-fetching subsequent files without blocking the user.
6. WHEN a user is on a slow network (< 2 Mbps), THE Audio_Cache SHALL prioritize pre-fetching the current word's audio before subsequent words.

### Requirement 15: L1 Interference Anticipation - Dynamic L1 Notes Display

**User Story:** As a learner, I want to see targeted notes about Brazilian Portuguese interference patterns, so that I can avoid common mistakes and build accurate mental models.

#### Acceptance Criteria

1. WHERE a vocabulary item includes L1_Notes, THE Practice_Arena SHALL display the notes prominently after the user clicks "Reveal".
2. WHEN a user grades a vocabulary item as "Hard", THE Practice_Arena SHALL highlight the L1_Notes section with a visual indicator (e.g., border, background color) to draw attention to the interference pattern.
3. WHEN a user grades a vocabulary item as "Hard" twice consecutively, THE Practice_Arena SHALL increase the prominence of L1_Notes on the next review (e.g., larger font, additional emphasis).
4. THE L1_Notes SHALL be structured to clearly distinguish the interference pattern (e.g., "make vs. do: Use 'make' for creating or producing; use 'do' for actions or tasks").
5. WHEN a vocabulary item does not include L1_Notes, THE Practice_Arena SHALL not display an empty L1_Notes section.

### Requirement 16: User Authentication and Profile Integration

**User Story:** As a user, I want my vocabulary progress to be securely associated with my account, so that my learning data is private and persists across devices.

#### Acceptance Criteria

1. WHEN a user logs in, THE System SHALL retrieve their User_Profile and load their associated User_Vocabulary_Progress entries.
2. WHEN a user logs out, THE System SHALL clear all session data and require re-authentication to access their progress.
3. WHEN a user accesses the Active_Lexicon_Engine from a different device, THE System SHALL display the same progress and due words as their previous session.
4. THE System SHALL encrypt all User_Vocabulary_Progress data at rest and in transit.
5. WHEN a user updates their vocabulary progress, THE System SHALL log the update with a timestamp for audit purposes.

### Requirement 17: Performance Optimization - Dashboard Load Time

**User Story:** As a learner, I want the Progress Dashboard to load quickly, so that I can immediately see my metrics and start studying without delays.

#### Acceptance Criteria

1. WHEN the Progress_Dashboard loads, THE Dashboard SHALL display global metrics within 500ms.
2. WHEN the Progress_Dashboard loads, THE Dashboard SHALL display the due words queue within 1 second.
3. THE Progress_Dashboard SHALL cache global metrics for up to 30 seconds to reduce database queries.
4. WHEN a user updates a vocabulary item's status, THE Dashboard SHALL invalidate the cache and refresh metrics within 2 seconds.
5. THE Progress_Dashboard SHALL use lazy loading for the due words queue to display the first 20 items immediately and load additional items on demand.

### Requirement 18: Data Consistency and Integrity

**User Story:** As a system administrator, I want to ensure that vocabulary progress data remains consistent and accurate, so that users receive reliable review schedules and metrics.

#### Acceptance Criteria

1. WHEN a user grades a vocabulary item, THE System SHALL use database transactions to ensure that ease_factor, interval_days, next_review_date, total_reviews, and consecutive_correct are updated atomically.
2. IF a transaction fails, THE System SHALL roll back all changes and retry the operation up to 3 times before reporting an error to the user.
3. WHEN a vocabulary item transitions to "Mastered" status, THE System SHALL verify that consecutive_correct >= 3 before allowing the transition.
4. WHEN the system calculates next_review_date, THE System SHALL use UTC time to ensure consistency across time zones.
5. THE System SHALL validate all user input (grades, search terms, filters) to prevent SQL injection and data corruption.

### Requirement 19: Vocabulary Item Initialization

**User Story:** As a learner, I want new vocabulary items to be properly initialized when I first encounter them, so that my review schedule starts correctly.

#### Acceptance Criteria

1. WHEN a user clicks "Start Learning" on a vocabulary item in the Lexicon_Hub, THE System SHALL check if the item exists in User_Vocabulary_Progress.
2. IF the item does not exist in User_Vocabulary_Progress, THE System SHALL create a new entry with: status="New", ease_factor=2.5, interval_days=1, next_review_date=today, total_reviews=0, consecutive_correct=0.
3. IF the item already exists in User_Vocabulary_Progress, THE System SHALL load the existing entry without creating a duplicate.
4. WHEN a new vocabulary item is initialized, THE System SHALL immediately route the user to the Practice_Arena to begin the first review.

### Requirement 20: Mastery Transition and Long-Term Retention

**User Story:** As a learner, I want vocabulary items to transition to "Mastered" status when I've demonstrated consistent recall, so that I can focus on new words while maintaining long-term retention.

#### Acceptance Criteria

1. WHEN a vocabulary item reaches consecutive_correct = 3, THE System SHALL transition the status to "Mastered".
2. WHEN a vocabulary item transitions to "Mastered", THE System SHALL set interval_days = 30 to schedule long-term retention reviews.
3. WHEN a user grades a "Mastered" item as "Hard", THE System SHALL transition the status back to "Learning" and reset consecutive_correct = 0.
4. WHEN a user grades a "Mastered" item as "Good" or "Easy", THE System SHALL maintain the "Mastered" status and update interval_days accordingly.
5. WHEN a vocabulary item is in "Mastered" status, THE System SHALL display a visual indicator (e.g., checkmark, badge) in the Lexicon_Hub and Practice_Arena.

### Requirement 21: Parser and Serializer - Cloze Sentence Generation

**User Story:** As a system, I want to reliably parse vocabulary entries and generate cloze sentences, so that flashcards are correctly formatted and consistent.

#### Acceptance Criteria

1. THE Cloze_Parser SHALL parse Example_Sentence entries to identify the target vocabulary word and replace it with a blank (___).
2. WHEN the Cloze_Parser processes an Example_Sentence, THE Parser SHALL handle edge cases: multiple occurrences of the target word (replace only the first), punctuation attached to the word, and capitalization variations.
3. THE Cloze_Serializer SHALL format cloze sentences back into complete sentences with the target word restored for display and verification.
4. FOR ALL valid Example_Sentence entries, parsing then serializing then parsing SHALL produce an equivalent cloze sentence (round-trip property).
5. WHEN the Cloze_Parser encounters an invalid Example_Sentence (e.g., missing target word), THE Parser SHALL return a descriptive error: "Target word not found in example sentence".

### Requirement 22: Parser and Serializer - L1 Notes Formatting

**User Story:** As a system, I want to reliably parse and format L1 Notes, so that interference patterns are clearly communicated to learners.

#### Acceptance Criteria

1. THE L1_Notes_Parser SHALL parse structured L1_Notes entries to extract the interference pattern and explanation.
2. WHEN the L1_Notes_Parser processes an L1_Notes entry, THE Parser SHALL validate the format: "term1 vs. term2: explanation".
3. THE L1_Notes_Serializer SHALL format parsed L1_Notes back into human-readable text for display in the Practice_Arena.
4. FOR ALL valid L1_Notes entries, parsing then serializing then parsing SHALL produce an equivalent L1_Notes entry (round-trip property).
5. WHEN the L1_Notes_Parser encounters an invalid L1_Notes entry (e.g., missing colon separator), THE Parser SHALL return a descriptive error: "Invalid L1_Notes format. Expected 'term1 vs. term2: explanation'".

### Requirement 23: Accessibility - Keyboard Navigation

**User Story:** As a user with mobility limitations, I want to navigate the Active Lexicon Engine using only the keyboard, so that I can study independently without a mouse.

#### Acceptance Criteria

1. WHEN a user presses Tab, THE System SHALL cycle through all interactive elements (buttons, input fields, links) in a logical order.
2. WHEN a user presses Enter on a focused button, THE System SHALL trigger the button's action.
3. WHEN a user presses Escape, THE System SHALL close any open modals or detail panels and return to the previous view.
4. WHEN a user is in the Practice_Arena, THE System SHALL allow grading using keyboard shortcuts: "H" for Hard, "G" for Good, "E" for Easy.
5. WHEN a user is in the Lexicon_Hub, THE System SHALL allow filtering using keyboard shortcuts: "S" to focus the search field, "F" to open the filter panel.

### Requirement 24: Accessibility - Screen Reader Support

**User Story:** As a blind user, I want the Active Lexicon Engine to be fully compatible with screen readers, so that I can access all features independently.

#### Acceptance Criteria

1. WHEN a screen reader encounters the Practice_Arena, THE Arena SHALL announce: "Cloze flashcard. Fill in the blank: [cloze sentence]".
2. WHEN a screen reader encounters the Reveal button, THE Button SHALL announce: "Reveal. Button. Activates to show the English word, definition, and L1 notes".
3. WHEN a screen reader encounters the grading buttons, THE Buttons SHALL announce: "Hard button", "Good button", "Easy button" with clear descriptions of their effects.
4. WHEN a screen reader encounters the Lexicon_Hub datatable, THE Table SHALL announce: "Vocabulary table with columns: English Word, CEFR Level, Unit, Mastery Status, Last Reviewed Date".
5. WHEN a screen reader encounters the Progress_Dashboard metrics, THE Metrics SHALL announce: "Total Words Unlocked: [number]. Words in Learning: [number]. Words Mastered: [number]".

### Requirement 25: Error Handling and User Feedback

**User Story:** As a learner, I want clear error messages and feedback when something goes wrong, so that I can understand what happened and how to proceed.

#### Acceptance Criteria

1. WHEN a database query fails, THE System SHALL display a user-friendly error message: "We encountered an issue loading your data. Please try again in a moment."
2. WHEN a network request times out, THE System SHALL display a message: "Connection lost. Your progress has been saved. Please check your internet connection."
3. WHEN a user attempts to grade a vocabulary item but the update fails, THE System SHALL queue the grade locally and display: "Saving your progress. This will sync when your connection is restored."
4. WHEN a user attempts to perform an action without proper authentication, THE System SHALL redirect to the login page with a message: "Your session has expired. Please log in again."
5. WHEN the system encounters an unexpected error, THE System SHALL log the error with a unique error ID and display: "An unexpected error occurred (Error ID: [ID]). Please contact support if this persists."

