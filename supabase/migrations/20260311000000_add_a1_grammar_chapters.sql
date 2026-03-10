-- Add A1 Grammar Lessons
-- This migration adds 24 A1-level grammar lessons to the grammar_chapters table.
-- The lessons cover essential elementary grammar topics including verb tenses,
-- possessive structures, modals, comparatives, prepositions, and question formation.
--
-- IDEMPOTENCY: This migration uses WHERE NOT EXISTS to check for existing chapter_codes
-- before insertion, allowing safe re-execution without creating duplicates.
-- If a chapter_code already exists, that insertion is skipped without error.

-- Insert A1 grammar chapters using idempotent pattern
INSERT INTO public.grammar_chapters (
  chapter_code,
  title,
  cefr_level,
  form_content,
  meaning_content,
  use_content,
  contrast_notes,
  common_errors,
  diagnostic_hook,
  task_upgrades,
  micro_practice,
  cross_links,
  is_published,
  sort_order
)
SELECT * FROM (VALUES
  -- A1.G.01: Simple Present
  ('A1.G.01', 'Simple Present', 'A1',
   'The verb be

| Subject | Affirmative | Negative |
| :--- | :--- | :--- |
| I | am (''m) | am not (''m not) |
| He / She / It | is (''s) | is not (isn''t) |
| You / We / They | are (''re) | are not (aren''t) |

Other verbs (Action verbs)

| Subject | Affirmative | Negative (See A1.G.02) |
| :--- | :--- | :--- |
| I / You / We / They | work | do not (don''t) work |
| He / She / It | works | does not (doesn''t) work |

Spelling Rules for He/She/It (Action Verbs)

Most verbs: add -s (plays, writes)
Verbs ending in -ch, -sh, -s, -x, -z: add -es (watches, fixes)
Verbs ending in consonant + y: change ''y'' to ''i'' and add -es (study → studies)
Irregular: have → has, go → goes, do → does

Adverbs of Frequency Placement

Before action verbs: I always wake up early.
After the verb be: I am usually tired.',
   'The simple present does not usually describe what is happening right exactly now. Instead, it describes things that are generally true, routines that repeat, or permanent states.',
   'Choose be to describe identity, age, feelings, locations, and qualities.

Choose action verbs to describe physical or mental actions you do regularly.

Pragmatic note: Using simple present with frequency adverbs (always, never, sometimes) is the most common way to answer "What is a typical day like for you?"',
   'I am a teacher. (State of being)
I teach English. (Habitual action)

Do not mix them: "I am teach" is incorrect.',
   'Error: Missing the ''s'' for third-person singular (He work here).
Fix: Remember the "He/She/It needs an S" rule.

Error: Mixing be and action verbs (I am agree / She is play).
Fix: Choose one lane. Is it a state/description (be) or an action (verb)?',
   'Describe your daily routines and habits.

State general facts and permanent situations.

Describe people, places, and things currently.',
   'Starter: I get up at 7:00. → Upgrade: I usually start my day at 7:00.

Starter: I am an engineer. → Upgrade: I work as an engineer.',
   '[{"type": "fill_blank", "prompt": "Complete: She ___ (work) at a hospital.", "answer": "works", "feedback": "Add -s for he/she/it in simple present."}, {"type": "multiple_choice", "prompt": "Choose the correct form: They ___ English every day.", "options": ["study", "studies", "studying"], "answer": "study", "feedback": "Use the base form with they."}, {"type": "fill_blank", "prompt": "Complete: I ___ (be) a student.", "answer": "am", "feedback": "Use am with I."}]'::jsonb,
   '[{"type": "prerequisite", "chapter_code": "A0.G.02", "note": "Review the verb be before studying simple present"}, {"type": "prerequisite", "chapter_code": "A0.G.03", "note": "Review subject pronouns"}, {"type": "related", "chapter_code": "A1.G.02", "note": "See also: Simple Present Questions and Negatives"}]'::jsonb,
   true,
   1),
  
  -- A1.G.02: Simple Present Questions and Negatives
  ('A1.G.02', 'Simple Present Questions and Negatives', 'A1',
   'Negative Statements

| Subject | Auxiliary | Base Verb |
| :--- | :--- | :--- |
| I / You / We / They | do not (don''t) | like |
| He / She / It | does not (doesn''t) | like |

Yes/No Questions & Short Answers

| Auxiliary | Subject | Base Verb | Short Answer |
| :--- | :--- | :--- | :--- |
| Do | you | live here? | Yes, I do. / No, I don''t. |
| Does | she | work late? | Yes, she does. / No, she doesn''t. |

Word order rules

Questions: Auxiliary + Subject + Verb (ASV).

Crucial rule: In negatives and questions, the main verb is ALWAYS in the base form. The auxiliary (doesn''t/does) carries the ''s''.',
   'These structures allow you to seek out general truths and habits of others, or to correct assumptions about your own habits.',
   'If asking about a state/identity → use Are/Is. (Are you happy?)

If asking about an action/routine → use Do/Does. (Do you run?)

Register note: "Do not" and "does not" sound very formal or emphatic. Use "don''t" and "doesn''t" in everyday speech and emails.',
   'be questions vs do/does questions.

Are you a student? (Asking about a noun/identity)
Do you study? (Asking about an action)',
   'Error: Double marking the ''s'' in third-person questions (Does he plays?).
Fix: The "does" already has the ''s''. The main verb stays naked. (Does he play?)

Error: Using "no" instead of "don''t" (I no like coffee).
Fix: English requires an auxiliary verb to make a negative. (I don''t like coffee.)

Error: Using be for action questions (Are you like pizza?).
Fix: Use Do/Does for action verbs.',
   'Ask people for information about their lives, habits, and preferences.

Deny incorrect facts or clarify what you do not do.

Conduct surveys or interviews.',
   'Starter: Do you like music? → Upgrade: Are you into music?

Starter: I don''t know. → Upgrade: I have no idea / I''m not sure.',
   '[{"type": "multiple_choice", "prompt": "Choose the correct question: ___ you like pizza?", "options": ["Do", "Does", "Are"], "answer": "Do", "feedback": "Use Do with you for action verbs."}, {"type": "fill_blank", "prompt": "Make it negative: She ___ (not/like) coffee.", "answer": "doesn''t like", "feedback": "Use doesn''t + base verb for he/she/it."}, {"type": "multiple_choice", "prompt": "Fix the error: Does he plays tennis?", "options": ["Does he play tennis?", "Do he plays tennis?", "Does he playing tennis?"], "answer": "Does he play tennis?", "feedback": "Does already has the -s, so the main verb stays in base form."}]'::jsonb,
   '[{"type": "prerequisite", "chapter_code": "A1.G.01", "note": "Study Simple Present affirmative first"}, {"type": "related", "chapter_code": "A1.G.03", "note": "See also: Possessive ''s"}]'::jsonb,
   true,
   2),
  
  -- A1.G.03: Possessive 's
  ('A1.G.03', 'Possessive ''s', 'A1',
   'Noun Type | Rule | Example
:--- | :--- | :---
Singular nouns | Add ''s | The manager''s office
Regular plural nouns (ending in -s) | Add only an apostrophe ('') | My parents'' house
Irregular plural nouns (not ending in -s) | Add ''s | The children''s toys',
   'The possessive ''s shows a relationship of belonging. It links two nouns together: the owner (first) and the thing owned (second).',
   'If the owner is a person or animal → use ''s (Sarah''s laptop, the dog''s bed).

If the owner is a time or organization → you can often use ''s (today''s meeting, the company''s rules).

If the owner is an inanimate object → usually prefer "of" (The door of the car, NOT the car''s door - though this rule is flexible in modern English).',
   'Possessive ''s vs Possessive Adjectives (my, your, his, her).

Sarah''s book is on the table. (Specific name)
Her book is on the table. (Pronoun)',
   'Error: Using "of" for people (The phone of my friend).
Fix: This sounds unnatural in English. Flip it and use ''s: My friend''s phone.

Error: Confusing ''s (possessive) with ''s (is).
John''s here. (John is here.) vs John''s car is here. (Possessive).
Fix: Look at the word that follows. If it''s a noun, it''s usually possessive.',
   'Talk about ownership (who owns what).

Describe family and social relationships.

Identify places associated with people.',
   'Starter: This is the house of my parents. → Upgrade: This is my parents'' house.

Starter: I am going to the doctor''s office. → Upgrade: I am going to the doctor''s. (Native speakers often drop the place noun if it''s obvious).',
   '[{"type": "fill_blank", "prompt": "Complete: This is ___ (Sarah) car.", "answer": "Sarah''s", "feedback": "Add ''s to show ownership."}, {"type": "multiple_choice", "prompt": "Choose the correct form: The ___ toys are everywhere.", "options": ["childrens", "children''s", "childrens''"], "answer": "children''s", "feedback": "Irregular plurals add ''s."}, {"type": "fill_blank", "prompt": "Complete: My ___ (parents) house is big.", "answer": "parents''", "feedback": "Regular plurals ending in -s just add an apostrophe."}]'::jsonb,
   '[{"type": "prerequisite", "chapter_code": "A0.G.03", "note": "Review possessive adjectives (my, your, his, her)"}, {"type": "related", "chapter_code": "A1.G.05", "note": "See also: Possessive Pronouns"}]'::jsonb,
   true,
   3),
  
  -- A1.G.04: Object Pronouns
  ('A1.G.04', 'Object Pronouns', 'A1',
   'Subject Pronoun (Does the action) | Object Pronoun (Receives the action)
:--- | :---
I | me
You | you
He | him
She | her
It | it
We | us
They | them

Word order rules

Subject + Verb + Object (I called him.)
Preposition + Object (This is for her. / I played chess with them.)',
   'Object pronouns replace the noun that is receiving the action of the verb or following a preposition. They act as shortcuts to avoid repetition.',
   'Choose it when the listener already knows who or what you are talking about. "Where is your guitar?" → "I left it at home."

Pragmatic note: In spoken English, him, her, and them often lose their first sound when spoken quickly ("Tell ''im I said hi").',
   'Subject vs. Object Pronouns

She likes him. (She = doer, him = receiver)
He likes her. (He = doer, her = receiver)',
   'Error: Dropping the object pronoun entirely, especially "it" (I bought a new car. I love!).
Fix: English verbs usually need an object if they are transitive. (I love it!).

L1 Transfer Note: In Portuguese, it is common to drop the object pronoun entirely in informal speech. Remind learners that English sentences feel "empty" without them.

Error: Using subject pronouns after verbs or prepositions (This gift is for she / I saw he yesterday).
Fix: After a verb or preposition, always switch to the object list.',
   'Talk about people and things without repeating their names constantly.

Explain who receives an action or who is involved in a situation.

Keep conversations flowing naturally and quickly.',
   'Starter: I will call Mary later. → Upgrade: I''ll call her later.

Starter: Do you want to come to the conversation club with John and me? → Upgrade: Do you want to come with us?',
   '[{"type": "multiple_choice", "prompt": "Choose the correct pronoun: I saw ___ at the store.", "options": ["he", "him", "his"], "answer": "him", "feedback": "Use object pronouns after verbs."}, {"type": "fill_blank", "prompt": "Complete: This gift is for ___. (she)", "answer": "her", "feedback": "Use object pronouns after prepositions."}, {"type": "multiple_choice", "prompt": "Fix the error: She likes they.", "options": ["She likes them.", "She likes their.", "She like them."], "answer": "She likes them.", "feedback": "Use them as the object pronoun for they."}]'::jsonb,
   '[{"type": "prerequisite", "chapter_code": "A0.G.03", "note": "Review subject pronouns first"}]'::jsonb,
   true,
   4),
  
  -- A1.G.05: Count/Noncount Nouns I
  ('A1.G.05', 'Count/Noncount Nouns I', 'A1',
   'Count Nouns (Things you can count: 1 apple, 2 apples)

Use a / an for singular: a chair, an idea.
Add -s or -es for plural: chairs, ideas.
Can use numbers: three cars.

Noncount Nouns (Liquids, powders, materials, abstract ideas)

No a / an.
No plural form (-s).
Cannot use numbers directly (not "two waters").
Examples: water, coffee, money, time, music, information, bread, advice.

Using "Some" and "Any" (Basic)

Affirmative (+): use some for plural count and noncount (I have some apples. / I have some water.)
Negative (-) and Questions (?): use any (I don''t have any time. / Do you have any questions?)',
   'Grammar divides the world into individual items we can easily separate (count) and continuous substances or abstract concepts we cannot easily separate (noncount).',
   'When offering or requesting: We often use "some" in questions if we expect a "yes" answer. (Would you like some coffee? / Can I have some water?)',
   'I need a paper. (A specific document/newspaper)
I need some paper. (The material itself)',
   'Error: Making noncount nouns plural (I need some informations / The furnitures are nice / I bought two breads).
Fix: Memorize the common "trick" words that are noncount in English.

L1 Transfer Note: This is a major hurdle for Portuguese speakers, where informações, móveis, conselhos, and pães are perfectly normal plurals. Emphasize that in English, these words never take an ''s''.

Error: Using "a/an" with noncount nouns (I have an advice for you).
Fix: Use "some" instead. (I have some advice for you).',
   'Talk about food, drinks, and ingredients.

Request specific quantities of items.

Describe general concepts and materials.',
   'Starter: I want a water. → Upgrade: I''d like some water, please. (Or: a bottle of water).

Starter: Give me an information. → Upgrade: Can you give me some details?',
   '[{"type": "multiple_choice", "prompt": "Choose the correct form: I need ___ advice.", "options": ["an", "some", "a"], "answer": "some", "feedback": "Advice is noncount. Use some, not a/an."}, {"type": "fill_blank", "prompt": "Complete: Do you have ___ questions? (any/some)", "answer": "any", "feedback": "Use any in questions."}, {"type": "multiple_choice", "prompt": "Fix the error: I bought two breads.", "options": ["I bought two loaves of bread.", "I bought two bread.", "I bought some breads."], "answer": "I bought two loaves of bread.", "feedback": "Bread is noncount. Use a counter like loaves."}]'::jsonb,
   '[{"type": "prerequisite", "chapter_code": "A0.G.04", "note": "Review articles (a/an) first"}, {"type": "prerequisite", "chapter_code": "A0.G.05", "note": "Review plural forms"}, {"type": "related", "chapter_code": "A1.G.06", "note": "See also: There is/are II (for some/any usage)"}]'::jsonb,
   true,
   5),
  
  -- A1.G.06: There is/are II
  ('A1.G.06', 'There is/are II', 'A1',
   'Type | Singular (or Noncount) | Plural Count
:--- | :--- | :---
Affirmative (+) | There is a park. / There is some milk. | There are some parks.
Negative (-) | There isn''t a park. / There isn''t any milk. | There aren''t any parks.
Question (?) | Is there a park? / Is there any milk? | Are there any parks?
Short Answers | Yes, there is. / No, there isn''t. | Yes, there are. / No, there aren''t.',
   'We use "There is/are" to introduce that something exists in a specific place. It shifts the focus from who owns it to the simple fact that it is there.',
   'Choose "There is" before a singular noun or a noncount noun.

Choose "There are" before plural nouns.

Pragmatic note: In spoken English, native speakers frequently contract "There is" to "There''s". (There''s a good restaurant downtown). There''re is difficult to say and less common, though people sometimes incorrectly use "There''s" with plural nouns in fast, informal speech (e.g., "There''s two cars outside").',
   'There is vs. It is

There is a new student in class. (Existence - pointing out the fact)
He is from Brazil. (Describing the specific student)',
   'Error: Using "Have" or "Has" to show existence (Have a lot of traffic today / Has a problem in my apartment).
Fix: "Have" requires an owner (I have, the city has). If there is no owner, use "There is / There are".

L1 Transfer Note: In Portuguese, the verb ter (to have) is universally used for existence (Tem um problema). This is one of the most persistent errors for Brazilian learners. Drill the concept that English spaces do not "have" things; things exist in them.

Error: Using "any" in affirmative sentences (There are any books on the desk).
Fix: Use "some" or "a lot of" for affirmatives. Reserve "any" for negatives and questions.',
   'Describe a city, a neighborhood, or a room in detail.

Explain what ingredients are available in a kitchen.

Point out problems (e.g., "There is a mistake here").',
   'Starter: Have many people at the club. → Upgrade: There are a lot of people at the club.

Starter: Is there a pharmacy near here? → Upgrade: Do you know if there''s a pharmacy around here?',
   '[{"type": "multiple_choice", "prompt": "Choose the correct form: ___ some milk in the fridge.", "options": ["There is", "There are", "Have"], "answer": "There is", "feedback": "Use There is with noncount nouns like milk."}, {"type": "fill_blank", "prompt": "Make it negative: There ___ any parks nearby.", "answer": "aren''t", "feedback": "Use aren''t with plural nouns in negative sentences."}, {"type": "multiple_choice", "prompt": "Fix the error: Have a problem in my apartment.", "options": ["There is a problem in my apartment.", "Has a problem in my apartment.", "Is a problem in my apartment."], "answer": "There is a problem in my apartment.", "feedback": "Use There is to show existence, not have."}]'::jsonb,
   '[{"type": "prerequisite", "chapter_code": "A0.G.07", "note": "Review basic There is/are first"}, {"type": "related", "chapter_code": "A1.G.05", "note": "See also: Count/Noncount Nouns"}]'::jsonb,
   true,
   6),
  
  -- A1.G.07: Can for requests/permission
  ('A1.G.07', 'Can for requests/permission', 'A1',
   'Type | Structure | Example
:--- | :--- | :---
Requesting action (asking someone else) | Can you + base verb + ...? | Can you help me?
Requesting items/permission (asking for yourself) | Can I + have / base verb + ...? | Can I have a coffee? / Can I sit here?

Rules:
Never use to after can. (Not: Can you to help me?)
Never add an -s to can or the main verb.',
   'In A0, we used can for physical ability (I can swim). Here, the meaning shifts to social possibility. You are asking if a situation is possible or permitted.',
   'Can you...? is the standard, everyday way to ask family, friends, and coworkers for help.

Can I have...? is the most common way to order food or buy things in casual settings.

Pragmatic note: Can is casual but polite enough for most daily interactions, provided you add "please" at the end of the question.',
   'Can I have... vs. I want...

"I want a coffee" sounds demanding and often rude to native English speakers. Always use "Can I have..." or "I''d like..." when interacting with service staff.',
   'Error: Dropping the subject pronoun (Can help me? / Can open the window?).
Fix: English questions must always have a subject. You must specify who is doing the action (Can you help me?).

L1 Transfer Note: In Portuguese, it is very common to ask favors using just the verb (Pode me ajudar?). Remind learners that the "you" is mandatory in English.',
   'Ask someone to do a favor for you.

Ask for an item in a store, cafe, or restaurant.

Ask for permission to do something.',
   'Starter: Can you send the email? → Upgrade: Could you send the email, please? (A bit softer and more polite).

Starter: Can I have the menu? → Upgrade: Could I get the menu, please?',
   '[{"type": "fill_blank", "prompt": "Complete: ___ you help me with this?", "answer": "Can", "feedback": "Use Can you to ask for help."}, {"type": "multiple_choice", "prompt": "Choose the correct request: ___ I have a coffee, please?", "options": ["Can", "Do", "Am"], "answer": "Can", "feedback": "Use Can I have to request items politely."}, {"type": "multiple_choice", "prompt": "Fix the error: Can help me?", "options": ["Can you help me?", "Can me help?", "You can help me?"], "answer": "Can you help me?", "feedback": "Always include the subject pronoun you."}]'::jsonb,
   '[{"type": "prerequisite", "chapter_code": "A0.G.10", "note": "Review can for ability first"}, {"type": "related", "chapter_code": "A1.G.17", "note": "See also: Basic modals (must/have to/should)"}]'::jsonb,
   true,
   7),
  
  -- A1.G.08: Present continuous
  ('A1.G.08', 'Present continuous', 'A1',
   'Subject + be (am/is/are) + verb-ing

| | Affirmative (+) | Negative (-) | Question (?) |
| :--- | :--- | :--- | :--- |
| I | am (''m) working. | am not (''m not) working. | Am I working? |
| She | is (''s) studying. | is not (isn''t) studying. | Is she studying? |
| They | are (''re) eating. | are not (aren''t) eating. | Are they eating? |

Spelling rules for adding -ing:
Most verbs: just add -ing (play → playing).
Verbs ending in -e: drop the -e, add -ing (make → making).
One-syllable verbs ending in Consonant-Vowel-Consonant (CVC): double the final consonant (sit → sitting, run → running).',
   'The action is in progress right now. It started in the past, it is happening at this second, and it will finish in the future. It is temporary.',
   'Choose this tense when answering the question: "What are you doing?" or "What''s happening?"

Common time markers: now, right now, at the moment, currently.',
   'Present Simple (Habit/Fact): I work in an office. (General truth).
Present Continuous (Now/Temporary): I am working from home today. (Temporary situation).',
   'Error: Forgetting the verb be (I working right now / She studying).
Fix: The -ing cannot stand alone. It always needs am/is/are to anchor it to the present.

Error: Using simple present for actions happening right now (Look! It rains).
Fix: If you can point at it happening, use the continuous (Look! It is raining).',
   'Describe what is happening at this exact moment.

Talk about temporary situations.

Describe actions in a photograph or video.',
   'Starter: I am studying English now. → Upgrade: I''m currently focusing on my English.

Starter: What do you do now? (Incorrect) → Upgrade: What are you working on at the moment?',
   '[{"type": "fill_blank", "prompt": "Complete: She ___ (read) a book right now.", "answer": "is reading", "feedback": "Use is + verb-ing for actions happening now."}, {"type": "multiple_choice", "prompt": "Choose the correct form: They ___ dinner at the moment.", "options": ["eat", "are eating", "eating"], "answer": "are eating", "feedback": "Use are + verb-ing with they."}, {"type": "fill_blank", "prompt": "Complete: Look! It ___ (rain).", "answer": "is raining", "feedback": "Use present continuous for actions you can see happening now."}]'::jsonb,
   '[{"type": "prerequisite", "chapter_code": "A1.G.01", "note": "Review Simple Present first"}, {"type": "prerequisite", "chapter_code": "A0.G.02", "note": "Review the verb be"}]'::jsonb,
   true,
   8),
  
  -- A1.G.09: Like/love/hate + noun / -ing
  ('A1.G.09', 'Like/love/hate + noun / -ing', 'A1',
   'These verbs of preference can be followed by two different things:

Pattern 1: Verb + Noun (Things)
I like pizza.
She loves movies.
We hate traffic.

Pattern 2: Verb + Verb-ing (Activities)
I like cooking.
She loves watching movies.
We hate driving in traffic.

Note: In A1, we focus on the -ing pattern. (The "like + to + verb" pattern is also correct but taught later to reduce confusion).',
   'These verbs describe your feelings toward general concepts or activities. The -ing turns an action verb into a noun concept (e.g., swim = the action; swimming = the sport/concept).',
   'Use these when talking generally about your life.

Do not use them for temporary feelings right now (For "right now," use want or would like).',
   'I like coffee. (General preference - Fact).
I would like a coffee. (Request for right now - see A2.G.17).',
   'Error: Using a base verb after a preference verb (I like play soccer / She loves read).
Fix: You cannot put two conjugated verbs next to each other like this. Change the second verb into its -ing noun form: I like playing soccer.

L1 Transfer Note: In Portuguese, you use the infinitive (Eu gosto de jogar). In English, the gerund (-ing) is the most natural way to talk about general hobbies.

Error: Adding prepositions unnecessarily (I like of music).
Fix: English does not use "of" after like, love, or hate.',
   'Express your hobbies, interests, and preferences.

Talk about your favorite foods, media, and activities.

Find common ground with new people.',
   'Starter: I like tennis. → Upgrade: I''m really into tennis. / I''m a big fan of tennis.

Starter: I hate waiting. → Upgrade: I can''t stand waiting.',
   '[{"type": "fill_blank", "prompt": "Complete: I love ___ (cook).", "answer": "cooking", "feedback": "Use verb-ing after love to describe activities."}, {"type": "multiple_choice", "prompt": "Choose the correct form: She hates ___ in traffic.", "options": ["drive", "driving", "to drive"], "answer": "driving", "feedback": "Use verb-ing after hate."}, {"type": "multiple_choice", "prompt": "Fix the error: I like play soccer.", "options": ["I like playing soccer.", "I like to playing soccer.", "I like plays soccer."], "answer": "I like playing soccer.", "feedback": "Change the second verb to -ing form."}]'::jsonb,
   '[{"type": "prerequisite", "chapter_code": "A1.G.01", "note": "Review Simple Present first"}, {"type": "related", "chapter_code": "A1.G.22", "note": "See also: Object + infinitive (want to, need to)"}]'::jsonb,
   true,
   9),
  
  -- A1.G.10: Past of be
  ('A1.G.10', 'Past of be', 'A1',
   'Subject | Affirmative (+) | Negative (-)
:--- | :--- | :---
I / He / She / It | was | was not (wasn''t)
You / We / They | were | were not (weren''t)

Questions and Short Answers
Was he at home? → Yes, he was. / No, he wasn''t.
Were you tired? → Yes, we were. / No, we weren''t.',
   'Was and were are the past tense forms of am, is, and are. They describe a state of being, an identity, or a location in a time that is 100% finished.',
   'Use it with past time markers: yesterday, last night, last week, in 2010, when I was a child.

Pronunciation note: In fast speech, was /wʌz/ often reduces to a quick /wəz/, and were /wɜːr/ reduces to /wər/.',
   'Present: I am tired today. (Now)
Past: I was tired yesterday. (Finished)',
   'Error: Using did for questions with be (Did you be at the meeting? / Did he was sick?).
Fix: The verb be is strong. It makes its own questions by jumping to the front of the sentence. Never use did with was or were. (Were you at the meeting?)

Error: Confusing was and were with you (You was late).
Fix: You always pairs with were, even if you are only talking to one person.',
   'Talk about where you were in the past.

Describe how you felt yesterday or last week.

Talk about your childhood or historical facts.',
   'Starter: I was very busy yesterday. → Upgrade: I was slammed yesterday. / I was tied up all day.

Starter: The movie was good. → Upgrade: The movie was fantastic / pretty decent.',
   '[{"type": "multiple_choice", "prompt": "Choose the correct form: I ___ tired yesterday.", "options": ["was", "were", "am"], "answer": "was", "feedback": "Use was with I for past tense."}, {"type": "fill_blank", "prompt": "Complete: They ___ at home last night.", "answer": "were", "feedback": "Use were with they."}, {"type": "multiple_choice", "prompt": "Fix the error: You was late.", "options": ["You were late.", "You was been late.", "You are late."], "answer": "You were late.", "feedback": "Always use were with you, even for one person."}]'::jsonb,
   '[{"type": "prerequisite", "chapter_code": "A0.G.02", "note": "Review the verb be in present tense first"}, {"type": "related", "chapter_code": "A1.G.11", "note": "See also: Past simple (regular verbs)"}]'::jsonb,
   true,
   10),
  
  -- A1.G.11: Past simple (regular verbs)
  ('A1.G.11', 'Past simple (regular verbs)', 'A1',
   'Affirmative (+): Subject + Verb-ed
I worked late yesterday.
She lived in Paris in 2015.

Spelling Rules for -ed:
Most verbs: add -ed (start → started, watch → watched).
Verbs ending in -e: add -d (arrive → arrived, decide → decided).
Verbs ending in consonant + y: change ''y'' to ''i'' and add -ed (study → studied, try → tried).
One-syllable verbs ending in CVC: double the final consonant (stop → stopped, plan → planned).',
   'The past simple describes an action that started and finished in the past. It is over. It has no connection to right now.',
   'Choose this tense when you can answer the question "When did it happen?" (Even if you don''t say the time out loud, the time is finished in your mind).

Common triggers: ago (two days ago), last (last month), in + past year (in 1999).',
   'I live in Brazil. (Present state - Fact now)
I lived in London for two years. (Past state - I don''t live there now).',
   'Error: Pronouncing the "-ed" as an extra syllable on every verb (e.g., saying "work-ed" or "play-ed").
Fix: The "-ed" only adds an extra syllable /ɪd/ if the original verb ends in a T or a D sound (want → want-ed, need → need-ed). For all other verbs, it just sounds like a quick /t/ or /d/ at the end (worked = "workt", played = "playd").

L1 Transfer Note: Because Portuguese reads every vowel, Brazilians naturally want to pronounce the ''e'' in ''-ed''. It takes conscious effort to silence that ''e''. Drill the difference between "wanted" (extra syllable) and "stopped" (no extra syllable).',
   'Tell chronological stories about your life.

Report what you did at work yesterday or over the weekend.

Give a sequence of finished events.',
   'Starter: First I worked, then I cooked. → Upgrade: After I finished work, I cooked dinner.

Starter: I studied a lot yesterday. → Upgrade: I spent the whole day studying.',
   '[{"type": "fill_blank", "prompt": "Complete: I ___ (work) late yesterday.", "answer": "worked", "feedback": "Add -ed to regular verbs for past tense."}, {"type": "multiple_choice", "prompt": "Choose the correct form: She ___ in Paris in 2015.", "options": ["live", "lived", "living"], "answer": "lived", "feedback": "Use verb-ed for past simple."}, {"type": "fill_blank", "prompt": "Complete: They ___ (study) all night.", "answer": "studied", "feedback": "Change y to i and add -ed for verbs ending in consonant + y."}]'::jsonb,
   '[{"type": "prerequisite", "chapter_code": "A1.G.10", "note": "Review past of be first"}, {"type": "related", "chapter_code": "A1.G.12", "note": "See also: Past simple questions/negatives"}]'::jsonb,
   true,
   11),
  
  -- A1.G.12: Past simple questions/negatives
  ('A1.G.12', 'Past simple questions/negatives', 'A1',
   'Negative (-): Subject + didn''t + Base Verb
I didn''t go to work yesterday.
She didn''t like the movie.

Questions (?): Did + Subject + Base Verb
Did you watch the game?
Where did they eat?

Starter Irregular Verbs (Base → Past)
go → went
have → had
do → did
eat → ate
buy → bought

Crucial Rule: "Did" acts like a time machine. It carries the past tense so the main verb doesn''t have to. The main verb stays in the base form.',
   'These structures allow you to investigate or correct facts about the finished past.',
   'Use did and didn''t for all subjects (I, you, he, she, it, we, they). It never changes.',
   'Affirmative: He went home. (Main verb changes to past).
Negative: He didn''t go home. (Auxiliary ''didn''t'' shows past; main verb is base).',
   'Error: The "Double Past" - changing the main verb in questions and negatives (Did you went? / I didn''t saw him).
Fix: Remember the time machine rule. If "did" or "didn''t" is in the sentence, the main verb relaxes in its base form. (Did you go? / I didn''t see him).

L1 Transfer Note: In Portuguese, the main verb changes in questions and negatives (Você foi? / Eu não vi). English splits the job: the auxiliary does the grammar (time/negative), and the main verb does the meaning.

Error: Using wasn''t/weren''t with action verbs (I wasn''t eat breakfast).
Fix: Only use was/were for states and locations. For actions, use didn''t.',
   'Ask people about their past experiences and weekends.

Deny that you did something.

Clarify details in a conversation.',
   'Starter: Did you have a good weekend? → Upgrade: How was your weekend? / Get up to anything fun over the weekend?

Starter: I didn''t do anything. → Upgrade: I just relaxed at home. / Nothing special.',
   '[{"type": "fill_blank", "prompt": "Complete: I ___ (not/go) to work yesterday.", "answer": "didn''t go", "feedback": "Use didn''t + base verb for negatives."}, {"type": "multiple_choice", "prompt": "Choose the correct question: ___ you watch the game?", "options": ["Did", "Do", "Were"], "answer": "Did", "feedback": "Use Did for past simple questions."}, {"type": "multiple_choice", "prompt": "Fix the error: Did you went home?", "options": ["Did you go home?", "Do you went home?", "Did you going home?"], "answer": "Did you go home?", "feedback": "Did carries the past tense, so use the base verb go."}]'::jsonb,
   '[{"type": "prerequisite", "chapter_code": "A1.G.11", "note": "Study past simple affirmative first"}, {"type": "related", "chapter_code": "A1.G.02", "note": "Compare with: Simple Present Questions and Negatives"}]'::jsonb,
   true,
   12),
  
  -- A1.G.13: Future: be going to
  ('A1.G.13', 'Future: be going to', 'A1',
   'Subject + be (am/is/are) + going to + base verb

| | Affirmative (+) | Negative (-) | Question (?) |
| :--- | :--- | :--- | :--- |
| I | am (''m) going to travel. | am not (''m not) going to travel. | Am I going to travel? |
| She | is (''s) going to study. | isn''t going to study. | Is she going to study? |
| They | are (''re) going to win. | aren''t going to win. | Are they going to win? |

Pronunciation note: In spoken English, going to almost always blends together to sound like "gonna" (I''m gonna travel). You should say "gonna," but never write it in formal contexts.',
   'Be going to shows that a decision has already been made before the moment of speaking. It is a solid plan or a strong intention.',
   'For plans: Answering "What are your plans for the weekend?"

For evidence-based predictions: If you look up and see dark, heavy clouds, you say, "It''s going to rain." (You have physical proof right now).',
   'Present Continuous vs. Be going to:
I am meeting John at 5:00. (A fixed arrangement with another person; very certain).
I am going to meet John. (My plan/intention; usually means the same thing, but slightly less fixed).',
   'Error: Forgetting the verb be (I going to buy a car).
Fix: Going is an -ing word; it cannot survive without am/is/are to anchor it.

Error: Direct translation using just the verb "go" (I go travel next year).
Fix: Use the full be going to structure.

L1 Transfer Note: In Portuguese, Eu vou viajar uses just one verb (vou = I go). In English, you need three pieces: I am + going to + travel.',
   'Talk about your weekend plans or upcoming vacations.

Discuss your intentions and goals for the future.

Make predictions based on things you can see right now.',
   'Starter: I am going to relax this weekend. → Upgrade: I''m planning to just relax this weekend. / I''m looking forward to relaxing.

Starter: What are you going to do? → Upgrade: Got any plans for the weekend?',
   '[{"type": "fill_blank", "prompt": "Complete: I ___ (be) going to travel next month.", "answer": "am", "feedback": "Use am going to with I."}, {"type": "multiple_choice", "prompt": "Choose the correct form: She ___ going to study tonight.", "options": ["is", "are", "am"], "answer": "is", "feedback": "Use is going to with she."}, {"type": "fill_blank", "prompt": "Complete: They ___ going to win the game.", "answer": "are", "feedback": "Use are going to with they."}]'::jsonb,
   '[{"type": "prerequisite", "chapter_code": "A0.G.02", "note": "Review the verb be"}, {"type": "prerequisite", "chapter_code": "A1.G.08", "note": "Review present continuous structure"}, {"type": "related", "chapter_code": "A1.G.14", "note": "Compare with: Future with will"}]'::jsonb,
   true,
   13),
  
  -- A1.G.14: Future: will
  ('A1.G.14', 'Future: will', 'A1',
   'Subject + will / won''t + base verb

| | Affirmative (+) | Negative (-) | Question (?) |
| :--- | :--- | :--- | :--- |
| I | will (''ll) help you. | will not (won''t) tell anyone. | Will you help me? |
| She | will (''ll) call later. | won''t call later. | Will she call later? |',
   'Unlike be going to, will is used when the idea just popped into your head. There is no prior plan. It is a reaction to the present moment.',
   'Decisions: The phone rings. You say: "I''ll get it!"

Orders: The waiter asks what you want. You look at the menu and say: "I''ll have the steak."

Offers/Promises: "This box is heavy." → "I''ll carry it for you." / "I won''t be late, I promise."',
   'Will vs. Be going to (The ultimate test)
A: "We don''t have any milk."
B (Spontaneous decision): "Really? I will (''ll) go to the store and buy some."
B (Prior plan): "I know. I am going to go to the store after work."',
   'Error: Using will for established plans (Next year, I will visit Disney).
Fix: If the tickets are bought or the dream is established, use be going to.

L1 Transfer Note: Because Portuguese uses vou for both spontaneous decisions and future plans, learners tend to overuse will because it looks simpler. Force the habit of using be going to for plans and reserving will for reactions and restaurant orders.

Error: Adding to after will (I will to help you).
Fix: Will is a modal. It goes directly next to the base verb.',
   'Make quick, spontaneous decisions in the moment.

Order food at a restaurant or drinks at a bar.

Offer to help someone or make a promise.',
   'Starter: I will help you with that. → Upgrade: Let me give you a hand with that.

Starter: I will have a coffee. → Upgrade: I think I''ll go with a coffee.',
   '[{"type": "fill_blank", "prompt": "The phone is ringing. Complete: I ___ get it!", "answer": "will", "feedback": "Use will for spontaneous decisions."}, {"type": "multiple_choice", "prompt": "Choose the correct form: I ___ have the steak, please.", "options": ["will", "am going to", "going to"], "answer": "will", "feedback": "Use will when ordering at a restaurant."}, {"type": "multiple_choice", "prompt": "Fix the error: I will to help you.", "options": ["I will help you.", "I will helping you.", "I am will help you."], "answer": "I will help you.", "feedback": "Don''t add to after will."}]'::jsonb,
   '[{"type": "prerequisite", "chapter_code": "A1.G.13", "note": "Study be going to first to understand the difference"}, {"type": "related", "chapter_code": "A1.G.13", "note": "Compare with: Future with going to"}]'::jsonb,
   true,
   14),
  
  -- A1.G.15: Comparatives
  ('A1.G.15', 'Comparatives', 'A1',
   'Rule 1: Short Adjectives (1 syllable)
Add -er + than:
tall → taller than
cheap → cheaper than.

Spelling: If it ends in CVC, double the last letter (big → bigger). If it ends in ''y'', change to ''i'' (busy → busier).

Rule 2: Long Adjectives (2+ syllables)
Add more + adjective + than:
expensive → more expensive than
comfortable → more comfortable than.

Rule 3: Irregular Adjectives (Memorize these)
good → better than
bad → worse than
far → further/farther than',
   'You are placing two nouns on a scale and showing the difference between them.',
   'Always use this structure when contrasting exactly two things.

If the second thing is obvious from context, you can drop "than + noun" (e.g., "This laptop is $500, but that one is $400. That one is cheaper.")',
   'Comparing two things vs. describing one thing.
Fact: My car is fast.
Comparison: My car is faster than your car.',
   'Error: Mixing both rules (He is more taller than me).
Fix: Choose one. Short words get -er. Long words get more. Never both.

Error: Using that instead of than (Brazil is bigger that France).
Fix: That points to things. Than connects comparisons.

L1 Transfer Note: In Portuguese, the word que translates to both that and than, making this a very common mistake. Drill than as the official "comparison bridge." Portuguese also uses mais for all comparisons (mais alto, mais caro), so students often forget the -er suffix entirely and say more tall.',
   'Compare two products before buying one.

Talk about the differences between two cities or two people.

Justify your preferences (e.g., why A is better than B).',
   'Starter: New York is more expensive than Blumenau. → Upgrade: New York is much more expensive than Blumenau. / New York is a lot more expensive.

Starter: John is taller than Mark. → Upgrade: John is a little bit taller than Mark.',
   '[{"type": "fill_blank", "prompt": "Complete: This car is ___ (cheap) than that one.", "answer": "cheaper", "feedback": "Add -er for short adjectives."}, {"type": "multiple_choice", "prompt": "Choose the correct form: This hotel is ___ expensive than the other.", "options": ["more", "most", "expensiver"], "answer": "more", "feedback": "Use more with long adjectives."}, {"type": "multiple_choice", "prompt": "Choose the correct form: My coffee is ___ than yours.", "options": ["good", "better", "more good"], "answer": "better", "feedback": "Good is irregular: good → better."}]'::jsonb,
   '[{"type": "prerequisite", "chapter_code": "A0.G.04", "note": "Review articles (a/an/the)"}, {"type": "related", "chapter_code": "A1.G.16", "note": "See also: Superlatives"}]'::jsonb,
   true,
   15),
  
  -- A1.G.16: Superlatives
  ('A1.G.16', 'Superlatives', 'A1',
   'Rule 1: Short Adjectives (1 syllable)
Add the + adjective + -est:
tall → the tallest
cheap → the cheapest

Spelling: If it ends in CVC, double the last letter (big → the biggest). If it ends in ''y'', change to ''i'' (busy → the busiest).

Rule 2: Long Adjectives (2+ syllables)
Add the most + adjective:
expensive → the most expensive
comfortable → the most comfortable

Rule 3: Irregular Adjectives (Memorize these)
good → the best
bad → the worst
far → the furthest/farthest

Important: Always use "the" before superlatives.',
   'You are placing three or more nouns on a scale and identifying the extreme point (the highest, lowest, biggest, smallest, etc.).',
   'Use superlatives when comparing three or more things and identifying which one is at the top or bottom of the scale.

Common contexts: "What is the best restaurant in town?" / "She is the tallest person in the class."

Pragmatic note: In spoken English, native speakers often emphasize superlatives with "by far" (This is by far the best option).',
   'Comparatives vs. Superlatives

Comparative (2 things): My car is faster than your car.
Superlative (3+ things): My car is the fastest in the city.',
   'Error: Forgetting "the" before superlatives (She is tallest student).
Fix: Superlatives always need "the" (She is the tallest student).

Error: Mixing both rules (He is the most tallest / This is the more expensive).
Fix: Choose one. Short words get -est. Long words get most. Never both.

Error: Using superlatives for only two things (Between John and Mark, John is the tallest).
Fix: Use comparatives for two things (John is taller than Mark).',
   'Identify the best, worst, biggest, or most extreme option.

Make recommendations (e.g., "This is the best restaurant in town").

Describe records and achievements.',
   'Starter: This is the best movie. → Upgrade: This is hands down the best movie I''ve seen this year.

Starter: She is the most intelligent student. → Upgrade: She''s the brightest student in the class.',
   '[{"type": "fill_blank", "prompt": "Complete: This is ___ (tall) building in the city.", "answer": "the tallest", "feedback": "Use the + adjective + -est for superlatives."}, {"type": "multiple_choice", "prompt": "Choose the correct form: This is ___ expensive restaurant in town.", "options": ["the most", "the more", "most"], "answer": "the most", "feedback": "Use the most with long adjectives."}, {"type": "multiple_choice", "prompt": "Fix the error: She is tallest student.", "options": ["She is the tallest student.", "She is most tallest student.", "She is taller student."], "answer": "She is the tallest student.", "feedback": "Always use the before superlatives."}]'::jsonb,
   '[{"type": "prerequisite", "chapter_code": "A1.G.15", "note": "Study comparatives first"}, {"type": "prerequisite", "chapter_code": "A0.G.04", "note": "Review articles (the)"}]'::jsonb,
   true,
   16),
  
  -- A1.G.17: Basic modals: must / have to / should
  ('A1.G.17', 'Basic modals: must / have to / should', 'A1',
   'Must / Have to (Strong obligation)

Subject + must + base verb
I must finish this today.
You must wear a seatbelt.

Subject + have to / has to + base verb
I have to go to work.
She has to study for the exam.

Should (Advice/Recommendation)

Subject + should + base verb
You should see a doctor.
We should leave early.

Negative forms:
must not (mustn''t) = prohibition (You mustn''t smoke here)
don''t have to = no obligation (You don''t have to come)
shouldn''t = advice against (You shouldn''t eat too much sugar)

Questions:
Must I...? / Do I have to...? / Should I...?',
   'Must and have to express strong obligation or necessity. Should expresses advice or recommendation (weaker than must/have to).

Must often comes from the speaker''s authority or personal feeling.
Have to often comes from external rules or circumstances.',
   'Use must for rules, laws, and strong personal obligations.

Use have to for external obligations and requirements.

Use should for giving advice or making recommendations.

Pragmatic note: In American English, have to is more common than must in everyday speech. Must can sound very formal or authoritative.',
   'Must vs. Have to (Both mean strong obligation, but the source differs)

I must call my mother. (I feel it''s important)
I have to call my boss. (It''s required by my job)

Must not vs. Don''t have to (Very different meanings!)

You mustn''t park here. (It''s prohibited)
You don''t have to park here. (It''s optional; you can park elsewhere)',
   'Error: Using to after must or should (I must to go / You should to study).
Fix: Must and should are modals. They go directly to the base verb. Only have to uses "to".

Error: Confusing mustn''t and don''t have to (You mustn''t come = You don''t have to come).
Fix: Mustn''t = prohibition (don''t do it). Don''t have to = no obligation (it''s optional).

Error: Adding -s to must or should for third person (He musts go / She shoulds study).
Fix: Modals never change form. (He must go / She should study).',
   'Express rules, obligations, and requirements.

Give advice and recommendations.

Explain what is prohibited or not necessary.',
   'Starter: You must be careful. → Upgrade: You need to be careful. / You''d better be careful.

Starter: You should try this restaurant. → Upgrade: You''ve got to try this restaurant. / I highly recommend this restaurant.',
   '[{"type": "multiple_choice", "prompt": "Choose the correct form: You ___ wear a seatbelt. (It''s the law)", "options": ["must", "should", "can"], "answer": "must", "feedback": "Use must for strong obligations and rules."}, {"type": "fill_blank", "prompt": "Complete: You ___ see a doctor. (advice)", "answer": "should", "feedback": "Use should for advice and recommendations."}, {"type": "multiple_choice", "prompt": "Fix the error: I must to go now.", "options": ["I must go now.", "I must going now.", "I am must go now."], "answer": "I must go now.", "feedback": "Don''t add to after must."}]'::jsonb,
   '[{"type": "prerequisite", "chapter_code": "A0.G.10", "note": "Review can for ability"}, {"type": "prerequisite", "chapter_code": "A0.G.11", "note": "Review have/has"}, {"type": "related", "chapter_code": "A1.G.07", "note": "Compare with: Can for requests/permission"}]'::jsonb,
   true,
   17),
  
  -- A1.G.18: Prepositions of time
  ('A1.G.18', 'Prepositions of time', 'A1',
   'At (Specific times)
at 7:00
at noon / at midnight
at night
at the weekend (British English)

On (Days and dates)
on Monday
on January 15th
on my birthday
on the weekend (American English)

In (Longer periods)
in the morning / in the afternoon / in the evening
in January / in summer
in 2024
in the 21st century

Special cases:
No preposition with: yesterday, today, tomorrow, last week, next month, this year
(I saw him yesterday. NOT: I saw him on yesterday.)',
   'Prepositions of time show when something happens. English uses different prepositions depending on whether you''re talking about a specific point in time, a day, or a longer period.',
   'Use at for clock times and specific moments.

Use on for days and dates.

Use in for months, years, seasons, and parts of the day.

Pragmatic note: "At the weekend" (British) vs. "On the weekend" (American) - both are correct depending on your English variety.',
   'At vs. In for parts of the day

at night (Exception - always use "at")
in the morning / in the afternoon / in the evening (Use "in" for these)

On vs. In

on Monday (Specific day)
in January (Whole month)',
   'Error: Using the wrong preposition (in Monday / at January / on 7:00).
Fix: Memorize the pattern: at = times, on = days, in = longer periods.

Error: Adding prepositions with yesterday/today/tomorrow (on yesterday / in tomorrow).
Fix: These words never take prepositions. (I''ll see you tomorrow.)

L1 Transfer Note: Portuguese uses em for most time expressions (na segunda-feira, em janeiro, às 7 horas). English requires three different prepositions, making this a persistent challenge for Brazilian learners.',
   'Talk about schedules and appointments.

Describe when events happen.

Make plans and arrangements.',
   'Starter: I have a meeting on 3:00. → Fix: I have a meeting at 3:00.

Starter: See you in Monday. → Fix: See you on Monday.

Starter: I was born in 1990 in March. → Upgrade: I was born in March 1990.',
   '[{"type": "multiple_choice", "prompt": "Choose the correct preposition: I have class ___ 9:00.", "options": ["at", "on", "in"], "answer": "at", "feedback": "Use at for specific times."}, {"type": "fill_blank", "prompt": "Complete: My birthday is ___ July.", "answer": "in", "feedback": "Use in for months."}, {"type": "multiple_choice", "prompt": "Choose the correct preposition: See you ___ Monday.", "options": ["on", "at", "in"], "answer": "on", "feedback": "Use on for days of the week."}]'::jsonb,
   '[{"type": "prerequisite", "chapter_code": "A0.G.08", "note": "Review prepositions of place first"}]'::jsonb,
   true,
   18),
  
  -- A1.G.19: Questions with how
  ('A1.G.19', 'Questions with how', 'A1',
   'How + adjective/adverb + auxiliary + subject + verb?

How old are you?
How tall is he?
How far is the station?
How long does it take?
How often do you exercise?
How much does it cost?
How many people are coming?

Structure:
How + [adjective/adverb] + [auxiliary verb] + [subject] + [main verb]?

Common "how" questions:
How are you? (General greeting)
How do you spell that?
How do you say X in English?
How was your weekend?',
   'Questions with "how" ask about the manner, degree, or extent of something. They often combine with adjectives (old, tall, far) or adverbs (often, long) to ask for specific measurements or descriptions.',
   'Use "How + adjective" to ask about measurements, age, distance, etc.

Use "How + adverb" to ask about frequency, duration, etc.

Use "How much" for uncountable nouns and prices.

Use "How many" for countable nouns.

Pragmatic note: "How are you?" is a standard greeting, not always a genuine question about your health. The expected response is usually "Fine, thanks" or "Good, how are you?"',
   'How much vs. How many

How much water do you drink? (Uncountable)
How many glasses of water do you drink? (Countable)

How long vs. How far

How long does it take? (Duration/time)
How far is it? (Distance)',
   'Error: Wrong word order (How old you are? / How much costs it?).
Fix: Use question word order: How + adjective + auxiliary + subject + verb. (How old are you? / How much does it cost?)

Error: Using "how" alone when you need "how much/many" (How people are coming?).
Fix: Add "many" for countable nouns. (How many people are coming?)

Error: Confusing "how long" and "how far" (How far does it take to get there?).
Fix: How long = time, How far = distance. (How long does it take?)',
   'Ask about age, height, distance, and other measurements.

Ask about prices and quantities.

Ask about frequency and duration.

Greet people and ask about their well-being.',
   'Starter: How old are you? → Upgrade: Do you mind if I ask how old you are? (More polite for adults)

Starter: How much is it? → Upgrade: How much does this run? / What''s the damage? (Informal)

Starter: How are you? → Upgrade: How''s it going? / How have you been?',
   '[{"type": "fill_blank", "prompt": "Complete: ___ old is your brother?", "answer": "How", "feedback": "Use How + adjective to ask about age."}, {"type": "multiple_choice", "prompt": "Choose the correct question: ___ does it cost?", "options": ["How much", "How many", "How"], "answer": "How much", "feedback": "Use How much for prices."}, {"type": "multiple_choice", "prompt": "Choose the correct question: ___ people are coming?", "options": ["How many", "How much", "How"], "answer": "How many", "feedback": "Use How many for countable nouns."}]'::jsonb,
   '[{"type": "prerequisite", "chapter_code": "A0.G.09", "note": "Review basic question formation first"}, {"type": "related", "chapter_code": "A1.G.05", "note": "See also: Count/Noncount Nouns (for how much/many)"}]'::jsonb,
   true,
   19),
  
  -- A1.G.20: Adverbs of frequency + word order
  ('A1.G.20', 'Adverbs of frequency + word order', 'A1',
   'Common adverbs of frequency (from 100% to 0%):
always (100%)
usually
often
sometimes
occasionally
rarely
seldom
never (0%)

Word order rules:

Rule 1: BEFORE action verbs
I always wake up early.
She usually drinks coffee.
They never eat meat.

Rule 2: AFTER the verb "be"
I am always tired.
He is usually late.
We are never bored.

Rule 3: In questions and negatives, position stays the same
Do you always wake up early?
She doesn''t usually drink coffee.
Are you always tired?

Exceptions: Sometimes, usually, and normally can also go at the beginning or end of a sentence for emphasis.
Sometimes I wake up early. / I wake up early sometimes.',
   'Adverbs of frequency tell us how often something happens. They describe the regularity of an action or state, from "always" (every time) to "never" (not even once).',
   'Use these adverbs to describe habits and routines.

Place them before action verbs but after the verb "be".

For emphasis or variety, sometimes, usually, and normally can move to the beginning or end of the sentence.

Pragmatic note: "Never" is very strong. If you want to soften it, use "hardly ever" or "rarely" instead.',
   'Before action verbs vs. After "be"

I always work late. (Action verb - adverb comes before)
I am always busy. (Verb "be" - adverb comes after)

Adverbs of frequency vs. Time expressions

I always go to the gym. (Frequency - how often)
I go to the gym every day. (Time expression - when)',
   'Error: Putting the adverb after action verbs (I go always to work early).
Fix: Put it before the action verb. (I always go to work early.)

Error: Putting the adverb before "be" (I always am tired).
Fix: Put it after "be". (I am always tired.)

L1 Transfer Note: In Portuguese, adverbs are more flexible and often come after the verb (Eu sempre vou / Eu vou sempre). English has stricter rules: before action verbs, after "be".

Error: Using double negatives (I don''t never eat meat).
Fix: Use either "don''t" or "never", not both. (I never eat meat. / I don''t ever eat meat.)',
   'Describe your daily routines and habits.

Talk about how often you do activities.

Explain your lifestyle and preferences.',
   'Starter: I always drink coffee in the morning. → Upgrade: I can''t start my day without coffee.

Starter: I never eat fast food. → Upgrade: I hardly ever eat fast food. / I try to avoid fast food.

Starter: She is usually late. → Upgrade: She tends to run late. / She''s rarely on time.',
   '[{"type": "fill_blank", "prompt": "Complete: I ___ wake up early. (100%)", "answer": "always", "feedback": "Use always for 100% frequency."}, {"type": "multiple_choice", "prompt": "Choose the correct position: She ___ late.", "options": ["is usually", "usually is", "is usual"], "answer": "is usually", "feedback": "Put adverbs after the verb be."}, {"type": "multiple_choice", "prompt": "Fix the error: I go always to work early.", "options": ["I always go to work early.", "I go to work always early.", "Always I go to work early."], "answer": "I always go to work early.", "feedback": "Put adverbs before action verbs."}]'::jsonb,
   '[{"type": "prerequisite", "chapter_code": "A1.G.01", "note": "Review Simple Present first"}, {"type": "prerequisite", "chapter_code": "A0.G.02", "note": "Review the verb be for word order rules"}]'::jsonb,
   true,
   20),
  
  -- A1.G.21: Basic conjunctions II
  ('A1.G.21', 'Basic conjunctions II', 'A1',
   'Reason: Because

[Situation/Result] + because + [Reason]
I went to bed early because I was tired.
We stayed home because it was raining.

Result: So

[Reason] + , so + [Result]
I was tired, so I went to bed early.
It was raining, so we stayed home.',
   'These two words are two sides of the same coin. Because points backward to the cause. So points forward to the effect.',
   'Use because to answer "Why?" questions.

Use so to narrate a story chronologically (Action A happened, so Action B happened).

Punctuation note: Usually, we put a comma before so. We do not put a comma before because.',
   'Because vs. Because of (Intro)

I am late because there was traffic. (Because + subject + verb)
I am late because of the traffic. (Because of + noun).',
   'Error: Starting a sentence with "Because" and leaving it incomplete (Why are you late? Because the bus was late.)
Fix: In spoken English, this is perfectly fine! However, in formal writing, because needs to connect two ideas in the same sentence. (I am late because the bus was late).

Error: Confusing so and to for purpose (I went to the store so buy milk).
Fix: Use to for the purpose of an action (I went to the store to buy milk). Use so for a logical result (I had no milk, so I went to the store).',
   'Explain your reasons for doing something.

Describe the results of an action.

Connect simple, short sentences into longer, more fluent ideas.',
   'Starter: I was sick, so I didn''t go. → Upgrade: I was sick. That''s why I didn''t go.

Starter: I like it because it''s cheap. → Upgrade: I like it mostly because it''s cheap.',
   '[{"type": "fill_blank", "prompt": "Complete: I stayed home ___ I was tired.", "answer": "because", "feedback": "Use because to give a reason."}, {"type": "multiple_choice", "prompt": "Choose the correct connector: I was tired, ___ I went to bed.", "options": ["so", "because", "but"], "answer": "so", "feedback": "Use so to show the result."}, {"type": "multiple_choice", "prompt": "Fix the error: I went to the store so buy milk.", "options": ["I went to the store to buy milk.", "I went to the store because buy milk.", "I went to the store so to buy milk."], "answer": "I went to the store to buy milk.", "feedback": "Use to for purpose, not so."}]'::jsonb,
   '[{"type": "prerequisite", "chapter_code": "A0.G.12", "note": "Review simple connectors (and/but) first"}]'::jsonb,
   true,
   21),
  
  -- A1.G.22: Basic object + infinitive
  ('A1.G.22', 'Basic object + infinitive', 'A1',
   'Subject + Verb + to + Base Verb

I want to learn. / She wants to travel.
I need to sleep. / He needs to work.
We have to go. / It has to stop.

Negatives:

I don''t want to go.
She doesn''t need to buy that.',
   'These verbs are forward-looking. They express a feeling or rule about an action that will happen next. The to acts as the bridge connecting your desire/need to the action itself.',
   'Want to: For desires and preferences.

Need to: For strong necessities (survival, health, strict deadlines).

Have to: For external obligations (rules from society or bosses - see A1.G.17).

Pronunciation upgrade: In casual speech, want to becomes wanna, and have to becomes hafta.',
   'Verb + Noun vs. Verb + Infinitive

I want a car. (Noun object)
I want to buy a car. (Infinitive action object)',
   'Error: Forgetting the "to" bridge (I want go home / I need sleep).
Fix: You cannot smash two conjugated verbs together in English. You must use "to" to connect them.

L1 Transfer Note: In Portuguese, the second verb is just in the infinitive without a bridge word (Eu quero ir). Emphasize that in English, the "to" is mandatory glue.

Error: Putting an ''s'' on the second verb (He wants to plays).
Fix: The ''s'' goes on the first verb (wants/needs/has). The verb after ''to'' is always a naked base verb.',
   'Set goals and express your desires.

Talk about your physical or professional needs.

State your obligations and daily tasks.',
   'Starter: I want to go to the bathroom. → Upgrade: I need to use the restroom. (More polite).

Starter: I want to see the menu. → Upgrade: I''d like to see the menu, please. (Softer).',
   '[{"type": "fill_blank", "prompt": "Complete: I want ___ learn English.", "answer": "to", "feedback": "Use to after want to connect to the action."}, {"type": "multiple_choice", "prompt": "Choose the correct form: She needs ___ sleep.", "options": ["to", "for", "at"], "answer": "to", "feedback": "Use to after need."}, {"type": "multiple_choice", "prompt": "Fix the error: He wants go home.", "options": ["He wants to go home.", "He wants going home.", "He want to go home."], "answer": "He wants to go home.", "feedback": "Add to between want and the base verb."}]'::jsonb,
   '[{"type": "prerequisite", "chapter_code": "A1.G.01", "note": "Review Simple Present first"}, {"type": "related", "chapter_code": "A1.G.09", "note": "Compare with: Like/love/hate + -ing"}]'::jsonb,
   true,
   22),
  
  -- A1.G.23: Basic "too/enough"
  ('A1.G.23', 'Basic "too/enough"', 'A1',
   'Too (More than you need/want)

too + adjective
The shoes are too small.
It is too expensive.

Enough (Exactly what you need/want)

adjective + enough
The shoes are big enough.
Is the water warm enough?

Not enough (Less than you need/want)

not + adjective + enough
It is not big enough.',
   'These words judge limits. Too means a limit has been crossed, and it is usually a negative thing. Enough means the requirement has been successfully met.',
   'Very common in shopping scenarios (clothes, houses, cars) and talking about weather or food.',
   'Very vs. Too

Very just makes an adjective stronger. It can be good or bad. (This car is very fast = I like it! / It is very expensive = Just a fact).

Too means there is a problem. (This car is too fast = I am scared. / It is too expensive = I cannot buy it).',
   'Error: Putting enough before the adjective (This shirt is enough big).
Fix: Enough always comes after the adjective. (This shirt is big enough).

L1 Transfer Note: In Portuguese, the word order is flexible or reversed (É grande o suficiente or É suficientemente grande). In English, the order is locked: Adjective first, enough second.',
   'Evaluate products or situations.

Complain about problems (temperature, size, price).

Explain why you cannot do something.',
   'Starter: It is too expensive. → Upgrade: It''s a bit out of my price range.

Starter: It is not big enough. → Upgrade: I think I need a larger size.',
   '[{"type": "multiple_choice", "prompt": "Choose the correct form: The shoes are ___ small.", "options": ["too", "enough", "very"], "answer": "too", "feedback": "Use too when something exceeds the limit (negative)."}, {"type": "fill_blank", "prompt": "Complete: Is the water warm ___?", "answer": "enough", "feedback": "Enough comes after the adjective."}, {"type": "multiple_choice", "prompt": "Fix the error: This shirt is enough big.", "options": ["This shirt is big enough.", "This shirt is too big.", "This shirt enough is big."], "answer": "This shirt is big enough.", "feedback": "Put enough after the adjective."}]'::jsonb,
   '[{"type": "related", "chapter_code": "A1.G.15", "note": "See also: Comparatives (for comparing options)"}]'::jsonb,
   true,
   23),
  
  -- A1.G.24: Basic relative clauses
  ('A1.G.24', 'Basic relative clauses', 'A1',
   'For People: use WHO

Noun (Person) + who + Verb...
He is the man who lives next door.
I like people who are honest.

For Things: use THAT

Noun (Thing) + that + Verb...
It is a machine that makes coffee.
Where is the book that was on the table?',
   'Relative clauses act like one giant adjective. They attach directly to a noun to give essential information about it, answering the question: "Which one?"',
   'Survival strategy: This is the most important grammar for A1 learners when they forget a vocabulary word. If you forget the word "dentist," you can say: "I need to see a doctor who fixes teeth."',
   'Two sentences vs. One clause

Basic: I have a friend. He speaks Japanese.
Better: I have a friend who speaks Japanese.',
   'Error: Repeating the subject pronoun inside the clause (He is the man who he lives next door).
Fix: The word who replaces he/she/they. You cannot have both. Drop the pronoun.

L1 Transfer Note: In informal spoken Portuguese, people often leave the pronoun in (O cara que ele mora aqui). This is a hard error in English.

Error: Using who for things, or which for people.
Fix: Keep it strict at A1: Who is for humans. That is for objects/animals.',
   'Define words you don''t know in English (circumlocution).

Describe exactly which person or thing you are talking about.

Combine two short, choppy sentences into one smooth one.',
   'Starter: A person who makes food is a chef. → Upgrade: Basically, it''s a person who makes food.

Starter: It is a thing that you use for your hair. → Upgrade: It''s a kind of thing that you use for your hair.',
   '[{"type": "multiple_choice", "prompt": "Choose the correct word: He is the man ___ lives next door.", "options": ["who", "that", "which"], "answer": "who", "feedback": "Use who for people."}, {"type": "fill_blank", "prompt": "Complete: It is a machine ___ makes coffee.", "answer": "that", "feedback": "Use that for things."}, {"type": "multiple_choice", "prompt": "Fix the error: He is the man who he lives here.", "options": ["He is the man who lives here.", "He is the man that he lives here.", "He is the man lives here."], "answer": "He is the man who lives here.", "feedback": "Don''t repeat the pronoun after who."}]'::jsonb,
   '[{"type": "prerequisite", "chapter_code": "A0.G.09", "note": "Review basic question formation first"}, {"type": "prerequisite", "chapter_code": "A1.G.01", "note": "Review Simple Present for verb forms in clauses"}]'::jsonb,
   true,
   24)
) AS new_chapters(
  chapter_code,
  title,
  cefr_level,
  form_content,
  meaning_content,
  use_content,
  contrast_notes,
  common_errors,
  diagnostic_hook,
  task_upgrades,
  micro_practice,
  cross_links,
  is_published,
  sort_order
)
WHERE NOT EXISTS (
  SELECT 1
  FROM public.grammar_chapters
  WHERE chapter_code = new_chapters.chapter_code
);
