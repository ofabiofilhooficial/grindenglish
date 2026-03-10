-- Rollback Script: Vocabulary Enhancements
-- Description: Scripts to rollback individual batches or all vocabulary enhancements
-- Usage: Execute the appropriate section based on what needs to be rolled back

-- ============================================================================
-- INDIVIDUAL BATCH ROLLBACKS
-- ============================================================================

-- Rollback Batch 1: A0 Pronouns and Basic Verbs (~150 words)
-- Uncomment and execute to rollback batch 1
/*
UPDATE lexicon_entries
SET
  ipa = NULL,
  definition_simple = NULL,
  definition_teacher = NULL,
  usage_notes = NULL,
  register = NULL,
  variety = NULL,
  examples = '[]'::jsonb,
  collocations = '[]'::jsonb,
  patterns = '[]'::jsonb,
  updated_at = now()
WHERE headword IN (
  'I', 'you', 'he', 'she', 'it', 'we', 'they', 'me', 'him', 'her', 'us', 'them',
  'my', 'your', 'his', 'her', 'its', 'our', 'their',
  'be', 'am', 'is', 'are', 'was', 'were', 'been', 'being',
  'have', 'has', 'had', 'having',
  'do', 'does', 'did', 'done', 'doing',
  'go', 'goes', 'went', 'gone', 'going',
  'come', 'comes', 'came', 'coming',
  'get', 'gets', 'got', 'gotten', 'getting',
  'make', 'makes', 'made', 'making',
  'take', 'takes', 'took', 'taken', 'taking',
  'see', 'sees', 'saw', 'seen', 'seeing',
  'know', 'knows', 'knew', 'known', 'knowing',
  'think', 'thinks', 'thought', 'thinking',
  'want', 'wants', 'wanted', 'wanting',
  'give', 'gives', 'gave', 'given', 'giving',
  'use', 'uses', 'used', 'using',
  'find', 'finds', 'found', 'finding',
  'tell', 'tells', 'told', 'telling',
  'ask', 'asks', 'asked', 'asking',
  'work', 'works', 'worked', 'working',
  'seem', 'seems', 'seemed', 'seeming',
  'feel', 'feels', 'felt', 'feeling',
  'try', 'tries', 'tried', 'trying',
  'leave', 'leaves', 'left', 'leaving',
  'call', 'calls', 'called', 'calling'
);
*/

-- Rollback Batch 2: A0 Common Nouns and Adjectives (~150 words)
-- Uncomment and execute to rollback batch 2
/*
UPDATE lexicon_entries
SET
  ipa = NULL,
  definition_simple = NULL,
  definition_teacher = NULL,
  usage_notes = NULL,
  register = NULL,
  variety = NULL,
  examples = '[]'::jsonb,
  collocations = '[]'::jsonb,
  patterns = '[]'::jsonb,
  updated_at = now()
WHERE headword IN (
  'time', 'person', 'year', 'way', 'day', 'thing', 'man', 'world', 'life', 'hand',
  'part', 'child', 'eye', 'woman', 'place', 'work', 'week', 'case', 'point', 'government',
  'company', 'number', 'group', 'problem', 'fact', 'people', 'water', 'room', 'money', 'story',
  'family', 'friend', 'house', 'book', 'word', 'business', 'job', 'question', 'name', 'area',
  'good', 'new', 'first', 'last', 'long', 'great', 'little', 'own', 'other', 'old',
  'right', 'big', 'high', 'different', 'small', 'large', 'next', 'early', 'young', 'important',
  'few', 'public', 'bad', 'same', 'able', 'full', 'sure', 'low', 'certain', 'free'
);
*/

-- Rollback Batch 3: A0 Prepositions, Determiners, Conjunctions (~100 words)
-- Uncomment and execute to rollback batch 3
/*
UPDATE lexicon_entries
SET
  ipa = NULL,
  definition_simple = NULL,
  definition_teacher = NULL,
  usage_notes = NULL,
  register = NULL,
  variety = NULL,
  examples = '[]'::jsonb,
  collocations = '[]'::jsonb,
  patterns = '[]'::jsonb,
  updated_at = now()
WHERE headword IN (
  'in', 'on', 'at', 'to', 'from', 'with', 'for', 'about', 'by', 'up',
  'out', 'over', 'down', 'off', 'through', 'into', 'under', 'after', 'before', 'between',
  'the', 'a', 'an', 'this', 'that', 'these', 'those', 'some', 'any', 'all',
  'each', 'every', 'many', 'much', 'more', 'most', 'other', 'another', 'such', 'no',
  'and', 'but', 'or', 'if', 'because', 'when', 'while', 'where', 'who', 'which',
  'what', 'how', 'why', 'so', 'than', 'as', 'like', 'not', 'only', 'also'
);
*/

-- Rollback Batch 4: A1 Work and Business Vocabulary (~150 words)
-- Uncomment and execute to rollback batch 4
/*
UPDATE lexicon_entries
SET
  ipa = NULL,
  definition_simple = NULL,
  definition_teacher = NULL,
  usage_notes = NULL,
  register = NULL,
  variety = NULL,
  examples = '[]'::jsonb,
  collocations = '[]'::jsonb,
  patterns = '[]'::jsonb,
  updated_at = now()
WHERE headword IN (
  'business', 'company', 'office', 'meeting', 'project', 'plan', 'report', 'team',
  'manager', 'employee', 'client', 'customer', 'service', 'product', 'market', 'price',
  'account', 'address', 'advantage', 'amount', 'base', 'board', 'branch', 'budget',
  'manage', 'organize', 'plan', 'present', 'discuss', 'develop', 'improve', 'increase',
  'professional', 'responsible', 'available', 'necessary', 'possible', 'successful', 'effective', 'efficient'
);
*/

-- Rollback Batch 5: A1 Communication and Technology (~150 words)
-- Uncomment and execute to rollback batch 5
/*
UPDATE lexicon_entries
SET
  ipa = NULL,
  definition_simple = NULL,
  definition_teacher = NULL,
  usage_notes = NULL,
  register = NULL,
  variety = NULL,
  examples = '[]'::jsonb,
  collocations = '[]'::jsonb,
  patterns = '[]'::jsonb,
  updated_at = now()
WHERE headword IN (
  'say', 'tell', 'speak', 'talk', 'ask', 'answer', 'call', 'write', 'read', 'listen',
  'understand', 'explain', 'show', 'mean', 'send',
  'computer', 'phone', 'email', 'internet', 'website', 'message', 'information',
  'question', 'language', 'word', 'name', 'number',
  'idea', 'problem', 'help', 'example', 'reason', 'way', 'thing', 'part', 'place', 'point'
);
*/

-- Rollback Batch 6: A1 Time and Quantity (~150 words)
-- Uncomment and execute to rollback batch 6
/*
UPDATE lexicon_entries
SET
  ipa = NULL,
  definition_simple = NULL,
  definition_teacher = NULL,
  usage_notes = NULL,
  register = NULL,
  variety = NULL,
  examples = '[]'::jsonb,
  collocations = '[]'::jsonb,
  patterns = '[]'::jsonb,
  updated_at = now()
WHERE headword IN (
  'time', 'day', 'week', 'month', 'year', 'hour', 'minute', 'moment',
  'today', 'tomorrow', 'yesterday', 'now', 'then',
  'many', 'much', 'some', 'any', 'all', 'every', 'each', 'most', 'few', 'little',
  'other', 'another',
  'before', 'after', 'during', 'while', 'when',
  'already', 'yet', 'still', 'soon'
);
*/

-- Rollback Batch 7: A1 Remaining High-Frequency Words (~150 words)
-- Uncomment and execute to rollback batch 7
/*
UPDATE lexicon_entries
SET
  ipa = NULL,
  definition_simple = NULL,
  definition_teacher = NULL,
  usage_notes = NULL,
  register = NULL,
  variety = NULL,
  examples = '[]'::jsonb,
  collocations = '[]'::jsonb,
  patterns = '[]'::jsonb,
  updated_at = now()
WHERE headword IN (
  'can', 'could', 'will', 'would', 'should', 'must', 'may', 'might',
  'know', 'think', 'want', 'need', 'like', 'see', 'look', 'find', 'give', 'take',
  'good', 'bad', 'big', 'small', 'new', 'old', 'important', 'different', 'same', 'right', 'wrong', 'ready',
  'make', 'do', 'get', 'go', 'come', 'use', 'work', 'start'
);
*/

-- ============================================================================
-- FULL ROLLBACK - ALL BATCHES
-- ============================================================================

-- Rollback ALL vocabulary enhancements (Batches 1-7)
-- WARNING: This will remove all enhanced data for A0 and A1 vocabulary
-- Uncomment and execute to rollback everything
/*
UPDATE lexicon_entries
SET
  ipa = NULL,
  definition_simple = NULL,
  definition_teacher = NULL,
  usage_notes = NULL,
  register = NULL,
  variety = NULL,
  examples = '[]'::jsonb,
  collocations = '[]'::jsonb,
  patterns = '[]'::jsonb,
  updated_at = now()
WHERE cefr_receptive IN ('A0', 'A1')
  AND is_published = true;
*/

-- ============================================================================
-- VERIFICATION QUERIES
-- ============================================================================

-- After rollback, verify that fields have been cleared
-- Run this query to check rollback success
SELECT 
  cefr_receptive,
  COUNT(*) as total_entries,
  COUNT(ipa) as entries_with_ipa,
  COUNT(definition_simple) as entries_with_definition,
  COUNT(CASE WHEN jsonb_array_length(examples) > 0 THEN 1 END) as entries_with_examples
FROM lexicon_entries
WHERE cefr_receptive IN ('A0', 'A1')
  AND is_published = true
GROUP BY cefr_receptive
ORDER BY cefr_receptive;

-- Check specific batch rollback success
-- Replace the headword list with the batch you rolled back
/*
SELECT 
  headword,
  ipa,
  definition_simple,
  jsonb_array_length(examples) as example_count
FROM lexicon_entries
WHERE headword IN ('say', 'tell', 'speak', 'talk', 'ask')
ORDER BY headword;
*/
