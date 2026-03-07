# 🚀 START HERE - Quick Implementation Guide

## You're Right - We Improved the Architecture!

Instead of just adding features, we've restructured how content is organized:

**Unit Level** → Students pre-study grammar/vocabulary  
**Lesson Level** → General resources  
**Stage Level** → Contextual resources  

## 3 Steps to Get Started (15 minutes)

### Step 1: Run 3 Migrations (5 min)

Go to **Supabase Dashboard → SQL Editor → New Query**

Copy and paste each migration file content, then click "Run":

1. **First**: `supabase/migrations/20260306000002_add_stage_id_to_lesson_assets.sql`
   - Adds stage linking capability

2. **Second**: `supabase/migrations/20260306000003_create_unit_assets.sql`
   - Creates unit-level assets table

3. **Third**: `supabase/migrations/20260306000004_seed_lesson_1_professional_greetings.sql`
   - Seeds grammar and vocabulary for Lesson 1

### Step 2: Set Up Unit 1 Targets (5 min)

1. Open your app
2. Go to **Course Builder → A0 Level → Unit 1**
3. Click the **"Targets"** tab
4. You'll see the AssetSelector
5. Link these items:
   - Grammar: **A0.G.01** (Verb To Be)
   - Grammar: **A0.G.02** (Possessive My)
   - Vocabulary: **hello, hi, good morning, good afternoon**
   - Vocabulary: **name, first name, last name, nice to meet you**
6. Click **"Save"**

**Result**: Students can now study these resources at the unit level before starting lessons!

### Step 3: Create Lesson 1 (5 min quick version)

1. In Unit 1, go to **"Lessons"** tab
2. Create new lesson:
   - Title: **"Professional Greetings & Names"**
   - Type: **vocabulary**
3. Click **"Add"**
4. Click on the lesson to open editor
5. Add the goal and success criteria (see below)
6. Add stages (see quick version below)
7. **Save and Publish**

#### Quick Goal & Success Criteria

**Goal**:
```
By the end of this lesson, you can confidently greet a colleague 
and introduce your first and last name using "I'm [name]".
```

**Success Criteria**:
```
You can use appropriate greetings for different times of day, 
introduce yourself professionally, and pronounce greetings correctly.
```

#### Quick Stages (Minimal Version)

**Stage 1: Warm-up** (5 min)
- Instructions: "Think about greetings in Portuguese. Do you know the English equivalents?"
- Resources: None

**Stage 2: Input** (10 min)
- Instructions: "Learn how to introduce yourself professionally. Use 'I'm [name]' not 'My name is...'. Study the resources below."
- Link: Grammar A0.G.01, Grammar A0.G.02, Vocab: hello, good morning, nice to meet you

**Stage 3: Practice** (10 min)
- Instructions: "Practice introducing yourself at different times of day. Say it out loud!"
- Link: Vocab: good morning, good afternoon, first name, last name

**Stage 4: Communicative Task** (15 min)
- Instructions: "Imagine you're in a Zoom meeting. Introduce yourself to 3 different people (a peer, your boss, a client)."
- Link: Vocab: hello, nice to meet you

**Stage 5: Reflection** (5 min)
- Instructions: "What did you do well? What needs improvement? Write down one thing to practice."
- Link: Grammar A0.G.01

## What You'll See

### In the Course Builder

**Unit 1 → Targets Tab**:
```
┌─────────────────────────────────────┐
│ 📚 Unit Learning Targets            │
│                                     │
│ Currently Linked:                   │
│ • Grammar: Verb To Be           [X] │
│ • Grammar: Possessive My        [X] │
│ • Vocabulary: hello             [X] │
│ • Vocabulary: good morning      [X] │
│ • ... (8 total)                     │
│                                     │
│ [Search box]                        │
│ [Grammar] [Vocabulary]              │
└─────────────────────────────────────┘
```

**Lesson 1 → Stage 2**:
```
┌─────────────────────────────────────┐
│ ≡ [Input] [The Solution] [10] min  │
│                                     │
│ Instructions:                       │
│ Learn how to introduce yourself...  │
│                                     │
│ ─────────────────────────────────── │
│ 📖 Stage Resources                  │
│ Currently Linked:                   │
│ • Grammar: Verb To Be           [X] │
│ • Grammar: Possessive My        [X] │
│ • Vocabulary: hello             [X] │
│ • Vocabulary: good morning      [X] │
│ • Vocabulary: nice to meet you  [X] │
└─────────────────────────────────────┘
```

### What Students See

**At Unit Level**:
- Unit 1 → Targets → All grammar and vocabulary to pre-study

**In Lesson**:
- Stage 1 → Instructions only (diagnostic)
- Stage 2 → Instructions + 5 resources (input)
- Stage 3 → Instructions + 4 resources (practice)
- Stage 4 → Instructions + 2 resources (task)
- Stage 5 → Instructions + 1 resource (reflection)

## Detailed Setup (30-45 min)

For the complete, detailed setup with all instructions and content, see:
**`LESSON_1_SETUP_GUIDE.md`**

## Architecture Overview

See the full explanation in:
**`IMPROVED_ARCHITECTURE_COMPLETE.md`**

## Troubleshooting

**"Error: could not find 'stage_id' column"**
→ Run migration #1

**"Can't link assets to unit"**
→ Run migration #2

**"Grammar/vocabulary not found"**
→ Run migration #3

**"Assets not showing"**
→ Make sure you clicked "Save"
→ Refresh the page
→ Check that content is published

## What's Next?

After Lesson 1 is working:

1. **Create more vocabulary** in Lexicon Manager
2. **Create more grammar chapters** in Grammar Manager
3. **Build Lesson 2** following the same pattern
4. **Add pronunciation and pragmatics** content

## Key Files

- `START_HERE.md` ← You are here
- `LESSON_1_SETUP_GUIDE.md` ← Detailed step-by-step
- `IMPROVED_ARCHITECTURE_COMPLETE.md` ← Full explanation
- `RUN_MIGRATION_NOW.md` ← Migration instructions

---

**Ready?** Run the migrations and start building! 🚀
