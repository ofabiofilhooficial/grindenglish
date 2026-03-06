# Asset Linking System - Deployment Checklist

## Pre-Deployment

### Database Preparation
- [ ] Review migration file: `supabase/migrations/20260306000001_create_lesson_assets_linking.sql`
- [ ] Backup current database (if production)
- [ ] Test migration in development environment
- [ ] Verify no conflicts with existing tables

### Code Review
- [ ] Review all TypeScript changes for type safety
- [ ] Check component imports and exports
- [ ] Verify RLS policies are secure
- [ ] Test error handling in all components

### Testing
- [ ] Test AssetSelector component in Lesson Editor
- [ ] Test LinkedAssetViewer component in Lesson Player
- [ ] Verify tracking events are logged correctly
- [ ] Test with different user roles (admin, teacher, student)
- [ ] Test edge cases (no assets, all required, all optional)

## Deployment Steps

### Step 1: Database Migration
```bash
# Navigate to project root
cd /path/to/project

# Apply migration
supabase db push

# Verify tables created
supabase db inspect
```

**Expected Output**:
- ✅ Table `lesson_assets` created
- ✅ Indexes created on lesson_id, asset_type, asset_id
- ✅ Functions `check_lesson_assets_completion` and `get_lesson_completion_status` created
- ✅ RLS policies applied

### Step 2: Verify Database
```sql
-- Check table exists
SELECT * FROM lesson_assets LIMIT 1;

-- Test function
SELECT check_lesson_assets_completion(
  'test-user-id'::uuid, 
  'test-lesson-id'::uuid
);

-- Verify RLS policies
SELECT * FROM pg_policies WHERE tablename = 'lesson_assets';
```

### Step 3: Deploy Frontend Code
```bash
# Install dependencies (if needed)
npm install

# Build application
npm run build

# Deploy to hosting (adjust for your platform)
# Example for Vercel:
vercel deploy --prod

# Example for Netlify:
netlify deploy --prod
```

### Step 4: Smoke Tests
- [ ] Open Lesson Editor as content creator
- [ ] Verify AssetSelector appears and loads data
- [ ] Link a grammar chapter to a test lesson
- [ ] Link a vocabulary entry to the same lesson
- [ ] Save and verify links persist
- [ ] Open Lesson Player as student
- [ ] Verify LinkedAssetViewer displays linked assets
- [ ] Expand an asset and wait 3 seconds
- [ ] Check database for `lesson_asset_viewed` event
- [ ] Click "Mark as Understood" button
- [ ] Verify checkmark appears

## Post-Deployment

### Monitoring
- [ ] Monitor database query performance
- [ ] Check error logs for any issues
- [ ] Monitor event logging rate
- [ ] Verify RLS policies working correctly

### Data Validation
```sql
-- Check event logging
SELECT 
  event_type,
  COUNT(*) as count,
  MAX(created_at) as last_event
FROM progress_events
WHERE event_type = 'lesson_asset_viewed'
GROUP BY event_type;

-- Check linked assets
SELECT 
  asset_type,
  COUNT(*) as count,
  COUNT(DISTINCT lesson_id) as lessons_with_links
FROM lesson_assets
GROUP BY asset_type;

-- Check completion rates
SELECT 
  l.title,
  COUNT(DISTINCT la.id) as total_assets,
  COUNT(DISTINCT CASE WHEN la.is_required THEN la.id END) as required_assets
FROM lessons l
LEFT JOIN lesson_assets la ON la.lesson_id = l.id
GROUP BY l.id, l.title
ORDER BY total_assets DESC;
```

### User Communication
- [ ] Notify content creators about new feature
- [ ] Share quick start guide: `docs/ASSET_LINKING_QUICK_START.md`
- [ ] Provide training session (optional)
- [ ] Create video tutorial (optional)
- [ ] Update platform documentation

### Content Migration
- [ ] Identify priority lessons for asset linking
- [ ] Start with A0 Unit 1 (highest priority)
- [ ] Link grammar chapters to relevant lessons
- [ ] Link vocabulary entries to relevant lessons
- [ ] Mark critical assets as "Required"
- [ ] Add context notes where helpful
- [ ] Test student experience for each unit

## Rollback Plan

### If Issues Occur

**Option 1: Rollback Migration**
```bash
# Revert to previous migration
supabase db reset

# Or manually drop objects
```

```sql
-- Drop in reverse order
DROP POLICY IF EXISTS "Content creators can manage lesson assets" ON lesson_assets;
DROP POLICY IF EXISTS "Users can view lesson assets for published lessons" ON lesson_assets;
DROP FUNCTION IF EXISTS get_lesson_completion_status;
DROP FUNCTION IF EXISTS check_lesson_assets_completion;
DROP TABLE IF EXISTS lesson_assets;
```

**Option 2: Disable Feature**
- Comment out AssetSelector in LessonEditorPage.tsx
- Comment out LinkedAssetViewer in LessonPlayerPage.tsx
- Redeploy frontend

**Option 3: Make Table Optional**
- Update components to gracefully handle missing table
- Add try-catch around all lesson_assets queries
- Display fallback UI if table doesn't exist

## Success Criteria

### Technical
- ✅ Migration runs without errors
- ✅ All queries execute in < 100ms
- ✅ No TypeScript errors in production build
- ✅ RLS policies prevent unauthorized access
- ✅ Event logging works for all users

### Functional
- ✅ Content creators can link assets to lessons
- ✅ Students can view linked assets in lessons
- ✅ Tracking events are logged correctly
- ✅ "Mark as Understood" button works
- ✅ Completion status reflects asset viewing

### User Experience
- ✅ AssetSelector is intuitive and fast
- ✅ LinkedAssetViewer displays content clearly
- ✅ No performance degradation in Lesson Player
- ✅ Visual indicators (badges, checkmarks) work
- ✅ Search and filter work smoothly

## Timeline

### Day 1: Preparation
- Morning: Review all code and documentation
- Afternoon: Test in development environment
- Evening: Prepare rollback plan

### Day 2: Deployment
- Morning: Run database migration
- Midday: Deploy frontend code
- Afternoon: Run smoke tests
- Evening: Monitor for issues

### Day 3: Validation
- Morning: Check analytics and logs
- Midday: Gather initial user feedback
- Afternoon: Address any issues
- Evening: Document lessons learned

### Week 1: Content Migration
- Link assets to A0 Unit 1 (Days 4-5)
- Link assets to A0 Unit 2 (Days 6-7)
- Continue with remaining units

## Support Contacts

### Technical Issues
- Database: [DBA contact]
- Frontend: [Frontend lead]
- Backend: [Backend lead]

### User Support
- Content creators: [Training lead]
- Students: [Support team]
- Teachers: [Teacher success team]

## Documentation Links

- **Full Implementation**: `docs/ASSET_LINKING_IMPLEMENTATION.md`
- **Quick Start Guide**: `docs/ASSET_LINKING_QUICK_START.md`
- **Summary**: `docs/ASSET_LINKING_SUMMARY.md`
- **This Checklist**: `docs/ASSET_LINKING_DEPLOYMENT_CHECKLIST.md`

## Notes

### Known Limitations
- Supabase types need regeneration to include lesson_assets table
- Currently using `as any` type assertions (safe, but not ideal)
- Asset content fetching could be optimized with caching
- No pagination on asset lists (fine for current scale)

### Future Improvements
- Regenerate Supabase types after migration
- Add caching layer for frequently accessed assets
- Implement pagination for large asset lists
- Add bulk linking feature for multiple lessons
- Create asset usage analytics dashboard

## Sign-Off

- [ ] Database Admin reviewed and approved
- [ ] Frontend Lead reviewed and approved
- [ ] Backend Lead reviewed and approved
- [ ] Product Owner reviewed and approved
- [ ] QA tested and approved

**Deployment Date**: _________________

**Deployed By**: _________________

**Status**: _________________

**Notes**: _________________
