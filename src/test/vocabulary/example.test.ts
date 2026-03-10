/**
 * Example Tests for Vocabulary Testing Infrastructure
 * Demonstrates usage of the testing utilities
 */

import { describe, it, expect } from 'vitest';
import {
  createTestClient,
  validateEntry,
  generateTestHeadword,
} from './index';

describe('Vocabulary Testing Infrastructure', () => {
  const client = createTestClient();

  it('should create a test database client', () => {
    expect(client).toBeDefined();
  });

  it('should validate a complete entry', () => {
    const validEntry = {
      id: 'test-id',
      headword: 'test',
      entry_type: 'lemma',
      pos: 'noun',
      cefr_receptive: 'A1',
      cefr_productive: 'A1',
      ipa: 'test',
      definition_simple: 'A test word.',
      definition_teacher: 'A word used for testing purposes.',
      usage_notes: 'This is a test entry.',
      register: 'neutral',
      variety: 'international',
      examples: ['This is a test.', 'Another test example.'],
      collocations: [],
      patterns: [],
      frequency_band: null,
      is_published: true,
      created_at: new Date().toISOString(),
      updated_at: new Date().toISOString(),
    };

    const validation = validateEntry(validEntry as any);
    expect(validation.valid).toBe(true);
    expect(validation.errors).toHaveLength(0);
  });

  it('should detect validation errors', () => {
    const invalidEntry = {
      id: 'test-id',
      headword: 'test',
      entry_type: 'lemma',
      pos: null,
      cefr_receptive: null,
      cefr_productive: null,
      ipa: '/invalid/',
      definition_simple: '',
      definition_teacher: null,
      usage_notes: null,
      register: 'invalid_register',
      variety: null,
      examples: ['only one'],
      collocations: [],
      patterns: [],
      frequency_band: null,
      is_published: true,
      created_at: new Date().toISOString(),
      updated_at: new Date().toISOString(),
    };

    const validation = validateEntry(invalidEntry as any);
    expect(validation.valid).toBe(false);
    expect(validation.errors.length).toBeGreaterThan(0);
    
    // Check specific errors
    expect(validation.errors).toContain('IPA contains invalid characters (/, [, ])');
    expect(validation.errors).toContain('Missing simple definition');
    expect(validation.errors).toContain('Invalid register: invalid_register');
    expect(validation.errors).toContain('Examples cardinality invalid: 1 (expected 2-4)');
  });

  it('should generate unique test headwords', () => {
    const headword1 = generateTestHeadword('test1');
    const headword2 = generateTestHeadword('test2');
    
    expect(headword1).toContain('test_');
    expect(headword2).toContain('test_');
    expect(headword1).not.toBe(headword2);
  });
});
