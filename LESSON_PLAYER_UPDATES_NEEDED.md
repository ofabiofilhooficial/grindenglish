## LessonPlayerPage Updates Needed

### Changes to Make in `src/pages/LessonPlayerPage.tsx`

#### 1. Add useStageCompletion Hook (after other hooks)
```typescript
const { completedStages, completeStage, isStageComplete, getCompletionCount } = useStageCompletion(lessonId);
```

#### 2. Add Stage Status Calculation Function (after state declarations)
```typescript
const getStageStatus = (index: number): 'locked' | 'current' | 'complete' => {
  if (!stages[index]) return 'locked';
  
  // Check if stage is complete
  if (isStageComplete(stages[index].id)) return 'complete';
  
  // First stage is always available
  if (index === 0) return 'current';
  
  // Other stages unlock when previous stage is complete
  if (index > 0 && isStageComplete(stages[index - 1].id)) {
    return 'current';
  }
  
  return 'locked';
};
```

#### 3. Add Stage Completion Handler
```typescript
const handleCompleteStage = async () => {
  if (!stages[currentStage]) return;
  
  const success = await completeStage(stages[currentStage].id);
  
  if (success) {
    // Move to next stage if available
    if (currentStage < stages.length - 1) {
      setCurrentStage(currentStage + 1);
    }
  }
};
```

#### 4. Update Sidebar Stage Rendering (in the sidebar map function)
Replace the existing status calculation with:
```typescript
const status = getStageStatus(index);
```

#### 5. Update Stage Navigation Button Click Handler
```typescript
onClick={() => {
  const status = getStageStatus(index);
  if (status !== 'locked') {
    setCurrentStage(index);
  }
}}
```

#### 6. Update StageContentViewer Call (in main content area)
```typescript
<StageContentViewer 
  stage={stages[currentStage]} 
  lessonId={lessonId}
  onStageComplete={handleCompleteStage}
/>
```

#### 7. Update Navigation Buttons (at bottom)
Replace the existing navigation section with:
```typescript
<div className="flex items-center justify-between pt-4 border-t border-border">
  <Button 
    variant="outline" 
    disabled={currentStage === 0}
    onClick={() => setCurrentStage(Math.max(0, currentStage - 1))}
  >
    <ArrowLeft className="mr-2 h-4 w-4" />
    Previous
  </Button>
  
  <div className="flex items-center gap-2">
    {/* Show complete button if stage not yet complete */}
    {!isStageComplete(stages[currentStage]?.id) && (
      <Button 
        onClick={handleCompleteStage}
        className="bg-gradient-primary hover:opacity-90"
      >
        <CheckCircle2 className="mr-2 h-4 w-4" />
        Complete Stage
      </Button>
    )}
    
    {/* Show next button if current stage is complete */}
    {isStageComplete(stages[currentStage]?.id) && currentStage < stages.length - 1 && (
      <Button 
        onClick={() => setCurrentStage(currentStage + 1)}
        className="bg-gradient-primary hover:opacity-90"
      >
        Next Stage
        <ArrowRight className="ml-2 h-4 w-4" />
      </Button>
    )}
    
    {/* Show finish button on last stage if complete */}
    {isStageComplete(stages[currentStage]?.id) && currentStage === stages.length - 1 && (
      <Button 
        onClick={() => {
          // Navigate back to unit or show completion message
          window.location.href = `/course/${level}/${unitId}`;
        }}
        className="bg-gradient-primary hover:opacity-90"
      >
        <CheckCircle2 className="mr-2 h-4 w-4" />
        Finish Lesson
      </Button>
    )}
  </div>
</div>
```

#### 8. Update Progress Calculation
```typescript
const completedCount = getCompletionCount();
const progress = stages.length > 0 ? Math.round((completedCount / stages.length) * 100) : 0;
```

#### 9. Add Lock Icon Import
Already added in previous update: `Lock` from 'lucide-react'

#### 10. Update Sidebar to Show Lock Icons
In the sidebar stage button, add lock icon for locked stages:
```typescript
{status === 'locked' && (
  <Lock className="h-4 w-4" />
)}
```

### Summary of Changes

These updates will:
- ✅ Track stage completion in database
- ✅ Unlock stages progressively (only after previous is complete)
- ✅ Show "Complete Stage" button
- ✅ Show lock icons for locked stages
- ✅ Prevent navigation to locked stages
- ✅ Show interactive vocabulary practice in Stage 0
- ✅ Integrate with SRS system for vocabulary tracking
- ✅ Update progress bar based on completed stages

### Testing Steps

1. Navigate to Lesson 1
2. Should see only Stage 0 available (others locked)
3. Complete vocabulary practice in Stage 0
4. Click "Complete Stage"
5. Stage 1 should unlock
6. Continue through all 6 stages
7. Each stage unlocks only after completing previous
8. Vocabulary from Stage 0 should appear in SRS reviews
