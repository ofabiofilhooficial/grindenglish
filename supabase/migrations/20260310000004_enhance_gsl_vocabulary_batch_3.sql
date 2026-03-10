-- Migration: Enhance GSL Vocabulary - Batch 3 (A0 Prepositions and Conjunctions)
-- Description: Add comprehensive linguistic data for third batch of A0 words
-- Words: Prepositions (in, on, at, to, from, with, for, about, by, up, down, out, off, over, under, etc.)
--        Conjunctions (because, if, when, while, since, until, so, as, etc.)
-- Target: ~100 A0 words (prepositions and function words)

-- ============================================================================
-- PREPOSITIONS - LOCATION AND DIRECTION (25 words)
-- ============================================================================

-- Preposition: in
UPDATE lexicon_entries
SET
  ipa = 'ɪn',
  definition_simple = 'inside something or at a place',
  definition_teacher = 'preposition: expresses location within boundaries, time periods, or states; highly versatile with spatial, temporal, and abstract uses; neutral register',
  usage_notes = 'Fundamental preposition. In professional contexts: "in the office", "in a meeting", "in time" (before deadline), "in progress". Brazilian learners often confuse "in" (inside/within) with "on" (surface) and "at" (point). Use "in" for enclosed spaces, cities, countries, and longer time periods.',
  register = 'neutral',
  variety = 'international',
  examples = '["I work in São Paulo.", "The meeting is in the conference room.", "She will arrive in two hours.", "We are in the process of reviewing applications."]'::jsonb,
  collocations = '["in the office", "in a meeting", "in time", "in progress", "in advance"]'::jsonb,
  patterns = '["in + place", "in + time period", "in + state/condition"]'::jsonb,
  updated_at = now()
WHERE headword = 'in';

-- Preposition: on
UPDATE lexicon_entries
SET
  ipa = 'ɒn',
  definition_simple = 'touching the surface of something',
  definition_teacher = 'preposition: expresses position on a surface, days/dates, topics, or states; also used for devices and transportation; neutral register',
  usage_notes = 'Common preposition. In professional contexts: "on time" (punctual), "on schedule", "on the phone", "on a team", "work on a project". Use "on" for surfaces, days/dates, and topics. Brazilian learners often confuse with "in" - remember "on" for surfaces and specific days.',
  register = 'neutral',
  variety = 'international',
  examples = '["The report is on your desk.", "The meeting is on Monday.", "I am working on a new project.", "She is on the phone right now."]'::jsonb,
  collocations = '["on time", "on schedule", "on the phone", "work on", "on a team"]'::jsonb,
  patterns = '["on + surface", "on + day/date", "on + topic", "on + device"]'::jsonb,
  updated_at = now()
WHERE headword = 'on';

-- Preposition: at
UPDATE lexicon_entries
SET
  ipa = 'æt',
  definition_simple = 'in a particular place or time',
  definition_teacher = 'preposition: expresses specific location points, clock times, or rates; used for precise positions and moments; neutral register',
  usage_notes = 'Precise location/time preposition. In professional contexts: "at work", "at the office", "at 3 PM", "at the meeting". Use "at" for specific points (locations, times, rates). Brazilian learners often confuse with "in" and "on" - remember "at" for specific points.',
  register = 'neutral',
  variety = 'international',
  examples = '["I am at work right now.", "The meeting starts at 2 PM.", "She is at the conference.", "We sell products at competitive prices."]'::jsonb,
  collocations = '["at work", "at the office", "at a meeting", "at the moment", "at a price"]'::jsonb,
  patterns = '["at + specific location", "at + clock time", "at + rate/price"]'::jsonb,
  updated_at = now()
WHERE headword = 'at';

-- Preposition: to
UPDATE lexicon_entries
SET
  ipa = 'tuː',
  definition_simple = 'in the direction of a place or person',
  definition_teacher = 'preposition: expresses direction, destination, recipient, or range; also used in infinitive verb forms; neutral register',
  usage_notes = 'Fundamental direction preposition. In professional contexts: "go to work", "send to", "from Monday to Friday", "to + infinitive". Very common in business. Note: "to" (preposition/infinitive marker) vs "too" (also/excessive) vs "two" (number) - common confusion.',
  register = 'neutral',
  variety = 'international',
  examples = '["I go to the office every day.", "Please send the file to me.", "We work from 9 to 5.", "I need to finish this report."]'::jsonb,
  collocations = '["go to", "send to", "from...to", "need to", "have to"]'::jsonb,
  patterns = '["to + place", "to + person", "from...to", "to + infinitive"]'::jsonb,
  updated_at = now()
WHERE headword = 'to';

-- Preposition: from
UPDATE lexicon_entries
SET
  ipa = 'frɒm',
  definition_simple = 'showing where something starts or comes from',
  definition_teacher = 'preposition: expresses origin, source, starting point, or separation; often paired with "to" for ranges; neutral register',
  usage_notes = 'Origin/source preposition. In professional contexts: "from 9 to 5", "email from", "from experience", "work from home". Very common in business communication. Often used with "to" to show ranges or movement.',
  register = 'neutral',
  variety = 'international',
  examples = '["I received an email from the manager.", "We work from 9 AM to 5 PM.", "She works from home.", "This is different from the previous version."]'::jsonb,
  collocations = '["from...to", "email from", "work from home", "from experience", "different from"]'::jsonb,
  patterns = '["from + source", "from...to", "from + place"]'::jsonb,
  updated_at = now()
WHERE headword = 'from';

-- Preposition: with
UPDATE lexicon_entries
SET
  ipa = 'wɪð',
  definition_simple = 'together with someone or something',
  definition_teacher = 'preposition: expresses accompaniment, instrument, manner, or possession; highly versatile; neutral register',
  usage_notes = 'Versatile preposition. In professional contexts: "work with", "meet with", "deal with", "with experience", "with pleasure". Very common in business. Can express accompaniment, tools, or characteristics.',
  register = 'neutral',
  variety = 'international',
  examples = '["I work with a great team.", "She has a meeting with the client.", "We need someone with experience.", "I will help you with this project."]'::jsonb,
  collocations = '["work with", "meet with", "deal with", "with experience", "with pleasure"]'::jsonb,
  patterns = '["with + person", "with + tool/instrument", "with + quality"]'::jsonb,
  updated_at = now()
WHERE headword = 'with';

-- Preposition: for
UPDATE lexicon_entries
SET
  ipa = 'fɔːr',
  definition_simple = 'intended to be given to or used by someone',
  definition_teacher = 'preposition: expresses purpose, beneficiary, duration, or support; highly versatile with multiple meanings; neutral register',
  usage_notes = 'Highly versatile preposition. In professional contexts: "work for", "for example", "for two years", "responsible for", "wait for". Very common in business. Can express purpose, duration, or beneficiary. Note: "for" (preposition) vs "four" (number) - same pronunciation.',
  register = 'neutral',
  variety = 'international',
  examples = '["I work for a technology company.", "This document is for you.", "She has worked here for five years.", "I am responsible for the project."]'::jsonb,
  collocations = '["work for", "for example", "responsible for", "wait for", "for a long time"]'::jsonb,
  patterns = '["for + beneficiary", "for + duration", "for + purpose"]'::jsonb,
  updated_at = now()
WHERE headword = 'for';

-- Preposition: about
UPDATE lexicon_entries
SET
  ipa = 'əˈbaʊt',
  definition_simple = 'on the subject of something',
  definition_teacher = 'preposition: expresses topic, approximation, or concern; also adverb meaning "approximately"; neutral register',
  usage_notes = 'Topic/approximation preposition. In professional contexts: "talk about", "think about", "about 100 people", "information about", "worry about". Very common in business communication. Can mean "concerning" or "approximately".',
  register = 'neutral',
  variety = 'international',
  examples = '["We need to talk about the project.", "I have a question about the report.", "There are about 50 employees.", "She is concerned about the deadline."]'::jsonb,
  collocations = '["talk about", "think about", "information about", "worry about", "about (approximately)"]'::jsonb,
  patterns = '["about + topic", "about + number (approximately)"]'::jsonb,
  updated_at = now()
WHERE headword = 'about';

-- Preposition: by
UPDATE lexicon_entries
SET
  ipa = 'baɪ',
  definition_simple = 'near something or before a time',
  definition_teacher = 'preposition: expresses proximity, agent (passive voice), method, or deadline; highly versatile; neutral register',
  usage_notes = 'Versatile preposition. In professional contexts: "by Friday" (deadline), "by email", "by the way", "done by" (agent). Very common in business. Used for deadlines, methods, and agents in passive voice.',
  register = 'neutral',
  variety = 'international',
  examples = '["Please finish this by Friday.", "Send the document by email.", "The report was written by our team.", "By the way, we have a meeting tomorrow."]'::jsonb,
  collocations = '["by email", "by phone", "by the way", "by Friday", "done by"]'::jsonb,
  patterns = '["by + deadline", "by + method", "by + agent (passive)"]'::jsonb,
  updated_at = now()
WHERE headword = 'by';

-- Preposition: up
UPDATE lexicon_entries
SET
  ipa = 'ʌp',
  definition_simple = 'toward a higher place or position',
  definition_teacher = 'preposition/adverb: expresses upward direction, increase, or completion; often used in phrasal verbs; neutral register',
  usage_notes = 'Direction/completion word. In professional contexts: "follow up", "set up", "pick up", "up to date", "go up" (increase). Very common in phrasal verbs. Can be preposition, adverb, or part of phrasal verb.',
  register = 'neutral',
  variety = 'international',
  examples = '["Please follow up with the client.", "We need to set up a meeting.", "Sales went up this quarter.", "Keep your skills up to date."]'::jsonb,
  collocations = '["follow up", "set up", "pick up", "up to date", "go up"]'::jsonb,
  patterns = '["verb + up (phrasal verb)", "up + to", "up + noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'up';

-- Preposition: down
UPDATE lexicon_entries
SET
  ipa = 'daʊn',
  definition_simple = 'toward a lower place or position',
  definition_teacher = 'preposition/adverb: expresses downward direction, decrease, or recording; often used in phrasal verbs; neutral register',
  usage_notes = 'Direction/decrease word. In professional contexts: "write down", "break down", "slow down", "go down" (decrease), "shut down". Common in phrasal verbs. Can be preposition, adverb, or part of phrasal verb.',
  register = 'neutral',
  variety = 'international',
  examples = '["Please write down the key points.", "Let me break down the costs.", "Sales went down last month.", "The system shut down unexpectedly."]'::jsonb,
  collocations = '["write down", "break down", "slow down", "go down", "shut down"]'::jsonb,
  patterns = '["verb + down (phrasal verb)", "down + to", "down + noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'down';

-- Preposition: out
UPDATE lexicon_entries
SET
  ipa = 'aʊt',
  definition_simple = 'away from the inside of a place',
  definition_teacher = 'preposition/adverb: expresses movement away from inside, absence, or completion; very common in phrasal verbs; neutral register',
  usage_notes = 'Movement/completion word. In professional contexts: "find out", "work out", "carry out", "out of office", "point out". Very common in phrasal verbs. Can express exit, absence, or completion.',
  register = 'neutral',
  variety = 'international',
  examples = '["We need to find out more information.", "Let''s work out a solution.", "I am out of the office today.", "She pointed out an important issue."]'::jsonb,
  collocations = '["find out", "work out", "carry out", "out of office", "point out"]'::jsonb,
  patterns = '["verb + out (phrasal verb)", "out + of", "out + noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'out';

-- Preposition: off
UPDATE lexicon_entries
SET
  ipa = 'ɒf',
  definition_simple = 'away from a place or not working',
  definition_teacher = 'preposition/adverb: expresses removal, separation, deactivation, or absence; common in phrasal verbs; neutral register',
  usage_notes = 'Removal/absence word. In professional contexts: "day off", "time off", "turn off", "take off", "off duty". Common in workplace discussions. Can express removal, deactivation, or absence from work.',
  register = 'neutral',
  variety = 'international',
  examples = '["I have a day off tomorrow.", "Please turn off your phone.", "The meeting is off (cancelled).", "She took time off for vacation."]'::jsonb,
  collocations = '["day off", "time off", "turn off", "take off", "off duty"]'::jsonb,
  patterns = '["verb + off (phrasal verb)", "off + duty/work", "noun + off"]'::jsonb,
  updated_at = now()
WHERE headword = 'off';

-- Preposition: over
UPDATE lexicon_entries
SET
  ipa = 'ˈəʊvər',
  definition_simple = 'above something or more than a number',
  definition_teacher = 'preposition: expresses position above, movement across, excess, or duration; highly versatile; neutral register',
  usage_notes = 'Position/excess preposition. In professional contexts: "over budget", "over time", "go over" (review), "over the phone", "over 100 employees". Common in business. Can express position, excess, or duration.',
  register = 'neutral',
  variety = 'international',
  examples = '["The project is over budget.", "We have over 100 employees.", "Let''s go over the report.", "We discussed this over the phone."]'::jsonb,
  collocations = '["over budget", "over time", "go over", "over the phone", "over (more than)"]'::jsonb,
  patterns = '["over + number", "over + noun", "go over"]'::jsonb,
  updated_at = now()
WHERE headword = 'over';

-- Preposition: under
UPDATE lexicon_entries
SET
  ipa = 'ˈʌndər',
  definition_simple = 'below something or less than a number',
  definition_teacher = 'preposition: expresses position below, subordination, or being less than; opposite of "over"; neutral register',
  usage_notes = 'Position/subordination preposition. In professional contexts: "under budget", "under pressure", "under review", "under management", "under 30 years old". Common in business. Can express position, subordination, or being less than.',
  register = 'neutral',
  variety = 'international',
  examples = '["The project is under budget.", "The document is under review.", "She works under a lot of pressure.", "We have employees under 30 years old."]'::jsonb,
  collocations = '["under budget", "under pressure", "under review", "under management", "under (less than)"]'::jsonb,
  patterns = '["under + number", "under + noun", "under + condition"]'::jsonb,
  updated_at = now()
WHERE headword = 'under';

-- Preposition: through
UPDATE lexicon_entries
SET
  ipa = 'θruː',
  definition_simple = 'from one side of something to the other',
  definition_teacher = 'preposition: expresses movement across/within, means, or completion; neutral register',
  usage_notes = 'Movement/means preposition. In professional contexts: "go through" (review), "through email", "through experience", "get through" (complete). Common in business. Can express movement, means, or completion.',
  register = 'neutral',
  variety = 'international',
  examples = '["Let''s go through the document.", "Please contact me through email.", "I learned this through experience.", "We got through all the tasks."]'::jsonb,
  collocations = '["go through", "through email", "through experience", "get through", "through the process"]'::jsonb,
  patterns = '["through + place", "through + means", "go through"]'::jsonb,
  updated_at = now()
WHERE headword = 'through';

-- Preposition: between
UPDATE lexicon_entries
SET
  ipa = 'bɪˈtwiːn',
  definition_simple = 'in the space or time that separates two things',
  definition_teacher = 'preposition: expresses position or relationship involving two entities; used for spatial, temporal, or relational contexts; neutral register',
  usage_notes = 'Two-entity preposition. In professional contexts: "between meetings", "between 9 and 5", "choose between", "difference between". Use "between" for two items, "among" for more than two. Brazilian learners often confuse these.',
  register = 'neutral',
  variety = 'international',
  examples = '["The meeting is between 2 and 3 PM.", "We need to choose between two options.", "There is a difference between the two proposals.", "I have time between meetings."]'::jsonb,
  collocations = '["between meetings", "between...and", "choose between", "difference between"]'::jsonb,
  patterns = '["between + two items", "between...and"]'::jsonb,
  updated_at = now()
WHERE headword = 'between';

-- Preposition: among
UPDATE lexicon_entries
SET
  ipa = 'əˈmʌŋ',
  definition_simple = 'in the middle of a group of things or people',
  definition_teacher = 'preposition: expresses position or relationship involving three or more entities; used for groups; neutral register',
  usage_notes = 'Group preposition. In professional contexts: "among employees", "among the best", "among other things". Use "among" for more than two items, "between" for two. Common in business communication.',
  register = 'neutral',
  variety = 'international',
  examples = '["She is among the best employees.", "This is popular among our clients.", "Among other things, we need to improve communication.", "The information was shared among the team."]'::jsonb,
  collocations = '["among employees", "among the best", "among other things", "among ourselves"]'::jsonb,
  patterns = '["among + group", "among + superlative"]'::jsonb,
  updated_at = now()
WHERE headword = 'among';

-- Preposition: during
UPDATE lexicon_entries
SET
  ipa = 'ˈdjʊərɪŋ',
  definition_simple = 'throughout a period of time',
  definition_teacher = 'preposition: expresses time period when something happens; used with nouns, not clauses; neutral register',
  usage_notes = 'Time period preposition. In professional contexts: "during the meeting", "during office hours", "during the week", "during the project". Note: use "during" + noun, not "during" + clause. Brazilian learners often confuse "during" with "while".',
  register = 'neutral',
  variety = 'international',
  examples = '["Please don''t use your phone during the meeting.", "I am available during office hours.", "We made progress during the project.", "Sales increased during the quarter."]'::jsonb,
  collocations = '["during the meeting", "during office hours", "during the week", "during the project"]'::jsonb,
  patterns = '["during + time period/event"]'::jsonb,
  updated_at = now()
WHERE headword = 'during';

-- Preposition: before
UPDATE lexicon_entries
SET
  ipa = 'bɪˈfɔːr',
  definition_simple = 'earlier than something',
  definition_teacher = 'preposition/conjunction: expresses earlier time or position in front; can be followed by noun or clause; neutral register',
  usage_notes = 'Earlier time preposition. In professional contexts: "before the meeting", "before Friday", "before starting", "the day before". Common in scheduling. Can be preposition (before noon) or conjunction (before we start).',
  register = 'neutral',
  variety = 'international',
  examples = '["Please finish this before Friday.", "We should meet before the presentation.", "I need to review this before sending it.", "The day before the deadline was very busy."]'::jsonb,
  collocations = '["before the meeting", "before Friday", "the day before", "before starting"]'::jsonb,
  patterns = '["before + time", "before + event", "before + gerund/clause"]'::jsonb,
  updated_at = now()
WHERE headword = 'before';

-- Preposition: after
UPDATE lexicon_entries
SET
  ipa = 'ˈɑːftər',
  definition_simple = 'later than something',
  definition_teacher = 'preposition/conjunction: expresses later time or following position; can be followed by noun or clause; neutral register',
  usage_notes = 'Later time preposition. In professional contexts: "after the meeting", "after 5 PM", "after finishing", "the day after". Common in scheduling. Can be preposition (after lunch) or conjunction (after we finish).',
  register = 'neutral',
  variety = 'international',
  examples = '["Let''s talk after the meeting.", "I will be available after 3 PM.", "We can start after everyone arrives.", "The day after the presentation, we received feedback."]'::jsonb,
  collocations = '["after the meeting", "after work", "after hours", "the day after"]'::jsonb,
  patterns = '["after + time", "after + event", "after + gerund/clause"]'::jsonb,
  updated_at = now()
WHERE headword = 'after';

-- Preposition: until
UPDATE lexicon_entries
SET
  ipa = 'ənˈtɪl',
  definition_simple = 'up to the time when something happens',
  definition_teacher = 'preposition/conjunction: expresses continuation up to a specific time or event; can be followed by noun or clause; neutral register',
  usage_notes = 'Duration endpoint preposition. In professional contexts: "until Friday", "until 5 PM", "until we finish", "not until". Common in deadlines. Note: "until" and "till" are interchangeable, but "until" is more formal.',
  register = 'neutral',
  variety = 'international',
  examples = '["I will be in meetings until 4 PM.", "We need to wait until Friday.", "The office is open until 6 PM.", "Don''t start until everyone is ready."]'::jsonb,
  collocations = '["until Friday", "until now", "not until", "wait until"]'::jsonb,
  patterns = '["until + time", "until + event", "until + clause"]'::jsonb,
  updated_at = now()
WHERE headword = 'until';

-- Preposition: since
UPDATE lexicon_entries
SET
  ipa = 'sɪns',
  definition_simple = 'from a time in the past until now',
  definition_teacher = 'preposition/conjunction: expresses starting point continuing to present, or reason; used with present perfect tense; neutral register',
  usage_notes = 'Starting point preposition. In professional contexts: "since Monday", "since 2020", "since joining the company". Used with present perfect: "I have worked here since 2020". Also means "because": "Since you are here, let''s start."',
  register = 'neutral',
  variety = 'international',
  examples = '["I have worked here since 2020.", "We have been waiting since 9 AM.", "Since you mentioned it, let me explain.", "The company has grown since last year."]'::jsonb,
  collocations = '["since Monday", "since last year", "since then", "ever since"]'::jsonb,
  patterns = '["since + time point", "have + past participle + since", "since + clause (reason)"]'::jsonb,
  updated_at = now()
WHERE headword = 'since';

-- Preposition: into
UPDATE lexicon_entries
SET
  ipa = 'ˈɪntuː',
  definition_simple = 'to the inside of something',
  definition_teacher = 'preposition: expresses movement toward the interior, transformation, or involvement; implies direction and entry; neutral register',
  usage_notes = 'Movement inward preposition. In professional contexts: "go into details", "look into" (investigate), "get into" (become involved), "turn into". Common in business. Expresses movement or transformation.',
  register = 'neutral',
  variety = 'international',
  examples = '["Let''s go into more detail.", "We need to look into this issue.", "She got into project management.", "The meeting turned into a long discussion."]'::jsonb,
  collocations = '["go into detail", "look into", "get into", "turn into", "divide into"]'::jsonb,
  patterns = '["into + place", "verb + into", "into + field/topic"]'::jsonb,
  updated_at = now()
WHERE headword = 'into';

-- Preposition: onto
UPDATE lexicon_entries
SET
  ipa = 'ˈɒntuː',
  definition_simple = 'moving to a position on a surface',
  definition_teacher = 'preposition: expresses movement toward and upon a surface; implies direction and contact; neutral register',
  usage_notes = 'Movement to surface preposition. In professional contexts: "move onto", "onto the next topic", "get onto" (board/access). Note: "onto" (preposition showing movement) vs "on to" (adverb + preposition). Common in transitions.',
  register = 'neutral',
  variety = 'international',
  examples = '["Let''s move onto the next topic.", "Please save the file onto the server.", "We need to get onto this issue quickly.", "The project moved onto the next phase."]'::jsonb,
  collocations = '["move onto", "onto the next", "get onto", "onto the agenda"]'::jsonb,
  patterns = '["onto + surface", "move onto", "onto + next item"]'::jsonb,
  updated_at = now()
WHERE headword = 'onto';

-- Preposition: without
UPDATE lexicon_entries
SET
  ipa = 'wɪðˈaʊt',
  definition_simple = 'not having or not with something',
  definition_teacher = 'preposition: expresses absence, lack, or exclusion; opposite of "with"; neutral register',
  usage_notes = 'Absence preposition. In professional contexts: "without delay", "without notice", "without experience", "go without saying". Common in business. Expresses lack or absence of something.',
  register = 'neutral',
  variety = 'international',
  examples = '["We need to finish this without delay.", "She left without notice.", "It goes without saying that quality is important.", "We cannot proceed without approval."]'::jsonb,
  collocations = '["without delay", "without notice", "without doubt", "go without saying"]'::jsonb,
  patterns = '["without + noun", "without + gerund"]'::jsonb,
  updated_at = now()
WHERE headword = 'without';

-- Preposition: within
UPDATE lexicon_entries
SET
  ipa = 'wɪðˈɪn',
  definition_simple = 'inside something or before a period of time ends',
  definition_teacher = 'preposition: expresses interior position, time limit, or range; more formal than "in"; neutral register',
  usage_notes = 'Interior/time limit preposition. In professional contexts: "within the company", "within 24 hours", "within budget", "within reach". Common in business. More formal than "in" for time periods.',
  register = 'neutral',
  variety = 'international',
  examples = '["We will respond within 24 hours.", "The solution is within our budget.", "This information stays within the team.", "The goal is within reach."]'::jsonb,
  collocations = '["within 24 hours", "within budget", "within the company", "within reach"]'::jsonb,
  patterns = '["within + time period", "within + limit", "within + place"]'::jsonb,
  updated_at = now()
WHERE headword = 'within';

-- ============================================================================
-- CONJUNCTIONS - CONNECTING IDEAS (15 words)
-- ============================================================================

-- Conjunction: because
UPDATE lexicon_entries
SET
  ipa = 'bɪˈkɒz',
  definition_simple = 'for the reason that',
  definition_teacher = 'conjunction: introduces reason or cause; subordinating conjunction that connects clauses; neutral register',
  usage_notes = 'Reason conjunction. In professional contexts: "because of" (+ noun), "because" (+ clause). Very common in explanations. Note: "because" + clause vs "because of" + noun. Brazilian learners sometimes use "because" incorrectly with nouns.',
  register = 'neutral',
  variety = 'international',
  examples = '["I am late because of traffic.", "We postponed the meeting because the manager is sick.", "She succeeded because she worked hard.", "Because of the deadline, we need to work faster."]'::jsonb,
  collocations = '["because of", "just because", "because + clause"]'::jsonb,
  patterns = '["because + clause", "because of + noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'because';

-- Conjunction: if
UPDATE lexicon_entries
SET
  ipa = 'ɪf',
  definition_simple = 'used to say that something will happen only when something else happens',
  definition_teacher = 'conjunction: introduces conditional clauses; expresses conditions, possibilities, or polite requests; neutral register',
  usage_notes = 'Conditional conjunction. In professional contexts: "if possible", "if necessary", "if you have questions", "even if". Very common in business. Used for conditions, possibilities, and polite requests.',
  register = 'neutral',
  variety = 'international',
  examples = '["If you have questions, please ask.", "We can meet tomorrow if that works for you.", "If necessary, we can extend the deadline.", "Even if it''s difficult, we need to try."]'::jsonb,
  collocations = '["if possible", "if necessary", "if not", "even if", "as if"]'::jsonb,
  patterns = '["if + clause, main clause", "main clause + if + clause"]'::jsonb,
  updated_at = now()
WHERE headword = 'if';

-- Conjunction: when
UPDATE lexicon_entries
SET
  ipa = 'wen',
  definition_simple = 'at the time that something happens',
  definition_teacher = 'conjunction/adverb: introduces time clauses or asks about time; can be subordinating conjunction or question word; neutral register',
  usage_notes = 'Time conjunction. In professional contexts: "when possible", "when ready", "when you arrive", "let me know when". Very common in scheduling. Can introduce time clauses or ask questions about time.',
  register = 'neutral',
  variety = 'international',
  examples = '["Please call me when you arrive.", "When is the meeting?", "We will start when everyone is ready.", "Let me know when you finish."]'::jsonb,
  collocations = '["when possible", "when ready", "let me know when", "when you arrive"]'::jsonb,
  patterns = '["when + clause", "when + question"]'::jsonb,
  updated_at = now()
WHERE headword = 'when';

-- Conjunction: while
UPDATE lexicon_entries
SET
  ipa = 'waɪl',
  definition_simple = 'during the time that something is happening',
  definition_teacher = 'conjunction: introduces simultaneous action or contrast; expresses duration or opposition; neutral register',
  usage_notes = 'Simultaneous/contrast conjunction. In professional contexts: "while working", "while you wait", "while...at the same time". Can express simultaneous actions or contrast. Note: "while" + clause, not "while" + noun (use "during" + noun).',
  register = 'neutral',
  variety = 'international',
  examples = '["I will work on this while you are in the meeting.", "While I agree with you, I have some concerns.", "Please wait here while I check.", "While sales increased, costs also went up."]'::jsonb,
  collocations = '["while working", "while you wait", "while...at the same time"]'::jsonb,
  patterns = '["while + clause (simultaneous)", "while + clause (contrast)"]'::jsonb,
  updated_at = now()
WHERE headword = 'while';

-- Conjunction: so
UPDATE lexicon_entries
SET
  ipa = 'səʊ',
  definition_simple = 'therefore or as a result',
  definition_teacher = 'conjunction/adverb: introduces result or purpose; coordinating conjunction for consequence; also intensifier; neutral register',
  usage_notes = 'Result conjunction. In professional contexts: "so that" (purpose), "so" (result), "so far", "and so on". Very common in business. Can introduce results or purposes. Also used as intensifier: "so important".',
  register = 'neutral',
  variety = 'international',
  examples = '["The deadline is tight, so we need to work fast.", "We are doing this so that we can improve quality.", "So far, the project is going well.", "We need to update the website, documentation, and so on."]'::jsonb,
  collocations = '["so that", "so far", "and so on", "so + adjective"]'::jsonb,
  patterns = '["clause + so + clause (result)", "so that + clause (purpose)", "so + adjective/adverb"]'::jsonb,
  updated_at = now()
WHERE headword = 'so';

-- Conjunction: as
UPDATE lexicon_entries
SET
  ipa = 'æz',
  definition_simple = 'while something is happening or in the way that',
  definition_teacher = 'conjunction/preposition: highly versatile word expressing time, manner, reason, or comparison; neutral register',
  usage_notes = 'Versatile conjunction. In professional contexts: "as soon as", "as well as", "as expected", "work as" (role), "as a result". Very common in business. Multiple meanings: time, manner, reason, comparison, or role.',
  register = 'neutral',
  variety = 'international',
  examples = '["Please contact me as soon as possible.", "She works as a project manager.", "As expected, sales increased.", "We offer training as well as support."]'::jsonb,
  collocations = '["as soon as", "as well as", "as expected", "work as", "as a result"]'::jsonb,
  patterns = '["as + adjective + as (comparison)", "as + clause (time/reason)", "as + noun (role)"]'::jsonb,
  updated_at = now()
WHERE headword = 'as';

-- Conjunction: than
UPDATE lexicon_entries
SET
  ipa = 'ðæn',
  definition_simple = 'used to compare two things',
  definition_teacher = 'conjunction: introduces second element in comparisons; used with comparative adjectives and adverbs; neutral register',
  usage_notes = 'Comparison conjunction. In professional contexts: "more than", "less than", "better than", "rather than". Essential for comparisons. Note: "than" (comparison) vs "then" (time) - common spelling error.',
  register = 'neutral',
  variety = 'international',
  examples = '["This solution is better than the previous one.", "We have more than 100 employees.", "I would rather work from home than commute.", "Sales are higher than last year."]'::jsonb,
  collocations = '["more than", "less than", "better than", "rather than", "other than"]'::jsonb,
  patterns = '["comparative + than", "more/less + than + number"]'::jsonb,
  updated_at = now()
WHERE headword = 'than';

-- Conjunction: though
UPDATE lexicon_entries
SET
  ipa = 'ðəʊ',
  definition_simple = 'despite the fact that',
  definition_teacher = 'conjunction/adverb: introduces contrast or concession; similar to "although" but less formal; can appear at end of sentence as adverb; neutral register',
  usage_notes = 'Contrast conjunction. In professional contexts: "even though", "though...still", "as though". Common in business. Similar to "although" but can be used at end of sentence. Expresses contrast or concession.',
  register = 'neutral',
  variety = 'international',
  examples = '["Though the project was difficult, we completed it on time.", "We are making progress, though slowly.", "Even though we tried, we couldn''t meet the deadline.", "It looks as though we will succeed."]'::jsonb,
  collocations = '["even though", "as though", "though...still"]'::jsonb,
  patterns = '["though + clause", "clause + though (end position)", "even though + clause"]'::jsonb,
  updated_at = now()
WHERE headword = 'though';

-- Conjunction: although
UPDATE lexicon_entries
SET
  ipa = 'ɔːlˈðəʊ',
  definition_simple = 'despite the fact that',
  definition_teacher = 'conjunction: introduces contrast or concession; subordinating conjunction; more formal than "though"; neutral register',
  usage_notes = 'Contrast conjunction. In professional contexts: "although...still", used for concessions. More formal than "though". Cannot be used at end of sentence. Common in business writing for expressing contrasts.',
  register = 'neutral',
  variety = 'international',
  examples = '["Although sales decreased, profits remained stable.", "We will proceed, although there are risks.", "Although the deadline is tight, we can manage.", "The project succeeded although we faced challenges."]'::jsonb,
  collocations = '["although...still", "although + clause"]'::jsonb,
  patterns = '["although + clause, main clause", "main clause + although + clause"]'::jsonb,
  updated_at = now()
WHERE headword = 'although';

-- Conjunction: unless
UPDATE lexicon_entries
SET
  ipa = 'ənˈles',
  definition_simple = 'except if',
  definition_teacher = 'conjunction: introduces negative condition; means "if not" or "except if"; subordinating conjunction; neutral register',
  usage_notes = 'Negative condition conjunction. In professional contexts: "unless otherwise stated", "unless necessary", "unless you hear from me". Common in business. Means "if not" - expresses exception or negative condition.',
  register = 'neutral',
  variety = 'international',
  examples = '["We will proceed unless you object.", "Unless otherwise stated, the deadline is Friday.", "Don''t call unless it''s urgent.", "Unless we act now, we will miss the opportunity."]'::jsonb,
  collocations = '["unless otherwise stated", "unless necessary", "unless you hear from me"]'::jsonb,
  patterns = '["unless + clause", "main clause + unless + clause"]'::jsonb,
  updated_at = now()
WHERE headword = 'unless';

-- Conjunction: whether
UPDATE lexicon_entries
SET
  ipa = 'ˈweðər',
  definition_simple = 'if something is true or not',
  definition_teacher = 'conjunction: introduces indirect questions or alternatives; expresses uncertainty between options; neutral register',
  usage_notes = 'Alternative/uncertainty conjunction. In professional contexts: "whether or not", "whether...or", "decide whether". Common in business. Used for indirect questions and alternatives. Note: "whether" (if) vs "weather" (climate) - common confusion.',
  register = 'neutral',
  variety = 'international',
  examples = '["We need to decide whether to proceed.", "Please let me know whether you can attend.", "Whether or not we succeed depends on teamwork.", "I don''t know whether this is the right approach."]'::jsonb,
  collocations = '["whether or not", "whether...or", "decide whether", "know whether"]'::jsonb,
  patterns = '["whether + clause", "whether...or", "whether or not"]'::jsonb,
  updated_at = now()
WHERE headword = 'whether';

-- Conjunction: once
UPDATE lexicon_entries
SET
  ipa = 'wʌns',
  definition_simple = 'as soon as or after something happens',
  definition_teacher = 'conjunction/adverb: introduces time clause meaning "as soon as" or "after"; also means "one time"; neutral register',
  usage_notes = 'Time conjunction. In professional contexts: "once completed", "once you finish", "once a week" (frequency). Can mean "as soon as" (conjunction) or "one time" (adverb). Common in business for sequential actions.',
  register = 'neutral',
  variety = 'international',
  examples = '["Once you finish the report, please send it to me.", "We can start once everyone arrives.", "I check email once a day.", "Once the project is approved, we will begin."]'::jsonb,
  collocations = '["once completed", "once a week", "once you finish", "once again"]'::jsonb,
  patterns = '["once + clause (time)", "once + time period (frequency)"]'::jsonb,
  updated_at = now()
WHERE headword = 'once';

-- Conjunction: however
UPDATE lexicon_entries
SET
  ipa = 'haʊˈevər',
  definition_simple = 'despite what was just said',
  definition_teacher = 'adverb/conjunction: introduces contrast or opposition; more formal than "but"; typically used with semicolon or at start of sentence; neutral to formal register',
  usage_notes = 'Contrast connector. In professional contexts: very common in business writing for showing contrast. More formal than "but". Usually preceded by semicolon or period. Note: "however" (contrast) vs "how ever" (question intensifier).',
  register = 'neutral',
  variety = 'international',
  examples = '["Sales increased; however, costs also rose.", "However, we need to consider other factors.", "The project is challenging. However, we are making progress.", "We tried our best; however, we didn''t meet the deadline."]'::jsonb,
  collocations = '["however + comma", "; however,"]'::jsonb,
  patterns = '["clause; however, clause", "However, clause"]'::jsonb,
  updated_at = now()
WHERE headword = 'however';

-- Conjunction: therefore
UPDATE lexicon_entries
SET
  ipa = 'ˈðeəfɔːr',
  definition_simple = 'for that reason or as a result',
  definition_teacher = 'adverb/conjunction: introduces logical conclusion or result; formal connector; typically used with semicolon or at start of sentence; formal register',
  usage_notes = 'Result connector. In professional contexts: very common in business writing for showing logical conclusions. More formal than "so". Usually preceded by semicolon or period. Essential for formal business communication.',
  register = 'formal',
  variety = 'international',
  examples = '["The deadline is tight; therefore, we need to prioritize.", "Therefore, we recommend proceeding with the plan.", "Costs have increased. Therefore, we must adjust prices.", "The data is incomplete; therefore, we cannot make a decision."]'::jsonb,
  collocations = '["therefore + comma", "; therefore,", "and therefore"]'::jsonb,
  patterns = '["clause; therefore, clause", "Therefore, clause"]'::jsonb,
  updated_at = now()
WHERE headword = 'therefore';

-- ============================================================================
-- ADDITIONAL FUNCTION WORDS (20 words)
-- ============================================================================

-- Adverb: then
UPDATE lexicon_entries
SET
  ipa = 'ðen',
  definition_simple = 'at that time or next',
  definition_teacher = 'adverb: expresses time (past/future), sequence, or logical consequence; highly versatile; neutral register',
  usage_notes = 'Time/sequence adverb. In professional contexts: "and then", "by then", "since then", "if...then". Very common in business. Can express time, sequence, or logical result. Note: "then" (time) vs "than" (comparison) - common spelling error.',
  register = 'neutral',
  variety = 'international',
  examples = '["First, we analyze the data. Then, we make recommendations.", "I was working in marketing then.", "If you agree, then we can proceed.", "By then, the project will be complete."]'::jsonb,
  collocations = '["and then", "by then", "since then", "if...then", "back then"]'::jsonb,
  patterns = '["then + clause", "if...then", "by then"]'::jsonb,
  updated_at = now()
WHERE headword = 'then';

-- Adverb: now
UPDATE lexicon_entries
SET
  ipa = 'naʊ',
  definition_simple = 'at the present time',
  definition_teacher = 'adverb: expresses present moment or immediate time; also used as discourse marker; neutral register',
  usage_notes = 'Present time adverb. In professional contexts: "right now", "for now", "now that", "as of now". Very common in business. Can express present moment or introduce new topics. Also used as discourse marker: "Now, let''s discuss..."',
  register = 'neutral',
  variety = 'international',
  examples = '["I am in a meeting right now.", "For now, let''s focus on the main issues.", "Now that we have the data, we can decide.", "As of now, the project is on schedule."]'::jsonb,
  collocations = '["right now", "for now", "now that", "as of now", "from now on"]'::jsonb,
  patterns = '["now + clause", "right now", "now that + clause"]'::jsonb,
  updated_at = now()
WHERE headword = 'now';

-- Adverb: here
UPDATE lexicon_entries
SET
  ipa = 'hɪər',
  definition_simple = 'in this place',
  definition_teacher = 'adverb: expresses location at speaker''s position or in present context; opposite of "there"; neutral register',
  usage_notes = 'Location adverb. In professional contexts: "here is/are", "come here", "work here", "here and there". Very common in business. Refers to speaker''s location or present context. Note: "here" (place) vs "hear" (listen) - same pronunciation.',
  register = 'neutral',
  variety = 'international',
  examples = '["Here is the report you requested.", "I work here at the headquarters.", "Please come here for a moment.", "We have offices here and there around the world."]'::jsonb,
  collocations = '["here is/are", "come here", "work here", "here and there", "right here"]'::jsonb,
  patterns = '["here + is/are", "verb + here", "here + and + there"]'::jsonb,
  updated_at = now()
WHERE headword = 'here';

-- Adverb: there
UPDATE lexicon_entries
SET
  ipa = 'ðeər',
  definition_simple = 'in or at that place',
  definition_teacher = 'adverb: expresses location away from speaker or existence; also used in "there is/are" constructions; neutral register',
  usage_notes = 'Location/existence adverb. In professional contexts: "there is/are", "over there", "work there", "there and back". Very common in business. Can express location or introduce existence. Note: "there" (place/existence) vs "their" (possessive) vs "they''re" (they are).',
  register = 'neutral',
  variety = 'international',
  examples = '["There is a meeting at 3 PM.", "I used to work there.", "The office is over there.", "There are several options to consider."]'::jsonb,
  collocations = '["there is/are", "over there", "work there", "there and back", "out there"]'::jsonb,
  patterns = '["there + is/are", "verb + there", "over there"]'::jsonb,
  updated_at = now()
WHERE headword = 'there';

-- Adverb: where
UPDATE lexicon_entries
SET
  ipa = 'weər',
  definition_simple = 'in or at what place',
  definition_teacher = 'adverb/conjunction: asks about or introduces location; question word or relative pronoun; neutral register',
  usage_notes = 'Location question word. In professional contexts: "where is/are", "where to", "where possible", "the place where". Very common in business. Can ask questions or introduce relative clauses about location.',
  register = 'neutral',
  variety = 'international',
  examples = '["Where is the meeting room?", "This is where we work.", "I don''t know where to start.", "Where possible, we should reduce costs."]'::jsonb,
  collocations = '["where is/are", "where to", "where possible", "the place where"]'::jsonb,
  patterns = '["where + question", "where + clause (relative)"]'::jsonb,
  updated_at = now()
WHERE headword = 'where';

-- Adverb: why
UPDATE lexicon_entries
SET
  ipa = 'waɪ',
  definition_simple = 'for what reason',
  definition_teacher = 'adverb: asks about or introduces reason or purpose; question word or relative pronoun; neutral register',
  usage_notes = 'Reason question word. In professional contexts: "why not", "that''s why", "the reason why", "why don''t we". Very common in business. Can ask questions or introduce relative clauses about reasons.',
  register = 'neutral',
  variety = 'international',
  examples = '["Why is the project delayed?", "That''s why we need to change our approach.", "I understand why you are concerned.", "Why don''t we schedule a meeting?"]'::jsonb,
  collocations = '["why not", "that''s why", "the reason why", "why don''t we"]'::jsonb,
  patterns = '["why + question", "why + clause (relative)", "why not + suggestion"]'::jsonb,
  updated_at = now()
WHERE headword = 'why';

-- Adverb: how
UPDATE lexicon_entries
SET
  ipa = 'haʊ',
  definition_simple = 'in what way or by what means',
  definition_teacher = 'adverb: asks about or introduces manner, method, or degree; question word; neutral register',
  usage_notes = 'Manner question word. In professional contexts: "how to", "how much/many", "how about", "know how". Very common in business. Can ask questions about manner, method, or degree. Essential for instructions and suggestions.',
  register = 'neutral',
  variety = 'international',
  examples = '["How do you use this software?", "I know how to solve this problem.", "How much does it cost?", "How about we meet tomorrow?"]'::jsonb,
  collocations = '["how to", "how much/many", "how about", "know how", "how long"]'::jsonb,
  patterns = '["how + question", "how + to + infinitive", "how + adjective/adverb"]'::jsonb,
  updated_at = now()
WHERE headword = 'how';

-- Adverb: what
UPDATE lexicon_entries
SET
  ipa = 'wɒt',
  definition_simple = 'used to ask for information about something',
  definition_teacher = 'pronoun/determiner/adverb: asks about or introduces identity, nature, or selection; question word; neutral register',
  usage_notes = 'General question word. In professional contexts: "what is/are", "what about", "what if", "what kind of". Very common in business. Most versatile question word - asks about identity, nature, or selection.',
  register = 'neutral',
  variety = 'international',
  examples = '["What is your opinion?", "What about the budget?", "What if we try a different approach?", "What kind of experience do you have?"]'::jsonb,
  collocations = '["what is/are", "what about", "what if", "what kind of", "what else"]'::jsonb,
  patterns = '["what + question", "what + noun", "what + about/if"]'::jsonb,
  updated_at = now()
WHERE headword = 'what';

-- Adverb: which
UPDATE lexicon_entries
SET
  ipa = 'wɪtʃ',
  definition_simple = 'used to ask about or show a choice between things',
  definition_teacher = 'pronoun/determiner: asks about or introduces selection from defined set; question word or relative pronoun; neutral register',
  usage_notes = 'Selection question word. In professional contexts: "which one", "which option", "in which case". Common in business. Used for selection from known options. Can be question word or relative pronoun.',
  register = 'neutral',
  variety = 'international',
  examples = '["Which option do you prefer?", "I don''t know which one to choose.", "This is the approach which we recommend.", "In which case, we should proceed."]'::jsonb,
  collocations = '["which one", "which option", "in which case", "which means"]'::jsonb,
  patterns = '["which + noun + question", "which + clause (relative)"]'::jsonb,
  updated_at = now()
WHERE headword = 'which';

-- Pronoun: who
UPDATE lexicon_entries
SET
  ipa = 'huː',
  definition_simple = 'what person or people',
  definition_teacher = 'pronoun: asks about or introduces person''s identity; question word or relative pronoun for people; neutral register',
  usage_notes = 'Person question word. In professional contexts: "who is", "who knows", "the person who". Very common in business. Used for people only (not things). Can be question word or relative pronoun.',
  register = 'neutral',
  variety = 'international',
  examples = '["Who is responsible for this project?", "I know who can help us.", "The person who submitted the report did excellent work.", "Who knows the answer?"]'::jsonb,
  collocations = '["who is", "who knows", "the person who", "who else"]'::jsonb,
  patterns = '["who + question", "who + clause (relative)"]'::jsonb,
  updated_at = now()
WHERE headword = 'who';

-- Pronoun: whom
UPDATE lexicon_entries
SET
  ipa = 'huːm',
  definition_simple = 'used instead of who as the object of a verb or preposition',
  definition_teacher = 'pronoun: object form of "who"; used in formal contexts after prepositions or as object; formal register',
  usage_notes = 'Formal person pronoun. In professional contexts: "to whom", "with whom", "for whom". More formal than "who". Used as object, especially after prepositions. In modern English, "who" often replaces "whom" in informal contexts.',
  register = 'formal',
  variety = 'international',
  examples = '["To whom should I address this letter?", "With whom are you working on this project?", "The person to whom I spoke was very helpful.", "For whom is this report intended?"]'::jsonb,
  collocations = '["to whom", "with whom", "for whom", "of whom"]'::jsonb,
  patterns = '["preposition + whom", "whom + clause"]'::jsonb,
  updated_at = now()
WHERE headword = 'whom';

-- Pronoun: whose
UPDATE lexicon_entries
SET
  ipa = 'huːz',
  definition_simple = 'belonging to or connected with which person',
  definition_teacher = 'pronoun/determiner: asks about or indicates possession; possessive form of "who"; neutral register',
  usage_notes = 'Possessive question word. In professional contexts: "whose responsibility", "whose idea", "the person whose". Common in business. Used to ask about or indicate possession. Note: "whose" (possessive) vs "who''s" (who is).',
  register = 'neutral',
  variety = 'international',
  examples = '["Whose responsibility is this?", "I don''t know whose idea it was.", "The employee whose work was excellent received an award.", "Whose turn is it to present?"]'::jsonb,
  collocations = '["whose responsibility", "whose idea", "whose turn", "the person whose"]'::jsonb,
  patterns = '["whose + noun + question", "whose + clause (relative)"]'::jsonb,
  updated_at = now()
WHERE headword = 'whose';

-- Determiner: another
UPDATE lexicon_entries
SET
  ipa = 'əˈnʌðər',
  definition_simple = 'one more person or thing of the same type',
  definition_teacher = 'determiner/pronoun: indicates an additional one or a different one; combines "an" + "other"; neutral register',
  usage_notes = 'Additional/different determiner. In professional contexts: "another option", "another meeting", "one another" (each other). Very common in business. Can mean "one more" or "a different one". Used with singular countable nouns.',
  register = 'neutral',
  variety = 'international',
  examples = '["We need another meeting to discuss this.", "Let''s try another approach.", "Can I have another copy of the report?", "We help one another on the team."]'::jsonb,
  collocations = '["another option", "another meeting", "one another", "another way"]'::jsonb,
  patterns = '["another + singular noun", "one another"]'::jsonb,
  updated_at = now()
WHERE headword = 'another';

-- Determiner: other
UPDATE lexicon_entries
SET
  ipa = 'ˈʌðər',
  definition_simple = 'different from the one already mentioned',
  definition_teacher = 'determiner/pronoun: indicates different or additional items; used with plural or uncountable nouns; neutral register',
  usage_notes = 'Different/additional determiner. In professional contexts: "other options", "each other", "on the other hand", "other than". Very common in business. Used with plural nouns (unlike "another"). Can mean "different" or "additional".',
  register = 'neutral',
  variety = 'international',
  examples = '["We should consider other options.", "We work well with each other.", "On the other hand, this approach has benefits.", "Other than that, everything is fine."]'::jsonb,
  collocations = '["other options", "each other", "on the other hand", "other than", "other people"]'::jsonb,
  patterns = '["other + plural noun", "each other", "other than"]'::jsonb,
  updated_at = now()
WHERE headword = 'other';

-- Determiner: such
UPDATE lexicon_entries
SET
  ipa = 'sʌtʃ',
  definition_simple = 'of this or that kind',
  definition_teacher = 'determiner/pronoun: indicates type, degree, or example; used for emphasis or specification; neutral register',
  usage_notes = 'Type/degree determiner. In professional contexts: "such as" (examples), "such a" (emphasis), "as such" (therefore), "no such". Common in business. Used to indicate type, give examples, or emphasize degree.',
  register = 'neutral',
  variety = 'international',
  examples = '["We offer services such as consulting and training.", "This is such a great opportunity.", "As such, we need to act quickly.", "There is no such thing as a perfect solution."]'::jsonb,
  collocations = '["such as", "such a", "as such", "no such", "such that"]'::jsonb,
  patterns = '["such + as", "such + a + adjective + noun", "as such"]'::jsonb,
  updated_at = now()
WHERE headword = 'such';

-- Determiner: both
UPDATE lexicon_entries
SET
  ipa = 'bəʊθ',
  definition_simple = 'the two people or things',
  definition_teacher = 'determiner/pronoun: refers to two items together; emphasizes inclusion of both; used with plural verbs; neutral register',
  usage_notes = 'Two-item determiner. In professional contexts: "both...and", "both of", "both sides". Common in business. Refers to two items together. Takes plural verb. Used to emphasize inclusion of both items.',
  register = 'neutral',
  variety = 'international',
  examples = '["Both options are acceptable.", "We need both time and money.", "Both of the proposals are good.", "Let''s consider both sides of the issue."]'::jsonb,
  collocations = '["both...and", "both of", "both sides", "both ways"]'::jsonb,
  patterns = '["both + plural noun", "both...and", "both of + the"]'::jsonb,
  updated_at = now()
WHERE headword = 'both';

-- Determiner: either
UPDATE lexicon_entries
SET
  ipa = 'ˈaɪðər',
  definition_simple = 'one or the other of two things',
  definition_teacher = 'determiner/pronoun/conjunction: refers to one of two options; used with singular verbs; also used in "either...or" constructions; neutral register',
  usage_notes = 'Choice determiner. In professional contexts: "either...or", "either way", "either option". Common in business. Refers to one of two choices. Takes singular verb. Used for alternatives or in negative sentences (meaning "also").',
  register = 'neutral',
  variety = 'international',
  examples = '["Either option is acceptable.", "You can either call or email me.", "Either way, we need to decide soon.", "I don''t like it either. (negative)"]'::jsonb,
  collocations = '["either...or", "either way", "either option", "not...either"]'::jsonb,
  patterns = '["either + singular noun", "either...or", "not...either (negative)"]'::jsonb,
  updated_at = now()
WHERE headword = 'either';

-- Determiner: neither
UPDATE lexicon_entries
SET
  ipa = 'ˈnaɪðər',
  definition_simple = 'not one and not the other of two things',
  definition_teacher = 'determiner/pronoun/conjunction: refers to not either of two options; negative form of "either"; used with singular verbs; neutral register',
  usage_notes = 'Negative choice determiner. In professional contexts: "neither...nor", "neither option". Common in business. Refers to not either of two choices. Takes singular verb. Used for negative alternatives.',
  register = 'neutral',
  variety = 'international',
  examples = '["Neither option is ideal.", "Neither the manager nor the team was available.", "I like neither approach.", "Neither solution addresses the problem."]'::jsonb,
  collocations = '["neither...nor", "neither option", "neither one"]'::jsonb,
  patterns = '["neither + singular noun", "neither...nor", "neither + verb (singular)"]'::jsonb,
  updated_at = now()
WHERE headword = 'neither';

-- Pronoun: something
UPDATE lexicon_entries
SET
  ipa = 'ˈsʌmθɪŋ',
  definition_simple = 'a thing that is not known or not named',
  definition_teacher = 'pronoun: refers to an unspecified thing; used in affirmative sentences and questions; takes singular verb; neutral register',
  usage_notes = 'Indefinite pronoun. In professional contexts: "something else", "something like", "or something". Very common in business. Refers to unspecified thing. Used in affirmative and questions (use "anything" in negatives).',
  register = 'neutral',
  variety = 'international',
  examples = '["I need to tell you something.", "Is there something wrong?", "We need something else.", "The cost is $100 or something like that."]'::jsonb,
  collocations = '["something else", "something like", "or something", "something wrong"]'::jsonb,
  patterns = '["something + adjective", "something + else", "something + like"]'::jsonb,
  updated_at = now()
WHERE headword = 'something';

-- Pronoun: anything
UPDATE lexicon_entries
SET
  ipa = 'ˈeniθɪŋ',
  definition_simple = 'any thing or things',
  definition_teacher = 'pronoun: refers to any unspecified thing; used in questions, negatives, and conditionals; takes singular verb; neutral register',
  usage_notes = 'Indefinite pronoun. In professional contexts: "anything else", "if anything", "anything like". Very common in business. Used in questions, negatives, and conditionals. More general than "something".',
  register = 'neutral',
  variety = 'international',
  examples = '["Do you need anything else?", "I don''t have anything to add.", "If anything changes, let me know.", "Is there anything I can help with?"]'::jsonb,
  collocations = '["anything else", "if anything", "anything like", "anything wrong"]'::jsonb,
  patterns = '["anything + adjective", "anything + else", "if anything"]'::jsonb,
  updated_at = now()
WHERE headword = 'anything';

-- Pronoun: nothing
UPDATE lexicon_entries
SET
  ipa = 'ˈnʌθɪŋ',
  definition_simple = 'not anything',
  definition_teacher = 'pronoun: refers to not any thing; negative indefinite pronoun; takes singular verb; neutral register',
  usage_notes = 'Negative indefinite pronoun. In professional contexts: "nothing else", "nothing to do with", "for nothing". Common in business. Already negative - don''t use with "not". Takes singular verb.',
  register = 'neutral',
  variety = 'international',
  examples = '["There is nothing to worry about.", "Nothing has changed.", "I have nothing else to add.", "This has nothing to do with the project."]'::jsonb,
  collocations = '["nothing else", "nothing to do with", "for nothing", "nothing wrong"]'::jsonb,
  patterns = '["nothing + adjective", "nothing + else", "nothing + to + infinitive"]'::jsonb,
  updated_at = now()
WHERE headword = 'nothing';

-- Pronoun: everything
UPDATE lexicon_entries
SET
  ipa = 'ˈevriθɪŋ',
  definition_simple = 'all things',
  definition_teacher = 'pronoun: refers to all things; comprehensive indefinite pronoun; takes singular verb; neutral register',
  usage_notes = 'Comprehensive indefinite pronoun. In professional contexts: "everything else", "everything is", "everything possible". Very common in business. Refers to all things. Takes singular verb despite meaning "all things".',
  register = 'neutral',
  variety = 'international',
  examples = '["Everything is ready for the meeting.", "We tried everything possible.", "Is everything okay?", "Everything else can wait."]'::jsonb,
  collocations = '["everything else", "everything is", "everything possible", "everything okay"]'::jsonb,
  patterns = '["everything + singular verb", "everything + adjective", "everything + else"]'::jsonb,
  updated_at = now()
WHERE headword = 'everything';

-- Pronoun: someone
UPDATE lexicon_entries
SET
  ipa = 'ˈsʌmwʌn',
  definition_simple = 'a person who is not known or not named',
  definition_teacher = 'pronoun: refers to an unspecified person; used in affirmative sentences and questions; takes singular verb; neutral register',
  usage_notes = 'Indefinite person pronoun. In professional contexts: "someone else", "someone who", "or someone". Very common in business. Refers to unspecified person. Used in affirmative and questions (use "anyone" in negatives).',
  register = 'neutral',
  variety = 'international',
  examples = '["Someone needs to take responsibility.", "Is someone available to help?", "We need someone else for this task.", "Someone from the team will contact you."]'::jsonb,
  collocations = '["someone else", "someone who", "someone from", "or someone"]'::jsonb,
  patterns = '["someone + singular verb", "someone + else", "someone + who"]'::jsonb,
  updated_at = now()
WHERE headword = 'someone';

-- Pronoun: anyone
UPDATE lexicon_entries
SET
  ipa = 'ˈeniwʌn',
  definition_simple = 'any person',
  definition_teacher = 'pronoun: refers to any unspecified person; used in questions, negatives, and conditionals; takes singular verb; neutral register',
  usage_notes = 'Indefinite person pronoun. In professional contexts: "anyone else", "if anyone", "anyone who". Very common in business. Used in questions, negatives, and conditionals. More general than "someone".',
  register = 'neutral',
  variety = 'international',
  examples = '["Does anyone have questions?", "I don''t know anyone who can help.", "If anyone is interested, please contact me.", "Is anyone else available?"]'::jsonb,
  collocations = '["anyone else", "if anyone", "anyone who", "anyone available"]'::jsonb,
  patterns = '["anyone + singular verb", "anyone + else", "if anyone"]'::jsonb,
  updated_at = now()
WHERE headword = 'anyone';

-- Pronoun: no one
UPDATE lexicon_entries
SET
  ipa = 'ˈnəʊ wʌn',
  definition_simple = 'not any person',
  definition_teacher = 'pronoun: refers to not any person; negative indefinite pronoun; takes singular verb; can be written "no one" or "no-one"; neutral register',
  usage_notes = 'Negative indefinite person pronoun. In professional contexts: "no one else", "no one knows". Common in business. Already negative - don''t use with "not". Takes singular verb. Can be written "no one" or "no-one".',
  register = 'neutral',
  variety = 'international',
  examples = '["No one is available right now.", "No one knows the answer.", "No one else can do this.", "No one responded to the email."]'::jsonb,
  collocations = '["no one else", "no one knows", "no one is"]'::jsonb,
  patterns = '["no one + singular verb", "no one + else"]'::jsonb,
  updated_at = now()
WHERE headword = 'no one';

-- Pronoun: everyone
UPDATE lexicon_entries
SET
  ipa = 'ˈevriwʌn',
  definition_simple = 'all people',
  definition_teacher = 'pronoun: refers to all people; comprehensive indefinite pronoun; takes singular verb; neutral register',
  usage_notes = 'Comprehensive indefinite person pronoun. In professional contexts: "everyone else", "everyone is", "everyone who". Very common in business. Refers to all people. Takes singular verb despite meaning "all people".',
  register = 'neutral',
  variety = 'international',
  examples = '["Everyone is invited to the meeting.", "Everyone else has finished.", "Everyone who attended received a certificate.", "Is everyone ready?"]'::jsonb,
  collocations = '["everyone else", "everyone is", "everyone who", "everyone ready"]'::jsonb,
  patterns = '["everyone + singular verb", "everyone + else", "everyone + who"]'::jsonb,
  updated_at = now()
WHERE headword = 'everyone';

-- Adverb: somewhere
UPDATE lexicon_entries
SET
  ipa = 'ˈsʌmweər',
  definition_simple = 'in or to a place that is not known or not named',
  definition_teacher = 'adverb: refers to an unspecified place; used in affirmative sentences and questions; neutral register',
  usage_notes = 'Indefinite place adverb. In professional contexts: "somewhere else", "somewhere around", "or somewhere". Common in business. Refers to unspecified place. Used in affirmative and questions (use "anywhere" in negatives).',
  register = 'neutral',
  variety = 'international',
  examples = '["We need to meet somewhere.", "The file is somewhere on the server.", "Let''s go somewhere else.", "The cost is somewhere around $1000."]'::jsonb,
  collocations = '["somewhere else", "somewhere around", "or somewhere", "somewhere between"]'::jsonb,
  patterns = '["somewhere + else", "somewhere + around/between"]'::jsonb,
  updated_at = now()
WHERE headword = 'somewhere';

-- Adverb: anywhere
UPDATE lexicon_entries
SET
  ipa = 'ˈeniweər',
  definition_simple = 'in or to any place',
  definition_teacher = 'adverb: refers to any unspecified place; used in questions, negatives, and conditionals; neutral register',
  usage_notes = 'Indefinite place adverb. In professional contexts: "anywhere else", "anywhere in the world", "if anywhere". Common in business. Used in questions, negatives, and conditionals. More general than "somewhere".',
  register = 'neutral',
  variety = 'international',
  examples = '["Can we meet anywhere?", "I can''t find it anywhere.", "If you need help anywhere, let me know.", "We can work from anywhere."]'::jsonb,
  collocations = '["anywhere else", "anywhere in the world", "if anywhere", "from anywhere"]'::jsonb,
  patterns = '["anywhere + else", "from anywhere", "if anywhere"]'::jsonb,
  updated_at = now()
WHERE headword = 'anywhere';

-- Adverb: nowhere
UPDATE lexicon_entries
SET
  ipa = 'ˈnəʊweər',
  definition_simple = 'not in or to any place',
  definition_teacher = 'adverb: refers to not any place; negative indefinite place adverb; neutral register',
  usage_notes = 'Negative indefinite place adverb. In professional contexts: "nowhere else", "nowhere to be found", "get nowhere". Common in business. Already negative - don''t use with "not".',
  register = 'neutral',
  variety = 'international',
  examples = '["The document is nowhere to be found.", "We are getting nowhere with this approach.", "There is nowhere else to look.", "Nowhere in the report does it mention this."]'::jsonb,
  collocations = '["nowhere else", "nowhere to be found", "get nowhere", "nowhere near"]'::jsonb,
  patterns = '["nowhere + else", "nowhere + to + infinitive", "get nowhere"]'::jsonb,
  updated_at = now()
WHERE headword = 'nowhere';

-- Adverb: everywhere
UPDATE lexicon_entries
SET
  ipa = 'ˈevriweər',
  definition_simple = 'in or to all places',
  definition_teacher = 'adverb: refers to all places; comprehensive indefinite place adverb; neutral register',
  usage_notes = 'Comprehensive indefinite place adverb. In professional contexts: "everywhere else", "everywhere in the world". Common in business. Refers to all places.',
  register = 'neutral',
  variety = 'international',
  examples = '["We have offices everywhere.", "I looked everywhere for the file.", "Everywhere else is fully booked.", "Our products are available everywhere."]'::jsonb,
  collocations = '["everywhere else", "everywhere in the world", "look everywhere"]'::jsonb,
  patterns = '["everywhere + else", "everywhere + in"]'::jsonb,
  updated_at = now()
WHERE headword = 'everywhere';

-- ============================================================================
-- END OF BATCH 3
-- ============================================================================

-- Summary: This migration adds comprehensive linguistic data for ~100 A0 function words
-- Categories covered:
--   - Prepositions (25): in, on, at, to, from, with, for, about, by, up, down, out, off, over, under, through, between, among, during, before, after, until, since, into, onto, without, within
--   - Conjunctions (15): because, if, when, while, so, as, than, though, although, unless, whether, once, however, therefore
--   - Question words (8): then, now, here, there, where, why, how, what, which, who, whom, whose
--   - Determiners (6): another, other, such, both, either, neither
--   - Indefinite pronouns (12): something, anything, nothing, everything, someone, anyone, no one, everyone, somewhere, anywhere, nowhere, everywhere
-- Total: ~66 words (focused on high-frequency function words essential for A0 level)
