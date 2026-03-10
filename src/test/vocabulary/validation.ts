/**
 * Validation Query Utilities
 * Provides functions to validate vocabulary data quality
 */

import { SupabaseClient } from '@supabase/supabase-js';
import { LexiconEntry } from './testDatabase';
import { VALID_REGISTERS, VALID_VARIETIES } from './generators';

/**
 * Validation result for missing required fields
 */
export interface MissingFieldsResult {
  headword: string;
  cefr_receptive: string | null;
  missing_fields: string[];
}

/**
 * Validation result for invalid enumerated values
 */
export interface InvalidEnumResult {
  headword: string;
  field: string;
  invalid_value: string | null;
}

/**
 * Validation result for JSONB structure issues
 */
export interface JSONBValidationResult {
  headword: string;
  field: string;
  issue: string;
}

/**
 * Validation result for IPA format issues
 */
export interface IPAValidationResult {
  headword: string;
  ipa: string;
  issue: string;
}

/**
 * Checks for missing required fields in published entries
 * Requirements: 11.1, 11.2
 */
export async function checkMissingRequiredFields(
  client: SupabaseClient
): Promise<MissingFieldsResult[]> {
  const { data, error } = await client
    .from('lexicon_entries')
    .select('headword, cefr_receptive, ipa, definition_simple, definition_teacher, usage_notes, register, variety, examples')
    .eq('is_published', true);

  if (error) {
    throw error;
  }

  const results: MissingFieldsResult[] = [];

  for (const entry of data) {
    const missing: string[] = [];

    if (!entry.ipa || entry.ipa === '') {
      missing.push('ipa');
    }
    if (!entry.definition_simple || entry.definition_simple === '') {
      missing.push('definition_simple');
    }
    if (!entry.definition_teacher || entry.definition_teacher === '') {
      missing.push('definition_teacher');
    }
    if (!entry.usage_notes || entry.usage_notes === '') {
      missing.push('usage_notes');
    }
    if (!entry.register || entry.register === '') {
      missing.push('register');
    }
    if (!entry.variety || entry.variety === '') {
      missing.push('variety');
    }
    if (!entry.examples || (Array.isArray(entry.examples) && entry.examples.length === 0)) {
      missing.push('examples');
    }

    if (missing.length > 0) {
      results.push({
        headword: entry.headword,
        cefr_receptive: entry.cefr_receptive,
        missing_fields: missing,
      });
    }
  }

  return results;
}

/**
 * Validates register values are one of: 'formal', 'neutral', 'informal'
 * Requirements: 11.4
 */
export async function validateRegisterValues(
  client: SupabaseClient
): Promise<InvalidEnumResult[]> {
  const { data, error } = await client
    .from('lexicon_entries')
    .select('headword, register')
    .eq('is_published', true)
    .not('register', 'is', null);

  if (error) {
    throw error;
  }

  const results: InvalidEnumResult[] = [];

  for (const entry of data) {
    if (entry.register && !VALID_REGISTERS.includes(entry.register as any)) {
      results.push({
        headword: entry.headword,
        field: 'register',
        invalid_value: entry.register,
      });
    }
  }

  return results;
}

/**
 * Validates variety values are one of: 'US', 'UK', 'international'
 * Requirements: 11.5
 */
export async function validateVarietyValues(
  client: SupabaseClient
): Promise<InvalidEnumResult[]> {
  const { data, error } = await client
    .from('lexicon_entries')
    .select('headword, variety')
    .eq('is_published', true)
    .not('variety', 'is', null);

  if (error) {
    throw error;
  }

  const results: InvalidEnumResult[] = [];

  for (const entry of data) {
    if (entry.variety && !VALID_VARIETIES.includes(entry.variety as any)) {
      results.push({
        headword: entry.headword,
        field: 'variety',
        invalid_value: entry.variety,
      });
    }
  }

  return results;
}

/**
 * Validates JSONB structure and cardinality
 * Requirements: 11.3
 */
export async function validateJSONBStructure(
  client: SupabaseClient
): Promise<JSONBValidationResult[]> {
  const { data, error } = await client
    .from('lexicon_entries')
    .select('headword, examples, collocations, patterns')
    .eq('is_published', true);

  if (error) {
    throw error;
  }

  const results: JSONBValidationResult[] = [];

  for (const entry of data) {
    // Validate examples
    if (entry.examples !== null) {
      if (!Array.isArray(entry.examples)) {
        results.push({
          headword: entry.headword,
          field: 'examples',
          issue: 'Not a valid JSON array',
        });
      } else {
        // Check if all elements are strings
        const allStrings = entry.examples.every((item: any) => typeof item === 'string');
        if (!allStrings) {
          results.push({
            headword: entry.headword,
            field: 'examples',
            issue: 'Array contains non-string elements',
          });
        }
        // Check cardinality (2-4 items)
        if (entry.examples.length < 2 || entry.examples.length > 4) {
          results.push({
            headword: entry.headword,
            field: 'examples',
            issue: `Invalid cardinality: ${entry.examples.length} (expected 2-4)`,
          });
        }
      }
    }

    // Validate collocations
    if (entry.collocations !== null) {
      if (!Array.isArray(entry.collocations)) {
        results.push({
          headword: entry.headword,
          field: 'collocations',
          issue: 'Not a valid JSON array',
        });
      } else {
        const allStrings = entry.collocations.every((item: any) => typeof item === 'string');
        if (!allStrings) {
          results.push({
            headword: entry.headword,
            field: 'collocations',
            issue: 'Array contains non-string elements',
          });
        }
        // Check cardinality (0-5 items, but if non-empty must be 2-5)
        if (entry.collocations.length > 0 && (entry.collocations.length < 2 || entry.collocations.length > 5)) {
          results.push({
            headword: entry.headword,
            field: 'collocations',
            issue: `Invalid cardinality: ${entry.collocations.length} (expected 0 or 2-5)`,
          });
        }
      }
    }

    // Validate patterns
    if (entry.patterns !== null) {
      if (!Array.isArray(entry.patterns)) {
        results.push({
          headword: entry.headword,
          field: 'patterns',
          issue: 'Not a valid JSON array',
        });
      } else {
        const allStrings = entry.patterns.every((item: any) => typeof item === 'string');
        if (!allStrings) {
          results.push({
            headword: entry.headword,
            field: 'patterns',
            issue: 'Array contains non-string elements',
          });
        }
        // Check cardinality (0-3 items, but if non-empty must be 1-3)
        if (entry.patterns.length > 0 && (entry.patterns.length < 1 || entry.patterns.length > 3)) {
          results.push({
            headword: entry.headword,
            field: 'patterns',
            issue: `Invalid cardinality: ${entry.patterns.length} (expected 0 or 1-3)`,
          });
        }
      }
    }
  }

  return results;
}

/**
 * Checks IPA format compliance (no slashes or brackets)
 * Requirements: 11.3
 */
export async function validateIPAFormat(
  client: SupabaseClient
): Promise<IPAValidationResult[]> {
  const { data, error } = await client
    .from('lexicon_entries')
    .select('headword, ipa')
    .eq('is_published', true)
    .not('ipa', 'is', null);

  if (error) {
    throw error;
  }

  const results: IPAValidationResult[] = [];

  for (const entry of data) {
    if (entry.ipa) {
      const invalidChars = ['/', '[', ']'];
      const foundInvalidChars = invalidChars.filter(char => entry.ipa.includes(char));

      if (foundInvalidChars.length > 0) {
        results.push({
          headword: entry.headword,
          ipa: entry.ipa,
          issue: `Contains invalid characters: ${foundInvalidChars.join(', ')}`,
        });
      }
    }
  }

  return results;
}

/**
 * Runs all validation checks and returns a comprehensive report
 */
export async function runAllValidations(client: SupabaseClient) {
  const [
    missingFields,
    invalidRegisters,
    invalidVarieties,
    jsonbIssues,
    ipaIssues,
  ] = await Promise.all([
    checkMissingRequiredFields(client),
    validateRegisterValues(client),
    validateVarietyValues(client),
    validateJSONBStructure(client),
    validateIPAFormat(client),
  ]);

  return {
    missingFields,
    invalidRegisters,
    invalidVarieties,
    jsonbIssues,
    ipaIssues,
    totalIssues:
      missingFields.length +
      invalidRegisters.length +
      invalidVarieties.length +
      jsonbIssues.length +
      ipaIssues.length,
  };
}

/**
 * Validates a single entry against all rules
 */
export function validateEntry(entry: LexiconEntry): {
  valid: boolean;
  errors: string[];
} {
  const errors: string[] = [];

  // Check required fields
  if (!entry.ipa || entry.ipa === '') {
    errors.push('Missing IPA');
  }
  if (!entry.definition_simple || entry.definition_simple === '') {
    errors.push('Missing simple definition');
  }
  if (!entry.definition_teacher || entry.definition_teacher === '') {
    errors.push('Missing teacher definition');
  }
  if (!entry.usage_notes || entry.usage_notes === '') {
    errors.push('Missing usage notes');
  }
  if (!entry.register || entry.register === '') {
    errors.push('Missing register');
  }
  if (!entry.variety || entry.variety === '') {
    errors.push('Missing variety');
  }

  // Check register value
  if (entry.register && !VALID_REGISTERS.includes(entry.register as any)) {
    errors.push(`Invalid register: ${entry.register}`);
  }

  // Check variety value
  if (entry.variety && !VALID_VARIETIES.includes(entry.variety as any)) {
    errors.push(`Invalid variety: ${entry.variety}`);
  }

  // Check IPA format
  if (entry.ipa && (entry.ipa.includes('/') || entry.ipa.includes('[') || entry.ipa.includes(']'))) {
    errors.push('IPA contains invalid characters (/, [, ])');
  }

  // Check examples
  if (!Array.isArray(entry.examples)) {
    errors.push('Examples is not an array');
  } else {
    if (entry.examples.length < 2 || entry.examples.length > 4) {
      errors.push(`Examples cardinality invalid: ${entry.examples.length} (expected 2-4)`);
    }
    if (!entry.examples.every(item => typeof item === 'string')) {
      errors.push('Examples contains non-string elements');
    }
  }

  // Check collocations
  if (!Array.isArray(entry.collocations)) {
    errors.push('Collocations is not an array');
  } else {
    if (entry.collocations.length > 0 && (entry.collocations.length < 2 || entry.collocations.length > 5)) {
      errors.push(`Collocations cardinality invalid: ${entry.collocations.length} (expected 0 or 2-5)`);
    }
    if (!entry.collocations.every(item => typeof item === 'string')) {
      errors.push('Collocations contains non-string elements');
    }
  }

  // Check patterns
  if (!Array.isArray(entry.patterns)) {
    errors.push('Patterns is not an array');
  } else {
    if (entry.patterns.length > 0 && (entry.patterns.length < 1 || entry.patterns.length > 3)) {
      errors.push(`Patterns cardinality invalid: ${entry.patterns.length} (expected 0 or 1-3)`);
    }
    if (!entry.patterns.every(item => typeof item === 'string')) {
      errors.push('Patterns contains non-string elements');
    }
  }

  return {
    valid: errors.length === 0,
    errors,
  };
}
