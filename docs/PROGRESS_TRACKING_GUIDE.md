# Progress Tracking System

## Overview

The progress tracking system monitors user activity and maintains streak counters, study time, and learning metrics. It automatically tracks when users access the platform and view content.

## Database Schema

### Tables

#### `progress_events`
Logs all user activity events.

| Column | Type | Description |
|--------|------|-------------|
| id | UUID | Primary key |
| user_id | UUID | References auth.users |
| event_type | TEXT | Type of activity (see Event Types below) |
| event_data | JSONB | Additional event metadata |
| created_at | TIMESTAMPTZ | When the event occurred |

#### `learner_progress`
Aggregated progress statistics per user.

| Column | Type | Description |
|--------|------|-------------|
| id | UUID | Primary key |
| user_id | UUID | References auth.users (unique) |
| current_streak | INT | Current consecutive days streak |
| longest_streak | INT | Longest streak ever achieved |
| last_activity_date | DATE | Last day user was active |
| total_study_time_minutes | INT | Total study time in minutes |
| words_learned | INT | Number of vocabulary words learned |
| grammar_chapters_viewed | INT | Number of grammar chapters viewed |
| lessons_completed | INT | Number of lessons completed |
| created_at | TIMESTAMPTZ | Record creation time |
| updated_at | TIMESTAMPTZ | Last update time |

## Event Types

The system tracks the following activity types:

- `login` - User logged in
- `dashboard_view` - User viewed the dashboard
- `lesson_start` - User started a lesson
- `lesson_complete` - User completed a lesson
- `grammar_view` - User viewed a grammar chapter
- `vocab_view` - User viewed a vocabulary entry
- `pronunciation_view` - User viewed pronunciation content
- `pragmatics_view` - User viewed pragmatics content
- `course_view` - User viewed course page
- `level_view` - User viewed a level page
- `unit_view` - User viewed a unit page

## Streak Logic

### How Streaks Work

1. **First Activity**: When a user performs any tracked activity, their streak starts at 1
2. **Consecutive Days**: If the user returns the next day, the streak increments
3. **Broken Streak**: If the user misses a day, the streak resets to 1
4. **Longest Streak**: The system tracks the longest streak ever achieved

### Streak Update Function

The `update_user_streak()` function is called automatically whenever an activity is logged:

```sql
SELECT public.update_user_streak(user_id);
```

This function:
- Creates a learner_progress record if it doesn't exist
- Checks if today is a new day
- Increments streak if consecutive
- Resets streak if broken
- Updates longest_streak if current exceeds it

## Usage in Code

### Tracking Page Views

Use the `usePageViewTracker` hook to automatically track when a user visits a page:

```typescript
import { usePageViewTracker } from '@/hooks/useActivityTracker';

export default function MyPage() {
  // Automatically logs 'grammar_view' when component mounts
  usePageViewTracker('grammar_view');
  
  return <div>...</div>;
}
```

### Tracking Custom Events

Use the `useActivityTracker` hook for custom event tracking:

```typescript
import { useActivityTracker } from '@/hooks/useActivityTracker';

export default function MyComponent() {
  const { logActivity } = useActivityTracker();
  
  const handleAction = async () => {
    await logActivity('lesson_complete', {
      lesson_id: 'abc-123',
      score: 95,
      time_spent: 15
    });
  };
  
  return <button onClick={handleAction}>Complete Lesson</button>;
}
```

### Displaying Progress Data

Use the `useProgress` hook to fetch and display user progress:

```typescript
import { useProgress } from '@/hooks/useProgress';

export default function Dashboard() {
  const { progress, loading } = useProgress();
  
  if (loading) return <div>Loading...</div>;
  
  return (
    <div>
      <p>Current Streak: {progress?.currentStreak || 0} days</p>
      <p>Total Time: {progress?.totalStudyTimeMinutes || 0} minutes</p>
      <p>Words Learned: {progress?.wordsLearned || 0}</p>
    </div>
  );
}
```

## Database Functions

### `log_activity_event()`

Logs an activity event and updates the user's streak.

```sql
SELECT public.log_activity_event(
  _user_id := 'user-uuid',
  _event_type := 'grammar_view',
  _event_data := '{"chapter_id": "A0.G.01"}'::jsonb
);
```

Returns the UUID of the created event.

### `update_user_streak()`

Updates a user's streak based on their last activity date.

```sql
SELECT public.update_user_streak('user-uuid');
```

This is called automatically by `log_activity_event()`.

## Security

### Row Level Security (RLS)

All tables have RLS enabled:

- **Users** can only view and insert their own progress data
- **Content creators** can view all progress data for analytics
- **Admins** have full access

## Future Enhancements

Planned features for the progress tracking system:

1. **Study Time Tracking**: Automatically track time spent on lessons
2. **Words Learned Counter**: Increment when users complete vocabulary exercises
3. **SRS Integration**: Track spaced repetition system performance
4. **Progress Page**: Dedicated page showing detailed progress analytics
5. **Achievements**: Badge system for milestones
6. **Weekly/Monthly Reports**: Email summaries of progress
7. **Leaderboards**: Optional community features

## Migration

To apply the progress tracking system to your database:

1. Run the migration in Supabase SQL Editor:
   ```sql
   -- Copy contents of supabase/migrations/20260305000000_create_progress_tracking.sql
   ```

2. The system will automatically start tracking activity once deployed

3. Existing users will have their progress records created on first activity

## Troubleshooting

### Streak not updating

- Check that the user is authenticated
- Verify RLS policies allow the user to insert/update their progress
- Check browser console for errors
- Verify the `log_activity_event` function is being called

### Progress data not showing

- Ensure the migration has been applied
- Check that the user has performed at least one tracked activity
- Verify the `useProgress` hook is being used correctly
- Check browser console for errors

## API Reference

### Hooks

#### `useActivityTracker()`

Returns an object with:
- `logActivity(eventType, eventData)` - Function to log an activity event

#### `usePageViewTracker(eventType, eventData?)`

Automatically logs an activity when the component mounts.

#### `useProgress()`

Returns an object with:
- `progress` - LearnerProgress object or null
- `loading` - Boolean indicating if data is loading

### Types

```typescript
interface LearnerProgress {
  currentStreak: number;
  longestStreak: number;
  lastActivityDate: string | null;
  totalStudyTimeMinutes: number;
  wordsLearned: number;
  grammarChaptersViewed: number;
  lessonsCompleted: number;
}

type ActivityEventType =
  | 'login'
  | 'dashboard_view'
  | 'lesson_start'
  | 'lesson_complete'
  | 'grammar_view'
  | 'vocab_view'
  | 'pronunciation_view'
  | 'pragmatics_view'
  | 'course_view'
  | 'level_view'
  | 'unit_view';
```
