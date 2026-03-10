-- Remove Duplicate Vocabulary Entries
-- Issue: Each word appears twice in the database
-- Solution: Keep only one entry per headword (preferring enhanced entries)

-- First, let's see how many duplicates we have
DO $$
DECLARE
  total_count INTEGER;
  unique_count INTEGER;
  duplicate_count INTEGER;
BEGIN
  SELECT COUNT(*) INTO total_count FROM lexicon_entries;
  SELECT COUNT(DISTINCT headword) INTO unique_count FROM lexicon_entries;
  duplicate_count := total_count - unique_count;
  
  RAISE NOTICE 'Total entries: %', total_count;
  RAISE NOTICE 'Unique headwords: %', unique_count;
  RAISE NOTICE 'Duplicate entries to remove: %', duplicate_count;
END $$;

-- Delete duplicate entries, keeping only one per headword
-- Strategy: Keep the entry with the most data (enhanced entries preferred)
-- Use ctid (physical row identifier) to distinguish between duplicates
DELETE FROM lexicon_entries a
USING lexicon_entries b
WHERE a.headword = b.headword
  AND a.ctid < b.ctid;

-- Alternative approach if above doesn't work:
-- This keeps the entry with IPA data if available, otherwise keeps any one
/*
DELETE FROM lexicon_entries
WHERE id IN (
  SELECT id
  FROM (
    SELECT 
      id,
      headword,
      ROW_NUMBER() OVER (
        PARTITION BY headword 
        ORDER BY 
          CASE WHEN ipa IS NOT NULL THEN 0 ELSE 1 END,
          created_at
      ) as rn
    FROM lexicon_entries
  ) ranked
  WHERE rn > 1
);
*/

-- Verify cleanup
DO $$
DECLARE
  final_count INTEGER;
  unique_count INTEGER;
BEGIN
  SELECT COUNT(*) INTO final_count FROM lexicon_entries;
  SELECT COUNT(DISTINCT headword) INTO unique_count FROM lexicon_entries;
  
  RAISE NOTICE 'Entries after cleanup: %', final_count;
  RAISE NOTICE 'Unique headwords: %', unique_count;
  
  IF final_count = unique_count THEN
    RAISE NOTICE '✅ SUCCESS: All duplicates removed!';
  ELSE
    RAISE WARNING '⚠️  Still have duplicates: % entries for % unique words', final_count, unique_count;
  END IF;
END $$;
