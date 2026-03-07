# Lesson Content Creation Template

Use this template to create grammar chapters and vocabulary entries for each A0 lesson, then link them using the Course Builder.

## Template: Grammar Chapter

```sql
INSERT INTO public.grammar_chapters (
  id,
  chapter_code,
  cefr_level,
  title,
  meaning_content,
  form_content,
  use_content,
  contrast_notes,
  common_errors,
  sort_order,
  is_published
) VALUES (
  gen_random_uuid(),
  '[CHAPTER_CODE]',  -- e.g., 'A0.G.03'
  'A0',
  '[TITLE]',  -- e.g., 'Preposition: From'
  '[MEANING]',  -- What does this grammar mean? When do we use it?
  '[FORM]',  -- How is it structured? Show patterns and examples
  '[USE]',  -- How do professionals use this in real contexts?
  '[L1_CONTRAST]',  -- How is this different from Portuguese? Common translation errors?
  '[COMMON_ERRORS]',  -- What mistakes do Brazilian learners make?
  [SORT_NUMBER],  -- Sequential number for ordering
  true
);
```

## Template: Vocabulary Entry

```sql
INSERT INTO public.lexicon_entries (
  id,
  headword,
  pos,
  cefr_receptive,
  cefr_productive,
  ipa,
  definition_simple,
  definition_teacher,
  usage_notes,
  register,
  variety,
  examples,
  frequency_band,
  is_published
) VALUES (
  gen_random_uuid(),
  '[WORD]',  -- e.g., 'engineer'
  '[POS]',  -- noun, verb, adjective, phrase, interjection
  'A0',
  'A0',
  '[IPA]',  -- e.g., 'ˌendʒɪˈnɪr'
  '[SIMPLE_DEF]',  -- Simple definition for students
  '[TEACHER_DEF]',  -- More detailed definition for teachers
  '[USAGE_NOTES]',  -- When/how to use this word professionally
  '[REGISTER]',  -- neutral, formal, informal
  'international',  -- or 'american', 'british'
  '["[EXAMPLE_1]", "[EXAMPLE_2]", "[EXAMPLE_3]"]'::jsonb,
  1,  -- frequency band (1 = most common)
  true
);
```

## A0-U1-L2: Origins & Roles

### Grammar Needed
1. **Preposition: From** (A0.G.03)
   - Meaning: Shows where you come from
   - Form: I am from [place]
   - Use: "I'm from Brazil" / "I'm from São Paulo"
   - L1 Contrast: Similar to Portuguese "de", but position is different
   - Common Errors: "I am of Brazil" ❌ → "I'm from Brazil" ✅

2. **Articles: A/An** (A0.G.04)
   - Meaning: Used before singular countable nouns
   - Form: a + consonant sound, an + vowel sound
   - Use: "I'm a teacher" / "I'm an engineer"
   - L1 Contrast: Portuguese uses "um/uma" but English uses a/an before professions
   - Common Errors: "I am manager" ❌ → "I'm a manager" ✅

### Vocabulary Needed
- Brazil (noun) - /brəˈzɪl/
- city (noun) - /ˈsɪti/
- country (noun) - /ˈkʌntri/
- job (noun) - /dʒɑːb/
- work (verb/noun) - /wɜːrk/
- engineer (noun) - /ˌendʒɪˈnɪr/
- manager (noun) - /ˈmænɪdʒər/
- developer (noun) - /dɪˈveləpər/
- teacher (noun) - /ˈtiːtʃər/
- student (noun) - /ˈstuːdənt/

## A0-U1-L3: Exchanging Contact Info

### Grammar Needed
1. **Questions: What is...?** (A0.G.05)
   - Meaning: Asking for information
   - Form: What is your [noun]?
   - Use: "What is your email?" / "What is your phone number?"
   - L1 Contrast: Word order is different from Portuguese
   - Common Errors: "What your email?" ❌ → "What is your email?" ✅

### Vocabulary Needed
- alphabet (noun) - /ˈælfəbet/
- email (noun) - /ˈiːmeɪl/
- phone number (phrase) - /foʊn ˈnʌmbər/
- WhatsApp (noun) - /ˈwɑːtsæp/
- @ (at) - /æt/
- . (dot) - /dɑːt/
- Numbers 0-20

## Quick Linking Process

After creating grammar and vocabulary:

1. Go to **Course Builder** → **Levels** → **A0 Foundations**
2. Click on the **Unit** (e.g., Unit 1)
3. Click on the **Lesson** (e.g., Lesson 2)
4. Scroll to **"Linked Reference Content"** section
5. Click **Grammar** tab
6. Search for your grammar chapter
7. Click **+** to link it
8. Click **Vocabulary** tab
9. Search for each vocabulary entry
10. Click **+** to link each one
11. Verify they appear in "Currently Linked" with actual names
12. Save

## Verification Checklist

For each lesson, verify:
- [ ] Grammar chapters created and published
- [ ] Vocabulary entries created and published
- [ ] Assets linked to lesson in Course Builder
- [ ] "Currently Linked" shows actual asset names (not just "Grammar"/"Vocabulary")
- [ ] Student view shows all content when lesson is opened
- [ ] Content expands to show full details
- [ ] Progress tracking works (3-second view threshold)

## Batch Creation Tips

### For Multiple Lessons
1. Create all grammar chapters for a unit at once
2. Create all vocabulary entries for a unit at once
3. Then link them lesson by lesson
4. This is faster than doing one lesson at a time

### Use Consistent Naming
- Grammar codes: A0.G.01, A0.G.02, A0.G.03...
- Keep titles clear and descriptive
- Use consistent format for examples

### Test As You Go
- After linking 2-3 lessons, test student view
- Verify progress tracking works
- Check SRS scheduling
- Fix any issues before continuing

## Example: Complete Lesson 2 Creation

```sql
-- Grammar 1: Preposition From
INSERT INTO public.grammar_chapters (
  id, chapter_code, cefr_level, title,
  meaning_content, form_content, use_content,
  contrast_notes, common_errors, sort_order, is_published
) VALUES (
  gen_random_uuid(), 'A0.G.03', 'A0', 'Preposition: From',
  'The preposition "from" shows your origin - where you come from.',
  'Pattern: I am from + [place]

Examples:
• I am from Brazil. → I''m from Brazil.
• I am from São Paulo. → I''m from São Paulo.
• I am from the United States. → I''m from the US.',
  'Use "from" to state your city or country in professional introductions.

Professional context:
• "I''m from Brazil, but I work in the US."
• "I''m from São Paulo. Where are you from?"',
  'Portuguese speakers say "Eu sou do Brasil" (I am of Brazil). In English, we use "from", not "of".

❌ Brazilian way: "I am of Brazil"
✅ English way: "I''m from Brazil"',
  'Common errors:
1. ❌ "I am of Brazil" (translating "do")
   ✅ "I''m from Brazil"
2. ❌ "I from Brazil" (missing verb)
   ✅ "I''m from Brazil"',
  3, true
);

-- Vocabulary: engineer
INSERT INTO public.lexicon_entries (
  id, headword, pos, cefr_receptive, cefr_productive,
  ipa, definition_simple, definition_teacher, usage_notes,
  register, variety, examples, frequency_band, is_published
) VALUES (
  gen_random_uuid(), 'engineer', 'noun', 'A0', 'A0',
  'ˌendʒɪˈnɪr',
  'A person who designs and builds machines, roads, bridges, etc.',
  'Professional who applies scientific and mathematical principles to design and build systems.',
  'Use "engineer" with the article "an" because it starts with a vowel sound.
  
Common types: software engineer, civil engineer, mechanical engineer.',
  'neutral', 'international',
  '["I''m an engineer.", "She is a software engineer.", "He works as an engineer at Google."]'::jsonb,
  1, true
);
```

Then link them in Course Builder!
