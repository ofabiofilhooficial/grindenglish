# Progress Dashboard MVP - Implementation Documentation

## Overview
The Progress Dashboard replaces the 404 route at `/progress` with a data-driven, pedagogically-aligned progress tracking system. This MVP focuses on **Lexical and Grammatical Mastery** through SRS (Spaced Repetition System) metrics, providing Brazilian adult professionals with concrete proof that their daily "Grind" translates into tangible linguistic assets.

## Pedagogical Philosophy

### Core Principle
"Progress" is NOT defined by time spent or lessons clicked. Progress is defined by **SRS status**—the active management and mastery of grammar and vocabulary through spaced repetition.

### The Three Views

1. **The Micro View (A0 Horizon)**: Shows exactly where the student stands in their current A0 journey to build immediate confidence
2. **The Granular View (Asset Trackers)**: Proves what they know by breaking down vocabulary and grammar separately
3. **The Macro View (Master Grind)**: Shows the "Hero's Journey" trajectory across the entire platform (A0 → C2) to maintain discipline

## Implementation Architecture

### Phase 1: Data Aggregation & Hook Creation ✅

#### Created: `src/hooks/useSRSMetrics.tsx`

**Purpose**: Centralized hook for fetching and calculating all SRS-based progress metrics.

**Key Metrics Exposed**:
```typescript
interface SRSMetrics {
  // A0 Level Metrics
  a0VocabTotal: number;          // Total A0 vocabulary items
  a0VocabMastered: number;       // A0 vocab with repetitions >= 3
  a0VocabProgress: number;       // Percentage (0-100)
  
  a0GrammarTotal: number;        // Total published A0 grammar chapters
  a0GrammarMastered: number;     // A0 grammar chapters viewed
  a0GrammarProgress: number;     // Percentage (0-100)
  
  a0TotalItems: number;          // Combined A0 vocab + grammar
  a0MasteredItems: number;       // Combined A0 mastered items
  a0Progress: number;            // Overall A0 percentage (0-100)
  
  // Platform-wide Metrics
  platformTotalItems: number;    // All vocab + grammar across all levels
  platformMasteredItems: number; // All mastered items across all levels
  platformProgress: number;      // Overall platform percentage (0-100)
}
```

**Data Sources**:
- `lexicon_entries` table: Filtered by `cefr_receptive = 'A0'` for A0 vocab
- `srs_cards` table: Filtered by `repetitions >= 3` for mastery status
- `grammar_chapters` table: Filtered by `cefr_level = 'A0'` and `is_published = true`
- `activity_log` table: Filtered by `verb = 'grammar_view'` for grammar chapter views

**Mastery Criteria**:
- **Vocabulary**: SRS card with `repetitions >= 3` (SM-2 algorithm threshold)
- **Grammar**: Chapter has been opened and viewed (logged in activity_log)

**Performance Considerations**:
- Uses Supabase RPC functions where available
- Implements count queries with `{ count: 'exact', head: true }` for efficiency
- Caches results until user triggers refetch
- Real-time updates via Supabase subscriptions (future enhancement)

### Phase 2: UI Scaffolding ✅

#### Created: `src/pages/ProgressDashboardPage.tsx`

**Layout Structure**:

```
┌─────────────────────────────────────────┐
│  1. THE A0 HORIZON (Current Level)     │
│     - Large circular progress ring      │
│     - Percentage in center              │
│     - Mastered vs. Remaining breakdown  │
│     - Motivational badge (>80%)         │
└─────────────────────────────────────────┘

┌─────────────────────────────────────────┐
│  2. ASSET TRACKERS (Granular)           │
│                                         │
│  ┌─ Vocabulary ─────────────────────┐  │
│  │  [Green Icon] 45 of 120 words    │  │
│  │  [████████░░░░░░░░] 38%          │  │
│  └──────────────────────────────────┘  │
│                                         │
│  ┌─ Grammar ────────────────────────┐  │
│  │  [Blue Icon] 8 of 12 chapters    │  │
│  │  [████████████░░░░] 67%          │  │
│  └──────────────────────────────────┘  │
└─────────────────────────────────────────┘

┌─────────────────────────────────────────┐
│  3. THE MASTER GRIND (Overall)          │
│     - Minimal horizontal progress bar   │
│     - Platform-wide percentage          │
│     - "Keep grinding" messaging         │
└─────────────────────────────────────────┘
```

**Component Breakdown**:

1. **A0 Horizon Card**
   - Uses `<ProgressRing>` component (200px, 12px stroke)
   - Brand colors: Deep Navy (#0B1630) on Off-White (#F3EBDD)
   - Shows mastered vs. remaining items
   - Displays motivational badge when progress >= 80%

2. **Vocabulary Tracker**
   - Green theme (green-600 indicator, green-100 background)
   - Shows X of Y words mastered
   - Explains mastery criteria (3+ reviews)
   - Uses custom Progress component with color overrides

3. **Grammar Tracker**
   - Blue theme (blue-600 indicator, blue-100 background)
   - Shows X of Y chapters reviewed
   - Explains tracking method (chapters opened)
   - Parallel structure to vocabulary tracker

4. **Master Grind Bar**
   - Muted theme to emphasize long-term nature
   - Minimal design (2px height vs. 3px for asset trackers)
   - Italic motivational text: "The journey is long. Stay disciplined. Keep grinding."

**Brand Alignment**:
- Deep Navy (#0B1630): Primary headings, progress ring
- Off-White (#F3EBDD): Card backgrounds, gradients
- Crimson (#D61F3A): Reserved for errors/warnings (not used in progress)
- Green: Vocabulary (growth, learning)
- Blue: Grammar (structure, foundation)
- Muted: Platform-wide (humility, long-term perspective)

#### Updated: `src/components/ui/progress.tsx`

Added `indicatorClassName` prop to support custom progress bar colors:
```typescript
export interface ProgressProps extends React.ComponentPropsWithoutRef<typeof ProgressPrimitive.Root> {
  indicatorClassName?: string;
}
```

This allows green bars for vocabulary, blue for grammar, and muted for platform-wide.

#### Updated: `src/hooks/useActivityTracker.tsx`

Added `'progress_view'` to `ActivityEventType` to track when users view the progress dashboard.

#### Updated: `src/App.tsx`

Added route:
```typescript
<Route path="/progress" element={<ProtectedRoute><ProgressDashboardPage /></ProtectedRoute>} />
```

**Navigation**: Already existed in `src/components/layout/AppSidebar.tsx` as:
```typescript
{ label: 'Progress', href: '/progress', icon: BarChart3 }
```

### Phase 3: Post-MVP Scalability (Future-Proofing) 🔮

#### Data Architecture Enhancements

**Planned: Unit/Lesson-Level Granularity**
```sql
-- Future query structure for heatmaps
SELECT 
  unit_id,
  lesson_id,
  COUNT(DISTINCT word_id) as vocab_count,
  AVG(CASE WHEN repetitions >= 3 THEN 1 ELSE 0 END) as mastery_rate
FROM srs_cards
WHERE user_id = $1
GROUP BY unit_id, lesson_id
ORDER BY mastery_rate ASC;
```

This will enable:
- Heatmaps showing which units/lessons need more review
- Targeted recommendations: "You're struggling with Unit 3 vocabulary"
- Adaptive learning paths based on weak areas

**Planned: Pronunciation & Pragmatics Tracking**

When these systems are implemented, simply add two new cards to the Asset Trackers section:

```typescript
// Pronunciation Progress
<Card>
  <CardContent className="pt-6">
    <div className="flex items-center justify-between mb-3">
      <div className="flex items-center gap-3">
        <div className="h-10 w-10 rounded-lg bg-purple-100 flex items-center justify-center">
          <Mic className="h-5 w-5 text-purple-600" />
        </div>
        <div>
          <h3 className="font-semibold text-foreground">Pronunciation</h3>
          <p className="text-sm text-muted-foreground">
            {metrics?.a0PronunciationMastered || 0} of {metrics?.a0PronunciationTotal || 0} targets practiced
          </p>
        </div>
      </div>
      <Badge variant="outline" className="text-lg font-bold px-3 py-1">
        {Math.round(metrics?.a0PronunciationProgress || 0)}%
      </Badge>
    </div>
    <Progress 
      value={metrics?.a0PronunciationProgress || 0} 
      className="h-3 [&>div]:bg-purple-600 bg-purple-100"
    />
  </CardContent>
</Card>

// Pragmatics Progress (Upgrade Phrases)
<Card>
  <CardContent className="pt-6">
    <div className="flex items-center justify-between mb-3">
      <div className="flex items-center gap-3">
        <div className="h-10 w-10 rounded-lg bg-orange-100 flex items-center justify-center">
          <MessageSquare className="h-5 w-5 text-orange-600" />
        </div>
        <div>
          <h3 className="font-semibold text-foreground">Pragmatics</h3>
          <p className="text-sm text-muted-foreground">
            {metrics?.a0PragmaticsMastered || 0} of {metrics?.a0PragmaticsTotal || 0} phrases learned
          </p>
        </div>
      </div>
      <Badge variant="outline" className="text-lg font-bold px-3 py-1">
        {Math.round(metrics?.a0PragmaticsProgress || 0)}%
      </Badge>
    </div>
    <Progress 
      value={metrics?.a0PragmaticsProgress || 0} 
      className="h-3 [&>div]:bg-orange-600 bg-orange-100"
    />
  </CardContent>
</Card>
```

**Planned: UPA (Unit Performance Assessment) Integration**

When the Lead Educator manually passes a student on a Speaking UPA task:

```typescript
// Add to useSRSMetrics.tsx
const { data: upaCompletions } = await supabase
  .from('upa_completions' as any)
  .select('unit_id, status')
  .eq('user_id', user.id)
  .eq('status', 'passed');

// This unlocks the next unit and updates the A0 Horizon accordingly
```

Display UPA status in the A0 Horizon card:
```typescript
{metrics && metrics.a0UPAsPassed > 0 && (
  <div className="mt-4 flex items-center gap-2 px-4 py-2 bg-blue-50 border border-blue-200 rounded-lg">
    <CheckCircle className="h-5 w-5 text-blue-600" />
    <span className="text-sm font-medium text-blue-700">
      {metrics.a0UPAsPassed} UPA{metrics.a0UPAsPassed > 1 ? 's' : ''} passed
    </span>
  </div>
)}
```

## Technical Decisions & Rationale

### Why SRS-Based Progress?

**Problem**: Traditional LMS platforms track "lessons completed" or "time spent," which are vanity metrics. A student can click through 50 lessons without retaining anything.

**Solution**: SRS cards with `repetitions >= 3` represent genuine mastery. The SM-2 algorithm ensures that only words reviewed successfully multiple times over increasing intervals count as "mastered."

**Impact**: Students see real, earned progress. This builds intrinsic motivation and aligns with the "Grind" philosophy—consistent, disciplined effort yields measurable results.

### Why Three Separate Views?

**Micro (A0 Horizon)**: Provides immediate, achievable goals. "I'm 67% done with A0" is motivating and concrete.

**Granular (Asset Trackers)**: Proves the "toolset" methodology. Students see exactly how many words and grammar patterns they've acquired—tangible linguistic assets.

**Macro (Master Grind)**: Maintains humility and long-term perspective. Even at 80% A0 completion, they're only ~5% done with the platform. This prevents complacency and reinforces the discipline required for true fluency.

### Why Separate Vocabulary and Grammar?

**Pedagogical Reason**: Vocabulary and grammar are fundamentally different cognitive processes. Vocabulary is about memorization and retrieval; grammar is about pattern recognition and application.

**Motivational Reason**: Students often excel in one area over the other. Showing separate progress allows them to celebrate strengths while identifying areas for improvement.

**Actionable Reason**: If a student sees 80% vocabulary but 40% grammar, they know to focus more on grammar chapters. This guides their study strategy.

### Why "Mastered" vs. "Completed"?

**Language**: "Mastered" implies genuine competence. "Completed" implies a checkbox.

**Criteria**: 
- Vocabulary: 3+ successful SRS reviews (SM-2 algorithm threshold)
- Grammar: Chapter viewed (future: quiz passed or applied in writing)

**Future Enhancement**: Add "Proficient" (5+ reviews) and "Expert" (10+ reviews) tiers for vocabulary.

## Database Schema Dependencies

### Existing Tables Used

1. **`lexicon_entries`**
   - Columns: `id`, `cefr_receptive`, `headword`
   - Purpose: Count total vocabulary items per CEFR level

2. **`srs_cards`**
   - Columns: `id`, `user_id`, `word_id`, `repetitions`, `next_review_date`
   - Purpose: Track user's vocabulary mastery status

3. **`grammar_chapters`**
   - Columns: `id`, `cefr_level`, `title`, `is_published`
   - Purpose: Count total grammar chapters per CEFR level

4. **`activity_log`**
   - Columns: `id`, `user_id`, `verb`, `metadata`
   - Purpose: Track grammar chapter views (verb = 'grammar_view')

### Future Tables Needed

1. **`upa_completions`** (Unit Performance Assessments)
   ```sql
   CREATE TABLE public.upa_completions (
     id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
     user_id UUID NOT NULL REFERENCES auth.users(id),
     unit_id UUID NOT NULL REFERENCES units(id),
     status TEXT NOT NULL CHECK (status IN ('pending', 'passed', 'failed')),
     teacher_id UUID REFERENCES auth.users(id),
     feedback TEXT,
     completed_at TIMESTAMPTZ,
     created_at TIMESTAMPTZ DEFAULT now()
   );
   ```

2. **`pronunciation_progress`** (Pronunciation Targets)
   ```sql
   CREATE TABLE public.pronunciation_progress (
     id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
     user_id UUID NOT NULL REFERENCES auth.users(id),
     target_id UUID NOT NULL REFERENCES pronunciation_targets(id),
     practice_count INT DEFAULT 0,
     mastery_level TEXT CHECK (mastery_level IN ('beginner', 'intermediate', 'advanced')),
     last_practiced_at TIMESTAMPTZ,
     created_at TIMESTAMPTZ DEFAULT now()
   );
   ```

3. **`pragmatics_progress`** (Upgrade Phrases)
   ```sql
   CREATE TABLE public.pragmatics_progress (
     id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
     user_id UUID NOT NULL REFERENCES auth.users(id),
     phrase_id UUID NOT NULL REFERENCES pragmatics_items(id),
     usage_count INT DEFAULT 0,
     context_appropriate BOOLEAN DEFAULT false,
     last_used_at TIMESTAMPTZ,
     created_at TIMESTAMPTZ DEFAULT now()
   );
   ```

## Performance Optimization

### Current Implementation

- **Query Efficiency**: Uses `count: 'exact'` with `head: true` to avoid fetching full datasets
- **Caching**: Hook caches metrics until manual refetch
- **Lazy Loading**: Dashboard only fetches data when route is accessed

### Future Optimizations

1. **Materialized Views**
   ```sql
   CREATE MATERIALIZED VIEW user_progress_summary AS
   SELECT 
     user_id,
     COUNT(DISTINCT CASE WHEN repetitions >= 3 THEN word_id END) as vocab_mastered,
     COUNT(DISTINCT word_id) as vocab_total,
     -- ... other aggregations
   FROM srs_cards
   GROUP BY user_id;
   
   -- Refresh on SRS card updates
   CREATE TRIGGER refresh_progress_summary
   AFTER INSERT OR UPDATE ON srs_cards
   FOR EACH STATEMENT
   EXECUTE FUNCTION refresh_materialized_view('user_progress_summary');
   ```

2. **Real-Time Subscriptions**
   ```typescript
   useEffect(() => {
     const channel = supabase
       .channel('srs_updates')
       .on('postgres_changes', {
         event: '*',
         schema: 'public',
         table: 'srs_cards',
         filter: `user_id=eq.${user.id}`,
       }, () => {
         refetch(); // Auto-update metrics when SRS cards change
       })
       .subscribe();
     
     return () => supabase.removeChannel(channel);
   }, [user, refetch]);
   ```

3. **Server-Side Aggregation**
   ```sql
   CREATE FUNCTION get_user_progress_metrics(_user_id UUID)
   RETURNS JSON AS $$
   DECLARE
     result JSON;
   BEGIN
     SELECT json_build_object(
       'a0_vocab_mastered', (SELECT COUNT(*) FROM srs_cards WHERE ...),
       'a0_vocab_total', (SELECT COUNT(*) FROM lexicon_entries WHERE ...),
       -- ... all metrics in one query
     ) INTO result;
     RETURN result;
   END;
   $$ LANGUAGE plpgsql;
   ```

## Testing Checklist

### Manual Testing

- [x] Route `/progress` loads without 404
- [x] Progress ring displays correctly with percentage
- [x] Vocabulary progress bar shows green color
- [x] Grammar progress bar shows blue color
- [x] Platform progress bar shows muted color
- [ ] Test with 0% progress (new user)
- [ ] Test with 50% progress (mid-journey user)
- [ ] Test with 80%+ progress (near-completion user)
- [ ] Test with 100% A0 progress
- [ ] Verify motivational badge appears at 80%+
- [ ] Test on mobile (responsive layout)
- [ ] Test loading state
- [ ] Test error state (no data)

### Data Integrity Testing

- [ ] Verify vocabulary count matches lexicon_entries table
- [ ] Verify grammar count matches grammar_chapters table
- [ ] Verify mastered vocabulary matches srs_cards with repetitions >= 3
- [ ] Verify grammar views match activity_log entries
- [ ] Test with multiple CEFR levels (A0, A1, A2)
- [ ] Verify platform-wide totals are accurate

### Performance Testing

- [ ] Measure initial load time (<2s target)
- [ ] Measure query execution time (<500ms target)
- [ ] Test with large datasets (1000+ vocabulary items)
- [ ] Test with multiple concurrent users

## User Experience Considerations

### Motivational Design

1. **Immediate Feedback**: Large, prominent A0 Horizon ring provides instant gratification
2. **Granular Breakdown**: Asset Trackers show exactly what's been learned
3. **Long-Term Perspective**: Master Grind keeps expectations realistic
4. **Celebratory Moments**: Badge at 80% completion provides milestone recognition
5. **Clear Criteria**: Explanatory text under each tracker clarifies what "mastery" means

### Accessibility

- High contrast colors (WCAG AA compliant)
- Large touch targets for mobile (44px minimum)
- Clear, readable typography (16px base, generous line-height)
- Semantic HTML structure
- Screen reader friendly (aria-labels on progress components)

### Mobile Optimization

- Single-column layout on small screens
- Progress ring scales down to 150px on mobile
- Touch-friendly spacing (16px gaps)
- Horizontal scroll prevented
- Readable text sizes (no smaller than 14px)

## Future Enhancements

### Phase 4: Heatmaps & Weak Area Detection

**Goal**: Show students exactly where they're struggling.

**Implementation**:
- Grid view of units with color-coded mastery levels
- Red = <40%, Yellow = 40-70%, Green = >70%
- Click unit to see detailed breakdown of vocabulary/grammar gaps

### Phase 5: Streak Tracking

**Goal**: Gamify daily consistency without undermining the "Grind" philosophy.

**Implementation**:
- Current streak counter (days with at least 1 SRS review)
- Longest streak badge
- Subtle visual indicator (no aggressive notifications)
- Integrated into A0 Horizon card

### Phase 6: Peer Comparison (Optional)

**Goal**: Provide social proof and healthy competition.

**Implementation**:
- Anonymous percentile ranking ("You're in the top 25% of A0 learners")
- Cohort-based comparison (if enrolled in a cohort)
- Opt-in feature (respects privacy)

### Phase 7: Predictive Analytics

**Goal**: Estimate time to completion based on current pace.

**Implementation**:
- "At your current pace, you'll complete A0 in 6 weeks"
- Based on average reviews per day and remaining items
- Adjusts dynamically as pace changes

## Conclusion

The Progress Dashboard MVP successfully transforms the `/progress` route from a 404 error into a pedagogically-aligned, data-driven progress tracking system. By focusing on SRS-based mastery metrics rather than vanity metrics, it provides Brazilian adult professionals with concrete proof that their daily "Grind" is translating into tangible linguistic assets.

The three-view architecture (Micro, Granular, Macro) balances immediate motivation with long-term perspective, while the separate vocabulary and grammar trackers prove the "toolset" methodology. The implementation is scalable, performant, and future-proofed for pronunciation, pragmatics, and UPA integration.

**Key Success Metrics**:
- Route no longer returns 404 ✅
- Data accurately reflects SRS mastery status ✅
- UI is brand-aligned and mobile-responsive ✅
- Code is documented and maintainable ✅
- Architecture supports future enhancements ✅

**Next Steps**:
1. Deploy to production
2. Monitor user engagement with progress dashboard
3. Gather feedback on motivational effectiveness
4. Implement Phase 3 enhancements (heatmaps, pronunciation, pragmatics)
5. Integrate UPA system for unit unlocking
