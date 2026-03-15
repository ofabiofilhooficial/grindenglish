-- Add A2 Grammar Lessons
-- This migration adds 28 A2-level grammar lessons to the grammar_chapters table.
-- The lessons cover pre-intermediate grammar topics including irregular past verbs,
-- past continuous, present perfect, expanded modals, conditionals, gerunds vs infinitives,
-- passive voice introduction, relative clauses, and more.
--
-- IDEMPOTENCY: This migration uses WHERE NOT EXISTS to check for existing chapter_codes
-- before insertion, allowing safe re-execution without creating duplicates.
-- If a chapter_code already exists, that insertion is skipped without error.

-- Insert A2 grammar chapters using idempotent pattern
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
  ('A2.G.01', 'Past Simple (Irregular Verbs)', 'A2', 'Affirmative (+): Subject + Irregular Verb (V2)
There are no rules for affirmative irregular verbs. They must be memorized.
go → went
have → had
buy → bought
see → saw

Negative (-): Subject + didn''t + Base Verb
I didn''t go to the party.
She didn''t buy the laptop.

Questions (?): Did + Subject + Base Verb
Did you have a good weekend?
What did he see?', 'Just like regular verbs (A1.G.11), irregular verbs describe actions that started and finished completely in the past.', 'Use these with clear past time markers: yesterday, last month, three days ago, in 2022.
When telling a story, use sequence markers to connect irregular actions: First I woke up, then I had coffee, and after that, I went to work.', 'Regular: I worked yesterday. (Follows the -ed rule).
Irregular: I left early yesterday. (Breaks the rule).', 'Error: The "Double Past" (Did you went? / I didn''t saw it).
Fix: Remember the "time machine" rule from A1. Did and didn''t already show the past. The main verb must stay in the base form.

Error: Adding -ed to irregular verbs (He buyed a car / I catched the ball).
Fix: This happens when learners internalize the grammar rule too well. Keep a top-20 irregular verb list handy until they become automatic.

L1 Transfer Note: Portuguese verbs follow highly predictable conjugation patterns even when irregular. English irregulars often look completely different from their base forms (teach → taught). Encourage spaced repetition and grouping verbs by sound patterns (e.g., buy-bought, bring-brought, catch-caught).', 'Tell chronological, engaging stories about your life or career.
Explain what happened during a trip or over the weekend.
Report a sequence of events in a meeting or email.', 'Starter: I went to sleep. → Upgrade: I crashed as soon as I got home.
Starter: I had a good time. → Upgrade: I had a blast.', '[{"type":"fill_blank","prompt":"Write the past tense form of ''think''","answer":"thought","feedback":"The past tense of think is thought (irregular verb)"},{"type":"fill_blank","prompt":"Write the past tense form of ''make''","answer":"made","feedback":"The past tense of make is made (irregular verb)"},{"type":"fill_blank","prompt":"Write the past tense form of ''take''","answer":"took","feedback":"The past tense of take is took (irregular verb)"},{"type":"correction","prompt":"Fix the error: I didn''t saw it.","answer":"I didn''t see it.","feedback":"Remember the ''time machine'' rule. Did and didn''t already show the past. The main verb must stay in the base form (see, not saw)."},{"type":"correction","prompt":"Fix the error: He buyed a car.","answer":"He bought a car.","feedback":"Don''t add -ed to irregular verbs. The past tense of buy is bought."},{"type":"mini_output","prompt":"Speaking: Tell a partner three things you did last weekend in chronological order. Use ''First'', ''Then'', and ''After that''.","answer":"Example: First, I went to the gym. Then, I had lunch with friends. After that, I watched a movie.","feedback":"Your response should include three past simple verbs with sequence markers (First, Then, After that). Make sure to use irregular past forms correctly."}]'::jsonb, '[{"type":"prerequisite","chapter_code":"A1.G.11","note":null},{"type":"prerequisite","chapter_code":"A1.G.12","note":null},{"type":"advanced","chapter_code":"A2.G.02","note":null},{"type":"advanced","chapter_code":"B1.G.03","note":"Narrative tenses"}]'::jsonb, true, 1),
  ('A2.G.02', 'Past Continuous', 'A2', 'Subject + was/were + Verb-ing

Affirmative (+) | Negative (-) | Question (?)
I was working. | I wasn''t working. | Was I working?
They were sleeping. | They weren''t sleeping. | Were they sleeping?

Connecting Words:
When + Past Simple (the interruption)
While + Past Continuous (the background action)', 'The past continuous shows an action that was in progress at a specific moment in the past. It provides the "background vibe" of a situation.', 'Answering specific time questions: "What were you doing at 8 PM last night?" → "I was eating dinner."
Explaining interruptions: "I was taking a shower when the phone rang."', 'Past Simple: The sun shined yesterday. (A simple fact about the whole day).
Past Continuous: The sun was shining, and the birds were singing when I woke up. (Setting a vivid scene for a story).', 'Error: Using past simple for interrupted actions (I cooked when he called).
Fix: If you were in the middle of the action, use was/were + -ing. (I was cooking when he called).

L1 Transfer Note: Portuguese speakers actually have an advantage here, as the past continuous translates very neatly (Eu estava cozinhando quando ele ligou). However, learners often default to the simple past because it feels "safer" and shorter. Encourage them to stretch their sentences out to sound more fluent.', 'Set the scene for a story.
Explain what you were in the middle of doing when someone called or interrupted you.
Provide a polite excuse for missing a call or a message.', 'Starter: I was working when you called. → Upgrade: I was right in the middle of working when you called.
Starter: Sorry I didn''t answer. I was driving. → Upgrade: I couldn''t pick up because I was behind the wheel.', '[{"type":"multiple_choice","prompt":"Choose the correct tense: I ___ my phone while I ___ to the bus.","options":["dropped / ran","was dropping / was running","dropped / was running","was dropping / ran"],"answer":"dropped / was running","feedback":"Use past simple (dropped) for the completed action and past continuous (was running) for the action in progress when interrupted."},{"type":"multiple_choice","prompt":"Choose the correct tense: What ___ when the power went out?","options":["did you do","were you doing","have you done","do you do"],"answer":"were you doing","feedback":"Use past continuous to ask what someone was in the middle of doing at a specific moment in the past."},{"type":"multiple_choice","prompt":"Choose the correct tense: While we ___ a movie, my friend ___ me.","options":["watched / texted","were watching / texted","watched / was texting","were watching / was texting"],"answer":"were watching / texted","feedback":"Use past continuous (were watching) for the background action and past simple (texted) for the interruption."},{"type":"transformation","prompt":"Combine using ''when'' or ''while'': I was reading a book. I fell asleep.","answer":"I fell asleep while I was reading a book.","feedback":"Use ''while'' with the past continuous (was reading) for the background action, and ''when'' with the past simple (fell asleep) for the interruption."},{"type":"transformation","prompt":"Combine using ''when'' or ''while'': We were having a meeting. The fire alarm rang.","answer":"The fire alarm rang while we were having a meeting.","feedback":"Use ''while'' with the past continuous (were having) for the background action, and ''when'' with the past simple (rang) for the interruption."},{"type":"mini_output","prompt":"Writing: Write a text message apologizing to a colleague for missing their phone call. Explain exactly what you were doing when they tried to reach you.","answer":"Example: Sorry I missed your call! I was in a meeting when you called. I''ll call you back in 10 minutes.","feedback":"Your message should explain what you were doing (past continuous) when they called. Use ''was/were + -ing'' to show the action in progress."}]'::jsonb, '[{"type":"prerequisite","chapter_code":"A1.G.08","note":null},{"type":"prerequisite","chapter_code":"A1.G.10","note":null},{"type":"advanced","chapter_code":"B1.G.03","note":"Narrative tenses"}]'::jsonb, true, 2),
  ('A2.G.03', 'Present Perfect', 'A2', 'Subject + have/has + Past Participle (V3)
I have (''ve) been to Japan.
She has (''s) eaten sushi.
We haven''t seen that movie.

Using Ever and Never:
Questions: Have you ever worked in sales? (At any point in your life).
Negative: I have never worked in sales. (Zero times in my life).', 'When you use the present perfect for experience, you are talking about your life as an unfinished timeline. You are not saying when something happened, just that the experience currently exists in your brain.', 'The "Have you ever...?" loop: This is the most common conversation starter in English.
Person A: "Have you ever been to Paris?" (Present Perfect - establishing the experience).
Person B: "Yes, I have. I went there in 2019." (Past Simple - shifting to the specific details).', 'Past Simple: I went to London in 2015. (Focus is on the specific date).
Present Perfect: I have been to London. (Focus is on the fact that I possess this experience).', 'Error: Using past simple to ask about life experiences (Did you ever eat snails?).
Fix: Always use Have you ever...? to ask about someone''s life timeline.

L1 Transfer Note: This is a major hurdle. In Portuguese, asking about life experience uses the simple past with já (Você já comeu escargot?). Using the direct translation (Did you already eat?) sounds unnatural in English. Drill "Have you ever..." as a single, unbreakable chunk of vocabulary.

Error: Using gone instead of been (I have gone to Italy three times).
Fix: Been means you went and came back (experience). Gone means you went and are still there!', 'Network and find common ground with new people.
Answer interview questions about your skills and history.
Brag about exciting things you have accomplished.', 'Starter: Have you ever eaten Thai food? → Upgrade: Have you tried the new Thai place downtown?
Starter: I have never done that. → Upgrade: I''ve never done that before, but I''d love to try.', '[{"type":"multiple_choice","prompt":"Choose the correct option: ___ to a music festival?","options":["Did you ever go","Have you ever been"],"answer":"Have you ever been","feedback":"Use ''Have you ever been'' to ask about life experiences. ''Did you ever go'' is incorrect in English."},{"type":"multiple_choice","prompt":"Choose the correct option: I ___ that movie last night.","options":["have seen","saw"],"answer":"saw","feedback":"Use past simple ''saw'' with a specific time reference like ''last night''. Present perfect ''have seen'' is for life experience without a specific time."},{"type":"multiple_choice","prompt":"Choose the correct option: She knows a lot about software because she ___ in IT for years.","options":["has worked","worked"],"answer":"has worked","feedback":"Use present perfect ''has worked'' to show an action that started in the past and continues to the present. The duration ''for years'' indicates ongoing experience."},{"type":"fill_blank","prompt":"Complete: I have never ___ (do) that before.","answer":"done","feedback":"The past participle of ''do'' is ''done''. Use ''I have never done that'' to say you''ve never had this experience."},{"type":"mini_output","prompt":"Speaking: Play ''Two Truths and a Lie'' with a partner using the Present Perfect. Create three sentences about your life experiences.","answer":"Example: I have met a celebrity. I have broken my arm. I have never flown in a helicopter.","feedback":"Your sentences should use ''I have'' or ''I have never'' to talk about life experiences. Your partner should guess which statement is false."}]'::jsonb, '[{"type":"prerequisite","chapter_code":"A2.G.01","note":null},{"type":"advanced","chapter_code":"A2.G.04","note":null},{"type":"advanced","chapter_code":"B1.G.01","note":null}]'::jsonb, true, 3),
  ('A2.G.04', 'Present Perfect II', 'A2', 'Subject + have/has + [just / already / yet] + V3

Just (A few moments ago): I have just finished the report. (Goes in the middle).
Already (Sooner than expected): I have already paid the bill. (Goes in the middle).
Yet (Expected, but hasn''t happened): 
* Questions: Have you sent the email yet? (Goes at the end).
* Negatives: I haven''t sent it yet. (Goes at the end).', 'While A2.G.03 looked at your whole life, this structure looks at the very recent past. The action just finished, and the result is highly visible or important right now.', 'Use already to refuse offers politely: "Would you like some coffee?" -> "No thanks, I''ve already had two cups."
Use yet to manage expectations: "Is the meeting ready?" -> "Not yet, I haven''t set up the projector yet."', 'Past Simple: I finished my homework at 4:00. (Cold, historical fact).
Present Perfect: Can I watch TV? I''ve just finished my homework! (Hot news! The result matters right now).', 'Error: Putting yet in the middle of the sentence (I haven''t yet finished).
Fix: Yet is heavy; it sinks to the very end of the sentence.

L1 Transfer Note: In Portuguese, já acts as a wildcard for already, ever, now, and sometimes yet. (Você já terminou?). Brazilians often translate this to: "Did you already finish?" Instruct learners that in English questions expecting a result, yet at the end of the sentence is the most natural choice: "Have you finished yet?"', 'Give immediate updates on a project''s status.
Offer a reason why you don''t want to do something (e.g., "I''ve already eaten").
Ask if a deadline has been met.', 'Starter: I just arrived. → Upgrade: I literally just walked in the door.
Starter: I haven''t done it yet. → Upgrade: I haven''t gotten around to it yet.', '[{"type":"fill_blank","prompt":"Put ''already'' in the correct place: She has left the office.","answer":"She has already left the office.","feedback":"''Already'' goes in the middle of the present perfect structure, between ''has/have'' and the past participle."},{"type":"fill_blank","prompt":"Put ''yet'' in the correct place: Have you checked your emails?","answer":"Have you checked your emails yet?","feedback":"''Yet'' is heavy and sinks to the very end of the sentence, especially in questions."},{"type":"fill_blank","prompt":"Put ''just'' in the correct place: We have signed the contract!","answer":"We have just signed the contract!","feedback":"''Just'' goes in the middle of the present perfect structure, between ''have'' and the past participle."},{"type":"multiple_choice","prompt":"Choose the correct response: Coworker: ''Don''t forget to pay the internet bill!'' You: ''Don''t worry, I ___.''","options":["have already paid it","haven''t paid it yet","will pay it","am paying it"],"answer":"have already paid it","feedback":"Use ''have already paid'' to reassure your coworker that you''ve completed the task. This shows the action is finished and the result is visible now."},{"type":"multiple_choice","prompt":"Choose the correct response: Boss: ''Is the presentation ready?'' You: ''Sorry, I ___.''","options":["have already finished","haven''t finished yet","will finish","am finishing"],"answer":"haven''t finished yet","feedback":"Use ''haven''t finished yet'' to indicate the task is not complete but is expected to be done soon. ''Yet'' manages expectations."},{"type":"mini_output","prompt":"Writing: Write a quick status update email to your team. State one thing you have already done today, and one thing you haven''t finished yet.","answer":"Example: I have already completed the budget report. However, I haven''t finished the client presentation yet.","feedback":"Your email should include one completed task (with ''already'') and one incomplete task (with ''yet''). Use present perfect to show current relevance."}]'::jsonb, '[{"type":"prerequisite","chapter_code":"A2.G.03","note":null},{"type":"advanced","chapter_code":"B1.G.01","note":null}]'::jsonb, true, 4),
  ('A2.G.05', 'Future Forms Review', 'A2', 'Will (Decisions/Offers): I''ll call you back.
Be going to (Intentions/Plans): I''m going to study tonight.
Present Continuous (Fixed Arrangements): I''m meeting the boss at 3 PM tomorrow.', 'Will: The decision was made at the exact moment of speaking. It popped into your head.
Going to: The decision was made in the past. It is an intention, but it might only involve you.
Present Continuous: The decision is locked in. It usually involves other people, a specific time, and an entry in your calendar.', 'If a colleague asks, "Can we meet tomorrow?", do NOT use will. Look at your calendar and say: "Sorry, I''m having lunch with a client at 12, but I''m going to be free after 2 PM."', 'Going to vs. Present Continuous
I''m going to travel to Europe someday. (Intention. No tickets bought).
I''m traveling to Europe next Friday. (Arrangement. Tickets bought, bags packed).', 'Error: Using Present Simple for future arrangements (Tomorrow I travel to São Paulo).
Fix: Unless it is a bus or train schedule, do not use Present Simple for the future. Use the Present Continuous. (Tomorrow I am traveling to São Paulo).

L1 Transfer Note: Because Portuguese leans heavily on the simple present (Amanhã eu viajo) or vou + infinitive (Vou viajar) for the future, the English Present Continuous feels completely wrong to Brazilian learners because it looks like it means "right now." Reassure them that native speakers use this constantly for future diary events.', 'Manage your calendar and schedule appointments.
Make spontaneous offers to help others.
Clearly explain your intentions versus your fixed plans.', 'Starter: I will help you with that. → Upgrade: Let me take care of that for you.
Starter: I am going to the doctor tomorrow at 4. → Upgrade: I have a doctor''s appointment tomorrow at 4.', '[{"type":"multiple_choice","prompt":"Choose the best future form. Phone rings. \"I (will / am going to) answer it!\"","options":["will","am going to"],"answer":"will","feedback":"Use ''will'' for spontaneous decisions made at the moment of speaking."},{"type":"multiple_choice","prompt":"Choose the best future form: I can''t meet you on Friday. I (will fly / am flying) to Miami for a conference.","options":["will fly","am flying"],"answer":"am flying","feedback":"Use present continuous for fixed arrangements with specific dates and times."},{"type":"multiple_choice","prompt":"Choose the best future form: Have you decided what to do with the money? \"Yes, I (will / am going to) buy a new car.\"","options":["will","am going to"],"answer":"am going to","feedback":"Use ''going to'' for intentions and plans made before the moment of speaking."},{"type":"fill_blank","prompt":"Complete: After this lesson, I am going to ____________________.","answer":"[any future activity]","feedback":"Use ''going to'' for intentions and plans."},{"type":"mini_output","prompt":"Speaking: Look at your schedule for tomorrow. Tell a partner about two fixed arrangements you have, and one general intention you hope to accomplish.","answer":"Example: I''m meeting my boss on Wednesday at 3 PM. I''m going to study for my exam this weekend. I''ll help you move if you need me.","feedback":"Your response should show the difference between fixed arrangements (present continuous), intentions (going to), and spontaneous offers (will)."}]'::jsonb, '[{"type":"prerequisite","chapter_code":"A1.G.08","note":null},{"type":"prerequisite","chapter_code":"A1.G.13","note":null},{"type":"prerequisite","chapter_code":"A1.G.14","note":null},{"type":"advanced","chapter_code":"B1.G.05","note":"Future continuous"}]'::jsonb, true, 5),
  ('A2.G.06', 'Modals for Obligation/Permission II', 'A2', 'Obligation: You must wear a badge. / You have to wear a badge.
No Obligation (Optional): You don''t have to work on Saturday.
Prohibition (Forbidden): You mustn''t park here. / You can''t park here.
Permission: You can leave early. / You are allowed to leave early.', 'This grammar dictates the rules of society. It tells you what is necessary, what is a choice, and what will get you into trouble.', 'Can is the most common way to give permission in everyday speech.
Be allowed to is used to talk about the rules from a distance (e.g., "We are allowed to wear jeans on Fridays").', 'Mustn''t vs. Don''t have to (Review from A1)
You mustn''t tell the boss. (It is a secret. Keep your mouth shut).
You don''t have to tell the boss. (It''s up to you. I don''t care if you do or don''t).', 'Error: Using can when you mean must (You can pay your taxes).
Fix: Can means you have a choice. Paying taxes is not a choice! Use have to.

L1 Transfer Note: Brazilians often confuse have to and must in the negative forms, as mentioned in A1. At the A2 level, reinforce that não precisa = don''t have to, and não pode = can''t / mustn''t. Another common error is adding to after mustn''t (You mustn''t to go).', 'Read and explain workplace guidelines or city laws.
Grant or deny permission professionally.
Clarify what tasks are optional.', 'Starter: You mustn''t do that. → Upgrade: That''s strictly prohibited. / You''re not supposed to do that.
Starter: You don''t have to come. → Upgrade: It''s completely optional. / No pressure to come.', '[{"type":"multiple_choice","prompt":"Choose the correct modal: The museum is free on Sundays. You ___ pay.","options":["mustn''t","don''t have to"],"answer":"don''t have to","feedback":"Use ''don''t have to'' to show something is optional. ''Mustn''t'' means it''s forbidden."},{"type":"multiple_choice","prompt":"Choose the correct modal: You ___ smoke inside the building.","options":["aren''t allowed to","don''t have to"],"answer":"aren''t allowed to","feedback":"Use ''aren''t allowed to'' or ''can''t'' to show something is prohibited/forbidden."},{"type":"multiple_choice","prompt":"Choose the correct modal: Employees ___ take a one-hour lunch break whenever they want between 12 and 2.","options":["can","have to"],"answer":"can","feedback":"Use ''can'' to show permission or choice. ''Have to'' would mean it''s mandatory."},{"type":"fill_blank","prompt":"Complete: You ___ (must/have to) wear a badge in this building.","answer":"must / have to","feedback":"Both ''must'' and ''have to'' show obligation. They are nearly interchangeable."},{"type":"mini_output","prompt":"Speaking: Think of a strict rule in your house or at your workplace. Explain it to a partner using ''have to'', and tell them one thing that is optional using ''don''t have to''.","answer":"Example: At work, we have to arrive by 9 AM. However, we don''t have to stay past 5 PM if we finish our tasks.","feedback":"Your response should clearly distinguish between mandatory rules (have to) and optional activities (don''t have to)."}]'::jsonb, '[{"type":"prerequisite","chapter_code":"A1.G.07","note":null},{"type":"prerequisite","chapter_code":"A1.G.17","note":null},{"type":"advanced","chapter_code":"B1.G.09","note":"Modals of advice"}]'::jsonb, true, 6),
  ('A2.G.07', 'First Conditional', 'A2', 'The "If" Clause (Condition) + The Main Clause (Result)
If + Subject + Present Simple, Subject + will + Base Verb
If it rains, we will stay home.
If you help me, I will buy you lunch.

Reversing the order: You can put the result first. If you do, drop the comma.
We will stay home if it rains.', 'The first conditional talks about a real, possible situation in the future. It is not a fantasy; it is a highly likely cause and effect.', 'Use this for practical, everyday planning and problem-solving.
It is the standard grammar for making a deal.', 'Two separate sentences: It might rain. We will stay home. (Disconnected).
First conditional: If it rains, we will stay home. (Logically linked).', 'Error: Putting will in the If clause (If it will rain, we will stay home).
Fix: If acts as a barrier. The word will cannot go inside the If clause. It must stay in the result half of the sentence.

L1 Transfer Note: In Portuguese, the future subjunctive is used here (Se chover / Se eu for). Because learners want to express a future idea, they often reach for will. Drill the formula: If + Present.', 'Make plans that depend on the weather or other people.
Give warnings or make promises in the workplace.
Negotiate basic terms (e.g., "If you lower the price, I will buy it").', 'Starter: If you call, I will answer. → Upgrade: Give me a call if you need anything.
Starter: If we don''t hurry, we will be late. → Upgrade: We''ll miss the flight if we don''t leave right now.', '[{"type":"correction","prompt":"Fix the error: If it will rain, we will stay home.","answer":"If it rains, we will stay home.","feedback":"The ''if'' clause must use present simple, not ''will''. The ''will'' stays only in the result clause."},{"type":"correction","prompt":"Fix the error: If they don''t arrive soon, we leave without them.","answer":"If they don''t arrive soon, we will leave without them.","feedback":"The result clause needs ''will'' to show future. Use: If + present, will + base verb."},{"type":"fill_blank","prompt":"Complete: If I have free time this weekend, I ____________________.","answer":"will [do something]","feedback":"Use ''will'' in the result clause to show a future consequence of the condition."},{"type":"transformation","prompt":"Combine into a first conditional: I will be very happy. You come to my party.","answer":"I will be very happy if you come to my party.","feedback":"Use ''if'' to connect the condition (you come) with the result (I will be happy)."},{"type":"mini_output","prompt":"Writing: Write a short text message to a friend making a backup plan for the weekend in case the weather is bad.","answer":"Example: If it rains on Saturday, let''s go to the movies instead. If the weather is nice, we can go hiking.","feedback":"Your message should include at least one first conditional sentence showing a plan that depends on a condition."}]'::jsonb, '[{"type":"prerequisite","chapter_code":"A1.G.01","note":null},{"type":"prerequisite","chapter_code":"A1.G.14","note":null},{"type":"advanced","chapter_code":"B1.G.10","note":"Conditionals 1 & 2 productive control"}]'::jsonb, true, 7),
  ('A2.G.08', 'Zero Conditional', 'A2', 'If/When + Present Simple, Present Simple
If you heat ice, it melts.
When I have a headache, I take medicine.
The machine turns off if you press this button.', 'The zero conditional is not about the future; it is about always. It describes a 100% guaranteed result. If A happens, B always happens.', 'You can almost always replace If with When or Whenever in the zero conditional without changing the meaning.
Highly useful in IT, technical support, and HR (explaining company rules).', 'First Conditional (Future/Specific) vs. Zero Conditional (Always/General)
First (Specific day): If it rains tomorrow, I will take the bus.
Zero (General habit): If it rains, I take the bus. (Every time it rains, this is my routine).', 'Error: Using will for general facts (If you mix blue and yellow, you will get green).
Fix: While native speakers sometimes do this, it''s better to stick to the present simple for absolute facts to sound more authoritative. (If you mix blue and yellow, you get green).', 'Explain scientific facts and absolute truths.
Give instructions on how machines or software work.
Describe your non-negotiable personal routines.', 'Starter: If I drink coffee at night, I don''t sleep. → Upgrade: Whenever I drink coffee late, I can''t fall asleep.
Starter: If the screen is black, push the button. → Upgrade: When in doubt, just restart the computer.', '[{"type":"multiple_choice","prompt":"Choose the correct form: Generally, if you ___ water, it expands.","options":["freeze","will freeze"],"answer":"freeze","feedback":"Use present simple for both clauses in the zero conditional because this is a general fact that always happens."},{"type":"multiple_choice","prompt":"Choose the correct form: Look at those clouds! If it rains, I ___ wet.","options":["get","will get"],"answer":"will get","feedback":"This is a first conditional (specific future situation), not zero conditional. Use ''will'' in the result clause."},{"type":"multiple_choice","prompt":"Choose the correct form: When I am stressed, I usually ___ to music.","options":["listen","will listen"],"answer":"listen","feedback":"This describes a habitual action (zero conditional). Use present simple for both clauses."},{"type":"fill_blank","prompt":"Complete: What happens if you arrive late to work? → If you arrive late, ____________________.","answer":"you get in trouble / you lose pay / etc.","feedback":"Use present simple in both clauses to describe a general rule or consequence that always happens."},{"type":"mini_output","prompt":"Speaking: Explain a personal routine to a partner. Give two examples of what you do when you feel stressed, and what you do when you have trouble sleeping.","answer":"Example: When I feel stressed, I go for a run. If I can''t sleep, I read a book.","feedback":"Your response should use zero conditional (present simple in both clauses) to describe habitual actions and general truths."}]'::jsonb, '[{"type":"prerequisite","chapter_code":"A2.G.07","note":null},{"type":"advanced","chapter_code":"A2.G.25","note":"Second conditional intro"}]'::jsonb, true, 8),
  ('A2.G.09', 'Gerunds vs Infinitives', 'A2', 'When you put two verbs next to each other, the first verb acts as the boss. It decides what uniform the second verb must wear: the to-infinitive (to do) or the gerund (-ing).

Group A: The "to-infinitive" Bosses (Usually about the future/plans)
want, need, plan, decide, hope, promise
I plan to travel next year.
She decided to quit her job.

Group B: The "-ing" Bosses (Usually about experiences/habits)
enjoy, avoid, finish, mind, suggest, practice
I enjoy reading before bed.
He avoided answering the question.', 'There is no perfect logical rule here, but generally: verbs looking forward to an uncompleted action take to. Verbs dealing with ongoing, real, or finished experiences take -ing.', 'At the A2 level, this is purely an exercise in memorizing high-frequency combinations so you can speak without pausing to translate.', 'Wrong: I enjoy to cook.
Right: I enjoy cooking.', 'Error: Defaulting to the infinitive for everything (I finished to eat / I avoid to drive).
Fix: Memorize Group B (enjoy, avoid, finish, mind) immediately. These are the most common troublemakers.

L1 Transfer Note: In Portuguese, chaining two verbs almost always uses the infinitive (Terminei de comer, evito dirigir, gosto de ler). The English gerund (-ing) feels unnatural because it looks like a continuous action. Remind learners that the gerund is acting as a noun (the concept of the activity), not a continuous verb.', 'Chain multiple actions together smoothly.
Talk about your likes, dislikes, plans, and avoidance strategies.
State your future intentions clearly.', 'Starter: I don''t want to do that. → Upgrade: I''d prefer not to do that.
Starter: Do you care if I sit here? → Upgrade: Do you mind if I sit here? / Would you mind moving over?', '[{"type":"multiple_choice","prompt":"Choose the correct form: We decided ___ home tonight.","options":["staying","to stay"],"answer":"to stay","feedback":"''Decide'' is a ''to-infinitive'' verb. It shows a future plan or intention."},{"type":"multiple_choice","prompt":"Choose the correct form: Have you finished ___ the printer?","options":["using","to use"],"answer":"using","feedback":"''Finish'' is a ''-ing'' verb. It describes completing an action that was in progress."},{"type":"multiple_choice","prompt":"Choose the correct form: I promise ___ you tomorrow.","options":["helping","to help"],"answer":"to help","feedback":"''Promise'' is a ''to-infinitive'' verb. It shows a future commitment."},{"type":"fill_blank","prompt":"Complete: Next year, I plan ____________________.","answer":"to [do something]","feedback":"''Plan'' takes the to-infinitive because it describes a future intention."},{"type":"mini_output","prompt":"Speaking: Ask a partner three questions using different ''boss'' verbs: What do they enjoy doing? What do they plan to do next week? What do they avoid doing on weekends?","answer":"Example: What do you enjoy doing in your free time? What do you plan to do next week? What do you avoid doing on weekends?","feedback":"Your questions should use the correct verb form: enjoy + -ing, plan + to-infinitive, avoid + -ing."}]'::jsonb, '[{"type":"prerequisite","chapter_code":"A1.G.09","note":"Like/love/hate"},{"type":"advanced","chapter_code":"B1.G.12","note":"Gerunds/infinitives meaning changes"}]'::jsonb, true, 9),
  ('A2.G.10', 'Articles II', 'A2', 'The Core Rule: New vs. Known Information
A / An: Use when mentioning a singular countable noun for the first time. (It''s new to the listener).
The: Use when mentioning it for the second time, OR if there is only one in the room/world. (It''s known to the listener).

The Zero Article (Ø) Rule:
Use no article for plural nouns or noncount nouns when speaking in general.', 'Articles are the spotlight of English grammar. "A/An" turns the spotlight on a random item in a crowded room. "The" narrows the spotlight onto one specific, agreed-upon item.', 'Storytelling flow: "I saw a man and a dog. The man was angry, but the dog was happy." (First mention = A. Second mention = The).
The "Only One" rule: "Can you close the door?" (There is only one door in this room. We both know which one it is).', 'A vs. The
Let''s watch a movie. (Any movie, we haven''t decided yet).
Let''s watch the movie. (The specific one we talked about earlier).', 'Error: Using "the" for general categories (The women live longer than the men / The nature is beautiful).
Fix: If you mean 100% of the group in the whole world, drop the article entirely. (Women live longer / Nature is beautiful).

L1 Transfer Note: Portuguese requires definite articles for broad concepts (A natureza, as mulheres, a sociedade, o amor). This is the single most frequent article error for Brazilian adults. Drill the "Zero Article for General Truths" rule aggressively.', 'Tell a cohesive story by tracking the flow of information.
Specify exactly which object you want someone to interact with.
Make general statements about the world.', 'Starter: I have a question about the grammar. → Upgrade: I have a question about this specific grammar point.
Starter: The life is hard. → Upgrade: Life can be tough sometimes.', '[{"type":"fill_blank","prompt":"Complete: I bought ___ new laptop yesterday. ___ laptop is very fast.","answer":"a / The","feedback":"Use ''a'' for the first mention (new information). Use ''the'' for the second mention (known information)."},{"type":"fill_blank","prompt":"Complete: ___ cats are usually more independent than ___ dogs.","answer":"Ø / Ø","feedback":"Use zero article for general statements about all cats and all dogs in the world."},{"type":"fill_blank","prompt":"Complete: Could you pass me ___ salt, please? (Hint: It''s on the table between us).","answer":"the","feedback":"Use ''the'' because there is only one salt shaker on the table. We both know which one you mean."},{"type":"correction","prompt":"Fix the error: The life is hard.","answer":"Life is hard. / Life can be tough.","feedback":"Don''t use ''the'' for abstract concepts or general truths. Use zero article instead."},{"type":"mini_output","prompt":"Writing: Write a three-sentence story about finding an object. Use ''a/an'' the first time you mention the object, and ''the'' the next two times.","answer":"Example: I found a wallet on the street. The wallet was full of money. I returned the wallet to the police.","feedback":"Your story should show the progression from ''a/an'' (new information) to ''the'' (known information)."}]'::jsonb, '[{"type":"prerequisite","chapter_code":"A0.G.04","note":null},{"type":"advanced","chapter_code":"B1.G.21","note":null},{"type":"advanced","chapter_code":"B2.G.20","note":null}]'::jsonb, true, 10),
  ('A2.G.11', 'Quantifiers (Expanded)', 'A2', 'Large Amounts
A lot of / Lots of: Used for both Count and Noncount nouns. (A lot of cars / A lot of water).
Much: Noncount nouns. (Mostly in questions/negatives: I don''t have much time).
Many: Plural Count nouns. (Mostly in questions/negatives: Are there many people?)

Small Amounts
A few: Plural Count nouns. (I have a few friends).
A little: Noncount nouns. (I have a little money).', 'A lot of is the universal, friendly affirmative quantifier.
A few / A little mean "some, but not a lot." They have a positive feeling (it''s enough to survive).', 'In modern spoken English, native speakers rarely use much or many in affirmative sentences. (Saying "I have much money" sounds strange). Always default to a lot of for affirmative sentences.', 'A few vs. Few (The article changes the feeling)
I have a few friends. (Positive: I have 3 or 4. I am happy).
I have few friends. (Negative: I only have 1 or 2. I am lonely).', 'Error: Mixing count/noncount quantifiers (I have much cars / There is many traffic).
Fix: Memorize the split: Many/Few = Countable. Much/Little = Uncountable.

L1 Transfer Note: In Portuguese, muito/muitos works for everything (muito trânsito, muitos carros). Furthermore, muita gente (a lot of people) is singular in Portuguese. Brazilians frequently say "much people" or "many persons." Drill that people is the irregular plural of person and takes many or a lot of.', 'Estimate crowd sizes, budgets, and remaining time.
Complain about having too much work or not enough resources.
Give general data without needing exact numbers.', 'Starter: I don''t have much time. → Upgrade: I''m a little short on time.
Starter: There are a lot of people here. → Upgrade: It''s pretty crowded in here.', '[{"type":"multiple_choice","prompt":"Choose the correct quantifier: How ___ luggage are you taking on the trip?","options":["much","many"],"answer":"much","feedback":"''Luggage'' is uncountable, so use ''much''. ''Many'' is only for countable nouns."},{"type":"multiple_choice","prompt":"Choose the correct quantifier: We have ___ problems to solve before Friday.","options":["a few","a little"],"answer":"a few","feedback":"''Problems'' is countable (plural), so use ''a few''. ''A little'' is for uncountable nouns."},{"type":"multiple_choice","prompt":"Choose the correct quantifier: I don''t drink ___ coffee.","options":["much","many"],"answer":"much","feedback":"''Coffee'' is uncountable, so use ''much''. This is a negative sentence, which is correct for ''much''."},{"type":"fill_blank","prompt":"Complete: In my hometown, there are a lot of ____________________.","answer":"[countable noun]","feedback":"''A lot of'' works with both countable and uncountable nouns, but here you should use a countable plural noun."},{"type":"mini_output","prompt":"Speaking: Look at a photo of a busy street or a messy desk. Tell your partner three things you see using ''a lot of'', ''a few'', and ''not much''.","answer":"Example: There are a lot of cars on the street. I see a few people walking. There isn''t much space to park.","feedback":"Your response should correctly match quantifiers to countable and uncountable nouns."}]'::jsonb, '[{"type":"prerequisite","chapter_code":"A1.G.05","note":null},{"type":"prerequisite","chapter_code":"A1.G.19","note":null},{"type":"advanced","chapter_code":"B1.G.19","note":"Determiners: all/most/both"}]'::jsonb, true, 11),
  ('A2.G.12', 'Count/Noncount II', 'A2', 'You cannot put a number directly in front of a noncount noun (e.g., two waters). You must use a Measure Word + of.

Liquids & Foods
a bottle / glass / cup of water
a piece / slice of cake
a loaf of bread
a can of soda

Abstract Concepts (The tricky ones)
a piece of advice
a piece of information
an item of news
a piece of furniture', 'Measure words act like containers. They take a continuous, unshaped substance (like water or advice) and package it into a box so you can put a number on it.', 'Use these when you need exact quantities. If you don''t need exact quantities, just use some (A1.G.05).
Spoken exception: In a cafe, it is acceptable to say "Two coffees, please," because everyone understands you mean "Two cups of coffee."', 'Wrong: Please give me an advice.
Right: Please give me a piece of advice. (Or just: Please give me some advice).', 'Error: Trying to pluralize the noncount noun instead of the measure word (Two bottles of waters / Three pieces of informations).
Fix: The noncount noun NEVER gets an ''s''. Only the container gets the ''s'' (Two bottles of water).

L1 Transfer Note: As noted in A1, Portuguese makes these words plural (informações, conselhos, móveis, pães). The concept of a "piece of advice" or a "loaf of bread" feels overly wordy. Emphasize that failing to use these measure words is one of the quickest ways to sound non-native.', 'Order food accurately in restaurants or at the grocery store.
Pack luggage and organize supplies.
Break abstract concepts down into manageable pieces.', 'Starter: I need a paper. → Upgrade: Could I get a blank sheet of paper?
Starter: She gave me a good advice. → Upgrade: She gave me a great piece of advice. / She gave me some solid advice.', '[{"type":"multiple_choice","prompt":"Match the measure word to the noncount noun: a slice of ___","options":["water","advice","pizza"],"answer":"pizza","feedback":"''A slice of'' is used for pizza (countable when sliced) and bread. ''Water'' and ''advice'' need different measure words."},{"type":"multiple_choice","prompt":"Match the measure word to the noncount noun: a bottle of ___","options":["water","advice","pizza"],"answer":"water","feedback":"''A bottle of'' is used for liquids like water. ''Advice'' and ''pizza'' need different measure words."},{"type":"multiple_choice","prompt":"Match the measure word to the noncount noun: a piece of ___","options":["water","advice","pizza"],"answer":"advice","feedback":"''A piece of'' is used for abstract concepts like advice, information, and furniture."},{"type":"correction","prompt":"Fix the error: She gave me a good advice.","answer":"She gave me a piece of advice. / She gave me some good advice.","feedback":"''Advice'' is uncountable. Use ''a piece of advice'' or just ''some advice''."},{"type":"mini_output","prompt":"Writing: Write a short shopping list text to your spouse or roommate. Include at least three noncount items using specific measure words.","answer":"Example: Don''t forget to grab two loaves of bread, a bottle of milk, and a box of cereal.","feedback":"Your list should use appropriate measure words (loaves, bottles, boxes, etc.) for noncount nouns."}]'::jsonb, '[{"type":"prerequisite","chapter_code":"A1.G.05","note":null},{"type":"advanced","chapter_code":"B1.G.21","note":null}]'::jsonb, true, 12),
  ('A2.G.13', 'Comparatives & Modifiers', 'A2', 'Modifiers with Comparatives (Reviewing A1.G.15)
Big difference: much / far / a lot + comparative (e.g., much bigger, far more expensive)
Small difference: a bit / a little + comparative (e.g., a bit colder, a little faster)

Equality / Inequality: (not) as... as
Equal (=): Subject + be + as + adjective + as + Object
My car is as fast as yours.

Unequal (≠): Subject + be + not as + adjective + as + Object
The sequel was not as good as the first movie.', 'Modifiers act like a volume knob for your comparatives, turning the intensity up or down. The as...as structure allows you to compare things without using the -er or more forms at all.', 'Using not as...as is a very diplomatic way to say something is worse. Saying "The hotel was not as clean as the pictures" is much softer and more professional than saying "The hotel was dirtier than the pictures."', 'Direct Comparative: A BMW is more expensive than a Ford.
Not as...as: A Ford is not as expensive as a BMW. (These mean exactly the same thing, just from different angles).', 'Error: Mixing modifiers with the base adjective (It is much expensive / It is far good).
Fix: Modifiers like much and far MUST sit next to a comparative form (much more expensive / far better).

Error: Saying "so...as" instead of "as...as" (She is not so tall as him).
Fix: While you might read "so...as" in very old books, in modern English, always use as...as for both affirmative and negative sentences.

L1 Transfer Note: In Portuguese, the structure tão... quanto maps perfectly to as... as. The main issue Brazilians have is translating muito mais directly as very more instead of much more. Drill the chunk: much more / much better.', 'Explain exactly how much better or worse an option is.
Show that two things are equal (or unequal).
Soften a comparison so you don''t sound too aggressive.', 'Starter: The test was harder than I thought. → Upgrade: The test was much harder than I expected.
Starter: This is worse than the old one. → Upgrade: This is nowhere near as good as the old one.', '[{"type":"transformation","prompt":"Rewrite using ''not as...as'': Trains are faster than buses.","answer":"Buses are not as fast as trains.","feedback":"Use ''not as + adjective + as'' to express inequality. It means the same thing as the comparative but from a different angle."},{"type":"transformation","prompt":"Rewrite using ''not as...as'': Silver is cheaper than gold.","answer":"Silver is not as expensive as gold.","feedback":"Use ''not as + adjective + as'' to express the opposite comparison."},{"type":"fill_blank","prompt":"Complete: Your current job vs. Your first job: My current job is ____________________.","answer":"[comparison with modifier]","feedback":"Use a comparative with a modifier like ''much'', ''a bit'', or ''not as...as'' to show the degree of difference."},{"type":"correction","prompt":"Fix the error: It is much expensive.","answer":"It is much more expensive.","feedback":"Modifiers like ''much'' must go with the comparative form (more expensive), not the base adjective."},{"type":"mini_output","prompt":"Speaking: Look at two different smartphones. Give a partner a recommendation comparing their price, battery life, and camera quality using at least one ''not as...as'' structure.","answer":"Example: The iPhone is much more expensive than the Android phone. However, the Android phone is not as fast as the iPhone. The camera quality is about the same.","feedback":"Your response should include comparatives with modifiers and at least one ''not as...as'' structure."}]'::jsonb, '[{"type":"prerequisite","chapter_code":"A1.G.15","note":null},{"type":"prerequisite","chapter_code":"A1.G.16","note":null},{"type":"advanced","chapter_code":"B1.G.18","note":"Comparatives for persuasion"}]'::jsonb, true, 13),
  ('A2.G.14', 'Relative Clauses (Subject/Object)', 'A2', 'Subject Relative Clauses (The pronoun does the action)
The pronoun (who/that) cannot be dropped.
The man [who called me] was angry. (The man called).
I want a phone [that takes good photos]. (The phone takes photos).

Object Relative Clauses (The pronoun receives the action)
The pronoun (who/that) CAN be dropped (and usually is!).
The man [(who) I called] was angry. (I called the man).
The phone [(that) I bought] is great. (I bought the phone).', 'Relative clauses define a noun. When the noun is the object of the clause (e.g., "the book I read"), the relative pronoun becomes "invisible grammar" in spoken English.', 'At the A2 level, dropping the object relative pronoun is mainly receptive. You need to recognize it when listening to native speakers, who drop that and who almost constantly.', 'Written/Formal: The report that you sent is excellent.
Spoken/Natural: The report you sent is excellent.', 'Error: Putting the object pronoun back in at the end of the clause (The book that I read it was good).
Fix: That already replaces it. You can''t have both.

L1 Transfer Note: In Portuguese, the word que (that/who) is absolutely mandatory to connect these ideas (O livro que eu li). Dropping it feels incredibly uncomfortable for Brazilians. Challenge them to practice reading sentences aloud while completely skipping the word that. It will feel weird, but it sounds highly fluent.', 'Speak more fluently by linking short sentences together.
Clearly identify which person or thing you are talking about.
Sound more like a native speaker by dropping unnecessary words.', 'Starter: This is the laptop that I use. → Upgrade: This is the laptop I use.
Starter: The person who I met was nice. → Upgrade: The person I spoke with was really helpful.', '[{"type":"multiple_choice","prompt":"Can you drop the pronoun (who/that) in this sentence? ''I like the girl who sits next to me.''","options":["Yes","No"],"answer":"No","feedback":"The pronoun ''who'' is the subject of the clause (the girl sits). Subject pronouns cannot be dropped."},{"type":"multiple_choice","prompt":"Can you drop the pronoun (who/that) in this sentence? ''Where is the money that I left on the table?''","options":["Yes","No"],"answer":"Yes","feedback":"The pronoun ''that'' is the object of the clause (I left the money). Object pronouns can be dropped: ''Where is the money I left on the table?''"},{"type":"multiple_choice","prompt":"Can you drop the pronoun (who/that) in this sentence? ''The car that crashed into the tree is ruined.''","options":["Yes","No"],"answer":"No","feedback":"The pronoun ''that'' is the subject of the clause (the car crashed). Subject pronouns cannot be dropped."},{"type":"transformation","prompt":"Combine by dropping the relative pronoun: You recommended a movie. I watched it.","answer":"I watched the movie you recommended.","feedback":"Drop ''that'' because it''s the object of the clause. The result sounds more natural and fluent."},{"type":"mini_output","prompt":"Writing: Write a sentence about the best gift you ever received, and a sentence about the best person you work with. Try dropping the relative pronoun in both.","answer":"Example: The gift my parents gave me was a laptop. The person I work with most is Sarah.","feedback":"Your sentences should drop the object relative pronouns to sound more natural and fluent."}]'::jsonb, '[{"type":"prerequisite","chapter_code":"A1.G.24","note":null},{"type":"advanced","chapter_code":"B1.G.13","note":"Defining vs. non-defining"}]'::jsonb, true, 14),
  ('A2.G.15', 'Basic Passive (Present/Past)', 'A2', 'Subject + be (am/is/are/was/were) + Past Participle (V3)

Present Passive (Routines / Facts)
Active: They speak Portuguese in Brazil.
Passive: Portuguese is spoken in Brazil.
Active: They make these phones in China.
Passive: These phones are made in China.

Past Passive (History / Finished Events)
Active: Someone stole my wallet.
Passive: My wallet was stolen.
Active: Leonardo da Vinci painted the Mona Lisa.
Passive: The Mona Lisa was painted by Leonardo da Vinci.', 'The passive voice changes the camera angle. Instead of looking at the person doing the action, the camera points directly at the thing receiving the action.', 'Use the passive when the "doer" is unknown, unimportant, or obvious. (e.g., The thief was arrested. It''s obvious the police arrested him, so we don''t need to say "by the police").', 'Active: Someone built this house in 1950. (Focus is on the mysterious builder).
Passive: This house was built in 1950. (Focus is on the house itself).', 'Error: Forgetting the verb be entirely (The book written by Tolkien / The car made in Germany).
Fix: A passive sentence without be is like a car without an engine. It goes nowhere. You MUST have is/are or was/were before the V3.

L1 Transfer Note: Brazilians understand the passive well because it exists in Portuguese (foi construído, é feito), but they often default to the active voice using the third-person plural (Construíram esta casa / Fizeram este carro). Encourage them to use the English passive for these "anonymous they" situations, as it sounds much more natural.', 'Describe where products come from and how they are made.
Talk about historical events and monuments.
Report news or facts without knowing exactly who did the action.', 'Starter: People started the company in 2010. → Upgrade: The company was founded in 2010.
Starter: Where do they make this? → Upgrade: Where is this manufactured?', '[{"type":"multiple_choice","prompt":"Choose Present Passive or Past Passive: The Harry Potter books ___ by J.K. Rowling.","options":["are written","were written"],"answer":"were written","feedback":"Use past passive because the books were written in the past. The action is complete."},{"type":"multiple_choice","prompt":"Choose Present Passive or Past Passive: Millions of emails ___ every single day.","options":["are sent","were sent"],"answer":"are sent","feedback":"Use present passive because this is a current, ongoing fact about how emails are sent daily."},{"type":"multiple_choice","prompt":"Choose Present Passive or Past Passive: My car ___ last week.","options":["is repaired","was repaired"],"answer":"was repaired","feedback":"Use past passive because the repair happened last week (a specific past time)."},{"type":"transformation","prompt":"Change to passive: Someone cleans the office every night.","answer":"The office is cleaned every night.","feedback":"Use present passive (is + past participle) for routine actions. The ''someone'' becomes unnecessary."},{"type":"mini_output","prompt":"Speaking: Think of a famous building, food, or product from your city. Tell a partner two passive facts about it (e.g., where it is made, when it was created).","answer":"Example: Guaraná is made in Brazil. The Christ the Redeemer statue was built in 1931.","feedback":"Your response should include both present and past passive sentences about a local product or landmark."}]'::jsonb, '[{"type":"prerequisite","chapter_code":"A1.G.10","note":"Past of be"},{"type":"prerequisite","chapter_code":"A2.G.01","note":"Irregular V3 forms"},{"type":"advanced","chapter_code":"B1.G.07","note":"Passive expanded"}]'::jsonb, true, 15),
  ('A2.G.16', 'Reported Speech (Intro: Say/Tell)', 'A2', 'The Core Verbs: Say vs. Tell

Say: Subject + said + (that) + Sentence.
He said (that) he was tired.

Tell: Subject + told + PERSON + (that) + Sentence.
He told me (that) he was tired.

Basic Tense Shifting (Backshifting)
When you report what someone said in the past, their original words usually take one step back in time.

Present Simple → Past Simple: "I want coffee." → She said she wanted coffee.
Present Continuous → Past Continuous: "I am working." → He said he was working.
Will → Would: "I will call you." → They said they would call me.', 'You are acting as a messenger. Because time has passed since the person originally spoke, you shift the verbs backwards into the past to show that the quote belongs to history, not right now.', 'In spoken English, you can completely ignore the word that. (She said she was busy).', 'Direct Quote: John said, "I am hungry." (You are reading a script).
Reported: John said he was hungry. (You are summarizing the message).', 'Error: Forgetting the person after tell, or adding a person immediately after say (He told that... / He said me that...).
Fix: Tell needs a target (told me, told him, told Sarah). Say shoots the message into the air (said that).

L1 Transfer Note: As mentioned previously, Portuguese allows Ele me disse (He said me) and Ele contou que (He told that). You must break this habit early. Drill the patterns: Said that / Told me that.

Error: Not shifting the tense (She said she is tired).
Fix: While native speakers sometimes don''t shift the tense if the fact is still true right now, it is safer and grammatically stronger for A2 learners to always shift the verb to the past.', 'Pass on a message from a boss or a client.
Gossip about what someone said.
Remind someone of a promise they made.', 'Starter: He said to me that he will come. → Upgrade: He told me he would come.
Starter: The boss said we need to finish. → Upgrade: The boss mentioned we needed to finish.', '[{"type":"multiple_choice","prompt":"Choose said or told: My manager ___ me to take the day off.","options":["said","told"],"answer":"told","feedback":"''Tell'' requires a person after it (told me). ''Say'' doesn''t take a direct object."},{"type":"multiple_choice","prompt":"Choose said or told: The client ___ the price was too high.","options":["said","told"],"answer":"said","feedback":"''Say'' is used when the message is directed to no one in particular. ''Tell'' would need a person (told us)."},{"type":"multiple_choice","prompt":"Choose said or told: I ___ them that I would be late.","options":["said","told"],"answer":"told","feedback":"''Tell'' is used with a person (told them). ''Say'' would need ''that'' (said that)."},{"type":"transformation","prompt":"Change to reported speech: ''I am living in London.'' → She said she ____________________.","answer":"was living in London / lived in London","feedback":"Shift the present continuous to past continuous (was living) to show the quote belongs to the past."},{"type":"mini_output","prompt":"Writing: Think of a meeting or conversation you had recently. Write two sentences reporting what the other person told you using ''said'' and ''told me''.","answer":"Example: My boss told me the project deadline was moved. She said we would have more time to finish.","feedback":"Your sentences should correctly use ''told me'' (with a person) and ''said'' (without a person), and shift the tenses appropriately."}]'::jsonb, '[{"type":"prerequisite","chapter_code":"A1.G.10","note":null},{"type":"prerequisite","chapter_code":"A1.G.11","note":null},{"type":"advanced","chapter_code":"B1.G.06","note":"Reported questions"}]'::jsonb, true, 16),
  ('A2.G.17', 'Requests and Politeness Structures', 'A2', 'Making Requests (Asking someone to do something)

Could you + Base Verb + please?
Could you send me the file, please?

Would you mind + Verb-ing? (Advanced/Very polite)
Would you mind sending me the file?

Making Offers (Asking if someone wants something)

Would you like + Noun?
Would you like a coffee?

Would you like me to + Base Verb?
Would you like me to call a taxi?', 'These structures use modal verbs in the past tense (could, would) NOT to talk about the past, but to create "polite distance." They soften your words so you do not sound like a dictator giving orders.', 'Use Could you...? with coworkers, strangers, and in professional emails.
Never use I want in a restaurant or cafe. Always use I would like (I''d like).', 'Aggressive: Send me the report. / I want a coffee.
Polite: Could you send me the report? / I''d like a coffee, please.', 'Error: Direct translation of requests (Can you to help me? / Do you want a coffee?).
Fix: Drop the to after could. Use Would you like instead of Do you want.

L1 Transfer Note: In Portuguese, Você quer um café? is perfectly polite. In English, "Do you want a coffee?" sounds very direct, almost like you are challenging them. Train learners to automatically use Would you like in hospitality or office settings. Similarly, Brazilians often use the imperative to ask favors (Me manda o arquivo). English requires the modal wrapper (Could you send...).', 'Ask for favors without sounding rude or demanding.
Offer food, drinks, or help to guests and clients.
Function smoothly in a professional English environment.', 'Starter: I want the chicken, please. → Upgrade: I''ll have the chicken, please. / I''d like the chicken.
Starter: Do you want help? → Upgrade: Can I give you a hand with that?', '[{"type":"correction","prompt":"Fix the error: Could you to open the window, please?","answer":"Could you open the window, please?","feedback":"Don''t use ''to'' after ''could''. Use: Could you + base verb."},{"type":"correction","prompt":"Fix the error: Do you want that I call the manager?","answer":"Would you like me to call the manager?","feedback":"Use ''Would you like me to'' instead of ''Do you want that I''. It''s more polite and grammatically correct."},{"type":"correction","prompt":"Fix the error: Would you mind to wait for a moment?","answer":"Would you mind waiting for a moment?","feedback":"Use ''Would you mind + -ing'' (waiting), not ''Would you mind to + base verb''."},{"type":"transformation","prompt":"Turn into a polite request: Give me some water.","answer":"Could you give me some water, please? / Would you mind giving me some water?","feedback":"Use ''Could you'' or ''Would you mind'' to make the request polite and less demanding."},{"type":"mini_output","prompt":"Speaking: Role-play a situation where you are hosting a client at your office. Offer them a drink, offer to take their coat, and politely request that they sign the visitor log.","answer":"Example: Would you like a coffee? Let me take your coat. Could you sign the visitor log, please?","feedback":"Your role-play should include polite offers (Would you like...?) and polite requests (Could you...?)."}]'::jsonb, '[{"type":"prerequisite","chapter_code":"A1.G.07","note":null},{"type":"advanced","chapter_code":"B1.G.32","note":"Grammar for email basics"}]'::jsonb, true, 17),
  ('A2.G.18', 'Adverbs & Intensifiers', 'A2', 'Intensifiers (Before Adjectives)

Quite / Pretty: 70% intensity. (The movie was quite good. I liked it.)
Very: 90% intensity. (The movie was very good. Highly recommended.)
Really: 100% intensity. (The movie was really fantastic!)

Good vs. Well (The Ultimate Rule)

Good is an adjective. It describes Nouns (Things/People).
He is a good player. / This is a good pizza.

Well is an adverb. It describes Verbs (Actions).
He plays well. / The team performed well.', 'Intensifiers control the volume of your adjectives. "Well" and "Good" are tools to make sure you are describing the correct part of the sentence (the object vs. the action).', 'Pretty is extremely common in spoken American English to mean "quite" (It''s pretty expensive = It''s quite expensive). It has nothing to do with beauty in this context.
Exception: When talking about your health, use well as an adjective. ("I don''t feel well").', 'Wrong: He speaks English very good. (Describing the action ''speaks'' with an adjective).
Right: He speaks English very well. (Describing the action with an adverb).', 'Error: Using very with strong adjectives (The movie was very fantastic / very terrible).
Fix: Very is for normal adjectives (very good, very bad). If the adjective is already at 100% (fantastic, terrible, huge), use really or absolutely.

L1 Transfer Note: In Portuguese, bem and bom are sometimes swapped in casual speech, and muito covers all intensifiers. The "He speaks very good" error is universal among Brazilian learners. Drill the connection: Action = Well.', 'Add emotion, emphasis, and detail to your opinions.
Evaluate someone''s performance or a product''s quality accurately.
Modulate your tone (from "it''s okay" to "it''s amazing").', 'Starter: It is very good. → Upgrade: It''s pretty decent. / It''s really outstanding.
Starter: I did a good job. → Upgrade: I think the presentation went really well.', '[{"type":"multiple_choice","prompt":"Choose good or well: Did you sleep ___ last night?","options":["good","well"],"answer":"well","feedback":"''Sleep'' is a verb (action), so use the adverb ''well''. ''Good'' is an adjective for nouns."},{"type":"multiple_choice","prompt":"Choose good or well: That is a very ___ idea.","options":["good","well"],"answer":"good","feedback":"''Idea'' is a noun, so use the adjective ''good''. ''Well'' is an adverb for verbs."},{"type":"multiple_choice","prompt":"Choose good or well: She manages the marketing team extremely ___.","options":["good","well"],"answer":"well","feedback":"''Manages'' is a verb (action), so use the adverb ''well''."},{"type":"fill_blank","prompt":"Complete (70% intensity): The new restaurant is ___ expensive, but not too bad.","answer":"quite / pretty","feedback":"Use ''quite'' or ''pretty'' for 70% intensity. These modifiers soften the adjective."},{"type":"mini_output","prompt":"Writing: Write two sentences reviewing a product you bought recently. Describe the product itself using good/very, and describe how it performs/works using well.","answer":"Example: This is a very good coffee maker. It works really well and makes excellent espresso.","feedback":"Your review should correctly use ''good'' for the noun (coffee maker) and ''well'' for the verb (works)."}]'::jsonb, '[{"type":"prerequisite","chapter_code":"A1.G.01","note":null},{"type":"advanced","chapter_code":"B1.G.24","note":"Adjective order"}]'::jsonb, true, 18),
  ('A2.G.19', 'Prepositions after Verbs/Adjectives', 'A2', 'Some verbs and adjectives must always be followed by a specific preposition.

Adjective + Preposition
good / bad at (math, sports, cooking)
interested in (history, art)
afraid of (spiders, heights)

Verb + Preposition
listen to (music, a podcast)
depend on (the weather, the price)
wait for (a friend, the bus)
ask for (help, the bill)', 'These prepositions don''t use their normal "location" meanings (like in the box). They act as invisible glue that attaches the adjective or verb to the noun that follows it.', 'If a verb comes directly after these prepositions, you MUST add -ing to it (e.g., I am good at playing chess).', 'Wrong: I listen music. (Missing the glue).
Right: I listen to music.', 'Error: Directly translating the preposition from the native language (I am good in math / It depends of the price).
Fix: Treat the verb/adjective and its preposition as a single vocabulary word. Never learn "depend"; only learn "depend on."

L1 Transfer Note: Brazilian learners universally struggle here because Portuguese uses different prepositions (bom em = good in, depende de = depends of). Drill these starter sets heavily, especially listen to and good at, as they are used constantly in casual conversation.', 'Talk about your hobbies and skills accurately.
Express interest or disinterest in various topics.
Sound more natural when pairing action words with objects.', 'Starter: I like history. → Upgrade: I''m really interested in history.
Starter: I am bad at cooking. → Upgrade: I''m terrible at cooking.', '[{"type":"multiple_choice","prompt":"Choose the correct preposition: Are you listening (at / to / for) me?","options":["at","to","for"],"answer":"to","feedback":"Use ''listen to'' for the person or thing you''re paying attention to."},{"type":"multiple_choice","prompt":"Choose the correct preposition: She is very good (in / at / on) solving problems.","options":["in","at","on"],"answer":"at","feedback":"Use ''good at'' to describe skills or abilities."},{"type":"multiple_choice","prompt":"Choose the correct preposition: We are waiting (for / to / on) the meeting to start.","options":["for","to","on"],"answer":"for","feedback":"Use ''wait for'' when expecting someone or something to arrive."},{"type":"fill_blank","prompt":"Complete: I am really interested in ____________________.","answer":"[noun or gerund]","feedback":"Use ''interested in'' to express what topics or activities capture your attention."},{"type":"mini_output","prompt":"Speaking: Ask a partner three questions using the starter sets (e.g., ''What are you good at?'' / ''What kind of music do you listen to?'').","answer":"Example: What are you good at? What kind of music do you listen to? What are you interested in?","feedback":"Your questions should use the correct preposition combinations (good at, listen to, interested in)."}]'::jsonb, '[{"type":"prerequisite","chapter_code":"A1.G.18","note":null},{"type":"advanced","chapter_code":"B1.G.22","note":"Preposition patterns expanded"}]'::jsonb, true, 19),
  ('A2.G.20', 'Question Forms Expansion (Indirect Questions)', 'A2', 'Introductory Phrase + Question Word + Subject + Verb

Direct: Where is the station?
Indirect: Can you tell me where the station is?

Direct: What time does the club start?
Indirect: Do you know what time the club starts?', 'By adding "Can you tell me..." or "Do you know...", you change the focus. You are politely asking if the person has the information, rather than directly demanding the information itself.', 'Use this whenever you approach someone you don''t know well, like a receptionist, a stranger on the street, or a new client.', 'Direct (Aggressive to strangers): Where is the bathroom?
Indirect (Polite): Excuse me, do you know where the bathroom is?', 'Error: Keeping the question word order in the second half of the sentence (Can you tell me where is the bank?).
Fix: The first part (Can you tell me) does the heavy lifting for the question. The second part must return to normal statement order (Subject -> Verb).

L1 Transfer Note: In Portuguese, the word order does not change at all (Onde é o banco? / Você sabe onde é o banco?). This syntactic flip requires a lot of controlled practice before it feels natural to a Brazilian learner.', 'Politely ask for directions or information from strangers.
Soften questions in a professional or service environment.
Avoid sounding like an interrogator.', 'Starter: What time is it? → Upgrade: Do you happen to know what time it is?
Starter: How much is this? → Upgrade: Could you tell me how much this costs?', '[{"type":"correction","prompt":"Fix the error: Can you tell me where is the bank?","answer":"Can you tell me where the bank is?","feedback":"The second part of the sentence must use statement word order (Subject + Verb), not question word order."},{"type":"transformation","prompt":"Change the direct question into an indirect one: Where does he live? → Do you know where ____________________?","answer":"he lives","feedback":"Use statement word order (he lives) in the second part of the indirect question."},{"type":"transformation","prompt":"Change the direct question into an indirect one: What time is the meeting? → Can you tell me what time ____________________?","answer":"the meeting is","feedback":"Use statement word order (the meeting is) in the second part of the indirect question."},{"type":"fill_blank","prompt":"Complete: You are lost in a new city. Form a polite question: Excuse me, do you know ____________________?","answer":"where [location] is / how to get to [location]","feedback":"Use indirect question form with statement word order to sound polite and natural."},{"type":"mini_output","prompt":"Writing: Write a short message to a hotel receptionist asking politely what time breakfast starts.","answer":"Example: Good morning, could you tell me what time breakfast starts? / Do you know what time breakfast is served?","feedback":"Your message should use indirect question form with statement word order (breakfast starts / breakfast is served)."}]'::jsonb, '[{"type":"prerequisite","chapter_code":"A1.G.02","note":null},{"type":"prerequisite","chapter_code":"A1.G.19","note":null},{"type":"advanced","chapter_code":"B1.G.16","note":"Indirect questions core"}]'::jsonb, true, 20),
  ('A2.G.21', 'Prepositions of Movement II', 'A2', 'Prepositions of Movement (Expanding A1.G.04)

Into: Movement toward the inside
The cat jumped into the box.

Out of: Movement away from the inside
The cat jumped out of the box.

Through: Movement from one side to the other
We walked through the forest.

Across: Movement from one side to the other (on a surface)
She ran across the street.

Along: Movement following a line or path
We walked along the beach.

Toward/Towards: Movement in the direction of
The car drove toward the city.', 'These prepositions show the direction and path of movement, not just location. They answer "which way?" rather than "where?"', 'Use these when giving directions or describing journeys. They are essential for storytelling and navigation.', 'In vs. Into
I am in the room. (Location - I am already here).
I walked into the room. (Movement - I entered).', 'Error: Confusing in and into (I walked in the room).
Fix: Use into for movement toward the inside. Use in for location.

L1 Transfer Note: Portuguese uses em for both location and movement (Entrei em casa / Estou em casa). English requires the distinction between in (location) and into (movement).', 'Give clear directions to travelers or new employees.
Describe journeys and adventures.
Explain routes and paths.', 'Starter: Go in the building. → Upgrade: Go into the building.
Starter: Walk on the beach. → Upgrade: Walk along the beach.', '[{"type":"multiple_choice","prompt":"Choose the correct preposition: The ball rolled ___ the box.","options":["in","into"],"answer":"into","feedback":"Use ''into'' for movement toward the inside. ''In'' is for location."},{"type":"multiple_choice","prompt":"Choose the correct preposition: We walked ___ the park.","options":["through","across"],"answer":"through","feedback":"Use ''through'' for movement from one side to the other (inside a space). ''Across'' is for movement on a surface."},{"type":"fill_blank","prompt":"Complete: She ran ___ the street to catch the bus.","answer":"across","feedback":"Use ''across'' for movement from one side to the other on a surface like a street."},{"type":"transformation","prompt":"Rewrite using a preposition of movement: I entered the building.","answer":"I walked into the building.","feedback":"Use ''into'' to show movement toward the inside."},{"type":"mini_output","prompt":"Speaking: Give a partner directions from your home to a nearby location using at least three prepositions of movement.","answer":"Example: Go out of your house, walk along the street, and go through the park.","feedback":"Your directions should include prepositions like into, out of, through, across, along, and toward."}]'::jsonb, '[{"type":"prerequisite","chapter_code":"A1.G.04","note":null},{"type":"advanced","chapter_code":"B1.G.26","note":"Prepositions of time/place"}]'::jsonb, true, 21),
  ('A2.G.22', 'Phrasal Verbs - Introduction', 'A2', 'What is a Phrasal Verb?

A phrasal verb is a verb + preposition/adverb combination that creates a new meaning.

Common Phrasal Verbs:
Turn on: Activate (Turn on the light)
Turn off: Deactivate (Turn off the TV)
Pick up: Collect or answer (Pick up the phone)
Put on: Wear or activate (Put on your shoes)
Take off: Remove or depart (Take off your coat / The plane takes off)
Look for: Search (Look for your keys)
Look after: Care for (Look after the children)
Get up: Wake and rise (Get up at 7 AM)
Go out: Leave home for entertainment (Go out with friends)
Come back: Return (Come back home)
Sit down: Be seated (Sit down, please)
Stand up: Rise to standing position (Stand up for the national anthem)', 'Phrasal verbs are extremely common in English. They often have a simpler single-word synonym, but native speakers prefer the phrasal verb in casual speech.', 'Phrasal verbs are essential for sounding natural. They appear constantly in conversation, movies, and everyday English.', 'Single verb: Activate the light.
Phrasal verb: Turn on the light. (More natural and common).', 'Error: Translating phrasal verbs word-by-word (Turn on = Girar em = Rotate on).
Fix: Phrasal verbs have fixed meanings that cannot be predicted from the individual words. Memorize them as single vocabulary items.

L1 Transfer Note: Portuguese does not have phrasal verbs. Brazilians often try to translate them literally, which creates confusion. Drill these as fixed chunks: turn on, turn off, pick up, put on, take off.', 'Understand native speakers in casual conversation.
Give simple, natural instructions.
Sound more fluent and natural.', 'Starter: Activate the light. → Upgrade: Turn on the light.
Starter: Remove your shoes. → Upgrade: Take off your shoes.', '[{"type":"multiple_choice","prompt":"Choose the correct phrasal verb: Can you ___ the TV? I want to watch the news.","options":["turn on","turn off"],"answer":"turn on","feedback":"Use ''turn on'' to activate or start something. ''Turn off'' means to deactivate."},{"type":"multiple_choice","prompt":"Choose the correct phrasal verb: I need to ___ the phone. My boss is calling.","options":["pick up","put on"],"answer":"pick up","feedback":"Use ''pick up'' to answer a phone call. ''Put on'' means to wear or activate."},{"type":"fill_blank","prompt":"Complete: Please ___ your shoes before entering the house.","answer":"take off","feedback":"Use ''take off'' to remove clothing or items."},{"type":"transformation","prompt":"Rewrite using a phrasal verb: I woke up at 6 AM.","answer":"I got up at 6 AM.","feedback":"Use ''get up'' as a more natural way to say you woke and rose from bed."},{"type":"mini_output","prompt":"Speaking: Give a partner three instructions using phrasal verbs (e.g., turn on, pick up, sit down).","answer":"Example: Turn on the computer. Pick up your bag. Sit down and relax.","feedback":"Your instructions should use common phrasal verbs naturally."}]'::jsonb, '[{"type":"prerequisite","chapter_code":"A1.G.06","note":null},{"type":"advanced","chapter_code":"B1.G.27","note":"Phrasal verbs II"}]'::jsonb, true, 22),
  ('A2.G.23', 'Make vs Do', 'A2', 'Make: Create or produce something

Make a cake: Bake or prepare a cake
Make a decision: Choose
Make a mistake: Commit an error
Make a plan: Create a strategy
Make progress: Advance
Make a noise: Create sound
Make a difference: Have an impact

Do: Perform an action or task

Do homework: Complete schoolwork
Do the dishes: Wash plates
Do exercise: Work out
Do a job: Perform work
Do your best: Try hard
Do a favor: Help someone
Do business: Conduct commerce', 'Make focuses on creating or producing something new. Do focuses on performing or completing an action or task.', 'These are high-frequency verbs that appear in many common expressions. Memorizing the most common collocations is essential.', 'Make: I made a cake. (I created it).
Do: I did the dishes. (I performed the task).', 'Error: Confusing make and do (I did a cake / I made the dishes).
Fix: Make = create/produce. Do = perform/complete.

L1 Transfer Note: Portuguese uses fazer for both meanings (Fiz um bolo / Fiz os pratos). English requires the distinction. Drill the most common collocations: make a decision, make a mistake, do homework, do the dishes.', 'Discuss daily tasks and responsibilities.
Talk about creating or producing things.
Use common expressions naturally.', 'Starter: I created a plan. → Upgrade: I made a plan.
Starter: I performed my homework. → Upgrade: I did my homework.', '[{"type":"multiple_choice","prompt":"Choose make or do: I ___ a mistake in the exam.","options":["made","did"],"answer":"made","feedback":"Use ''made'' because a mistake is something you create or produce."},{"type":"multiple_choice","prompt":"Choose make or do: Can you ___ me a favor?","options":["make","do"],"answer":"do","feedback":"Use ''do'' because a favor is an action or task you perform."},{"type":"multiple_choice","prompt":"Choose make or do: She ___ a lot of progress this year.","options":["made","did"],"answer":"made","feedback":"Use ''made'' because progress is something you create or produce."},{"type":"fill_blank","prompt":"Complete: I need to ___ my homework before dinner.","answer":"do","feedback":"Use ''do'' for tasks and actions you perform."},{"type":"mini_output","prompt":"Speaking: Tell a partner three things you made or did today using the correct verb.","answer":"Example: I made a decision about my career. I did my homework. I made a cake for dessert.","feedback":"Your response should correctly use ''made'' for creating things and ''did'' for performing tasks."}]'::jsonb, '[{"type":"prerequisite","chapter_code":"A1.G.18","note":null},{"type":"advanced","chapter_code":"B1.G.28","note":"Collocations with make/do/have/take"}]'::jsonb, true, 23),
  ('A2.G.24', 'Say vs Tell (Expanded)', 'A2', 'Say: Communicate words (no direct object required)

Say something: I said hello.
Say that: She said that she was tired.
Say to someone: He said to me that he would come. (Less common)

Tell: Communicate to a specific person (requires direct object)

Tell someone: I told him the truth.
Tell someone that: She told me that she was busy.
Tell someone to do something: I told him to sit down.

Key Difference:
Say: The message goes into the air (no specific recipient required).
Tell: The message goes to a specific person (recipient is required).', 'Say focuses on the words spoken. Tell focuses on the recipient of the message. Tell requires you to specify who receives the message.', 'These verbs are essential for reporting what people said. Using them correctly makes you sound more native-like.', 'Say: "I am tired," she said. (Focus on the words).
Tell: She told me she was tired. (Focus on who received the message).', 'Error: Adding a person after say (He said me that...).
Fix: Say does not take a direct object. Use tell for that.

Error: Forgetting the person after tell (He told that...).
Fix: Tell requires a recipient.

L1 Transfer Note: Portuguese uses contar and dizer interchangeably in many contexts. English requires the distinction.', 'Report what people said accurately.
Pass on messages from others.
Give instructions or commands.', 'Starter: He said to me that he will come. → Upgrade: He told me he would come.
Starter: I said the answer. → Upgrade: I told him the answer.', '[{"type":"multiple_choice","prompt":"Choose say or tell: My boss ___ me to finish the report by Friday.","options":["said","told"],"answer":"told","feedback":"Use ''told'' because you need to specify who received the instruction (me)."},{"type":"multiple_choice","prompt":"Choose say or tell: The teacher ___ that the exam is next week.","options":["said","told"],"answer":"said","feedback":"Use ''said'' because the message is directed to the class in general, not to a specific person."},{"type":"fill_blank","prompt":"Complete: I ___ him that I would be late.","answer":"told","feedback":"Use ''told'' because you need to specify the recipient (him)."},{"type":"transformation","prompt":"Change to reported speech: ''I am leaving now.'' → She ___ she was leaving.","answer":"said","feedback":"Use ''said'' to report what someone said without specifying a recipient."},{"type":"mini_output","prompt":"Speaking: Tell a partner something someone said to you recently using both ''said'' and ''told me''.","answer":"Example: My friend said she was tired. She told me she needed a vacation.","feedback":"Your response should correctly use ''said'' for general statements and ''told me'' when specifying the recipient."}]'::jsonb, '[{"type":"prerequisite","chapter_code":"A1.G.20","note":null},{"type":"advanced","chapter_code":"B1.G.29","note":"Verb patterns"}]'::jsonb, true, 24),
  ('A2.G.25', 'So/Such/Too/Enough', 'A2', 'So + Adjective: Very (intensifier)

So big: Very big
So tired: Very tired
So happy: Very happy

Such + Noun: Very (intensifier for nouns)

Such a big house: A very big house
Such a good idea: A very good idea
Such beautiful weather: Very beautiful weather

Too + Adjective: More than needed (negative)

Too big: Bigger than needed
Too expensive: More expensive than I can afford
Too late: Later than acceptable

Enough + Noun: Sufficient quantity

Enough time: Sufficient time
Enough money: Sufficient money
Enough people: Sufficient people

Adjective + Enough: Sufficient quality

Good enough: Sufficiently good
Fast enough: Sufficiently fast
Big enough: Sufficiently big', 'So and such intensify adjectives and nouns. Too indicates excess. Enough indicates sufficiency.', 'These words are essential for expressing opinions, complaints, and satisfaction. They appear frequently in casual conversation.', 'So: The movie was so good! (Intensifier - positive).
Too: The movie was too long. (Excess - negative).
Enough: The movie was long enough. (Sufficiency).', 'Error: Confusing so and such (It is such big / It is so a big house).
Fix: So + adjective. Such + noun.

Error: Putting enough before the adjective (enough good / enough big).
Fix: Adjective + enough (good enough / big enough).

L1 Transfer Note: Portuguese uses tão for so/such and demais for too. The word order for enough is particularly tricky for Brazilians.', 'Express strong opinions and emotions.
Complain about things.
Describe satisfaction or dissatisfaction.', 'Starter: It is very expensive. → Upgrade: It is too expensive.
Starter: It is very good. → Upgrade: It is so good!', '[{"type":"multiple_choice","prompt":"Choose so or such: The weather is ___ beautiful today!","options":["so","such"],"answer":"so","feedback":"Use ''so'' before an adjective (beautiful). ''Such'' is used before a noun."},{"type":"multiple_choice","prompt":"Choose so or such: That is ___ a good idea!","options":["so","such"],"answer":"such","feedback":"Use ''such'' before a noun phrase (a good idea). ''So'' is used before an adjective alone."},{"type":"multiple_choice","prompt":"Choose too or enough: The coffee is ___ hot. I can''t drink it.","options":["too","enough"],"answer":"too","feedback":"Use ''too'' to indicate excess (more than needed). ''Enough'' indicates sufficiency."},{"type":"fill_blank","prompt":"Complete: Is this apartment big ___?","answer":"enough","feedback":"Use ''enough'' after the adjective to indicate sufficiency."},{"type":"mini_output","prompt":"Speaking: Describe something you like and something you dislike using so/such, too, and enough.","answer":"Example: The restaurant has such good food! The portions are too big. The prices are reasonable enough.","feedback":"Your response should correctly use so/such for intensifiers, too for excess, and enough for sufficiency."}]'::jsonb, '[{"type":"prerequisite","chapter_code":"A2.G.08","note":null},{"type":"advanced","chapter_code":"B1.G.30","note":"Intensifiers"}]'::jsonb, true, 25),
  ('A2.G.26', 'Both/Neither/Either', 'A2', 'Both: Two things together (affirmative)

Both options are good.
I like both coffee and tea.
Both of them are here.

Neither: Not one and not the other (negative)

Neither option is good.
I like neither coffee nor tea.
Neither of them is here.

Either: One or the other (choice)

Either option is fine.
You can choose either coffee or tea.
Either of them can help.

Correlative Conjunctions:
Both...and: I like both pizza and pasta.
Neither...nor: I like neither pizza nor pasta.
Either...or: You can choose either pizza or pasta.', 'Both includes two things. Neither excludes both things. Either presents a choice between two things.', 'These words are essential for discussing options, preferences, and agreements. They appear frequently in decision-making conversations.', 'Both: I like both options. (Affirmative - I like two things).
Neither: I like neither option. (Negative - I like zero things).
Either: I like either option. (Choice - I like one of two things).', 'Error: Using neither with or (Neither coffee or tea).
Fix: Use neither...nor (Neither coffee nor tea).

Error: Confusing both and either (Either of them are here).
Fix: Both of them are here (affirmative). Either of them is here (choice - singular).

L1 Transfer Note: Portuguese uses ambos, nenhum, and qualquer um. The correlative conjunctions (both...and, neither...nor, either...or) are particularly tricky.', 'Discuss options and preferences.
Make agreements or disagreements.
Express choices clearly.', 'Starter: I like coffee and tea. → Upgrade: I like both coffee and tea.
Starter: I don''t like coffee or tea. → Upgrade: I like neither coffee nor tea.', '[{"type":"multiple_choice","prompt":"Choose the correct option: ___ of them can help you with the project.","options":["Both","Neither"],"answer":"Both","feedback":"Use ''both'' to include two people. ''Neither'' would mean neither person can help."},{"type":"multiple_choice","prompt":"Choose the correct option: I like ___ pizza ___ pasta.","options":["both...and","neither...nor"],"answer":"both...and","feedback":"Use ''both...and'' to include two things you like. ''Neither...nor'' means you like neither."},{"type":"fill_blank","prompt":"Complete: You can choose ___ option. Both are acceptable.","answer":"either","feedback":"Use ''either'' to present a choice between two options."},{"type":"transformation","prompt":"Rewrite using neither...nor: I don''t like coffee. I don''t like tea.","answer":"I like neither coffee nor tea.","feedback":"Use ''neither...nor'' to express that you dislike both things."},{"type":"mini_output","prompt":"Speaking: Tell a partner about two options you have and express your preference using both, neither, or either.","answer":"Example: I can choose either job. Both positions are interesting. I like neither option, actually.","feedback":"Your response should correctly use both, neither, and either to discuss options."}]'::jsonb, '[{"type":"prerequisite","chapter_code":"A1.G.21","note":null},{"type":"advanced","chapter_code":"B1.G.31","note":"Quantifiers III"}]'::jsonb, true, 26),
  ('A2.G.27', 'Reflexive Pronouns', 'A2', 'Reflexive Pronouns:

I → myself
You → yourself
He → himself
She → herself
It → itself
We → ourselves
You (plural) → yourselves
They → themselves

Uses:

1. The action returns to the subject (the person doing the action does it to themselves):
I cut myself. (I cut my own body).
She dressed herself. (She put on her own clothes).

2. Emphasis (to emphasize that the subject did the action):
I did it myself. (I did it, not someone else).
The president himself attended the meeting. (The president, not a representative).

3. Reflexive verbs (actions that naturally involve yourself):
Enjoy yourself: Have fun
Help yourself: Take what you want
Behave yourself: Act properly
Hurt yourself: Injure yourself', 'Reflexive pronouns show that the action returns to the subject. They are used when the subject and object are the same person.', 'Reflexive pronouns are essential for describing personal care, accidents, and emphasis. They appear frequently in everyday English.', 'Regular: I cut the bread. (I cut something else).
Reflexive: I cut myself. (I cut my own body).', 'Error: Using a regular pronoun instead of reflexive (I cut me / She dressed her).
Fix: Use the reflexive form when the action returns to the subject.

L1 Transfer Note: Portuguese uses reflexive pronouns similarly (me corto, ela se vestiu), so this concept should be familiar. The main issue is remembering to use them in English.', 'Describe personal care and accidents.
Emphasize that you did something yourself.
Use common reflexive expressions.', 'Starter: I hurt my body. → Upgrade: I hurt myself.
Starter: I did it. → Upgrade: I did it myself.', '[{"type":"multiple_choice","prompt":"Choose the correct reflexive pronoun: He cut ___ while cooking.","options":["him","himself"],"answer":"himself","feedback":"Use ''himself'' because the action returns to the subject (he cut his own body)."},{"type":"multiple_choice","prompt":"Choose the correct reflexive pronoun: They enjoyed ___ at the party.","options":["them","themselves"],"answer":"themselves","feedback":"Use ''themselves'' because they enjoyed their own experience."},{"type":"fill_blank","prompt":"Complete: I did the project ___.","answer":"myself","feedback":"Use ''myself'' to emphasize that you did it, not someone else."},{"type":"transformation","prompt":"Rewrite using a reflexive pronoun: She dressed her own clothes.","answer":"She dressed herself.","feedback":"Use ''herself'' to show that she dressed her own body."},{"type":"mini_output","prompt":"Speaking: Tell a partner about something you did yourself or an accident where you hurt yourself.","answer":"Example: I made the cake myself. I hurt myself playing soccer yesterday.","feedback":"Your response should correctly use reflexive pronouns to describe personal actions and accidents."}]'::jsonb, '[{"type":"prerequisite","chapter_code":"A1.G.22","note":null},{"type":"advanced","chapter_code":"B1.G.32","note":"Discourse markers"}]'::jsonb, true, 27),
  ('A2.G.28', 'Possessive Pronouns Review', 'A2', 'Possessive Pronouns (Review and Expansion from A1.G.23)

Mine: Belongs to me
Yours: Belongs to you
His: Belongs to him
Hers: Belongs to her
Ours: Belongs to us
Theirs: Belongs to them

Key Differences:

Possessive Adjectives vs. Possessive Pronouns:
Possessive Adjective: My book (adjective modifies the noun)
Possessive Pronoun: This book is mine. (pronoun replaces the noun)

Possessive Adjectives: my, your, his, her, its, our, their
Possessive Pronouns: mine, yours, his, hers, ours, theirs

Common Expressions:
A friend of mine: One of my friends
A colleague of yours: One of your colleagues
That is none of your business: That does not concern you', 'Possessive pronouns replace nouns to avoid repetition. They stand alone without a noun following them.', 'Possessive pronouns are essential for avoiding repetition and sounding natural. They appear frequently in conversation.', 'Possessive Adjective: This is my book.
Possessive Pronoun: This book is mine.', 'Error: Using possessive adjective instead of pronoun (This is my / That is your).
Fix: Use the pronoun form when the noun is not present (This is mine / That is yours).

Error: Confusing his and hers (This is his book / This is hers book).
Fix: His and hers are pronouns and do not need a noun after them.

L1 Transfer Note: Portuguese uses possessive pronouns similarly (meu, seu, dele, dela), so this concept should be familiar. The main issue is remembering to use the pronoun form without a noun.', 'Clarify ownership and possession.
Avoid repetition in conversation.
Use common possessive expressions.', 'Starter: This is my book. → Upgrade: This book is mine.
Starter: That is your pen. → Upgrade: That pen is yours.', '[{"type":"multiple_choice","prompt":"Choose the correct possessive pronoun: This laptop is ___. It belongs to me.","options":["my","mine"],"answer":"mine","feedback":"Use ''mine'' (pronoun) because the noun ''laptop'' is not repeated. ''My'' is an adjective."},{"type":"multiple_choice","prompt":"Choose the correct possessive pronoun: These are ___ keys. They belong to her.","options":["her","hers"],"answer":"hers","feedback":"Use ''hers'' (pronoun) because the noun ''keys'' is not repeated. ''Her'' is an adjective."},{"type":"fill_blank","prompt":"Complete: A friend of ___ told me about this restaurant.","answer":"mine","feedback":"Use ''mine'' in the expression ''a friend of mine'' to mean ''one of my friends''."},{"type":"transformation","prompt":"Rewrite using a possessive pronoun: This is my book.","answer":"This book is mine.","feedback":"Use ''mine'' to replace ''my book'' and avoid repetition."},{"type":"mini_output","prompt":"Speaking: Tell a partner about something that belongs to you and something that belongs to a friend using possessive pronouns.","answer":"Example: This phone is mine. That car is his. A friend of mine has a boat.","feedback":"Your response should correctly use possessive pronouns (mine, yours, his, hers, ours, theirs) to show ownership."}]'::jsonb, '[{"type":"prerequisite","chapter_code":"A1.G.23","note":null},{"type":"advanced","chapter_code":"B1.G.01","note":"Present perfect vs past simple"}]'::jsonb, true, 28)
) AS new_chapters(chapter_code, title, cefr_level, form_content, meaning_content, use_content, contrast_notes, common_errors, diagnostic_hook, task_upgrades, micro_practice, cross_links, is_published, sort_order)
WHERE NOT EXISTS (
  SELECT 1 FROM public.grammar_chapters 
  WHERE chapter_code = new_chapters.chapter_code
);
