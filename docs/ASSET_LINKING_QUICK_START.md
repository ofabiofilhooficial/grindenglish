# Asset Linking Quick Start Guide

## For Content Creators

### Linking Assets to a Lesson

1. Navigate to **Course Builder** → Select your level → Select unit → Click on a lesson
2. Scroll down to the **"Linked Reference Content"** section
3. Use the search bar to find grammar chapters or vocabulary entries
4. Switch between **Grammar** and **Vocabulary** tabs
5. Click **"Link"** button next to any asset you want to add
6. Linked assets appear at the top with options to unlink

### Best Practices

- **Link 2-5 assets per lesson** (avoid overwhelming students)
- **Use context notes** to explain when to access each asset
- **Mark as Required** only for essential content
- **Order matters**: Assets appear in the order you link them

### Example: A0 Unit 1, Lesson 3

**Lesson**: "Introducing Yourself"

**Linked Assets**:
1. Grammar: "Present Simple - To Be" (Required)
2. Grammar: "Personal Pronouns" (Required)
3. Vocabulary: "greet" (Optional)
4. Vocabulary: "introduce" (Optional)
5. Vocabulary: "name" (Required)

## For Students

### Accessing Reference Materials

1. Open any lesson in the **Lesson Player**
2. Scroll to the **"Reference Materials"** section
3. Click on any card to expand and view content
4. Read the grammar explanation or vocabulary definition
5. Click **"Mark as Understood"** when you've reviewed it
6. A green checkmark appears when viewed

### What Gets Tracked

- ✅ When you expand an asset (after 3 seconds)
- ✅ How long you view each asset
- ✅ When you click "Mark as Understood"
- ✅ Which assets are required vs optional

## For Developers

### Quick Integration

**1. Add Asset Selector to any editor**:
```tsx
import { AssetSelector } from '@/components/author/AssetSelector';

<AssetSelector
  lessonId={lessonId}
  linkedAssets={linkedAssets}
  onAssetsChange={refetchData}
/>
```

**2. Add Asset Viewer to any player**:
```tsx
import { LinkedAssetViewer } from '@/components/lesson/LinkedAssetViewer';

<LinkedAssetViewer lessonId={lessonId} />
```

**3. Track asset views manually**:
```tsx
import { useActivityTracker } from '@/hooks/useActivityTracker';

const { trackAssetView } = useActivityTracker();

await trackAssetView(lessonId, assetId, 'grammar', 30);
```

### Database Queries

**Fetch linked assets for a lesson**:
```typescript
const { data } = await supabase
  .from('lesson_assets')
  .select('*, grammar_chapters(*), lexicon_entries(*)')
  .eq('lesson_id', lessonId)
  .order('order_index');
```

**Check if user viewed all required assets**:
```typescript
const { data } = await supabase
  .rpc('check_lesson_assets_completion', {
    _user_id: userId,
    _lesson_id: lessonId
  });
```

**Get completion status**:
```typescript
const { data } = await supabase
  .rpc('get_lesson_completion_status', {
    _user_id: userId,
    _lesson_id: lessonId
  });
```

## Common Scenarios

### Scenario 1: Grammar-Heavy Lesson
Link 3-4 grammar chapters that are practiced in the lesson. Mark the primary chapter as Required.

### Scenario 2: Vocabulary Focus
Link 10-15 target vocabulary items. Mark high-frequency words as Required.

### Scenario 3: Integrated Skills
Link 1-2 grammar chapters + 5-8 vocabulary items. Use context notes to indicate which stage they're needed for.

### Scenario 4: Review Lesson
Link previously taught grammar/vocab for recycling. Mark all as Optional since it's review.

## Troubleshooting

**Q: Assets don't appear in Lesson Player**
- Ensure lesson is published
- Check that grammar chapters/vocabulary are published
- Verify you're logged in as a student

**Q: Tracking not working**
- Check browser console for errors
- Ensure you're authenticated
- Wait 3 seconds after expanding an asset

**Q: Can't link an asset**
- Asset might already be linked
- Check if asset is published
- Verify you have content creator permissions

**Q: How do I unlink an asset?**
- In Lesson Editor, find the asset in "Currently Linked" section
- Click the X button next to it

## Next Steps

1. ✅ Run the database migration
2. ✅ Link assets to your first lesson
3. ✅ Test in Lesson Player as a student
4. ✅ Check analytics to see tracking data
5. ✅ Roll out to all lessons in your course

## Support

For detailed implementation information, see:
- `docs/ASSET_LINKING_IMPLEMENTATION.md` - Full technical documentation
- `src/components/author/AssetSelector.tsx` - Author component source
- `src/components/lesson/LinkedAssetViewer.tsx` - Student component source
