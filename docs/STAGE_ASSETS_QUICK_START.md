# Stage Assets - Quick Start Guide

## What Changed?

You can now link grammar chapters and vocabulary entries to specific lesson stages, not just to the entire lesson. This means students see the right resources at the right time as they progress through each stage.

## For You (Course Author)

### Before (Old Way)
- Assets were linked to the entire lesson
- Students saw all resources at once at the bottom
- No way to organize resources by stage

### After (New Way)
- Assets can be linked to specific stages OR to the entire lesson
- Students see stage-specific resources as they progress
- Better organization and contextual learning

## How to Use It

### Step 1: Open Your Lesson in the Editor
Navigate to: Author → Course Builder → Select Level → Select Unit → Click on a Lesson

### Step 2: Add Resources to a Stage
1. Scroll to the lesson stages section
2. Find the stage where you want to add resources
3. Look for the "Stage Resources" section at the bottom of each stage card
4. Click to expand the resource selector

### Step 3: Link Grammar or Vocabulary
1. Use the search box to find resources
2. Switch between "Grammar" and "Vocabulary" tabs
3. Click "Link" next to any resource you want to add
4. The resource will now appear for students during that stage

### Step 4: Add Lesson-Level Resources (Optional)
- Scroll to the bottom of the lesson editor
- Use the "Linked Reference Content" section
- These resources appear at the bottom of the lesson for general reference

### Step 5: Save Your Changes
Click the "Save" button at the top right

## What Students See

### During a Lesson
1. Student starts the lesson and sees Stage 1
2. Stage instructions appear
3. Below the instructions, any linked resources for that stage appear
4. Student can expand resources to read full explanations
5. Student clicks "Mark as Understood" when ready
6. Student moves to Stage 2 - new stage-specific resources appear

### Resource Display
- **Grammar chapters** show: meaning, form, use
- **Vocabulary entries** show: pronunciation, definition, examples
- Resources are collapsible to reduce clutter
- Visual checkmarks show which resources have been reviewed

## Example Use Case

### Lesson: "Talking About Past Experiences"

**Stage 1: Warm-up** (3 min)
- No resources needed

**Stage 2: Lead-in** (5 min)
- Link vocabulary: "experience", "memorable", "journey"

**Stage 3: Listening** (10 min)
- Link vocabulary: "adventure", "unexpected", "destination"

**Stage 4: Language Focus** (10 min)
- Link grammar: "Past Simple vs Present Perfect"
- Link grammar: "Time expressions with present perfect"

**Stage 5: Practice** (12 min)
- Link vocabulary: "recently", "ever", "never"

**Lesson-Level Resources**:
- Grammar: "Question formation"
- Vocabulary: "Travel vocabulary list"

## Tips

1. **Be Selective**: Only link resources that are directly relevant to each stage
2. **Progressive Disclosure**: Start with basic resources in early stages, add complexity later
3. **Mix Types**: Combine grammar and vocabulary as needed
4. **Use Lesson-Level**: For general reference materials that don't fit a specific stage
5. **Test It**: Preview the lesson as a student to see if resources appear at the right time

## Troubleshooting

### "I don't see the Stage Resources section"
- Make sure you've saved the lesson at least once
- Check that the stage has been created (not just added but saved)

### "Resources aren't showing for students"
- Verify the lesson is published (not in draft mode)
- Check that the grammar chapter or vocabulary entry is also published
- Ensure you clicked "Save" after linking resources

### "I want to move a resource to a different stage"
- Unlink it from the current stage (click the X)
- Go to the new stage and link it there

### "I want a resource available in multiple stages"
- Link it separately to each stage where it's needed
- Or make it a lesson-level resource if it's needed throughout

## Database Migration Required

Before this feature works, your database needs to be updated. See `STAGE_ASSET_MIGRATION.md` for the SQL migration script.

The migration adds a `stage_id` column to the `lesson_assets` table, allowing assets to be linked to specific stages.
