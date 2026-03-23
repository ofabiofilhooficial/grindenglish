-- Populate all 24 A0 lessons with complete pedagogical stage sequences
-- A0 Foundation: 6 units × 4 lessons = 24 lessons
-- Each lesson has 6-8 stages following: Warm-up → Lead-in → Input → Comprehension → Practice → Communicative Use → Assignment

DO $$
DECLARE
  v_lesson_id UUID;
  v_unit1_id UUID;
  v_unit2_id UUID;
  v_unit3_id UUID;
  v_unit4_id UUID;
  v_unit5_id UUID;
  v_unit6_id UUID;
BEGIN

  -- Get all unit IDs
  SELECT id INTO v_unit1_id FROM units WHERE level_id = (SELECT id FROM levels WHERE code = 'A0') AND position = 1 LIMIT 1;
  SELECT id INTO v_unit2_id FROM units WHERE level_id = (SELECT id FROM levels WHERE code = 'A0') AND position = 2 LIMIT 1;
  SELECT id INTO v_unit3_id FROM units WHERE level_id = (SELECT id FROM levels WHERE code = 'A0') AND position = 3 LIMIT 1;
  SELECT id INTO v_unit4_id FROM units WHERE level_id = (SELECT id FROM levels WHERE code = 'A0') AND position = 4 LIMIT 1;
  SELECT id INTO v_unit5_id FROM units WHERE level_id = (SELECT id FROM levels WHERE code = 'A0') AND position = 5 LIMIT 1;
  SELECT id INTO v_unit6_id FROM units WHERE level_id = (SELECT id FROM levels WHERE code = 'A0') AND position = 6 LIMIT 1;

  -- ============ UNIT 1: Hello & Identity (Lessons 1-4) ============

  -- Lesson 1: Professional Greetings & Names
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

  -- Lesson 2: Meeting People & Politeness
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

  -- Lesson 3: The Alphabet & Spelling
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

  -- Lesson 4: Contact Exchange
  SELECT id INTO v_lesson_id FROM lessons WHERE lesson_code = 'A0-U1-L4' LIMIT 1;
  IF v_lesson_id IS NOT NULL THEN
    UPDATE lessons SET
      lesson_goal = 'Exchange contact information accurately and professionally in English',
      success_criteria = jsonb_build_array(
        'Can exchange phone numbers clearly',
        'Can give and understand email addresses',
        'Can use "Could I have...?" politely',
        'Can confirm information ("Did you say...?")'
      ),
      homework = jsonb_build_object(
        'title', 'Contact Exchange Role-Play',
        'description', 'Full contact exchange dialogue',
        'retrieval', 'Review numbers and spelling',
        'input', 'Learn polite request phrases',
        'output', 'Record a contact exchange dialogue',
        'estimated_minutes', 15
      )
    WHERE id = v_lesson_id;

    INSERT INTO lesson_stages (lesson_id, stage_type, title, instructions, timing_minutes, content, sort_order)
    VALUES
      (v_lesson_id, 'warm_up', 'Retrieval: Numbers & Spelling', 'Quick review of numbers and alphabet', 5,
        jsonb_build_object('format', 'mixed practice'), 0),
      (v_lesson_id, 'lead_in', 'The Authentic Need', 'End of meeting: exchanging contact details', 7,
        jsonb_build_object('scenario', 'Professional contact exchange'), 1),
      (v_lesson_id, 'input', 'Learn: Polite Requests & Confirmation', 'How to ask for and confirm contact info', 10,
        jsonb_build_object('phrases', jsonb_build_array('Could I have your email?', 'Did you say [number]?')), 2),
      (v_lesson_id, 'comprehension', 'Listen & Write Information', 'Hear contact details and write them down', 8,
        jsonb_build_object('task', 'Information dictation'), 3),
      (v_lesson_id, 'focus_practice', 'Structured Practice Exchanges', 'Complete guided exchanges with substitution', 10,
        jsonb_build_object('format', 'controlled dialogue'), 4),
      (v_lesson_id, 'communicative_use', 'Partner Exchange', 'Exchange real contact info with a partner (recorded)', 7,
        jsonb_build_object('task', 'Authentic information exchange'), 5),
      (v_lesson_id, 'assignment', 'Full Contact Exchange', 'Record complete exchange from greeting to contact details', 8,
        jsonb_build_object('duration_seconds', 120), 6),
      (v_lesson_id, 'reflection', 'Unit Reflection', 'What was your biggest breakthrough in Unit 1?', 5,
        jsonb_build_object('scope', 'Unit 1 overall achievement'), 7);
  END IF;

  -- ============ UNIT 2: Numbers, Time & Dates (Lessons 5-8) ============

  -- Lesson 5: Numbers 0-20
  SELECT id INTO v_lesson_id FROM lessons WHERE lesson_code = 'A0-U2-L1' LIMIT 1;
  IF v_lesson_id IS NOT NULL THEN
    UPDATE lessons SET
      lesson_goal = 'Confidently understand and produce numbers 0-20 in spoken and written English',
      success_criteria = jsonb_build_array(
        'Can count from 0 to 20 clearly',
        'Can recognize numbers when heard',
        'Can distinguish similar sounding numbers (13/30, 14/40)',
        'Can use numbers in context (phone numbers, ages)'
      ),
      homework = jsonb_build_object(
        'title', 'Number Recognition & Production',
        'description', 'Hear, recognize, and produce numbers 0-20',
        'retrieval', 'Count in your first language',
        'input', 'Learn English number system',
        'output', 'Record yourself saying and dictating numbers',
        'estimated_minutes', 12
      )
    WHERE id = v_lesson_id;

    INSERT INTO lesson_stages (lesson_id, stage_type, title, instructions, timing_minutes, content, sort_order)
    VALUES
      (v_lesson_id, 'warm_up', 'Retrieval: Counting at Home', 'Count from 0-10 in English if you can remember', 5,
        jsonb_build_object('task', 'Initial attempt count'), 0),
      (v_lesson_id, 'lead_in', 'Real Use: Phone Numbers & Codes', 'Why do you need numbers? Workplaces use them constantly', 7,
        jsonb_build_object('context', 'Professional necessity for numbers'), 1),
      (v_lesson_id, 'input', 'Learn: Numbers 0-20 System', 'Understand the pattern and pronunciation of English numbers', 12,
        jsonb_build_object('method', 'Grouped instruction with pronunciation focus'), 2),
      (v_lesson_id, 'comprehension', 'Listen & Identify Numbers', 'Hear numbers in sequence and write them down', 8,
        jsonb_build_object('format', 'number dictation'), 3),
      (v_lesson_id, 'focus_practice', 'Number Discrimination & Repetition', 'Distinguish similar numbers and practice rhythm', 10,
        jsonb_build_object('focus', 'Particularly 13/30, 14/40, 15/50'), 4),
      (v_lesson_id, 'communicative_use', 'Number Production Task', 'Say numbers in response to prompts (recorded)', 7,
        jsonb_build_object('task', 'Random number production'), 5),
      (v_lesson_id, 'assignment', 'Phone Number Exchange', 'Record yourself saying your phone number clearly', 8,
        jsonb_build_object('context', 'Professional context'), 6),
      (v_lesson_id, 'reflection', 'Confidence with Numbers', 'Which numbers still feel awkward to say?', 5,
        jsonb_build_object('self_assessment', 'Personal difficulty areas'), 7);
  END IF;

  -- Lesson 6: Telling Time
  SELECT id INTO v_lesson_id FROM lessons WHERE lesson_code = 'A0-U2-L2' LIMIT 1;
  IF v_lesson_id IS NOT NULL THEN
    UPDATE lessons SET
      lesson_goal = 'Tell and understand time accurately in English',
      success_criteria = jsonb_build_array(
        'Can tell time with hours and minutes',
        'Can use "quarter past", "half past", "quarter to"',
        'Can understand time in both 12-hour and 24-hour formats',
        'Can use "It''s..." for telling time'
      ),
      homework = jsonb_build_object(
        'title', 'Time Telling Practice',
        'description', 'Understand and produce times throughout the day',
        'retrieval', 'Recall numbers 0-60',
        'input', 'Learn time expression patterns',
        'output', 'Record yourself telling times',
        'estimated_minutes', 15
      )
    WHERE id = v_lesson_id;

    INSERT INTO lesson_stages (lesson_id, stage_type, title, instructions, timing_minutes, content, sort_order)
    VALUES
      (v_lesson_id, 'warm_up', 'Retrieval: Clock Reading', 'What time do you start work? Can you say it in English?', 5,
        jsonb_build_object('personal_connection', 'Personal schedule'), 0),
      (v_lesson_id, 'lead_in', 'The Need: Meeting Scheduling', 'Your boss says "Meet me at 2:30." Can you understand?', 7,
        jsonb_build_object('context', 'Professional meeting scenario'), 1),
      (v_lesson_id, 'input', 'Learn: Telling Time in English', 'Hour/minute patterns, quarter and half constructions', 12,
        jsonb_build_object('focus', 'Both analog and digital expressions'), 2),
      (v_lesson_id, 'comprehension', 'Listen & Write Times', 'Hear times spoken and write them', 8,
        jsonb_build_object('format', 'time dictation'), 3),
      (v_lesson_id, 'focus_practice', 'Time Expression Drills', 'Say times shown on clocks', 10,
        jsonb_build_object('variation', 'Different clock formats'), 4),
      (v_lesson_id, 'communicative_use', 'Real-Time Production', 'Tell times in conversation flow', 7,
        jsonb_build_object('task', 'Respond to "What time is it?"'), 5),
      (v_lesson_id, 'assignment', 'Record Your Daily Schedule', 'Record your daily schedule with accurate times', 8,
        jsonb_build_object('scope', 'Your typical day'), 6),
      (v_lesson_id, 'reflection', 'Time Sense Check', 'Do 24-hour or 12-hour formats feel more natural?', 5,
        jsonb_build_object('format_preference', 'Personal learning'), 7);
  END IF;

  -- Lesson 7: Days, Months, Dates
  SELECT id INTO v_lesson_id FROM lessons WHERE lesson_code = 'A0-U2-L3' LIMIT 1;
  IF v_lesson_id IS NOT NULL THEN
    UPDATE lessons SET
      lesson_goal = 'Understand and produce days, months, and dates in professional contexts',
      success_criteria = jsonb_build_array(
        'Can name all 7 days of the week',
        'Can name all 12 months',
        'Can say dates (March 5th, 1995)',
        'Can understand and write dates in various formats'
      ),
      homework = jsonb_build_object(
        'title', 'Calendar & Schedule Practice',
        'description', 'Work with dates and calendar information',
        'retrieval', 'Know days and months in your language',
        'input', 'Learn English calendar terms',
        'output', 'Record your important dates',
        'estimated_minutes', 12
      )
    WHERE id = v_lesson_id;

    INSERT INTO lesson_stages (lesson_id, stage_type, title, instructions, timing_minutes, content, sort_order)
    VALUES
      (v_lesson_id, 'warm_up', 'Retrieval: What Day Is Today?', 'Try to say today''s day of the week', 5,
        jsonb_build_object('personal', 'Awareness of current day'), 0),
      (v_lesson_id, 'lead_in', 'The Scenario: Meeting Scheduling', 'Your boss says "Let''s meet on March 5th"', 7,
        jsonb_build_object('context', 'Scheduling situation'), 1),
      (v_lesson_id, 'input', 'Learn: Days, Months, and Dates', 'Calendar vocabulary and date expression patterns', 10,
        jsonb_build_object('scope', 'Complete calendar system'), 2),
      (v_lesson_id, 'comprehension', 'Listen & Write Dates', 'Hear dates and write them in English format', 8,
        jsonb_build_object('format', 'date dictation'), 3),
      (v_lesson_id, 'focus_practice', 'Calendar Drills', 'Practice week and month sequences, date patterns', 10,
        jsonb_build_object('focus', 'Memorization and rhythm'), 4),
      (v_lesson_id, 'communicative_use', 'Date Production', 'Say dates in conversational context', 7,
        jsonb_build_object('task', 'Respond to date questions'), 5),
      (v_lesson_id, 'assignment', 'Record Important Dates', 'Record 5 important personal dates with explanation', 8,
        jsonb_build_object('context', 'Meaningful personal dates'), 6),
      (v_lesson_id, 'reflection', 'Memory Anchors', 'How do you remember the months and days?', 5,
        jsonb_build_object('metacognition', 'Learning strategies'), 7);
  END IF;

  -- Lesson 8: Prepositions of Time (on/in/at)
  SELECT id INTO v_lesson_id FROM lessons WHERE lesson_code = 'A0-U2-L4' LIMIT 1;
  IF v_lesson_id IS NOT NULL THEN
    UPDATE lessons SET
      lesson_goal = 'Use prepositions of time (on, in, at) accurately for scheduling and planning',
      success_criteria = jsonb_build_array(
        'Can use "on" with specific days and dates',
        'Can use "in" with months and years',
        'Can use "at" with specific times',
        'Can combine time expressions in complete sentences'
      ),
      homework = jsonb_build_object(
        'title', 'Preposition Application',
        'description', 'Write and speak about scheduling',
        'retrieval', 'Recall days, months, times',
        'input', 'Learn preposition rules',
        'output', 'Create sentences with prepositions',
        'estimated_minutes', 12
      )
    WHERE id = v_lesson_id;

    INSERT INTO lesson_stages (lesson_id, stage_type, title, instructions, timing_minutes, content, sort_order)
    VALUES
      (v_lesson_id, 'warm_up', 'Retrieval: When and Where', 'Think about time words: on, in, at - how are they different?', 5,
        jsonb_build_object('reflection', 'Intuitive pattern finding'), 0),
      (v_lesson_id, 'lead_in', 'The Issue: Speaking Incorrectly', 'Portuguese doesn''t distinguish these; English does', 7,
        jsonb_build_object('context', 'Cross-linguistic difficulty'), 1),
      (v_lesson_id, 'input', 'Learn: When to Use on/in/at', 'Clear rules and patterns for time prepositions', 10,
        jsonb_build_object('method', 'Rule-based with examples'), 2),
      (v_lesson_id, 'comprehension', 'Listen & Choose Preposition', 'Hear sentences and identify the correct preposition', 8,
        jsonb_build_object('format', 'multiple choice listening'), 3),
      (v_lesson_id, 'focus_practice', 'Preposition Substitution', 'Complete sentences with correct prepositions', 10,
        jsonb_build_object('format', 'fill-in-the-blank'), 4),
      (v_lesson_id, 'communicative_use', 'Sentence Creation', 'Create sentences about your schedule (recorded)', 7,
        jsonb_build_object('task', 'Spontaneous sentence production'), 5),
      (v_lesson_id, 'assignment', 'Your Weekly Schedule', 'Record your schedule using on/in/at correctly', 8,
        jsonb_build_object('context', 'Personal weekly activities'), 6),
      (v_lesson_id, 'reflection', 'Unit 2 Summary', 'What was your biggest learning about time in English?', 5,
        jsonb_build_object('synthesis', 'Unit-level reflection'), 7);
  END IF;

  -- ============ UNIT 3: My World - Home & Objects (Lessons 9-12) ============

  -- Lesson 9: Rooms in a House
  SELECT id INTO v_lesson_id FROM lessons WHERE lesson_code = 'A0-U3-L1' LIMIT 1;
  IF v_lesson_id IS NOT NULL THEN
    UPDATE lessons SET
      lesson_goal = 'Name and describe rooms in a house accurately',
      success_criteria = jsonb_build_array(
        'Can name 8-10 common rooms',
        'Can use "There is/are" for rooms',
        'Can describe what you do in each room',
        'Can understand room descriptions'
      ),
      homework = jsonb_build_object(
        'title', 'Your Home Description',
        'description', 'Describe rooms in your home',
        'retrieval', 'Think about rooms you know',
        'input', 'Learn room vocabulary',
        'output', 'Describe your home',
        'estimated_minutes', 12
      )
    WHERE id = v_lesson_id;

    INSERT INTO lesson_stages (lesson_id, stage_type, title, instructions, timing_minutes, content, sort_order)
    VALUES
      (v_lesson_id, 'warm_up', 'Retrieval: Draw Your Home', 'Draw your home and label rooms in your language', 5,
        jsonb_build_object('activation', 'Visual and conceptual'), 0),
      (v_lesson_id, 'lead_in', 'The Gap: Describing Your Place', 'A colleague asks: "Do you have an office at home?"', 7,
        jsonb_build_object('context', 'Remote work scenario'), 1),
      (v_lesson_id, 'input', 'Learn: Rooms & Furniture Introduction', 'Room names and basic furniture vocabulary', 10,
        jsonb_build_object('scope', 'Essential room vocabulary'), 2),
      (v_lesson_id, 'comprehension', 'Listen & Identify Rooms', 'Hear descriptions and identify which room', 8,
        jsonb_build_object('format', 'identification task'), 3),
      (v_lesson_id, 'focus_practice', 'Room Vocabulary Drills', 'Say room names and match to activities', 10,
        jsonb_build_object('focus', 'Memorization and association'), 4),
      (v_lesson_id, 'communicative_use', 'Describe Your Room', 'Describe your workspace (recorded)', 7,
        jsonb_build_object('task', 'Personal space description'), 5),
      (v_lesson_id, 'assignment', 'Home Tour Description', 'Record a description of 5 rooms in your home', 8,
        jsonb_build_object('scope', 'Full home description'), 6),
      (v_lesson_id, 'reflection', 'Room-Activity Connections', 'Which room vocabulary will be most useful?', 5,
        jsonb_build_object('relevance', 'Personal usefulness'), 7);
  END IF;

  -- Lesson 10: Furniture & Objects
  SELECT id INTO v_lesson_id FROM lessons WHERE lesson_code = 'A0-U3-L2' LIMIT 1;
  IF v_lesson_id IS NOT NULL THEN
    UPDATE lessons SET
      lesson_goal = 'Name common household furniture and objects in English',
      success_criteria = jsonb_build_array(
        'Can name 15+ pieces of furniture',
        'Can describe what furniture is used for',
        'Can use countable/uncountable concepts',
        'Can understand furniture descriptions'
      ),
      homework = jsonb_build_object(
        'title', 'Furniture Inventory',
        'description', 'Identify and describe furniture',
        'retrieval', 'Name items you see around you',
        'input', 'Learn furniture vocabulary',
        'output', 'Describe your room''s furniture',
        'estimated_minutes', 13
      )
    WHERE id = v_lesson_id;

    INSERT INTO lesson_stages (lesson_id, stage_type, title, instructions, timing_minutes, content, sort_order)
    VALUES
      (v_lesson_id, 'warm_up', 'Retrieval: Spot the Object', 'Look around - how many objects can you name in English?', 5,
        jsonb_build_object('environmental', 'Real-time vocabulary'), 0),
      (v_lesson_id, 'lead_in', 'Real Context: Describing Your Space', 'You need to order furniture online; descriptions help', 7,
        jsonb_build_object('practical', 'E-commerce context'), 1),
      (v_lesson_id, 'input', 'Learn: Household Furniture & Objects', 'Common furniture, materials, and uses', 11,
        jsonb_build_object('scope', 'Comprehensive furniture vocabulary'), 2),
      (v_lesson_id, 'comprehension', 'Listen & Write Furniture Names', 'Hear descriptions and write the object name', 8,
        jsonb_build_object('format', 'dictation-based'), 3),
      (v_lesson_id, 'focus_practice', 'Object Description Practice', 'Match pictures to descriptions', 10,
        jsonb_build_object('activity', 'Visual-verbal matching'), 4),
      (v_lesson_id, 'communicative_use', 'Describe Your Workspace', 'Describe furniture and objects you use (recorded)', 7,
        jsonb_build_object('task', 'Workspace description'), 5),
      (v_lesson_id, 'assignment', 'Room Layout Description', 'Describe the furniture arrangement in your room', 8,
        jsonb_build_object('complexity', 'Spatial relationships'), 6),
      (v_lesson_id, 'reflection', 'Vocabulary Consolidation', 'Which furniture words feel most natural to you?', 5,
        jsonb_build_object('metacognition', 'Personal learning'), 7);
  END IF;

  -- Lesson 11: "There is/are" Structure
  SELECT id INTO v_lesson_id FROM lessons WHERE lesson_code = 'A0-U3-L3' LIMIT 1;
  IF v_lesson_id IS NOT NULL THEN
    UPDATE lessons SET
      lesson_goal = 'Use "There is/are" to describe what exists in spaces',
      success_criteria = jsonb_build_array(
        'Can form "There is/are" statements correctly',
        'Can make questions with "Is there...?" "Are there...?"',
        'Can understand negative "There is no/are no" structures',
        'Can combine with prepositions for location'
      ),
      homework = jsonb_build_object(
        'title', 'Space Description with There is/are',
        'description', 'Describe existence and location of objects',
        'retrieval', 'Review furniture vocabulary',
        'input', 'Learn there is/are structures',
        'output', 'Create and record sentences',
        'estimated_minutes', 12
      )
    WHERE id = v_lesson_id;

    INSERT INTO lesson_stages (lesson_id, stage_type, title, instructions, timing_minutes, content, sort_order)
    VALUES
      (v_lesson_id, 'warm_up', 'Retrieval: What''s in This Room?', 'Look at a picture - can you name objects?', 5,
        jsonb_build_object('visual', 'Picture-based activation'), 0),
      (v_lesson_id, 'lead_in', 'The Structure Need', 'How do you say what exists in your office?', 7,
        jsonb_build_object('functional', 'Need for existence expression'), 1),
      (v_lesson_id, 'input', 'Learn: There is/are Structure', 'Formation, negation, questions with emphasis on be-agreement', 10,
        jsonb_build_object('grammar', 'Subject-verb agreement focus'), 2),
      (v_lesson_id, 'comprehension', 'Listen & Identify True/False', 'Hear descriptions and judge truth value', 8,
        jsonb_build_object('format', 'comprehension check'), 3),
      (v_lesson_id, 'focus_practice', 'Form & Respond Practice', 'Create "there is/are" sentences and ask questions', 10,
        jsonb_build_object('activities', jsonb_build_array('Sentence formation', 'Question response')), 4),
      (v_lesson_id, 'communicative_use', 'Describe & Question', 'Make statements and ask about location (recorded)', 7,
        jsonb_build_object('task', 'Q&A about surroundings'), 5),
      (v_lesson_id, 'assignment', 'Describe Your Actual Office', 'Record description of your actual workspace using "there is/are"', 8,
        jsonb_build_object('authentic', 'Real office description'), 6),
      (v_lesson_id, 'reflection', 'Structure Confidence', 'Does this structure feel natural yet?', 5,
        jsonb_build_object('self_assessment', 'Comfort with structure'), 7);
  END IF;

  -- Lesson 12: Prepositions of Place
  SELECT id INTO v_lesson_id FROM lessons WHERE lesson_code = 'A0-U3-L4' LIMIT 1;
  IF v_lesson_id IS NOT NULL THEN
    UPDATE lessons SET
      lesson_goal = 'Use prepositions of place to describe object locations accurately',
      success_criteria = jsonb_build_array(
        'Can use in, on, under, next to, between, in front of',
        'Can understand spatial descriptions',
        'Can combine prepositions with furniture',
        'Can ask and answer "Where is...?" questions'
      ),
      homework = jsonb_build_object(
        'title', 'Location Description',
        'description', 'Describe where objects are located',
        'retrieval', 'Recall furniture and objects',
        'input', 'Learn prepositions of place',
        'output', 'Create location descriptions',
        'estimated_minutes', 13
      )
    WHERE id = v_lesson_id;

    INSERT INTO lesson_stages (lesson_id, stage_type, title, instructions, timing_minutes, content, sort_order)
    VALUES
      (v_lesson_id, 'warm_up', 'Retrieval: Show Me the Location', 'Point and try to describe where things are', 5,
        jsonb_build_object('physical', 'Gesture-based activation'), 0),
      (v_lesson_id, 'lead_in', 'The Need: Finding Things in Office', 'Boss asks: "Where is the projector?"', 7,
        jsonb_build_object('functional', 'Workplace necessity'), 1),
      (v_lesson_id, 'input', 'Learn: Common Prepositions of Place', 'in, on, under, next to, between, in front of, behind', 11,
        jsonb_build_object('focus', 'Spatial relationships'), 2),
      (v_lesson_id, 'comprehension', 'Listen & Point or Draw', 'Hear location descriptions and identify object placement', 8,
        jsonb_build_object('format', 'mapping/visual'), 3),
      (v_lesson_id, 'focus_practice', 'Preposition Substitution Drills', 'Complete sentences with location prepositions', 10,
        jsonb_build_object('format', 'fill-in-blank'), 4),
      (v_lesson_id, 'communicative_use', 'Question & Answer About Location', 'Ask and answer "Where is...?" with prepositions (recorded)', 7,
        jsonb_build_object('format', 'dialogue'), 5),
      (v_lesson_id, 'assignment', 'Describe Your Office Layout', 'Record a complete description of your office with locations', 8,
        jsonb_build_object('scope', 'Full office spatial description'), 6),
      (v_lesson_id, 'reflection', 'Unit 3 Synthesis', 'Can you now fully describe your home or office?', 5,
        jsonb_build_object('synthesis', 'Unit-level integration'), 7);
  END IF;

  -- ============ UNIT 4: Daily Routines (Lessons 13-16) ============

  -- Lesson 13: Routine Verbs
  SELECT id INTO v_lesson_id FROM lessons WHERE lesson_code = 'A0-U4-L1' LIMIT 1;
  IF v_lesson_id IS NOT NULL THEN
    UPDATE lessons SET
      lesson_goal = 'Name and use verbs for common daily activities',
      success_criteria = jsonb_build_array(
        'Can name 12+ routine action verbs',
        'Can describe your morning routine',
        'Can understand others'' daily activities',
        'Can use verbs with "I" form correctly'
      ),
      homework = jsonb_build_object(
        'title', 'My Daily Routine Vocabulary',
        'description', 'Record and describe your daily activities',
        'retrieval', 'Think of your morning activities',
        'input', 'Learn routine action verbs',
        'output', 'Describe your complete routine',
        'estimated_minutes', 12
      )
    WHERE id = v_lesson_id;

    INSERT INTO lesson_stages (lesson_id, stage_type, title, instructions, timing_minutes, content, sort_order)
    VALUES
      (v_lesson_id, 'warm_up', 'Retrieval: Mime Your Morning', 'Mime your morning routine - can you name the actions?', 5,
        jsonb_build_object('kinesthetic', 'Physical activation'), 0),
      (v_lesson_id, 'lead_in', 'Why This Matters', 'Colleague asks: "What do you do first in the morning?"', 7,
        jsonb_build_object('social', 'Small talk scenario'), 1),
      (v_lesson_id, 'input', 'Learn: Common Routine Verbs', 'wake up, get up, brush teeth, have breakfast, etc.', 10,
        jsonb_build_object('scope', 'Complete morning/evening sequence'), 2),
      (v_lesson_id, 'comprehension', 'Listen & Sequence Activities', 'Hear routine description and put actions in order', 8,
        jsonb_build_object('format', 'sequencing task'), 3),
      (v_lesson_id, 'focus_practice', 'Verb Repetition & Context', 'Say verbs and use them in simple sentences', 10,
        jsonb_build_object('format', 'drilling with context'), 4),
      (v_lesson_id, 'communicative_use', 'Describe Your Morning', 'Tell your routine in sequence (recorded)', 7,
        jsonb_build_object('task', 'Personal routine narrative'), 5),
      (v_lesson_id, 'assignment', 'Complete Routine Description', 'Record your full morning or evening routine (2 minutes)', 8,
        jsonb_build_object('scope', 'Extended narrative'), 6),
      (v_lesson_id, 'reflection', 'Verb Familiarity', 'Which routine verbs feel most natural?', 5,
        jsonb_build_object('reflection', 'Personal learning'), 7);
  END IF;

  -- Lesson 14: Simple Present for Routines
  SELECT id INTO v_lesson_id FROM lessons WHERE lesson_code = 'A0-U4-L2' LIMIT 1;
  IF v_lesson_id IS NOT NULL THEN
    UPDATE lessons SET
      lesson_goal = 'Form and use Simple Present tense for habitual actions',
      success_criteria = jsonb_build_array(
        'Can conjugate regular verbs in Simple Present',
        'Can use with "I, you, we, they"',
        'Can form questions and negatives',
        'Can understand others'' routines in Simple Present'
      ),
      homework = jsonb_build_object(
        'title', 'My Simple Present Routine',
        'description', 'Write and record sentences about what you do daily',
        'retrieval', 'Recall routine verbs',
        'input', 'Learn Simple Present formation',
        'output', 'Create and record statements',
        'estimated_minutes', 13
      )
    WHERE id = v_lesson_id;

    INSERT INTO lesson_stages (lesson_id, stage_type, title, instructions, timing_minutes, content, sort_order)
    VALUES
      (v_lesson_id, 'warm_up', 'Retrieval: What Do You Do Daily?', 'Try to say some of your daily activities', 5,
        jsonb_build_object('activation', 'Intuitive attempt'), 0),
      (v_lesson_id, 'lead_in', 'Grammar Awareness', 'Notice the structure: "I wake up at 7. I eat breakfast."', 7,
        jsonb_build_object('attention', 'Pattern recognition'), 1),
      (v_lesson_id, 'input', 'Learn: Simple Present Formation', 'Base form patterns for I/you/we/they with rule for he/she/it', 11,
        jsonb_build_object('focus', 'Verb conjugation patterns'), 2),
      (v_lesson_id, 'comprehension', 'Listen & Identify Verb Forms', 'Hear sentences and identify the base verb', 8,
        jsonb_build_object('format', 'listening discrimination'), 3),
      (v_lesson_id, 'focus_practice', 'Form Simple Present Sentences', 'Create sentences with given verbs and subjects', 10,
        jsonb_build_object('format', 'structured production'), 4),
      (v_lesson_id, 'communicative_use', 'Tell Your Routine in Present Tense', 'Describe what you do regularly (recorded)', 7,
        jsonb_build_object('task', 'Habitual action description'), 5),
      (v_lesson_id, 'assignment', 'My Typical Day Narrative', 'Record a complete description of a typical day using Simple Present', 8,
        jsonb_build_object('complexity', 'Extended narrative'), 6),
      (v_lesson_id, 'reflection', 'Tense Comfort Level', 'Does Simple Present feel natural for your routine?', 5,
        jsonb_build_object('reflection', 'Grammar comfort'), 7);
  END IF;

  -- Lesson 15: Question Formation & Responses
  SELECT id INTO v_lesson_id FROM lessons WHERE lesson_code = 'A0-U4-L3' LIMIT 1;
  IF v_lesson_id IS NOT NULL THEN
    UPDATE lessons SET
      lesson_goal = 'Ask and answer questions about daily routines accurately',
      success_criteria = jsonb_build_array(
        'Can form "Do you...?" and "What do you...?" questions',
        'Can answer yes/no and open questions',
        'Can use follow-up questions naturally',
        'Can understand routine questions from native speakers'
      ),
      homework = jsonb_build_object(
        'title', 'Routine Interview',
        'description', 'Ask and answer routine questions',
        'retrieval', 'Recall your routine and Simple Present',
        'input', 'Learn question word order',
        'output', 'Conduct a routine Q&A',
        'estimated_minutes', 14
      )
    WHERE id = v_lesson_id;

    INSERT INTO lesson_stages (lesson_id, stage_type, title, instructions, timing_minutes, content, sort_order)
    VALUES
      (v_lesson_id, 'warm_up', 'Retrieval: Can You Ask?', 'Try to ask someone: "Do you exercise?"', 5,
        jsonb_build_object('activation', 'Question attempt'), 0),
      (v_lesson_id, 'lead_in', 'Real Context: Getting to Know Colleagues', 'New coworker: "What time do you usually start work?"', 7,
        jsonb_build_object('context', 'Office small talk'), 1),
      (v_lesson_id, 'input', 'Learn: Question Formation', 'Word order for Do/Does questions, What/When questions', 11,
        jsonb_build_object('focus', 'Question structures and word order'), 2),
      (v_lesson_id, 'comprehension', 'Listen & Answer Questions', 'Hear routine questions and provide answers', 8,
        jsonb_build_object('format', 'Q&A comprehension'), 3),
      (v_lesson_id, 'focus_practice', 'Question & Short Answer Drills', 'Practice asking and answering routine questions', 10,
        jsonb_build_object('format', 'controlled dialogue'), 4),
      (v_lesson_id, 'communicative_use', 'Interview a Partner', 'Ask and record responses about their routine (recorded)', 7,
        jsonb_build_object('task', 'Authentic interview'), 5),
      (v_lesson_id, 'assignment', 'Full Routine Interview', 'Record yourself asking 5 routine questions and giving answers', 8,
        jsonb_build_object('scope', 'Complete Q&A sequence'), 6),
      (v_lesson_id, 'reflection', 'Question Confidence', 'Which question words feel most natural?', 5,
        jsonb_build_object('reflection', 'Personal learning'), 7);
  END IF;

  -- Lesson 16: Frequency Adverbs
  SELECT id INTO v_lesson_id FROM lessons WHERE lesson_code = 'A0-U4-L4' LIMIT 1;
  IF v_lesson_id IS NOT NULL THEN
    UPDATE lessons SET
      lesson_goal = 'Use frequency adverbs to describe how often you do things',
      success_criteria = jsonb_build_array(
        'Can use always, usually, often, sometimes, never correctly',
        'Can place frequency adverbs in sentences correctly',
        'Can ask and answer frequency questions',
        'Can understand frequency descriptions'
      ),
      homework = jsonb_build_object(
        'title', 'My Frequency of Activities',
        'description', 'Describe how often you do various activities',
        'retrieval', 'Recall routine verbs and Simple Present',
        'input', 'Learn frequency adverb placement',
        'output', 'Create frequency-marked routine descriptions',
        'estimated_minutes', 13
      )
    WHERE id = v_lesson_id;

    INSERT INTO lesson_stages (lesson_id, stage_type, title, instructions, timing_minutes, content, sort_order)
    VALUES
      (v_lesson_id, 'warm_up', 'Retrieval: How Often Do You...?', 'Think about how often you exercise or read', 5,
        jsonb_build_object('reflection', 'Personal frequency awareness'), 0),
      (v_lesson_id, 'lead_in', 'The Need: Nuancing Your Routine', 'You don''t do everything at the same frequency', 7,
        jsonb_build_object('context', 'Realistic routine description'), 1),
      (v_lesson_id, 'input', 'Learn: Frequency Adverbs & Placement', 'always/usually/often/sometimes/never and their position in sentences', 10,
        jsonb_build_object('focus', 'Adverb placement rules'), 2),
      (v_lesson_id, 'comprehension', 'Listen & Identify Frequency', 'Hear routine descriptions and identify frequency markers', 8,
        jsonb_build_object('format', 'listening discrimination'), 3),
      (v_lesson_id, 'focus_practice', 'Frequency Adverb Placement', 'Complete sentences with correct adverb placement', 10,
        jsonb_build_object('format', 'sentence building'), 4),
      (v_lesson_id, 'communicative_use', 'Describe Your Real Frequency', 'Describe how often you actually do things (recorded)', 7,
        jsonb_build_object('task', 'Authentic frequency description'), 5),
      (v_lesson_id, 'assignment', 'Realistic Routine with Frequency', 'Record description of your actual routine with frequency markers', 8,
        jsonb_build_object('authenticity', 'True frequency patterns'), 6),
      (v_lesson_id, 'reflection', 'Unit 4 Review', 'Can you now describe and discuss your routine fully?', 5,
        jsonb_build_object('synthesis', 'Unit-level integration'), 7);
  END IF;

  -- ============ UNIT 5: Shopping Basics (Lessons 17-20) ============

  -- Lesson 17: Shopping Vocabulary
  SELECT id INTO v_lesson_id FROM lessons WHERE lesson_code = 'A0-U5-L1' LIMIT 1;
  IF v_lesson_id IS NOT NULL THEN
    UPDATE lessons SET
      lesson_goal = 'Use shopping vocabulary accurately in store contexts',
      success_criteria = jsonb_build_array(
        'Can name common items in stores',
        'Can understand prices and quantities',
        'Can use shopping-related verbs (buy, sell, cost)',
        'Can understand basic shopping transactions'
      ),
      homework = jsonb_build_object(
        'title', 'My Shopping List',
        'description', 'Create and speak about shopping lists',
        'retrieval', 'Think of items you buy regularly',
        'input', 'Learn shopping vocabulary and prices',
        'output', 'Record your shopping list and prices',
        'estimated_minutes', 12
      )
    WHERE id = v_lesson_id;

    INSERT INTO lesson_stages (lesson_id, stage_type, title, instructions, timing_minutes, content, sort_order)
    VALUES
      (v_lesson_id, 'warm_up', 'Retrieval: What Do You Buy?', 'Think of 5 items you regularly purchase', 5,
        jsonb_build_object('personal', 'Shopping experience recall'), 0),
      (v_lesson_id, 'lead_in', 'The Scenario: Online Shopping', 'You need to order items in English online', 7,
        jsonb_build_object('context', 'E-commerce scenario'), 1),
      (v_lesson_id, 'input', 'Learn: Shopping Vocabulary', 'Common items, store types, shopping verbs, payment terms', 10,
        jsonb_build_object('scope', 'Comprehensive shopping vocabulary'), 2),
      (v_lesson_id, 'comprehension', 'Listen & Match Products', 'Hear product descriptions and identify items', 8,
        jsonb_build_object('format', 'product identification'), 3),
      (v_lesson_id, 'focus_practice', 'Shopping Dialog Drills', 'Practice asking for items and quantities', 10,
        jsonb_build_object('format', 'transactional dialogues'), 4),
      (v_lesson_id, 'communicative_use', 'Describe Your Shopping', 'Tell what you buy regularly (recorded)', 7,
        jsonb_build_object('task', 'Personal shopping habits'), 5),
      (v_lesson_id, 'assignment', 'My Shopping Preferences', 'Record a shopping preference statement (3 items with preferences)', 8,
        jsonb_build_object('scope', 'Personal shopping profile'), 6),
      (v_lesson_id, 'reflection', 'Shopping Comfort', 'Do you feel ready to shop for these items in English?', 5,
        jsonb_build_object('confidence', 'Self-assessment'), 7);
  END IF;

  -- Lesson 18: Prices & Quantities
  SELECT id INTO v_lesson_id FROM lessons WHERE lesson_code = 'A0-U5-L2' LIMIT 1;
  IF v_lesson_id IS NOT NULL THEN
    UPDATE lessons SET
      lesson_goal = 'Understand and use prices, quantities, and measurement terms in shopping',
      success_criteria = jsonb_build_array(
        'Can say and understand prices in English',
        'Can use quantity expressions (dozen, liter, kilo)',
        'Can ask about prices ("How much...?")',
        'Can understand discounts and special offers'
      ),
      homework = jsonb_build_object(
        'title', 'Shopping Price Awareness',
        'description', 'Gather and speak about prices',
        'retrieval', 'Recall numbers and shopping items',
        'input', 'Learn price expressions and quantities',
        'output', 'Record prices and quantities of items',
        'estimated_minutes', 13
      )
    WHERE id = v_lesson_id;

    INSERT INTO lesson_stages (lesson_id, stage_type, title, instructions, timing_minutes, content, sort_order)
    VALUES
      (v_lesson_id, 'warm_up', 'Retrieval: Price Awareness', 'Think of prices of 3 items you buy - can you say them in English?', 5,
        jsonb_build_object('activation', 'Price recall'), 0),
      (v_lesson_id, 'lead_in', 'Real Context: Budget Shopping', 'You need to calculate if you can afford items', 7,
        jsonb_build_object('functional', 'Real-world necessity'), 1),
      (v_lesson_id, 'input', 'Learn: Prices & Quantity Expressions', 'How to say prices, units of measurement, comparisons', 11,
        jsonb_build_object('focus', 'Transactional language'), 2),
      (v_lesson_id, 'comprehension', 'Listen & Write Prices', 'Hear prices and product descriptions and write details', 8,
        jsonb_build_object('format', 'dictation'), 3),
      (v_lesson_id, 'focus_practice', 'Price Questions & Responses', 'Practice asking and answering about prices and quantities', 10,
        jsonb_build_object('format', 'Q&A drills'), 4),
      (v_lesson_id, 'communicative_use', 'Negotiate or Compare Prices', 'Ask about and compare prices (recorded)', 7,
        jsonb_build_object('task', 'Price comparison dialogue'), 5),
      (v_lesson_id, 'assignment', 'Shopping List with Prices', 'Record your shopping list with quantities and prices', 8,
        jsonb_build_object('scope', 'Complete shopping transaction'), 6),
      (v_lesson_id, 'reflection', 'Transaction Readiness', 'Could you now shop in English?', 5,
        jsonb_build_object('confidence', 'Practical readiness'), 7);
  END IF;

  -- Lesson 19: Polite Requests
  SELECT id INTO v_lesson_id FROM lessons WHERE lesson_code = 'A0-U5-L3' LIMIT 1;
  IF v_lesson_id IS NOT NULL THEN
    UPDATE lessons SET
      lesson_goal = 'Make and respond to polite requests in shopping contexts',
      success_criteria = jsonb_build_array(
        'Can use "Could I have...?" and "Can I have...?"',
        'Can use "Please" and "Thank you" appropriately',
        'Can understand polite refusals',
        'Can respond helpfully to polite requests'
      ),
      homework = jsonb_build_object(
        'title', 'Polite Shopping Exchanges',
        'description', 'Practice polite request dialogues',
        'retrieval', 'Recall shopping items and prices',
        'input', 'Learn polite request formulas',
        'output', 'Create polite shopping dialogues',
        'estimated_minutes', 12
      )
    WHERE id = v_lesson_id;

    INSERT INTO lesson_stages (lesson_id, stage_type, title, instructions, timing_minutes, content, sort_order)
    VALUES
      (v_lesson_id, 'warm_up', 'Retrieval: Politeness Awareness', 'How do you ask for something politely in your language?', 5,
        jsonb_build_object('cultural', 'Cross-linguistic politeness'), 0),
      (v_lesson_id, 'lead_in', 'The Importance: Making Good Impression', 'Politeness is valued in English-speaking commerce', 7,
        jsonb_build_object('context', 'Cultural expectation'), 1),
      (v_lesson_id, 'input', 'Learn: Polite Request Patterns', '"Could I have...?", "Can I have...?", "Could you...?" with appropriate tone', 10,
        jsonb_build_object('focus', 'Register and politeness levels'), 2),
      (v_lesson_id, 'comprehension', 'Listen & Identify Politeness Level', 'Hear requests and judge appropriateness', 8,
        jsonb_build_object('format', 'register discrimination'), 3),
      (v_lesson_id, 'focus_practice', 'Request Formation & Response', 'Create and respond to polite requests', 10,
        jsonb_build_object('format', 'dialogue exchange'), 4),
      (v_lesson_id, 'communicative_use', 'Polite Request Exchange', 'Make and respond to polite shopping requests (recorded)', 7,
        jsonb_build_object('task', 'Authentic polite exchange'), 5),
      (v_lesson_id, 'assignment', 'Full Shopping Dialogue', 'Record a complete polite shopping transaction', 8,
        jsonb_build_object('scope', 'Complete authentic transaction'), 6),
      (v_lesson_id, 'reflection', 'Politeness Comfort', 'Does English politeness feel natural to you?', 5,
        jsonb_build_object('reflection', 'Register awareness'), 7);
  END IF;

  -- Lesson 20: Payment & Transactions
  SELECT id INTO v_lesson_id FROM lessons WHERE lesson_code = 'A0-U5-L4' LIMIT 1;
  IF v_lesson_id IS NOT NULL THEN
    UPDATE lessons SET
      lesson_goal = 'Complete actual shopping transactions in English',
      success_criteria = jsonb_build_array(
        'Can say what you want to buy',
        'Can understand and state total costs',
        'Can mention payment method',
        'Can understand receipt information'
      ),
      homework = jsonb_build_object(
        'title', 'Real Shopping Transaction',
        'description', 'Simulate a complete shopping transaction',
        'retrieval', 'Review all shopping vocabulary and prices',
        'input', 'Learn payment and receipt language',
        'output', 'Record a complete shopping transaction',
        'estimated_minutes', 14
      )
    WHERE id = v_lesson_id;

    INSERT INTO lesson_stages (lesson_id, stage_type, title, instructions, timing_minutes, content, sort_order)
    VALUES
      (v_lesson_id, 'warm_up', 'Retrieval: Full Shopping Simulation', 'Practice the complete shopping process mentally', 5,
        jsonb_build_object('mental_simulation', 'Review and organize'), 0),
      (v_lesson_id, 'lead_in', 'Authenticity: Real Shopping Scenario', 'You''re actually at a store checkout; complete the transaction', 7,
        jsonb_build_object('context', 'Authentic transaction'), 1),
      (v_lesson_id, 'input', 'Learn: Transaction Completion Language', 'Final price confirmation, payment methods, receipts, change', 11,
        jsonb_build_object('scope', 'Conclusion of transaction'), 2),
      (v_lesson_id, 'comprehension', 'Listen & Understand Checkouts', 'Hear checkout interactions and understand all parts', 8,
        jsonb_build_object('format', 'transaction listening'), 3),
      (v_lesson_id, 'focus_practice', 'Complete Transaction Drills', 'Practice from selection through payment', 10,
        jsonb_build_object('format', 'extended dialogue'), 4),
      (v_lesson_id, 'communicative_use', 'Role-Play Shopper & Clerk', 'Conduct a complete shopping transaction with recording', 7,
        jsonb_build_object('task', 'Full transaction role-play'), 5),
      (v_lesson_id, 'assignment', 'Record a Real Shopping Dialogue', 'Create and record a 3-minute shopping transaction', 8,
        jsonb_build_object('authenticity', 'Complete realistic transaction'), 6),
      (v_lesson_id, 'reflection', 'Unit 5 Integration', 'Are you ready to shop independently in English?', 5,
        jsonb_build_object('synthesis', 'Unit-level readiness'), 7);
  END IF;

  -- ============ UNIT 6: Getting Around (Lessons 21-24) ============

  -- Lesson 21: Direction Words
  SELECT id INTO v_lesson_id FROM lessons WHERE lesson_code = 'A0-U6-L1' LIMIT 1;
  IF v_lesson_id IS NOT NULL THEN
    UPDATE lessons SET
      lesson_goal = 'Understand and use direction words to navigate spaces',
      success_criteria = jsonb_build_array(
        'Can use left, right, straight, north, south, east, west',
        'Can understand and follow directions',
        'Can describe relative directions',
        'Can ask for directions appropriately'
      ),
      homework = jsonb_build_object(
        'title', 'Navigation Vocabulary',
        'description', 'Learn and practice direction terms',
        'retrieval', 'Recall prepositions of place from Unit 3',
        'input', 'Learn comprehensive direction vocabulary',
        'output', 'Record directions to familiar places',
        'estimated_minutes', 12
      )
    WHERE id = v_lesson_id;

    INSERT INTO lesson_stages (lesson_id, stage_type, title, instructions, timing_minutes, content, sort_order)
    VALUES
      (v_lesson_id, 'warm_up', 'Retrieval: Describe a Route', 'Can you describe how to get from your home to work?', 5,
        jsonb_build_object('activation', 'Route visualization'), 0),
      (v_lesson_id, 'lead_in', 'Real Need: Asking for Directions', 'You''re lost in an English-speaking city; you need directions', 7,
        jsonb_build_object('context', 'Genuine navigation need'), 1),
      (v_lesson_id, 'input', 'Learn: Direction & Navigation Words', 'left, right, straight, north, south, corner, intersection, block', 10,
        jsonb_build_object('scope', 'Complete navigation vocabulary'), 2),
      (v_lesson_id, 'comprehension', 'Listen & Follow Directions', 'Hear directions and trace route on map or in mind', 8,
        jsonb_build_object('format', 'directional listening'), 3),
      (v_lesson_id, 'focus_practice', 'Direction Drills', 'Say directions and practice gesture coordination', 10,
        jsonb_build_object('kinesthetic', 'Gesture-based practice'), 4),
      (v_lesson_id, 'communicative_use', 'Give Directions', 'Describe a route you know well (recorded)', 7,
        jsonb_build_object('task', 'Accurate route description'), 5),
      (v_lesson_id, 'assignment', 'Direction Recording', 'Record directions from your home to a familiar place', 8,
        jsonb_build_object('authenticity', 'Real route'), 6),
      (v_lesson_id, 'reflection', 'Spatial Language Comfort', 'Do direction words feel natural?', 5,
        jsonb_build_object('reflection', 'Language comfort'), 7);
  END IF;

  -- Lesson 22: Imperatives for Directions
  SELECT id INTO v_lesson_id FROM lessons WHERE lesson_code = 'A0-U6-L2' LIMIT 1;
  IF v_lesson_id IS NOT NULL THEN
    UPDATE lessons SET
      lesson_goal = 'Use imperative forms to give and understand directions clearly',
      success_criteria = jsonb_build_array(
        'Can form imperative verbs correctly',
        'Can use imperatives in direction-giving',
        'Can understand imperative directions from others',
        'Can use polite imperatives with "please"'
      ),
      homework = jsonb_build_object(
        'title', 'Imperative Directions',
        'description', 'Practice imperative direction-giving',
        'retrieval', 'Recall direction words and verbs',
        'input', 'Learn imperative formation',
        'output', 'Give directions using imperatives',
        'estimated_minutes', 12
      )
    WHERE id = v_lesson_id;

    INSERT INTO lesson_stages (lesson_id, stage_type, title, instructions, timing_minutes, content, sort_order)
    VALUES
      (v_lesson_id, 'warm_up', 'Retrieval: Imperative Intuition', 'Try to tell someone to "go straight" or "turn left"', 5,
        jsonb_build_object('intuitive', 'Command formation'), 0),
      (v_lesson_id, 'lead_in', 'The Structure: Direct Commands', 'How do English speakers give quick directions?', 7,
        jsonb_build_object('observation', 'Grammar pattern'), 1),
      (v_lesson_id, 'input', 'Learn: Imperative Formation & Use', 'Base verb forms for commands, negative imperatives, polite imperatives', 10,
        jsonb_build_object('focus', 'Command structures'), 2),
      (v_lesson_id, 'comprehension', 'Listen & Identify Imperatives', 'Hear directions and identify imperative verbs', 8,
        jsonb_build_object('format', 'verb identification'), 3),
      (v_lesson_id, 'focus_practice', 'Imperative Substitution', 'Create imperative direction sentences', 10,
        jsonb_build_object('format', 'sentence building'), 4),
      (v_lesson_id, 'communicative_use', 'Give Quick Directions', 'Use imperatives naturally when giving directions (recorded)', 7,
        jsonb_build_object('task', 'Quick direction commands'), 5),
      (v_lesson_id, 'assignment', 'Complete Imperative Directions', 'Record a full set of imperative directions to a place', 8,
        jsonb_build_object('scope', 'Complete direction sequence'), 6),
      (v_lesson_id, 'reflection', 'Command Comfort', 'Do imperative directions feel natural?', 5,
        jsonb_build_object('register', 'Command register'), 7);
  END IF;

  -- Lesson 23: "Where is...?" Questions
  SELECT id INTO v_lesson_id FROM lessons WHERE lesson_code = 'A0-U6-L3' LIMIT 1;
  IF v_lesson_id IS NOT NULL THEN
    UPDATE lessons SET
      lesson_goal = 'Ask for locations and understand location responses accurately',
      success_criteria = jsonb_build_array(
        'Can ask "Where is...?" questions naturally',
        'Can understand location responses',
        'Can ask follow-up location questions',
        'Can help others find locations'
      ),
      homework = jsonb_build_object(
        'title', 'Location Question Dialogues',
        'description', 'Ask and answer location questions',
        'retrieval', 'Recall direction words and locations',
        'input', 'Learn how to ask location questions',
        'output', 'Record location Q&A exchanges',
        'estimated_minutes', 12
      )
    WHERE id = v_lesson_id;

    INSERT INTO lesson_stages (lesson_id, stage_type, title, instructions, timing_minutes, content, sort_order)
    VALUES
      (v_lesson_id, 'warm_up', 'Retrieval: Location Consciousness', 'Look around - can you ask where things are?', 5,
        jsonb_build_object('environmental', 'Situational awareness'), 0),
      (v_lesson_id, 'lead_in', 'Real Context: Lost & Asking', 'You don''t know where something is; you need to ask', 7,
        jsonb_build_object('scenario', 'Genuine question need'), 1),
      (v_lesson_id, 'input', 'Learn: Asking Location Questions', 'Where is...? Is there a...? How do I get to...?', 10,
        jsonb_build_object('focus', 'Question formation'), 2),
      (v_lesson_id, 'comprehension', 'Listen & Answer Location Questions', 'Hear questions and understand what''s being asked', 8,
        jsonb_build_object('format', 'question comprehension'), 3),
      (v_lesson_id, 'focus_practice', 'Question & Answer Exchanges', 'Create question-response pairs about locations', 10,
        jsonb_build_object('format', 'dialogue building'), 4),
      (v_lesson_id, 'communicative_use', 'Ask for Real Locations', 'Ask for directions to actual places (recorded)', 7,
        jsonb_build_object('authenticity', 'Real location requests'), 5),
      (v_lesson_id, 'assignment', 'Location Interview', 'Record yourself asking for 5 different locations and receiving answers', 8,
        jsonb_build_object('scope', 'Multiple exchanges'), 6),
      (v_lesson_id, 'reflection', 'Question Naturalness', 'Do location questions feel conversational yet?', 5,
        jsonb_build_object('reflection', 'Natural speech'), 7);
  END IF;

  -- Lesson 24: Asking for Help & Clarification
  SELECT id INTO v_lesson_id FROM lessons WHERE lesson_code = 'A0-U6-L4' LIMIT 1;
  IF v_lesson_id IS NOT NULL THEN
    UPDATE lessons SET
      lesson_goal = 'Ask for help and clarification effectively in navigation and general contexts',
      success_criteria = jsonb_build_array(
        'Can ask "Can you help me?" appropriately',
        'Can say "I don''t understand" and ask for repetition',
        'Can ask for clarification naturally',
        'Can thank people and express appreciation'
      ),
      homework = jsonb_build_object(
        'title', 'Help & Clarification Exchanges',
        'description', 'Practice asking for help effectively',
        'retrieval', 'Review all direction and location language',
        'input', 'Learn help-seeking phrases',
        'output', 'Record help-seeking interactions',
        'estimated_minutes', 13
      )
    WHERE id = v_lesson_id;

    INSERT INTO lesson_stages (lesson_id, stage_type, title, instructions, timing_minutes, content, sort_order)
    VALUES
      (v_lesson_id, 'warm_up', 'Retrieval: Help Phrases', 'What do you say when you need help?', 5,
        jsonb_build_object('activation', 'Help phrase recall'), 0),
      (v_lesson_id, 'lead_in', 'Universal Need: Everyone Needs Help Sometimes', 'You can''t understand everything; you need to ask for help', 7,
        jsonb_build_object('universality', 'Essential communication skill'), 1),
      (v_lesson_id, 'input', 'Learn: Help & Clarification Phrases', '"Can you help me?", "I don''t understand", "Could you repeat?", "What does...mean?"', 11,
        jsonb_build_object('scope', 'Complete help-seeking vocabulary'), 2),
      (v_lesson_id, 'comprehension', 'Listen & Respond to Help Requests', 'Hear help requests and understand what''s needed', 8,
        jsonb_build_object('format', 'help request understanding'), 3),
      (v_lesson_id, 'focus_practice', 'Help-Seeking Exchanges', 'Practice asking for and providing help', 10,
        jsonb_build_object('format', 'helping dialogues'), 4),
      (v_lesson_id, 'communicative_use', 'Ask for Real Help', 'Ask for clarification on real information (recorded)', 7,
        jsonb_build_object('authenticity', 'Real help requests'), 5),
      (v_lesson_id, 'assignment', 'Complete Help Dialogue', 'Record a full interaction where you ask for and receive help', 8,
        jsonb_build_object('scope', 'Complete A0 narrative'), 6),
      (v_lesson_id, 'reflection', 'A0 Reflection & Celebration', 'Congratulations on completing A0 Foundations! What''s your biggest achievement?', 5,
        jsonb_build_object('celebration', 'Course completion'), 7);
  END IF;

END $$;
