# Asset Linking System - Architecture Overview

## System Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                        ASSET LINKING SYSTEM                      │
└─────────────────────────────────────────────────────────────────┘

┌──────────────────────┐         ┌──────────────────────┐
│   AUTHOR INTERFACE   │         │  STUDENT INTERFACE   │
│                      │         │                      │
│  ┌────────────────┐  │         │  ┌────────────────┐  │
│  │ Lesson Editor  │  │         │  │ Lesson Player  │  │
│  │                │  │         │  │                │  │
│  │ ┌────────────┐ │  │         │  │ ┌────────────┐ │  │
│  │ │   Asset    │ │  │         │  │ │   Linked   │ │  │
│  │ │  Selector  │ │  │         │  │ │   Asset    │ │  │
│  │ │            │ │  │         │  │ │   Viewer   │ │  │
│  │ └────────────┘ │  │         │  │ └────────────┘ │  │
│  └────────────────┘  │         │  └────────────────┘  │
└──────────┬───────────┘         └──────────┬───────────┘
           │                                 │
           │ Link Assets                     │ View Assets
           │                                 │ Track Progress
           ▼                                 ▼
┌─────────────────────────────────────────────────────────────────┐
│                         DATABASE LAYER                           │
│                                                                   │
│  ┌──────────────┐    ┌──────────────┐    ┌──────────────┐      │
│  │   lessons    │    │lesson_assets │    │grammar_      │      │
│  │              │◄───┤              ├───►│chapters      │      │
│  │ - id         │    │ - lesson_id  │    │              │      │
│  │ - title      │    │ - asset_id   │    │ - id         │      │
│  │ - unit_id    │    │ - asset_type │    │ - title      │      │
│  └──────────────┘    │ - is_required│    │ - content    │      │
│                      │ - order_index│    └──────────────┘      │
│                      └──────────────┘                           │
│                             │                                    │
│                             └───────────┐                        │
│                                         ▼                        │
│                                  ┌──────────────┐               │
│                                  │lexicon_      │               │
│                                  │entries       │               │
│                                  │              │               │
│                                  │ - id         │               │
│                                  │ - headword   │               │
│                                  │ - definition │               │
│                                  └──────────────┘               │
│                                                                   │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │              progress_events (Tracking)                   │   │
│  │                                                            │   │
│  │  event_type: 'lesson_asset_viewed'                       │   │
│  │  event_data: {                                           │   │
│  │    lesson_id: uuid,                                      │   │
│  │    asset_id: uuid,                                       │   │
│  │    asset_type: 'grammar' | 'vocabulary',                │   │
│  │    duration: seconds                                     │   │
│  │  }                                                        │   │
│  └──────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────┘
```

## Data Flow Diagrams

### Content Creation Flow

```
Author Opens Lesson Editor
         │
         ▼
Fetch Lesson Data + Linked Assets
         │
         ▼
Display AssetSelector Component
         │
         ├─► Search Grammar Chapters
         │   (from grammar_chapters table)
         │
         ├─► Search Vocabulary Entries
         │   (from lexicon_entries table)
         │
         ▼
Author Clicks "Link" Button
         │
         ▼
INSERT INTO lesson_assets
  (lesson_id, asset_id, asset_type, is_required, order_index)
         │
         ▼
Refresh Linked Assets Display
         │
         ▼
Author Saves Lesson
```

### Student Learning Flow

```
Student Opens Lesson Player
         │
         ▼
Fetch Lesson Data
         │
         ▼
Fetch Linked Assets
  SELECT * FROM lesson_assets
  WHERE lesson_id = ?
  JOIN grammar_chapters / lexicon_entries
         │
         ▼
Display LinkedAssetViewer Component
         │
         ▼
Student Clicks to Expand Asset
         │
         ├─► Start View Timer (3 seconds)
         │
         ├─► Display Asset Content
         │   (grammar explanation or vocab definition)
         │
         ▼
After 3 Seconds OR "Mark as Understood"
         │
         ▼
Call trackAssetView()
         │
         ▼
INSERT INTO progress_events
  event_type: 'lesson_asset_viewed'
  event_data: { lesson_id, asset_id, asset_type, duration }
         │
         ▼
Update UI (show checkmark)
         │
         ▼
Check Lesson Completion
  call check_lesson_assets_completion()
         │
         ▼
All Required Assets Viewed?
  ├─► YES: Allow lesson completion
  └─► NO: Prompt to view remaining assets
```

### Progress Tracking Flow

```
Asset View Event Triggered
         │
         ▼
useActivityTracker.trackAssetView()
         │
         ▼
supabase.rpc('log_activity_event', {
  _user_id: user.id,
  _event_type: 'lesson_asset_viewed',
  _event_data: {
    lesson_id: uuid,
    asset_id: uuid,
    asset_type: 'grammar' | 'vocabulary',
    duration: seconds
  }
})
         │
         ▼
Database Function: log_activity_event()
         │
         ├─► INSERT INTO progress_events
         │
         └─► CALL update_user_streak()
                   │
                   ▼
             Update learner_progress table
                   │
                   ▼
             Return event_id
```

## Component Hierarchy

```
LessonEditorPage
├── AppLayout
├── Lesson Metadata Form
├── Lesson Stages Editor
└── AssetSelector ◄── NEW
    ├── Currently Linked Assets Display
    ├── Search Input
    └── Tabs
        ├── Grammar Tab
        │   └── Grammar Chapter List
        │       └── Link Button
        └── Vocabulary Tab
            └── Lexicon Entry List
                └── Link Button

LessonPlayerPage
├── Header (Progress, Navigation)
├── Sidebar (Stage Navigation)
└── Main Content
    ├── Stage Content
    ├── Comprehension Questions
    ├── Tips Card
    └── LinkedAssetViewer ◄── NEW
        └── Asset Cards
            ├── Asset Header (collapsible)
            ├── Asset Content (expandable)
            │   ├── Grammar: Meaning, Form, Use, Errors
            │   └── Vocabulary: Definition, Examples, Usage
            └── "Mark as Understood" Button
```

## Database Schema Relationships

```
┌─────────────┐
│   courses   │
└──────┬──────┘
       │
       ▼
┌─────────────┐
│   levels    │
└──────┬──────┘
       │
       ▼
┌─────────────┐
│    units    │
└──────┬──────┘
       │
       ▼
┌─────────────┐         ┌──────────────────┐
│   lessons   │◄────────┤  lesson_assets   │
└──────┬──────┘         └────────┬─────────┘
       │                         │
       │                         ├──────────────┐
       │                         │              │
       ▼                         ▼              ▼
┌─────────────┐         ┌──────────────┐  ┌──────────────┐
│lesson_stages│         │grammar_      │  │lexicon_      │
└─────────────┘         │chapters      │  │entries       │
                        └──────────────┘  └──────────────┘

┌─────────────┐
│    users    │
└──────┬──────┘
       │
       ▼
┌─────────────────────┐
│  progress_events    │
│                     │
│  event_type:        │
│  - lesson_start     │
│  - lesson_complete  │
│  - lesson_asset_    │◄── NEW EVENT TYPE
│    viewed           │
└─────────────────────┘
```

## State Management

### AssetSelector Component State

```typescript
{
  searchTerm: string,
  grammarChapters: GrammarChapter[],
  lexiconEntries: LexiconEntry[],
  loading: boolean
}
```

### LinkedAssetViewer Component State

```typescript
{
  assets: LessonAsset[],
  expandedAsset: string | null,
  viewedAssets: Set<string>,
  loading: boolean,
  observerRefs: Map<string, IntersectionObserver>,
  viewTimers: Map<string, { start: number, timer: NodeJS.Timeout }>
}
```

## API Endpoints (Supabase RPC)

### Existing
- `log_activity_event(_user_id, _event_type, _event_data)` → UUID
- `update_user_streak(_user_id)` → VOID

### New
- `check_lesson_assets_completion(_user_id, _lesson_id)` → BOOLEAN
- `get_lesson_completion_status(_user_id, _lesson_id)` → TABLE

## Security Model (RLS Policies)

```
lesson_assets Table:
├── SELECT: Users can view assets for published lessons
│   USING (EXISTS (SELECT 1 FROM lessons WHERE id = lesson_id AND is_published = true))
│
└── ALL: Content creators can manage all assets
    USING (is_content_creator(auth.uid()))
    WITH CHECK (is_content_creator(auth.uid()))

progress_events Table:
├── SELECT: Users can view own events
│   USING (auth.uid() = user_id)
│
├── INSERT: Users can insert own events
│   WITH CHECK (auth.uid() = user_id)
│
└── SELECT: Content creators can view all events
    USING (is_content_creator(auth.uid()))
```

## Performance Considerations

### Indexes
```sql
CREATE INDEX idx_lesson_assets_lesson ON lesson_assets(lesson_id);
CREATE INDEX idx_lesson_assets_type ON lesson_assets(asset_type);
CREATE INDEX idx_lesson_assets_asset ON lesson_assets(asset_id);
CREATE INDEX idx_progress_events_user ON progress_events(user_id);
CREATE INDEX idx_progress_events_type ON progress_events(event_type);
```

### Query Optimization
- Lazy loading: Asset content fetched only when expanded
- Batch queries: Fetch all linked assets in single query with JOINs
- Debouncing: View tracking delayed by 3 seconds to prevent spam
- Caching: Grammar chapters and vocabulary cached in component state

## Error Handling

```
Component Level:
├── Try-catch blocks around all async operations
├── Toast notifications for user-facing errors
├── Graceful degradation if table doesn't exist
└── Loading states during data fetching

Database Level:
├── Foreign key constraints prevent orphaned records
├── Check constraints validate asset_type values
├── Unique constraints prevent duplicate links
└── RLS policies prevent unauthorized access

Application Level:
├── Type assertions for new tables (until types regenerated)
├── Null checks for optional fields
├── Default values for missing data
└── Fallback UI for empty states
```

## Monitoring & Analytics

### Key Metrics to Track
- Asset linking rate (assets per lesson)
- Student engagement rate (% viewing linked assets)
- Average view duration per asset type
- Completion rate (required assets viewed)
- Most/least accessed assets
- Time to first asset view per lesson

### Queries for Analytics
```sql
-- Asset engagement by type
SELECT 
  event_data->>'asset_type' as type,
  COUNT(*) as views,
  AVG((event_data->>'duration')::int) as avg_duration
FROM progress_events
WHERE event_type = 'lesson_asset_viewed'
GROUP BY event_data->>'asset_type';

-- Most viewed assets
SELECT 
  event_data->>'asset_id' as asset_id,
  COUNT(*) as view_count
FROM progress_events
WHERE event_type = 'lesson_asset_viewed'
GROUP BY event_data->>'asset_id'
ORDER BY view_count DESC
LIMIT 10;
```

## Deployment Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    Production Environment                │
│                                                           │
│  ┌──────────────┐         ┌──────────────┐             │
│  │   Frontend   │         │   Supabase   │             │
│  │   (Vercel/   │◄───────►│   (Database  │             │
│  │   Netlify)   │         │   + Auth)    │             │
│  └──────────────┘         └──────────────┘             │
│         │                         │                      │
│         │                         │                      │
│         ▼                         ▼                      │
│  ┌──────────────┐         ┌──────────────┐             │
│  │   React      │         │  PostgreSQL  │             │
│  │   Components │         │  + RLS       │             │
│  └──────────────┘         └──────────────┘             │
└─────────────────────────────────────────────────────────┘
```

This architecture provides a scalable, secure, and performant system for linking educational content to lessons with comprehensive progress tracking.
