# 🚨 URGENT: Run This Migration Now

## The Error You're Seeing

```
Error: could not find the 'stage_id' column of 'lesson_assets' in the schema cache
```

This happens because the database doesn't have the `stage_id` column yet.

## How to Fix It (2 Minutes)

### Option 1: Supabase Dashboard (Easiest)

1. Go to your Supabase project dashboard
2. Click on "SQL Editor" in the left sidebar
3. Click "New Query"
4. Copy and paste this SQL:

```sql
-- Add stage_id column to lesson_assets
ALTER TABLE public.lesson_assets
ADD COLUMN stage_id UUID REFERENCES public.lesson_stages(id) ON DELETE CASCADE;

-- Add indexes for performance
CREATE INDEX idx_lesson_assets_stage_id ON public.lesson_assets(stage_id);
CREATE INDEX idx_lesson_assets_lesson_stage ON public.lesson_assets(lesson_id, stage_id);

-- Add comment
COMMENT ON COLUMN public.lesson_assets.stage_id IS 'Optional: If set, asset is linked to a specific stage. If NULL, asset is available throughout the lesson.';

-- Update unique constraint
ALTER TABLE public.lesson_assets DROP CONSTRAINT IF EXISTS lesson_assets_lesson_id_asset_type_asset_id_key;

ALTER TABLE public.lesson_assets 
ADD CONSTRAINT lesson_assets_lesson_stage_type_asset_unique 
UNIQUE(lesson_id, stage_id, asset_type, asset_id);
```

5. Click "Run" (or press Ctrl+Enter)
6. You should see "Success. No rows returned"
7. Refresh your app and try linking assets again

### Option 2: Using Supabase CLI

If you have Supabase CLI installed:

```bash
supabase db push
```

This will apply the migration file: `supabase/migrations/20260306000002_add_stage_id_to_lesson_assets.sql`

### Option 3: Direct Database Connection

If you have a PostgreSQL client (like pgAdmin, DBeaver, or psql):

1. Get your database connection string from Supabase dashboard
2. Connect to the database
3. Run the SQL from Option 1

## Verify It Worked

After running the migration, check if it worked:

```sql
-- This should return one row showing the stage_id column
SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_name = 'lesson_assets' AND column_name = 'stage_id';
```

Expected result:
```
column_name | data_type | is_nullable
------------|-----------|------------
stage_id    | uuid      | YES
```

## What This Does

- Adds a `stage_id` column to the `lesson_assets` table
- Allows you to link assets to specific stages (when `stage_id` is set)
- Allows you to link assets to the entire lesson (when `stage_id` is NULL)
- All existing assets will have `stage_id = NULL` (lesson-level)

## After Migration

Once the migration is complete:

1. Refresh your browser
2. Go to the lesson editor
3. Expand a lesson stage
4. You should now see "Stage Resources" at the bottom
5. Try linking a grammar chapter or vocabulary entry
6. It should work without errors!

## Still Having Issues?

If you still see errors after running the migration:

1. Check the browser console (F12) for detailed error messages
2. Verify the migration ran successfully in Supabase
3. Try clearing your browser cache and refreshing
4. Check that your Supabase connection is working

## Need Help?

The migration file is located at:
`supabase/migrations/20260306000002_add_stage_id_to_lesson_assets.sql`

You can also check the full documentation in:
`docs/STAGE_ASSET_MIGRATION.md`
