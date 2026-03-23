-- Populate all A0 lessons with complete stage sequences
-- A0 Foundation (6 units × 4 lessons = 24 lessons, each with 6-8 stages)
-- Following the 9-stage pedagogical sequence: Warm-up → Hook → Input → Comprehension → Practice → Communicative Use → Feedback → Assignment → Reflection

DO $$
DECLARE
  v_unit1_id UUID;
  v_unit2_id UUID;
  v_unit3_id UUID;
  v_unit4_id UUID;
  v_unit5_id UUID;
  v_unit6_id UUID;
BEGIN
  -- Get all unit IDs
  SELECT id INTO v_unit1_id FROM units WHERE title = 'Hello & Identity' LIMIT 1;
  SELECT id INTO v_unit2_id FROM units WHERE title = 'Numbers, Time & Dates' LIMIT 1;
  SELECT id INTO v_unit3_id FROM units WHERE title = 'My World (Home & Objects)' LIMIT 1;
  SELECT id INTO v_unit4_id FROM units WHERE title = 'Daily Routines' LIMIT 1;
  SELECT id INTO v_unit5_id FROM units WHERE title = 'Shopping Basics' LIMIT 1;
  SELECT id INTO v_unit6_id FROM units WHERE title = 'Getting Around' LIMIT 1;

  -- ============ UNIT 1: Hello & Identity ============

  -- L1: Professional Greetings & Names
  PERFORM populate_lesson_stages('A0-U1-L1', v_unit1_id, 0, jsonb_build_object(
    'goal', 'Confidently greet a colleague and introduce your first and last name using the verb to be',
    'success_criteria', jsonb_build_array(
      'Can use appropriate greetings (Hello, Hi, Good morning/afternoon)',
      'Can introduce yourself using "I am / I am [Name]"',
      'Can state your first and last name clearly',
      'Can pronounce greetings without adding extra vowel sounds'
    ),
    'stages', jsonb_build_array(
      jsonb_build_object(
        'type', 'warm_up',
        'title', 'Retrieval: What Do You Know About Greetings?',
        'timing', 5,
        'instructions', 'Think about these Portuguese greetings and try to say them in English',
        'content', jsonb_build_object(
          'prompts', jsonb_build_array('Oi → ?', 'Bom dia → ?', 'Boa tarde → ?')
        )
      ),
      jsonb_build_object(
        'type', 'lead_in',
        'title', 'Notice the Gap: Real-world Introduction Scenario',
        'timing', 7,
        'instructions', 'Listen to a colleague introducing themselves in a Zoom meeting',
        'content', jsonb_build_object(
          'scenario', 'You are joining a global Zoom meeting for the first time',
          'task', 'Try to introduce yourself now as if you are in that meeting'
        )
      ),
      jsonb_build_object(
        'type', 'input',
        'title', 'The Solution: Professional Introductions',
        'timing', 10,
        'instructions', 'Learn how to confidently introduce yourself in English',
        'content', jsonb_build_object(
          'key_point', 'In global meetings, use "I am / I''m [Name]" not "My name is..."',
          'examples', jsonb_build_array('I''m Maria', 'I''m Carlos Silva', 'I''m the new project manager')
        )
      ),
      jsonb_build_object(
        'type', 'comprehension',
        'title', 'Listen & Repeat: Model Introductions',
        'timing', 8,
        'instructions', 'Listen to 5 professional introductions and identify key parts',
        'content', jsonb_build_object(
          'audio_count', 5,
          'task_type', 'cloze'
        )
      ),
      jsonb_build_object(
        'type', 'focus_practice',
        'title', 'Controlled Practice: Greetings & Names',
        'timing', 10,
        'instructions', 'Complete fill-in-the-blank exercises and pronunce with audio',
        'content', jsonb_build_object(
          'exercises', jsonb_build_array(
            'Greeting selection (5 scenarios)',
            'Pronunciation drills (5 names)',
            'Stress pattern practice'
          )
        )
      ),
      jsonb_build_object(
        'type', 'communicative_use',
        'title', 'Role-Play: Meet a Colleague',
        'timing', 7,
        'instructions', 'Record yourself greeting and introducing yourself',
        'content', jsonb_build_object(
          'task', 'Introduce yourself to a virtual colleague (recorded)',
          'duration_seconds', 30
        )
      ),
      jsonb_build_object(
        'type', 'assignment',
        'title', 'Performance Task: Video Introduction',
        'timing', 8,
        'instructions', 'Record a 30-second self-introduction video',
        'content', jsonb_build_object(
          'requirements', jsonb_build_array(
            'Use appropriate greeting',
            'State your full name using "I am..."',
            'Natural pronunciation and stress'
          ),
          'deliverable', 'video'
        )
      )
    )
  ));

  -- L2: Origins & Roles (Be + Personal Info)
  PERFORM populate_lesson_stages('A0-U1-L2', v_unit1_id, 1, jsonb_build_object(
    'goal', 'State your city/country of origin and your professional title using the verb to be',
    'success_criteria', jsonb_build_array(
      'Can use "I am from [city/country]" correctly',
      'Can state your professional role/student status',
      'Can understand and respond to "Where are you from?"',
      'Can use subject pronouns (I, you, he, she, we, they) with "to be"'
    ),
    'stages', jsonb_build_array(
      jsonb_build_object('type', 'warm_up', 'title', 'Retrieval: Countries & Cities', 'timing', 5, 'instructions', 'Name cities and countries you know in English'),
      jsonb_build_object('type', 'lead_in', 'title', 'Listen: Where Are They From?', 'timing', 6, 'instructions', 'Hear 5 people state their origins'),
      jsonb_build_object('type', 'input', 'title', 'Learn: "I am from... I am a..."', 'timing', 10, 'instructions', 'Master the sentence structure'),
      jsonb_build_object('type', 'comprehension', 'title', 'Listening Comprehension', 'timing', 8, 'instructions', 'Match people to their cities/jobs'),
      jsonb_build_object('type', 'focus_practice', 'title', 'Guided Practice: Countries & Roles', 'timing', 10, 'instructions', 'Fill-in + sentence building'),
      jsonb_build_object('type', 'communicative_use', 'title', 'Pair Dialogue: "Where Are You From?"', 'timing', 7, 'instructions', 'Record a 2-message exchange'),
      jsonb_build_object('type', 'assignment', 'title', 'Written Profile: My Origin & Role', 'timing', 8, 'instructions', 'Write 3 sentences about yourself', 'content', jsonb_build_object('format', 'text', 'example', 'I am Maria. I am from Rio de Janeiro. I am a teacher.'))
    )
  ));

  -- L3: Exchanging Contact Info (Spelling & Dictation)
  PERFORM populate_lesson_stages('A0-U1-L3', v_unit1_id, 2, jsonb_build_object(
    'goal', 'Confidently spell your name and dictate your email/phone number',
    'success_criteria', jsonb_build_array(
      'Can spell your name clearly letter-by-letter',
      'Can ask for spelling: "Can you spell that?"',
      'Can dictate an email address',
      'Can dictate a phone number'
    ),
    'stages', jsonb_build_array(
      jsonb_build_object('type', 'warm_up', 'title', 'Retrieval: English Alphabet', 'timing', 5, 'instructions', 'Recall the English alphabet sounds'),
      jsonb_build_object('type', 'lead_in', 'title', 'Listen: Spelling in Action', 'timing', 6, 'instructions', 'Hear native speakers spelling names'),
      jsonb_build_object('type', 'input', 'title', 'The Alphabet: Letter Names & Pronunciation', 'timing', 12, 'instructions', 'Master all 26 letter names with audio'),
      jsonb_build_object('type', 'comprehension', 'title', 'Dictation: Write Down Names', 'timing', 8, 'instructions', 'Hear letters and write the word'),
      jsonb_build_object('type', 'focus_practice', 'title', 'Spell Your Details', 'timing', 10, 'instructions', 'Practice spelling your name + email'),
      jsonb_build_object('type', 'communicative_use', 'title', 'Dialogue: Request Spelling', 'timing', 7, 'instructions', 'Record: Ask for and provide spelling'),
      jsonb_build_object('type', 'assignment', 'title', 'Voice Recording: Dictate Your Contact', 'timing', 8, 'instructions', 'Record spelling your name + email + phone')
    )
  ));

  -- L4: Unit Performance Assessment
  PERFORM populate_lesson_stages('A0-U1-L4', v_unit1_id, 3, jsonb_build_object(
    'goal', 'Complete a profile card and conduct a 2-message introductory chat',
    'success_criteria', jsonb_build_array(
      'Profile card is complete and clear',
      'Chat messages use correct "to be" forms',
      'Greetings and closings are appropriate',
      'Contact information is spelled correctly'
    ),
    'stages', jsonb_build_array(
      jsonb_build_object('type', 'lead_in', 'title', 'Review of Unit 1 Objectives', 'timing', 5, 'instructions', 'Recall what you''ve learned'),
      jsonb_build_object('type', 'focus_practice', 'title', 'Quick Review Activities', 'timing', 10, 'instructions', 'Short drills on each sub-skill'),
      jsonb_build_object('type', 'communicative_use', 'title', 'Simulated Performance: Complete Profile', 'timing', 10, 'instructions', 'Fill out your digital profile card'),
      jsonb_build_object('type', 'assignment', 'title', 'Assessment Task 1: Profile Card', 'timing', 8, 'instructions', 'Submit your completed profile'),
      jsonb_build_object('type', 'assignment', 'title', 'Assessment Task 2: Introductory Chat', 'timing', 12, 'instructions', 'Exchange 3 messages introducing yourself'),
      jsonb_build_object('type', 'reflection', 'title', 'Reflection: What Did You Learn?', 'timing', 5, 'instructions', 'Reflect on your learning in Unit 1')
    )
  ));

  -- ============ UNIT 2: Numbers, Time & Dates ============

  -- L1: Days of the Week & Availability
  PERFORM populate_lesson_stages('A0-U2-L1', v_unit2_id, 0, jsonb_build_object(
    'goal', 'State your availability using days of the week and the preposition "on"',
    'success_criteria', jsonb_build_array(
      'Can name all 7 days of the week',
      'Can use "on Monday", "on Tuesday", etc.',
      'Can understand availability questions',
      'Can respond to "What days are you available?"'
    ),
    'stages', jsonb_build_array(
      jsonb_build_object('type', 'warm_up', 'title', 'Retrieval: Days in Portuguese', 'timing', 5, 'instructions', 'Name each day in Portuguese first, then English'),
      jsonb_build_object('type', 'lead_in', 'title', 'Watch: Calendar Scheduling in English', 'timing', 6, 'instructions', 'See native speakers discussing availability'),
      jsonb_build_object('type', 'input', 'title', 'Learn: Days + Preposition "On"', 'timing', 10, 'instructions', 'Master the 7 days and "on Monday" structure'),
      jsonb_build_object('type', 'comprehension', 'title', 'Listening: Which Day?', 'timing', 8, 'instructions', 'Hear days mentioned and identify them'),
      jsonb_build_object('type', 'focus_practice', 'title', 'Day Drills & Sentences', 'timing', 10, 'instructions', 'Fill-in-the-blank and sentence building'),
      jsonb_build_object('type', 'communicative_use', 'title', 'Dialogue: When Are You Available?', 'timing', 7, 'instructions', 'State your availability for 3 days'),
      jsonb_build_object('type', 'assignment', 'title', 'Write Your Weekly Schedule', 'timing', 8, 'instructions', 'List 3 days you are available')
    )
  ));

  -- L2: Telling Time for Meetings
  PERFORM populate_lesson_stages('A0-U2-L2', v_unit2_id, 1, jsonb_build_object(
    'goal', 'State exact and half-hour meeting times using 12-hour AM/PM system',
    'success_criteria', jsonb_build_array(
      'Can say all times on the hour (1:00, 2:00, etc.)',
      'Can say half-hour times (1:30, 2:30, etc.)',
      'Can use AM/PM correctly',
      'Can understand "What time...?" questions'
    ),
    'stages', jsonb_build_array(
      jsonb_build_object('type', 'warm_up', 'title', 'Retrieval: Numbers 1-12', 'timing', 5, 'instructions', 'Say numbers used in clock times'),
      jsonb_build_object('type', 'lead_in', 'title', 'Notice: How Native Speakers Say Time', 'timing', 7, 'instructions', 'Hear natural time expressions'),
      jsonb_build_object('type', 'input', 'title', 'The System: Hour + Half-Hour Times', 'timing', 11, 'instructions', 'Learn "It is 3:00" and "It is 3:30"'),
      jsonb_build_object('type', 'comprehension', 'title', 'Listening: Identify Meeting Times', 'timing', 8, 'instructions', 'Hear times and write them down'),
      jsonb_build_object('type', 'focus_practice', 'title', 'Time-Telling Practice', 'timing', 10, 'instructions', 'Say 15 different times with audio feedback'),
      jsonb_build_object('type', 'communicative_use', 'title', 'Pair Work: Schedule a Meeting', 'timing', 8, 'instructions', 'Record: "Let''s meet at 3:00?"'),
      jsonb_build_object('type', 'assignment', 'title', 'Create Your Daily Schedule', 'timing', 8, 'instructions', 'Write 5 times for your meetings this week')
    )
  ));

  -- L3: Proposing a Plan
  PERFORM populate_lesson_stages('A0-U2-L3', v_unit2_id, 2, jsonb_build_object(
    'goal', 'Ask about availability using inverted "to be" questions and confirm a meeting',
    'success_criteria', jsonb_build_array(
      'Can ask "Are you available on Tuesday?"',
      'Can propose a specific time: "Can we meet at 2:00?"',
      'Can confirm plans: "So, Tuesday at 2:00, right?"',
      'Can handle yes/no responses'
    ),
    'stages', jsonb_build_array(
      jsonb_build_object('type', 'warm_up', 'title', 'Retrieval: Days + Times Combined', 'timing', 5, 'instructions', 'Say "Tuesday at 3:00", etc.'),
      jsonb_build_object('type', 'lead_in', 'title', 'Listen: Full Meeting Proposal Dialogue', 'timing', 7, 'instructions', 'Hear complete meeting proposal in English'),
      jsonb_build_object('type', 'input', 'title', 'Question Formation: Inverted "To Be"', 'timing', 11, 'instructions', 'Learn "Are you available?" structure'),
      jsonb_build_object('type', 'comprehension', 'title', 'Identify Parts of a Proposal', 'timing', 8, 'instructions', 'Match proposals to their intentions'),
      jsonb_build_object('type', 'focus_practice', 'title', 'Form & Ask Questions', 'timing', 10, 'instructions', 'Make 10 different availability questions'),
      jsonb_build_object('type', 'communicative_use', 'title', 'Role-Play: Full Meeting Negotiation', 'timing', 8, 'instructions', 'Record a 2-minute dialogue proposing and confirming'),
      jsonb_build_object('type', 'assignment', 'title', 'Text Message: Propose Meeting', 'timing', 8, 'instructions', 'Write and record a meeting proposal message')
    )
  ));

  -- L4: Unit Performance Assessment
  PERFORM populate_lesson_stages('A0-U2-L4', v_unit2_id, 3, jsonb_build_object(
    'goal', 'Successfully negotiate a meeting time',
    'success_criteria', jsonb_build_array(
      'Can understand availability constraints',
      'Can propose alternatives',
      'Can confirm final time',
      'Can manage miscommunications'
    ),
    'stages', jsonb_build_array(
      jsonb_build_object('type', 'lead_in', 'title', 'Unit 2 Review', 'timing', 5, 'instructions', 'Refresh your skills'),
      jsonb_build_object('type', 'focus_practice', 'title', 'Mixed Review Drills', 'timing', 10, 'instructions', 'Days, times, and questions combined'),
      jsonb_build_object('type', 'communicative_use', 'title', 'Guided Practice: Meeting Negotiation', 'timing', 10, 'instructions', 'Structured dialogue with support'),
      jsonb_build_object('type', 'assignment', 'title', 'Assessment: Schedule Meeting via Message', 'timing', 10, 'instructions', 'Exchange 3-4 messages to confirm meeting'),
      jsonb_build_object('type', 'assignment', 'title', 'Assessment: Verbal Confirmation', 'timing', 10, 'instructions', 'Record yourself confirming a meeting plan'),
      jsonb_build_object('type', 'reflection', 'title', 'Reflect on Unit 2', 'timing', 5, 'instructions', 'What was easy? What was challenging?')
    )
  ));

  -- ============ UNIT 3: My World (Home & Objects) ============

  -- L1: The Office & Home Workspace
  PERFORM populate_lesson_stages('A0-U3-L1', v_unit3_id, 0, jsonb_build_object(
    'goal', 'State your current working location and identify basic rooms',
    'success_criteria', jsonb_build_array(
      'Can name 5 common rooms (office, kitchen, bedroom, etc.)',
      'Can use "I work in the office" / "I am in the kitchen"',
      'Can understand room-related vocabulary',
      'Can describe where you are currently'
    ),
    'stages', jsonb_build_array(
      jsonb_build_object('type', 'warm_up', 'title', 'Retrieval: Rooms in Your Home', 'timing', 5, 'instructions', 'Think about rooms you know'),
      jsonb_build_object('type', 'lead_in', 'title', 'Watch: Home Tour in English', 'timing', 7, 'instructions', 'Hear someone describing their home'),
      jsonb_build_object('type', 'input', 'title', 'Learn: 8 Common Rooms + Location Language', 'timing', 11, 'instructions', 'Master room vocabulary and "I am in..."'),
      jsonb_build_object('type', 'comprehension', 'title', 'Listening: Room Identification', 'timing', 8, 'instructions', 'Hear descriptions and identify rooms'),
      jsonb_build_object('type', 'focus_practice', 'title', 'Room Vocabulary Drills', 'timing', 10, 'instructions', 'Pronunciation and sentence building'),
      jsonb_build_object('type', 'communicative_use', 'title', 'Dialogue: Where Are You Now?', 'timing', 7, 'instructions', 'Describe your current location'),
      jsonb_build_object('type', 'assignment', 'title', 'Describe Your Workspace', 'timing', 8, 'instructions', 'List or record 3 rooms in your home/office')
    )
  ));

  -- L2: Desk & Tech Vocabulary
  PERFORM populate_lesson_stages('A0-U3-L2', v_unit3_id, 1, jsonb_build_object(
    'goal', 'Identify standard tech equipment and report a broken item',
    'success_criteria', jsonb_build_array(
      'Can name 8 common office items (desk, chair, computer, etc.)',
      'Can use "This is a..." for items',
      'Can say "My [item] is broken"',
      'Can ask for help: "Can you fix my...?"'
    ),
    'stages', jsonb_build_array(
      jsonb_build_object('type', 'warm_up', 'title', 'Retrieval: Office Items', 'timing', 5, 'instructions', 'Point to objects around you'),
      jsonb_build_object('type', 'lead_in', 'title', 'Listen: Office Tech Terminology', 'timing', 6, 'instructions', 'Hear how native speakers refer to equipment'),
      jsonb_build_object('type', 'input', 'title', 'Vocabulary: 12 Common Office Items', 'timing', 11, 'instructions', 'Learn names with pronunciation and usage'),
      jsonb_build_object('type', 'comprehension', 'title', 'Identify Items from Descriptions', 'timing', 8, 'instructions', 'Match definitions to office items'),
      jsonb_build_object('type', 'focus_practice', 'title', 'Vocabulary + Sentence Practice', 'timing', 10, 'instructions', 'Build phrases like "My computer is broken"'),
      jsonb_build_object('type', 'communicative_use', 'title', 'Role-Play: Report a Problem', 'timing', 7, 'instructions', 'Record reporting an equipment issue'),
      jsonb_build_object('type', 'assignment', 'title', 'List & Label Your Desk', 'timing', 8, 'instructions', 'Identify 5 items at your desk and label them')
    )
  ));

  -- L3: Where Is It?
  PERFORM populate_lesson_stages('A0-U3-L3', v_unit3_id, 2, jsonb_build_object(
    'goal', 'Ask where an item is and answer using prepositions on/under/near',
    'success_criteria', jsonb_build_array(
      'Can use "Where is my...?"',
      'Can answer "It is on the desk", "It is under the chair"',
      'Can use prepositions: on, under, near, next to, in',
      'Can ask for and locate items'
    ),
    'stages', jsonb_build_array(
      jsonb_build_object('type', 'warm_up', 'title', 'Retrieval: Items + Locations', 'timing', 5, 'instructions', 'Say where common items are'),
      jsonb_build_object('type', 'lead_in', 'title', 'Listen: Searching for Items', 'timing', 7, 'instructions', 'Hear people asking "Where is...?"'),
      jsonb_build_object('type', 'input', 'title', 'Prepositions: On, Under, Near, Next To', 'timing', 11, 'instructions', 'Master location prepositions'),
      jsonb_build_object('type', 'comprehension', 'title', 'Understand Directional Language', 'timing', 8, 'instructions', 'Match items to their locations'),
      jsonb_build_object('type', 'focus_practice', 'title', 'Ask & Answer About Locations', 'timing', 10, 'instructions', 'Form questions and give answers'),
      jsonb_build_object('type', 'communicative_use', 'title', 'Role-Play: Locate Missing Items', 'timing', 8, 'instructions', 'Record a dialogue about finding things'),
      jsonb_build_object('type', 'assignment', 'title', 'Describe Your Room Layout', 'timing', 8, 'instructions', 'Describe where 5 items are in your space')
    )
  ));

  -- L4: Unit Performance Assessment
  PERFORM populate_lesson_stages('A0-U3-L4', v_unit3_id, 3, jsonb_build_object(
    'goal', 'Give a virtual tour and locate missing items',
    'success_criteria', jsonb_build_array(
      'Can describe your room coherently',
      'Can use prepositions naturally',
      'Can explain where things are',
      'Can handle interactive questions about your space'
    ),
    'stages', jsonb_build_array(
      jsonb_build_object('type', 'lead_in', 'title', 'Unit 3 Review: Rooms, Items, Locations', 'timing', 5, 'instructions', 'Recap all vocabulary and structures'),
      jsonb_build_object('type', 'focus_practice', 'title', 'Comprehensive Drills', 'timing', 10, 'instructions', 'Mixed vocabulary and prepositions'),
      jsonb_build_object('type', 'communicative_use', 'title', 'Guided Virtual Tour', 'timing', 10, 'instructions', 'Practice describing a room systematically'),
      jsonb_build_object('type', 'assignment', 'title', 'Assessment: Virtual Room Tour (Video)', 'timing', 10, 'instructions', 'Record a 60-second tour of your workspace'),
      jsonb_build_object('type', 'assignment', 'title', 'Assessment: Missing Item Dialogue', 'timing', 10, 'instructions', 'Record finding a missing item via conversation'),
      jsonb_build_object('type', 'reflection', 'title', 'Reflect on Unit 3', 'timing', 5, 'instructions', 'What did you learn? What was useful?')
    )
  ));

  -- ============ UNIT 4: Daily Routines ============

  -- L1: Morning & Evening Habits
  PERFORM populate_lesson_stages('A0-U4-L1', v_unit4_id, 0, jsonb_build_object(
    'goal', 'Describe 4-5 key events in your day using "I" and correct time prepositions',
    'success_criteria', jsonb_build_array(
      'Can use simple present for daily routines',
      'Can name 10 routine verbs (wake up, get up, eat, work, etc.)',
      'Can say times of day',
      'Can sequence events: "First I..., then I..."'
    ),
    'stages', jsonb_build_array(
      jsonb_build_object('type', 'warm_up', 'title', 'Retrieval: Your Typical Day', 'timing', 5, 'instructions', 'Think through your daily schedule'),
      jsonb_build_object('type', 'lead_in', 'title', 'Listen: Daily Routine Narrative', 'timing', 7, 'instructions', 'Hear someone describe their morning'),
      jsonb_build_object('type', 'input', 'title', 'Learn: Routine Verbs & Time Expressions', 'timing', 11, 'instructions', 'Master 10 key routine verbs with times'),
      jsonb_build_object('type', 'comprehension', 'title', 'Listening: Order of Daily Events', 'timing', 8, 'instructions', 'Sequence events in the correct order'),
      jsonb_build_object('type', 'focus_practice', 'title', 'Routine Verb Drills', 'timing', 10, 'instructions', 'Say routines with correct times'),
      jsonb_build_object('type', 'communicative_use', 'title', 'Describe Your Morning Routine', 'timing', 8, 'instructions', 'Record 45 seconds about your morning'),
      jsonb_build_object('type', 'assignment', 'title', 'Write: My Daily Schedule', 'timing', 8, 'instructions', 'Write 5 sentences: "I get up at..., I have breakfast..."')
    )
  ));

  -- L2: Work vs. Study Routines
  PERFORM populate_lesson_stages('A0-U4-L2', v_unit4_id, 1, jsonb_build_object(
    'goal', 'Qualify your routine using adverbs of frequency to explain schedule variations',
    'success_criteria', jsonb_build_array(
      'Can use "always, usually, often, sometimes, never"',
      'Can explain "I always go to the office, but sometimes I work at home"',
      'Can use simple present with frequency adverbs',
      'Can discuss routine variations'
    ),
    'stages', jsonb_build_array(
      jsonb_build_object('type', 'warm_up', 'title', 'Retrieval: Your Weekly Routine Variations', 'timing', 5, 'instructions', 'Think about what changes in your schedule'),
      jsonb_build_object('type', 'lead_in', 'title', 'Listen: Frequency in Real Routines', 'timing', 7, 'instructions', 'Hear how people qualify their habits'),
      jsonb_build_object('type', 'input', 'title', 'Adverbs of Frequency: Always to Never', 'timing', 11, 'instructions', 'Learn the frequency scale and usage'),
      jsonb_build_object('type', 'comprehension', 'title', 'Identify Frequency Markers', 'timing', 8, 'instructions', 'Hear and identify frequency adverbs'),
      jsonb_build_object('type', 'focus_practice', 'title', 'Build Sentences with Frequency', 'timing', 10, 'instructions', 'Make statements about your varying routine'),
      jsonb_build_object('type', 'communicative_use', 'title', 'Explain Your Schedule Variation', 'timing', 8, 'instructions', 'Record: "I usually..., but sometimes I..."'),
      jsonb_build_object('type', 'assignment', 'title', 'Compare Work vs. Study Routines', 'timing', 8, 'instructions', 'Describe how your routine changes based on context')
    )
  ));

  -- L3: Asking About Routines
  PERFORM populate_lesson_stages('A0-U4-L3', v_unit4_id, 2, jsonb_build_object(
    'goal', 'Ask open and closed questions to determine a colleague''s schedule',
    'success_criteria', jsonb_build_array(
      'Can ask "Do you work every day?"',
      'Can ask "What time do you start work?"',
      'Can ask "Do you have lunch at the office?"',
      'Can follow up with open questions'
    ),
    'stages', jsonb_build_array(
      jsonb_build_object('type', 'warm_up', 'title', 'Retrieval: Question Formation', 'timing', 5, 'instructions', 'Review yes/no and wh-question patterns'),
      jsonb_build_object('type', 'lead_in', 'title', 'Listen: Interviewing About Routines', 'timing', 7, 'instructions', 'Hear natural interview questions'),
      jsonb_build_object('type', 'input', 'title', 'Question Types: Closed & Open About Routines', 'timing', 11, 'instructions', 'Learn to form both question types'),
      jsonb_build_object('type', 'comprehension', 'title', 'Understand Different Question Types', 'timing', 8, 'instructions', 'Identify questions by their structure'),
      jsonb_build_object('type', 'focus_practice', 'title', 'Form Questions About Routines', 'timing', 10, 'instructions', 'Create 15 different routine questions'),
      jsonb_build_object('type', 'communicative_use', 'title', 'Interview a Partner About Their Routine', 'timing', 8, 'instructions', 'Record an interview with 5-6 questions'),
      jsonb_build_object('type', 'assignment', 'title', 'Create an Interview Script', 'timing', 8, 'instructions', 'Write 5 questions to ask a colleague about their day')
    )
  ));

  -- L4: Unit Performance Assessment
  PERFORM populate_lesson_stages('A0-U4-L4', v_unit4_id, 3, jsonb_build_object(
    'goal', 'Describe your workday and interview a colleague about their schedule',
    'success_criteria', jsonb_build_array(
      'Can fluently describe your own routine',
      'Can ask natural follow-up questions',
      'Can respond to questions about your schedule',
      'Can handle conversational rhythm'
    ),
    'stages', jsonb_build_array(
      jsonb_build_object('type', 'lead_in', 'title', 'Unit 4 Review', 'timing', 5, 'instructions', 'Recall all routine-related language'),
      jsonb_build_object('type', 'focus_practice', 'title', 'Integrated Practice', 'timing', 10, 'instructions', 'Verbs, frequency, times, and questions'),
      jsonb_build_object('type', 'communicative_use', 'title', 'Full Routine Conversation Rehearsal', 'timing', 10, 'instructions', 'Practice telling and asking'),
      jsonb_build_object('type', 'assignment', 'title', 'Assessment: Describe Your Workday (Video)', 'timing', 10, 'instructions', 'Record 60 seconds: "My typical day is..."'),
      jsonb_build_object('type', 'assignment', 'title', 'Assessment: Interview a Colleague', 'timing', 10, 'instructions', 'Record a 3-minute conversation about routines'),
      jsonb_build_object('type', 'reflection', 'title', 'Reflect: Routines & Habits', 'timing', 5, 'instructions', 'What did you discover about yourself/others?')
    )
  ));

  -- ============ UNIT 5: Shopping Basics ============

  -- L1: Basic Items & Prices
  PERFORM populate_lesson_stages('A0-U5-L1', v_unit5_id, 0, jsonb_build_object(
    'goal', 'Ask for the price of an item and comprehend responses from $1 to $999',
    'success_criteria', jsonb_build_array(
      'Can name 10 common items (apple, coffee, sandwich, etc.)',
      'Can ask "How much is the...?"',
      'Can understand price responses',
      'Can discuss money and quantities'
    ),
    'stages', jsonb_build_array(
      jsonb_build_object('type', 'warm_up', 'title', 'Retrieval: Items & Money', 'timing', 5, 'instructions', 'Name shopping items you know'),
      jsonb_build_object('type', 'lead_in', 'title', 'Listen: Shopping Conversations', 'timing', 7, 'instructions', 'Hear customers asking about prices'),
      jsonb_build_object('type', 'input', 'title', 'Learn: 12 Common Items + "How much is...?"', 'timing', 11, 'instructions', 'Master shopping vocabulary and price question'),
      jsonb_build_object('type', 'comprehension', 'title', 'Listening: Identify Items & Prices', 'timing', 8, 'instructions', 'Hear descriptions and match to items'),
      jsonb_build_object('type', 'focus_practice', 'title', 'Item Vocabulary & Price Drills', 'timing', 10, 'instructions', 'Say items and their prices'),
      jsonb_build_object('type', 'communicative_use', 'title', 'Dialogue: Ask for a Price', 'timing', 7, 'instructions', 'Record asking about and discussing prices'),
      jsonb_build_object('type', 'assignment', 'title', 'Create a Shopping List', 'timing', 8, 'instructions', 'List 8-10 items you''d buy with approximate prices')
    )
  ));

  -- L2: Polite Requests in a Store
  PERFORM populate_lesson_stages('A0-U5-L2', v_unit5_id, 1, jsonb_build_object(
    'goal', 'Order food, drinks, or retail items using "would like" instead of "want"',
    'success_criteria', jsonb_build_array(
      'Can use "I''d like a coffee"',
      'Can say "Can I have...?"',
      'Can make polite requests',
      'Can interact with service staff appropriately'
    ),
    'stages', jsonb_build_array(
      jsonb_build_object('type', 'warm_up', 'title', 'Retrieval: Shopping Phrases', 'timing', 5, 'instructions', 'Recall polite expressions'),
      jsonb_build_object('type', 'lead_in', 'title', 'Listen: Polite Ordering in Action', 'timing', 7, 'instructions', 'Hear native speakers order politely'),
      jsonb_build_object('type', 'input', 'title', 'The "Would Like" Structure', 'timing', 11, 'instructions', 'Learn polite request forms'),
      jsonb_build_object('type', 'comprehension', 'title', 'Identify Polite vs. Impolite Requests', 'timing', 8, 'instructions', 'Match requests to their appropriateness'),
      jsonb_build_object('type', 'focus_practice', 'title', 'Practice Polite Ordering', 'timing', 10, 'instructions', 'Form polite requests for food/items'),
      jsonb_build_object('type', 'communicative_use', 'title', 'Role-Play: Order at a Café', 'timing', 8, 'instructions', 'Record ordering a drink and snack'),
      jsonb_build_object('type', 'assignment', 'title', 'Write Polite Requests', 'timing', 8, 'instructions', 'Write 5 polite order phrases')
    )
  ));

  -- L3: Checking Out & Payment
  PERFORM populate_lesson_stages('A0-U5-L3', v_unit5_id, 2, jsonb_build_object(
    'goal', 'State your payment method using correct prepositions and ask for a receipt',
    'success_criteria', jsonb_build_array(
      'Can say "I''ll pay with credit card / cash"',
      'Can ask "Can I get a receipt?"',
      'Can say "Thank you" appropriately',
      'Can confirm total amount'
    ),
    'stages', jsonb_build_array(
      jsonb_build_object('type', 'warm_up', 'title', 'Retrieval: Payment Vocabulary', 'timing', 5, 'instructions', 'Name payment methods'),
      jsonb_build_object('type', 'lead_in', 'title', 'Listen: Checkout Interactions', 'timing', 7, 'instructions', 'Hear full payment exchanges'),
      jsonb_build_object('type', 'input', 'title', 'Payment Phrases & Receipts', 'timing', 11, 'instructions', 'Master checkout language'),
      jsonb_build_object('type', 'comprehension', 'title', 'Understand Payment Requests', 'timing', 8, 'instructions', 'Recognize checkout questions'),
      jsonb_build_object('type', 'focus_practice', 'title', 'Practice Payment Interactions', 'timing', 10, 'instructions', 'Role-play checkout repeatedly'),
      jsonb_build_object('type', 'communicative_use', 'title', 'Full Checkout Dialogue', 'timing', 8, 'instructions', 'Record a complete purchase and payment'),
      jsonb_build_object('type', 'assignment', 'title', 'Dialogue Script: Paying for Items', 'timing', 8, 'instructions', 'Write a checkout conversation')
    )
  ));

  -- L4: Unit Performance Assessment
  PERFORM populate_lesson_stages('A0-U5-L4', v_unit5_id, 3, jsonb_build_object(
    'goal', 'Navigate a complete retail transaction from order to payment',
    'success_criteria', jsonb_build_array(
      'Can browse and discuss items fluently',
      'Can make polite requests',
      'Can negotiate price or quantity',
      'Can complete payment confidently'
    ),
    'stages', jsonb_build_array(
      jsonb_build_object('type', 'lead_in', 'title', 'Unit 5 Review', 'timing', 5, 'instructions', 'Recap all shopping scenarios'),
      jsonb_build_object('type', 'focus_practice', 'title', 'Integrated Shopping Drills', 'timing', 10, 'instructions', 'Items, prices, requests, and payment'),
      jsonb_build_object('type', 'communicative_use', 'title', 'Full Transaction Role-Play', 'timing', 10, 'instructions', 'Practice complete shopping experience'),
      jsonb_build_object('type', 'assignment', 'title', 'Assessment: Shopping Role-Play (Video)', 'timing', 12, 'instructions', 'Record a complete 2-3 minute transaction'),
      jsonb_build_object('type', 'assignment', 'title', 'Assessment: Shopping List + Written Exchange', 'timing', 10, 'instructions', 'Create list and write checkout dialogue'),
      jsonb_build_object('type', 'reflection', 'title', 'Reflect on Shopping Skills', 'timing', 5, 'instructions', 'Rate your confidence in each stage')
    )
  ));

  -- ============ UNIT 6: Getting Around (Directions & Transport) ============

  -- L1: Places in the City & Neighborhood
  PERFORM populate_lesson_stages('A0-U6-L1', v_unit6_id, 0, jsonb_build_object(
    'goal', 'Identify standard urban/corporate locations and describe their position',
    'success_criteria', jsonb_build_array(
      'Can name 10 common places (bank, supermarket, pharmacy, hospital, etc.)',
      'Can describe where a place is located',
      'Can ask "Where is the bank?"',
      'Can use directions vocabulary (near, next to, across from)'
    ),
    'stages', jsonb_build_array(
      jsonb_build_object('type', 'warm_up', 'title', 'Retrieval: Places You Know', 'timing', 5, 'instructions', 'Think of places in your city'),
      jsonb_build_object('type', 'lead_in', 'title', 'Listen: City Navigation Dialogue', 'timing', 7, 'instructions', 'Hear people asking about locations'),
      jsonb_build_object('type', 'input', 'title', 'Learn: 12 Common Urban Places', 'timing', 11, 'instructions', 'Master place names and prepositions'),
      jsonb_build_object('type', 'comprehension', 'title', 'Identify Places from Descriptions', 'timing', 8, 'instructions', 'Match definitions to locations'),
      jsonb_build_object('type', 'focus_practice', 'title', 'Place Vocabulary Drills', 'timing', 10, 'instructions', 'Say places and their locations'),
      jsonb_build_object('type', 'communicative_use', 'title', 'Describe Your Neighborhood', 'timing', 7, 'instructions', 'Record describing 5 nearby places'),
      jsonb_build_object('type', 'assignment', 'title', 'Map Your Neighborhood', 'timing', 8, 'instructions', 'Describe locations of 8 nearby places')
    )
  ));

  -- L2: Basic Directions
  PERFORM populate_lesson_stages('A0-U6-L2', v_unit6_id, 1, jsonb_build_object(
    'goal', 'Issue and comprehend clear directional commands using imperative verbs',
    'success_criteria', jsonb_build_array(
      'Can use imperatives: "Turn left, go straight, turn right"',
      'Can give step-by-step directions',
      'Can understand direction requests',
      'Can describe routes simply'
    ),
    'stages', jsonb_build_array(
      jsonb_build_object('type', 'warm_up', 'title', 'Retrieval: Direction Words', 'timing', 5, 'instructions', 'Name direction verbs and phrases'),
      jsonb_build_object('type', 'lead_in', 'title', 'Listen: Giving Directions Step-by-Step', 'timing', 7, 'instructions', 'Hear natural direction-giving'),
      jsonb_build_object('type', 'input', 'title', 'Imperative Verbs for Directions', 'timing', 11, 'instructions', 'Master turn, go, cross, continue'),
      jsonb_build_object('type', 'comprehension', 'title', 'Follow Directions on a Map', 'timing', 8, 'instructions', 'Trace routes from verbal directions'),
      jsonb_build_object('type', 'focus_practice', 'title', 'Give Directions with Imperatives', 'timing', 10, 'instructions', 'Create step-by-step directions'),
      jsonb_build_object('type', 'communicative_use', 'title', 'Dialogue: Guide Someone', 'timing', 8, 'instructions', 'Record giving directions clearly'),
      jsonb_build_object('type', 'assignment', 'title', 'Write Directions to a Place', 'timing', 8, 'instructions', 'Give 4-5 steps to a familiar location')
    )
  ));

  -- L3: Asking for Help
  PERFORM populate_lesson_stages('A0-U6-L3', v_unit6_id, 2, jsonb_build_object(
    'goal', 'Politely interrupt a stranger to ask for directions to a specific location',
    'success_criteria', jsonb_build_array(
      'Can politely get someone''s attention: "Excuse me"',
      'Can ask "Could you tell me where the bank is?"',
      'Can confirm understanding of directions',
      'Can say thank you appropriately'
    ),
    'stages', jsonb_build_array(
      jsonb_build_object('type', 'warm_up', 'title', 'Retrieval: Polite Phrases', 'timing', 5, 'instructions', 'Recall polite openings'),
      jsonb_build_object('type', 'lead_in', 'title', 'Listen: Polite Direction Requests', 'timing', 7, 'instructions', 'Hear natural, polite way to ask'),
      jsonb_build_object('type', 'input', 'title', 'The Formula: "Excuse me... Could you...?"', 'timing', 11, 'instructions', 'Learn polite request structure'),
      jsonb_build_object('type', 'comprehension', 'title', 'Understand Request Variations', 'timing', 8, 'instructions', 'Recognize different politeness levels'),
      jsonb_build_object('type', 'focus_practice', 'title', 'Form Polite Direction Requests', 'timing', 10, 'instructions', 'Create 10 different polite questions'),
      jsonb_build_object('type', 'communicative_use', 'title', 'Role-Play: Ask a Stranger', 'timing', 8, 'instructions', 'Record asking and getting help'),
      jsonb_build_object('type', 'assignment', 'title', 'Write Polite Direction Requests', 'timing', 8, 'instructions', 'Write 3 ways to ask for directions')
    )
  ));

  -- L4: Unit Performance Assessment
  PERFORM populate_lesson_stages('A0-U6-L4', v_unit6_id, 3, jsonb_build_object(
    'goal', 'Navigate a foreign environment by asking for and giving clear directions',
    'success_criteria', jsonb_build_array(
      'Can find locations in an unfamiliar place',
      'Can ask and understand directions fluently',
      'Can give directions clearly',
      'Can handle confusing situations'
    ),
    'stages', jsonb_build_array(
      jsonb_build_object('type', 'lead_in', 'title', 'Unit 6 Review', 'timing', 5, 'instructions', 'Recap all navigation vocabulary'),
      jsonb_build_object('type', 'focus_practice', 'title', 'Integrated Navigation Drills', 'timing', 10, 'instructions', 'Places, directions, requests combined'),
      jsonb_build_object('type', 'communicative_use', 'title', 'Full Navigation Scenario', 'timing', 10, 'instructions', 'Practice asking and giving directions'),
      jsonb_build_object('type', 'assignment', 'title', 'Assessment: Ask for Directions (Audio)', 'timing', 10, 'instructions', 'Record asking multiple locals for directions'),
      jsonb_build_object('type', 'assignment', 'title', 'Assessment: Give a Route (Video)', 'timing', 10, 'instructions', 'Record giving clear step-by-step directions'),
      jsonb_build_object('type', 'reflection', 'title', 'Reflect on A0 Complete', 'timing', 5, 'instructions', 'What was your biggest achievement?')
    )
  ));

  RAISE NOTICE 'A0 lessons population complete: 24 lessons with full stages, 6-8 stages per lesson';

END $$;

-- Add a function placeholder for populate_lesson_stages if not exists
CREATE OR REPLACE FUNCTION populate_lesson_stages(
  p_lesson_code TEXT,
  p_unit_id UUID,
  p_sort_order INT,
  p_metadata JSONB
)
RETURNS VOID
LANGUAGE plpgsql
AS $$
DECLARE
  v_lesson_id UUID;
  v_stage_record JSONB;
  v_stage_sort INT;
BEGIN
  -- Find or create lesson
  SELECT id INTO v_lesson_id
  FROM lessons
  WHERE unit_id = p_unit_id
  AND sort_order = p_sort_order;

  IF v_lesson_id IS NULL THEN
    RAISE NOTICE 'Lesson not found for unit % with sort_order %', p_unit_id, p_sort_order;
    RETURN;
  END IF;

  -- Update lesson metadata
  UPDATE lessons
  SET
    goal = p_metadata->>'goal',
    success_criteria = (p_metadata->'success_criteria')::jsonb,
    updated_at = now()
  WHERE id = v_lesson_id;

  -- Insert stages from metadata array
  v_stage_sort := 0;
  FOR v_stage_record IN
    SELECT jsonb_array_elements(p_metadata->'stages')
  LOOP
    INSERT INTO lesson_stages (
      lesson_id,
      stage_type,
      title,
      instructions,
      timing_minutes,
      content,
      sort_order
    ) VALUES (
      v_lesson_id,
      v_stage_record->>'type',
      v_stage_record->>'title',
      v_stage_record->>'instructions',
      (v_stage_record->>'timing')::INT,
      v_stage_record->'content',
      v_stage_sort
    );
    v_stage_sort := v_stage_sort + 1;
  END LOOP;

  RAISE NOTICE 'Populated lesson % with % stages', p_lesson_code, v_stage_sort;

END $$;
