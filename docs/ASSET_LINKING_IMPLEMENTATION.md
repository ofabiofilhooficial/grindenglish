# Asset Linking System Implementation

## Overview

The Asset Linking System bridges the gap between published lessons and the platform's reference databases (grammar chapters and vocabulary). This enables:

1. **Content Integration**: Link grammar chapters and vocabulary entries directly to lessons
2. **Progress Tracking**: Track when students view linked assets
3. **Completion Requirements**: Optionally require students to view specific assets before completing a lesson
4. **Pedagogical Alignment**: Ensure students access the right reference materials at the right time

## Database Schema

### New Table: `lesson_assets`

```sql
CREATE TABLE public.lesson_assets (
  id UUID PRIMARY KEY,
  lesson_id UUID REFERENCES lessons(id),
  asset_type TEXT CHECK (asset_type IN ('grammar', 'vocabulary', 'pronunciation', 'pragmatics')),
  asset_id UUID, -- References grammar_chapters.id or lexicon_entries.id
  order_index INT,
  is_required BOOLEAN DEFAULT true,
  context_note TEXT,
  created_at TIMESTAMPTZ
);
```

### Progress Tracking

The existing `progress_events` table now supports a new event type:

- **Event Type**: `lesson_asset_viewed`
- **Event Data Structure**:
  ```json
  {
    "lesson_id": "uuid",
    "asset_id": "uuid",
    "asset_type": "grammar|vocabulary",
    "duration": 15,
    "timestamp": "2026-03-06T10:30:00Z"
  }
  ```

### Database Functions

#### `check_lesson_assets_completion(_user_id, _lesson_id)`
Returns `BOOLEAN` indicating if all required assets have been viewed.

#### `get_lesson_completion_status(_user_id, _lesson_id)`
Returns comprehensive completion status:
- `is_complete`: Lesson marked as complete
- `assets_complete`: All required assets viewed
- `required_assets_count`: Total required assets
- `viewed_assets_count`: Assets viewed by user

## TypeScript Types

### Updated `Lesson` Interface

```typescript
export interface Lesson {
  // ... existing fields
  assets?: LessonAsset[];
}

export interface LessonAsset {
  id: string;
  lessonId: string;
  assetType: 'grammar' | 'vocabulary' | 'pronunciation' | 'pragmatics';
  assetId: string;
  orderIndex: number;
  isRequired: boolean;
  contextNote?: string;
  grammarChapter?: GrammarChapter;
  lexiconEntry?: LexiconEntry;
}
```

## Components

### 1. AssetSelector (Author Tool)

**Location**: `src/components/author/AssetSelector.tsx`

**Purpose**: Allows content creators to link grammar chapters and vocabulary to lessons.

**Features**:
- Search and filter grammar chapters and vocabulary
- Tab-based interface for different asset types
- Visual indication of already-linked assets
- One-click linking/unlinking
- Displays currently linked assets with badges

**Usage in Lesson Editor**:
```tsx
<AssetSelector
  lessonId={lessonId}
  linkedAssets={linkedAssets}
  onAssetsChange={fetchData}
/>
```

### 2. LinkedAssetViewer (Student Interface)

**Location**: `src/components/lesson/LinkedAssetViewer.tsx`

**Purpose**: Displays linked reference materials to students during lessons.

**Features**:
- Expandable cards for each linked asset
- Automatic view tracking (3-second threshold)
- "Mark as Understood" button for explicit acknowledgment
- Visual indicators for viewed/required assets
- Displays relevant content (meaning, form, use for grammar; definition, examples for vocabulary)
- Duration tracking for analytics

**Usage in Lesson Player**:
```tsx
<LinkedAssetViewer lessonId={lessonId} />
```

## Activity Tracking

### Updated `useActivityTracker` Hook

**New Function**: `trackAssetView(lessonId, assetId, assetType, duration)`

**Usage**:
```typescript
const { trackAssetView } = useActivityTracker();

await trackAssetView(
  'lesson-uuid',
  'asset-uuid',
  'grammar',
  15 // seconds
);
```

**Automatic Tracking**:
- Starts when asset is expanded
- Marks as viewed after 3 seconds
- Records total view duration
- Prevents duplicate tracking

## Pedagogical Implementation

### A0 Course Integration

For the A0 "False Beginners" course:

1. **Grammar Feed Integration**:
   - Link "Survival English" grammar chapters to specific lessons
   - Example: Link "Imperatives for Directions" to A0 Unit 6, Lesson 4

2. **Vocabulary Sync**:
   - Link entries from "A1 Master Lexicon" to Stage 2 "Targeted Input"
   - Ensure vocabulary appears in context during lessons

3. **L1 Support**:
   - Portuguese (pt-BR) glossaries automatically displayed for A0 students
   - Contrast notes help bridge L1/L2 gap

### Workflow for Content Creators

1. **Create/Edit Lesson** in Lesson Editor
2. **Scroll to Asset Selector** section
3. **Search** for relevant grammar chapters or vocabulary
4. **Click "Link"** to associate asset with lesson
5. **Mark as Required** if viewing is mandatory for completion
6. **Add Context Note** (optional) to explain when/why to access
7. **Save Lesson** - assets are now linked

### Student Experience

1. **Start Lesson** in Lesson Player
2. **See "Reference Materials"** card below main content
3. **Click to Expand** any linked asset
4. **Read Content** - viewing is automatically tracked after 3 seconds
5. **Click "Mark as Understood"** to explicitly acknowledge (triggers "Notice the Gap" pedagogical requirement)
6. **Complete Lesson** - system checks if all required assets were viewed

## Analytics & Reporting

### Teacher Dashboard Integration

The `StudentAnalyticsPage.tsx` can now display:

- **Asset Heatmap**: Which grammar chapters students have accessed
- **Completion Rates**: Percentage of required assets viewed per lesson
- **Time Spent**: Duration students spend on each asset type
- **Engagement Patterns**: Most/least accessed reference materials

### Query Examples

**Get all asset views for a student**:
```sql
SELECT 
  pe.event_data->>'asset_type' as asset_type,
  pe.event_data->>'asset_id' as asset_id,
  pe.event_data->>'duration' as duration,
  pe.created_at
FROM progress_events pe
WHERE pe.user_id = 'student-uuid'
  AND pe.event_type = 'lesson_asset_viewed'
ORDER BY pe.created_at DESC;
```

**Check lesson completion with assets**:
```sql
SELECT * FROM get_lesson_completion_status('user-uuid', 'lesson-uuid');
```

## Migration Path

### Step 1: Run Migration
```bash
# Apply the new migration
supabase db push
```

### Step 2: Link Existing Content
1. Open Lesson Editor for each published lesson
2. Use Asset Selector to link relevant grammar/vocabulary
3. Mark critical assets as "Required"

### Step 3: Update Analytics
1. Modify `StudentAnalyticsPage.tsx` to query `lesson_asset_viewed` events
2. Add visualizations for asset engagement

## Best Practices

### For Content Creators

1. **Be Selective**: Only link assets directly relevant to the lesson
2. **Use Context Notes**: Explain when students should access each asset
3. **Mark Strategically**: Only mark truly essential assets as "Required"
4. **Order Matters**: Set `order_index` to match lesson flow
5. **Test Student View**: Preview lessons to ensure assets display correctly

### For Developers

1. **Lazy Loading**: Fetch asset content only when expanded
2. **Caching**: Cache grammar chapters and vocabulary to reduce queries
3. **Error Handling**: Gracefully handle missing or unpublished assets
4. **Performance**: Use indexes on `lesson_id` and `asset_id` for fast queries
5. **RLS**: Ensure students can only view assets for published lessons

## Future Enhancements

1. **Pronunciation Scripts**: Link shadowing exercises to lessons
2. **Pragmatics Packs**: Link speech act guides to relevant lessons
3. **Adaptive Linking**: AI suggests relevant assets based on lesson content
4. **Student Notes**: Allow students to annotate linked assets
5. **Spaced Repetition**: Auto-create SRS cards from viewed vocabulary
6. **Progress Badges**: Award badges for viewing all assets in a unit

## Troubleshooting

### Assets Not Appearing in Lesson Player
- Check if lesson is published (`is_published = true`)
- Verify asset is published in grammar_chapters or lexicon_entries
- Check RLS policies allow student to view lesson_assets

### Tracking Not Working
- Ensure user is authenticated
- Check `log_activity_event` function permissions
- Verify event_data JSON structure is correct

### Performance Issues
- Add indexes if querying large datasets
- Implement pagination for asset lists
- Cache frequently accessed grammar chapters

## Summary

The Asset Linking System provides a robust infrastructure for connecting lessons to reference materials, tracking student engagement, and ensuring pedagogical alignment. It supports the A0 course's "Notice the Gap" methodology by making grammar and vocabulary accessible exactly when students need them.
