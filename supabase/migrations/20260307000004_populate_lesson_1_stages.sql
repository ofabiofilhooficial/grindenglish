-- Populate Lesson 1: Professional Greetings & Names with Stages
-- A0-U1-L1 | Track: Core / Professional | Time: 50 Minutes

DO $$
DECLARE
  v_lesson_id UUID;
  v_stage_0_id UUID;
  v_stage_1_id UUID;
  v_stage_2_id UUID;
  v_stage_3_id UUID;
  v_stage_4_id UUID;
  v_stage_5_id UUID;
BEGIN
  -- Get Lesson 1 ID
  SELECT l.id INTO v_lesson_id
  FROM lessons l
  JOIN units u ON l.unit_id = u.id
  JOIN levels lv ON u.level_id = lv.id
  WHERE lv.cefr_code = 'A0'
    AND u.sort_order = 0
    AND l.sort_order = 0
    AND l.title = 'Professional Greetings & Names';

  IF v_lesson_id IS NULL THEN
    RAISE EXCEPTION 'Lesson 1 not found';
  END IF;

  -- Update lesson metadata
  UPDATE lessons
  SET 
    goal = 'By the end, you can confidently greet a colleague and introduce your first and last name using the verb to be.',
    success_criteria = 'Can use appropriate greetings (Hello, Hi, Good morning/afternoon) | Can introduce yourself using "I''m [Name]" | Can state your first and last name clearly | Can pronounce greetings without adding extra vowel sounds',
    interaction_pattern = 'solo',
    recycled_language = '[]'::jsonb,
    new_language = jsonb_build_array(
      'Hello', 'Hi', 'Good morning', 'Good afternoon', 
      'Name', 'First name', 'Last name', 'Nice to meet you',
      'I am / I''m', 'My'
    ),
    homework = jsonb_build_object(
      'title', 'Voice Note Introduction',
      'description', 'Record a 15-second voice note introducing yourself for a Slack/Teams channel',
      'instructions', 'Include: 1) Appropriate greeting for the time, 2) Your full name using "I''m...", 3) "Nice to meet you"',
      'estimated_minutes', 10
    )
  WHERE id = v_lesson_id;

  -- Stage 0: Retrieval (5 min)
  INSERT INTO lesson_stages (
    lesson_id, stage_type, title, instructions, timing_minutes, content, sort_order
  ) VALUES (
    v_lesson_id,
    'warm_up',
    'Retrieval: Prior Knowledge Check',
    'Assess what you already know about English greetings',
    5,
    jsonb_build_object(
      'objective', 'Activate prior knowledge and assess baseline',
      'task', 'Think about these Portuguese greetings and try to say them in English',
      'prompts', jsonb_build_array(
        'Oi → ?',
        'Bom dia → ?',
        'Boa tarde → ?'
      ),
      'teacher_notes', 'This diagnostic helps identify what students already know before formal instruction',
      'student_action', 'Write or say the English equivalents if you know them. It''s okay if you''re not sure!'
    ),
    0
  ) RETURNING id INTO v_stage_0_id;

  -- Stage 1: The Hook - "Notice the Gap" (7 min)
  INSERT INTO lesson_stages (
    lesson_id, stage_type, title, instructions, timing_minutes, content, sort_order
  ) VALUES (
    v_lesson_id,
    'lead_in',
    'The Hook: Notice the Gap',
    'Experience a real-world scenario and discover what you need to learn',
    7,
    jsonb_build_object(
      'objective', 'Create awareness of the language gap through authentic scenario',
      'scenario', jsonb_build_object(
        'context', 'You are logging into a global Zoom meeting for the first time',
        'situation', 'The host says: "Welcome! Who is joining us?"',
        'your_task', 'Introduce yourself immediately'
      ),
      'diagnostic_task', 'Try to introduce yourself right now as if you''re in that Zoom meeting',
      'anticipated_gaps', jsonb_build_array(
        'Using Portuguese pronunciation (adding extra vowel sounds)',
        'Saying "My name is..." instead of "I''m..."',
        'Forgetting to say "Nice to meet you"',
        'Uncertainty about which greeting to use'
      ),
      'teacher_notes', 'Don''t correct yet - just observe and note the gaps. This creates motivation for the upcoming input.',
      'reflection_prompt', 'How confident did you feel? What felt difficult?'
    ),
    1
  ) RETURNING id INTO v_stage_1_id;

  -- Stage 2: Targeted Input (10 min)
  INSERT INTO lesson_stages (
    lesson_id, stage_type, title, instructions, timing_minutes, content, sort_order
  ) VALUES (
    v_lesson_id,
    'input',
    'Targeted Input: The Solution',
    'Learn the professional way to greet and introduce yourself',
    10,
    jsonb_build_object(
      'objective', 'Present the target language with clear explanations and examples',
      'key_teaching_point', 'In a global meeting, we want to sound confident and direct. We use "I''m" instead of "My name is"',
      'grammar_focus', jsonb_build_object(
        'structure', 'I am → I''m + [Name]',
        'examples', jsonb_build_array(
          'I''m Maria.',
          'I''m Carlos Silva.',
          'I''m the new project manager.'
        ),
        'why_not', jsonb_build_object(
          'avoid', 'My name is...',
          'reason', 'Sounds too formal or childish in professional English. "I''m" is natural and confident.'
        )
      ),
      'vocabulary_focus', jsonb_build_object(
        'greetings', jsonb_build_array(
          jsonb_build_object('word', 'Hello', 'use', 'Professional, neutral, works anytime'),
          jsonb_build_object('word', 'Hi', 'use', 'Friendly, informal, use with colleagues you know'),
          jsonb_build_object('word', 'Good morning', 'use', 'Before 12:00 PM (noon)'),
          jsonb_build_object('word', 'Good afternoon', 'use', '12:00 PM - 6:00 PM')
        ),
        'name_vocabulary', jsonb_build_array(
          jsonb_build_object('term', 'First name', 'example', 'Carlos (in Carlos Silva)'),
          jsonb_build_object('term', 'Last name', 'example', 'Silva (in Carlos Silva)')
        )
      ),
      'pronunciation_focus', jsonb_build_object(
        'key_issue', 'Brazilian speakers add extra "i" sounds at the end of words',
        'wrong', 'Good-ee morning-ee',
        'right', 'Good morning (no extra vowels)',
        'practice_words', jsonb_build_array('Good', 'morning', 'afternoon', 'Hello')
      ),
      'pragmatics', jsonb_build_object(
        'cultural_note', 'In English-speaking business culture, direct eye contact and a firm handshake (or nod on video) show confidence',
        'professional_formula', 'Greeting + I''m [Name] + Nice to meet you'
      ),
      'student_action', 'Review the grammar and vocabulary assets linked to this lesson. Take notes on the key differences from Portuguese.'
    ),
    2
  ) RETURNING id INTO v_stage_2_id;

  -- Stage 3: Focused Practice (8 min)
  INSERT INTO lesson_stages (
    lesson_id, stage_type, title, instructions, timing_minutes, content, sort_order
  ) VALUES (
    v_lesson_id,
    'practice',
    'Focused Practice: Rapid-Fire Drill',
    'Practice choosing the right greeting for different times of day',
    8,
    jsonb_build_object(
      'objective', 'Automate the connection between time of day and appropriate greeting',
      'activity_type', 'Substitution drill',
      'instructions', 'For each time shown, respond with the correct greeting + "I''m [Your Name]"',
      'drill_items', jsonb_build_array(
        jsonb_build_object('time', '9:00 AM', 'expected', 'Good morning, I''m [Name]'),
        jsonb_build_object('time', '3:00 PM', 'expected', 'Good afternoon, I''m [Name]'),
        jsonb_build_object('time', '10:30 AM', 'expected', 'Good morning, I''m [Name]'),
        jsonb_build_object('time', '1:00 PM', 'expected', 'Good afternoon, I''m [Name]'),
        jsonb_build_object('time', '11:45 AM', 'expected', 'Good morning, I''m [Name]'),
        jsonb_build_object('time', '5:00 PM', 'expected', 'Good afternoon, I''m [Name]')
      ),
      'success_criteria', 'You can respond within 3 seconds with the correct greeting',
      'teacher_notes', 'Focus on speed and accuracy. Correct pronunciation immediately.',
      'self_study_tip', 'Record yourself doing this drill. Listen back and check your pronunciation.',
      'upgrade', 'Once comfortable, add "Nice to meet you" at the end of each response'
    ),
    3
  ) RETURNING id INTO v_stage_3_id;

  -- Stage 4: Communicative Task (15 min)
  INSERT INTO lesson_stages (
    lesson_id, stage_type, title, instructions, timing_minutes, content, sort_order
  ) VALUES (
    v_lesson_id,
    'communicative_use',
    'The Main Event: Zoom Breakout Room Simulation',
    'Use your new language in realistic professional scenarios',
    15,
    jsonb_build_object(
      'objective', 'Apply the target language in authentic, varied contexts',
      'activity_type', 'Role-play simulation',
      'scenario', 'You are joining 3 different virtual meetings. Each requires a different level of formality.',
      'situations', jsonb_build_array(
        jsonb_build_object(
          'room', 'Room 1: Team Meeting',
          'context', 'Meeting a peer/colleague for the first time',
          'time', '10:00 AM',
          'formality', 'Friendly professional',
          'your_task', 'Introduce yourself when you enter the meeting',
          'expected_language', 'Good morning! I''m [Name]. Nice to meet you.'
        ),
        jsonb_build_object(
          'room', 'Room 2: Executive Briefing',
          'context', 'Meeting your new boss for the first time',
          'time', '2:00 PM',
          'formality', 'Formal professional',
          'your_task', 'Introduce yourself professionally',
          'expected_language', 'Good afternoon. I''m [Full Name]. It''s nice to meet you.'
        ),
        jsonb_build_object(
          'room', 'Room 3: Client Call',
          'context', 'First call with an important client',
          'time', '4:00 PM',
          'formality', 'Very professional',
          'your_task', 'Make a strong first impression',
          'expected_language', 'Good afternoon. I''m [Full Name] from [Company]. Nice to meet you.'
        )
      ),
      'success_criteria', jsonb_build_array(
        'Use the correct greeting for the time of day',
        'Use "I''m" (not "My name is")',
        'Pronounce words clearly without extra vowel sounds',
        'Include "Nice to meet you"',
        'Adjust formality appropriately'
      ),
      'teacher_notes', 'In live class: Teacher plays each role. For self-study: Student records themselves for each scenario.',
      'self_study_instructions', 'Record yourself introducing yourself in each scenario. Play it back and evaluate using the success criteria.',
      'reflection_questions', jsonb_build_array(
        'Which scenario felt most comfortable?',
        'Which greeting felt most natural?',
        'What do you need to practice more?'
      )
    ),
    4
  ) RETURNING id INTO v_stage_4_id;

  -- Stage 5: Debrief & Upgrade (5 min)
  INSERT INTO lesson_stages (
    lesson_id, stage_type, title, instructions, timing_minutes, content, sort_order
  ) VALUES (
    v_lesson_id,
    'feedback',
    'Debrief & Upgrade',
    'Reflect on your performance and identify your next steps',
    5,
    jsonb_build_object(
      'objective', 'Consolidate learning and set clear improvement targets',
      'feedback_framework', jsonb_build_object(
        'strength', 'Identify 1 thing you did well (e.g., "Your confidence was great!")',
        'fix', 'Identify 1 specific thing to improve (e.g., "Practice the pronunciation of ''Good'' without the extra ''i''")',
        'upgrade', 'Identify 1 way to level up (e.g., "Try adding ''Nice to meet you'' more naturally")'
      ),
      'self_assessment_prompts', jsonb_build_array(
        'What felt easy?',
        'What felt challenging?',
        'What will you practice before the next lesson?'
      ),
      'teacher_notes', 'Keep feedback specific and actionable. Always start with a strength.',
      'next_steps', jsonb_build_array(
        'Complete the homework: Record your 15-second introduction',
        'Review the linked grammar and vocabulary',
        'Practice the pronunciation drill daily'
      ),
      'connection_to_next_lesson', 'In Lesson 2, you''ll learn to talk about where you''re from and what you do professionally.'
    ),
    5
  ) RETURNING id INTO v_stage_5_id;

  RAISE NOTICE 'Lesson 1 populated successfully with 6 stages';
  RAISE NOTICE 'Stage IDs: %, %, %, %, %, %', v_stage_0_id, v_stage_1_id, v_stage_2_id, v_stage_3_id, v_stage_4_id, v_stage_5_id;

END $$;

COMMENT ON TABLE lesson_stages IS 'Lesson 1 now has 6 complete stages with detailed content for self-paced study';
