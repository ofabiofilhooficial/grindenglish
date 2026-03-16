/**
 * Property-Based Tests for Parsers and Serializers
 * Tests cloze and L1 notes parsing/serialization
 */

import { describe, it, expect } from 'vitest';
import {
  parseCloze,
  serializeCloze,
  parseL1Notes,
  serializeL1Notes,
  ParsedL1Notes,
} from './parsers';

describe('Cloze Parser and Serializer', () => {
  // ============================================================================
  // Property 20: Cloze Sentence Generation
  // Validates: Requirements 9.2, 21.1, 21.2
  // ============================================================================
  describe('Property 20: Cloze Sentence Generation', () => {
    it('should replace target word with blank', () => {
      const sentence = 'I have breakfast at 7 AM';
      const target = 'have';
      const result = parseCloze(sentence, target);

      expect(result).toBe('I _____ breakfast at 7 AM');
    });

    it('should handle case-insensitive matching', () => {
      const sentence = 'I Have breakfast at 7 AM';
      const target = 'have';
      const result = parseCloze(sentence, target);

      expect(result).toBe('I _____ breakfast at 7 AM');
    });

    it('should handle capitalized target word at sentence start', () => {
      const sentence = 'Have you finished your homework?';
      const target = 'have';
      const result = parseCloze(sentence, target);

      expect(result).toBe('_____ you finished your homework?');
    });

    it('should replace only first occurrence', () => {
      const sentence = 'I have a cat and I have a dog';
      const target = 'have';
      const result = parseCloze(sentence, target);

      expect(result).toBe('I _____ a cat and I have a dog');
    });

    it('should handle punctuation attached to target word', () => {
      const sentence = 'I have, therefore I am.';
      const target = 'have';
      const result = parseCloze(sentence, target);

      expect(result).toBe('I _____, therefore I am.');
    });

    it('should handle multiple punctuation marks', () => {
      const sentence = 'Do you have...? Yes, I have!';
      const target = 'have';
      const result = parseCloze(sentence, target);

      expect(result).toBe('Do you _____...? Yes, I have!');
    });

    it('should throw error when target word not found', () => {
      const sentence = 'I eat breakfast at 7 AM';
      const target = 'have';

      expect(() => parseCloze(sentence, target)).toThrow(
        'Target word not found in example sentence'
      );
    });

    it('should handle single word sentences', () => {
      const sentence = 'Run';
      const target = 'run';
      const result = parseCloze(sentence, target);

      expect(result).toBe('_____');
    });

    it('should handle words with apostrophes', () => {
      const sentence = "I don't have time";
      const target = 'have';
      const result = parseCloze(sentence, target);

      expect(result).toBe("I don't _____ time");
    });
  });

  // ============================================================================
  // Property 21: Cloze Sentence Round Trip
  // Validates: Requirements 21.4
  // ============================================================================
  describe('Property 21: Cloze Sentence Round Trip', () => {
    it('should round trip: parse -> serialize -> parse', () => {
      const sentence = 'I have breakfast at 7 AM';
      const target = 'have';

      const cloze1 = parseCloze(sentence, target);
      const restored = serializeCloze(cloze1, target);
      const cloze2 = parseCloze(restored, target);

      expect(cloze1).toBe(cloze2);
    });

    it('should round trip with capitalized word', () => {
      const sentence = 'Have you finished?';
      const target = 'have';

      const cloze1 = parseCloze(sentence, target);
      const restored = serializeCloze(cloze1, target);
      const cloze2 = parseCloze(restored, target);

      expect(cloze1).toBe(cloze2);
    });

    it('should round trip with punctuation', () => {
      const sentence = 'I have, therefore I am.';
      const target = 'have';

      const cloze1 = parseCloze(sentence, target);
      const restored = serializeCloze(cloze1, target);
      const cloze2 = parseCloze(restored, target);

      expect(cloze1).toBe(cloze2);
    });

    it('should restore original sentence structure', () => {
      const sentence = 'The quick brown fox jumps over the lazy dog';
      const target = 'quick';

      const cloze = parseCloze(sentence, target);
      const restored = serializeCloze(cloze, target);

      expect(restored).toBe(sentence);
    });
  });

  describe('serializeCloze', () => {
    it('should restore complete sentence from cloze', () => {
      const cloze = 'I _____ breakfast at 7 AM';
      const target = 'have';
      const result = serializeCloze(cloze, target);

      expect(result).toBe('I have breakfast at 7 AM');
    });

    it('should throw error when blank not found', () => {
      const cloze = 'I have breakfast at 7 AM';
      const target = 'have';

      expect(() => serializeCloze(cloze, target)).toThrow('Cloze blank not found');
    });

    it('should handle multiple blanks (replaces first)', () => {
      const cloze = '_____ _____ breakfast at 7 AM';
      const target = 'I';
      const result = serializeCloze(cloze, target);

      expect(result).toBe('I _____ breakfast at 7 AM');
    });

    it('should clean up extra spaces', () => {
      const cloze = 'I  _____  breakfast';
      const target = 'have';
      const result = serializeCloze(cloze, target);

      expect(result).toBe('I have breakfast');
    });
  });
});

describe('L1 Notes Parser and Serializer', () => {
  // ============================================================================
  // Property 22: L1 Notes Format Validation
  // Validates: Requirements 22.2
  // ============================================================================
  describe('Property 22: L1 Notes Format Validation', () => {
    it('should parse valid L1 notes format', () => {
      const notes = 'make vs. do: Use make for creating; use do for actions';
      const result = parseL1Notes(notes);

      expect(result.term1).toBe('make');
      expect(result.term2).toBe('do');
      expect(result.explanation).toBe(
        'Use make for creating; use do for actions'
      );
    });

    it('should handle whitespace around terms', () => {
      const notes = '  make  vs.  do  : explanation';
      const result = parseL1Notes(notes);

      expect(result.term1).toBe('make');
      expect(result.term2).toBe('do');
      expect(result.explanation).toBe('explanation');
    });

    it('should throw error when missing colon', () => {
      const notes = 'make vs. do explanation';

      expect(() => parseL1Notes(notes)).toThrow(
        "Invalid L1_Notes format. Expected 'term1 vs. term2: explanation'"
      );
    });

    it('should throw error when missing vs separator', () => {
      const notes = 'make and do: explanation';

      expect(() => parseL1Notes(notes)).toThrow(
        "Invalid L1_Notes format. Expected 'term1 vs. term2: explanation'"
      );
    });

    it('should handle complex explanations', () => {
      const notes =
        'there vs. their: "there" is a place; "their" shows possession';
      const result = parseL1Notes(notes);

      expect(result.term1).toBe('there');
      expect(result.term2).toBe('their');
      expect(result.explanation).toBe(
        '"there" is a place; "their" shows possession'
      );
    });

    it('should handle multi-word terms', () => {
      const notes = 'look at vs. look for: different meanings';
      const result = parseL1Notes(notes);

      expect(result.term1).toBe('look at');
      expect(result.term2).toBe('look for');
      expect(result.explanation).toBe('different meanings');
    });
  });

  // ============================================================================
  // Property 23: L1 Notes Round Trip
  // Validates: Requirements 22.4
  // ============================================================================
  describe('Property 23: L1 Notes Round Trip', () => {
    it('should round trip: parse -> serialize -> parse', () => {
      const notes = 'make vs. do: Use make for creating; use do for actions';

      const parsed1 = parseL1Notes(notes);
      const serialized = serializeL1Notes(parsed1);
      const parsed2 = parseL1Notes(serialized);

      expect(parsed1).toEqual(parsed2);
    });

    it('should preserve exact format on round trip', () => {
      const notes = 'have vs. there is: have shows possession';

      const parsed = parseL1Notes(notes);
      const serialized = serializeL1Notes(parsed);

      expect(serialized).toBe(notes);
    });

    it('should handle complex round trip', () => {
      const notes =
        'look at vs. look for: "look at" means observe; "look for" means search';

      const parsed1 = parseL1Notes(notes);
      const serialized = serializeL1Notes(parsed1);
      const parsed2 = parseL1Notes(serialized);

      expect(parsed1).toEqual(parsed2);
    });
  });

  describe('serializeL1Notes', () => {
    it('should format parsed notes correctly', () => {
      const parsed: ParsedL1Notes = {
        term1: 'make',
        term2: 'do',
        explanation: 'Use make for creating; use do for actions',
      };

      const result = serializeL1Notes(parsed);

      expect(result).toBe(
        'make vs. do: Use make for creating; use do for actions'
      );
    });

    it('should handle multi-word terms', () => {
      const parsed: ParsedL1Notes = {
        term1: 'look at',
        term2: 'look for',
        explanation: 'different meanings',
      };

      const result = serializeL1Notes(parsed);

      expect(result).toBe('look at vs. look for: different meanings');
    });
  });
});
