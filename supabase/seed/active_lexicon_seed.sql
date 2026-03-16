-- Active Lexicon Engine - Sample Master_Lexicon seed data
-- Run after migrations. Use: supabase db execute -f supabase/seed/active_lexicon_seed.sql
-- Or paste into Supabase SQL Editor.
-- Re-running is safe: ON CONFLICT (english_word) DO NOTHING.

INSERT INTO public.Master_Lexicon (
  english_word,
  cefr_level,
  unit,
  definition,
  example_sentence,
  audio_url,
  l1_notes
) VALUES
  (
    'have',
    'A1',
    'Unit 1',
    'to possess or own',
    'I have breakfast at 7 AM',
    NULL,
    'make vs. do: Use "have" for possession; "make" for creating things.'
  ),
  (
    'make',
    'A1',
    'Unit 1',
    'to create or produce',
    'She makes dinner every day',
    NULL,
    'make vs. do: Use "make" for creating; "do" for actions or tasks.'
  ),
  (
    'do',
    'A1',
    'Unit 1',
    'to perform an action or task',
    'I do my homework after school',
    NULL,
    'make vs. do: Use "do" for tasks and activities; "make" for creating.'
  ),
  (
    'get',
    'A1',
    'Unit 2',
    'to obtain or receive',
    'I get up at seven o''clock',
    NULL,
    'get vs. have: "Get" suggests obtaining; "have" suggests already possessing.'
  ),
  (
    'go',
    'A1',
    'Unit 2',
    'to move or travel',
    'We go to school by bus',
    NULL,
    'go vs. come: "Go" is away from speaker; "come" is toward speaker.'
  )
ON CONFLICT (english_word) DO NOTHING;
