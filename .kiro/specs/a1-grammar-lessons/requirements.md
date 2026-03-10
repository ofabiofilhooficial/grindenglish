# Requirements Document

## Introduction

This feature adds 24 A1-level grammar lessons to the website's grammar reference section. The lessons follow the same pedagogical structure as the existing 12 A0 lessons and cover essential grammar topics for elementary English learners. Each lesson includes comprehensive content across multiple sections: functional goals, form, meaning, use, contrast, common learner problems, task language upgrades, micro-practice exercises, and cross-references to related lessons.

## Glossary

- **Grammar_Reference_System**: The website's grammar chapter database and UI that displays grammar lessons to learners
- **Grammar_Chapter**: A single grammar lesson entry in the grammar_chapters database table
- **Content_Creator**: A user with permissions to create and edit grammar content
- **CEFR_Level**: Common European Framework of Reference level (A0, A1, A2, B1, B2, C1, C2)
- **Chapter_Code**: Unique identifier for grammar lessons following the pattern [CEFR].[G].[Number] (e.g., A1.G.01)
- **Micro_Practice**: Short exercises embedded within grammar chapters for immediate practice
- **Cross_Link**: Reference to prerequisite or related grammar chapters
- **Database_Migration**: SQL script that modifies the database schema or data

## Requirements

### Requirement 1: Store A1 Grammar Lesson Content

**User Story:** As a content creator, I want to store 24 A1 grammar lessons in the database, so that learners can access comprehensive A1-level grammar reference material.

#### Acceptance Criteria

1. THE Grammar_Reference_System SHALL store 24 new Grammar_Chapters with cefr_level 'A1'
2. THE Grammar_Reference_System SHALL assign unique Chapter_Codes from 'A1.G.01' through 'A1.G.24' to each lesson
3. WHEN storing A1 Grammar_Chapters, THE Grammar_Reference_System SHALL populate all required fields: chapter_code, title, cefr_level, form_content, meaning_content, use_content, is_published, and sort_order
4. THE Grammar_Reference_System SHALL store optional fields when provided: contrast_notes, common_errors, diagnostic_hook, task_upgrades, micro_practice, and cross_links
5. THE Grammar_Reference_System SHALL maintain sort_order values from 1 to 24 corresponding to the chapter sequence

### Requirement 2: Preserve Existing A0 Grammar Content

**User Story:** As a learner, I want the existing A0 grammar lessons to remain accessible, so that I can continue using foundational grammar reference material.

#### Acceptance Criteria

1. WHEN adding A1 Grammar_Chapters, THE Grammar_Reference_System SHALL preserve all existing A0 Grammar_Chapters
2. THE Grammar_Reference_System SHALL maintain distinct sort_order sequences for A0 and A1 lessons
3. THE Grammar_Reference_System SHALL prevent Chapter_Code conflicts between A0 and A1 lessons

### Requirement 3: Support Comprehensive Grammar Lesson Structure

**User Story:** As a learner, I want each grammar lesson to include multiple pedagogical sections, so that I can understand grammar from different angles.

#### Acceptance Criteria

1. THE Grammar_Reference_System SHALL store form_content describing how to construct the grammar structure
2. THE Grammar_Reference_System SHALL store meaning_content explaining what the grammar structure means
3. THE Grammar_Reference_System SHALL store use_content describing when to use the grammar structure
4. THE Grammar_Reference_System SHALL store contrast_notes comparing the structure with competing alternatives
5. THE Grammar_Reference_System SHALL store common_errors documenting typical learner mistakes and corrections
6. THE Grammar_Reference_System SHALL store diagnostic_hook providing scenario-based learning challenges
7. THE Grammar_Reference_System SHALL store task_upgrades showing basic versus professional language usage
8. THE Grammar_Reference_System SHALL store micro_practice as JSONB containing practice exercises
9. THE Grammar_Reference_System SHALL store cross_links as JSONB containing references to prerequisite and related lessons

### Requirement 4: Implement A1 Grammar Topics Coverage

**User Story:** As a curriculum designer, I want the A1 grammar lessons to cover essential elementary grammar topics, so that learners have comprehensive A1-level grammar support.

#### Acceptance Criteria

1. THE Grammar_Reference_System SHALL include Grammar_Chapters for simple present tense (affirmative, negative, questions)
2. THE Grammar_Reference_System SHALL include Grammar_Chapters for possessive structures (possessive 's, possessive pronouns)
3. THE Grammar_Reference_System SHALL include Grammar_Chapters for object pronouns
4. THE Grammar_Reference_System SHALL include Grammar_Chapters for count and noncount nouns with quantifiers
5. THE Grammar_Reference_System SHALL include Grammar_Chapters for present continuous tense
6. THE Grammar_Reference_System SHALL include Grammar_Chapters for past tense (regular and irregular verbs)
7. THE Grammar_Reference_System SHALL include Grammar_Chapters for future tenses (going to, will)
8. THE Grammar_Reference_System SHALL include Grammar_Chapters for comparative and superlative adjectives
9. THE Grammar_Reference_System SHALL include Grammar_Chapters for modal verbs (must, have to, should, would like)
10. THE Grammar_Reference_System SHALL include Grammar_Chapters for prepositions (time, movement)
11. THE Grammar_Reference_System SHALL include Grammar_Chapters for adverbs of frequency and manner
12. THE Grammar_Reference_System SHALL include Grammar_Chapters for question formation (how much/many, whose)

### Requirement 5: Enable Grammar Lesson Publishing Control

**User Story:** As a content creator, I want to control which grammar lessons are visible to learners, so that I can review content before making it public.

#### Acceptance Criteria

1. THE Grammar_Reference_System SHALL support an is_published boolean flag for each Grammar_Chapter
2. WHEN is_published is true, THE Grammar_Reference_System SHALL make the Grammar_Chapter visible to authenticated learners
3. WHEN is_published is false, THE Grammar_Reference_System SHALL restrict Grammar_Chapter visibility to Content_Creators only
4. THE Grammar_Reference_System SHALL allow Content_Creators to modify the is_published status

### Requirement 6: Maintain Database Schema Compatibility

**User Story:** As a developer, I want the A1 grammar lessons to use the existing database schema, so that no schema changes are required.

#### Acceptance Criteria

1. THE Grammar_Reference_System SHALL store A1 Grammar_Chapters using the existing grammar_chapters table structure
2. THE Grammar_Reference_System SHALL utilize existing columns without requiring schema modifications
3. THE Grammar_Reference_System SHALL maintain compatibility with existing Row Level Security policies
4. THE Grammar_Reference_System SHALL maintain compatibility with existing database triggers and indexes

### Requirement 7: Support Grammar Lesson Cross-Referencing

**User Story:** As a learner, I want to see connections between related grammar topics, so that I can understand how grammar concepts build on each other.

#### Acceptance Criteria

1. THE Grammar_Reference_System SHALL store cross_links as JSONB arrays containing prerequisite Chapter_Codes
2. THE Grammar_Reference_System SHALL store cross_links containing related Chapter_Codes for further study
3. WHEN displaying a Grammar_Chapter, THE Grammar_Reference_System SHALL resolve cross_links to display linked lesson titles
4. THE Grammar_Reference_System SHALL support cross_links referencing both A0 and A1 Grammar_Chapters

### Requirement 8: Implement Database Migration for A1 Content

**User Story:** As a developer, I want a database migration script to add A1 grammar lessons, so that the content can be deployed consistently across environments.

#### Acceptance Criteria

1. THE Grammar_Reference_System SHALL provide a Database_Migration script that inserts all 24 A1 Grammar_Chapters
2. THE Database_Migration SHALL use INSERT statements with explicit column specifications
3. THE Database_Migration SHALL set is_published to true for all A1 Grammar_Chapters
4. THE Database_Migration SHALL be idempotent by checking for existing Chapter_Codes before insertion
5. IF a Chapter_Code already exists, THEN THE Database_Migration SHALL skip that insertion without error

### Requirement 9: Support Micro-Practice Exercise Storage

**User Story:** As a learner, I want grammar lessons to include practice exercises, so that I can immediately apply what I learned.

#### Acceptance Criteria

1. THE Grammar_Reference_System SHALL store micro_practice as JSONB containing exercise data
2. THE Grammar_Reference_System SHALL support multiple exercise types within micro_practice
3. THE Grammar_Reference_System SHALL preserve exercise structure including prompts, answers, and feedback
4. WHEN micro_practice is empty or null, THE Grammar_Reference_System SHALL display the Grammar_Chapter without exercises

### Requirement 10: Maintain Consistent Lesson Numbering

**User Story:** As a curriculum designer, I want grammar lessons to follow a logical sequence, so that learners can progress through topics in a pedagogically sound order.

#### Acceptance Criteria

1. THE Grammar_Reference_System SHALL enforce unique Chapter_Codes within each CEFR_Level
2. THE Grammar_Reference_System SHALL maintain sort_order values that match the Chapter_Code sequence
3. WHEN displaying Grammar_Chapters, THE Grammar_Reference_System SHALL order them by sort_order within each CEFR_Level
4. THE Grammar_Reference_System SHALL prevent duplicate sort_order values within the same CEFR_Level
