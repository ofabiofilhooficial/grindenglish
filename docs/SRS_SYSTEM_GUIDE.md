# SRS (Spaced Repetition System) Guide

## Overview

The SRS system helps students retain vocabulary through scientifically-proven spaced repetition. It uses a simplified SM-2 algorithm to schedule reviews at optimal intervals based on how well the student remembers each word.

## How It Works

### For Students

1. **Learning New Words**
   - When you view a vocabulary word for the first time, it's added to your SRS deck
   - When you close the definition, you'll be asked to rate how well you remembered it

2. **Rating Your Recall**
   - 🔴 **Forgot / Errei** - You didn't remember the word
   - 🟠 **Hard / Lembrei com esforço** - You remembered with effort
   - 🟢 **Good / Lembrei bem** - You remembered well
   - 🔵 **Easy / Muito fácil** - Very easy to remember

3. **Daily Reviews**
   - Check your dashboard for due reviews
   - Click "Time to Review" to start your review session
   - Review each word and rate your recall
   - The system automatically schedules the next review

### Review Schedule

The system uses these intervals based on your performance:

- **First review**: 1 day
- **Second review**: 6 days
- **Subsequent reviews**: Interval multiplied by ease factor (typically 2-3x longer each time)
- **If you forget**: Reset to 1 day

## Database Schema

### `srs_cards` Table

| Column | Type | Description |
|--------|------|-------------|
| id | UUID | Primary key |
| user_id | UUID | References auth.users |
| word_id | UUID | References lexicon_entries |
| ease_factor | FLOAT | Multiplier for intervals (starts at 2.5, min 1.3) |
| interval | INT | Current interval in days |
| repetitions | INT | Successful recalls in a row |
| next_review_date | TIMESTAMPTZ | When the word is due for review |
| last_reviewed_at | TIMESTAMPTZ | Last review timestamp |
| created_at | TIMESTAMPTZ | Card creation time |
| updated_at | TIMESTAMPTZ | Last update time |

## SM-2 Algorithm

The system implements a simplified version of the SM-2 (SuperMemo 2) algorithm:

### Variables

- **EF** (Ease Factor): Starts at 2.5, minimum 1.3
- **I** (Interval): Days until next review
- **R** (Repetitions): Successful recalls in a row

### Calculation Rules

**If rating < 3 (Forgot):**
- R = 0 (reset repetitions)
- I = 1 (review tomorrow)
- EF = unchanged (for MVP)

**If rating >= 3 (Remembered):**
- R = R + 1 (increment repetitions)
- If R == 1: I = 1 day
- If R == 2: I = 6 days
- If R > 2: I = round(I × EF)
- EF = max(1.3, EF + (0.1 - (5 - rating) × (0.08 + (5 - rating) × 0.02)))

## Components

### SRSReviewModal

The metacognitive assessment modal that appears when closing a word definition.

**Props:**
- `open` - Boolean to control visibility
- `onOpenChange` - Callback when modal state changes
- `cardId` - UUID of the SRS card
- `wordHeadword` - The word being reviewed
- `onReviewComplete` - Callback after successful review

**Usage:**
```typescript
<SRSReviewModal
  open={showModal}
  onOpenChange={setShowModal}
  cardId={card.id}
  wordHeadword="hello"
  onReviewComplete={() => console.log('Review complete')}
/>
```

### SRSReviewQueue

Dashboard component showing due reviews and managing review sessions.

**Features:**
- Shows count of due words
- Bilingual call-to-action (EN/PT)
- Full-screen review session
- Progress tracking
- Automatic progression through cards

**Usage:**
```typescript
import { SRSReviewQueue } from '@/components/srs/SRSReviewQueue';

<SRSReviewQueue />
```

## Hooks

### useSRS()

Main hook for SRS operations.

**Returns:**
- `dueCount` - Number of cards due for review
- `loading` - Loading state
- `fetchDueCount()` - Refresh due count
- `getOrCreateCard(wordId)` - Get or create SRS card for a word
- `reviewCard(cardId, rating)` - Submit a review rating
- `getCardForWord(wordId)` - Get existing card for a word
- `needsReview(wordId)` - Check if word needs review
- `fetchDueCards()` - Get all due cards with word details

**Example:**
```typescript
const { dueCount, reviewCard, getOrCreateCard } = useSRS();

// Check due count
console.log(`${dueCount} words due`);

// Create card for new word
const cardId = await getOrCreateCard(wordId);

// Submit review
await reviewCard(cardId, 4); // Rating: Good
```

## Database Functions

### get_or_create_srs_card()

Gets existing SRS card or creates a new one.

```sql
SELECT get_or_create_srs_card(
  _user_id := 'user-uuid',
  _word_id := 'word-uuid'
);
```

Returns: Card UUID

### update_srs_card()

Updates card based on user rating and calculates next review.

```sql
SELECT * FROM update_srs_card(
  _card_id := 'card-uuid',
  _user_rating := 4
);
```

Returns: Table with new ease_factor, interval, repetitions, next_review_date

### get_due_cards_count()

Gets count of cards due for review.

```sql
SELECT get_due_cards_count('user-uuid');
```

Returns: Integer count

## Integration Points

### Vocabulary Reference Page

When a user closes a word definition:

1. Check if word needs review (`needsReview()`)
2. If yes, get or create SRS card (`getOrCreateCard()`)
3. Show SRS review modal
4. User rates their recall
5. Card is updated and next review scheduled

### Dashboard

Shows SRS review queue component:

1. Displays count of due words
2. Provides "Start Review" button
3. Opens review session dialog
4. Loops through due cards
5. Shows SRS review modal for each card
6. Tracks completion progress

## Words Learned Counter

The SRS system automatically updates the `words_learned` counter in `learner_progress`:

- Increments when a word is successfully recalled for the first time (repetitions: 0 → 1+)
- Uses a database trigger for automatic updates
- Displayed on the dashboard

## Security

### Row Level Security (RLS)

All SRS cards are protected:

- Users can only view/modify their own cards
- Content creators can view all cards for analytics
- Automatic user_id validation on all operations

## Testing

### Manual Testing

1. **Create a card:**
   - View a vocabulary word
   - Close the definition
   - Rate your recall

2. **Check the card:**
```sql
SELECT * FROM srs_cards 
WHERE user_id = 'your-user-id' 
ORDER BY created_at DESC 
LIMIT 1;
```

3. **Test review:**
   - Wait for next_review_date to pass (or manually update it)
   - Visit dashboard
   - Click "Start Review"
   - Complete the review

4. **Verify words_learned:**
```sql
SELECT words_learned FROM learner_progress 
WHERE user_id = 'your-user-id';
```

### Test Different Ratings

```sql
-- Test "Forgot" (rating 0)
SELECT * FROM update_srs_card('card-uuid', 0);
-- Should reset: repetitions=0, interval=1

-- Test "Good" (rating 4)
SELECT * FROM update_srs_card('card-uuid', 4);
-- Should increment: repetitions+1, interval increases

-- Test "Easy" (rating 5)
SELECT * FROM update_srs_card('card-uuid', 5);
-- Should increase ease_factor more
```

## Future Enhancements

### Short Term
1. Add audio pronunciation to review cards
2. Show example sentences during review
3. Add "Skip" option for review sessions
4. Statistics page showing retention rates

### Medium Term
1. Customizable review intervals
2. Bulk import of vocabulary lists
3. Export SRS data for analysis
4. Review history and performance graphs

### Long Term
1. Advanced SM-2+ algorithms
2. Context-based reviews (sentences, not just words)
3. Collaborative decks
4. Mobile app with offline support

## Troubleshooting

### Reviews not appearing

**Check:**
- User is authenticated
- Words have been viewed and rated
- `next_review_date` is in the past
- RLS policies allow access

**Query:**
```sql
SELECT * FROM srs_cards 
WHERE user_id = 'your-user-id' 
AND next_review_date <= now();
```

### Words_learned not incrementing

**Check:**
- Trigger is installed
- Rating is >= 3 (remembered)
- Card repetitions went from 0 to 1+

**Query:**
```sql
SELECT * FROM pg_trigger 
WHERE tgname = 'update_words_learned_on_review';
```

### Ease factor not changing

**Check:**
- Rating is >= 3
- Formula is correct in `update_srs_card` function

**Test:**
```sql
-- Should show different ease_factors
SELECT * FROM update_srs_card('card-uuid', 3); -- Hard
SELECT * FROM update_srs_card('card-uuid', 5); -- Easy
```

## Best Practices

### For Students

1. **Be honest with ratings** - Accurate ratings lead to better scheduling
2. **Review daily** - Consistency is key for retention
3. **Don't skip reviews** - Overdue reviews lose effectiveness
4. **Use "Forgot" when unsure** - Better to review sooner than later

### For Teachers

1. **Monitor student progress** - Check SRS analytics
2. **Encourage daily reviews** - Set expectations for review frequency
3. **Quality over quantity** - Better to master fewer words well
4. **Provide context** - Good definitions and examples improve retention

## API Reference

### Types

```typescript
interface SRSCard {
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

interface SRSCardWithWord extends SRSCard {
  word: {
    id: string;
    headword: string;
    ipa: string | null;
    definition_simple: string | null;
    // ... other word fields
  };
}

type UserRating = 0 | 3 | 4 | 5;
```

### Functions

```typescript
// Get due count
const count = await supabase.rpc('get_due_cards_count', {
  _user_id: userId
});

// Get or create card
const cardId = await supabase.rpc('get_or_create_srs_card', {
  _user_id: userId,
  _word_id: wordId
});

// Update card
const result = await supabase.rpc('update_srs_card', {
  _card_id: cardId,
  _user_rating: 4
});
```

## Migration

To apply the SRS system:

1. Run migration: `supabase/migrations/20260306000000_create_srs_system.sql`
2. Deploy frontend code
3. Test with a vocabulary word
4. Verify card creation and review scheduling

## Resources

- [SuperMemo SM-2 Algorithm](https://www.supermemo.com/en/archives1990-2015/english/ol/sm2)
- [Spaced Repetition Research](https://en.wikipedia.org/wiki/Spaced_repetition)
- [Anki Documentation](https://docs.ankiweb.net/) (popular SRS app)
