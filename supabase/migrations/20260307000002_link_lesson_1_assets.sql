-- Link Grammar and Vocabulary Assets to A0-U1-L1 (Professional Greetings & Names)
-- This migration connects the seeded content to the lesson

DO $$
DECLARE
  v_lesson_id UUID;
  v_grammar_be_id UUID;
  v_grammar_my_id UUID;
  v_vocab_hello_id UUID;
  v_vocab_hi_id UUID;
  v_vocab_good_morning_id UUID;
  v_vocab_good_afternoon_id UUID;
  v_vocab_name_id UUID;
  v_vocab_first_name_id UUID;
  v_vocab_last_name_id UUID;
  v_vocab_nice_to_meet_id UUID;
BEGIN
  -- Get the lesson ID for A0-U1-L1 (first lesson in first unit)
  SELECT l.id INTO v_lesson_id 
  FROM public.lessons l
  JOIN public.units u ON l.unit_id = u.id
  JOIN public.levels lv ON u.level_id = lv.id
  WHERE lv.cefr_code = 'A0' 
    AND u.sort_order = 0 
    AND l.sort_order = 0
    AND l.title = 'Professional Greetings & Names';

  IF v_lesson_id IS NULL THEN
    RAISE NOTICE 'Lesson "Professional Greetings & Names" not found. Run the course structure migration first.';
    RETURN;
  END IF;

  -- Get grammar chapter IDs
  SELECT id INTO v_grammar_be_id 
  FROM public.grammar_chapters 
  WHERE chapter_code = 'A0.G.01';

  SELECT id INTO v_grammar_my_id 
  FROM public.grammar_chapters 
  WHERE chapter_code = 'A0.G.02';

  -- Get vocabulary IDs
  SELECT id INTO v_vocab_hello_id 
  FROM public.lexicon_entries 
  WHERE headword = 'hello';

  SELECT id INTO v_vocab_hi_id 
  FROM public.lexicon_entries 
  WHERE headword = 'hi';

  SELECT id INTO v_vocab_good_morning_id 
  FROM public.lexicon_entries 
  WHERE headword = 'good morning';

  SELECT id INTO v_vocab_good_afternoon_id 
  FROM public.lexicon_entries 
  WHERE headword = 'good afternoon';

  SELECT id INTO v_vocab_name_id 
  FROM public.lexicon_entries 
  WHERE headword = 'name';

  SELECT id INTO v_vocab_first_name_id 
  FROM public.lexicon_entries 
  WHERE headword = 'first name';

  SELECT id INTO v_vocab_last_name_id 
  FROM public.lexicon_entries 
  WHERE headword = 'last name';

  SELECT id INTO v_vocab_nice_to_meet_id 
  FROM public.lexicon_entries 
  WHERE headword = 'nice to meet you';

  -- Link grammar chapters to the lesson (lesson-level, not stage-specific)
  IF v_grammar_be_id IS NOT NULL THEN
    INSERT INTO public.lesson_assets (
      lesson_id, asset_type, asset_id, order_index, is_required, context_note
    ) VALUES (
      v_lesson_id, 'grammar', v_grammar_be_id, 0, true, 
      'Core grammar for introducing yourself professionally'
    )
    ON CONFLICT (lesson_id, stage_id, asset_type, asset_id) DO NOTHING;
  END IF;

  IF v_grammar_my_id IS NOT NULL THEN
    INSERT INTO public.lesson_assets (
      lesson_id, asset_type, asset_id, order_index, is_required, context_note
    ) VALUES (
      v_lesson_id, 'grammar', v_grammar_my_id, 1, true, 
      'Possessive adjective for stating your name'
    )
    ON CONFLICT (lesson_id, stage_id, asset_type, asset_id) DO NOTHING;
  END IF;

  -- Link vocabulary to the lesson
  IF v_vocab_hello_id IS NOT NULL THEN
    INSERT INTO public.lesson_assets (
      lesson_id, asset_type, asset_id, order_index, is_required, context_note
    ) VALUES (
      v_lesson_id, 'vocabulary', v_vocab_hello_id, 2, true, 
      'Professional greeting'
    )
    ON CONFLICT (lesson_id, stage_id, asset_type, asset_id) DO NOTHING;
  END IF;

  IF v_vocab_hi_id IS NOT NULL THEN
    INSERT INTO public.lesson_assets (
      lesson_id, asset_type, asset_id, order_index, is_required, context_note
    ) VALUES (
      v_lesson_id, 'vocabulary', v_vocab_hi_id, 3, true, 
      'Informal greeting'
    )
    ON CONFLICT (lesson_id, stage_id, asset_type, asset_id) DO NOTHING;
  END IF;

  IF v_vocab_good_morning_id IS NOT NULL THEN
    INSERT INTO public.lesson_assets (
      lesson_id, asset_type, asset_id, order_index, is_required, context_note
    ) VALUES (
      v_lesson_id, 'vocabulary', v_vocab_good_morning_id, 4, true, 
      'Time-specific greeting (before noon)'
    )
    ON CONFLICT (lesson_id, stage_id, asset_type, asset_id) DO NOTHING;
  END IF;

  IF v_vocab_good_afternoon_id IS NOT NULL THEN
    INSERT INTO public.lesson_assets (
      lesson_id, asset_type, asset_id, order_index, is_required, context_note
    ) VALUES (
      v_lesson_id, 'vocabulary', v_vocab_good_afternoon_id, 5, true, 
      'Time-specific greeting (afternoon)'
    )
    ON CONFLICT (lesson_id, stage_id, asset_type, asset_id) DO NOTHING;
  END IF;

  IF v_vocab_name_id IS NOT NULL THEN
    INSERT INTO public.lesson_assets (
      lesson_id, asset_type, asset_id, order_index, is_required, context_note
    ) VALUES (
      v_lesson_id, 'vocabulary', v_vocab_name_id, 6, true, 
      'Core vocabulary for introductions'
    )
    ON CONFLICT (lesson_id, stage_id, asset_type, asset_id) DO NOTHING;
  END IF;

  IF v_vocab_first_name_id IS NOT NULL THEN
    INSERT INTO public.lesson_assets (
      lesson_id, asset_type, asset_id, order_index, is_required, context_note
    ) VALUES (
      v_lesson_id, 'vocabulary', v_vocab_first_name_id, 7, true, 
      'Given name terminology'
    )
    ON CONFLICT (lesson_id, stage_id, asset_type, asset_id) DO NOTHING;
  END IF;

  IF v_vocab_last_name_id IS NOT NULL THEN
    INSERT INTO public.lesson_assets (
      lesson_id, asset_type, asset_id, order_index, is_required, context_note
    ) VALUES (
      v_lesson_id, 'vocabulary', v_vocab_last_name_id, 8, true, 
      'Family name terminology'
    )
    ON CONFLICT (lesson_id, stage_id, asset_type, asset_id) DO NOTHING;
  END IF;

  IF v_vocab_nice_to_meet_id IS NOT NULL THEN
    INSERT INTO public.lesson_assets (
      lesson_id, asset_type, asset_id, order_index, is_required, context_note
    ) VALUES (
      v_lesson_id, 'vocabulary', v_vocab_nice_to_meet_id, 9, true, 
      'Professional greeting phrase after introductions'
    )
    ON CONFLICT (lesson_id, stage_id, asset_type, asset_id) DO NOTHING;
  END IF;

  RAISE NOTICE 'Successfully linked assets to Lesson A0-U1-L1';
END $$;
