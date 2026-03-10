# Vocabulary Testing Infrastructure

This directory contains the testing infrastructure for the comprehensive vocabulary data feature. It provides utilities for database testing, validation, progress monitoring, and property-based testing.

## Overview

The testing infrastructure supports:
- Database connection and query utilities
- Test data generators using fast-check for property-based testing
- Validation utilities to check data quality
- Progress monitoring and batch tracking
- Property-based testing with minimum 100 iterations

## Files

### `testDatabase.ts`
Database connection utilities and CRUD operations for lexicon entries.

**Key Functions:**
- `createTestClient()` - Creates a Supabase client for testing
- `getLexiconEntry(client, headword)` - Fetches an entry by headword
- `getPublishedEntries(client)` - Fetches all published entries
- `insertTestEntry(client, entry)` - Inserts a test entry
- `updateLexiconEntry(client, headword, updates)` - Updates an entry
- `deleteTestEntry(client, headword)` - Deletes a test entry
- `cleanupTestEntries(client)` - Cleans up all test entries

### `generators.ts`
Test data generators using fast-check for property-based testing.

**Key Generators:**
- `validLexiconEntryArbitrary()` - Generates complete valid entries
- `publishedGSLEntryArbitrary()` - Generates published GSL entries
- `invalidRegisterEntryArbitrary()` - Generates entries with invalid register
- `invalidVarietyEntryArbitrary()` - Generates entries with invalid variety
- `invalidIPAEntryArbitrary()` - Generates entries with invalid IPA format
- `invalidExamplesCardinalityArbitrary()` - Generates entries with wrong example count

**Constants:**
- `VALID_REGISTERS` - ['formal', 'neutral', 'informal']
- `VALID_VARIETIES` - ['US', 'UK', 'international']
- `VALID_CEFR_LEVELS` - ['A0', 'A1', 'A2', 'B1', 'B2', 'C1', 'C2']

### `validation.ts`
Validation utilities to check vocabulary data quality.

**Key Functions:**
- `checkMissingRequiredFields(client)` - Finds entries with missing required fields
- `validateRegisterValues(client)` - Checks for invalid register values
- `validateVarietyValues(client)` - Checks for invalid variety values
- `validateJSONBStructure(client)` - Validates JSONB arrays and cardinality
- `validateIPAFormat(client)` - Checks IPA format (no slashes or brackets)
- `runAllValidations(client)` - Runs all validation checks
- `validateEntry(entry)` - Validates a single entry against all rules

### `progress.ts`
Progress monitoring and batch tracking utilities.

**Key Functions:**
- `getCompletionStatusByCEFR(client)` - Shows completion by CEFR level
- `getFieldPopulationStats(client)` - Counts populated vs unpopulated fields
- `getMigrationBatchProgress(client)` - Reports overall migration progress
- `formatProgressReport(summary)` - Formats progress as human-readable text
- `exportProgressJSON(summary)` - Exports progress as JSON
- `getUnpopulatedEntries(client, cefrLevel?)` - Lists entries needing enhancement
- `checkBatchCompletion(client, headwords)` - Checks if a batch is complete

### `testConfig.ts`
Test configuration and constants.

**Key Exports:**
- `PBT_CONFIG` - Property-based test config (100 iterations)
- `PBT_CONFIG_EXTENDED` - Extended config (1000 iterations)
- `TEST_TIMEOUT` - Test timeout (30 seconds)
- `generateTestHeadword(suffix?)` - Generates unique test headwords
- `propertyTestTag(number, name)` - Formats property test annotations

## Usage Examples

### Running Validation Checks

\`\`\`typescript
import { createTestClient, runAllValidations, formatProgressReport } from './vocabulary';

const client = createTestClient();

// Run all validations
const results = await runAllValidations(client);
console.log(\`Total issues found: \${results.totalIssues}\`);

// Check specific validation
const missingFields = await checkMissingRequiredFields(client);
console.log(\`Entries with missing fields: \${missingFields.length}\`);
\`\`\`

### Monitoring Progress

\`\`\`typescript
import { createTestClient, getMigrationBatchProgress, formatProgressReport } from './vocabulary';

const client = createTestClient();

// Get progress summary
const progress = await getMigrationBatchProgress(client);
console.log(formatProgressReport(progress));

// Check specific CEFR level
const a0Status = await getCompletionStatusByCEFR(client);
const a0 = a0Status.find(s => s.cefr_level === 'A0');
console.log(\`A0 completion: \${a0.completion_percentage}%\`);
\`\`\`

### Property-Based Testing

\`\`\`typescript
import { describe, it } from 'vitest';
import * as fc from 'fast-check';
import { 
  validLexiconEntryArbitrary, 
  validateEntry,
  PBT_CONFIG,
  propertyTestTag 
} from './vocabulary';

describe('Vocabulary Properties', () => {
  it(propertyTestTag(1, 'Required Field Completeness'), () => {
    fc.assert(
      fc.property(
        validLexiconEntryArbitrary(),
        (entry) => {
          const validation = validateEntry(entry as any);
          return validation.valid;
        }
      ),
      PBT_CONFIG
    );
  });
});
\`\`\`

### Checking Batch Completion

\`\`\`typescript
import { createTestClient, checkBatchCompletion } from './vocabulary';

const client = createTestClient();

// Check if a batch of words is complete
const batch1Words = ['I', 'you', 'he', 'she', 'it', 'we', 'they'];
const status = await checkBatchCompletion(client, batch1Words);

console.log(\`Batch completion: \${status.completion_percentage}%\`);
console.log(\`Incomplete words: \${status.incomplete.join(', ')}\`);
\`\`\`

## Requirements Mapping

This infrastructure validates the following requirements:

- **Requirement 9.5**: Idempotent migrations (tested via property tests)
- **Requirement 10.3**: Valid JSONB structure (validated by `validateJSONBStructure`)
- **Requirement 11.1**: Check missing required fields (via `checkMissingRequiredFields`)
- **Requirement 11.2**: Identify empty fields (via `checkMissingRequiredFields`)
- **Requirement 11.3**: Verify valid JSON (via `validateJSONBStructure`)
- **Requirement 11.4**: Confirm register values (via `validateRegisterValues`)
- **Requirement 11.5**: Confirm variety values (via `validateVarietyValues`)
- **Requirement 12.4**: Show completion status (via `getMigrationBatchProgress`)

## Testing Guidelines

1. **Property-Based Tests**: Use minimum 100 iterations (PBT_CONFIG)
2. **Test Annotations**: Tag tests with property numbers using `propertyTestTag()`
3. **Test Cleanup**: Use `test_` prefix for test entries, cleanup with `cleanupTestEntries()`
4. **Database Access**: Tests use the anon key, so RLS policies apply
5. **Validation**: Always validate entries before and after modifications

## Running Tests

\`\`\`bash
# Run all vocabulary tests
npm test -- src/test/vocabulary

# Run specific test file
npm test -- src/test/vocabulary/example.test.ts

# Run with coverage
npm test -- --coverage src/test/vocabulary
\`\`\`

## Notes

- All test entries should use the `test_` prefix for easy cleanup
- The infrastructure uses the Supabase anon key, so RLS policies apply
- Property-based tests run 100 iterations by default (configurable)
- Validation utilities can be used in both tests and production scripts
- Progress monitoring utilities provide real-time migration status


## CLI Tools

### `validationReport.ts`
Generates comprehensive validation reports for vocabulary data.

**Key Functions:**
- `generateValidationReport()` - Generates full validation report
- `formatReportAsText(report)` - Formats report as human-readable text
- `formatReportAsJSON(report)` - Exports report as JSON

**Report Includes:**
- Summary statistics (total, complete, incomplete entries)
- Completion by CEFR level
- All validation issues categorized
- Missing required fields
- Invalid enumerated values
- Format violations

### `migrationProgress.ts`
Tracks migration batch application and progress.

**Key Functions:**
- `trackMigrationProgress()` - Tracks all migration batches
- `formatProgressAsText(report)` - Formats progress as text
- `formatProgressAsJSON(report)` - Exports progress as JSON
- `getUnappliedMigrations(report)` - Lists unapplied migrations
- `getIncompleteBatches(report)` - Lists incomplete batches

**Progress Includes:**
- Overall completion percentage
- Batch-by-batch status
- A0 and A1 completion status
- Missing words per batch
- Next steps recommendations

### `cli.ts`
Command-line interface for running reports.

**Commands:**
```bash
npm run vocab:validate     # Generate validation report
npm run vocab:progress     # Track migration progress
npm run vocab:report       # Generate both reports
npm run vocab:help         # Show help
```

**Output:**
- Reports saved to `reports/` directory
- Both text and JSON formats
- Console output with color coding
- Exit codes for CI/CD integration

## Migration Batches

The vocabulary enhancement is organized into 7 migration batches:

| Batch | Name | CEFR | Words | Migration File |
|-------|------|------|-------|----------------|
| 1 | A0 Pronouns and Basic Verbs | A0 | ~150 | `20260310000002_enhance_gsl_vocabulary_batch_1.sql` |
| 2 | A0 Common Nouns and Adjectives | A0 | ~150 | `20260310000003_enhance_gsl_vocabulary_batch_2.sql` |
| 3 | A0 Prepositions, Determiners, Conjunctions | A0 | ~100 | `20260310000004_enhance_gsl_vocabulary_batch_3.sql` |
| 4 | A1 Work and Business Vocabulary | A1 | ~150 | `20260310000005_enhance_gsl_vocabulary_batch_4_a1_work.sql` |
| 5 | A1 Communication and Technology | A1 | ~150 | `20260310000006_enhance_gsl_vocabulary_batch_5_a1_communication.sql` |
| 6 | A1 Time and Quantity | A1 | ~150 | `20260310000007_enhance_gsl_vocabulary_batch_6_a1_time_quantity.sql` |
| 7 | A1 Remaining High-Frequency Words | A1 | ~150 | `20260310000008_enhance_gsl_vocabulary_batch_7_a1_remaining.sql` |

## Rollback Procedures

Rollback scripts are available at `supabase/migrations/rollback_vocabulary_enhancements.sql`:

- Individual batch rollback (uncomment specific batch section)
- Full rollback (uncomment full rollback section)
- Verification queries to confirm rollback success

## Continuous Integration

The CLI tools can be integrated into CI/CD pipelines:

```yaml
# Example GitHub Actions workflow
- name: Validate Vocabulary Data
  run: npm run vocab:validate
  
- name: Check Migration Progress
  run: npm run vocab:progress
```

Exit codes:
- `0` - Success (no issues or expected state)
- `1` - Failure (validation issues found or error occurred)

## Best Practices

1. **Run validation after each migration batch** to catch issues early
2. **Track progress regularly** to monitor completion status
3. **Review reports before production deployment** to ensure data quality
4. **Use JSON exports** for automated processing and monitoring
5. **Keep rollback scripts** available for emergency recovery
6. **Document any data quality issues** found during validation
7. **Test migrations on staging** before applying to production

## Troubleshooting

### "Supabase credentials not found"
Ensure environment variables are set:
```bash
export VITE_SUPABASE_URL=your_url
export VITE_SUPABASE_ANON_KEY=your_key
```

### "No vocabulary entries found"
Check that:
- Initial seed migration has been applied
- Entries are marked as `is_published = true`
- CEFR levels are set to 'A0' or 'A1'

### "tsx command not found"
Install dependencies:
```bash
npm install
```

### Reports not generating
Check:
- Database connection is working
- User has read permissions on lexicon_entries table
- RLS policies allow access to published entries
