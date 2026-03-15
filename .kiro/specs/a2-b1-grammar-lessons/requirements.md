# Requirements Document

## Introduction

This feature adds 60 grammar lessons (28 A2-level and 32 B1-level) to the website's grammar reference section. The lessons follow the same pedagogical structure as the existing A0 and A1 lessons and cover intermediate grammar topics for English learners. Each lesson includes comprehensive content across nine sections: functional goals, form, meaning, use, contrast, common learner problems, task language upgrades, micro-practice exercises, and cross-references to related lessons. The source content is documented in docs/philosophy/complete-efl-grammar-theory.md.

## Glossary

- **Grammar_Reference_System**: The website's grammar chapter database and UI that displays grammar lessons to learners
- **Grammar_Chapter**: A single grammar lesson entry in the grammar_chapters database table
- **Content_Creator**: A user with permissions to create and edit grammar content
- **CEFR_Level**: Common European Framework of Reference level (A0, A1, A2, B1, B2, C1, C2)
- **Chapter_Code**: Unique identifier for grammar lessons following the pattern [CEFR].[G].[Number] (e.g., A2.G.01)
- **Micro_Practice**: Short exercises embedded within grammar chapters for immediate practice
- **Cross_Link**: Reference to prerequisite or related grammar chapters
- **Database_Migration**: SQL script that modifies the database schema or data
- **Source_Document**: The file docs/philosophy/complete-efl-grammar-theory.md containing all grammar lesson content

## Requirements

### Requirement 1: Store A2 Grammar Lesson Content

**User Story:** As a content creator, I want to store 28 A2 grammar lessons in the database, so that learners can access comprehensive A2-level grammar reference material.

#### Acceptance Criteria

1. THE Grammar_Reference_System SHALL store 28 new Grammar_Chapters with cefr_level 'A2'
2. THE Grammar_Reference_System SHALL assign unique Chapter_Codes from 'A2.G.01' through 'A2.G.28' to each lesson
3. WHEN storing A2 Grammar_Chapters, THE Grammar_Reference_System SHALL populate all required fields: chapter_code, title, cefr_level, form_content, meaning_content, use_content, is_published, and sort_order
4. THE Grammar_Reference_System SHALL store optional fields when provided: contrast_notes, common_errors, diagnostic_hook, task_upgrades, micro_practice, and cross_links
5. THE Grammar_Reference_System SHALL maintain sort_order values from 1 to 28 corresponding to the A2 chapter sequence

### Requirement 2: Store B1 Grammar Lesson Content

**User Story:** As a content creator, I want to store 32 B1 grammar lessons in the database, so that learners can access comprehensive B1-level grammar reference material.

#### Acceptance Criteria

1. THE Grammar_Reference_System SHALL store 32 new Grammar_Chapters with cefr_level 'B1'
2. THE Grammar_Reference_System SHALL assign unique Chapter_Codes from 'B1.G.01' through 'B1.G.32' to each lesson
3. WHEN storing B1 Grammar_Chapters, THE Grammar_Reference_System SHALL populate all required fields: chapter_code, title, cefr_level, form_content, meaning_content, use_content, is_published, and sort_order
4. THE Grammar_Reference_System SHALL store optional fields when provided: contrast_notes, common_errors, diagnostic_hook, task_upgrades, micro_practice, and cross_links
5. THE Grammar_Reference_System SHALL maintain sort_order values from 1 to 32 corresponding to the B1 chapter sequence

### Requirement 3: Preserve Existing Grammar Content

**User Story:** As a learner, I want the existing A0 and A1 grammar lessons to remain accessible, so that I can continue using foundational grammar reference material.

#### Acceptance Criteria

1. WHEN adding A2 and B1 Grammar_Chapters, THE Grammar_Reference_System SHALL preserve all existing A0 and A1 Grammar_Chapters
2. THE Grammar_Reference_System SHALL maintain distinct sort_order sequences for A0, A1, A2, and B1 lessons
3. THE Grammar_Reference_System SHALL prevent Chapter_Code conflicts across all CEFR levels

### Requirement 4: Support Comprehensive Grammar Lesson Structure

**User Story:** As a learner, I want each grammar lesson to include nine pedagogical sections, so that I can understand grammar from multiple perspectives.

#### Acceptance Criteria

1. THE Grammar_Reference_System SHALL store diagnostic_hook providing functional goals describing what learners can do with the grammar
2. THE Grammar_Reference_System SHALL store form_content describing how to construct the grammar structure
3. THE Grammar_Reference_System SHALL store meaning_content explaining what the grammar structure means
4. THE Grammar_Reference_System SHALL store use_content describing when to use the grammar structure
5. THE Grammar_Reference_System SHALL store contrast_notes comparing the structure with competing alternatives
6. THE Grammar_Reference_System SHALL store common_errors documenting typical learner mistakes and corrections
7. THE Grammar_Reference_System SHALL store task_upgrades showing basic versus professional language usage
8. THE Grammar_Reference_System SHALL store micro_practice as JSONB containing practice exercises
9. THE Grammar_Reference_System SHALL store cross_links as JSONB containing references to prerequisite and related lessons

### Requirement 5: Implement A2 Grammar Topics Coverage

**User Story:** As a curriculum designer, I want the A2 grammar lessons to cover essential pre-intermediate grammar topics, so that learners have comprehensive A2-level grammar support.

#### Acceptance Criteria

1. THE Grammar_Reference_System SHALL include Grammar_Chapters for past tenses (irregular verbs, past continuous)
2. THE Grammar_Reference_System SHALL include Grammar_Chapters for present perfect (life experience and recent events)
3. THE Grammar_Reference_System SHALL include Grammar_Chapters for future forms review
4. THE Grammar_Reference_System SHALL include Grammar_Chapters for expanded modals (obligation, permission, deduction)
5. THE Grammar_Reference_System SHALL include Grammar_Chapters for conditionals (first, zero, second)
6. THE Grammar_Reference_System SHALL include Grammar_Chapters for gerunds versus infinitives
7. THE Grammar_Reference_System SHALL include Grammar_Chapters for expanded articles and quantifiers
8. THE Grammar_Reference_System SHALL include Grammar_Chapters for passive voice introduction
9. THE Grammar_Reference_System SHALL include Grammar_Chapters for relative clauses introduction
10. THE Grammar_Reference_System SHALL include Grammar_Chapters for reported speech basics

### Requirement 6: Implement B1 Grammar Topics Coverage

**User Story:** As a curriculum designer, I want the B1 grammar lessons to cover intermediate grammar topics, so that learners have comprehensive B1-level grammar support.

#### Acceptance Criteria

1. THE Grammar_Reference_System SHALL include Grammar_Chapters for present perfect versus past simple distinction
2. THE Grammar_Reference_System SHALL include Grammar_Chapters for present perfect continuous
3. THE Grammar_Reference_System SHALL include Grammar_Chapters for narrative tenses
4. THE Grammar_Reference_System SHALL include Grammar_Chapters for future continuous and future perfect
5. THE Grammar_Reference_System SHALL include Grammar_Chapters for expanded passive voice
6. THE Grammar_Reference_System SHALL include Grammar_Chapters for expanded conditionals and mixed conditionals
7. THE Grammar_Reference_System SHALL include Grammar_Chapters for expanded modals (advice, deduction, speculation)
8. THE Grammar_Reference_System SHALL include Grammar_Chapters for expanded gerunds and infinitives
9. THE Grammar_Reference_System SHALL include Grammar_Chapters for expanded relative clauses
10. THE Grammar_Reference_System SHALL include Grammar_Chapters for expanded reported speech

### Requirement 7: Enable Grammar Lesson Publishing Control

**User Story:** As a content creator, I want to control which grammar lessons are visible to learners, so that I can review content before making it public.

#### Acceptance Criteria

1. THE Grammar_Reference_System SHALL support an is_published boolean flag for each Grammar_Chapter
2. WHEN is_published is true, THE Grammar_Reference_System SHALL make the Grammar_Chapter visible to authenticated learners
3. WHEN is_published is false, THE Grammar_Reference_System SHALL restrict Grammar_Chapter visibility to Content_Creators only
4. THE Grammar_Reference_System SHALL allow Content_Creators to modify the is_published status

### Requirement 8: Maintain Database Schema Compatibility

**User Story:** As a developer, I want the A2 and B1 grammar lessons to use the existing database schema, so that no schema changes are required.

#### Acceptance Criteria

1. THE Grammar_Reference_System SHALL store A2 and B1 Grammar_Chapters using the existing grammar_chapters table structure
2. THE Grammar_Reference_System SHALL utilize existing columns without requiring schema modifications
3. THE Grammar_Reference_System SHALL maintain compatibility with existing Row Level Security policies
4. THE Grammar_Reference_System SHALL maintain compatibility with existing database triggers and indexes

### Requirement 9: Support Grammar Lesson Cross-Referencing

**User Story:** As a learner, I want to see connections between related grammar topics, so that I can understand how grammar concepts build on each other.

#### Acceptance Criteria

1. THE Grammar_Reference_System SHALL store cross_links as JSONB arrays containing prerequisite Chapter_Codes
2. THE Grammar_Reference_System SHALL store cross_links containing related Chapter_Codes for further study
3. WHEN displaying a Grammar_Chapter, THE Grammar_Reference_System SHALL resolve cross_links to display linked lesson titles
4. THE Grammar_Reference_System SHALL support cross_links referencing A0, A1, A2, and B1 Grammar_Chapters
5. THE Grammar_Reference_System SHALL support cross_links referencing future B2 and C1 Grammar_Chapters

### Requirement 10: Implement Database Migration for A2 and B1 Content

**User Story:** As a developer, I want database migration scripts to add A2 and B1 grammar lessons, so that the content can be deployed consistently across environments.

#### Acceptance Criteria

1. THE Grammar_Reference_System SHALL provide Database_Migration scripts that insert all 28 A2 Grammar_Chapters
2. THE Grammar_Reference_System SHALL provide Database_Migration scripts that insert all 32 B1 Grammar_Chapters
3. THE Database_Migration SHALL use INSERT statements with explicit column specifications
4. THE Database_Migration SHALL set is_published to true for all A2 and B1 Grammar_Chapters
5. THE Database_Migration SHALL be idempotent by checking for existing Chapter_Codes before insertion
6. IF a Chapter_Code already exists, THEN THE Database_Migration SHALL skip that insertion without error

### Requirement 11: Support Micro-Practice Exercise Storage

**User Story:** As a learner, I want grammar lessons to include practice exercises, so that I can immediately apply what I learned.

#### Acceptance Criteria

1. THE Grammar_Reference_System SHALL store micro_practice as JSONB containing exercise data
2. THE Grammar_Reference_System SHALL support multiple exercise types within micro_practice including fill_blank, multiple_choice, and mini_output prompts
3. THE Grammar_Reference_System SHALL preserve exercise structure including prompts, answers, and feedback
4. WHEN micro_practice is empty or null, THE Grammar_Reference_System SHALL display the Grammar_Chapter without exercises

### Requirement 12: Maintain Consistent Lesson Numbering

**User Story:** As a curriculum designer, I want grammar lessons to follow a logical sequence, so that learners can progress through topics in a pedagogically sound order.

#### Acceptance Criteria

1. THE Grammar_Reference_System SHALL enforce unique Chapter_Codes within each CEFR_Level
2. THE Grammar_Reference_System SHALL maintain sort_order values that match the Chapter_Code sequence
3. WHEN displaying Grammar_Chapters, THE Grammar_Reference_System SHALL order them by sort_order within each CEFR_Level
4. THE Grammar_Reference_System SHALL prevent duplicate sort_order values within the same CEFR_Level

### Requirement 13: Extract Content from Source Document

**User Story:** As a developer, I want to extract grammar lesson content from the source document, so that I can populate the database with accurate lesson data.

#### Acceptance Criteria

1. THE Grammar_Reference_System SHALL extract content from Source_Document for all A2 lessons (A2.G.01 through A2.G.28)
2. THE Grammar_Reference_System SHALL extract content from Source_Document for all B1 lessons (B1.G.01 through B1.G.32)
3. THE Grammar_Reference_System SHALL map the nine sections from Source_Document to corresponding database columns
4. THE Grammar_Reference_System SHALL preserve formatting including tables, lists, and examples from Source_Document
5. THE Grammar_Reference_System SHALL convert micro-practice exercises from Source_Document into JSONB format
6. THE Grammar_Reference_System SHALL convert cross-links from Source_Document into JSONB format

### Requirement 14: Support L1 Transfer Notes

**User Story:** As a learner whose first language is Portuguese, I want to see notes about common mistakes related to my native language, so that I can avoid typical errors.

#### Acceptance Criteria

1. THE Grammar_Reference_System SHALL store L1 transfer notes within the common_errors field
2. THE Grammar_Reference_System SHALL preserve L1 transfer notes from Source_Document that explain Portuguese-specific challenges
3. WHEN displaying common_errors, THE Grammar_Reference_System SHALL include both general errors and L1 transfer notes
4. THE Grammar_Reference_System SHALL support L1 transfer notes for multiple source languages when available

### Requirement 15: Maintain Lesson Title Consistency

**User Story:** As a learner, I want grammar lesson titles to clearly describe the topic, so that I can quickly find the grammar I need to study.

#### Acceptance Criteria

1. THE Grammar_Reference_System SHALL extract lesson titles from Source_Document
2. THE Grammar_Reference_System SHALL store titles that accurately reflect the grammar topic
3. THE Grammar_Reference_System SHALL maintain title consistency with existing A0 and A1 lessons
4. THE Grammar_Reference_System SHALL support titles with Roman numerals for multi-part topics (e.g., "Present perfect II")
