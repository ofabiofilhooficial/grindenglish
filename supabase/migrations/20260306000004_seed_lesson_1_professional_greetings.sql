-- Seed Lesson 1: Professional Greetings & Names
-- A0-U1-L1 | Track: Core / Professional | Time: 50 Minutes

-- First, ensure we have the necessary grammar chapters
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
) VALUES
(
  gen_random_uuid(),
  'A0.G.01',
  'A0',
  'Verb To Be: I am / I''m',
  'The verb "to be" is used to say who you are, where you are from, and to describe yourself. "I am" is the full form, and "I''m" is the short form (contraction).',
  'Full form: I am
Short form (contraction): I''m

Examples:
• I am Maria. → I''m Maria.
• I am from Brazil. → I''m from Brazil.
• I am a teacher. → I''m a teacher.',
  'Use "I''m" in professional introductions because it sounds more natural and confident in English.

Professional context:
• "Hello, I''m John Smith." (NOT "My name is John Smith")
• "I''m the new project manager."
• "I''m calling about the meeting."',
  'Portuguese speakers often say "My name is..." because in Portuguese we say "Meu nome é...". In English, professionals prefer "I''m [name]" for introductions.

❌ Brazilian way: "My name is Carlos."
✅ English way: "I''m Carlos." or "Hello, I''m Carlos."',
  'Common errors:
1. ❌ "I am Carlos" (too formal for introductions)
   ✅ "I''m Carlos" (natural and professional)

2. ❌ "My name is Carlos" (sounds like a child)
   ✅ "I''m Carlos" (sounds professional)

3. ❌ "I am be Carlos" (double verb)
   ✅ "I''m Carlos"',
  1,
  true
);

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
) VALUES
(
  gen_random_uuid(),
  'A0.G.02',
  'A0',
  'Possessive Adjective: My',
  '"My" shows that something belongs to you. It comes before a noun.',
  'Pattern: my + noun

Examples:
• my name
• my first name
• my last name
• my email
• my phone number',
  'Use "my" when introducing yourself or giving your information:
• "My name is Carlos Silva."
• "My email is carlos@company.com"
• "My first name is Carlos, my last name is Silva."

In professional contexts, you often need to give your full name:
• "I''m Carlos Silva. My first name is Carlos, S-I-L-V-A is my last name."',
  'In Portuguese, we say "meu nome" (my name), which is similar to English. However, Brazilians often forget to use "my" in English.

❌ "Name is Carlos" (missing "my")
✅ "My name is Carlos"',
  'Common errors:
1. ❌ "Name is Carlos" (missing "my")
   ✅ "My name is Carlos"

2. ❌ "My name Carlos" (missing verb)
   ✅ "My name is Carlos"

3. ❌ "The my name" (don''t use "the" with "my")
   ✅ "My name"',
  2,
  true
);

-- Insert vocabulary entries
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
) VALUES
(
  gen_random_uuid(),
  'hello',
  'interjection',
  'A0',
  'A0',
  'həˈloʊ',
  'A word you say when you meet someone or answer the phone.',
  'The most common and neutral greeting in English. Used in all contexts - formal and informal.',
  'Use "Hello" in professional contexts. It''s more formal than "Hi" but not too formal. Perfect for first meetings, phone calls, and emails.',
  'neutral',
  'international',
  '["Hello, I''m John.", "Hello, nice to meet you.", "Hello, this is Maria calling."]'::jsonb,
  1,
  true
);

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
) VALUES
(
  gen_random_uuid(),
  'hi',
  'interjection',
  'A0',
  'A0',
  'haɪ',
  'An informal way to say hello.',
  'A casual, friendly greeting. Less formal than "hello".',
  'Use "Hi" with colleagues you know well. Don''t use it in very formal situations like job interviews or with senior executives you''re meeting for the first time.',
  'informal',
  'international',
  '["Hi, how are you?", "Hi there!", "Hi everyone!"]'::jsonb,
  1,
  true
);

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
) VALUES
(
  gen_random_uuid(),
  'good morning',
  'phrase',
  'A0',
  'A0',
  'ɡʊd ˈmɔːrnɪŋ',
  'What you say to greet someone before 12:00 PM (noon).',
  'Time-specific greeting used before noon. Professional and polite.',
  'PRONUNCIATION TIP: Don''t add an extra "i" sound at the end! Brazilian speakers often say "good-ee morning-ee" but in English it''s "good morning" (no extra vowel sounds).',
  'neutral',
  'international',
  '["Good morning, everyone.", "Good morning, Mr. Silva.", "Good morning! How are you today?"]'::jsonb,
  1,
  true
);

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
) VALUES
(
  gen_random_uuid(),
  'good afternoon',
  'phrase',
  'A0',
  'A0',
  'ɡʊd ˌæftərˈnuːn',
  'What you say to greet someone between 12:00 PM and 6:00 PM.',
  'Time-specific greeting used in the afternoon. Professional and polite.',
  'Use "Good afternoon" from noon until early evening (around 6 PM). After 6 PM, switch to "Good evening".',
  'neutral',
  'international',
  '["Good afternoon, team.", "Good afternoon, how can I help you?"]'::jsonb,
  1,
  true
);

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
) VALUES
(
  gen_random_uuid(),
  'name',
  'noun',
  'A0',
  'A0',
  'neɪm',
  'The word or words that someone is called.',
  'What you are called. In professional contexts, you usually give both your first name and last name.',
  'In English, we say "first name" (given name) and "last name" (family name/surname). Example: Carlos Silva → Carlos is the first name, Silva is the last name.',
  'neutral',
  'international',
  '["My name is Carlos.", "What''s your name?", "Can I have your name, please?"]'::jsonb,
  1,
  true
);

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
) VALUES
(
  gen_random_uuid(),
  'first name',
  'phrase',
  'A0',
  'A0',
  'fɜːrst neɪm',
  'Your personal name (not your family name).',
  'Also called "given name". In Carlos Silva, "Carlos" is the first name.',
  'In professional contexts, people often ask "What''s your first name?" when filling out forms or making introductions.',
  'neutral',
  'international',
  '["My first name is Carlos.", "Can I have your first name?", "Please write your first name here."]'::jsonb,
  1,
  true
);

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
) VALUES
(
  gen_random_uuid(),
  'last name',
  'phrase',
  'A0',
  'A0',
  'læst neɪm',
  'Your family name (surname).',
  'Also called "surname" or "family name". In Carlos Silva, "Silva" is the last name.',
  'In professional contexts, you often need to spell your last name because it might be unfamiliar to English speakers.',
  'neutral',
  'international',
  '["My last name is Silva.", "How do you spell your last name?", "S-I-L-V-A is my last name."]'::jsonb,
  1,
  true
);

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
) VALUES
(
  gen_random_uuid(),
  'nice to meet you',
  'phrase',
  'A0',
  'A0',
  'naɪs tə miːt juː',
  'A polite thing to say when you meet someone for the first time.',
  'Standard professional greeting phrase used after introductions.',
  'Say this AFTER you introduce yourself. Pattern: "Hello, I''m [name]. Nice to meet you."

The response is usually: "Nice to meet you too" or "Pleased to meet you".',
  'neutral',
  'international',
  '["Hello, I''m Carlos. Nice to meet you.", "Nice to meet you, Mr. Smith.", "Nice to meet you too!"]'::jsonb,
  1,
  true
);

-- Note: The actual lesson and stages will be created through the UI
-- This migration only ensures the grammar and vocabulary content exists

COMMENT ON TABLE public.grammar_chapters IS 'Grammar reference content for lessons';
COMMENT ON TABLE public.lexicon_entries IS 'Vocabulary entries for lessons';
