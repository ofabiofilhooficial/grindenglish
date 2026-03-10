/**
 * Test Data Generators for Vocabulary Entries
 * Uses fast-check for property-based testing
 */

import * as fc from 'fast-check';
import { LexiconEntry } from './testDatabase';

/**
 * Valid register values
 */
export const VALID_REGISTERS = ['formal', 'neutral', 'informal'] as const;

/**
 * Valid variety values
 */
export const VALID_VARIETIES = ['US', 'UK', 'international'] as const;

/**
 * Valid CEFR levels
 */
export const VALID_CEFR_LEVELS = ['A0', 'A1', 'A2', 'B1', 'B2', 'C1', 'C2'] as const;

/**
 * Valid POS tags
 */
export const VALID_POS = ['noun', 'verb', 'adj', 'adv', 'prep', 'conj', 'pron', 'det', 'interj'] as const;

/**
 * Valid entry types
 */
export const VALID_ENTRY_TYPES = ['lemma', 'phrase', 'collocation', 'discourse_marker', 'routine'] as const;

/**
 * Generates a valid register value
 */
export const registerArbitrary = () => fc.constantFrom(...VALID_REGISTERS);

/**
 * Generates a valid variety value
 */
export const varietyArbitrary = () => fc.constantFrom(...VALID_VARIETIES);

/**
 * Generates a valid CEFR level
 */
export const cefrLevelArbitrary = () => fc.constantFrom(...VALID_CEFR_LEVELS);

/**
 * Generates a valid POS tag
 */
export const posArbitrary = () => fc.constantFrom(...VALID_POS);

/**
 * Generates a valid entry type
 */
export const entryTypeArbitrary = () => fc.constantFrom(...VALID_ENTRY_TYPES);

/**
 * Generates a valid IPA transcription (without slashes or brackets)
 */
export const ipaArbitrary = () =>
  fc.stringOf(
    fc.constantFrom(
      'a', 'e', 'i', 'o', 'u', 'ə', 'ɪ', 'ʊ', 'ɛ', 'ɔ', 'æ', 'ʌ', 'ɑ',
      'p', 'b', 't', 'd', 'k', 'g', 'f', 'v', 'θ', 'ð', 's', 'z', 'ʃ', 'ʒ',
      'h', 'm', 'n', 'ŋ', 'l', 'r', 'w', 'j',
      'ː', 'ˈ', 'ˌ', '.'
    ),
    { minLength: 1, maxLength: 20 }
  );

/**
 * Generates a simple definition (1-2 sentences using simple vocabulary)
 */
export const simpleDefinitionArbitrary = () =>
  fc.oneof(
    fc.string({ minLength: 10, maxLength: 100 }).map(s => s + '.'),
    fc.tuple(
      fc.string({ minLength: 10, maxLength: 80 }),
      fc.string({ minLength: 10, maxLength: 80 })
    ).map(([s1, s2]) => `${s1}. ${s2}.`)
  );

/**
 * Generates a teacher definition (detailed linguistic definition)
 */
export const teacherDefinitionArbitrary = () =>
  fc.string({ minLength: 20, maxLength: 300 });

/**
 * Generates usage notes
 */
export const usageNotesArbitrary = () =>
  fc.string({ minLength: 20, maxLength: 200 });

/**
 * Generates an array of examples (2-4 items)
 */
export const examplesArbitrary = () =>
  fc.array(
    fc.string({ minLength: 10, maxLength: 100 }),
    { minLength: 2, maxLength: 4 }
  );

/**
 * Generates an array of collocations (0-5 items)
 */
export const collocationsArbitrary = () =>
  fc.array(
    fc.string({ minLength: 5, maxLength: 50 }),
    { minLength: 0, maxLength: 5 }
  );

/**
 * Generates an array of patterns (0-3 items)
 */
export const patternsArbitrary = () =>
  fc.array(
    fc.string({ minLength: 10, maxLength: 80 }),
    { minLength: 0, maxLength: 3 }
  );

/**
 * Generates a headword (simple English word)
 */
export const headwordArbitrary = () =>
  fc.stringOf(
    fc.constantFrom(...'abcdefghijklmnopqrstuvwxyz'.split('')),
    { minLength: 2, maxLength: 15 }
  );

/**
 * Generates a complete valid lexicon entry
 */
export const validLexiconEntryArbitrary = (): fc.Arbitrary<Partial<LexiconEntry>> =>
  fc.record({
    headword: headwordArbitrary(),
    entry_type: entryTypeArbitrary(),
    pos: posArbitrary(),
    cefr_receptive: cefrLevelArbitrary(),
    cefr_productive: cefrLevelArbitrary(),
    ipa: ipaArbitrary(),
    definition_simple: simpleDefinitionArbitrary(),
    definition_teacher: teacherDefinitionArbitrary(),
    usage_notes: usageNotesArbitrary(),
    register: registerArbitrary(),
    variety: varietyArbitrary(),
    examples: examplesArbitrary(),
    collocations: collocationsArbitrary(),
    patterns: patternsArbitrary(),
    is_published: fc.boolean(),
  });

/**
 * Generates a minimal lexicon entry (only required fields)
 */
export const minimalLexiconEntryArbitrary = (): fc.Arbitrary<Partial<LexiconEntry>> =>
  fc.record({
    headword: headwordArbitrary(),
    entry_type: entryTypeArbitrary(),
    is_published: fc.constant(false),
  });

/**
 * Generates a published GSL entry with all required fields
 */
export const publishedGSLEntryArbitrary = (): fc.Arbitrary<Partial<LexiconEntry>> =>
  fc.record({
    headword: headwordArbitrary(),
    entry_type: fc.constant('lemma'),
    pos: posArbitrary(),
    cefr_receptive: fc.constantFrom('A0', 'A1'),
    cefr_productive: fc.constantFrom('A0', 'A1'),
    ipa: ipaArbitrary(),
    definition_simple: simpleDefinitionArbitrary(),
    definition_teacher: teacherDefinitionArbitrary(),
    usage_notes: usageNotesArbitrary(),
    register: registerArbitrary(),
    variety: varietyArbitrary(),
    examples: examplesArbitrary(),
    collocations: collocationsArbitrary(),
    patterns: patternsArbitrary(),
    is_published: fc.constant(true),
  });

/**
 * Generates an entry with invalid register value
 */
export const invalidRegisterEntryArbitrary = (): fc.Arbitrary<Partial<LexiconEntry>> =>
  fc.record({
    headword: headwordArbitrary(),
    entry_type: entryTypeArbitrary(),
    register: fc.string({ minLength: 1, maxLength: 20 }).filter(
      s => !VALID_REGISTERS.includes(s as any)
    ),
    is_published: fc.constant(true),
  });

/**
 * Generates an entry with invalid variety value
 */
export const invalidVarietyEntryArbitrary = (): fc.Arbitrary<Partial<LexiconEntry>> =>
  fc.record({
    headword: headwordArbitrary(),
    entry_type: entryTypeArbitrary(),
    variety: fc.string({ minLength: 1, maxLength: 20 }).filter(
      s => !VALID_VARIETIES.includes(s as any)
    ),
    is_published: fc.constant(true),
  });

/**
 * Generates an entry with invalid IPA (contains slashes or brackets)
 */
export const invalidIPAEntryArbitrary = (): fc.Arbitrary<Partial<LexiconEntry>> =>
  fc.record({
    headword: headwordArbitrary(),
    entry_type: entryTypeArbitrary(),
    ipa: fc.oneof(
      fc.string().map(s => `/${s}/`),
      fc.string().map(s => `[${s}]`),
      fc.string().map(s => `${s}/`),
      fc.string().map(s => `${s}[`),
    ),
    is_published: fc.constant(true),
  });

/**
 * Generates an entry with invalid examples cardinality (not 2-4)
 */
export const invalidExamplesCardinalityArbitrary = (): fc.Arbitrary<Partial<LexiconEntry>> =>
  fc.record({
    headword: headwordArbitrary(),
    entry_type: entryTypeArbitrary(),
    examples: fc.oneof(
      fc.constant([]),
      fc.array(fc.string(), { minLength: 1, maxLength: 1 }),
      fc.array(fc.string(), { minLength: 5, maxLength: 10 })
    ),
    is_published: fc.constant(true),
  });

/**
 * Generates text with special characters (quotes, apostrophes, accents)
 */
export const specialCharacterTextArbitrary = () =>
  fc.stringOf(
    fc.constantFrom(
      ...'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '.split(''),
      "'", '"', 'á', 'é', 'í', 'ó', 'ú', 'ñ', 'ç', 'à', 'è'
    ),
    { minLength: 10, maxLength: 100 }
  );
