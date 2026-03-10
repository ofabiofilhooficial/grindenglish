# How to Apply Vocabulary Migrations

## Current Status
✅ All migration files created locally  
❌ Migrations NOT applied to database yet  
📊 Database currently has: **0 vocabulary entries**

## Why the Vocabulary Section Shows Incomplete Data

The vocabulary section is showing only word classifications because:
1. The initial seed migration added 1000 words with just basic info (headword, POS, CEFR level)
2. The enhancement migrations that add IPA, definitions, examples, etc. haven't been applied yet

## How to Apply Migrations

You have **8 migration files** that need to be applied in order:

### Step 1: Apply Initial Seed Migration
**File**: `supabase/migrations/20260310000001_seed_gsl_vocabulary.sql`
**What it does**: Inserts 1000 GSL words with basic information

1. Go to your Supabase Dashboard: https://supabase.com/dashboard
2. Select your project: `nyovkitllfvbjslunned`
3. Go to **SQL Editor** in the left sidebar
4. Click **New Query**
5. Copy the ENTIRE contents of `20260310000001_seed_gsl_vocabulary.sql`
6. Paste into the SQL Editor
7. Click **Run** (or press Ctrl+Enter)
8. Wait for success message

### Step 2: Apply Enhancement Batch 1 (A0 Pronouns & Basic Verbs)
**File**: `supabase/migrations/20260310000002_enhance_gsl_vocabulary_batch_1.sql`
**What it does**: Adds complete data for ~150 A0 words

Repeat the same process:
1. New Query in SQL Editor
2. Copy entire file contents
3. Paste and Run

### Step 3: Apply Enhancement Batch 2 (A0 Common Nouns & Adjectives)
**File**: `supabase/migrations/20260310000003_enhance_gsl_vocabulary_batch_2.sql`

### Step 4: Apply Enhancement Batch 3 (A0 Prepositions, Determiners, Conjunctions)
**File**: `supabase/migrations/20260310000004_enhance_gsl_vocabulary_batch_3.sql`

### Step 5: Apply Enhancement Batch 4 (A1 Work & Business)
**File**: `supabase/migrations/20260310000005_enhance_gsl_vocabulary_batch_4_a1_work.sql`

### Step 6: Apply Enhancement Batch 5 (A1 Communication & Technology)
**File**: `supabase/migrations/20260310000006_enhance_gsl_vocabulary_batch_5_a1_communication.sql`

### Step 7: Apply Enhancement Batch 6 (A1 Time & Quantity)
**File**: `supabase/migrations/20260310000007_enhance_gsl_vocabulary_batch_6_a1_time_quantity.sql`

### Step 8: Apply Enhancement Batch 7 (A1 Remaining High-Frequency Words)
**File**: `supabase/migrations/20260310000008_enhance_gsl_vocabulary_batch_7_a1_remaining.sql`

## Verification After Each Migration

After applying each migration, you can verify it worked by running:

```sql
-- Check total entries
SELECT COUNT(*) as total_entries FROM lexicon_entries;

-- Check entries with enhancements
SELECT COUNT(*) as enhanced_entries 
FROM lexicon_entries 
WHERE ipa IS NOT NULL 
  AND definition_simple IS NOT NULL;

-- View a sample enhanced entry
SELECT headword, ipa, definition_simple, 
       jsonb_array_length(examples) as example_count
FROM lexicon_entries 
WHERE ipa IS NOT NULL 
LIMIT 5;
```

## Alternative: Use Supabase CLI (If Installed)

If you want to install the Supabase CLI for easier migration management:

```bash
# Install Supabase CLI
npm install -g supabase

# Link to your project
supabase link --project-ref nyovkitllfvbjslunned

# Push all pending migrations
supabase db push
```

## After All Migrations Are Applied

Once all 8 migrations are applied, run the validation script to confirm:

```bash
npm run vocab:validate
```

Expected output:
- Total Entries: 1000
- Fully Complete: ~1000 (100%)
- All CEFR levels (A0, A1) should show high completion percentages

## What You'll See in the Vocabulary Section

After applying all migrations, vocabulary entries will show:
- ✅ IPA pronunciation (e.g., "aɪ" for "I")
- ✅ Simple definition (student-facing)
- ✅ Teacher notes
- ✅ Usage notes for professional contexts
- ✅ 2-4 example sentences
- ✅ Common collocations
- ✅ Grammar patterns
- ✅ Register (formal/neutral/informal)
- ✅ Variety (US/UK/international)

Instead of just:
- ❌ Word classification only (pron, verb, noun, etc.)

## Troubleshooting

### "Relation lexicon_entries does not exist"
The table hasn't been created yet. You need to apply the schema migration first:
- File: `supabase/migrations/20260217161704_db80f8c1-b8d5-480b-be77-985089236eba.sql`

### "Duplicate key value violates unique constraint"
The seed migration has already been applied. Skip to the enhancement batches.

### "Column does not exist"
The schema migration hasn't been applied. Apply it first before the vocabulary migrations.

## Summary

**Current State**: Migration files exist locally, but database is empty  
**Action Needed**: Apply 8 migration files through Supabase SQL Editor  
**Expected Result**: 1000 vocabulary entries with complete linguistic data  
**Time Required**: ~10-15 minutes to apply all migrations  

The vocabulary enhancement system is complete - it just needs to be deployed to your database!
