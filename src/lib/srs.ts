/**
 * SRS (Spaced Repetition System) Utilities
 * Implements simplified SM-2 algorithm for vocabulary learning
 */

export interface SRSCard {
  id: string;
  user_id: string;
  word_id: string;
  ease_factor: number;
  interval: number;
  repetitions: number;
  next_review_date: string;
  last_reviewed_at: string | null;
  created_at: string;
  updated_at: string;
}

export interface SRSCardWithWord extends SRSCard {
  word: {
    id: string;
    headword: string;
    ipa: string | null;
    definition_simple: string | null;
    definition_teacher: string | null;
    pos: string | null;
    cefr_receptive: string | null;
    cefr_productive: string | null;
    examples: string[];
    collocations: string[];
  };
}

export type UserRating = 0 | 3 | 4 | 5;

export interface RatingOption {
  value: UserRating;
  label: string;
  labelPt: string;
  color: string;
  icon: string;
}

export const RATING_OPTIONS: RatingOption[] = [
  {
    value: 0,
    label: 'Forgot',
    labelPt: 'Errei',
    color: 'bg-red-500 hover:bg-red-600',
    icon: '🔴',
  },
  {
    value: 3,
    label: 'Hard',
    labelPt: 'Lembrei com esforço',
    color: 'bg-orange-500 hover:bg-orange-600',
    icon: '🟠',
  },
  {
    value: 4,
    label: 'Good',
    labelPt: 'Lembrei bem',
    color: 'bg-green-500 hover:bg-green-600',
    icon: '🟢',
  },
  {
    value: 5,
    label: 'Easy',
    labelPt: 'Muito fácil',
    color: 'bg-blue-500 hover:bg-blue-600',
    icon: '🔵',
  },
];

/**
 * Calculate next review parameters based on SM-2 algorithm
 * This is a client-side implementation for reference/testing
 * The actual calculation happens in the database function
 */
export function calculateNextReview(
  currentCard: Pick<SRSCard, 'ease_factor' | 'interval' | 'repetitions'>,
  userRating: UserRating
): Pick<SRSCard, 'ease_factor' | 'interval' | 'repetitions'> {
  let { ease_factor, interval, repetitions } = currentCard;

  if (userRating < 3) {
    // Forgot: Reset progress
    repetitions = 0;
    interval = 1;
    // EF stays the same for MVP
  } else {
    // Remembered: Increment progress
    repetitions += 1;

    // Calculate new interval
    if (repetitions === 1) {
      interval = 1;
    } else if (repetitions === 2) {
      interval = 6;
    } else {
      interval = Math.round(interval * ease_factor);
    }

    // Update ease factor
    ease_factor = Math.max(
      1.3,
      ease_factor + (0.1 - (5 - userRating) * (0.08 + (5 - userRating) * 0.02))
    );
  }

  return { ease_factor, interval, repetitions };
}

/**
 * Check if a card is due for review
 */
export function isCardDue(nextReviewDate: string): boolean {
  return new Date(nextReviewDate) <= new Date();
}

/**
 * Format interval for display
 */
export function formatInterval(days: number): string {
  if (days === 0) return 'New';
  if (days === 1) return '1 day';
  if (days < 30) return `${days} days`;
  if (days < 365) {
    const months = Math.floor(days / 30);
    return months === 1 ? '1 month' : `${months} months`;
  }
  const years = Math.floor(days / 365);
  return years === 1 ? '1 year' : `${years} years`;
}

/**
 * Get next review date as a Date object
 */
export function getNextReviewDate(interval: number): Date {
  const date = new Date();
  date.setDate(date.getDate() + interval);
  return date;
}
