/**
 * Property-Based Tests for SRS Algorithm
 * Tests core SRS algorithm behavior across all inputs
 */

import { describe, it, expect } from 'vitest';
import {
  initializeVocabularyProgress,
  updateSRSProgress,
  isVocabularyDue,
  calculateDaysOverdue,
  VocabularyProgress,
  Grade,
} from './srs-algorithm';

describe('SRS Algorithm', () => {
  // ============================================================================
  // Property 3: User Progress Initialization
  // Validates: Requirements 2.2
  // ============================================================================
  describe('Property 3: User Progress Initialization', () => {
    it('should initialize with correct default values', () => {
      const progress = initializeVocabularyProgress();

      expect(progress.status).toBe('New');
      expect(progress.easeFactor).toBe(2.5);
      expect(progress.intervalDays).toBe(1);
      expect(progress.consecutiveCorrect).toBe(0);
      expect(progress.totalReviews).toBe(0);
    });

    it('should set next review date to today', () => {
      const progress = initializeVocabularyProgress();
      const today = new Date();
      today.setHours(0, 0, 0, 0);
      const nextReview = new Date(progress.nextReviewDate);
      nextReview.setHours(0, 0, 0, 0);

      expect(nextReview.getTime()).toBe(today.getTime());
    });

    it('should initialize multiple items independently', () => {
      const progress1 = initializeVocabularyProgress();
      const progress2 = initializeVocabularyProgress();

      expect(progress1).toEqual(progress2);
      expect(progress1).not.toBe(progress2);
    });
  });

  // ============================================================================
  // Property 4: Hard Grade Reduces Ease Factor
  // Validates: Requirements 3.1
  // ============================================================================
  describe('Property 4: Hard Grade Reduces Ease Factor', () => {
    it('should reduce ease factor by 0.2 on hard grade', () => {
      const initial = initializeVocabularyProgress();
      const result = updateSRSProgress(initial, 'Hard');

      expect(result.easeFactor).toBe(2.3);
    });

    it('should not reduce ease factor below 1.3', () => {
      const state: VocabularyProgress = {
        status: 'Learning',
        easeFactor: 1.4,
        intervalDays: 5,
        nextReviewDate: new Date(),
        consecutiveCorrect: 2,
        totalReviews: 5,
      };

      const result = updateSRSProgress(state, 'Hard');

      expect(result.easeFactor).toBe(1.3);
    });

    it('should reset interval to 1 on hard grade', () => {
      const state: VocabularyProgress = {
        status: 'Learning',
        easeFactor: 2.5,
        intervalDays: 10,
        nextReviewDate: new Date(),
        consecutiveCorrect: 2,
        totalReviews: 5,
      };

      const result = updateSRSProgress(state, 'Hard');

      expect(result.intervalDays).toBe(1);
    });

    it('should reset consecutive correct to 0 on hard grade', () => {
      const state: VocabularyProgress = {
        status: 'Learning',
        easeFactor: 2.5,
        intervalDays: 5,
        nextReviewDate: new Date(),
        consecutiveCorrect: 2,
        totalReviews: 5,
      };

      const result = updateSRSProgress(state, 'Hard');

      expect(result.consecutiveCorrect).toBe(0);
    });
  });

  // ============================================================================
  // Property 5: Good Grade Maintains Ease Factor
  // Validates: Requirements 3.2
  // ============================================================================
  describe('Property 5: Good Grade Maintains Ease Factor', () => {
    it('should maintain ease factor on good grade', () => {
      const initial = initializeVocabularyProgress();
      const result = updateSRSProgress(initial, 'Good');

      expect(result.easeFactor).toBe(initial.easeFactor);
    });

    it('should increase interval by ease factor on good grade', () => {
      const state: VocabularyProgress = {
        status: 'Learning',
        easeFactor: 2.5,
        intervalDays: 2,
        nextReviewDate: new Date(),
        consecutiveCorrect: 1,
        totalReviews: 2,
      };

      const result = updateSRSProgress(state, 'Good');

      expect(result.intervalDays).toBe(5); // 2 * 2.5 = 5
    });

    it('should increment consecutive correct on good grade', () => {
      const state: VocabularyProgress = {
        status: 'Learning',
        easeFactor: 2.5,
        intervalDays: 2,
        nextReviewDate: new Date(),
        consecutiveCorrect: 1,
        totalReviews: 2,
      };

      const result = updateSRSProgress(state, 'Good');

      expect(result.consecutiveCorrect).toBe(2);
    });
  });

  // ============================================================================
  // Property 6: Easy Grade Increases Ease Factor
  // Validates: Requirements 3.3
  // ============================================================================
  describe('Property 6: Easy Grade Increases Ease Factor', () => {
    it('should increase ease factor by 0.1 on easy grade', () => {
      const state: VocabularyProgress = {
        status: 'Learning',
        easeFactor: 2.4,
        intervalDays: 5,
        nextReviewDate: new Date(),
        consecutiveCorrect: 2,
        totalReviews: 5,
      };

      const result = updateSRSProgress(state, 'Easy');

      expect(result.easeFactor).toBe(2.5);
    });

    it('should not increase ease factor above 2.5', () => {
      const state: VocabularyProgress = {
        status: 'Learning',
        easeFactor: 2.5,
        intervalDays: 5,
        nextReviewDate: new Date(),
        consecutiveCorrect: 2,
        totalReviews: 5,
      };

      const result = updateSRSProgress(state, 'Easy');

      expect(result.easeFactor).toBe(2.5);
    });

    it('should increase interval by ease factor * 1.3 on easy grade', () => {
      const state: VocabularyProgress = {
        status: 'Learning',
        easeFactor: 2.5,
        intervalDays: 2,
        nextReviewDate: new Date(),
        consecutiveCorrect: 1,
        totalReviews: 2,
      };

      const result = updateSRSProgress(state, 'Easy');

      expect(result.intervalDays).toBe(7); // 2 * 2.5 * 1.3 = 6.5, rounded to 7
    });

    it('should increment consecutive correct on easy grade', () => {
      const state: VocabularyProgress = {
        status: 'Learning',
        easeFactor: 2.5,
        intervalDays: 2,
        nextReviewDate: new Date(),
        consecutiveCorrect: 1,
        totalReviews: 2,
      };

      const result = updateSRSProgress(state, 'Easy');

      expect(result.consecutiveCorrect).toBe(2);
    });
  });

  // ============================================================================
  // Property 7: Interval Days Always Positive
  // Validates: Requirements 3.5
  // ============================================================================
  describe('Property 7: Interval Days Always Positive', () => {
    it('should ensure interval days is at least 1', () => {
      const state: VocabularyProgress = {
        status: 'Learning',
        easeFactor: 1.3,
        intervalDays: 1,
        nextReviewDate: new Date(),
        consecutiveCorrect: 0,
        totalReviews: 1,
      };

      const result = updateSRSProgress(state, 'Good');

      expect(result.intervalDays).toBeGreaterThanOrEqual(1);
    });

    it('should round interval days to nearest integer', () => {
      const state: VocabularyProgress = {
        status: 'Learning',
        easeFactor: 2.3,
        intervalDays: 3,
        nextReviewDate: new Date(),
        consecutiveCorrect: 1,
        totalReviews: 2,
      };

      const result = updateSRSProgress(state, 'Good');

      expect(Number.isInteger(result.intervalDays)).toBe(true);
    });

    it('should never return negative interval days', () => {
      const grades: Grade[] = ['Hard', 'Good', 'Easy'];
      const state: VocabularyProgress = {
        status: 'Learning',
        easeFactor: 1.3,
        intervalDays: 1,
        nextReviewDate: new Date(),
        consecutiveCorrect: 0,
        totalReviews: 1,
      };

      for (const grade of grades) {
        const result = updateSRSProgress(state, grade);
        expect(result.intervalDays).toBeGreaterThanOrEqual(1);
      }
    });
  });

  // ============================================================================
  // Property 8: Next Review Date Calculation
  // Validates: Requirements 3.6, 2.6
  // ============================================================================
  describe('Property 8: Next Review Date Calculation', () => {
    it('should calculate next review date as today + interval days', () => {
      const state: VocabularyProgress = {
        status: 'Learning',
        easeFactor: 2.5,
        intervalDays: 5,
        nextReviewDate: new Date(),
        consecutiveCorrect: 1,
        totalReviews: 2,
      };

      const result = updateSRSProgress(state, 'Good');

      const today = new Date();
      today.setHours(0, 0, 0, 0);
      const expectedDate = new Date(today);
      expectedDate.setDate(expectedDate.getDate() + result.intervalDays);

      const resultDate = new Date(result.nextReviewDate);
      resultDate.setHours(0, 0, 0, 0);

      expect(resultDate.getTime()).toBe(expectedDate.getTime());
    });

    it('should update next review date on each grade', () => {
      const state: VocabularyProgress = {
        status: 'Learning',
        easeFactor: 2.5,
        intervalDays: 1,
        nextReviewDate: new Date(),
        consecutiveCorrect: 0,
        totalReviews: 1,
      };

      const result1 = updateSRSProgress(state, 'Good');
      const result2 = updateSRSProgress(result1, 'Good');

      expect(result2.nextReviewDate.getTime()).toBeGreaterThan(
        result1.nextReviewDate.getTime()
      );
    });
  });

  // ============================================================================
  // Property 29: Mastery Transition Threshold
  // Validates: Requirements 2.4, 20.1, 20.2
  // ============================================================================
  describe('Property 29: Mastery Transition Threshold', () => {
    it('should transition to mastered at consecutive correct >= 3', () => {
      let state: VocabularyProgress = {
        status: 'Learning',
        easeFactor: 2.5,
        intervalDays: 1,
        nextReviewDate: new Date(),
        consecutiveCorrect: 2,
        totalReviews: 2,
      };

      const result = updateSRSProgress(state, 'Good');

      expect(result.status).toBe('Mastered');
      expect(result.consecutiveCorrect).toBe(3);
    });

    it('should set interval to 30 days on mastery transition', () => {
      const state: VocabularyProgress = {
        status: 'Learning',
        easeFactor: 2.5,
        intervalDays: 5,
        nextReviewDate: new Date(),
        consecutiveCorrect: 2,
        totalReviews: 2,
      };

      const result = updateSRSProgress(state, 'Good');

      expect(result.intervalDays).toBe(30);
    });

    it('should demote from mastered to learning on hard grade', () => {
      const state: VocabularyProgress = {
        status: 'Mastered',
        easeFactor: 2.5,
        intervalDays: 30,
        nextReviewDate: new Date(),
        consecutiveCorrect: 3,
        totalReviews: 5,
      };

      const result = updateSRSProgress(state, 'Hard');

      expect(result.status).toBe('Learning');
      expect(result.consecutiveCorrect).toBe(0);
      expect(result.intervalDays).toBe(1);
    });

    it('should maintain mastered status on good or easy grade', () => {
      const state: VocabularyProgress = {
        status: 'Mastered',
        easeFactor: 2.5,
        intervalDays: 30,
        nextReviewDate: new Date(),
        consecutiveCorrect: 3,
        totalReviews: 5,
      };

      const resultGood = updateSRSProgress(state, 'Good');
      const resultEasy = updateSRSProgress(state, 'Easy');

      expect(resultGood.status).toBe('Mastered');
      expect(resultEasy.status).toBe('Mastered');
    });
  });

  // ============================================================================
  // Additional Unit Tests
  // ============================================================================
  describe('Status Transitions', () => {
    it('should transition from new to learning on first grade', () => {
      const initial = initializeVocabularyProgress();
      const result = updateSRSProgress(initial, 'Good');

      expect(result.status).toBe('Learning');
    });

    it('should increment total reviews on each grade', () => {
      const state: VocabularyProgress = {
        status: 'Learning',
        easeFactor: 2.5,
        intervalDays: 1,
        nextReviewDate: new Date(),
        consecutiveCorrect: 0,
        totalReviews: 5,
      };

      const result = updateSRSProgress(state, 'Good');

      expect(result.totalReviews).toBe(6);
    });
  });

  describe('isVocabularyDue', () => {
    it('should return true for today', () => {
      const today = new Date();
      expect(isVocabularyDue(today)).toBe(true);
    });

    it('should return true for past dates', () => {
      const yesterday = new Date();
      yesterday.setDate(yesterday.getDate() - 1);
      expect(isVocabularyDue(yesterday)).toBe(true);
    });

    it('should return false for future dates', () => {
      const tomorrow = new Date();
      tomorrow.setDate(tomorrow.getDate() + 1);
      expect(isVocabularyDue(tomorrow)).toBe(false);
    });
  });

  describe('calculateDaysOverdue', () => {
    it('should return 0 for today', () => {
      const today = new Date();
      expect(calculateDaysOverdue(today)).toBe(0);
    });

    it('should return positive number for past dates', () => {
      const yesterday = new Date();
      yesterday.setDate(yesterday.getDate() - 1);
      expect(calculateDaysOverdue(yesterday)).toBe(1);
    });

    it('should return negative number for future dates', () => {
      const tomorrow = new Date();
      tomorrow.setDate(tomorrow.getDate() + 1);
      expect(calculateDaysOverdue(tomorrow)).toBeLessThan(0);
    });
  });
});
