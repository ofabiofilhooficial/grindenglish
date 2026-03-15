// Generate B1.G.21 through B1.G.32 SQL INSERT statements

const lessons = [
  {
    code: 'B1.G.21',
    title: 'Articles III',
    form: `Rule 1: General vs. Specific (Plurals & Noncount nouns)
Zero Article (Ø): Talking about things in general.
Ø Computers are expensive. (All computers in the world).
Ø Love is complicated. (The concept of love).
The: Talking about specific things both the speaker and listener know.
The computers in this office are slow. (Specific ones).

Rule 2: Institutional Nouns (Places of purpose)
When you go to a place for its primary purpose, use the Zero Article (Ø).
go to Ø work (to do your job)
go to Ø bed (to sleep)
go to Ø school (to study)
go to Ø prison (as a prisoner)`,
    meaning: `Articles tell the listener if you are pulling a specific file out of a cabinet ("the"), talking about a random file ("a/an"), or talking about the concept of files existing in the universe ("zero").`,
    use: `Only use the when you can mentally point at the object and say, "You know exactly which one I mean."`,
    contrast: `General vs. Specific
I love Ø dogs. (All dogs).
I love the dogs next door. (Those two specific animals).`,
    errors: `Error: Putting "the" in front of general plural nouns or abstract concepts (The life is hard / The Brazilians love soccer).
Fix: Drop the article. (Life is hard / Brazilians love soccer).

L1 Transfer Note: Portuguese demands definite articles for general statements (A vida é dura / Os brasileiros amam futebol). This makes English sound completely wrong to Brazilian ears. This rule requires constant, conscious correction until it feels natural.`,
    hook: `Make broad, philosophical statements about life, society, and business.
Talk about daily routines involving institutions (work, school, hospital).
Polish your writing to remove distracting, unnatural errors.`,
    upgrades: `Starter: The time is money. → Upgrade: As they say, time is money.
Starter: I go to the work at 8. → Upgrade: I head into work around 8.`,
    micro: `[{"type":"fill_blank","prompt":"The money makes the world go round. (Cross out "The" if incorrect)","answer":"money makes the world go round","feedback":"Don''t use the with general plural nouns."},{"type":"fill_blank","prompt":"Where is the money I left on the table? (Cross out "The" if incorrect)","answer":"Where is the money I left on the table?","feedback":"Use the when referring to specific items."},{"type":"mini_output","prompt":"Speaking: State three general facts or opinions about your industry or hobby without using "the".","answer":"Example: Software engineering requires patience.","feedback":"Your statements should use zero article for general concepts."}]`,
    links: `[{"type":"prerequisite","chapter_code":"A1.G.05","note":null},{"type":"prerequisite","chapter_code":"A2.G.10","note":null},{"type":"advanced","chapter_code":"B2.G.20","note":"Article nuance B2 polish"}]`,
    sort: 21
  },
  {
    code: 'B1.G.22',
    title: 'Preposition Patterns (Expanded)',
    form: `Verbs and adjectives in English often lock onto a specific preposition. These are called "dependent prepositions." You must memorize the pair as a single unit.

High-Frequency B1 Pairs:
depend ON (not of)
rely ON
agree WITH a person / agree ON a topic
focus ON (not in)
pay FOR an item
wait FOR a person/thing
good AT a skill (not in)
responsible FOR a task

Rule: If a verb comes immediately after these prepositions, it MUST be in the -ing form.
I am responsible for managing the team.
She is good at solving problems.`,
    meaning: `These prepositions don''t always carry their normal spatial meaning (like "on the table"). They act as grammatical glue that connects the verb to its object.`,
    use: `These pairs are completely arbitrary. They evolved through history, not logic. The only way to choose the right one is to memorize the combination.`,
    contrast: `Pay the bill (Direct object - no preposition)
Pay FOR the coffee (Item - needs ''for'')`,
    errors: `Error: Direct translation of the preposition from the native language.

L1 Transfer Note: Portuguese speakers constantly say depend of (depende de), focus in (focar em), and good in (bom em). You must rewire these connections. Create a mental link between the English verb and the English preposition from day one.

Error: Using the infinitive after a preposition (I am responsible for to lead).
Fix: Prepositions are allergic to the base verb. Always use the -ing noun form.`,
    hook: `Use verbs correctly without having to pause and translate.
Express agreement, dependence, and focus in professional settings.
Sound highly accurate and idiomatic.`,
    upgrades: `Starter: It depends of the price. → Upgrade: That really depends on the price.
Starter: I agree with you. → Upgrade: I couldn''t agree with you more.`,
    micro: `[{"type":"multiple_choice","prompt":"We need to focus (in / on / at) the new marketing strategy.","options":["in","on","at"],"answer":"on","feedback":"Use focus on for the correct preposition."},{"type":"multiple_choice","prompt":"I am waiting (to / for / by) the manager to approve this.","options":["to","for","by"],"answer":"for","feedback":"Use wait for for the correct preposition."},{"type":"mini_output","prompt":"Speaking: Role-play a discussion about a project timeline. Use depend on, focus on, and agree with to negotiate the details.","answer":"Example: This depends on the budget. We need to focus on the deadline. I agree with your timeline.","feedback":"Your response should use the correct dependent prepositions."}]`,
    links: `[{"type":"prerequisite","chapter_code":"A2.G.19","note":null},{"type":"advanced","chapter_code":"B2.G.21","note":"Preposition nuance"}]`,
    sort: 22
  }
];

console.log('-- Insert B1.G.21 through B1.G.32');
console.log('INSERT INTO public.grammar_chapters (');
console.log('  chapter_code,');
console.log('  title,');
console.log('  cefr_level,');
console.log('  form_content,');
console.log('  meaning_content,');
console.log('  use_content,');
console.log('  contrast_notes,');
console.log('  common_errors,');
console.log('  diagnostic_hook,');
console.log('  task_upgrades,');
console.log('  micro_practice,');
console.log('  cross_links,');
console.log('  is_published,');
console.log('  sort_order');
console.log(')');
console.log('SELECT * FROM (VALUES');

lessons.forEach((lesson, idx) => {
  const comma = idx < lessons.length - 1 ? ',' : '';
  console.log(`  ('${lesson.code}', '${lesson.title}', 'B1', '${lesson.form.replace(/'/g, "''")}', '${lesson.meaning.replace(/'/g, "''")}', '${lesson.use.replace(/'/g, "''")}', '${lesson.contrast.replace(/'/g, "''")}', '${lesson.errors.replace(/'/g, "''")}', '${lesson.hook.replace(/'/g, "''")}', '${lesson.upgrades.replace(/'/g, "''")}', '${lesson.micro}'::jsonb, '${lesson.links}'::jsonb, true, ${lesson.sort})${comma}`);
});

console.log(`) AS new_chapters(chapter_code, title, cefr_level, form_content, meaning_content, use_content, contrast_notes, common_errors, diagnostic_hook, task_upgrades, micro_practice, cross_links, is_published, sort_order)`);
console.log('WHERE NOT EXISTS (');
console.log('  SELECT 1 FROM public.grammar_chapters');
console.log('  WHERE chapter_code = new_chapters.chapter_code');
console.log(');');
