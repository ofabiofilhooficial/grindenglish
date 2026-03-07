# Stage Asset Integration

## Overview
Assets (grammar chapters and vocabulary entries) can now be linked to specific lesson stages, allowing students to see relevant resources exactly when they need them during the lesson.

## Features

### For Course Authors

#### Lesson Editor Enhancements
- Each lesson stage now has an inline asset selector
- Link grammar chapters and vocabulary entries directly to specific stages
- Assets appear in a compact, collapsible format within each stage card
- Lesson-level assets can still be added for general reference

#### Two-Level Asset Organization
1. **Stage-Specific Assets**: Linked to individual stages, shown to students during that stage
2. **Lesson-Level Assets**: General resources available throughout the entire lesson

### For Students

#### Lesson Player Experience
- Assets are displayed within each stage as students progress
- Stage-specific resources appear in context with stage instructions
- Expandable cards show detailed grammar explanations or vocabulary definitions
- "Mark as Understood" button to track comprehension
- Lesson-level assets remain available at the bottom for reference

#### Asset Display Features
- Grammar chapters show: meaning, form, use, and common errors
- Vocabulary entries show: pronunciation (IPA), definition, and examples
- Visual indicators for viewed/understood assets
- Smooth expand/collapse interactions

## Database Structure

### lesson_assets Table
The `lesson_assets` table now supports an optional `stage_id` field:
- `lesson_id`: Required - links to the lesson
- `stage_id`: Optional - if provided, asset is stage-specific; if null, asset is lesson-level
- `asset_type`: 'grammar' or 'vocabulary'
- `asset_id`: UUID of the grammar chapter or lexicon entry
- `order_index`: Display order
- `is_required`: Whether the asset is required or optional

## Components

### AssetSelector
**Location**: `src/components/author/AssetSelector.tsx`

**Props**:
- `lessonId`: Required - the lesson to link assets to
- `stageId`: Optional - if provided, assets are linked to this stage
- `linkedAssets`: Current linked assets
- `onAssetsChange`: Callback when assets are modified
- `compact`: Optional - compact mode for inline display in stages

**Usage**:
```tsx
// Lesson-level assets
<AssetSelector
  lessonId={lessonId}
  linkedAssets={lessonLevelAssets}
  onAssetsChange={fetchData}
/>

// Stage-specific assets
<AssetSelector
  lessonId={lessonId}
  stageId={stageId}
  linkedAssets={stageAssets}
  onAssetsChange={fetchData}
  compact
/>
```

### StageAssetViewer
**Location**: `src/components/lesson/StageAssetViewer.tsx`

Displays assets linked to a specific stage in the lesson player.

**Props**:
- `lessonId`: Required
- `stageId`: Required - the stage to show assets for
- `onAssetViewed`: Optional callback when an asset is viewed

### LinkedAssetViewer
**Location**: `src/components/lesson/LinkedAssetViewer.tsx`

Updated to only show lesson-level assets (those without a `stage_id`).

## Implementation Notes

### Backward Compatibility
- Existing lesson-level assets continue to work (they have `stage_id = null`)
- The system gracefully handles lessons with no stage-specific assets
- Both asset types can coexist in the same lesson

### Activity Tracking
- Asset views are tracked for analytics
- 3-second view threshold before marking as "viewed"
- Tracks duration and asset type for progress reporting

## Usage Guide

### Adding Stage-Specific Assets

1. Open the Lesson Editor for your lesson
2. Expand the stage where you want to add resources
3. Use the "Stage Resources" selector at the bottom of the stage card
4. Search and link relevant grammar chapters or vocabulary
5. Save the lesson

### Student Experience

1. Student opens a lesson and sees the first stage
2. Stage instructions appear with any linked resources below
3. Student can expand resources to see full explanations
4. Student marks resources as understood when ready
5. Progress to next stage - new stage-specific resources appear

## Benefits

- **Contextual Learning**: Resources appear exactly when needed
- **Reduced Cognitive Load**: Students see only relevant materials per stage
- **Better Organization**: Clear separation between stage-specific and general resources
- **Improved Tracking**: Analytics on which resources students use at each stage
- **Flexible Design**: Authors can choose stage-level or lesson-level linking as appropriate
