# Requirements Document: Comprehensive Vocabulary Data

## Introduction

This feature enhances the existing vocabulary database by adding comprehensive linguistic information to the 1000 General Service List (GSL) words currently seeded with minimal data. The system currently has basic entries (headword, CEFR level, POS, entry_type) but lacks critical information needed for effective language learning: IPA pronunciation, definitions, usage notes, examples, collocations, patterns, register, and variety information.

The enhancement will transform the lexicon from a simple word list into a rich pedagogical resource that supports vocabulary practice, pronunciation training, and contextual learning for Brazilian professionals learning English.

## Glossary

- **Lexicon_System**: The vocabulary database and associated data structures in the application
- **GSL**: General Service List - a corpus-based list of the 1000 most frequent English words
- **IPA**: International Phonetic Alphabet - standardized phonetic notation
- **CEFR**: Common European Framework of Reference for Languages (A0, A1, A2, B1, B2, C1, C2)
- **POS**: Part of Speech (noun, verb, adjective, adverb, etc.)
- **Register**: The level of formality (formal, neutral, informal)
- **Variety**: English dialect variant (US, UK, international)
- **Collocation**: Words that frequently appear together
- **Pattern**: Grammatical structures commonly used with a word
- **Migration**: Database schema or data change script
- **Batch**: A subset of vocabulary entries processed together (e.g., 100-200 words)

## Requirements

### Requirement 1: Populate IPA Pronunciation Data

**User Story:** As a language learner, I want to see phonetic transcriptions for vocabulary words, so that I can learn correct pronunciation.

#### Acceptance Criteria

1. THE Lexicon_System SHALL store IPA transcription in the `ipa` field for all 1000 GSL words
2. WHEN a word has multiple pronunciations, THE Lexicon_System SHALL store the most common international pronunciation
3. THE Lexicon_System SHALL use standard IPA notation without slashes or brackets
4. WHERE a word has different US and UK pronunciations, THE Lexicon_System SHALL store the pronunciation matching the `variety` field value

### Requirement 2: Provide Simple Definitions

**User Story:** As a language learner, I want to see clear, simple definitions, so that I can understand word meanings without complex terminology.

#### Acceptance Criteria

1. THE Lexicon_System SHALL store a simple definition in the `definition_simple` field for all 1000 GSL words
2. THE Lexicon_System SHALL write simple definitions using A1-A2 level vocabulary
3. THE Lexicon_System SHALL limit simple definitions to one or two sentences
4. THE Lexicon_System SHALL focus definitions on the most common meaning of each word

### Requirement 3: Provide Teacher-Focused Definitions

**User Story:** As a teacher, I want to see detailed linguistic definitions, so that I can understand nuances and explain words accurately to students.

#### Acceptance Criteria

1. THE Lexicon_System SHALL store a detailed definition in the `definition_teacher` field for all 1000 GSL words
2. THE Lexicon_System SHALL include semantic range and register information in teacher definitions
3. THE Lexicon_System SHALL note polysemy when words have multiple distinct meanings
4. THE Lexicon_System SHALL reference grammatical behavior relevant to the word

### Requirement 4: Document Usage Patterns

**User Story:** As a language learner, I want to understand how words are used in professional contexts, so that I can use them appropriately in my work.

#### Acceptance Criteria

1. THE Lexicon_System SHALL store usage guidance in the `usage_notes` field for all 1000 GSL words
2. THE Lexicon_System SHALL prioritize professional and business English contexts in usage notes
3. WHERE a word has usage restrictions, THE Lexicon_System SHALL document those restrictions
4. THE Lexicon_System SHALL note common errors made by Brazilian Portuguese speakers when relevant

### Requirement 5: Specify Register and Variety

**User Story:** As a language learner, I want to know the formality level and dialect of words, so that I can use appropriate vocabulary in professional settings.

#### Acceptance Criteria

1. THE Lexicon_System SHALL store register information in the `register` field for all 1000 GSL words
2. THE Lexicon_System SHALL use one of three register values: 'formal', 'neutral', or 'informal'
3. THE Lexicon_System SHALL store variety information in the `variety` field for all 1000 GSL words
4. THE Lexicon_System SHALL use one of three variety values: 'US', 'UK', or 'international'
5. THE Lexicon_System SHALL default to 'neutral' register and 'international' variety when no specific variant is preferred

### Requirement 6: Provide Contextual Examples

**User Story:** As a language learner, I want to see words used in realistic sentences, so that I can understand context and usage patterns.

#### Acceptance Criteria

1. THE Lexicon_System SHALL store examples in the `examples` JSONB field as an array of strings
2. THE Lexicon_System SHALL provide at least 2 examples and at most 4 examples per word
3. THE Lexicon_System SHALL prioritize professional and workplace contexts in examples
4. THE Lexicon_System SHALL use A1-B1 level grammar in example sentences
5. THE Lexicon_System SHALL ensure examples demonstrate the most common usage of each word

### Requirement 7: Document Common Collocations

**User Story:** As a language learner, I want to know which words commonly appear together, so that I can sound more natural and fluent.

#### Acceptance Criteria

1. THE Lexicon_System SHALL store collocations in the `collocations` JSONB field as an array of strings
2. WHERE a word has common collocations, THE Lexicon_System SHALL include 2-5 high-frequency collocations
3. THE Lexicon_System SHALL prioritize collocations relevant to professional English
4. WHERE a word has no notable collocations, THE Lexicon_System SHALL store an empty array

### Requirement 8: Document Grammatical Patterns

**User Story:** As a language learner, I want to understand the grammatical structures used with words, so that I can construct correct sentences.

#### Acceptance Criteria

1. THE Lexicon_System SHALL store patterns in the `patterns` JSONB field as an array of strings
2. WHERE a word has specific grammatical patterns, THE Lexicon_System SHALL document 1-3 common patterns
3. THE Lexicon_System SHALL use notation like "verb + to-infinitive" or "adjective + preposition + noun"
4. WHERE a word has no specific patterns, THE Lexicon_System SHALL store an empty array
5. THE Lexicon_System SHALL prioritize patterns that Brazilian learners commonly struggle with

### Requirement 9: Implement Batched Migration Strategy

**User Story:** As a developer, I want to split vocabulary data into manageable batches, so that migrations are maintainable and can be reviewed effectively.

#### Acceptance Criteria

1. THE Lexicon_System SHALL organize vocabulary updates into migration files of 100-200 words each
2. THE Lexicon_System SHALL use UPDATE statements with WHERE clauses matching on headword
3. THE Lexicon_System SHALL group words by CEFR level within each batch (A0 words first, then A1)
4. THE Lexicon_System SHALL name migration files with sequential timestamps and descriptive names
5. THE Lexicon_System SHALL ensure each migration is idempotent and can be safely re-run

### Requirement 10: Maintain Data Consistency

**User Story:** As a system administrator, I want vocabulary data to be consistent and valid, so that the application functions correctly.

#### Acceptance Criteria

1. WHEN updating vocabulary entries, THE Lexicon_System SHALL preserve existing `id`, `headword`, `pos`, `cefr_receptive`, `cefr_productive`, `entry_type`, and `is_published` values
2. THE Lexicon_System SHALL update the `updated_at` timestamp when modifying entries
3. THE Lexicon_System SHALL ensure JSONB fields contain valid JSON arrays
4. THE Lexicon_System SHALL handle special characters and quotes correctly in all text fields
5. IF an UPDATE statement fails to match a headword, THEN THE Lexicon_System SHALL log a warning but continue processing

### Requirement 11: Validate Vocabulary Data Quality

**User Story:** As a content manager, I want to verify that vocabulary data meets quality standards, so that learners receive accurate information.

#### Acceptance Criteria

1. THE Lexicon_System SHALL provide a validation query to check for missing required fields
2. THE Lexicon_System SHALL identify entries where `ipa`, `definition_simple`, or `examples` are NULL or empty
3. THE Lexicon_System SHALL verify that all JSONB fields contain valid JSON
4. THE Lexicon_System SHALL confirm that register values are one of: 'formal', 'neutral', 'informal'
5. THE Lexicon_System SHALL confirm that variety values are one of: 'US', 'UK', 'international'

### Requirement 12: Support Incremental Rollout

**User Story:** As a developer, I want to deploy vocabulary enhancements incrementally, so that I can test and validate data before full deployment.

#### Acceptance Criteria

1. THE Lexicon_System SHALL allow running individual batch migrations independently
2. THE Lexicon_System SHALL track which batches have been applied using migration version numbers
3. WHERE a batch migration fails, THE Lexicon_System SHALL allow rollback without affecting other batches
4. THE Lexicon_System SHALL provide a query to show completion status across all batches
5. THE Lexicon_System SHALL allow re-running migrations to fix data errors without creating duplicates

