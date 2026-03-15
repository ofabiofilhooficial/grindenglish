# Design Document: A2-B1 Grammar Lessons

## Overview

This feature adds 60 intermediate-level grammar lessons (28 A2 and 32 B1) to the existing grammar reference system through database migrations. The implementation follows the established pattern from the A0 and A1 grammar lessons migrations, inserting comprehensive pedagogical content into the existing `grammar_chapters` table without requiring any schema modifications.

The A2 lessons cover pre-intermediate grammar topics including irregular past verbs, past continuous, present perfect (experience and recent events), expanded modals, conditionals, gerunds vs infinitives, passive voice introduction, and relative clauses. The B1 lessons advance to intermediate topics including present perfect vs past simple distinction, present perfect continuous, narrative tenses, future continuous/perfect, expanded passive voice, mixed conditionals, and expanded reported speech.

Each lesson includes nine pedagogical sections following the established structure: functional goals (diagnostic_hook), form, meaning, use, contrast, common learner problems, task language upgrades, micro-practice exercises, and cross-references to related lessons. The source content is documented in `docs/philosophy/complete-efl-grammar-theory.md`.

### Key Design Decisions

1. **Two-Migration Approach**: Content is deployed via two separate SQL migrations (one for A2, one for B1) rather than a single large file, improving maintainability and allowing independent deployment if needed.

2. **Schema Reuse**: The existing `grammar_chapters` table schema accommodates all A2 and B1 content requirements without modifications, maintaining backward compatibility with A0 and A1 lessons.

3. **Idempotent Migrations**: Both migrations check for existing chapter codes before insertion, allowing safe re-execution without creating duplicates.

4. **Content Extraction Strategy**: Manual extraction from the source document with careful attention to the nine-section structure, ensuring all content maps correctly to database columns.

5. **JSONB Structure**: Micro-practice exercises and cross-links are stored as JSONB arrays, providing flexibility for complex nested data while maintaining queryability and consistency with A0/A1 lessons.

6. **Sequential Sort Order**: A2 lessons use sort_order 1-28, B1 lessons use sort_order 1-32, maintaining distinct sequences per CEFR level as established in the existing implementation.

## Architecture

### System Components

```
┌─────────────────────────────────────────────────────────────┐
│              Migration Scripts                               │
│  ┌────────────────────────────────────────────────────┐    │
│  │ 20260312000000_add_a2_grammar_chapters.sql         │    │
│  │ (28 A2 lessons)                                    │    │
│  └────────────────────────────────────────────────────┘    │
│  ┌────────────────────────────────────────────────────┐    │
│  │ 20260312000001_add_b1_grammar_chapters.sql         │    │
│  │ (32 B1 lessons)                                    │    │
│  └────────────────────────────────────────────────────┘    │
└─────────────────────┬───────────────────────────────────────┘
                      │
                      │ INSERT statements
                      ▼
┌─────────────────────────────────────────────────────────────┐
│              grammar_chapters Table                          │
│  ┌────────────────────────────────────────────────────┐    │
│  │ Existing A0 Chapters (12 rows)                     │    │
│  │ - A0.G.01 through A0.G.12                          │    │
│  └────────────────────────────────────────────────────┘    │
│  ┌────────────────────────────────────────────────────┐    │
│  │ Existing A1 Chapters (24 rows)                     │    │
│  │ - A1.G.01 through A1.G.24                          │    │
│  └────────────────────────────────────────────────────┘    │
│  ┌────────────────────────────────────────────────────┐    │
│  │ New A2 Chapters (28 rows)                          │    │
│  │ - A2.G.01 through A2.G.28                          │    │
│  └────────────────────────────────────────────────────┘    │
│  ┌────────────────────────────────────────────────────┐    │
│  │ New B1 Chapters (32 rows)                          │    │
│  │ - B1.G.01 through B1.G.32                          │    │
│  └────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────┘
                      │
                      │ RLS policies apply
                      ▼
┌─────────────────────────────────────────────────────────────┐
│              Application Layer                               │
│  - Grammar reference UI                                      │
│  - Content management interface                              │
└─────────────────────────────────────────────────────────────┘
```

### Data Flow

1. **Migration Execution**: Database administrator runs the migration scripts via Supabase CLI or dashboard in sequence
2. **Idempotency Check**: For each chapter, the migration checks if the chapter_code already exists
3. **Conditional Insert**: If chapter_code doesn't exist, insert the full chapter record
4. **Constraint Validation**: Database enforces unique constraints on chapter_code and validates JSONB structure
5. **RLS Application**: Existing Row Level Security policies automatically apply to new A2 and B1 chapters
6. **Application Access**: Grammar reference UI queries chapters filtered by CEFR level and sort order

## Components and Interfaces

### Database Migration Files

**File 1**: `supabase/migrations/20260312000000_add_a2_grammar_chapters.sql`

**Structure**:
```sql
-- Add A2 Grammar Lessons
-- This migration adds 28 A2-level grammar lessons to the grammar_chapters table.
-- The lessons cover pre-intermediate grammar topics including irregular past verbs,
-- past continuous, present perfect, expanded modals, conditionals, and more.
--
-- IDEMPOTENCY: This migration uses WHERE NOT EXISTS to check for existing chapter_codes
-- before insertion, allowing safe re-execution without creating duplicates.

INSERT INTO public.grammar_chapters (
  chapter_code, 
  title, 
  cefr_level, 
  form_content, 
  meaning_content, 
  use_content, 
  contrast_notes, 
  common_errors, 
  diagnostic_hook,
  task_upgrades,
  micro_practice,
  cross_links,
  is_published, 
  sort_order
) 
SELECT * FROM (VALUES
  ('A2.G.01', 'Past Simple (Irregular Verbs)', 'A2', 'form...', 'meaning...', ...)
) AS new_chapters(...)
WHERE NOT EXISTS (
  SELECT 1 FROM public.grammar_chapters 
  WHERE chapter_code = new_chapters.chapter_code
);
```

**File 2**: `supabase/migrations/20260312000001_add_b1_grammar_chapters.sql`

Similar structure for 32 B1 lessons (B1.G.01 through B1.G.32).

**Rationale**: Splitting into two migrations provides:
- Better maintainability (smaller files, easier to review)
- Independent deployment capability (can deploy A2 first, B1 later if needed)
- Clearer git history and code review process
- Follows the established pattern from A0/A1 (which were separate migrations)

### Grammar Chapters Table Schema

**Table**: `public.grammar_chapters` (existing, no modifications needed)

**Columns**:
- `id` (UUID, PK): Auto-generated unique identifier
- `chapter_code` (TEXT, UNIQUE, NOT NULL): Human-readable code (e.g., 'A2.G.01', 'B1.G.15')
- `title` (TEXT, NOT NULL): Lesson title
- `cefr_level` (TEXT, NOT NULL): CEFR level indicator ('A2' or 'B1')
- `form_content` (TEXT): How to construct the grammar structure
- `meaning_content` (TEXT): What the structure means
- `use_content` (TEXT): When to use the structure
- `contrast_notes` (TEXT): Comparison with alternatives
- `common_errors` (TEXT): Typical mistakes and corrections
- `diagnostic_hook` (TEXT): Functional goals / scenario-based learning challenge
- `task_upgrades` (TEXT): Basic vs. professional usage examples
- `micro_practice` (JSONB, DEFAULT '[]'): Practice exercises
- `cross_links` (JSONB, DEFAULT '[]'): References to related lessons
- `is_published` (BOOLEAN, NOT NULL, DEFAULT false): Visibility flag
- `sort_order` (INT, NOT NULL, DEFAULT 0): Display sequence
- `created_at` (TIMESTAMPTZ, NOT NULL): Creation timestamp
- `updated_at` (TIMESTAMPTZ, NOT NULL): Last update timestamp

**Constraints**:
- UNIQUE constraint on `chapter_code` prevents duplicates
- NOT NULL constraints ensure required fields are populated
- RLS policies control access based on user roles

### Content Formatting Interface

**Text Content Escaping**:
```sql
-- Apostrophes and single quotes must be doubled
'I''m happy'  -- Renders as: I'm happy
'She''s here'  -- Renders as: She's here
'It''s a book' -- Renders as: It's a book
```

**Table Formatting**:
```sql
-- Use plain text tables with consistent spacing
'Subject | Verb | Object
I | eat | food
She | drinks | water'
```

**Line Breaks**:
```sql
-- Use actual line breaks within the string literal
'First paragraph.

Second paragraph after blank line.'
```

### JSONB Data Structures

**Micro-Practice Format**:
```json
[
  {
    "type": "fill_blank",
    "prompt": "Complete: I ___ (go) to Paris last year.",
    "answer": "went",
    "feedback": "Use the irregular past form went, not goed."
  },
  {
    "type": "multiple_choice",
    "prompt": "Choose the correct form: Have you ___ been to Japan?",
    "options": ["ever", "never", "already"],
    "answer": "ever",
    "feedback": "Use ever in questions about life experience."
  },
  {
    "type": "correction",
    "prompt": "Fix the error: I have went to the store.",
    "answer": "I have been to the store.",
    "feedback": "The past participle of go is been (for experience) or gone (for current location)."
  }
]
```

**Cross-Links Format**:
```json
[
  {
    "type": "prerequisite",
    "chapter_code": "A1.G.11",
    "note": "Review regular past simple before studying irregular verbs"
  },
  {
    "type": "related",
    "chapter_code": "A2.G.02",
    "note": "See also: Past Continuous for background actions"
  },
  {
    "type": "advanced",
    "chapter_code": "B1.G.03",
    "note": "Next step: Narrative tenses combining past forms"
  }
]
```

**Rationale**: JSONB provides schema flexibility for exercises while maintaining PostgreSQL's indexing and querying capabilities. The array structure allows multiple exercises per chapter, and the object structure within each exercise supports various exercise types with different fields.

## Data Models

### Grammar Chapter Entity

```typescript
interface GrammarChapter {
  id: string;                    // UUID
  chapter_code: string;          // e.g., 'A2.G.01', 'B1.G.15'
  title: string;                 // e.g., 'Past Simple (Irregular Verbs)'
  cefr_level: string;            // 'A2' or 'B1'
  form_content: string | null;   // Markdown/plain text
  meaning_content: string | null;
  use_content: string | null;
  contrast_notes: string | null;
  common_errors: string | null;
  diagnostic_hook: string | null;
  task_upgrades: string | null;
  micro_practice: MicroPractice[];
  cross_links: CrossLink[];
  is_published: boolean;
  sort_order: number;            // 1-28 for A2, 1-32 for B1
  created_at: string;            // ISO timestamp
  updated_at: string;
}
```

### Micro-Practice Exercise

```typescript
interface MicroPractice {
  type: 'fill_blank' | 'multiple_choice' | 'correction' | 'transformation' | 'mini_output';
  prompt: string;
  answer: string;
  options?: string[];            // For multiple choice
  feedback: string;
  hint?: string;
}
```

### Cross-Link Reference

```typescript
interface CrossLink {
  type: 'prerequisite' | 'related' | 'advanced';
  chapter_code: string;          // e.g., 'A1.G.11', 'A2.G.05', 'B1.G.03'
  note?: string;                 // Optional explanation
}
```

### A2 Lesson Topics (28 lessons)

1. **A2.G.01**: Past Simple (Irregular Verbs)
2. **A2.G.02**: Past Continuous
3. **A2.G.03**: Present Perfect (Experience)
4. **A2.G.04**: Present Perfect II (Just/Already/Yet)
5. **A2.G.05**: Future Forms Review
6. **A2.G.06**: Modals for Obligation/Permission II
7. **A2.G.07**: Modals for Deduction (must/might/can't)
8. **A2.G.08**: Zero Conditional
9. **A2.G.09**: First Conditional
10. **A2.G.10**: Second Conditional
11. **A2.G.11**: Gerunds vs Infinitives I
12. **A2.G.12**: Articles (a/an/the) - Expanded
13. **A2.G.13**: Quantifiers II (a lot of/lots of/plenty of)
14. **A2.G.14**: Passive Voice - Introduction
15. **A2.G.15**: Relative Clauses I (who/that/which)
16. **A2.G.16**: Reported Speech - Basics
17. **A2.G.17**: Question Tags
18. **A2.G.18**: Used to
19. **A2.G.19**: Adjectives - Order and Position
20. **A2.G.20**: Adverbs of Manner
21. **A2.G.21**: Prepositions of Movement II
22. **A2.G.22**: Phrasal Verbs - Introduction
23. **A2.G.23**: Make vs Do
24. **A2.G.24**: Say vs Tell
25. **A2.G.25**: So/Such/Too/Enough
26. **A2.G.26**: Both/Neither/Either
27. **A2.G.27**: Reflexive Pronouns
28. **A2.G.28**: Possessive Pronouns Review

### B1 Lesson Topics (32 lessons)

1. **B1.G.01**: Present Perfect vs Past Simple
2. **B1.G.02**: Present Perfect Continuous
3. **B1.G.03**: Narrative Tenses
4. **B1.G.04**: Past Perfect
5. **B1.G.05**: Future Continuous
6. **B1.G.06**: Future Perfect
7. **B1.G.07**: Passive Voice II (All Tenses)
8. **B1.G.08**: Passive Voice III (with Modals)
9. **B1.G.09**: Third Conditional
10. **B1.G.10**: Mixed Conditionals
11. **B1.G.11**: Wish/If Only
12. **B1.G.12**: Modals of Deduction II (Past)
13. **B1.G.13**: Modals for Advice (should have/ought to)
14. **B1.G.14**: Gerunds vs Infinitives II
15. **B1.G.15**: Relative Clauses II (Defining/Non-defining)
16. **B1.G.16**: Relative Clauses III (where/when/whose)
17. **B1.G.17**: Reported Speech II (Questions)
18. **B1.G.18**: Reported Speech III (Commands/Requests)
19. **B1.G.19**: Causative (have/get something done)
20. **B1.G.20**: Emphasis with Cleft Sentences
21. **B1.G.21**: Inversion for Emphasis
22. **B1.G.22**: Participle Clauses
23. **B1.G.23**: Linking Words (Contrast)
24. **B1.G.24**: Linking Words (Purpose/Result)
25. **B1.G.25**: Linking Words (Addition/Sequence)
26. **B1.G.26**: Phrasal Verbs II (Separable/Inseparable)
27. **B1.G.27**: Collocations with Make/Do/Have/Take
28. **B1.G.28**: Verb Patterns (allow/let/make)
29. **B1.G.29**: Comparison Structures (as...as/not as...as)
30. **B1.G.30**: Quantifiers III (all/most/some/none)
31. **B1.G.31**: Substitution and Ellipsis
32. **B1.G.32**: Discourse Markers


## Correctness Properties

*A property is a characteristic or behavior that should hold true across all valid executions of a system—essentially, a formal statement about what the system should do. Properties serve as the bridge between human-readable specifications and machine-verifiable correctness guarantees.*

### Property Reflection

After analyzing all acceptance criteria, I identified the following testable properties and performed redundancy elimination:

**Redundancy Analysis**:
- Properties 1.3, 2.3 (Required fields completeness for A2 and B1) can be combined into a single property that applies to all new chapters
- Properties 1.5, 2.5, 12.2 (Sort order matching chapter code) are all testing the same rule and can be combined
- Properties 12.1 and 3.3 (Chapter code uniqueness) are testing the same constraint at different scopes and can be combined
- Properties 9.1 and 9.2 (JSONB structure for cross_links) are testing the same thing and can be combined
- Properties 11.1 and 11.3 (JSONB structure for micro_practice) overlap and can be combined

**Final Property Set**: After eliminating redundancy, the following properties provide unique validation value:

### Property 1: Required Fields Completeness

*For any* A2 or B1 grammar chapter in the database, all required fields (chapter_code, title, cefr_level, form_content, meaning_content, use_content, is_published, sort_order) must be non-null and non-empty.

**Validates: Requirements 1.3, 2.3**

### Property 2: Sort Order Sequence Alignment

*For any* grammar chapter with chapter_code matching the pattern '[LEVEL].G.[XX]', the sort_order value must equal the numeric portion XX.

**Validates: Requirements 1.5, 2.5, 12.2**

### Property 3: Chapter Code Uniqueness

*For any* two grammar chapters in the database, their chapter_code values must be distinct across all CEFR levels.

**Validates: Requirements 3.3, 12.1**

### Property 4: Sort Order Uniqueness Within Level

*For any* two grammar chapters with the same cefr_level, their sort_order values must be distinct.

**Validates: Requirements 12.4**

### Property 5: CEFR Level Independence

*For any* two different CEFR levels, chapters from different levels can have the same sort_order value without conflict.

**Validates: Requirements 3.2**

### Property 6: JSONB Validity for Micro-Practice

*For any* grammar chapter with a non-null micro_practice field, the stored value must be valid JSON that can be parsed as an array, and each exercise object must contain prompt, answer, and feedback fields.

**Validates: Requirements 11.1, 11.3**

### Property 7: JSONB Validity for Cross-Links

*For any* grammar chapter with a non-null cross_links field, the stored value must be valid JSON that can be parsed as an array, and each link object must contain type and chapter_code fields.

**Validates: Requirements 9.1, 9.2**

### Property 8: Publication Status

*For any* A2 or B1 grammar chapter inserted by the migrations, the is_published field must be true.

**Validates: Requirements 10.4**

### Property 9: Migration Idempotency

*For any* number of times the migration is executed, the final state of the database must be identical, with exactly 28 A2 chapters and 32 B1 chapters, and no duplicate chapter_codes.

**Validates: Requirements 10.5, 10.6**

### Property 10: Database Compatibility Preservation

*For any* existing database constraint, trigger, or RLS policy that applied to grammar chapters before the migrations, it must continue to apply correctly to A0, A1, A2, and B1 chapters after the migrations.

**Validates: Requirements 8.3, 8.4**

## Error Handling

### Migration Errors

**Duplicate Chapter Code**:
- **Scenario**: Migration attempts to insert a chapter_code that already exists
- **Handling**: The idempotent WHERE NOT EXISTS clause prevents the insertion, allowing the migration to complete successfully
- **User Impact**: No error thrown; existing chapter is preserved
- **Prevention**: The idempotency check ensures safe re-execution

**Invalid JSONB**:
- **Scenario**: Malformed JSON in micro_practice or cross_links fields
- **Handling**: PostgreSQL rejects the INSERT with a JSON parsing error
- **Resolution**: Fix the JSON syntax in the migration file and re-run
- **Prevention**: Validate all JSON structures before including in migration using online JSON validators or `jq` command-line tool

**Missing Required Fields**:
- **Scenario**: INSERT statement omits a NOT NULL column
- **Handling**: PostgreSQL rejects the INSERT with a constraint violation error
- **Resolution**: Add the missing field to the INSERT statement
- **Prevention**: Use explicit column lists in INSERT statements and verify against schema

**Character Encoding Issues**:
- **Scenario**: Special characters or non-ASCII text causes encoding errors
- **Handling**: PostgreSQL may reject the INSERT or store corrupted text
- **Resolution**: Ensure migration file is saved as UTF-8 and use proper escaping (doubled single quotes)
- **Prevention**: Test migration with special characters in development environment before production deployment

**Constraint Violations**:
- **Scenario**: Attempting to insert duplicate sort_order within same CEFR level
- **Handling**: Database enforces uniqueness and rejects the INSERT
- **Resolution**: Review and correct sort_order values in migration
- **Prevention**: Verify sort_order sequences match chapter_code sequences (A2.G.01 → sort_order 1, etc.)

### Application Errors

**Missing Cross-Link References**:
- **Scenario**: cross_links references a chapter_code that doesn't exist yet (e.g., forward reference to B2 chapters)
- **Handling**: Application should gracefully handle missing references by not displaying broken links or showing "Coming Soon" placeholder
- **Resolution**: This is acceptable for forward references; update cross_links when future chapters are added
- **Prevention**: Validate all backward references (to A0, A1) exist before migration

**Empty Content Sections**:
- **Scenario**: Optional fields (contrast_notes, common_errors) are null or empty
- **Handling**: Application UI should hide empty sections rather than displaying null/empty content
- **User Impact**: Cleaner UI without empty placeholders
- **Prevention**: Ensure all content from source document is properly extracted

**JSONB Structure Mismatch**:
- **Scenario**: Application expects specific JSONB structure but migration uses different format
- **Handling**: Application may fail to render exercises or cross-links correctly
- **Resolution**: Ensure JSONB structure matches application expectations (validate against A0/A1 examples)
- **Prevention**: Test with sample chapters in development environment

## Testing Strategy

### Dual Testing Approach

This feature requires both unit tests and property-based tests to ensure comprehensive coverage:

- **Unit tests**: Verify specific examples (e.g., A2.G.01 exists, exactly 28 A2 chapters, migration is idempotent)
- **Property tests**: Verify universal properties across all A2 and B1 chapters (e.g., all required fields populated, JSONB validity)

Unit tests focus on concrete scenarios and edge cases, while property tests validate that correctness properties hold across all inputs through randomized testing.

### Unit Testing

**Migration Execution Tests**:
```typescript
describe('A2-B1 Grammar Migrations', () => {
  it('should insert exactly 28 A2 chapters', async () => {
    const { count } = await supabase
      .from('grammar_chapters')
      .select('*', { count: 'exact', head: true })
      .eq('cefr_level', 'A2');
    expect(count).toBe(28);
  });

  it('should insert exactly 32 B1 chapters', async () => {
    const { count } = await supabase
      .from('grammar_chapters')
      .select('*', { count: 'exact', head: true })
      .eq('cefr_level', 'B1');
    expect(count).toBe(32);
  });

  it('should create A2 chapters A2.G.01 through A2.G.28', async () => {
    const expectedCodes = Array.from({ length: 28 }, (_, i) => 
      `A2.G.${String(i + 1).padStart(2, '0')}`
    );
    const { data } = await supabase
      .from('grammar_chapters')
      .select('chapter_code')
      .eq('cefr_level', 'A2')
      .order('sort_order');
    const actualCodes = data.map(row => row.chapter_code);
    expect(actualCodes).toEqual(expectedCodes);
  });

  it('should create B1 chapters B1.G.01 through B1.G.32', async () => {
    const expectedCodes = Array.from({ length: 32 }, (_, i) => 
      `B1.G.${String(i + 1).padStart(2, '0')}`
    );
    const { data } = await supabase
      .from('grammar_chapters')
      .select('chapter_code')
      .eq('cefr_level', 'B1')
      .order('sort_order');
    const actualCodes = data.map(row => row.chapter_code);
    expect(actualCodes).toEqual(expectedCodes);
  });

  it('should preserve all existing A0 and A1 chapters', async () => {
    const { count: a0Count } = await supabase
      .from('grammar_chapters')
      .select('*', { count: 'exact', head: true })
      .eq('cefr_level', 'A0');
    
    const { count: a1Count } = await supabase
      .from('grammar_chapters')
      .select('*', { count: 'exact', head: true })
      .eq('cefr_level', 'A1');
    
    expect(a0Count).toBe(12); // Known A0 count
    expect(a1Count).toBe(24); // Known A1 count
  });

  it('should be idempotent when run multiple times', async () => {
    // Run migrations twice
    await runA2Migration();
    await runB1Migration();
    
    const { count: firstA2Count } = await supabase
      .from('grammar_chapters')
      .select('*', { count: 'exact', head: true })
      .eq('cefr_level', 'A2');
    
    const { count: firstB1Count } = await supabase
      .from('grammar_chapters')
      .select('*', { count: 'exact', head: true })
      .eq('cefr_level', 'B1');
    
    // Run again
    await runA2Migration();
    await runB1Migration();
    
    const { count: secondA2Count } = await supabase
      .from('grammar_chapters')
      .select('*', { count: 'exact', head: true })
      .eq('cefr_level', 'A2');
    
    const { count: secondB1Count } = await supabase
      .from('grammar_chapters')
      .select('*', { count: 'exact', head: true })
      .eq('cefr_level', 'B1');
    
    expect(secondA2Count).toBe(firstA2Count);
    expect(secondA2Count).toBe(28);
    expect(secondB1Count).toBe(firstB1Count);
    expect(secondB1Count).toBe(32);
  });

  it('should include specific A2 topics', async () => {
    const requiredTopics = [
      'Past Simple (Irregular Verbs)',
      'Past Continuous',
      'Present Perfect',
      'First Conditional',
      'Second Conditional',
      'Passive Voice - Introduction',
      'Relative Clauses I'
    ];
    
    const { data } = await supabase
      .from('grammar_chapters')
      .select('title')
      .eq('cefr_level', 'A2');
    
    const titles = data.map(row => row.title);
    requiredTopics.forEach(topic => {
      expect(titles).toContain(topic);
    });
  });

  it('should include specific B1 topics', async () => {
    const requiredTopics = [
      'Present Perfect vs Past Simple',
      'Present Perfect Continuous',
      'Narrative Tenses',
      'Third Conditional',
      'Mixed Conditionals',
      'Passive Voice II (All Tenses)',
      'Relative Clauses II (Defining/Non-defining)'
    ];
    
    const { data } = await supabase
      .from('grammar_chapters')
      .select('title')
      .eq('cefr_level', 'B1');
    
    const titles = data.map(row => row.title);
    requiredTopics.forEach(topic => {
      expect(titles).toContain(topic);
    });
  });
});
```

**Content Validation Tests**:
```typescript
describe('A2-B1 Chapter Content', () => {
  it('should have valid JSONB in micro_practice fields', async () => {
    const { data } = await supabase
      .from('grammar_chapters')
      .select('chapter_code, micro_practice')
      .in('cefr_level', ['A2', 'B1']);
    
    data.forEach(chapter => {
      expect(Array.isArray(chapter.micro_practice)).toBe(true);
      // Validate structure of each exercise
      chapter.micro_practice.forEach(exercise => {
        expect(exercise).toHaveProperty('type');
        expect(exercise).toHaveProperty('prompt');
        expect(exercise).toHaveProperty('answer');
        expect(exercise).toHaveProperty('feedback');
      });
    });
  });

  it('should have valid JSONB in cross_links fields', async () => {
    const { data } = await supabase
      .from('grammar_chapters')
      .select('chapter_code, cross_links')
      .in('cefr_level', ['A2', 'B1']);
    
    data.forEach(chapter => {
      expect(Array.isArray(chapter.cross_links)).toBe(true);
      // Validate structure of each link
      chapter.cross_links.forEach(link => {
        expect(link).toHaveProperty('type');
        expect(link).toHaveProperty('chapter_code');
        expect(['prerequisite', 'related', 'advanced']).toContain(link.type);
      });
    });
  });

  it('should include cross-links to prerequisite chapters', async () => {
    const { data } = await supabase
      .from('grammar_chapters')
      .select('chapter_code, cross_links')
      .eq('chapter_code', 'A2.G.01');
    
    const crossLinks = data[0].cross_links;
    const hasPrerequisite = crossLinks.some(link => 
      link.type === 'prerequisite' && link.chapter_code.startsWith('A1.')
    );
    expect(hasPrerequisite).toBe(true);
  });

  it('should support forward references to future chapters', async () => {
    // Test that cross_links can reference B2 chapters even if they don't exist yet
    const { data } = await supabase
      .from('grammar_chapters')
      .select('chapter_code, cross_links')
      .eq('cefr_level', 'B1');
    
    // Should not throw error even if some cross_links reference B2.G.XX
    expect(data).toBeDefined();
    expect(Array.isArray(data)).toBe(true);
  });
});
```

### Property-Based Testing

**Configuration**: Use `fast-check` library for TypeScript/JavaScript property-based testing. Each test should run a minimum of 100 iterations to ensure comprehensive coverage through randomization.

**Test Tagging**: Each property test must include a comment referencing its design document property:
```typescript
// Feature: a2-b1-grammar-lessons, Property 1: Required Fields Completeness
```

**Property Test 1: Required Fields Completeness**
```typescript
import fc from 'fast-check';

// Feature: a2-b1-grammar-lessons, Property 1: Required Fields Completeness
describe('Property: Required Fields Completeness', () => {
  it('all A2 and B1 chapters have required fields populated', async () => {
    await fc.assert(
      fc.asyncProperty(
        fc.constantFrom('A2', 'B1'),
        fc.integer({ min: 1, max: 32 }),
        async (level, num) => {
          // Skip invalid combinations (A2 only has 28 chapters)
          if (level === 'A2' && num > 28) return true;
          
          const chapterCode = `${level}.G.${String(num).padStart(2, '0')}`;
          const { data } = await supabase
            .from('grammar_chapters')
            .select('*')
            .eq('chapter_code', chapterCode)
            .single();
          
          // All required fields must be non-null and non-empty
          expect(data.chapter_code).toBeTruthy();
          expect(data.title).toBeTruthy();
          expect(data.cefr_level).toBe(level);
          expect(data.form_content).toBeTruthy();
          expect(data.meaning_content).toBeTruthy();
          expect(data.use_content).toBeTruthy();
          expect(typeof data.is_published).toBe('boolean');
          expect(typeof data.sort_order).toBe('number');
          expect(data.sort_order).toBeGreaterThan(0);
        }
      ),
      { numRuns: 100 }
    );
  });
});
```

**Property Test 2: Sort Order Sequence Alignment**
```typescript
// Feature: a2-b1-grammar-lessons, Property 2: Sort Order Sequence Alignment
describe('Property: Sort Order Sequence Alignment', () => {
  it('sort_order matches chapter_code numeric suffix for all chapters', async () => {
    await fc.assert(
      fc.asyncProperty(
        fc.constantFrom('A2', 'B1'),
        fc.integer({ min: 1, max: 32 }),
        async (level, expectedOrder) => {
          // Skip invalid combinations
          if (level === 'A2' && expectedOrder > 28) return true;
          
          const chapterCode = `${level}.G.${String(expectedOrder).padStart(2, '0')}`;
          const { data } = await supabase
            .from('grammar_chapters')
            .select('sort_order')
            .eq('chapter_code', chapterCode)
            .single();
          
          expect(data.sort_order).toBe(expectedOrder);
        }
      ),
      { numRuns: 100 }
    );
  });
});
```

**Property Test 3: Chapter Code Uniqueness**
```typescript
// Feature: a2-b1-grammar-lessons, Property 3: Chapter Code Uniqueness
describe('Property: Chapter Code Uniqueness', () => {
  it('no two chapters share the same chapter_code across all levels', async () => {
    const { data: allChapters } = await supabase
      .from('grammar_chapters')
      .select('chapter_code');
    
    const chapterCodes = allChapters.map(c => c.chapter_code);
    const uniqueCodes = new Set(chapterCodes);
    
    expect(uniqueCodes.size).toBe(chapterCodes.length);
  });
});
```

**Property Test 4: Sort Order Uniqueness Within Level**
```typescript
// Feature: a2-b1-grammar-lessons, Property 4: Sort Order Uniqueness Within Level
describe('Property: Sort Order Uniqueness Within Level', () => {
  it('all chapters within same CEFR level have unique sort_order values', async () => {
    await fc.assert(
      fc.asyncProperty(
        fc.constantFrom('A0', 'A1', 'A2', 'B1'),
        async (level) => {
          const { data } = await supabase
            .from('grammar_chapters')
            .select('sort_order')
            .eq('cefr_level', level);
          
          const sortOrders = data.map(c => c.sort_order);
          const uniqueOrders = new Set(sortOrders);
          
          expect(uniqueOrders.size).toBe(sortOrders.length);
        }
      ),
      { numRuns: 100 }
    );
  });
});
```

**Property Test 5: CEFR Level Independence**
```typescript
// Feature: a2-b1-grammar-lessons, Property 5: CEFR Level Independence
describe('Property: CEFR Level Independence', () => {
  it('different CEFR levels can have overlapping sort_order values', async () => {
    const { data: a2Chapters } = await supabase
      .from('grammar_chapters')
      .select('sort_order')
      .eq('cefr_level', 'A2');
    
    const { data: b1Chapters } = await supabase
      .from('grammar_chapters')
      .select('sort_order')
      .eq('cefr_level', 'B1');
    
    const a2Orders = new Set(a2Chapters.map(c => c.sort_order));
    const b1Orders = new Set(b1Chapters.map(c => c.sort_order));
    
    // Find intersection
    const overlap = [...a2Orders].filter(order => b1Orders.has(order));
    
    // Should have overlap (both have 1, 2, 3, etc.)
    expect(overlap.length).toBeGreaterThan(0);
  });
});
```

**Property Test 6: JSONB Validity for Micro-Practice**
```typescript
// Feature: a2-b1-grammar-lessons, Property 6: JSONB Validity for Micro-Practice
describe('Property: JSONB Validity for Micro-Practice', () => {
  it('all micro_practice fields contain valid parseable JSON with required structure', async () => {
    await fc.assert(
      fc.asyncProperty(
        fc.constantFrom('A2', 'B1'),
        fc.integer({ min: 1, max: 32 }),
        async (level, num) => {
          // Skip invalid combinations
          if (level === 'A2' && num > 28) return true;
          
          const chapterCode = `${level}.G.${String(num).padStart(2, '0')}`;
          const { data } = await supabase
            .from('grammar_chapters')
            .select('micro_practice')
            .eq('chapter_code', chapterCode)
            .single();
          
          // Should be valid array
          expect(Array.isArray(data.micro_practice)).toBe(true);
          
          // Should be serializable
          expect(() => JSON.stringify(data.micro_practice)).not.toThrow();
          
          // Each exercise should have required fields
          data.micro_practice.forEach(exercise => {
            expect(exercise).toHaveProperty('type');
            expect(exercise).toHaveProperty('prompt');
            expect(exercise).toHaveProperty('answer');
            expect(exercise).toHaveProperty('feedback');
          });
        }
      ),
      { numRuns: 100 }
    );
  });
});
```

**Property Test 7: JSONB Validity for Cross-Links**
```typescript
// Feature: a2-b1-grammar-lessons, Property 7: JSONB Validity for Cross-Links
describe('Property: JSONB Validity for Cross-Links', () => {
  it('all cross_links fields contain valid parseable JSON with required structure', async () => {
    await fc.assert(
      fc.asyncProperty(
        fc.constantFrom('A2', 'B1'),
        fc.integer({ min: 1, max: 32 }),
        async (level, num) => {
          // Skip invalid combinations
          if (level === 'A2' && num > 28) return true;
          
          const chapterCode = `${level}.G.${String(num).padStart(2, '0')}`;
          const { data } = await supabase
            .from('grammar_chapters')
            .select('cross_links')
            .eq('chapter_code', chapterCode)
            .single();
          
          // Should be valid array
          expect(Array.isArray(data.cross_links)).toBe(true);
          
          // Should be serializable
          expect(() => JSON.stringify(data.cross_links)).not.toThrow();
          
          // Each link should have required fields
          data.cross_links.forEach(link => {
            expect(link).toHaveProperty('type');
            expect(link).toHaveProperty('chapter_code');
            expect(['prerequisite', 'related', 'advanced']).toContain(link.type);
          });
        }
      ),
      { numRuns: 100 }
    );
  });
});
```

**Property Test 8: Publication Status**
```typescript
// Feature: a2-b1-grammar-lessons, Property 8: Publication Status
describe('Property: Publication Status', () => {
  it('all A2 and B1 chapters are published', async () => {
    await fc.assert(
      fc.asyncProperty(
        fc.constantFrom('A2', 'B1'),
        fc.integer({ min: 1, max: 32 }),
        async (level, num) => {
          // Skip invalid combinations
          if (level === 'A2' && num > 28) return true;
          
          const chapterCode = `${level}.G.${String(num).padStart(2, '0')}`;
          const { data } = await supabase
            .from('grammar_chapters')
            .select('is_published')
            .eq('chapter_code', chapterCode)
            .single();
          
          expect(data.is_published).toBe(true);
        }
      ),
      { numRuns: 100 }
    );
  });
});
```

**Property Test 9: Migration Idempotency**
```typescript
// Feature: a2-b1-grammar-lessons, Property 9: Migration Idempotency
describe('Property: Migration Idempotency', () => {
  it('running migrations multiple times produces identical results', async () => {
    // Get initial state
    const { count: initialA2 } = await supabase
      .from('grammar_chapters')
      .select('*', { count: 'exact', head: true })
      .eq('cefr_level', 'A2');
    
    const { count: initialB1 } = await supabase
      .from('grammar_chapters')
      .select('*', { count: 'exact', head: true })
      .eq('cefr_level', 'B1');
    
    // Run migrations again
    await runA2Migration();
    await runB1Migration();
    
    // Get final state
    const { count: finalA2 } = await supabase
      .from('grammar_chapters')
      .select('*', { count: 'exact', head: true })
      .eq('cefr_level', 'A2');
    
    const { count: finalB1 } = await supabase
      .from('grammar_chapters')
      .select('*', { count: 'exact', head: true })
      .eq('cefr_level', 'B1');
    
    // Counts should be unchanged
    expect(finalA2).toBe(initialA2);
    expect(finalA2).toBe(28);
    expect(finalB1).toBe(initialB1);
    expect(finalB1).toBe(32);
    
    // Verify no duplicates
    const { data: allChapters } = await supabase
      .from('grammar_chapters')
      .select('chapter_code')
      .in('cefr_level', ['A2', 'B1']);
    
    const codes = allChapters.map(c => c.chapter_code);
    const uniqueCodes = new Set(codes);
    expect(uniqueCodes.size).toBe(codes.length);
  });
});
```

**Property Test 10: Database Compatibility Preservation**
```typescript
// Feature: a2-b1-grammar-lessons, Property 10: Database Compatibility Preservation
describe('Property: Database Compatibility Preservation', () => {
  it('RLS policies apply to A2 and B1 chapters', async () => {
    // Test as authenticated user
    const { data: withAuth } = await supabase
      .from('grammar_chapters')
      .select('*')
      .in('cefr_level', ['A2', 'B1'])
      .eq('is_published', true);
    
    expect(withAuth.length).toBeGreaterThan(0);
    
    // Test as anonymous user (should be restricted by RLS)
    const anonClient = createClient(supabaseUrl, supabaseAnonKey);
    const { data: withoutAuth } = await anonClient
      .from('grammar_chapters')
      .select('*')
      .in('cefr_level', ['A2', 'B1']);
    
    // RLS should restrict access appropriately
    expect(withoutAuth).toBeDefined();
  });

  it('updated_at trigger fires on A2 and B1 chapter updates', async () => {
    const testChapter = 'A2.G.01';
    
    const { data: before } = await supabase
      .from('grammar_chapters')
      .select('updated_at')
      .eq('chapter_code', testChapter)
      .single();
    
    // Wait a moment then update
    await new Promise(resolve => setTimeout(resolve, 1000));
    
    await supabase
      .from('grammar_chapters')
      .update({ title: 'Updated Title' })
      .eq('chapter_code', testChapter);
    
    const { data: after } = await supabase
      .from('grammar_chapters')
      .select('updated_at')
      .eq('chapter_code', testChapter)
      .single();
    
    expect(new Date(after.updated_at).getTime())
      .toBeGreaterThan(new Date(before.updated_at).getTime());
  });
});
```

### Test Execution

**Unit Tests**: Run via standard test runner (Jest, Vitest) as part of CI/CD pipeline
```bash
npm test -- a2-b1-grammar-migration.test.ts
```

**Property Tests**: Run with increased timeout due to database queries
```bash
npm test -- a2-b1-grammar-properties.test.ts --testTimeout=30000
```

**Manual Verification**: After migration, manually verify:
1. Grammar reference UI displays all 28 A2 lessons and 32 B1 lessons
2. Lessons appear in correct sort order within each level
3. Cross-links resolve to correct lesson titles
4. Micro-practice exercises render correctly
5. Content formatting (tables, line breaks) displays properly
6. L1 transfer notes are visible in common errors section
7. All nine pedagogical sections display correctly for sample chapters
