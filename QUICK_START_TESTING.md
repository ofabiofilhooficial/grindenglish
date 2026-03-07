# Quick Start - Test Lesson 1 Now! 🚀

## 1-Minute Setup

### Prerequisites Check
```bash
# Verify migration applied
# In Supabase SQL Editor, run:
SELECT COUNT(*) FROM user_stage_completions;
# Should return 0 (table exists but empty)
```

## 5-Minute Test Flow

### Step 1: Open Lesson 1 (30 seconds)
```
Navigate: Home → My Courses → A0 Foundations → Unit 1 → Lesson 1
```

**What to see**:
- ✅ 6 stages in left sidebar
- ✅ Only Stage 0 clickable (others have lock icons 🔒)
- ✅ Stage 0 content displayed

### Step 2: Complete Vocabulary Practice (2 minutes)
**Type these translations**:
1. Oi → `hi` (or `hello`)
2. Bom dia → `good morning`
3. Boa tarde → `good afternoon`

**What to see**:
- ✅ Green checkmarks ✓ for correct answers
- ✅ "Excellent work!" message
- ✅ "Complete Stage" button appears

### Step 3: Unlock Next Stage (30 seconds)
**Click**: "Complete Stage" button

**What to see**:
- ✅ Stage 1 unlocks 🔓
- ✅ Automatically navigates to Stage 1
- ✅ Progress bar updates to ~17%

### Step 4: Complete All Stages (2 minutes)
**For each stage (1-5)**:
1. Read content
2. Click "Complete Stage"
3. Next stage unlocks

**What to see**:
- ✅ Each stage unlocks sequentially
- ✅ Progress bar increases
- ✅ Checkmarks ✓ on completed stages

### Step 5: Finish Lesson (30 seconds)
**On Stage 5**: Click "Finish Lesson"

**What to see**:
- ✅ Returns to Unit 1 page
- ✅ Lesson 1 shows as complete

## Quick Verification

### Visual Checks
- [ ] Lock icons on locked stages
- [ ] Checkmarks on completed stages
- [ ] Progress bar updates
- [ ] "Complete Stage" button works

### Functional Checks
- [ ] Can't click locked stages
- [ ] Vocabulary practice accepts correct answers
- [ ] Stage completion persists (refresh page)
- [ ] Assets expand when clicked

### SRS Check
```
Navigate: Progress → Review Schedule
Should see: hi, good morning, good afternoon
```

## Troubleshooting

### Problem: No stages visible
**Fix**: Check migration applied, refresh page

### Problem: Can't type in vocabulary inputs
**Fix**: Click inside input field, ensure Stage 0 is active

### Problem: "Complete Stage" doesn't work
**Fix**: Check browser console for errors, verify all vocabulary correct

### Problem: Stages don't unlock
**Fix**: Verify previous stage completed, check completion tracking

## Expected Timeline

| Action | Time | Cumulative |
|--------|------|------------|
| Navigate to Lesson 1 | 30s | 30s |
| Complete vocabulary | 2m | 2m 30s |
| Complete Stage 1 | 30s | 3m |
| Complete Stage 2 | 30s | 3m 30s |
| Complete Stage 3 | 30s | 4m |
| Complete Stage 4 | 30s | 4m 30s |
| Complete Stage 5 | 30s | 5m |
| **Total** | **5m** | **5m** |

## Success Indicators

✅ All 6 stages completed
✅ Progress bar at 100%
✅ Vocabulary in SRS schedule
✅ No console errors
✅ Smooth user experience

## Next Steps After Testing

1. ✅ Verify SRS integration works
2. ✅ Test with different user accounts
3. ✅ Test on mobile devices
4. ✅ Apply pattern to other lessons
5. ✅ Collect user feedback

## Quick Commands

### Reset Progress (for re-testing)
```sql
-- In Supabase SQL Editor
DELETE FROM user_stage_completions 
WHERE user_id = auth.uid();
```

### Check Completion Status
```sql
-- See your completed stages
SELECT ls.title, usc.completed_at
FROM user_stage_completions usc
JOIN lesson_stages ls ON ls.id = usc.stage_id
WHERE usc.user_id = auth.uid()
ORDER BY usc.completed_at;
```

### Verify Vocabulary in SRS
```sql
-- Check SRS items
SELECT le.headword, si.next_review, si.interval_days
FROM srs_items si
JOIN lexicon_entries le ON le.id = si.item_id
WHERE si.user_id = auth.uid()
AND si.item_type = 'vocabulary';
```

## Documentation

- **Complete Guide**: `IMPLEMENTATION_COMPLETE.md`
- **Detailed Testing**: `TEST_LESSON_1_FLOW.md`
- **Fix Summary**: `LESSON_1_FIXES_SUMMARY.md`
- **Technical Details**: `PROGRESSIVE_STAGE_UNLOCKING_COMPLETE.md`

---

**Ready to test?** Just navigate to Lesson 1 and start! 🎉
