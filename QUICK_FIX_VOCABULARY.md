# Quick Fix: Apply Vocabulary Migrations

## Current Problem
✅ Database is connected  
❌ Database has 0 vocabulary entries  
❌ Migrations haven't been applied yet  

## Solution: Apply Migrations via Supabase Dashboard

Since the Supabase CLI can't be installed on Windows via npm, you need to apply the migrations manually through the Supabase Dashboard.

---

## Step-by-Step Instructions

### Step 1: Open Supabase Dashboard

1. Go to: https://supabase.com/dashboard/project/nyovkitllfvbjslunned
2. Log in if needed
3. Click on **SQL Editor** in the left sidebar (icon looks like `</>`)

### Step 2: Apply Migration 1 - Seed GSL Vocabulary

1. In SQL Editor, click **New Query** button (top right)
2. Open this file in VS Code: `supabase/migrations/20260310000001_seed_gsl_vocabulary.sql`
3. Select ALL content (Ctrl+A)
4. Copy (Ctrl+C)
5. Paste into Supabase SQL Editor (Ctrl+V)
6. Click **Run** button (or press Ctrl+Enter)
7. Wait for success message (should say "Success. No rows returned")

**What this does**: Inserts 1000 GSL words with basic information (headword, POS, CEFR level)

### Step 3: Apply Migration 2 - Enhancement Batch 1

1. Click **New Query** again
2. Open: `supabase/migrations/20260310000002_enhance_gsl_vocabulary_batch_1.sql`
3. Copy all content
4. Paste and Run

**What this does**: Adds IPA, definitions, examples, etc. for ~150 A0 words (pronouns, basic verbs)

### Step 4: Apply Migration 3 - Enhancement Batch 2

1. New Query
2. Open: `supabase/migrations/20260310000003_enhance_gsl_vocabulary_batch_2.sql`
3. Copy all, paste, run

**What this does**: Enhances ~150 A0 words (common nouns, adjectives)

### Step 5: Apply Migration 4 - Enhancement Batch 3

1. New Query
2. Open: `supabase/migrations/20260310000004_enhance_gsl_vocabulary_batch_3.sql`
3. Copy all, paste, run

**What this does**: Enhances ~100 A0 words (prepositions, determiners, conjunctions)

### Step 6: Apply Migration 5 - Enhancement Batch 4

1. New Query
2. Open: `supabase/migrations/20260310000005_enhance_gsl_vocabulary_batch_4_a1_work.sql`
3. Copy all, paste, run

**What this does**: Enhances ~150 A1 words (work and business vocabulary)

### Step 7: Apply Migration 6 - Enhancement Batch 5

1. New Query
2. Open: `supabase/migrations/20260310000006_enhance_gsl_vocabulary_batch_5_a1_communication.sql`
3. Copy all, paste, run

**What this does**: Enhances ~150 A1 words (communication and technology)

### Step 8: Apply Migration 7 - Enhancement Batch 6

1. New Query
2. Open: `supabase/migrations/20260310000007_enhance_gsl_vocabulary_batch_6_a1_time_quantity.sql`
3. Copy all, paste, run

**What this does**: Enhances ~150 A1 words (time and quantity)

### Step 9: Apply Migration 8 - Enhancement Batch 7

1. New Query
2. Open: `supabase/migrations/20260310000008_enhance_gsl_vocabulary_batch_7_a1_remaining.sql`
3. Copy all, paste, run

**What this does**: Enhances ~150 A1 words (remaining high-frequency words)

---

## Verification

After applying all 8 migrations, verify in Supabase SQL Editor:

```sql
-- Check total entries
SELECT COUNT(*) as total_entries FROM lexicon_entries;
-- Expected: 1000

-- Check enhanced entries
SELECT COUNT(*) as enhanced_entries 
FROM lexicon_entries 
WHERE ipa IS NOT NULL 
  AND definition_simple IS NOT NULL;
-- Expected: ~1000

-- View sample enhanced entry
SELECT 
  headword, 
  ipa, 
  definition_simple,
  jsonb_array_length(examples) as example_count
FROM lexicon_entries 
WHERE ipa IS NOT NULL 
LIMIT 5;
-- Should show words with IPA, definitions, and examples
```

Or run from your terminal:

```bash
npm run vocab:validate
```

Expected output:
```
Total Entries: 1000
Fully Complete: ~1000 (100%)
Completion by CEFR Level:
  A0: 100% complete (400 entries)
  A1: 100% complete (600 entries)
```

---

## Alternative: Use Supabase CLI (Proper Installation)

If you want to install Supabase CLI properly for future use:

### Windows Installation Options:

**Option 1: Scoop (Recommended for Windows)**
```powershell
# Install Scoop if you don't have it
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
irm get.scoop.sh | iex

# Install Supabase CLI
scoop bucket add supabase https://github.com/supabase/scoop-bucket.git
scoop install supabase
```

**Option 2: Direct Download**
1. Go to: https://github.com/supabase/cli/releases
2. Download the Windows executable
3. Add to your PATH

**Option 3: Use npx (No installation needed)**
```bash
npx supabase db push
```

After installing, you can use:
```bash
supabase link --project-ref nyovkitllfvbjslunned
supabase db push
```

---

## What You'll See After Migrations

### Before (Current State):
- Vocabulary entries show only: "pron", "verb", "noun", etc.
- No definitions, examples, or pronunciation

### After (With Migrations):
- **IPA Pronunciation**: aɪ, juː, hiː, etc.
- **Simple Definition**: "used by a speaker to refer to themselves"
- **Teacher Notes**: "First person singular subject pronoun..."
- **Usage Notes**: "Essential for professional introductions..."
- **Examples**: 
  - "I am a software engineer."
  - "I work in sales."
  - "I have a meeting at 3 PM."
- **Collocations**: "I am", "I have", "I work"
- **Register**: neutral, formal, informal
- **Variety**: US, UK, international

---

## Troubleshooting

### "Relation lexicon_entries does not exist"
The table hasn't been created. Apply the schema migration first:
- File: `supabase/migrations/20260217161704_db80f8c1-b8d5-480b-be77-985089236eba.sql`

### "Duplicate key value violates unique constraint"
Migration 1 has already been applied. Skip to Migration 2.

### Still showing 0 entries after Migration 1
Check the SQL Editor for error messages. Common issues:
- Missing columns in table (apply schema migration first)
- RLS policies blocking inserts (check policies)

### Migrations take a long time
This is normal. Each migration updates 100-200 entries with complete data.
- Migration 1: ~30 seconds (1000 inserts)
- Migrations 2-8: ~10-20 seconds each (100-200 updates)

---

## Summary

**Time Required**: 10-15 minutes  
**Steps**: Apply 8 migration files through Supabase Dashboard  
**Result**: 1000 vocabulary entries with complete linguistic data  

After completing these steps, your vocabulary section will display complete information instead of just word classifications!
