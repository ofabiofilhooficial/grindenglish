/**
 * SRS Algorithm Implementation
 * Implements the Spaced Repetition System algorithm for vocabulary learning
 * Based on the Active Lexicon Engine specification
 */

export type Grade = 'Hard' | 'Good' | 'Easy';
export type VocabularyStatus = 'New' | 'Learning' | 'Mastered';

export interface VocabularyProgress {
  status: VocabularyStatus;
  easeFactor: number;
  intervalDays: number;
  nextReviewDate: Date;
  consecutiveCorrect: number;
  totalReviews: number;
}

export interface SRSUpdateResult extends VocabularyProgress {
  message: string;
}

/**
 * Initialize vocabulary progress for a new item
 * Sets initial values: status=New, ease_factor=2.5, interval_days=1, etc.
 */
export function initializeVocabularyProgress(): VocabularyProgress {
  return {
    status: 'New',
    easeFactor: 2.5,
    intervalDays: 1,
    nextReviewDate: new Date(),
    consecutiveCorrect: 0,
    totalReviews: 0,
  };
}

/**
 * Update vocabulary progress based on user grade
 * Implements the SRS algorithm with Hard, Good, Easy grades
 */
export function updateSRSProgress(
  currentState: VocabularyProgress,
  grade: Grade
): SRSUpdateResult {
  let newEaseFactor = currentState.easeFactor;
  let newIntervalDays = currentState.intervalDays;
  let newConsecutiveCorrect = currentState.consecutiveCorrect;
  let newStatus = currentState.status;
  let message = '';

  // Apply SRS algorithm based on grade
  if (grade === 'Hard') {
    // Hard grade: Reset progress
    newEaseFactor = Math.max(1.3, currentState.easeFactor - 0.2);
    newIntervalDays = 1;
    newConsecutiveCorrect = 0;
    message = 'Keep practicing this word. It will appear again soon.';
  } else if (grade === 'Good') {
    // Good grade: Maintain ease factor, increase interval
    newEaseFactor = currentState.easeFactor;
    newIntervalDays = Math.max(
      1,
      Math.round(currentState.intervalDays * currentState.easeFactor)
    );
    newConsecutiveCorrect = currentState.consecutiveCorrect + 1;
    message = "Nice work. You'll see this word again in a few days.";
  } else if (grade === 'Easy') {
    // Easy grade: Increase ease factor and interval
    newEaseFactor = Math.min(2.5, currentState.easeFactor + 0.1);
    newIntervalDays = Math.max(
      1,
      Math.round(currentState.intervalDays * currentState.easeFactor * 1.3)
    );
    newConsecutiveCorrect = currentState.consecutiveCorrect + 1;
    message = "Excellent. You've mastered this word.";
  }

  // Ensure interval_days is positive integer
  newIntervalDays = Math.max(1, Math.round(newIntervalDays));

  // Calculate next review date
  const nextReviewDate = new Date();
  nextReviewDate.setDate(nextReviewDate.getDate() + newIntervalDays);

  // Check for status transition to Mastered
  if (newConsecutiveCorrect >= 3 && currentState.status !== 'Mastered') {
    newStatus = 'Mastered';
    newIntervalDays = 30;
    const masteredDate = new Date();
    masteredDate.setDate(masteredDate.getDate() + 30);
    return {
      status: newStatus,
      easeFactor: newEaseFactor,
      intervalDays: newIntervalDays,
      nextReviewDate: masteredDate,
      consecutiveCorrect: newConsecutiveCorrect,
      totalReviews: currentState.totalReviews + 1,
      message: "Excellent. You've mastered this word.",
    };
  }

  // Handle demotion from Mastered
  if (currentState.status === 'Mastered' && grade === 'Hard') {
    newStatus = 'Learning';
    newConsecutiveCorrect = 0;
    newIntervalDays = 1;
    const demotedDate = new Date();
    demotedDate.setDate(demotedDate.getDate() + 1);
    return {
      status: newStatus,
      easeFactor: newEaseFactor,
      intervalDays: newIntervalDays,
      nextReviewDate: demotedDate,
      consecutiveCorrect: newConsecutiveCorrect,
      totalReviews: currentState.totalReviews + 1,
      message: 'Keep practicing this word. It will appear again soon.',
    };
  }

  // Transition from New to Learning
  if (currentState.status === 'New') {
    newStatus = 'Learning';
  }

  return {
    status: newStatus,
    easeFactor: newEaseFactor,
    intervalDays: newIntervalDays,
    nextReviewDate,
    consecutiveCorrect: newConsecutiveCorrect,
    totalReviews: currentState.totalReviews + 1,
    message,
  };
}

/**
 * Check if a vocabulary item is due for review
 */
export function isVocabularyDue(nextReviewDate: Date): boolean {
  const today = new Date();
  today.setHours(0, 0, 0, 0);
  const reviewDate = new Date(nextReviewDate);
  reviewDate.setHours(0, 0, 0, 0);
  return reviewDate <= today;
}

/**
 * Calculate days overdue for a vocabulary item
 */
export function calculateDaysOverdue(nextReviewDate: Date): number {
  const today = new Date();
  today.setHours(0, 0, 0, 0);
  const reviewDate = new Date(nextReviewDate);
  reviewDate.setHours(0, 0, 0, 0);
  const diffTime = today.getTime() - reviewDate.getTime();
  const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
  return diffDays;
}
