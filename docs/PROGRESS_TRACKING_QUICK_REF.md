# Progress Tracking Quick Reference

## Add Activity Tracking to a Page

### Automatic Page View Tracking

```typescript
import { usePageViewTracker } from '@/hooks/useActivityTracker';

export default function MyPage() {
  usePageViewTracker('grammar_view'); // or 'vocab_view', 'dashboard_view', etc.
  
  return <div>Your page content</div>;
}
```

### Custom Event Tracking

```typescript
import { useActivityTracker } from '@/hooks/useActivityTracker';

export default function MyComponent() {
  const { logActivity } = useActivityTracker();
  
  const handleAction = () => {
    logActivity('lesson_complete', {
      lesson_id: 'abc-123',
      score: 95
    });
  };
  
  return <button onClick={handleAction}>Complete</button>;
}
```

## Display Progress Data

```typescript
import { useProgress } from '@/hooks/useProgress';

export default function MyComponent() {
  const { progress, loading } = useProgress();
  
  if (loading) return <div>Loading...</div>;
  
  return (
    <div>
      <p>Streak: {progress?.currentStreak || 0} days</p>
      <p>Time: {progress?.totalStudyTimeMinutes || 0} min</p>
      <p>Words: {progress?.wordsLearned || 0}</p>
    </div>
  );
}
```

## Event Types

- `login` - User logged in
- `dashboard_view` - Dashboard page
- `lesson_start` - Started a lesson
- `lesson_complete` - Completed a lesson
- `grammar_view` - Grammar reference
- `vocab_view` - Vocabulary reference
- `pronunciation_view` - Pronunciation reference
- `pragmatics_view` - Pragmatics reference
- `course_view` - Course page
- `level_view` - Level page
- `unit_view` - Unit page

## Database Queries

### View User Progress
```sql
SELECT * FROM learner_progress WHERE user_id = 'user-uuid';
```

### View Recent Activity
```sql
SELECT * FROM progress_events 
WHERE user_id = 'user-uuid' 
ORDER BY created_at DESC 
LIMIT 10;
```

### Manually Log Event
```sql
SELECT log_activity_event(
  'user-uuid',
  'grammar_view',
  '{"chapter_id": "A0.G.01"}'::jsonb
);
```

## Progress Data Structure

```typescript
interface LearnerProgress {
  currentStreak: number;        // Current consecutive days
  longestStreak: number;        // Best streak ever
  lastActivityDate: string | null;  // Last active date
  totalStudyTimeMinutes: number;    // Total time (not yet tracked)
  wordsLearned: number;             // Words count (not yet tracked)
  grammarChaptersViewed: number;    // Grammar views
  lessonsCompleted: number;         // Lessons done
}
```

## Common Patterns

### Track Page + Custom Events
```typescript
export default function GrammarPage() {
  const { logActivity } = useActivityTracker();
  
  // Track page view
  usePageViewTracker('grammar_view');
  
  // Track chapter opens
  const handleChapterClick = (chapter) => {
    logActivity('grammar_view', {
      chapter_id: chapter.id,
      chapter_code: chapter.chapter_code
    });
  };
  
  return <div>...</div>;
}
```

### Conditional Display
```typescript
const { progress, loading } = useProgress();

{!loading && progress && (
  <div>
    {progress.currentStreak > 0 && (
      <Badge>🔥 {progress.currentStreak} day streak!</Badge>
    )}
  </div>
)}
```

## Troubleshooting

### Streak not updating?
- Check user is authenticated
- Verify RLS policies in Supabase
- Check browser console for errors
- Confirm migration was applied

### Progress not showing?
- User needs at least one activity
- Check `learner_progress` table exists
- Verify `useProgress` hook is called
- Check network tab for API errors

## Files to Know

- Migration: `supabase/migrations/20260305000000_create_progress_tracking.sql`
- Hooks: `src/hooks/useActivityTracker.tsx`, `src/hooks/useProgress.tsx`
- Guide: `docs/PROGRESS_TRACKING_GUIDE.md`
- Implementation: `docs/PROGRESS_TRACKING_IMPLEMENTATION.md`
