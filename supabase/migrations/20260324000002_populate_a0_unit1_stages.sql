-- Populate A0 Unit 1 Lessons with Complete Stage Sequences
-- Unit 1: Hello & Identity (Lessons 1-4)

DO $$
DECLARE
  v_lesson_id UUID;
BEGIN

  -- ============ LESSON 1: Professional Greetings & Names ============
  SELECT id INTO v_lesson_id FROM lessons WHERE lesson_code = 'A0-U1-L1' LIMIT 1;
  IF v_lesson_id IS NOT NULL THEN
    UPDATE lessons SET
      lesson_goal = 'Confidently greet a colleague and introduce yourself using the verb to be',
      success_criteria = jsonb_build_array(
        'Can use appropriate greetings (Hello, Hi, Good morning/afternoon)',
        'Can introduce yourself using "I am / I''m [Name]"',
        'Can state first and last name clearly',
        'Can pronounce greetings without adding extra vowel sounds'
      ),
      homework = jsonb_build_object(
        'title', 'Voice Introduction',
        'description', 'Record a 15-second voice note introducing yourself',
        'retrieval', 'Write 3 greetings you learned in Portuguese and English',
        'input', 'Write your introduction sentence: "I''m [Name]"',
        'output', 'Record and share your 15-second introduction',
        'estimated_minutes', 10
      )
    WHERE id = v_lesson_id;

    INSERT INTO lesson_stages (lesson_id, stage_type, title, instructions, timing_minutes, content, sort_order)
    VALUES
      (v_lesson_id, 'warm_up', 'Retrieval: What Do You Know About Greetings?', 'Think about Portuguese greetings and try to say them in English', 5,
        jsonb_build_object('objective', 'Activate prior knowledge', 'prompts', jsonb_build_array('Oi → ?', 'Bom dia → ?', 'Boa tarde → ?')), 0),
      (v_lesson_id, 'lead_in', 'The Hook: Real Meeting Scenario', 'You''re joining a global Zoom meeting. How would you introduce yourself?', 7,
        jsonb_build_object('scenario', 'Virtual meeting introduction', 'task', 'Try to introduce yourself now'), 1),
      (v_lesson_id, 'input', 'Learn: Professional Introductions', 'Use "I''m" + [Name] for confident introductions', 10,
        jsonb_build_object('key_point', 'Say "I''m Maria" not "My name is Maria"', 'examples', jsonb_build_array('I''m Maria', 'I''m Carlos Silva')), 2),
      (v_lesson_id, 'comprehension', 'Listen & Repeat: Model Introductions', 'Listen to professional introductions and identify key parts', 8,
        jsonb_build_object('task', 'Complete cloze exercises based on audio', 'audio_count', 5), 3),
      (v_lesson_id, 'focus_practice', 'Controlled Practice', 'Complete fill-in-the-blank and pronunciation exercises', 10,
        jsonb_build_object('exercises', jsonb_build_array('Greeting selection (5 scenarios)', 'Name pronunciation drills')), 4),
      (v_lesson_id, 'communicative_use', 'Role-Play: Meet a Colleague', 'Record yourself greeting and introducing yourself', 7,
        jsonb_build_object('task', 'Introduce yourself to a virtual colleague (recorded)', 'duration_seconds', 30), 5),
      (v_lesson_id, 'assignment', 'Performance Task: Video Introduction', 'Record a 30-second self-introduction video', 8,
        jsonb_build_object('task', 'Create a professional video introduction', 'duration_seconds', 30), 6),
      (v_lesson_id, 'reflection', 'Reflect on Your Learning', 'Think about what you learned and what still feels challenging', 5,
        jsonb_build_object('prompts', jsonb_build_array('What did you find easiest?', 'What needs more practice?')), 7);
  END IF;

  -- ============ LESSON 2: Meeting People & Politeness ============
  SELECT id INTO v_lesson_id FROM lessons WHERE lesson_code = 'A0-U1-L2' LIMIT 1;
  IF v_lesson_id IS NOT NULL THEN
    UPDATE lessons SET
      lesson_goal = 'Exchange basic information with new people and respond politely in meetings',
      success_criteria = jsonb_build_array(
        'Can ask "What''s your name?"',
        'Can respond with full name and role',
        'Can use "Nice to meet you"',
        'Can ask and answer simple "Where are you from?" questions'
      ),
      homework = jsonb_build_object(
        'title', 'Practice Exchange',
        'description', 'Write and record a brief conversation',
        'retrieval', 'List 5 polite phrases',
        'input', 'Write a short dialogue',
        'output', 'Record a 45-second conversation',
        'estimated_minutes', 15
      )
    WHERE id = v_lesson_id;

    INSERT INTO lesson_stages (lesson_id, stage_type, title, instructions, timing_minutes, content, sort_order)
    VALUES
      (v_lesson_id, 'warm_up', 'Retrieval: Question Words', 'Can you remember question words from previous lessons?', 5,
        jsonb_build_object('task', 'Match Portuguese questions to English'), 0),
      (v_lesson_id, 'lead_in', 'The Gap: Awkward Silence', 'You meet someone new. The greeting is over. Now what?', 7,
        jsonb_build_object('scenario', 'First time meeting a colleague'), 1),
      (v_lesson_id, 'input', 'Learn: Information Exchange Questions', 'How to ask and answer follow-up questions politely', 10,
        jsonb_build_object('patterns', jsonb_build_array('What''s your name? → I''m...', 'Where are you from? → I''m from...')), 2),
      (v_lesson_id, 'comprehension', 'Listen & Extract Information', 'Watch a conversation and fill in missing information', 8,
        jsonb_build_object('format', 'video dialogue'), 3),
      (v_lesson_id, 'focus_practice', 'Substitution & Response Drills', 'Practice responses with different information', 10,
        jsonb_build_object('activities', jsonb_build_array('Question-response pairs', 'Information slot fill')), 4),
      (v_lesson_id, 'communicative_use', 'Conversational Practice', 'Have a brief conversation with a partner (recorded)', 7,
        jsonb_build_object('prompts', jsonb_build_array('Greet', 'Ask about name', 'Ask about origin')), 5),
      (v_lesson_id, 'assignment', 'Record Your Conversation', 'Record a natural 1-minute conversation exchange', 8,
        jsonb_build_object('task', 'Full dialogue with greeting through information exchange'), 6),
      (v_lesson_id, 'reflection', 'What Was Natural?', 'Reflect on what felt authentic in your conversation', 5,
        jsonb_build_object('focus', 'Naturalness of response patterns'), 7);
  END IF;

  -- ============ LESSON 3: The Alphabet & Spelling ============
  SELECT id INTO v_lesson_id FROM lessons WHERE lesson_code = 'A0-U1-L3' LIMIT 1;
  IF v_lesson_id IS NOT NULL THEN
    UPDATE lessons SET
      lesson_goal = 'Spell and recognize English alphabet letters, especially for names and emails',
      success_criteria = jsonb_build_array(
        'Can pronounce all 26 letters correctly',
        'Can spell your name letter by letter',
        'Can spell email addresses and domain names',
        'Can understand when someone spells something for you'
      ),
      homework = jsonb_build_object(
        'title', 'Spelling Practice',
        'description', 'Listen and spell common words and names',
        'retrieval', 'Recall letter sounds',
        'input', 'Learn pronunciation of each letter',
        'output', 'Record yourself spelling 5 names',
        'estimated_minutes', 12
      )
    WHERE id = v_lesson_id;

    INSERT INTO lesson_stages (lesson_id, stage_type, title, instructions, timing_minutes, content, sort_order)
    VALUES
      (v_lesson_id, 'warm_up', 'Retrieval: Letter Sounds', 'Say the sounds of letters you see', 5,
        jsonb_build_object('format', 'visual letter recognition'), 0),
      (v_lesson_id, 'lead_in', 'The Problem: Email Confusion', 'Your colleague asks for your email. Can you spell it?', 7,
        jsonb_build_object('scenario', 'Workplace communication gap'), 1),
      (v_lesson_id, 'input', 'Learn: The English Alphabet', 'Hear and practice each letter with word examples', 12,
        jsonb_build_object('method', 'Audio-visual with word associations'), 2),
      (v_lesson_id, 'comprehension', 'Listening Discrimination', 'Identify and write letters you hear', 8,
        jsonb_build_object('task', 'Letter dictation exercises'), 3),
      (v_lesson_id, 'focus_practice', 'Alphabet Drills', 'Repeat and pronounce letters and spell common words', 10,
        jsonb_build_object('exercises', jsonb_build_array('Letter repetition', 'Name spelling', 'Word spelling')), 4),
      (v_lesson_id, 'communicative_use', 'Spelling Task', 'Spell your name and email for a listener', 7,
        jsonb_build_object('task', 'Record spelling 3 items'), 5),
      (v_lesson_id, 'assignment', 'Email Spelling Task', 'Spell your email address clearly for recording', 8,
        jsonb_build_object('format', 'Voice message format'), 6),
      (v_lesson_id, 'reflection', 'Letters You Find Hard', 'Which letters do you find most challenging?', 5,
        jsonb_build_object('reflection', 'Personal challenge letters'), 7);
  END IF;

  -- ============ LESSON 4: Contact Exchange ============
  SELECT id INTO v_lesson_id FROM lessons WHERE lesson_code = 'A0-U1-L4' LIMIT 1;
  IF v_lesson_id IS NOT NULL THEN
    UPDATE lessons SET
      lesson_goal = 'Exchange contact information professionally and accurately',
      success_criteria = jsonb_build_array(
        'Can ask for contact information politely',
        'Can give your phone number and email clearly',
        'Can spell email address on demand',
        'Can repeat back information to confirm accuracy'
      ),
      homework = jsonb_build_object(
        'title', 'Contact Exchange Recording',
        'description', 'Record a complete contact exchange interaction',
        'retrieval', 'Recall greetings and introductions',
        'input', 'Write your contact details in English',
        'output', 'Record yourself exchanging contact info',
        'estimated_minutes', 15
      )
    WHERE id = v_lesson_id;

    INSERT INTO lesson_stages (lesson_id, stage_type, title, instructions, timing_minutes, content, sort_order)
    VALUES
      (v_lesson_id, 'warm_up', 'Retrieval: Contact Words', 'What are the key words for contact exchange?', 5,
        jsonb_build_object('task', 'Match contact-related terms to definitions'), 0),
      (v_lesson_id, 'lead_in', 'The Situation: LinkedIn Connection', 'You meet someone at a conference. They ask for your contact info.', 7,
        jsonb_build_object('scenario', 'Professional networking'), 1),
      (v_lesson_id, 'input', 'Learn: Polite Contact Exchange', 'How to ask for and give contact information naturally', 10,
        jsonb_build_object('phrases', jsonb_build_array('Can I have your email?', 'What''s your phone number?', 'Here''s my contact')), 2),
      (v_lesson_id, 'comprehension', 'Listen & Understand Phone/Email', 'Identify contact details from audio dialogue', 8,
        jsonb_build_object('task', 'Fill in contact details from listening'), 3),
      (v_lesson_id, 'focus_practice', 'Controlled Exchanges', 'Practice giving and receiving contact information', 10,
        jsonb_build_object('activities', jsonb_build_array('Phone number repetition', 'Email dictation', 'Confirmation tasks')), 4),
      (v_lesson_id, 'communicative_use', 'Exchange with Partner', 'Have a complete contact exchange conversation', 7,
        jsonb_build_object('task', 'Full interaction with contact sharing'), 5),
      (v_lesson_id, 'assignment', 'Final Contact Exchange Recording', 'Record yourself in a complete contact exchange', 8,
        jsonb_build_object('format', 'Natural conversation recording'), 6),
      (v_lesson_id, 'reflection', 'Unit 1 Reflection', 'What did you learn in Unit 1? What''s still challenging?', 5,
        jsonb_build_object('prompts', jsonb_build_array('Most useful phrase?', 'Pronunciation challenges?', 'Ready for Unit 2?')), 7);
  END IF;

END $$;
