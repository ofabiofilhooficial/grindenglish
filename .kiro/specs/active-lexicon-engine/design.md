# Active Lexicon Engine - Design Document

## Overview

The Active Lexicon Engine is a comprehensive Spaced Repetition System (SRS) that transforms vocabulary learning through intelligent scheduling, contextual practice, and progress tracking. This design document provides the technical architecture for implementing all 25 requirements across three core components: Progress Dashboard, Lexicon Hub, and Practice Arena.

### Core Design Principles

1. **Immutable Master Data**: The Master_Lexicon serves as a single source of truth for vocabulary entries
2. **User-Centric Progress**: User_Vocabulary_Progress tracks individual learning journeys independently
3. **Algorithm-Driven Scheduling**: SRS algorithm ensures optimal review intervals based on performance
4. **Performance-First**: Sub-second response times for critical user paths
5. **Accessibility by Default**: Keyboard navigation and screen reader support built into all components
6. **Resilience**: Offline support and automatic sync when connectivity is restored

## System Architecture

### High-Level Component Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                     Frontend Layer                           │
├─────────────────────────────────────────────────────────────┤
│  Progress Dashboard  │  Lexicon Hub  │  Practice Arena       │
│  (Metrics + Queue)   │  (Discovery)  │  (Active Study)       │
└──────────────┬───────────────────────────────────┬───────────┘
               │                                   │
               ▼                                   ▼
┌─────────────────────────────────────────────────────────────┐
│                     API Layer (REST)                         │
├─────────────────────────────────────────────────────────────┤
│  Dashboard API  │  Lexicon API  │  Practice API  │ Auth API  │
└──────────────┬───────────────────────────────────┬───────────┘
               │                                   │
               ▼                                   ▼
┌─────────────────────────────────────────────────────────────┐
│                   Business Logic Layer                       │
├─────────────────────────────────────────────────────────────┤
│  SRS Algorithm  │  Parser/Serializer  │  Cache Manager      │
└──────────────┬───────────────────────────────────┬───────────┘
               │                                   │
               ▼                                   ▼
┌─────────────────────────────────────────────────────────────┐
│                   Data Access Layer                          │
├─────────────────────────────────────────────────────────────┤
│  Master_Lexicon  │  User_Vocabulary_Progress  │  Indexes    │
└─────────────────────────────────────────────────────────────┘
```

### Component Responsibilities

**Frontend Layer**:
- Progress Dashboard: Displays metrics and due words queue
- Lexicon Hub: Vocabulary discovery and filtering
- Practice Arena: Cloze flashcard presentation and grading

**API Layer**:
- Dashboard API: Metrics calculation and due words retrieval
- Lexicon API: Vocabulary search and filtering
- Practice API: Flashcard presentation and grading
- Auth API: User authentication and session management

**Business Logic Layer**:
- SRS Algorithm: Interval calculation and status transitions
- Parser/Serializer: Cloze sentence and L1 notes processing
- Cache Manager: Audio pre-fetching and session caching

**Data Access Layer**:
- Master_Lexicon: Immutable vocabulary repository
- User_Vocabulary_Progress: Mutable user progress tracking
- Indexes: Optimized query performance


## Data Model

### Master_Lexicon Table

The Master_Lexicon is an immutable, centralized repository of vocabulary entries. Each entry has a stable UUID that never changes.

```sql
CREATE TABLE Master_Lexicon (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  english_word VARCHAR(255) NOT NULL UNIQUE,
  cefr_level ENUM('A1', 'A2', 'B1', 'B2', 'C1', 'C2') NOT NULL,
  unit VARCHAR(255) NOT NULL,
  definition TEXT NOT NULL,
  example_sentence TEXT NOT NULL,
  audio_url VARCHAR(2048),
  l1_notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_master_lexicon_cefr ON Master_Lexicon(cefr_level);
CREATE INDEX idx_master_lexicon_unit ON Master_Lexicon(unit);
CREATE INDEX idx_master_lexicon_word ON Master_Lexicon(english_word);
```

**Properties**:
- `id`: Stable UUID assigned at creation, never changes
- `english_word`: The vocabulary word (unique constraint ensures no duplicates)
- `cefr_level`: Difficulty level (A1-C2)
- `unit`: Thematic grouping
- `definition`: Clear, learner-friendly definition
- `example_sentence`: Contextual sentence with target word
- `audio_url`: URL to pronunciation audio file
- `l1_notes`: Structured interference pattern notes (format: "term1 vs. term2: explanation")

### User_Vocabulary_Progress Table

Tracks individual user progress for each vocabulary item. This is the mutable counterpart to Master_Lexicon.

```sql
CREATE TABLE User_Vocabulary_Progress (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id),
  lexicon_entry_id UUID NOT NULL REFERENCES Master_Lexicon(id),
  status ENUM('New', 'Learning', 'Mastered') DEFAULT 'New',
  ease_factor DECIMAL(3, 2) DEFAULT 2.5,
  interval_days INTEGER DEFAULT 1,
  next_review_date DATE NOT NULL DEFAULT CURRENT_DATE,
  total_reviews INTEGER DEFAULT 0,
  consecutive_correct INTEGER DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE(user_id, lexicon_entry_id)
);

CREATE INDEX idx_uvp_user_next_review ON User_Vocabulary_Progress(user_id, next_review_date);
CREATE INDEX idx_uvp_user_status ON User_Vocabulary_Progress(user_id, status);
CREATE INDEX idx_uvp_user_id ON User_Vocabulary_Progress(user_id);
```

**Properties**:
- `user_id`: Foreign key to user account
- `lexicon_entry_id`: Foreign key to Master_Lexicon
- `status`: Current learning phase (New, Learning, Mastered)
- `ease_factor`: Adjustment factor for interval calculation (1.3-2.5)
- `interval_days`: Days until next review
- `next_review_date`: Calculated date for next review
- `total_reviews`: Cumulative review count
- `consecutive_correct`: Count of consecutive successful recalls

**Initialization Values**:
When a user first encounters a vocabulary item:
- `status = 'New'`
- `ease_factor = 2.5`
- `interval_days = 1`
- `next_review_date = today`
- `total_reviews = 0`
- `consecutive_correct = 0`

### Composite Index Strategy

The composite index on `(user_id, next_review_date)` is critical for performance:
- Enables fast retrieval of due words for a specific user
- Supports sorting by next_review_date in a single pass
- Target: < 100ms query time for users with 5000+ items

### Data Consistency Constraints

1. **Unique Constraint**: Each user can have at most one progress entry per vocabulary item
2. **Foreign Key Constraints**: Ensure referential integrity with Master_Lexicon and users table
3. **Status Transitions**: Only valid transitions are enforced at the application layer
4. **Ease Factor Bounds**: Always maintained between 1.3 and 2.5
5. **Interval Days**: Always a positive integer


## API Design

### Dashboard API

#### GET /api/dashboard/metrics

Retrieves global learning metrics for the authenticated user.

**Response** (200 OK):
```json
{
  "total_words_unlocked": 245,
  "words_in_learning": 87,
  "words_mastered": 158,
  "cache_timestamp": "2024-01-15T10:30:00Z"
}
```

**Implementation**:
- Query User_Vocabulary_Progress with aggregation functions
- Cache results for 30 seconds per user
- Invalidate cache on any progress update
- Target response time: < 500ms

#### GET /api/dashboard/due-words

Retrieves vocabulary items due for review today, paginated.

**Query Parameters**:
- `page`: Page number (default: 1)
- `limit`: Items per page (default: 20, max: 100)

**Response** (200 OK):
```json
{
  "items": [
    {
      "lexicon_entry_id": "uuid-1",
      "english_word": "have",
      "cefr_level": "A1",
      "unit": "Unit 1",
      "days_overdue": 2,
      "next_review_date": "2024-01-13"
    }
  ],
  "total_count": 45,
  "page": 1,
  "limit": 20
}
```

**Implementation**:
- Query: `SELECT * FROM User_Vocabulary_Progress WHERE user_id = ? AND next_review_date <= TODAY ORDER BY next_review_date ASC`
- Use composite index for performance
- Target response time: < 100ms
- Auto-refresh every 30 seconds on frontend

### Lexicon API

#### GET /api/lexicon/entries

Retrieves vocabulary entries with filtering and search.

**Query Parameters**:
- `search`: Search term for English_Word (case-insensitive)
- `cefr_levels`: Comma-separated CEFR levels (e.g., "A1,A2")
- `units`: Comma-separated unit names
- `statuses`: Comma-separated statuses (New, Learning, Mastered)
- `page`: Page number (default: 1)
- `limit`: Items per page (default: 50)

**Response** (200 OK):
```json
{
  "items": [
    {
      "lexicon_entry_id": "uuid-1",
      "english_word": "have",
      "cefr_level": "A1",
      "unit": "Unit 1",
      "mastery_status": "Learning",
      "last_reviewed_date": "2024-01-14"
    }
  ],
  "total_count": 2000,
  "page": 1,
  "limit": 50
}
```

**Implementation**:
- Join Master_Lexicon with User_Vocabulary_Progress (LEFT JOIN for non-started items)
- Apply filters with AND logic
- Use full-text search index on english_word for performance
- Target response time: < 500ms

#### GET /api/lexicon/entries/:id

Retrieves detailed information for a single vocabulary entry.

**Response** (200 OK):
```json
{
  "lexicon_entry_id": "uuid-1",
  "english_word": "have",
  "definition": "to possess or own",
  "example_sentence": "I have breakfast at 7 AM",
  "cefr_level": "A1",
  "unit": "Unit 1",
  "audio_url": "https://audio.example.com/have.mp3",
  "l1_notes": "make vs. do: Use 'have' for possession; 'make' for creation",
  "mastery_status": "Learning"
}
```

#### POST /api/lexicon/entries/:id/start-learning

Initializes a vocabulary item for learning or loads existing progress.

**Response** (200 OK):
```json
{
  "lexicon_entry_id": "uuid-1",
  "status": "New",
  "ease_factor": 2.5,
  "interval_days": 1,
  "next_review_date": "2024-01-15"
}
```

**Implementation**:
- Check if entry exists in User_Vocabulary_Progress
- If not, create with initialization values
- If exists, return current state
- Redirect frontend to Practice Arena

### Practice API

#### GET /api/practice/next-word

Retrieves the next due word for practice.

**Response** (200 OK):
```json
{
  "lexicon_entry_id": "uuid-1",
  "english_word": "have",
  "example_sentence": "I _____ breakfast at 7 AM",
  "audio_url": "https://audio.example.com/have.mp3",
  "session_position": 1,
  "session_total": 45
}
```

**Implementation**:
- Query first ungraded due word
- Return cloze sentence (target word replaced with blank)
- Do NOT return definition or L1_Notes yet
- Include session context for UI

#### POST /api/practice/grade

Records user's grade for a vocabulary item and updates progress.

**Request Body**:
```json
{
  "lexicon_entry_id": "uuid-1",
  "grade": "Good"
}
```

**Response** (200 OK):
```json
{
  "status": "Learning",
  "ease_factor": 2.5,
  "interval_days": 3,
  "next_review_date": "2024-01-18",
  "consecutive_correct": 1,
  "total_reviews": 5,
  "message": "Nice work. You'll see this word again in a few days."
}
```

**Implementation**:
- Execute SRS algorithm (see section below)
- Update User_Vocabulary_Progress atomically
- Check for status transitions (e.g., consecutive_correct >= 3 → Mastered)
- Return updated state and user-friendly message
- Queue locally if network fails

#### GET /api/practice/session-stats

Retrieves statistics for completed study session.

**Response** (200 OK):
```json
{
  "total_words_reviewed": 15,
  "average_ease_factor": 2.3,
  "words_mastered_today": 2,
  "session_duration_minutes": 12
}
```

### Auth API

#### POST /api/auth/login

Authenticates user and returns session token.

#### POST /api/auth/logout

Invalidates session token.

#### GET /api/auth/profile

Retrieves authenticated user's profile.

**Response** (200 OK):
```json
{
  "user_id": "uuid",
  "email": "[email]",
  "created_at": "2024-01-01"
}
```


## SRS Algorithm Implementation

### Algorithm Overview

The Spaced Repetition System adjusts review intervals based on user performance. The algorithm maintains an ease factor that increases with successful recalls and decreases with difficult recalls.

### Core Algorithm

```
FUNCTION updateProgress(grade, current_state):
  INPUT:
    grade: "Hard", "Good", or "Easy"
    current_state: {ease_factor, interval_days, consecutive_correct, status}
  
  OUTPUT:
    new_state: {ease_factor, interval_days, next_review_date, consecutive_correct, status}

  IF grade == "Hard":
    new_ease_factor = MAX(1.3, current_state.ease_factor - 0.2)
    new_interval_days = 1
    new_consecutive_correct = 0
  
  ELSE IF grade == "Good":
    new_ease_factor = current_state.ease_factor
    new_interval_days = ROUND(current_state.interval_days * current_state.ease_factor)
    new_consecutive_correct = current_state.consecutive_correct + 1
  
  ELSE IF grade == "Easy":
    new_ease_factor = current_state.ease_factor + 0.1
    new_interval_days = ROUND(current_state.interval_days * current_state.ease_factor * 1.3)
    new_consecutive_correct = current_state.consecutive_correct + 1
  
  // Ensure interval_days is positive integer
  new_interval_days = MAX(1, ROUND(new_interval_days))
  
  // Calculate next review date
  new_next_review_date = TODAY + new_interval_days
  
  // Check for status transition to Mastered
  IF new_consecutive_correct >= 3 AND current_state.status != "Mastered":
    new_status = "Mastered"
    new_interval_days = 30
    new_next_review_date = TODAY + 30
  
  // Handle demotion from Mastered
  ELSE IF current_state.status == "Mastered" AND grade == "Hard":
    new_status = "Learning"
    new_consecutive_correct = 0
    new_interval_days = 1
    new_next_review_date = TODAY + 1
  
  ELSE IF current_state.status == "New":
    new_status = "Learning"
  
  ELSE:
    new_status = current_state.status
  
  RETURN {
    ease_factor: new_ease_factor,
    interval_days: new_interval_days,
    next_review_date: new_next_review_date,
    consecutive_correct: new_consecutive_correct,
    status: new_status
  }
END FUNCTION
```

### Grade Response Messages

- **Hard**: "Keep practicing this word. It will appear again soon."
- **Good**: "Nice work. You'll see this word again in a few days."
- **Easy**: "Excellent. You've mastered this word."

### Interval Calculation Examples

**Starting State**: ease_factor=2.5, interval_days=1

| Grade | New Ease | New Interval | Next Review |
|-------|----------|--------------|-------------|
| Hard  | 2.3      | 1            | Tomorrow    |
| Good  | 2.5      | 2-3 days     | In 2-3 days |
| Easy  | 2.6      | 3-4 days     | In 3-4 days |

**After Mastery**: interval_days=30 (long-term retention)

### Atomic Transaction Requirements

All SRS updates must be atomic:
```sql
BEGIN TRANSACTION;
  UPDATE User_Vocabulary_Progress
  SET ease_factor = ?,
      interval_days = ?,
      next_review_date = ?,
      consecutive_correct = ?,
      status = ?,
      total_reviews = total_reviews + 1,
      updated_at = NOW()
  WHERE user_id = ? AND lexicon_entry_id = ?;
COMMIT;
```

If transaction fails, retry up to 3 times before reporting error to user.

### Timezone Handling

- All dates stored in UTC
- next_review_date calculated using user's local timezone
- Comparison with TODAY uses user's local date


## Frontend Architecture

### Progress Dashboard Component

**Responsibilities**:
- Display global metrics (Total_Words_Unlocked, Words_In_Learning, Words_Mastered)
- Display due words queue with pagination
- Provide primary CTA button ("Grind Due Words")
- Auto-refresh queue every 30 seconds

**Component Structure**:
```
ProgressDashboard
├── MetricsSection
│   ├── TotalWordsCard
│   ├── LearningWordsCard
│   └── MasteredWordsCard
├── DueWordsQueue
│   ├── QueueItem (repeating)
│   └── Pagination
└── PrimaryButton ("Grind Due Words")
```

**State Management**:
- Cache metrics for 30 seconds
- Invalidate on any progress update
- Lazy load due words queue (first 20 items immediately)

**Mobile Optimization**:
- Stack metrics vertically on mobile
- "Grind Due Words" button: 80% viewport width, 44px minimum height
- Single column layout for queue items

### Lexicon Hub Component

**Responsibilities**:
- Display datatable of all vocabulary entries
- Support search, filtering by CEFR level, unit, and status
- Show detail panel on entry click
- Initialize vocabulary items for learning

**Component Structure**:
```
LexiconHub
├── SearchBar
├── FilterPanel
│   ├── CEFRLevelFilter
│   ├── UnitFilter
│   └── StatusFilter
├── VocabularyTable
│   ├── TableHeader
│   └── TableRow (repeating)
├── Pagination
└── DetailPanel (conditional)
    ├── WordDetails
    ├── AudioButton
    └── StartLearningButton
```

**Keyboard Shortcuts**:
- `S`: Focus search field
- `F`: Open filter panel
- `Enter`: Open detail panel for selected row
- `Escape`: Close detail panel

**Filtering Logic**:
- Apply all filters with AND logic
- Full-text search on english_word
- Real-time filter updates

### Practice Arena Component

**Responsibilities**:
- Display cloze flashcard
- Manage reveal/hide of answer
- Handle audio playback
- Record grades and advance to next word
- Display session completion stats

**Component Structure**:
```
PracticeArena
├── ClozeCard
│   ├── ClozeQuestion
│   ├── RevealButton
│   └── RevealedContent (conditional)
│       ├── EnglishWord
│       ├── Definition
│       ├── AudioButton
│       └── L1Notes
├── GradingButtons
│   ├── HardButton
│   ├── GoodButton
│   └── EasyButton
├── FeedbackMessage
└── SessionStats (on completion)
```

**Mobile Optimization**:
- Cloze sentence: 18px minimum font
- Buttons: 44px x 44px minimum touch target
- Single column layout
- Grading buttons: 80% viewport width
- Position cloze in upper half, grading buttons in lower half

**Keyboard Shortcuts**:
- `R`: Reveal answer
- `H`: Grade as Hard
- `G`: Grade as Good
- `E`: Grade as Easy

**Offline Support**:
- Queue grades locally if network fails
- Display: "Saving your progress. This will sync when your connection is restored."
- Retry persistence when connectivity restored
- Maintain order of grades

### Audio Caching Strategy

**Pre-fetching Logic**:
```
WHEN user enters Practice Arena:
  1. Pre-fetch audio for current word
  2. Pre-fetch audio for next 3 words in queue
  3. Store in browser cache (IndexedDB or Service Worker)
  4. Prioritize current word on slow networks (< 2 Mbps)

WHEN user clicks audio button:
  1. Play from local cache (no network request)
  2. If not cached, stream from URL with loading indicator

WHEN session completes:
  1. Clear cached audio files
  2. Free up storage space
```

**Cache Storage**:
- Use Service Worker Cache API for reliability
- Fallback to IndexedDB for older browsers
- Store with session-scoped expiration
- Maximum cache size: 50MB per session

**Error Handling**:
- If pre-fetch fails, log error and continue
- Display "Audio unavailable for this word" if playback fails
- Allow user to continue without audio


## Cloze Parser & Serializer

### Cloze Parser

**Purpose**: Parse Example_Sentence to generate cloze flashcard by replacing target word with blank.

**Algorithm**:
```
FUNCTION parseCloze(example_sentence, target_word):
  INPUT:
    example_sentence: "I have breakfast at 7 AM"
    target_word: "have"
  
  OUTPUT:
    cloze_sentence: "I _____ breakfast at 7 AM"
  
  // Normalize for case-insensitive matching
  sentence_lower = example_sentence.toLowerCase()
  target_lower = target_word.toLowerCase()
  
  // Find first occurrence of target word
  index = sentence_lower.indexOf(target_lower)
  
  IF index == -1:
    THROW ERROR: "Target word not found in example sentence"
  
  // Extract word boundaries to handle punctuation
  start_index = index
  end_index = index + target_word.length
  
  // Check for attached punctuation
  WHILE end_index < sentence_lower.length AND 
        sentence_lower[end_index] IN ['.', ',', '!', '?', ';', ':']:
    end_index += 1
  
  // Replace with blank
  cloze_sentence = example_sentence.substring(0, start_index) + 
                   "_____ " + 
                   example_sentence.substring(end_index)
  
  RETURN cloze_sentence
END FUNCTION
```

**Edge Cases Handled**:
1. Multiple occurrences: Replace only the first
2. Punctuation attached: "have," → "_____ ,"
3. Capitalization: "Have" at sentence start → "_____ "
4. Missing target word: Return descriptive error

### Cloze Serializer

**Purpose**: Restore cloze sentence to complete sentence for verification.

**Algorithm**:
```
FUNCTION serializeCloze(cloze_sentence, target_word):
  INPUT:
    cloze_sentence: "I _____ breakfast at 7 AM"
    target_word: "have"
  
  OUTPUT:
    complete_sentence: "I have breakfast at 7 AM"
  
  // Find blank placeholder
  blank_index = cloze_sentence.indexOf("_____")
  
  IF blank_index == -1:
    THROW ERROR: "Cloze blank not found"
  
  // Replace blank with target word
  complete_sentence = cloze_sentence.substring(0, blank_index) +
                      target_word +
                      cloze_sentence.substring(blank_index + 5)
  
  // Clean up extra spaces
  complete_sentence = complete_sentence.replace(/\s+/g, ' ').trim()
  
  RETURN complete_sentence
END FUNCTION
```

### Round-Trip Property

**Requirement**: For all valid Example_Sentence entries, parsing then serializing then parsing SHALL produce an equivalent cloze sentence.

```
PROPERTY: Cloze Round Trip
FOR ANY valid example_sentence and target_word:
  cloze1 = parseCloze(example_sentence, target_word)
  restored = serializeCloze(cloze1, target_word)
  cloze2 = parseCloze(restored, target_word)
  ASSERT cloze1 == cloze2
```

## L1 Notes Parser & Serializer

### L1 Notes Parser

**Purpose**: Parse structured L1_Notes to extract interference pattern and explanation.

**Format**: "term1 vs. term2: explanation"

**Algorithm**:
```
FUNCTION parseL1Notes(l1_notes_text):
  INPUT:
    l1_notes_text: "make vs. do: Use 'make' for creating; use 'do' for actions"
  
  OUTPUT:
    parsed: {
      term1: "make",
      term2: "do",
      explanation: "Use 'make' for creating; use 'do' for actions"
    }
  
  // Check for required separator
  IF NOT l1_notes_text.contains(":"):
    THROW ERROR: "Invalid L1_Notes format. Expected 'term1 vs. term2: explanation'"
  
  // Split on colon
  parts = l1_notes_text.split(":", 2)
  terms_part = parts[0].trim()
  explanation = parts[1].trim()
  
  // Parse terms
  IF NOT terms_part.contains(" vs. "):
    THROW ERROR: "Invalid L1_Notes format. Expected 'term1 vs. term2: explanation'"
  
  terms = terms_part.split(" vs. ")
  term1 = terms[0].trim()
  term2 = terms[1].trim()
  
  RETURN {
    term1: term1,
    term2: term2,
    explanation: explanation
  }
END FUNCTION
```

### L1 Notes Serializer

**Purpose**: Format parsed L1_Notes back into human-readable text.

**Algorithm**:
```
FUNCTION serializeL1Notes(parsed):
  INPUT:
    parsed: {term1, term2, explanation}
  
  OUTPUT:
    l1_notes_text: "term1 vs. term2: explanation"
  
  l1_notes_text = parsed.term1 + " vs. " + parsed.term2 + ": " + parsed.explanation
  
  RETURN l1_notes_text
END FUNCTION
```

### Round-Trip Property

**Requirement**: For all valid L1_Notes entries, parsing then serializing then parsing SHALL produce an equivalent L1_Notes entry.

```
PROPERTY: L1 Notes Round Trip
FOR ANY valid l1_notes_text:
  parsed1 = parseL1Notes(l1_notes_text)
  serialized = serializeL1Notes(parsed1)
  parsed2 = parseL1Notes(serialized)
  ASSERT parsed1 == parsed2
```

### L1 Notes Display Logic

**In Practice Arena**:
1. After user clicks "Reveal", display L1_Notes prominently
2. If user grades as "Hard", highlight L1_Notes with visual indicator (border, background color)
3. If user grades as "Hard" twice consecutively, increase prominence on next review (larger font, additional emphasis)
4. If no L1_Notes exist, don't display empty section


## Performance Optimization

### Query Optimization Strategy

#### Due Words Query (Critical Path)

**Target**: < 100ms for users with 5000+ items

**Optimized Query**:
```sql
SELECT 
  uvp.id,
  uvp.lexicon_entry_id,
  ml.english_word,
  ml.cefr_level,
  ml.unit,
  uvp.next_review_date,
  (CURRENT_DATE - uvp.next_review_date) AS days_overdue
FROM User_Vocabulary_Progress uvp
INNER JOIN Master_Lexicon ml ON uvp.lexicon_entry_id = ml.id
WHERE uvp.user_id = $1 
  AND uvp.next_review_date <= CURRENT_DATE
ORDER BY uvp.next_review_date ASC
LIMIT 20 OFFSET $2;
```

**Index**: `(user_id, next_review_date)` composite index

**Execution Plan**:
1. Use index to locate user's entries
2. Filter by next_review_date in index order
3. Join with Master_Lexicon for display data
4. Return first 20 results

#### Metrics Query

**Target**: < 500ms

**Optimized Query**:
```sql
SELECT 
  COUNT(CASE WHEN status != 'New' THEN 1 END) AS total_words_unlocked,
  COUNT(CASE WHEN status = 'Learning' THEN 1 END) AS words_in_learning,
  COUNT(CASE WHEN status = 'Mastered' THEN 1 END) AS words_mastered
FROM User_Vocabulary_Progress
WHERE user_id = $1;
```

**Optimization**: Cache results for 30 seconds per user

#### Lexicon Search Query

**Target**: < 500ms

**Optimized Query**:
```sql
SELECT 
  ml.id,
  ml.english_word,
  ml.cefr_level,
  ml.unit,
  COALESCE(uvp.status, 'New') AS mastery_status,
  uvp.updated_at AS last_reviewed_date
FROM Master_Lexicon ml
LEFT JOIN User_Vocabulary_Progress uvp 
  ON ml.id = uvp.lexicon_entry_id AND uvp.user_id = $1
WHERE (ml.english_word ILIKE $2 OR $2 = '')
  AND (ml.cefr_level = ANY($3) OR $3 = '{}')
  AND (ml.unit = ANY($4) OR $4 = '{}')
  AND (COALESCE(uvp.status, 'New') = ANY($5) OR $5 = '{}')
ORDER BY ml.english_word ASC
LIMIT 50 OFFSET $6;
```

**Indexes**:
- Full-text search index on `english_word`
- Index on `cefr_level`
- Index on `unit`

### Caching Strategy

#### Metrics Cache

- **Duration**: 30 seconds per user
- **Invalidation**: On any User_Vocabulary_Progress update
- **Storage**: In-memory cache (Redis recommended)
- **Key**: `metrics:{user_id}`

#### Session Cache

- **Duration**: Session lifetime
- **Content**: Current due words queue, audio files
- **Storage**: Browser cache (Service Worker)
- **Cleanup**: On session end

#### Audio Cache

- **Duration**: Session lifetime
- **Content**: Pre-fetched audio files for current + next 3 words
- **Storage**: Service Worker Cache API or IndexedDB
- **Size Limit**: 50MB per session
- **Cleanup**: On session end

### Database Connection Pooling

- **Pool Size**: 20-50 connections (configurable)
- **Timeout**: 30 seconds
- **Idle Timeout**: 5 minutes
- **Retry Logic**: Exponential backoff (1s, 2s, 4s, 8s)

### Lazy Loading Strategy

**Dashboard**:
- Load metrics immediately (< 500ms)
- Load first 20 due words immediately (< 1s)
- Load additional pages on demand

**Lexicon Hub**:
- Load first 50 entries immediately
- Load additional pages on scroll or pagination click

**Practice Arena**:
- Load current word immediately
- Pre-fetch next 3 words in background
- Pre-fetch audio for next 3 words

### Query Result Pagination

- **Default Page Size**: 20 items (due words), 50 items (lexicon)
- **Maximum Page Size**: 100 items
- **Offset-Based Pagination**: Use LIMIT/OFFSET for simplicity
- **Cursor-Based Pagination**: Consider for large datasets (future optimization)


## Mobile Responsiveness

### Responsive Breakpoints

- **Mobile**: < 768px (primary focus)
- **Tablet**: 768px - 1024px
- **Desktop**: > 1024px

### One-Handed Interaction Design

#### Touch Target Sizes

- **Minimum**: 44px x 44px (iOS/Android standard)
- **Recommended**: 48px x 48px
- **Spacing**: 8px minimum between targets

#### Layout Strategy

**Mobile (< 768px)**:
```
┌─────────────────────┐
│   Cloze Question    │  (Upper half)
│   (18px+ font)      │
├─────────────────────┤
│   [Reveal Button]   │
├─────────────────────┤
│                     │
│  (Revealed Content) │
│  (if applicable)    │
│                     │
├─────────────────────┤
│  [Hard] [Good]      │  (Lower half)
│  [Easy]             │  (Thumb-friendly)
└─────────────────────┘
```

**Tablet (768px - 1024px)**:
```
┌──────────────────────────────────┐
│      Cloze Question              │
│      (24px font)                 │
├──────────────────────────────────┤
│  [Reveal]  [Audio]               │
├──────────────────────────────────┤
│      Revealed Content            │
├──────────────────────────────────┤
│  [Hard]  [Good]  [Easy]          │
└──────────────────────────────────┘
```

**Desktop (> 1024px)**:
```
┌────────────────────────────────────────┐
│         Cloze Question                 │
│         (24px font)                    │
├────────────────────────────────────────┤
│  [Reveal]  [Audio]                     │
├────────────────────────────────────────┤
│         Revealed Content               │
│         (Definition, L1 Notes)         │
├────────────────────────────────────────┤
│  [Hard]  [Good]  [Easy]  [Stats]       │
└────────────────────────────────────────┘
```

### Button Sizing

**Mobile**:
- "Grind Due Words": 80% viewport width, 44px height
- Grading buttons: 80% viewport width, 44px height each
- Audio button: 44px diameter circle
- Reveal button: 80% viewport width, 44px height

**Tablet/Desktop**:
- Buttons: 48px height, proportional width
- Maintain 8px spacing between buttons

### Font Sizing

- **Mobile Cloze**: 18px minimum
- **Mobile Definition**: 16px
- **Mobile L1 Notes**: 14px
- **Tablet Cloze**: 20px
- **Desktop Cloze**: 24px

### Viewport Optimization

**Mobile**:
- Hide non-essential UI elements (session stats, detailed metrics)
- Show only current word and grading options
- Minimize scrolling (fit cloze + buttons in viewport)
- Use full viewport width for buttons

**Tablet/Desktop**:
- Show session context (position in queue)
- Display session statistics on completion
- Use sidebar for additional information

### Gesture Support

**Mobile**:
- Swipe left: Grade as "Easy"
- Swipe right: Grade as "Hard"
- Tap: Grade as "Good"
- Long press: Show audio button

### Orientation Handling

**Portrait Mode**:
- Stack elements vertically
- Full-width buttons
- Cloze in upper half, buttons in lower half

**Landscape Mode**:
- Side-by-side layout (cloze on left, buttons on right)
- Smaller font sizes to fit content
- Horizontal button arrangement


## Accessibility Implementation

### Keyboard Navigation

#### Tab Order

All interactive elements must be reachable via Tab key in logical order:

**Progress Dashboard**:
1. Metrics section (read-only)
2. Due words queue items (clickable)
3. "Grind Due Words" button
4. Pagination controls

**Lexicon Hub**:
1. Search field
2. Filter buttons
3. Table rows (clickable)
4. Pagination controls
5. Detail panel (if open)

**Practice Arena**:
1. Cloze question (read-only)
2. Reveal button
3. Audio button (if revealed)
4. Grading buttons (Hard, Good, Easy)
5. Session stats (if visible)

#### Keyboard Shortcuts

**Global**:
- `Tab`: Move to next interactive element
- `Shift+Tab`: Move to previous interactive element
- `Enter`: Activate focused button
- `Escape`: Close modals/panels

**Lexicon Hub**:
- `S`: Focus search field
- `F`: Open filter panel
- `Enter`: Open detail panel for selected row

**Practice Arena**:
- `R`: Reveal answer
- `H`: Grade as Hard
- `G`: Grade as Good
- `E`: Grade as Easy

### Screen Reader Support

#### ARIA Labels and Descriptions

**Progress Dashboard**:
```html
<section aria-label="Learning Metrics">
  <div aria-label="Total Words Unlocked: 245"></div>
  <div aria-label="Words in Learning: 87"></div>
  <div aria-label="Words Mastered: 158"></div>
</section>

<section aria-label="Due Words Queue">
  <button aria-label="Grind Due Words. Start your daily review session">
    Grind Due Words
  </button>
</section>
```

**Practice Arena**:
```html
<section aria-label="Cloze Flashcard">
  <p aria-label="Cloze question. Fill in the blank: I _____ breakfast at 7 AM">
    I _____ breakfast at 7 AM
  </p>
  
  <button aria-label="Reveal. Button. Activates to show the English word, definition, and L1 notes">
    Reveal
  </button>
  
  <div aria-label="Revealed content" role="region" aria-live="polite">
    <p aria-label="English word: have"></p>
    <p aria-label="Definition: to possess or own"></p>
    <p aria-label="L1 Notes: make vs. do: Use 'make' for creating; use 'do' for actions"></p>
  </div>
  
  <div role="group" aria-label="Grading options">
    <button aria-label="Hard button. Grades this word as difficult. It will appear again tomorrow">
      Hard
    </button>
    <button aria-label="Good button. Grades this word as correctly recalled. It will appear again in a few days">
      Good
    </button>
    <button aria-label="Easy button. Grades this word as easy. It will appear again in several days">
      Easy
    </button>
  </div>
</section>
```

**Lexicon Hub**:
```html
<table aria-label="Vocabulary table with columns: English Word, CEFR Level, Unit, Mastery Status, Last Reviewed Date">
  <thead>
    <tr>
      <th>English Word</th>
      <th>CEFR Level</th>
      <th>Unit</th>
      <th>Mastery Status</th>
      <th>Last Reviewed Date</th>
    </tr>
  </thead>
  <tbody>
    <tr aria-label="have, A1, Unit 1, Learning, Last reviewed 2024-01-14">
      <td>have</td>
      <td>A1</td>
      <td>Unit 1</td>
      <td>Learning</td>
      <td>2024-01-14</td>
    </tr>
  </tbody>
</table>
```

#### Live Regions

**Practice Arena**:
```html
<!-- Announce grade feedback immediately -->
<div aria-live="polite" aria-atomic="true" role="status">
  Nice work. You'll see this word again in a few days.
</div>

<!-- Announce session completion -->
<div aria-live="assertive" aria-atomic="true" role="alert">
  Session complete. You reviewed 15 words and mastered 2 new words.
</div>
```

#### Semantic HTML

- Use `<button>` for all interactive elements (not `<div>` with click handlers)
- Use `<table>` for tabular data (not `<div>` grid)
- Use `<form>` for search and filter inputs
- Use `<section>` for major content areas
- Use `<nav>` for navigation elements

#### Color Contrast

- **Minimum Contrast Ratio**: 4.5:1 for normal text, 3:1 for large text
- **Test**: Use WCAG contrast checker for all color combinations
- **Avoid**: Relying solely on color to convey information (use icons, text, patterns)

#### Focus Indicators

- **Visible Focus**: All interactive elements must have visible focus indicator
- **Minimum Size**: 2px border or outline
- **Color**: High contrast with background (not removed with `outline: none`)
- **Example**: `button:focus { outline: 3px solid #0066cc; }`

#### Form Accessibility

**Search Field**:
```html
<label for="search-input">Search vocabulary</label>
<input 
  id="search-input" 
  type="text" 
  placeholder="Enter word to search"
  aria-describedby="search-help"
/>
<p id="search-help">Search is case-insensitive and matches partial words</p>
```

**Filter Checkboxes**:
```html
<fieldset>
  <legend>Filter by CEFR Level</legend>
  <label>
    <input type="checkbox" name="cefr" value="A1" />
    A1 (Beginner)
  </label>
  <label>
    <input type="checkbox" name="cefr" value="A2" />
    A2 (Elementary)
  </label>
</fieldset>
```

#### Error Messages

```html
<!-- Associate error with form field -->
<label for="email">Email</label>
<input 
  id="email" 
  type="email" 
  aria-describedby="email-error"
/>
<p id="email-error" role="alert">
  Invalid email format. Please enter a valid email address.
</p>
```

#### Skip Links

```html
<!-- At top of page -->
<a href="#main-content" class="skip-link">Skip to main content</a>

<!-- Main content section -->
<main id="main-content">
  <!-- Page content -->
</main>
```

### Testing Accessibility

1. **Keyboard Navigation**: Navigate entire app using only Tab, Enter, Escape
2. **Screen Reader**: Test with NVDA (Windows), JAWS, or VoiceOver (Mac/iOS)
3. **Color Contrast**: Use WebAIM contrast checker
4. **Automated Testing**: Use axe DevTools, Lighthouse, or WAVE
5. **Manual Testing**: Test with actual users with disabilities


## Error Handling & Resilience

### Network Error Recovery

#### Timeout Handling

**Query Timeout**: 30 seconds
**API Timeout**: 10 seconds
**Audio Timeout**: 5 seconds

```javascript
FUNCTION withTimeout(promise, timeoutMs):
  return Promise.race([
    promise,
    new Promise((_, reject) => 
      setTimeout(() => reject(new TimeoutError()), timeoutMs)
    )
  ])
END FUNCTION
```

#### Retry Logic

**Exponential Backoff**:
```
Attempt 1: Immediate
Attempt 2: Wait 1 second
Attempt 3: Wait 2 seconds
Attempt 4: Wait 4 seconds
Attempt 5: Wait 8 seconds
Max Attempts: 5
```

**Retry Conditions**:
- Network timeout
- 5xx server errors
- Connection refused
- DNS resolution failure

**No Retry**:
- 4xx client errors (except 408, 429)
- Authentication failures
- Validation errors

#### User-Facing Error Messages

**Network Error**:
```
"Connection lost. Your progress has been saved. 
Please check your internet connection."
```

**Timeout Error**:
```
"The request took too long. Please try again."
```

**Server Error**:
```
"We encountered an issue loading your data. 
Please try again in a moment."
```

**Grade Persistence Failure**:
```
"Saving your progress. This will sync when your 
connection is restored."
```

### Offline Support

#### Local Storage Strategy

**Queued Grades**:
```javascript
{
  "queued_grades": [
    {
      "lexicon_entry_id": "uuid-1",
      "grade": "Good",
      "timestamp": "2024-01-15T10:30:00Z"
    },
    {
      "lexicon_entry_id": "uuid-2",
      "grade": "Easy",
      "timestamp": "2024-01-15T10:35:00Z"
    }
  ]
}
```

**Cached Metrics**:
```javascript
{
  "metrics": {
    "total_words_unlocked": 245,
    "words_in_learning": 87,
    "words_mastered": 158,
    "cached_at": "2024-01-15T10:00:00Z"
  }
}
```

#### Sync Strategy

**When Connectivity Restored**:
1. Detect connectivity change (online event)
2. Retrieve queued grades from local storage
3. Send grades to server in order (maintain sequence)
4. If all succeed, clear queue
5. If any fail, retry with exponential backoff
6. Refresh metrics from server

```javascript
FUNCTION syncQueuedGrades():
  IF NOT navigator.onLine:
    RETURN
  
  queued_grades = localStorage.getItem("queued_grades")
  IF NOT queued_grades OR queued_grades.length == 0:
    RETURN
  
  FOR EACH grade IN queued_grades:
    TRY:
      response = await POST /api/practice/grade {grade}
      IF response.status == 200:
        remove grade from queue
      ELSE:
        BREAK (retry later)
    CATCH error:
      BREAK (retry later)
  
  IF queue is empty:
    localStorage.removeItem("queued_grades")
    refreshMetrics()
END FUNCTION
```

#### Service Worker Caching

**Cache Strategy**: Cache-first for static assets, network-first for API calls

```javascript
// Cache static assets (HTML, CSS, JS)
self.addEventListener('install', event => {
  event.waitUntil(
    caches.open('v1').then(cache => {
      return cache.addAll([
        '/',
        '/index.html',
        '/styles.css',
        '/app.js'
      ])
    })
  )
})

// Network-first for API calls
self.addEventListener('fetch', event => {
  if (event.request.url.includes('/api/')) {
    event.respondWith(
      fetch(event.request)
        .then(response => {
          // Cache successful responses
          if (response.status === 200) {
            const cache = caches.open('api-cache')
            cache.then(c => c.put(event.request, response.clone()))
          }
          return response
        })
        .catch(() => {
          // Return cached response if network fails
          return caches.match(event.request)
        })
    )
  }
})
```

### Data Consistency

#### Transaction Guarantees

All SRS updates use database transactions:

```sql
BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
  UPDATE User_Vocabulary_Progress
  SET ease_factor = ?,
      interval_days = ?,
      next_review_date = ?,
      consecutive_correct = ?,
      status = ?,
      total_reviews = total_reviews + 1,
      updated_at = NOW()
  WHERE user_id = ? AND lexicon_entry_id = ?;
COMMIT;
```

**Isolation Level**: SERIALIZABLE to prevent race conditions

**Retry Logic**:
- If transaction fails, retry up to 3 times
- Use exponential backoff between retries
- Log all failures for debugging

#### Optimistic Locking

**Version Column**:
```sql
ALTER TABLE User_Vocabulary_Progress ADD COLUMN version INTEGER DEFAULT 1;

UPDATE User_Vocabulary_Progress
SET ease_factor = ?,
    version = version + 1,
    updated_at = NOW()
WHERE user_id = ? 
  AND lexicon_entry_id = ? 
  AND version = ?;
```

**Conflict Resolution**:
- If version mismatch, fetch latest state
- Reapply user's grade to latest state
- Retry update

#### Audit Logging

```sql
CREATE TABLE Audit_Log (
  id UUID PRIMARY KEY,
  user_id UUID NOT NULL,
  lexicon_entry_id UUID NOT NULL,
  action VARCHAR(50) NOT NULL,
  old_state JSONB,
  new_state JSONB,
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Log every grade
INSERT INTO Audit_Log (user_id, lexicon_entry_id, action, old_state, new_state)
VALUES (?, ?, 'GRADE', ?, ?);
```

### Error Logging

**Error Tracking**:
- Capture all errors with unique error ID
- Log stack trace, user context, and timestamp
- Send to error tracking service (Sentry, Rollbar)
- Display error ID to user for support reference

**Error Message Format**:
```
"An unexpected error occurred. 
Error ID: ERR-2024-01-15-a7f3b2c1
Please contact support with this ID."
```

### Graceful Degradation

**Audio Unavailable**:
- Display: "Audio unavailable for this word"
- Allow user to continue without audio
- Don't block flashcard presentation

**Metrics Unavailable**:
- Display cached metrics if available
- Show: "Metrics may be outdated"
- Retry loading in background

**Search Unavailable**:
- Display: "Search temporarily unavailable"
- Show all vocabulary items
- Allow filtering by CEFR level and unit


## Security

### Authentication

#### Session Management

**Login Flow**:
1. User submits email and password
2. Server validates credentials against hashed password
3. Server generates JWT token with 24-hour expiration
4. Client stores token in secure HTTP-only cookie
5. Client includes token in Authorization header for API requests

**JWT Structure**:
```json
{
  "sub": "user-uuid",
  "email": "[email]",
  "iat": 1705315200,
  "exp": 1705401600,
  "iss": "active-lexicon-engine"
}
```

**Token Refresh**:
- Refresh token stored in HTTP-only cookie with 7-day expiration
- Access token refreshed automatically before expiration
- User re-authentication required if refresh token expires

#### Logout

```javascript
FUNCTION logout():
  1. Clear access token from memory
  2. Clear refresh token cookie (Set-Cookie with Max-Age=0)
  3. Invalidate token on server (add to blacklist)
  4. Redirect to login page
END FUNCTION
```

#### Session Timeout

- **Idle Timeout**: 30 minutes
- **Absolute Timeout**: 24 hours
- **Warning**: Display warning 5 minutes before timeout
- **Action**: Redirect to login page on timeout

### Authorization

#### Role-Based Access Control

**User Roles**:
- `learner`: Can access dashboard, lexicon hub, practice arena
- `admin`: Can manage vocabulary entries, view user analytics
- `instructor`: Can view student progress (future feature)

**Authorization Checks**:
```javascript
FUNCTION requireAuth(req, res, next):
  token = req.headers.authorization?.split(' ')[1]
  
  IF NOT token:
    RETURN res.status(401).json({error: "Unauthorized"})
  
  TRY:
    decoded = jwt.verify(token, SECRET_KEY)
    req.user = decoded
    next()
  CATCH error:
    RETURN res.status(401).json({error: "Invalid token"})
END FUNCTION

FUNCTION requireRole(role):
  RETURN (req, res, next) => {
    IF req.user.role != role:
      RETURN res.status(403).json({error: "Forbidden"})
    next()
  }
END FUNCTION
```

#### Data Isolation

- Users can only access their own progress data
- Query all endpoints with `WHERE user_id = req.user.id`
- Prevent direct access to other users' data via UUID manipulation

```javascript
// Secure endpoint
GET /api/dashboard/metrics
  user_id = req.user.id  // From JWT token
  metrics = query(SELECT ... WHERE user_id = user_id)
  RETURN metrics
```

### Data Encryption

#### At Rest

**Database Encryption**:
- Enable transparent data encryption (TDE) at database level
- Encrypt sensitive columns: `l1_notes`, `user_vocabulary_progress`
- Use AES-256 encryption

**Backup Encryption**:
- Encrypt all database backups
- Store encryption keys separately from backups
- Rotate keys annually

#### In Transit

**HTTPS/TLS**:
- All API endpoints use HTTPS (TLS 1.2+)
- Certificate pinning for mobile apps
- HSTS header: `Strict-Transport-Security: max-age=31536000`

**API Request/Response**:
```
POST /api/practice/grade HTTP/1.1
Host: api.example.com
Authorization: Bearer eyJhbGc...
Content-Type: application/json
Content-Length: 123

{
  "lexicon_entry_id": "uuid-1",
  "grade": "Good"
}
```

### Input Validation

#### SQL Injection Prevention

**Parameterized Queries**:
```javascript
// SAFE: Uses parameterized query
const result = await db.query(
  'SELECT * FROM Master_Lexicon WHERE english_word = $1',
  [userInput]
)

// UNSAFE: String concatenation
const result = await db.query(
  `SELECT * FROM Master_Lexicon WHERE english_word = '${userInput}'`
)
```

#### XSS Prevention

**Output Encoding**:
```javascript
// SAFE: React automatically escapes JSX
<div>{userInput}</div>

// UNSAFE: Direct HTML insertion
<div dangerouslySetInnerHTML={{__html: userInput}} />
```

**Content Security Policy**:
```
Content-Security-Policy: 
  default-src 'self';
  script-src 'self' 'unsafe-inline';
  style-src 'self' 'unsafe-inline';
  img-src 'self' https:;
  font-src 'self';
  connect-src 'self' https://api.example.com
```

#### Input Sanitization

**Search Input**:
```javascript
FUNCTION sanitizeSearch(input):
  // Remove special characters
  sanitized = input.replace(/[^a-zA-Z0-9\s-]/g, '')
  // Limit length
  sanitized = sanitized.substring(0, 100)
  // Trim whitespace
  sanitized = sanitized.trim()
  RETURN sanitized
END FUNCTION
```

**Grade Input**:
```javascript
FUNCTION validateGrade(grade):
  validGrades = ['Hard', 'Good', 'Easy']
  IF grade NOT IN validGrades:
    THROW ERROR: "Invalid grade"
  RETURN grade
END FUNCTION
```

### CORS Configuration

```javascript
const corsOptions = {
  origin: 'https://app.example.com',
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'DELETE'],
  allowedHeaders: ['Content-Type', 'Authorization'],
  maxAge: 3600
}

app.use(cors(corsOptions))
```

### Rate Limiting

**API Rate Limits**:
- Dashboard API: 100 requests/minute per user
- Practice API: 1000 requests/minute per user (high for rapid grading)
- Lexicon API: 500 requests/minute per user
- Auth API: 10 requests/minute per IP (prevent brute force)

**Implementation**:
```javascript
const rateLimit = require('express-rate-limit')

const limiter = rateLimit({
  windowMs: 60 * 1000,  // 1 minute
  max: 100,             // 100 requests per minute
  message: 'Too many requests, please try again later',
  standardHeaders: true,
  legacyHeaders: false
})

app.use('/api/', limiter)
```

### Password Security

**Hashing**:
- Algorithm: bcrypt with salt rounds = 12
- Never store plaintext passwords
- Never log passwords

**Password Requirements**:
- Minimum 8 characters
- At least one uppercase letter
- At least one lowercase letter
- At least one number
- At least one special character

**Password Reset**:
- Send reset link via email (valid for 1 hour)
- Reset link contains secure token
- Require new password confirmation
- Invalidate all existing sessions after reset

### Audit Trail

**Logged Events**:
- User login/logout
- Grade submission
- Status transitions
- Data access (for admin users)
- Failed authentication attempts

**Audit Log Schema**:
```sql
CREATE TABLE Audit_Log (
  id UUID PRIMARY KEY,
  user_id UUID NOT NULL,
  event_type VARCHAR(50) NOT NULL,
  resource_type VARCHAR(50),
  resource_id UUID,
  old_value JSONB,
  new_value JSONB,
  ip_address INET,
  user_agent TEXT,
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_audit_user_timestamp ON Audit_Log(user_id, timestamp);
```

### Dependency Security

**Vulnerability Scanning**:
- Use `npm audit` to identify vulnerable dependencies
- Update dependencies regularly
- Use automated tools (Dependabot, Snyk) for continuous monitoring
- Review security advisories before updating

**Supply Chain Security**:
- Pin dependency versions in package-lock.json
- Review package.json before adding new dependencies
- Use private npm registry for internal packages
- Verify package integrity with checksums


## Correctness Properties

*A property is a characteristic or behavior that should hold true across all valid executions of a system—essentially, a formal statement about what the system should do. Properties serve as the bridge between human-readable specifications and machine-verifiable correctness guarantees.*

### Property 1: Master Lexicon UUID Stability

*For any* vocabulary entry in the Master_Lexicon, retrieving the entry multiple times should always return the same UUID.

**Validates: Requirements 1.2**

### Property 2: Master Lexicon Complete Retrieval

*For any* vocabulary entry in the Master_Lexicon, a single query should return all required properties (UUID, English_Word, CEFR_Level, Unit, Definition, Example_Sentence, Audio_URL, L1_Notes) without requiring additional lookups.

**Validates: Requirements 1.5**

### Property 3: User Progress Initialization

*For any* user encountering a new vocabulary item, initializing the item in User_Vocabulary_Progress should set status="New", ease_factor=2.5, interval_days=1, next_review_date=today, total_reviews=0, and consecutive_correct=0.

**Validates: Requirements 2.2**

### Property 4: Hard Grade Reduces Ease Factor

*For any* vocabulary item with any ease_factor, grading as "Hard" should set the new ease_factor to max(1.3, current_ease_factor - 0.2) and interval_days to 1.

**Validates: Requirements 3.1**

### Property 5: Good Grade Maintains Ease Factor

*For any* vocabulary item with any ease_factor and interval_days, grading as "Good" should maintain the ease_factor and set new interval_days to round(current_interval_days * current_ease_factor).

**Validates: Requirements 3.2**

### Property 6: Easy Grade Increases Ease Factor

*For any* vocabulary item with any ease_factor and interval_days, grading as "Easy" should increase ease_factor by 0.1 and set new interval_days to round(current_interval_days * current_ease_factor * 1.3).

**Validates: Requirements 3.3**

### Property 7: Interval Days Always Positive

*For any* grade (Hard, Good, Easy) applied to any vocabulary item, the resulting interval_days should always be a positive integer (>= 1).

**Validates: Requirements 3.5**

### Property 8: Next Review Date Calculation

*For any* vocabulary item with any interval_days, the next_review_date should equal today + interval_days.

**Validates: Requirements 3.6, 2.6**

### Property 9: Due Words Query Correctness

*For any* user and any set of vocabulary items, the due words query should return exactly those items where next_review_date <= today, sorted by next_review_date in ascending order.

**Validates: Requirements 4.1, 4.5**

### Property 10: Due Words Query Performance

*For any* user with up to 5000 vocabulary items in progress, the due words query should execute in under 100ms.

**Validates: Requirements 4.2**

### Property 11: Metrics Calculation Accuracy

*For any* user, the total_words_unlocked metric should equal the count of items where status != "New", words_in_learning should equal count where status = "Learning", and words_mastered should equal count where status = "Mastered".

**Validates: Requirements 5.2, 5.3, 5.4**

### Property 12: Metrics Refresh Responsiveness

*For any* user who updates a vocabulary item's status, the Progress Dashboard metrics should refresh within 2 seconds.

**Validates: Requirements 5.5**

### Property 13: Due Words Queue Pagination

*For any* user with more than 20 due words, the due words queue should paginate with exactly 20 items per page.

**Validates: Requirements 6.3**

### Property 14: Queue Item Removal After Review

*For any* vocabulary item that is graded and has next_review_date > today, the item should be removed from the due words queue.

**Validates: Requirements 6.4**

### Property 15: Grind Button Conditional Display

*For any* user, the "Grind Due Words" button should be enabled when due words exist and disabled when no due words exist.

**Validates: Requirements 7.1, 7.3**

### Property 16: Grind Button Navigation

*For any* user with due words, clicking "Grind Due Words" should route to the Practice Arena with the first due word (sorted by next_review_date ascending) loaded.

**Validates: Requirements 7.2**

### Property 17: Mobile Button Width

*For any* mobile viewport (< 768px), the "Grind Due Words" button should occupy at least 80% of the viewport width.

**Validates: Requirements 7.5**

### Property 18: Lexicon Hub Search Filtering

*For any* search term, the Lexicon Hub should return only vocabulary entries where English_Word contains the search term (case-insensitive).

**Validates: Requirements 8.3**

### Property 19: Lexicon Hub Multi-Filter AND Logic

*For any* combination of CEFR level, unit, and status filters, the Lexicon Hub should return only entries matching ALL selected filters (AND logic).

**Validates: Requirements 8.7**

### Property 20: Cloze Sentence Generation

*For any* vocabulary entry with an example sentence, the cloze parser should replace the first occurrence of the target word with a blank (___), handling punctuation and capitalization correctly.

**Validates: Requirements 9.2, 21.1, 21.2**

### Property 21: Cloze Sentence Round Trip

*For any* valid example sentence and target word, parsing to cloze, then serializing back to complete sentence, then parsing to cloze again should produce an equivalent cloze sentence.

**Validates: Requirements 21.4**

### Property 22: L1 Notes Format Validation

*For any* L1_Notes entry, the parser should validate the format "term1 vs. term2: explanation" and extract all three components correctly.

**Validates: Requirements 22.2**

### Property 23: L1 Notes Round Trip

*For any* valid L1_Notes entry, parsing to components, then serializing back to text, then parsing again should produce equivalent components.

**Validates: Requirements 22.4**

### Property 24: Reveal Button Hides Answer Initially

*For any* cloze flashcard, the English_Word, Definition, and L1_Notes should not be visible until the user clicks the Reveal button.

**Validates: Requirements 9.4**

### Property 25: Reveal Button Shows All Content

*For any* vocabulary item, clicking the Reveal button should display the English_Word, Definition, and L1_Notes (if present) in a visually distinct section.

**Validates: Requirements 9.6**

### Property 26: Audio Pre-fetching

*For any* user entering the Practice Arena, audio files for the current word and the next 3 words in the queue should be pre-fetched and stored in the browser cache.

**Validates: Requirements 10.3, 14.1**

### Property 27: Audio Playback from Cache

*For any* pre-fetched audio file, clicking the audio button should play the audio from the local cache without requiring a network request.

**Validates: Requirements 10.2, 14.2**

### Property 28: Grade Recording and Progress Update

*For any* grade (Hard, Good, Easy) submitted by a user, the system should record the grade, update the User_Vocabulary_Progress entry with new ease_factor, interval_days, next_review_date, and consecutive_correct, and advance to the next due word.

**Validates: Requirements 11.2, 11.3**

### Property 29: Mastery Transition Threshold

*For any* vocabulary item, when consecutive_correct reaches 3, the status should transition to "Mastered" and interval_days should be set to 30.

**Validates: Requirements 2.4, 20.1, 20.2**

### Property 30: Mastery Demotion on Hard Grade

*For any* vocabulary item in "Mastered" status, grading as "Hard" should transition the status back to "Learning" and reset consecutive_correct to 0.

**Validates: Requirements 20.3**

### Property 31: Grade Persistence Latency

*For any* grade submitted by a user, the grade should be persisted to the database within 1 second.

**Validates: Requirements 12.1**

### Property 32: Offline Grade Queueing

*For any* grade submitted when the network is unavailable, the grade should be queued locally and persisted to the database when connectivity is restored, maintaining the order of grades.

**Validates: Requirements 12.4, 12.5**

### Property 33: Session Resumption

*For any* user who closes the Practice Arena before completing all due words, resuming the session should load the first ungraded due word from the previous session.

**Validates: Requirements 12.3**

### Property 34: Mobile Single Column Layout

*For any* mobile viewport (< 768px), the Practice Arena should arrange all interactive elements (Reveal button, grading buttons, audio button) in a single column layout.

**Validates: Requirements 13.1**

### Property 35: Mobile Touch Target Size

*For any* mobile viewport (< 768px), all buttons in the Practice Arena should have a minimum touch target size of 44px x 44px.

**Validates: Requirements 13.2**

### Property 36: Mobile Cloze Positioning

*For any* mobile viewport (< 768px), the cloze sentence and Reveal button should be positioned in the upper half of the viewport, and grading buttons in the lower half.

**Validates: Requirements 13.3, 13.4**

### Property 37: Mobile Font Size

*For any* mobile viewport (< 768px), the cloze sentence should use a font size of at least 18px.

**Validates: Requirements 13.5**

### Property 38: L1 Notes Highlighting on Hard Grade

*For any* vocabulary item with L1_Notes that is graded as "Hard", the L1_Notes section should be highlighted with a visual indicator (border, background color, or similar).

**Validates: Requirements 15.2**

### Property 39: L1 Notes Progressive Emphasis

*For any* vocabulary item with L1_Notes that is graded as "Hard" twice consecutively, the L1_Notes prominence should increase on the next review (larger font, additional emphasis).

**Validates: Requirements 15.3**

### Property 40: User Authentication Session Isolation

*For any* authenticated user, accessing the system from a different device should display the same progress and due words as their previous session.

**Validates: Requirements 16.3**

### Property 41: Dashboard Metrics Caching

*For any* user, the Progress Dashboard should cache metrics for up to 30 seconds, reducing database queries while maintaining accuracy.

**Validates: Requirements 17.3**

### Property 42: Cache Invalidation on Update

*For any* user who updates a vocabulary item's status, the metrics cache should be invalidated and metrics should refresh within 2 seconds.

**Validates: Requirements 17.4**

### Property 43: Atomic SRS Updates

*For any* grade submitted by a user, all fields (ease_factor, interval_days, next_review_date, consecutive_correct, total_reviews, status) should be updated atomically in a single database transaction.

**Validates: Requirements 18.1**

### Property 44: Transaction Retry Logic

*For any* failed database transaction, the system should retry the operation up to 3 times with exponential backoff before reporting an error to the user.

**Validates: Requirements 18.2**

### Property 45: Mastery Transition Validation

*For any* vocabulary item transitioning to "Mastered" status, the system should verify that consecutive_correct >= 3 before allowing the transition.

**Validates: Requirements 18.3**

### Property 46: Vocabulary Item Duplicate Prevention

*For any* user clicking "Start Learning" on a vocabulary item that already exists in User_Vocabulary_Progress, the system should load the existing entry without creating a duplicate.

**Validates: Requirements 19.3**

### Property 47: Keyboard Tab Navigation

*For any* page in the Active Lexicon Engine, pressing Tab should cycle through all interactive elements in a logical order.

**Validates: Requirements 23.1**

### Property 48: Keyboard Enter Activation

*For any* focused button in the system, pressing Enter should trigger the button's action.

**Validates: Requirements 23.2**

### Property 49: Keyboard Escape Handling

*For any* open modal or detail panel, pressing Escape should close it and return to the previous view.

**Validates: Requirements 23.3**

### Property 50: Practice Arena Keyboard Shortcuts

*For any* user in the Practice Arena, pressing "H" should grade as Hard, "G" should grade as Good, and "E" should grade as Easy.

**Validates: Requirements 23.4**

### Property 51: Lexicon Hub Keyboard Shortcuts

*For any* user in the Lexicon Hub, pressing "S" should focus the search field and "F" should open the filter panel.

**Validates: Requirements 23.5**

### Property 52: Screen Reader Cloze Announcement

*For any* cloze flashcard, a screen reader should announce: "Cloze flashcard. Fill in the blank: [cloze sentence]".

**Validates: Requirements 24.1**

### Property 53: Screen Reader Reveal Button Announcement

*For any* Reveal button, a screen reader should announce: "Reveal. Button. Activates to show the English word, definition, and L1 notes".

**Validates: Requirements 24.2**

### Property 54: Screen Reader Grading Buttons Announcement

*For any* grading button, a screen reader should announce the button name and its effect (e.g., "Hard button. Grades this word as difficult. It will appear again tomorrow").

**Validates: Requirements 24.3**

### Property 55: Unauthenticated Access Redirect

*For any* user attempting to access a protected resource without authentication, the system should redirect to the login page.

**Validates: Requirements 25.4**

### Property 56: Offline Grade Persistence Message

*For any* grade submitted when the network is unavailable, the system should display: "Saving your progress. This will sync when your connection is restored."

**Validates: Requirements 25.3**


## Testing Strategy

### Dual Testing Approach

The Active Lexicon Engine requires both unit tests and property-based tests for comprehensive coverage:

**Unit Tests**: Verify specific examples, edge cases, and error conditions
- Test concrete scenarios with known inputs and outputs
- Validate error handling and boundary conditions
- Test integration points between components
- Focus on user-facing error messages

**Property-Based Tests**: Verify universal properties across all inputs
- Test that properties hold for randomly generated inputs
- Validate algorithm correctness across input ranges
- Ensure consistency across different execution paths
- Minimum 100 iterations per property test

### Unit Testing Strategy

#### Master Lexicon Tests

```javascript
describe('Master_Lexicon', () => {
  test('should store vocabulary entry with all required properties', () => {
    const entry = {
      english_word: 'have',
      cefr_level: 'A1',
      unit: 'Unit 1',
      definition: 'to possess or own',
      example_sentence: 'I have breakfast at 7 AM',
      audio_url: 'https://audio.example.com/have.mp3',
      l1_notes: 'make vs. do: Use make for creating; use do for actions'
    }
    const result = createVocabularyEntry(entry)
    expect(result.id).toBeDefined()
    expect(result.english_word).toBe('have')
  })

  test('should prevent duplicate vocabulary entries', () => {
    const entry = { english_word: 'have', ... }
    createVocabularyEntry(entry)
    expect(() => createVocabularyEntry(entry)).toThrow('Duplicate entry')
  })

  test('should handle missing L1_Notes gracefully', () => {
    const entry = { english_word: 'run', ..., l1_notes: null }
    const result = createVocabularyEntry(entry)
    expect(result.l1_notes).toBeNull()
  })
})
```

#### SRS Algorithm Tests

```javascript
describe('SRS Algorithm', () => {
  test('Hard grade should reset interval to 1 and reduce ease factor', () => {
    const state = { ease_factor: 2.5, interval_days: 5, consecutive_correct: 2 }
    const result = updateProgress('Hard', state)
    expect(result.interval_days).toBe(1)
    expect(result.ease_factor).toBe(2.3)
    expect(result.consecutive_correct).toBe(0)
  })

  test('Good grade should maintain ease factor and multiply interval', () => {
    const state = { ease_factor: 2.5, interval_days: 1, consecutive_correct: 0 }
    const result = updateProgress('Good', state)
    expect(result.ease_factor).toBe(2.5)
    expect(result.interval_days).toBe(2) // 1 * 2.5 rounded
    expect(result.consecutive_correct).toBe(1)
  })

  test('Easy grade should increase ease factor and multiply interval by 1.3', () => {
    const state = { ease_factor: 2.5, interval_days: 1, consecutive_correct: 0 }
    const result = updateProgress('Easy', state)
    expect(result.ease_factor).toBe(2.6)
    expect(result.interval_days).toBe(3) // 1 * 2.5 * 1.3 rounded
    expect(result.consecutive_correct).toBe(1)
  })

  test('should transition to Mastered when consecutive_correct reaches 3', () => {
    const state = { status: 'Learning', consecutive_correct: 2, interval_days: 5 }
    const result = updateProgress('Good', state)
    expect(result.status).toBe('Mastered')
    expect(result.interval_days).toBe(30)
  })

  test('should demote from Mastered to Learning on Hard grade', () => {
    const state = { status: 'Mastered', consecutive_correct: 3, interval_days: 30 }
    const result = updateProgress('Hard', state)
    expect(result.status).toBe('Learning')
    expect(result.consecutive_correct).toBe(0)
    expect(result.interval_days).toBe(1)
  })

  test('should maintain Mastered status on Good or Easy grade', () => {
    const state = { status: 'Mastered', consecutive_correct: 3, interval_days: 30 }
    const resultGood = updateProgress('Good', state)
    const resultEasy = updateProgress('Easy', state)
    expect(resultGood.status).toBe('Mastered')
    expect(resultEasy.status).toBe('Mastered')
  })

  test('should ensure ease factor never goes below 1.3', () => {
    const state = { ease_factor: 1.4, interval_days: 1, consecutive_correct: 0 }
    const result = updateProgress('Hard', state)
    expect(result.ease_factor).toBe(1.3)
  })
})
```

#### Cloze Parser Tests

```javascript
describe('Cloze Parser', () => {
  test('should replace first occurrence of target word with blank', () => {
    const result = parseCloze('I have breakfast at 7 AM', 'have')
    expect(result).toBe('I _____ breakfast at 7 AM')
  })

  test('should handle punctuation attached to word', () => {
    const result = parseCloze('I have, you have.', 'have')
    expect(result).toBe('I _____, you have.')
  })

  test('should handle capitalization at sentence start', () => {
    const result = parseCloze('Have breakfast at 7 AM', 'have')
    expect(result).toBe('_____ breakfast at 7 AM')
  })

  test('should throw error if target word not found', () => {
    expect(() => parseCloze('I eat breakfast', 'have')).toThrow('Target word not found')
  })

  test('should replace only first occurrence', () => {
    const result = parseCloze('I have have breakfast', 'have')
    expect(result).toBe('I _____ have breakfast')
  })
})
```

#### L1 Notes Parser Tests

```javascript
describe('L1 Notes Parser', () => {
  test('should parse valid L1_Notes format', () => {
    const result = parseL1Notes('make vs. do: Use make for creating; use do for actions')
    expect(result.term1).toBe('make')
    expect(result.term2).toBe('do')
    expect(result.explanation).toBe('Use make for creating; use do for actions')
  })

  test('should throw error for invalid format', () => {
    expect(() => parseL1Notes('make and do: explanation')).toThrow('Invalid L1_Notes format')
    expect(() => parseL1Notes('make vs. do explanation')).toThrow('Invalid L1_Notes format')
  })
})
```

#### Query Tests

```javascript
describe('Due Words Query', () => {
  test('should return only items where next_review_date <= today', () => {
    const today = new Date()
    const yesterday = new Date(today.getTime() - 86400000)
    const tomorrow = new Date(today.getTime() + 86400000)
    
    createProgress({ next_review_date: yesterday })
    createProgress({ next_review_date: today })
    createProgress({ next_review_date: tomorrow })
    
    const result = getDueWords(userId)
    expect(result.length).toBe(2)
  })

  test('should return results sorted by next_review_date ascending', () => {
    const today = new Date()
    createProgress({ next_review_date: today })
    createProgress({ next_review_date: new Date(today.getTime() - 86400000) })
    
    const result = getDueWords(userId)
    expect(result[0].next_review_date).toBeLessThan(result[1].next_review_date)
  })

  test('should return empty array when no due words', () => {
    const result = getDueWords(userId)
    expect(result).toEqual([])
  })
})
```

### Property-Based Testing Strategy

#### SRS Algorithm Properties

```javascript
// Using fast-check for property-based testing
import fc from 'fast-check'

describe('SRS Algorithm Properties', () => {
  // Feature: active-lexicon-engine, Property 4: Hard Grade Reduces Ease Factor
  test('Hard grade should always reduce ease factor by 0.2 (minimum 1.3)', () => {
    fc.assert(
      fc.property(
        fc.float({ min: 1.3, max: 2.5 }),
        fc.integer({ min: 1, max: 365 }),
        (easeFactorBefore, intervalDays) => {
          const state = { ease_factor: easeFactorBefore, interval_days: intervalDays }
          const result = updateProgress('Hard', state)
          
          const expectedEase = Math.max(1.3, easeFactorBefore - 0.2)
          expect(result.ease_factor).toBe(expectedEase)
          expect(result.interval_days).toBe(1)
        }
      ),
      { numRuns: 100 }
    )
  })

  // Feature: active-lexicon-engine, Property 5: Good Grade Maintains Ease Factor
  test('Good grade should maintain ease factor and multiply interval', () => {
    fc.assert(
      fc.property(
        fc.float({ min: 1.3, max: 2.5 }),
        fc.integer({ min: 1, max: 365 }),
        (easeFactor, intervalDays) => {
          const state = { ease_factor: easeFactor, interval_days: intervalDays }
          const result = updateProgress('Good', state)
          
          expect(result.ease_factor).toBe(easeFactor)
          expect(result.interval_days).toBe(Math.round(intervalDays * easeFactor))
          expect(result.consecutive_correct).toBe(1)
        }
      ),
      { numRuns: 100 }
    )
  })

  // Feature: active-lexicon-engine, Property 7: Interval Days Always Positive
  test('Interval days should always be positive integer after any grade', () => {
    fc.assert(
      fc.property(
        fc.oneof(fc.constant('Hard'), fc.constant('Good'), fc.constant('Easy')),
        fc.float({ min: 1.3, max: 2.5 }),
        fc.integer({ min: 1, max: 365 }),
        (grade, easeFactor, intervalDays) => {
          const state = { ease_factor: easeFactor, interval_days: intervalDays }
          const result = updateProgress(grade, state)
          
          expect(result.interval_days).toBeGreaterThanOrEqual(1)
          expect(Number.isInteger(result.interval_days)).toBe(true)
        }
      ),
      { numRuns: 100 }
    )
  })

  // Feature: active-lexicon-engine, Property 29: Mastery Transition Threshold
  test('Status should transition to Mastered when consecutive_correct reaches 3', () => {
    fc.assert(
      fc.property(
        fc.integer({ min: 0, max: 2 }),
        (consecutiveCorrect) => {
          const state = { status: 'Learning', consecutive_correct: consecutiveCorrect }
          const result = updateProgress('Good', state)
          
          if (consecutiveCorrect + 1 >= 3) {
            expect(result.status).toBe('Mastered')
            expect(result.interval_days).toBe(30)
          } else {
            expect(result.status).toBe('Learning')
          }
        }
      ),
      { numRuns: 100 }
    )
  })
})
```

#### Cloze Parser Properties

```javascript
describe('Cloze Parser Properties', () => {
  // Feature: active-lexicon-engine, Property 21: Cloze Sentence Round Trip
  test('Parsing then serializing then parsing should produce equivalent cloze', () => {
    fc.assert(
      fc.property(
        fc.string({ minLength: 5, maxLength: 100 }),
        fc.string({ minLength: 1, maxLength: 20 }),
        (sentence, word) => {
          // Only test if word is in sentence
          if (!sentence.toLowerCase().includes(word.toLowerCase())) {
            return
          }
          
          const cloze1 = parseCloze(sentence, word)
          const restored = serializeCloze(cloze1, word)
          const cloze2 = parseCloze(restored, word)
          
          expect(cloze1).toBe(cloze2)
        }
      ),
      { numRuns: 100 }
    )
  })
})
```

#### L1 Notes Parser Properties

```javascript
describe('L1 Notes Parser Properties', () => {
  // Feature: active-lexicon-engine, Property 23: L1 Notes Round Trip
  test('Parsing then serializing then parsing should produce equivalent L1_Notes', () => {
    fc.assert(
      fc.property(
        fc.string({ minLength: 1, maxLength: 20 }),
        fc.string({ minLength: 1, maxLength: 20 }),
        fc.string({ minLength: 1, maxLength: 100 }),
        (term1, term2, explanation) => {
          const l1Notes = `${term1} vs. ${term2}: ${explanation}`
          
          const parsed1 = parseL1Notes(l1Notes)
          const serialized = serializeL1Notes(parsed1)
          const parsed2 = parseL1Notes(serialized)
          
          expect(parsed1.term1).toBe(parsed2.term1)
          expect(parsed1.term2).toBe(parsed2.term2)
          expect(parsed1.explanation).toBe(parsed2.explanation)
        }
      ),
      { numRuns: 100 }
    )
  })
})
```

#### Query Performance Properties

```javascript
describe('Query Performance Properties', () => {
  // Feature: active-lexicon-engine, Property 10: Due Words Query Performance
  test('Due words query should execute in under 100ms for 5000+ items', () => {
    fc.assert(
      fc.property(
        fc.integer({ min: 5000, max: 10000 }),
        (itemCount) => {
          // Generate random progress items
          const items = fc.sample(
            fc.record({
              next_review_date: fc.date({ min: new Date('2024-01-01'), max: new Date() })
            }),
            itemCount
          )
          
          const startTime = performance.now()
          const result = getDueWords(userId, items)
          const endTime = performance.now()
          
          expect(endTime - startTime).toBeLessThan(100)
        }
      ),
      { numRuns: 10 }
    )
  })
})
```

### Test Configuration

**Property-Based Test Framework**: fast-check (JavaScript/TypeScript)

**Minimum Iterations**: 100 per property test

**Test Tagging Format**:
```javascript
// Feature: active-lexicon-engine, Property 4: Hard Grade Reduces Ease Factor
test('Hard grade should always reduce ease factor by 0.2 (minimum 1.3)', () => {
  // test implementation
})
```

### Coverage Goals

- **Unit Tests**: 80% code coverage minimum
- **Property Tests**: All 56 correctness properties implemented
- **Integration Tests**: Critical user paths (login → dashboard → practice → grade)
- **Performance Tests**: Query performance, load time, cache effectiveness
- **Accessibility Tests**: Keyboard navigation, screen reader compatibility
- **Error Handling Tests**: Network failures, offline scenarios, invalid input

### Continuous Integration

- Run all tests on every commit
- Property tests run with 100+ iterations
- Performance tests run on staging environment
- Accessibility tests run with automated tools (axe, Lighthouse)
- Generate coverage reports and fail if below 80%
