# Design Document: A1 Grammar Lessons

## Overview

This feature adds 24 A1-level grammar lessons to the existing grammar reference system through a database migration. The implementation follows the established pattern from the A0 grammar lessons migration, inserting comprehensive pedagogical content into the existing `grammar_chapters` table without requiring any schema modifications.

The A1 lessons cover essential elementary grammar topics including verb tenses (simple present, past, future), possessive structures, modals, comparatives, prepositions, and question formation. Each lesson includes multiple pedagogical sections (form, meaning, use, contrast, common errors, task upgrades) along with structured practice exercises and cross-references to related lessons.

### Key Design Decisions

1. **Migration-Based Approach**: Content is deployed via SQL migration rather than through application UI, ensuring consistency across environments and enabling version control of lesson content.

2. **Schema Reuse**: The existing `grammar_chapters` table schema accommodates all A1 content requirements without modifications, maintaining backward compatibility.

3. **Idempotent Migration**: The migration checks for existing chapter codes before insertion, allowing safe re-execution without creating duplicates.

4. **Content Formatting**: Text content uses PostgreSQL string escaping (doubled single quotes) to handle apostrophes and special characters within SQL INSERT statements.

5. **JSONB Structure**: Micro-practice exercises and cross-links are stored as JSONB arrays, providing flexibility for complex nested data while maintaining queryability.

## Architecture

### System Components

```
┌─────────────────────────────────────────────────────────────┐
│                    Migration Script                          │
│  (20260311000000_add_a1_grammar_chapters.sql)               │
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
│  │ New A1 Chapters (24 rows)                          │    │
│  │ - A1.G.01 through A1.G.24                          │    │
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

1. **Migration Execution**: Database administrator runs the migration script via Supabase CLI or dashboard
2. **Idempotency Check**: For each chapter, the migration checks if the chapter_code already exists
3. **Conditional Insert**: If chapter_code doesn't exist, insert the full chapter record
4. **Constraint Validation**: Database enforces unique constraints on chapter_code and validates JSONB structure
5. **RLS Application**: Existing Row Level Security policies automatically apply to new A1 chapters
6. **Application Access**: Grammar reference UI queries chapters filtered by CEFR level and sort order

## Components and Interfaces

### Database Migration File

**File**: `supabase/migrations/20260311000000_add_a1_grammar_chapters.sql`

**Structure**:
```sql
-- Idempotent insertion pattern
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
  ('A1.G.01', 'Title', 'A1', 'form...', 'meaning...', 'use...', 
   'contrast...', 'errors...', 'hook...', 'upgrades...', 
   '[]'::jsonb, '[]'::jsonb, true, 1)
) AS new_chapters(chapter_code, title, cefr_level, form_content, 
  meaning_content, use_content, contrast_notes, common_errors, 
  diagnostic_hook, task_upgrades, micro_practice, cross_links, 
  is_published, sort_order)
WHERE NOT EXISTS (
  SELECT 1 FROM public.grammar_chapters 
  WHERE chapter_code = new_chapters.chapter_code
);
```

**Rationale**: This pattern provides idempotency by checking for existing chapter codes before insertion. Unlike the A0 migration which used DELETE then INSERT, this approach preserves any manual edits made to chapters while still allowing the migration to run multiple times safely.

### Grammar Chapters Table Schema

**Table**: `public.grammar_chapters`

**Columns**:
- `id` (UUID, PK): Auto-generated unique identifier
- `chapter_code` (TEXT, UNIQUE, NOT NULL): Human-readable code (e.g., 'A1.G.01')
- `title` (TEXT, NOT NULL): Lesson title
- `cefr_level` (TEXT, NOT NULL): CEFR level indicator ('A1')
- `form_content` (TEXT): How to construct the grammar structure
- `meaning_content` (TEXT): What the structure means
- `use_content` (TEXT): When to use the structure
- `contrast_notes` (TEXT): Comparison with alternatives
- `common_errors` (TEXT): Typical mistakes and corrections
- `diagnostic_hook` (TEXT): Scenario-based learning challenge
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
    "prompt": "Complete: I ___ (go) to school every day.",
    "answer": "go",
    "feedback": "Use the base form with 'I'."
  },
  {
    "type": "multiple_choice",
    "prompt": "Choose the correct form: She ___ coffee.",
    "options": ["drink", "drinks", "drinking"],
    "answer": "drinks",
    "feedback": "Add -s for he/she/it in simple present."
  }
]
```

**Cross-Links Format**:
```json
[
  {
    "type": "prerequisite",
    "chapter_code": "A0.G.02",
    "note": "Review verb 'be' before studying simple present"
  },
  {
    "type": "related",
    "chapter_code": "A1.G.02",
    "note": "See also: Simple Present Negative"
  }
]
```

**Rationale**: JSONB provides schema flexibility for exercises while maintaining PostgreSQL's indexing and querying capabilities. The array structure allows multiple exercises per chapter, and the object structure within each exercise supports various exercise types with different fields.

## Data Models

### Grammar Chapter Entity

```typescript
interface GrammarChapter {
  id: string;                    // UUID
  chapter_code: string;          // e.g., 'A1.G.01'
  title: string;                 // e.g., 'Simple Present - Affirmative'
  cefr_level: string;            // 'A1'
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
  sort_order: number;            // 1-24 for A1
  created_at: string;            // ISO timestamp
  updated_at: string;
}
```

### Micro-Practice Exercise

```typescript
interface MicroPractice {
  type: 'fill_blank' | 'multiple_choice' | 'correction' | 'transformation';
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
  chapter_code: string;          // e.g., 'A0.G.02' or 'A1.G.05'
  note?: string;                 // Optional explanation
}
```

### A1 Lesson Topics

The 24 A1 lessons cover:

1. **A1.G.01**: Simple Present - Affirmative
2. **A1.G.02**: Simple Present - Negative
3. **A1.G.03**: Simple Present - Questions
4. **A1.G.04**: Possessive 's
5. **A1.G.05**: Possessive Pronouns
6. **A1.G.06**: Object Pronouns
7. **A1.G.07**: Count and Noncount Nouns
8. **A1.G.08**: Quantifiers (some, any, much, many)
9. **A1.G.09**: Present Continuous - Affirmative
10. **A1.G.10**: Present Continuous - Negative and Questions
11. **A1.G.11**: Simple Past - Regular Verbs
12. **A1.G.12**: Simple Past - Irregular Verbs
13. **A1.G.13**: Simple Past - Negative and Questions
14. **A1.G.14**: Future with 'going to'
15. **A1.G.15**: Future with 'will'
16. **A1.G.16**: Comparative Adjectives
17. **A1.G.17**: Superlative Adjectives
18. **A1.G.18**: Modal: must / have to
19. **A1.G.19**: Modal: should
20. **A1.G.20**: Modal: would like
21. **A1.G.21**: Prepositions of Time
22. **A1.G.22**: Prepositions of Movement
23. **A1.G.23**: Adverbs of Frequency and Manner
24. **A1.G.24**: Questions with How much/many and Whose

## Correctness Properties

*A property is a characteristic or behavior that should hold true across all valid executions of a system—essentially, a formal statement about what the system should do. Properties serve as the bridge between human-readable specifications and machine-verifiable correctness guarantees.*

### Property 1: Required Fields Completeness

*For any* A1 grammar chapter in the database, all required fields (chapter_code, title, cefr_level, form_content, meaning_content, use_content, is_published, sort_order) must be non-null and non-empty.

**Validates: Requirements 1.3, 3.1, 3.2, 3.3**

### Property 2: JSONB Validity

*For any* grammar chapter with micro_practice or cross_links fields, the stored value must be valid JSON that can be parsed without errors.

**Validates: Requirements 3.8, 3.9, 7.1, 9.1**

### Property 3: Chapter Code Uniqueness

*For any* two grammar chapters in the database, their chapter_code values must be distinct (no duplicates across all CEFR levels).

**Validates: Requirements 2.3, 10.1**

### Property 4: Sort Order Sequence Alignment

*For any* A1 grammar chapter with chapter_code 'A1.G.XX', the sort_order value must equal XX (the numeric portion of the chapter code).

**Validates: Requirements 10.2**

### Property 5: Sort Order Uniqueness Within Level

*For any* two grammar chapters with the same cefr_level, their sort_order values must be distinct.

**Validates: Requirements 10.4**

### Property 6: Publication Status

*For any* A1 grammar chapter inserted by the migration, the is_published field must be true.

**Validates: Requirements 8.3**

### Property 7: CEFR Level Independence

*For any* two CEFR levels (e.g., A0 and A1), chapters from different levels can have the same sort_order value without conflict.

**Validates: Requirements 2.2**

### Property 8: Database Compatibility Preservation

*For any* existing database constraint, trigger, or RLS policy that applied to grammar chapters before the migration, it must continue to apply correctly to both A0 and A1 chapters after the migration.

**Validates: Requirements 6.3, 6.4**

## Error Handling

### Migration Errors

**Duplicate Chapter Code**:
- **Scenario**: Migration attempts to insert a chapter_code that already exists
- **Handling**: The idempotent WHERE NOT EXISTS clause prevents the insertion, allowing the migration to complete successfully
- **User Impact**: No error thrown; existing chapter is preserved

**Invalid JSONB**:
- **Scenario**: Malformed JSON in micro_practice or cross_links fields
- **Handling**: PostgreSQL rejects the INSERT with a JSON parsing error
- **Resolution**: Fix the JSON syntax in the migration file and re-run
- **Prevention**: Validate all JSON structures before including in migration

**Missing Required Fields**:
- **Scenario**: INSERT statement omits a NOT NULL column
- **Handling**: PostgreSQL rejects the INSERT with a constraint violation error
- **Resolution**: Add the missing field to the INSERT statement
- **Prevention**: Use explicit column lists in INSERT statements

**Character Encoding Issues**:
- **Scenario**: Special characters or non-ASCII text causes encoding errors
- **Handling**: PostgreSQL may reject the INSERT or store corrupted text
- **Resolution**: Ensure migration file is saved as UTF-8 and use proper escaping
- **Prevention**: Test migration with special characters in development environment

### Application Errors

**Missing Cross-Link References**:
- **Scenario**: cross_links references a chapter_code that doesn't exist
- **Handling**: Application should gracefully handle missing references by not displaying broken links
- **Resolution**: Update cross_links to reference valid chapter codes
- **Prevention**: Validate all cross-link references before migration

**Empty Content Sections**:
- **Scenario**: Optional fields (contrast_notes, common_errors) are null
- **Handling**: Application UI should hide empty sections rather than displaying null/empty content
- **User Impact**: Cleaner UI without empty placeholders

## Testing Strategy

### Dual Testing Approach

This feature requires both unit tests and property-based tests to ensure comprehensive coverage:

- **Unit tests**: Verify specific examples (e.g., A1.G.01 exists, migration is idempotent)
- **Property tests**: Verify universal properties across all A1 chapters (e.g., all required fields populated)

Unit tests focus on concrete scenarios and edge cases, while property tests validate that correctness properties hold across all inputs through randomized testing.

### Unit Testing

**Migration Execution Tests**:
```typescript
describe('A1 Grammar Migration', () => {
  it('should insert exactly 24 A1 chapters', async () => {
    const { count } = await supabase
      .from('grammar_chapters')
      .select('*', { count: 'exact', head: true })
      .eq('cefr_level', 'A1');
    expect(count).toBe(24);
  });

  it('should create chapters A1.G.01 through A1.G.24', async () => {
    const expectedCodes = Array.from({ length: 24 }, (_, i) => 
      `A1.G.${String(i + 1).padStart(2, '0')}`
    );
    const { data } = await supabase
      .from('grammar_chapters')
      .select('chapter_code')
      .eq('cefr_level', 'A1')
      .order('sort_order');
    const actualCodes = data.map(row => row.chapter_code);
    expect(actualCodes).toEqual(expectedCodes);
  });

  it('should preserve all existing A0 chapters', async () => {
    const { count: beforeCount } = await supabase
      .from('grammar_chapters')
      .select('*', { count: 'exact', head: true })
      .eq('cefr_level', 'A0');
    
    // Run migration (in test environment)
    
    const { count: afterCount } = await supabase
      .from('grammar_chapters')
      .select('*', { count: 'exact', head: true })
      .eq('cefr_level', 'A0');
    
    expect(afterCount).toBe(beforeCount);
    expect(afterCount).toBe(12); // Known A0 count
  });

  it('should be idempotent when run multiple times', async () => {
    // Run migration twice
    await runMigration();
    const { count: firstCount } = await supabase
      .from('grammar_chapters')
      .select('*', { count: 'exact', head: true })
      .eq('cefr_level', 'A1');
    
    await runMigration();
    const { count: secondCount } = await supabase
      .from('grammar_chapters')
      .select('*', { count: 'exact', head: true })
      .eq('cefr_level', 'A1');
    
    expect(secondCount).toBe(firstCount);
    expect(secondCount).toBe(24);
  });
});
```

**Content Validation Tests**:
```typescript
describe('A1 Chapter Content', () => {
  it('should have valid JSONB in micro_practice fields', async () => {
    const { data } = await supabase
      .from('grammar_chapters')
      .select('chapter_code, micro_practice')
      .eq('cefr_level', 'A1');
    
    data.forEach(chapter => {
      expect(Array.isArray(chapter.micro_practice)).toBe(true);
      // Additional structure validation
    });
  });

  it('should include cross-links to A0 prerequisites', async () => {
    const { data } = await supabase
      .from('grammar_chapters')
      .select('chapter_code, cross_links')
      .eq('chapter_code', 'A1.G.01');
    
    const crossLinks = data[0].cross_links;
    const hasA0Reference = crossLinks.some(link => 
      link.chapter_code.startsWith('A0.')
    );
    expect(hasA0Reference).toBe(true);
  });
});
```

### Property-Based Testing

**Configuration**: Use `fast-check` library for TypeScript/JavaScript property-based testing. Each test should run a minimum of 100 iterations to ensure comprehensive coverage through randomization.

**Test Tagging**: Each property test must include a comment referencing its design document property:
```typescript
// Feature: a1-grammar-lessons, Property 1: Required Fields Completeness
```

**Property Test 1: Required Fields Completeness**
```typescript
import fc from 'fast-check';

// Feature: a1-grammar-lessons, Property 1: Required Fields Completeness
describe('Property: Required Fields Completeness', () => {
  it('all A1 chapters have required fields populated', async () => {
    await fc.assert(
      fc.asyncProperty(
        fc.integer({ min: 1, max: 24 }),
        async (chapterNum) => {
          const chapterCode = `A1.G.${String(chapterNum).padStart(2, '0')}`;
          const { data } = await supabase
            .from('grammar_chapters')
            .select('*')
            .eq('chapter_code', chapterCode)
            .single();
          
          // All required fields must be non-null and non-empty
          expect(data.chapter_code).toBeTruthy();
          expect(data.title).toBeTruthy();
          expect(data.cefr_level).toBe('A1');
          expect(data.form_content).toBeTruthy();
          expect(data.meaning_content).toBeTruthy();
          expect(data.use_content).toBeTruthy();
          expect(typeof data.is_published).toBe('boolean');
          expect(typeof data.sort_order).toBe('number');
        }
      ),
      { numRuns: 100 }
    );
  });
});
```

**Property Test 2: JSONB Validity**
```typescript
// Feature: a1-grammar-lessons, Property 2: JSONB Validity
describe('Property: JSONB Validity', () => {
  it('all JSONB fields contain valid parseable JSON', async () => {
    await fc.assert(
      fc.asyncProperty(
        fc.integer({ min: 1, max: 24 }),
        async (chapterNum) => {
          const chapterCode = `A1.G.${String(chapterNum).padStart(2, '0')}`;
          const { data } = await supabase
            .from('grammar_chapters')
            .select('micro_practice, cross_links')
            .eq('chapter_code', chapterCode)
            .single();
          
          // Should be valid arrays
          expect(Array.isArray(data.micro_practice)).toBe(true);
          expect(Array.isArray(data.cross_links)).toBe(true);
          
          // Should be serializable (no circular references, etc.)
          expect(() => JSON.stringify(data.micro_practice)).not.toThrow();
          expect(() => JSON.stringify(data.cross_links)).not.toThrow();
        }
      ),
      { numRuns: 100 }
    );
  });
});
```

**Property Test 3: Chapter Code Uniqueness**
```typescript
// Feature: a1-grammar-lessons, Property 3: Chapter Code Uniqueness
describe('Property: Chapter Code Uniqueness', () => {
  it('no two chapters share the same chapter_code', async () => {
    const { data: allChapters } = await supabase
      .from('grammar_chapters')
      .select('chapter_code');
    
    const chapterCodes = allChapters.map(c => c.chapter_code);
    const uniqueCodes = new Set(chapterCodes);
    
    expect(uniqueCodes.size).toBe(chapterCodes.length);
  });
});
```

**Property Test 4: Sort Order Sequence Alignment**
```typescript
// Feature: a1-grammar-lessons, Property 4: Sort Order Sequence Alignment
describe('Property: Sort Order Sequence Alignment', () => {
  it('sort_order matches chapter_code numeric suffix', async () => {
    await fc.assert(
      fc.asyncProperty(
        fc.integer({ min: 1, max: 24 }),
        async (expectedOrder) => {
          const chapterCode = `A1.G.${String(expectedOrder).padStart(2, '0')}`;
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

**Property Test 5: Sort Order Uniqueness Within Level**
```typescript
// Feature: a1-grammar-lessons, Property 5: Sort Order Uniqueness Within Level
describe('Property: Sort Order Uniqueness Within Level', () => {
  it('all A1 chapters have unique sort_order values', async () => {
    const { data } = await supabase
      .from('grammar_chapters')
      .select('sort_order')
      .eq('cefr_level', 'A1');
    
    const sortOrders = data.map(c => c.sort_order);
    const uniqueOrders = new Set(sortOrders);
    
    expect(uniqueOrders.size).toBe(sortOrders.length);
    expect(sortOrders.length).toBe(24);
  });
});
```

**Property Test 6: Publication Status**
```typescript
// Feature: a1-grammar-lessons, Property 6: Publication Status
describe('Property: Publication Status', () => {
  it('all A1 chapters are published', async () => {
    await fc.assert(
      fc.asyncProperty(
        fc.integer({ min: 1, max: 24 }),
        async (chapterNum) => {
          const chapterCode = `A1.G.${String(chapterNum).padStart(2, '0')}`;
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

**Property Test 7: CEFR Level Independence**
```typescript
// Feature: a1-grammar-lessons, Property 7: CEFR Level Independence
describe('Property: CEFR Level Independence', () => {
  it('A0 and A1 can have overlapping sort_order values', async () => {
    const { data: a0Chapters } = await supabase
      .from('grammar_chapters')
      .select('sort_order')
      .eq('cefr_level', 'A0');
    
    const { data: a1Chapters } = await supabase
      .from('grammar_chapters')
      .select('sort_order')
      .eq('cefr_level', 'A1');
    
    const a0Orders = new Set(a0Chapters.map(c => c.sort_order));
    const a1Orders = new Set(a1Chapters.map(c => c.sort_order));
    
    // Find intersection
    const overlap = [...a0Orders].filter(order => a1Orders.has(order));
    
    // Should have overlap (both have 1, 2, 3, etc.)
    expect(overlap.length).toBeGreaterThan(0);
  });
});
```

**Property Test 8: Database Compatibility Preservation**
```typescript
// Feature: a1-grammar-lessons, Property 8: Database Compatibility Preservation
describe('Property: Database Compatibility Preservation', () => {
  it('RLS policies apply to A1 chapters', async () => {
    // Test as authenticated user
    const { data: withAuth } = await supabase
      .from('grammar_chapters')
      .select('*')
      .eq('cefr_level', 'A1')
      .eq('is_published', true);
    
    expect(withAuth.length).toBeGreaterThan(0);
    
    // Test as anonymous user (should be restricted by RLS)
    const anonClient = createClient(supabaseUrl, supabaseAnonKey);
    const { data: withoutAuth } = await anonClient
      .from('grammar_chapters')
      .select('*')
      .eq('cefr_level', 'A1');
    
    // RLS should restrict access appropriately
    expect(withoutAuth).toBeDefined();
  });

  it('updated_at trigger fires on A1 chapter updates', async () => {
    const testChapter = 'A1.G.01';
    
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
npm test -- a1-grammar-migration.test.ts
```

**Property Tests**: Run with increased timeout due to database queries
```bash
npm test -- a1-grammar-properties.test.ts --testTimeout=30000
```

**Manual Verification**: After migration, manually verify:
1. Grammar reference UI displays all 24 A1 lessons
2. Lessons appear in correct sort order
3. Cross-links resolve to correct lesson titles
4. Micro-practice exercises render correctly
5. Content formatting (tables, line breaks) displays properly

