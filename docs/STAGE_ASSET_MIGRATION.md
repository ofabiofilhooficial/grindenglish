# Stage Asset Integration - Database Migration

## Required Database Changes

To support stage-specific asset linking, the `lesson_assets` table needs a new optional column.

### Migration SQL

```sql
-- Add stage_id column to lesson_assets table
ALTER TABLE lesson_assets
ADD COLUMN stage_id UUID REFERENCES lesson_stages(id) ON DELETE CASCADE;

-- Add index for performance
CREATE INDEX idx_lesson_assets_stage_id ON lesson_assets(stage_id);

-- Add index for querying lesson-level assets
CREATE INDEX idx_lesson_assets_lesson_stage ON lesson_assets(lesson_id, stage_id);
```

### Migration Notes

1. **Nullable Column**: The `stage_id` column is nullable to support both:
   - Stage-specific assets (when `stage_id` is set)
   - Lesson-level assets (when `stage_id` is NULL)

2. **Cascade Delete**: When a stage is deleted, its linked assets are automatically removed

3. **Existing Data**: All existing `lesson_assets` records will have `stage_id = NULL`, making them lesson-level assets

4. **No Breaking Changes**: The application handles both NULL and non-NULL `stage_id` values gracefully

### Verification Queries

After migration, verify the changes:

```sql
-- Check the new column exists
SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_name = 'lesson_assets' AND column_name = 'stage_id';

-- Check existing assets (should all have NULL stage_id)
SELECT COUNT(*) as lesson_level_assets
FROM lesson_assets
WHERE stage_id IS NULL;

-- Check foreign key constraint
SELECT
    tc.constraint_name,
    tc.table_name,
    kcu.column_name,
    ccu.table_name AS foreign_table_name,
    ccu.column_name AS foreign_column_name
FROM information_schema.table_constraints AS tc
JOIN information_schema.key_column_usage AS kcu
    ON tc.constraint_name = kcu.constraint_name
JOIN information_schema.constraint_column_usage AS ccu
    ON ccu.constraint_name = tc.constraint_name
WHERE tc.table_name = 'lesson_assets' AND kcu.column_name = 'stage_id';
```

### Rollback Plan

If needed, the migration can be rolled back:

```sql
-- Remove indexes
DROP INDEX IF EXISTS idx_lesson_assets_stage_id;
DROP INDEX IF EXISTS idx_lesson_assets_lesson_stage;

-- Remove column
ALTER TABLE lesson_assets DROP COLUMN stage_id;
```

## TypeScript Type Updates

The `LessonAsset` interface in `src/types/course.ts` should be updated to include the optional `stageId`:

```typescript
export interface LessonAsset {
  id: string;
  lessonId: string;
  stageId?: string; // NEW: Optional stage ID
  assetType: 'grammar' | 'vocabulary' | 'pronunciation' | 'pragmatics';
  assetId: string;
  orderIndex: number;
  isRequired: boolean;
  contextNote?: string;
  grammarChapter?: GrammarChapter;
  lexiconEntry?: LexiconEntry;
}
```

## Testing Checklist

After migration:

- [ ] Verify existing lesson-level assets still display correctly
- [ ] Test linking a grammar chapter to a specific stage
- [ ] Test linking vocabulary to a specific stage
- [ ] Verify stage assets appear in the lesson player
- [ ] Test unlinking stage-specific assets
- [ ] Verify lesson-level assets appear at the bottom of the lesson player
- [ ] Test deleting a stage with linked assets (should cascade)
- [ ] Verify asset tracking/analytics still work
- [ ] Test with lessons that have no assets
- [ ] Test with lessons that have only lesson-level assets
- [ ] Test with lessons that have only stage-specific assets
- [ ] Test with lessons that have both types of assets
