// English Mastery Lab - Seed Data
// Initial course structure with CEFR levels A0-C2

import { 
  CEFRLevel, 
  Level, 
  Unit, 
  LexiconEntry, 
  GrammarChapter, 
  ShadowingScript, 
  PragmaticsPack,
  InterculturalCaseStudy
} from '@/types/course';

export const CEFR_LEVEL_CONFIG: Record<CEFRLevel, { 
  name: string; 
  description: string; 
  color: string;
  gradient: string;
  unitCount: number;
  hoursEstimate: number;
}> = {
  A0: {
    name: 'Pre-A1 (Breakthrough)',
    description: 'First steps in English. Basic survival phrases and foundational vocabulary.',
    color: 'hsl(var(--level-a0))',
    gradient: 'from-purple-500 to-violet-600',
    unitCount: 6,
    hoursEstimate: 30,
  },
  A1: {
    name: 'A1 (Elementary)',
    description: 'Simple everyday expressions and basic phrases for practical needs.',
    color: 'hsl(var(--level-a1))',
    gradient: 'from-violet-500 to-indigo-600',
    unitCount: 10,
    hoursEstimate: 50,
  },
  A2: {
    name: 'A2 (Pre-Intermediate)',
    description: 'Routine tasks and direct exchange of information on familiar topics.',
    color: 'hsl(var(--level-a2))',
    gradient: 'from-blue-500 to-cyan-600',
    unitCount: 10,
    hoursEstimate: 60,
  },
  B1: {
    name: 'B1 (Intermediate)',
    description: 'Handle most travel situations, describe experiences, give reasons and explanations.',
    color: 'hsl(var(--level-b1))',
    gradient: 'from-teal-500 to-emerald-600',
    unitCount: 10,
    hoursEstimate: 80,
  },
  B2: {
    name: 'B2 (Upper-Intermediate)',
    description: 'Interact with fluency and spontaneity, produce detailed text on wide range of subjects.',
    color: 'hsl(var(--level-b2))',
    gradient: 'from-emerald-500 to-green-600',
    unitCount: 10,
    hoursEstimate: 100,
  },
  C1: {
    name: 'C1 (Advanced)',
    description: 'Express ideas fluently and spontaneously without obvious searching for expressions.',
    color: 'hsl(var(--level-c1))',
    gradient: 'from-amber-500 to-orange-600',
    unitCount: 8,
    hoursEstimate: 120,
  },
  C2: {
    name: 'C2 (Mastery)',
    description: 'Understand with ease virtually everything heard or read. Express precisely and fluently.',
    color: 'hsl(var(--level-c2))',
    gradient: 'from-orange-500 to-red-600',
    unitCount: 8,
    hoursEstimate: 150,
  },
};

export const SEED_UNITS: Record<CEFRLevel, Array<{ title: string; theme: string; flagshipTask: string }>> = {
  A0: [
    { title: 'Who Am I?', theme: 'Identity', flagshipTask: 'Introduce yourself with basic information' },
    { title: 'What Time Is It?', theme: 'Time', flagshipTask: 'Ask and tell the time in daily contexts' },
    { title: 'My Home', theme: 'Home', flagshipTask: 'Describe your living space with basic vocabulary' },
    { title: 'Daily Routines', theme: 'Routines', flagshipTask: 'Describe your typical day using simple present' },
    { title: 'At the Shop', theme: 'Shopping', flagshipTask: 'Complete a basic shopping transaction' },
    { title: 'Getting Around', theme: 'Directions', flagshipTask: 'Ask for and give simple directions' },
  ],
  A1: [
    { title: 'Family & Friends', theme: 'Relationships', flagshipTask: 'Describe your family and close relationships' },
    { title: 'At the Restaurant', theme: 'Ordering', flagshipTask: 'Order food and drinks in a restaurant' },
    { title: 'My Neighborhood', theme: 'Neighborhood', flagshipTask: 'Describe places in your neighborhood' },
    { title: 'Shopping Preferences', theme: 'Shopping', flagshipTask: 'Express preferences when shopping' },
    { title: 'Health Basics', theme: 'Health', flagshipTask: 'Describe basic health problems and symptoms' },
    { title: 'Making Plans', theme: 'Invitations', flagshipTask: 'Invite someone and respond to invitations' },
    { title: 'Work & Study', theme: 'Work/Study', flagshipTask: 'Describe your job or studies' },
    { title: 'Free Time', theme: 'Hobbies', flagshipTask: 'Talk about hobbies and interests' },
    { title: 'Travel Plans', theme: 'Travel', flagshipTask: 'Book transportation and accommodation' },
    { title: 'Staying Connected', theme: 'Communication', flagshipTask: 'Use basic communication tools' },
  ],
  A2: [
    { title: 'Past Experiences', theme: 'Past Experiences', flagshipTask: 'Share a memorable experience from your past' },
    { title: 'Problem Solving', theme: 'Services', flagshipTask: 'Report a problem with a product or service' },
    { title: 'Making Appointments', theme: 'Appointments', flagshipTask: 'Schedule and confirm appointments' },
    { title: 'Finding a Place', theme: 'Renting', flagshipTask: 'Inquire about and rent accommodation' },
    { title: 'Travel Changes', theme: 'Travel Changes', flagshipTask: 'Handle changes to travel plans' },
    { title: 'Being a Host', theme: 'Hosting/Etiquette', flagshipTask: 'Host guests with appropriate etiquette' },
    { title: 'Future Goals', theme: 'Goals', flagshipTask: 'Describe your plans and aspirations' },
    { title: 'Office Life', theme: 'Workplace', flagshipTask: 'Navigate workplace routines and requests' },
    { title: 'Tech Support', theme: 'Tech Issues', flagshipTask: 'Describe and troubleshoot tech problems' },
    { title: 'Rules & Regulations', theme: 'Rules', flagshipTask: 'Understand and explain rules' },
  ],
  B1: [
    { title: 'Storytelling', theme: 'Narratives', flagshipTask: 'Tell an engaging personal story with structure' },
    { title: 'Making Decisions', theme: 'Decisions', flagshipTask: 'Discuss options and make group decisions' },
    { title: 'Meeting Coordination', theme: 'Coordination', flagshipTask: 'Run a short coordination meeting' },
    { title: 'Complaint Emails', theme: 'Complaints', flagshipTask: 'Write an effective complaint email' },
    { title: 'Wellbeing at Work', theme: 'Wellbeing', flagshipTask: 'Discuss work-life balance issues' },
    { title: 'Travel Challenges', theme: 'Travel Problems', flagshipTask: 'Handle unexpected travel problems' },
    { title: 'Conflict Resolution', theme: 'Conflict Repair', flagshipTask: 'Resolve a minor disagreement professionally' },
    { title: 'Current Events', theme: 'News/Opinions', flagshipTask: 'Discuss news and give opinions' },
    { title: 'Presenting Ideas', theme: 'Presentations', flagshipTask: 'Deliver a 3-minute presentation' },
    { title: 'Community Involvement', theme: 'Civic Life', flagshipTask: 'Participate in community discussions' },
  ],
  B2: [
    { title: 'Making Proposals', theme: 'Proposals', flagshipTask: 'Present a business proposal with supporting arguments' },
    { title: 'Explaining Processes', theme: 'Processes', flagshipTask: 'Explain a complex process clearly' },
    { title: 'Negotiation Skills', theme: 'Negotiation', flagshipTask: 'Negotiate terms in a professional context' },
    { title: 'Cross-Cultural Communication', theme: 'Intercultural', flagshipTask: 'Navigate a cross-cultural interaction' },
    { title: 'Building Credibility', theme: 'Credibility', flagshipTask: 'Present yourself as a credible expert' },
    { title: 'Rights & Responsibilities', theme: 'Rights', flagshipTask: 'Discuss rights and advocate for needs' },
    { title: 'Technology & Change', theme: 'Tech Change', flagshipTask: 'Discuss technological impact on society' },
    { title: 'Social Issues', theme: 'Society', flagshipTask: 'Debate a social issue with nuance' },
    { title: 'Career Development', theme: 'Career', flagshipTask: 'Discuss career trajectory and goals' },
    { title: 'Project Reporting', theme: 'Reporting', flagshipTask: 'Deliver a project status report' },
  ],
  C1: [
    { title: 'Nuance & Moderation', theme: 'Nuanced Discussion', flagshipTask: 'Moderate a complex discussion fairly' },
    { title: 'Problem Framing', theme: 'Problem Analysis', flagshipTask: 'Frame and analyze complex problems' },
    { title: 'Argument & Counterargument', theme: 'Argumentation', flagshipTask: 'Construct and rebut sophisticated arguments' },
    { title: 'Leadership Communication', theme: 'Leadership', flagshipTask: 'Communicate as a leader in challenging situations' },
    { title: 'Rhetoric & Bias', theme: 'Critical Analysis', flagshipTask: 'Identify and discuss rhetorical strategies' },
    { title: 'Policy Discussion', theme: 'Policy', flagshipTask: 'Participate in policy discussion with precision' },
    { title: 'Advanced Intercultural', theme: 'Intercultural', flagshipTask: 'Navigate complex intercultural dynamics' },
    { title: 'C1 Capstone', theme: 'Capstone', flagshipTask: 'Complete a major integrated project' },
  ],
  C2: [
    { title: 'Rhetorical Mastery', theme: 'Rhetoric', flagshipTask: 'Deliver a compelling persuasive speech' },
    { title: 'High-Stakes Interaction', theme: 'Pressure Situations', flagshipTask: 'Handle high-pressure professional situations' },
    { title: 'Synthesis & Integration', theme: 'Synthesis', flagshipTask: 'Synthesize complex information from multiple sources' },
    { title: 'Style & Register', theme: 'Stylistic Range', flagshipTask: 'Demonstrate full stylistic range across contexts' },
    { title: 'Dense Listening', theme: 'Complex Input', flagshipTask: 'Process and respond to dense academic content' },
    { title: 'Ethics & Dilemmas', theme: 'Ethics', flagshipTask: 'Navigate complex ethical discussions' },
    { title: 'Specialized Domains', theme: 'Electives', flagshipTask: 'Apply language skills in specialized domain' },
    { title: 'C2 Capstone', theme: 'Mastery Capstone', flagshipTask: 'Complete a comprehensive mastery demonstration' },
  ],
};

export const SAMPLE_LEXICON_ENTRIES: LexiconEntry[] = [
  {
    id: 'lex-001',
    headword: 'schedule',
    type: 'lemma',
    partOfSpeech: 'noun/verb',
    cefrReceptive: 'A2',
    cefrProductive: 'B1',
    ipa: '/ˈʃedjuːl/ (UK), /ˈskedʒuːl/ (US)',
    stress: 'first syllable',
    definitionSimple: 'A plan that shows when things will happen',
    definitionTeacher: 'A timetable or program of planned activities, events, or work; also used as a verb meaning to arrange for something to happen at a particular time',
    usageNotes: 'Common in both work and personal contexts. US/UK pronunciation differs significantly.',
    register: 'neutral',
    variety: 'international',
    examples: [
      'What\'s on the schedule for today?',
      'I need to schedule a meeting with the team.',
      'The flight is scheduled to depart at 8 AM.',
    ],
    collocations: ['lex-002', 'lex-003'],
    patterns: ['schedule + noun', 'schedule + to infinitive', 'on schedule', 'behind schedule'],
    topicTags: ['work', 'time', 'planning'],
    unitTags: ['A2-3', 'B1-4'],
    overlayTags: ['core', 'professional'],
    frequencyBand: 2,
    audioUrl: '/audio/lexicon/schedule.mp3',
    introducedInUnit: 'A2-3',
    recycledInUnits: ['A2-7', 'B1-4', 'B1-9'],
  },
  {
    id: 'lex-002',
    headword: 'tight schedule',
    type: 'collocation',
    partOfSpeech: 'noun phrase',
    cefrReceptive: 'B1',
    cefrProductive: 'B1',
    ipa: '/taɪt ˈʃedjuːl/',
    stress: 'adjective + noun',
    definitionSimple: 'A very busy plan with little free time',
    definitionTeacher: 'A schedule with many commitments and little flexibility; often implies stress or difficulty fitting additional items in',
    usageNotes: 'Used to politely decline or explain constraints.',
    register: 'neutral',
    variety: 'international',
    examples: [
      'I have a tight schedule this week, but I can meet briefly on Friday.',
      'We\'re on a tight schedule, so let\'s start the meeting.',
    ],
    collocations: ['lex-001'],
    patterns: ['have a tight schedule', 'be on a tight schedule'],
    topicTags: ['work', 'time'],
    unitTags: ['B1-4'],
    overlayTags: ['core', 'professional'],
    frequencyBand: 3,
    introducedInUnit: 'B1-4',
    recycledInUnits: ['B1-9', 'B2-3'],
  },
  {
    id: 'lex-003',
    headword: 'reschedule',
    type: 'lemma',
    partOfSpeech: 'verb',
    cefrReceptive: 'A2',
    cefrProductive: 'B1',
    ipa: '/riːˈʃedjuːl/',
    stress: 're-SCHE-dule',
    definitionSimple: 'To change the time of a planned event',
    definitionTeacher: 'To arrange for a scheduled event to take place at a different time',
    usageNotes: 'Often used with appointments, meetings, flights.',
    register: 'neutral',
    variety: 'international',
    examples: [
      'Can we reschedule our meeting to next week?',
      'The conference has been rescheduled due to weather.',
    ],
    collocations: ['lex-001'],
    patterns: ['reschedule + noun', 'reschedule + for + time', 'reschedule + to + time'],
    topicTags: ['work', 'appointments', 'planning'],
    unitTags: ['A2-5', 'B1-4'],
    overlayTags: ['core', 'professional'],
    frequencyBand: 3,
    audioUrl: '/audio/lexicon/reschedule.mp3',
    introducedInUnit: 'A2-5',
    recycledInUnits: ['B1-4', 'B1-6'],
  },
];

export const SAMPLE_GRAMMAR_CHAPTERS: GrammarChapter[] = [
  {
    id: 'A1.G.01',
    cefrLevel: 'A1',
    title: 'Present Simple: Be',
    form: 'I am, you are, he/she/it is, we/they are + adjective/noun/location',
    meaning: 'States facts, describes people/things, indicates location or identity',
    use: 'Introductions, descriptions, permanent states',
    contrast: 'vs. present continuous for temporary states',
    commonErrors: [
      'Using "have" instead of "be" for age: *I have 25 years → I am 25 years old',
      'Missing "be" verb: *She happy → She is happy',
      'Wrong form: *He are → He is',
    ],
    microPractice: [
      { id: 'mp1', type: 'cloze', question: 'My name ___ Maria. I ___ from Spain.', correctAnswer: ['is', 'am'] },
    ],
    taskUpgrades: ['Describe your family using be + adjectives', 'Introduce a colleague with be + job title'],
    crossLinks: ['A1.G.02', 'A2.G.05'],
    order: 1,
  },
  {
    id: 'A2.G.05',
    cefrLevel: 'A2',
    title: 'Past Simple: Regular and Irregular',
    form: 'Subject + verb-ed (regular) or irregular past form',
    meaning: 'Completed actions in the past with finished time reference',
    use: 'Narrating past events, telling stories, describing completed actions',
    contrast: 'vs. present perfect for recent/relevant past; vs. past continuous for background actions',
    commonErrors: [
      'Using present tense for past: *Yesterday I go → Yesterday I went',
      'Adding -ed to irregulars: *I goed → I went',
      'Wrong auxiliary in questions: *Did you went? → Did you go?',
    ],
    microPractice: [
      { id: 'mp1', type: 'cloze', question: 'Last week, I ___ (visit) my grandmother and we ___ (have) lunch together.', correctAnswer: ['visited', 'had'] },
    ],
    taskUpgrades: ['Tell a story about a memorable trip', 'Describe what you did last weekend'],
    crossLinks: ['A1.G.01', 'B1.G.03'],
    order: 5,
  },
  {
    id: 'B1.G.03',
    cefrLevel: 'B1',
    title: 'Present Perfect vs Past Simple',
    form: 'has/have + past participle vs. verb-ed/irregular past',
    meaning: 'Experience and recent relevance vs. completed past action',
    use: 'Talking about life experiences without time vs. narrating specific past events',
    contrast: 'Time markers: ever/never/already/yet (PP) vs. yesterday/last week/ago (PS)',
    commonErrors: [
      'Using PP with finished time: *I have seen him yesterday → I saw him yesterday',
      'Using PS for recent relevance: *I lost my keys (still looking) → I have lost my keys',
      'Wrong participle: *I have went → I have gone',
    ],
    microPractice: [
      { id: 'mp1', type: 'mcq', question: 'I ___ to Paris three times.', options: ['went', 'have been', 'have went', 'was'], correctAnswer: 'have been' },
    ],
    taskUpgrades: ['Discuss your work experience in an interview', 'Explain recent achievements and their relevance'],
    crossLinks: ['A2.G.05', 'B2.G.01'],
    order: 3,
  },
];

export const SAMPLE_SHADOWING_SCRIPTS: ShadowingScript[] = [
  {
    id: 'shad-001',
    type: 'micro',
    text: 'Nice to meet you.',
    chunkedVersion: 'Nice | to meet | you.',
    stressMarkedVersion: 'NICE to MEET you.',
    focusTags: ['greetings', 'intonation'],
    unitTags: ['A0-1'],
    speedPlan: 'Start at 50%, increase to 100%',
    audioUrl: '/audio/shadowing/nice-to-meet-you.mp3',
    duration: 3,
  },
  {
    id: 'shad-002',
    type: 'chunk',
    text: "I'd like to make a reservation for two people, please. Could you tell me what times are available?",
    chunkedVersion: "I'd like | to make a reservation | for two people, | please. || Could you tell me | what times | are available?",
    stressMarkedVersion: "I'd like to make a reserVAtion for TWO people, PLEASE. Could you TELL me what TIMES are aVAILable?",
    focusTags: ['requests', 'polite forms', 'connected speech'],
    unitTags: ['A1-2'],
    speedPlan: 'Practice chunk by chunk, then combine at 70%, then full speed',
    audioUrl: '/audio/shadowing/reservation.mp3',
    duration: 8,
  },
  {
    id: 'shad-003',
    type: 'dialogue',
    text: `A: I was wondering if we could reschedule our meeting? Something's come up.
B: Of course, no problem. When would work better for you?
A: Would Thursday afternoon be possible?
B: Let me check... Yes, that works. Shall we say 2 PM?
A: Perfect. I really appreciate your flexibility.`,
    chunkedVersion: `A: I was wondering | if we could reschedule | our meeting? || Something's come up.
B: Of course, | no problem. || When would work | better for you?
A: Would Thursday afternoon | be possible?
B: Let me check... || Yes, that works. || Shall we say | 2 PM?
A: Perfect. || I really appreciate | your flexibility.`,
    stressMarkedVersion: `A: I was WONdering if we could reSCHEDule our MEETing? Something's COME up.
B: Of COURSE, no PROBlem. WHEN would work BETter for you?
A: Would THURSday afterNOON be POSSible?
B: Let me CHECK... YES, that WORKS. Shall we SAY 2 PM?
A: PERfect. I REally apPREciate your flexiBIlity.`,
    focusTags: ['polite requests', 'scheduling', 'intonation patterns', 'hedging'],
    unitTags: ['A2-3', 'B1-4'],
    speedPlan: 'Role A first at 60%, then Role B, then alternate, then full speed',
    audioUrl: '/audio/shadowing/reschedule-dialogue.mp3',
    duration: 25,
  },
];

export const SAMPLE_PRAGMATICS_PACK: PragmaticsPack = {
  id: 'pci-requests',
  speechAct: 'requests',
  title: 'Making Requests',
  description: 'Learn to make requests appropriately across different registers and contexts, from casual to formal.',
  registerLadder: [
    {
      level: 'direct',
      examples: [
        'Give me the report.',
        'Send the email.',
        'Call me later.',
      ],
      notes: 'Use only with close friends or in emergencies. Can sound rude in professional contexts.',
    },
    {
      level: 'softened',
      examples: [
        'Can you give me the report?',
        'Could you send the email when you have a moment?',
        'Would you mind calling me later?',
      ],
      notes: 'Appropriate for most everyday and workplace interactions with colleagues.',
    },
    {
      level: 'formal',
      examples: [
        'I was wondering if you could send me the report at your earliest convenience.',
        'Would it be possible to have the email sent by Friday?',
        'I would greatly appreciate it if you could contact me at your convenience.',
      ],
      notes: 'Use for senior colleagues, clients, formal written communication.',
    },
  ],
  mediumGuides: [
    {
      medium: 'email',
      conventions: [
        'Use greeting and sign-off',
        'State context before request',
        'Include deadline if needed',
        'Thank in advance',
      ],
      examples: [
        'Dear Mr. Smith, I hope this email finds you well. I am writing to request... I would appreciate if this could be done by... Thank you in advance for your assistance.',
      ],
    },
    {
      medium: 'chat',
      conventions: [
        'Can be more direct but still polite',
        'Use please and thank you',
        'Acknowledge if timing is bad',
      ],
      examples: [
        'Hey, quick question - could you send me the file when you get a sec? No rush if you\'re busy!',
      ],
    },
  ],
  items: [
    {
      id: 'req-001',
      phrase: 'Could you possibly...',
      register: 'softened',
      context: 'Everyday requests to colleagues',
      appropriateFor: ['colleagues', 'acquaintances'],
      avoidWhen: ['very formal contexts', 'written to senior executives'],
    },
    {
      id: 'req-002',
      phrase: 'I was wondering if you might be able to...',
      register: 'formal',
      context: 'Formal requests, especially written',
      appropriateFor: ['seniors', 'clients', 'formal emails'],
      avoidWhen: ['casual conversation', 'time pressure'],
    },
  ],
};

export const SAMPLE_CASE_STUDY: InterculturalCaseStudy = {
  id: 'ics-001',
  title: 'The Missed Deadline',
  scenario: `Maria, from Spain, is working on a project with Kenji from Japan and Tom from the US. The deadline for a deliverable was yesterday, but Maria hasn't received Kenji's part. When she asks Kenji about it, he says, "It's a bit difficult at the moment." Tom suggests they should "just push the deadline back" and asks Kenji to "give us a heads up next time." The next day, Kenji submits the work but seems withdrawn in the team meeting.`,
  interpretations: [
    'Kenji\'s "It\'s a bit difficult" may have been an indirect way of asking for help or signaling a problem, which was not picked up by the team.',
    'Tom\'s direct suggestion to "push back" and give a "heads up" may have come across as criticism to Kenji, causing loss of face.',
    'Maria\'s direct question about the missing work may have put Kenji in an uncomfortable position.',
    'The withdrawal in the meeting could indicate Kenji felt embarrassed or that the issue wasn\'t handled in a face-saving way.',
  ],
  reflectionQuestions: [
    'How might you interpret "It\'s a bit difficult" in your culture? What might it mean in other contexts?',
    'What could the team have done differently when they noticed the delay?',
    'How can direct and indirect communication styles work together in international teams?',
  ],
  rolePlayTasks: [
    'Role-play the scenario where Maria checks in with Kenji in a more indirect, face-saving way.',
    'Role-play a team meeting where Tom addresses deadline concerns without singling anyone out.',
  ],
  cefrLevel: 'B2',
};
