-- Seed A0 Foundations Course Structure
-- Creates the complete A0 level with 6 units and 4 lessons per unit

-- First, ensure we have a course
DO $$
DECLARE
  v_course_id UUID;
  v_level_id UUID;
  v_unit1_id UUID;
  v_unit2_id UUID;
  v_unit3_id UUID;
  v_unit4_id UUID;
  v_unit5_id UUID;
  v_unit6_id UUID;
BEGIN
  -- Create or get the main course
  INSERT INTO public.courses (
    id,
    title,
    description,
    is_published
  ) VALUES (
    gen_random_uuid(),
    'Grind English - Core Track',
    'Complete English learning program from A0 to C2, designed for Brazilian adult learners',
    true
  )
  ON CONFLICT DO NOTHING
  RETURNING id INTO v_course_id;

  -- If course already exists, get its ID
  IF v_course_id IS NULL THEN
    SELECT id INTO v_course_id FROM public.courses LIMIT 1;
  END IF;

  -- Create A0 Level (or get existing)
  SELECT id INTO v_level_id 
  FROM public.levels 
  WHERE course_id = v_course_id AND cefr_code = 'A0';

  IF v_level_id IS NULL THEN
    INSERT INTO public.levels (
      id,
      course_id,
      cefr_code,
      title,
      sort_order,
      is_published
    ) VALUES (
      gen_random_uuid(),
      v_course_id,
      'A0',
      'A0 Foundations',
      0,
      true
    )
    RETURNING id INTO v_level_id;
  ELSE
    -- Update existing level to be published
    UPDATE public.levels 
    SET is_published = true 
    WHERE id = v_level_id;
  END IF;

  -- ============ UNIT 1: Hello & Identity ============
  INSERT INTO public.units (
    id,
    level_id,
    title,
    theme,
    flagship_task,
    outcomes,
    sort_order,
    is_published
  ) VALUES (
    gen_random_uuid(),
    v_level_id,
    'Hello & Identity',
    'Introductions & Contact',
    'Introduce yourself and exchange basic personal info (name, country, job/student, phone/WhatsApp)',
    jsonb_build_object(
      'speaking', 'Record a 30-45 second self-introduction',
      'writing', 'Complete a profile card with name, nationality, city, email/WhatsApp',
      'vocabulary', 'Greetings, countries/nationalities, jobs, alphabet, numbers 0-20',
      'grammar', 'Verb to be (affirmative/negative/questions), subject pronouns, possessive adjectives',
      'pronunciation', 'Alphabet letter names, sentence stress, basic question intonation'
    ),
    0,
    true
  )
  RETURNING id INTO v_unit1_id;

  -- Unit 1 Lessons
  INSERT INTO public.lessons (unit_id, title, lesson_type, goal, sort_order, is_published) VALUES
  (v_unit1_id, 'Professional Greetings & Names', 'vocabulary', 'Confidently greet a colleague and introduce your first and last name using the verb to be', 0, true),
  (v_unit1_id, 'Origins & Roles', 'grammar', 'State your city/country of origin and your professional title', 1, true),
  (v_unit1_id, 'Exchanging Contact Info', 'speaking', 'Confidently spell your name and dictate your email/phone number', 2, true),
  (v_unit1_id, 'Unit Performance Assessment', 'assessment', 'Complete a profile card and conduct a 2-message introductory chat', 3, true);

  -- ============ UNIT 2: Numbers, Time & Dates ============
  INSERT INTO public.units (
    id,
    level_id,
    title,
    theme,
    flagship_task,
    outcomes,
    sort_order,
    is_published
  ) VALUES (
    gen_random_uuid(),
    v_level_id,
    'Numbers, Time & Dates',
    'Scheduling & Planning',
    'Arrange a simple meeting time/date and confirm details',
    jsonb_build_object(
      'speaking', 'Propose a meeting time and confirm (45-60 seconds)',
      'writing', 'Write a short message: "Hi __. Can we meet on __ at __?"',
      'vocabulary', 'Numbers 0-100, days, months, times, basic calendar words',
      'grammar', 'What time is it? / When...? / Prepositions: on/in/at (intro)',
      'pronunciation', 'Numbers clarity (15/50, thirteen/thirty), stress in times/dates'
    ),
    1,
    true
  )
  RETURNING id INTO v_unit2_id;

  -- Unit 2 Lessons
  INSERT INTO public.lessons (unit_id, title, lesson_type, goal, sort_order, is_published) VALUES
  (v_unit2_id, 'Days of the Week & Availability', 'vocabulary', 'State your availability using days of the week and the preposition "on"', 0, true),
  (v_unit2_id, 'Telling Time for Meetings', 'vocabulary', 'State exact and half-hour meeting times using 12-hour AM/PM system', 1, true),
  (v_unit2_id, 'Proposing a Plan', 'speaking', 'Ask about availability using inverted "to be" questions and confirm a meeting', 2, true),
  (v_unit2_id, 'Unit Performance Assessment', 'assessment', 'Successfully negotiate a meeting time', 3, true);

  -- ============ UNIT 3: My World (Home & Objects) ============
  INSERT INTO public.units (
    id,
    level_id,
    title,
    theme,
    flagship_task,
    outcomes,
    sort_order,
    is_published
  ) VALUES (
    gen_random_uuid(),
    v_level_id,
    'My World (Home & Objects)',
    'Workspace & Location',
    'Describe your room/home and locate objects',
    jsonb_build_object(
      'speaking', '30-60 second guided description of a room',
      'writing', '3-5 sentences: "This is my __. There is/are..."',
      'vocabulary', 'Rooms, furniture, common objects, colors, basic adjectives',
      'grammar', 'There is/are, this/that/these/those, prepositions (in/on/under/next to)',
      'pronunciation', '/ð/ in this/that, plural -s awareness, chunking with "there is/are"'
    ),
    2,
    true
  )
  RETURNING id INTO v_unit3_id;

  -- Unit 3 Lessons
  INSERT INTO public.lessons (unit_id, title, lesson_type, goal, sort_order, is_published) VALUES
  (v_unit3_id, 'The Office & Home Workspace', 'vocabulary', 'State your current working location and identify basic rooms', 0, true),
  (v_unit3_id, 'Desk & Tech Vocabulary', 'vocabulary', 'Identify standard tech equipment and report a broken item', 1, true),
  (v_unit3_id, 'Where is it?', 'grammar', 'Ask where an item is and answer using prepositions on/under/near', 2, true),
  (v_unit3_id, 'Unit Performance Assessment', 'assessment', 'Give a virtual tour and locate missing items', 3, true);

  -- ============ UNIT 4: Daily Routines ============
  INSERT INTO public.units (
    id,
    level_id,
    title,
    theme,
    flagship_task,
    outcomes,
    sort_order,
    is_published
  ) VALUES (
    gen_random_uuid(),
    v_level_id,
    'Daily Routines',
    'Work & Life Schedule',
    'Talk about your daily routine and ask about someone else''s routine',
    jsonb_build_object(
      'speaking', '45-60 second "My day" recording (morning to evening)',
      'writing', '4-6 sentences: "I get up at... I work/study... I go to bed at..."',
      'vocabulary', 'Routine verbs (wake up, get up, go to work, have breakfast, study, exercise, sleep), time phrases',
      'grammar', 'Simple present (I/you/we/they), basic questions with "do", frequency adverbs (intro)',
      'pronunciation', 'Third-person -s awareness, sentence stress on time + action, linking in phrases'
    ),
    3,
    true
  )
  RETURNING id INTO v_unit4_id;

  -- Unit 4 Lessons
  INSERT INTO public.lessons (unit_id, title, lesson_type, goal, sort_order, is_published) VALUES
  (v_unit4_id, 'Morning & Evening Habits', 'vocabulary', 'Describe 4-5 key events in your day using "I" and correct time prepositions', 0, true),
  (v_unit4_id, 'Work vs. Study Routines', 'grammar', 'Qualify your routine using adverbs of frequency to explain schedule variations', 1, true),
  (v_unit4_id, 'Asking About Routines', 'speaking', 'Ask open and closed questions to determine a colleague''s schedule', 2, true),
  (v_unit4_id, 'Unit Performance Assessment', 'assessment', 'Describe your workday and interview a colleague about their schedule', 3, true);

  -- ============ UNIT 5: Shopping Basics ============
  INSERT INTO public.units (
    id,
    level_id,
    title,
    theme,
    flagship_task,
    outcomes,
    sort_order,
    is_published
  ) VALUES (
    gen_random_uuid(),
    v_level_id,
    'Shopping Basics',
    'Transactions & Purchases',
    'Buy items in a store: ask price, quantity, and pay',
    jsonb_build_object(
      'speaking', '60-90 second role-play: customer-cashier or customer-store assistant',
      'writing', 'Shopping list (8-12 items) + 2-message chat ("Do you have...?" "How much is...?")',
      'vocabulary', 'Common food/household items, money, numbers review, containers, store phrases',
      'grammar', 'How much/many? (intro), this/that/these/those (recycle), "some" (intro as chunk)',
      'pronunciation', 'Numbers + prices clarity, stress in polite requests, plural -s perception'
    ),
    4,
    true
  )
  RETURNING id INTO v_unit5_id;

  -- Unit 5 Lessons
  INSERT INTO public.lessons (unit_id, title, lesson_type, goal, sort_order, is_published) VALUES
  (v_unit5_id, 'Basic Items & Prices', 'vocabulary', 'Ask for the price of an item and comprehend responses from $1 to $999', 0, true),
  (v_unit5_id, 'Polite Requests in a Store', 'speaking', 'Order food, drinks, or retail items using "would like" instead of "want"', 1, true),
  (v_unit5_id, 'Checking Out & Payment', 'vocabulary', 'State your payment method using correct prepositions and ask for a receipt', 2, true),
  (v_unit5_id, 'Unit Performance Assessment', 'assessment', 'Navigate a complete retail transaction from order to payment', 3, true);

  -- ============ UNIT 6: Getting Around (Directions & Transport) ============
  INSERT INTO public.units (
    id,
    level_id,
    title,
    theme,
    flagship_task,
    outcomes,
    sort_order,
    is_published
  ) VALUES (
    gen_random_uuid(),
    v_level_id,
    'Getting Around',
    'Directions & Transport',
    'Ask for and understand simple directions; identify transport options',
    jsonb_build_object(
      'speaking', '60-90 second: ask directions + repeat back/confirm route',
      'writing', 'Short message: "How do I get to...?" + fill-in directions template (2-4 steps)',
      'vocabulary', 'Places in town (bank, supermarket, pharmacy, bus stop), direction words (left/right/straight), transport',
      'grammar', 'Imperatives for directions (turn left, go straight), "where is...?", there is/are (recycle)',
      'pronunciation', 'Clarity of place names, stress in multiword places, intonation for questions'
    ),
    5,
    true
  )
  RETURNING id INTO v_unit6_id;

  -- Unit 6 Lessons
  INSERT INTO public.lessons (unit_id, title, lesson_type, goal, sort_order, is_published) VALUES
  (v_unit6_id, 'Places in the City & Neighborhood', 'vocabulary', 'Identify standard urban/corporate locations and describe their position', 0, true),
  (v_unit6_id, 'Basic Directions', 'grammar', 'Issue and comprehend clear directional commands using imperative verbs', 1, true),
  (v_unit6_id, 'Asking for Help', 'speaking', 'Politely interrupt a stranger to ask for directions to a specific location', 2, true),
  (v_unit6_id, 'Unit Performance Assessment', 'assessment', 'Navigate a foreign environment by asking for and giving clear directions', 3, true);

END $$;

COMMENT ON TABLE public.courses IS 'Top-level course container';
COMMENT ON TABLE public.levels IS 'CEFR levels within a course';
COMMENT ON TABLE public.units IS 'Thematic units within a level';
COMMENT ON TABLE public.lessons IS 'Individual lessons within a unit';
