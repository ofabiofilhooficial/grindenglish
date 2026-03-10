-- Migration: Enhance GSL Vocabulary - Batch 1 (A0 Pronouns and Basic Verbs)
-- Description: Add comprehensive linguistic data for first 150 A0 words
-- Words: Pronouns, essential verbs, modal verbs
-- Target: ~150 A0 words (pronouns and basic verbs)

-- ============================================================================
-- PRONOUNS (14 words)
-- ============================================================================

-- Pronoun: I
UPDATE lexicon_entries
SET
  ipa = 'aɪ',
  definition_simple = 'the person who is speaking or writing',
  definition_teacher = 'pronoun: first person singular subject pronoun; refers to the speaker/writer in any context; always capitalized in English regardless of position in sentence; neutral register',
  usage_notes = 'Always capitalized in English. Used in both formal and informal contexts. In professional emails and reports, "I" is appropriate when expressing personal opinions or actions.',
  register = 'neutral',
  variety = 'international',
  examples = '["I am a software engineer.", "I work in São Paulo.", "I need to finish this report.", "I think this is a good idea."]'::jsonb,
  collocations = '[]'::jsonb,
  patterns = '["I + verb", "I + am/was + adjective/noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'I';

-- Pronoun: you
UPDATE lexicon_entries
SET
  ipa = 'juː',
  definition_simple = 'the person or people you are speaking or writing to',
  definition_teacher = 'pronoun: second person singular and plural subject/object pronoun; refers to the addressee(s); used for both formal and informal address in modern English; neutral register',
  usage_notes = 'English uses "you" for both singular and plural, unlike Portuguese "você/vocês". In professional contexts, "you" is polite and appropriate. Brazilian learners sometimes overuse "you" where passive voice would be more natural in formal writing.',
  register = 'neutral',
  variety = 'international',
  examples = '["You are the project manager.", "Can you send me the file?", "You need to sign this document.", "Are you available for a meeting?"]'::jsonb,
  collocations = '[]'::jsonb,
  patterns = '["you + verb", "you + are/were + adjective/noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'you';

-- Pronoun: he
UPDATE lexicon_entries
SET
  ipa = 'hiː',
  definition_simple = 'a male person or animal that was mentioned before',
  definition_teacher = 'pronoun: third person singular masculine subject pronoun; refers to a previously mentioned or contextually understood male person or animal; neutral register',
  usage_notes = 'Used for males and male animals. In professional contexts, use "he" when gender is known. Avoid assuming gender; use "they" as singular when gender is unknown or non-binary.',
  register = 'neutral',
  variety = 'international',
  examples = '["He is the CEO of the company.", "He works in the marketing department.", "He will attend the conference.", "He sent the email yesterday."]'::jsonb,
  collocations = '[]'::jsonb,
  patterns = '["he + verb", "he + is/was + adjective/noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'he';

-- Pronoun: she
UPDATE lexicon_entries
SET
  ipa = 'ʃiː',
  definition_simple = 'a female person or animal that was mentioned before',
  definition_teacher = 'pronoun: third person singular feminine subject pronoun; refers to a previously mentioned or contextually understood female person or animal; neutral register',
  usage_notes = 'Used for females and female animals. In professional contexts, use "she" when gender is known. Modern usage increasingly accepts singular "they" for unknown or non-binary gender.',
  register = 'neutral',
  variety = 'international',
  examples = '["She is the director of operations.", "She manages the team.", "She will present at the meeting.", "She graduated from university last year."]'::jsonb,
  collocations = '[]'::jsonb,
  patterns = '["she + verb", "she + is/was + adjective/noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'she';

-- Pronoun: it
UPDATE lexicon_entries
SET
  ipa = 'ɪt',
  definition_simple = 'a thing, animal, or situation that was mentioned before',
  definition_teacher = 'pronoun: third person singular neuter subject/object pronoun; refers to things, animals (when gender is unknown or irrelevant), situations, or ideas; also used for weather, time, and distance; neutral register',
  usage_notes = 'Used for objects, concepts, and animals. Also used in impersonal constructions: "It is important to...", "It takes time to...". Brazilian learners often omit "it" in sentences like "It is raining" (influenced by Portuguese "Está chovendo").',
  register = 'neutral',
  variety = 'international',
  examples = '["It is a good opportunity.", "The report is ready. It is on your desk.", "It is raining today.", "It takes two hours to get there."]'::jsonb,
  collocations = '[]'::jsonb,
  patterns = '["it + is/was + adjective", "it + verb", "it + takes/costs"]'::jsonb,
  updated_at = now()
WHERE headword = 'it';

-- Pronoun: we
UPDATE lexicon_entries
SET
  ipa = 'wiː',
  definition_simple = 'the speaker and one or more other people',
  definition_teacher = 'pronoun: first person plural subject pronoun; refers to the speaker plus one or more others; can be inclusive (including addressee) or exclusive (excluding addressee); neutral register',
  usage_notes = 'In professional contexts, "we" creates a sense of teamwork and shared responsibility. Common in business writing: "We recommend...", "We believe...". Can also be used for companies: "We offer excellent service."',
  register = 'neutral',
  variety = 'international',
  examples = '["We are working on the project.", "We need to meet the deadline.", "We offer training programs.", "We will discuss this tomorrow."]'::jsonb,
  collocations = '[]'::jsonb,
  patterns = '["we + verb", "we + are/were + adjective/noun", "we + need/want/can"]'::jsonb,
  updated_at = now()
WHERE headword = 'we';

-- Pronoun: they
UPDATE lexicon_entries
SET
  ipa = 'ðeɪ',
  definition_simple = 'people, animals, or things that were mentioned before',
  definition_teacher = 'pronoun: third person plural subject pronoun; refers to previously mentioned people, animals, or things; also used as singular pronoun for unknown or non-binary gender; neutral register',
  usage_notes = 'Used for plural referents and increasingly for singular non-binary or unknown gender. In professional writing, "they" is acceptable as singular: "Each employee should submit their report." This avoids the awkward "his or her".',
  register = 'neutral',
  variety = 'international',
  examples = '["They are our clients.", "The documents are ready. They are in the folder.", "They work in different departments.", "Someone left their phone here."]'::jsonb,
  collocations = '[]'::jsonb,
  patterns = '["they + verb", "they + are/were + adjective/noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'they';

-- Determiner: my
UPDATE lexicon_entries
SET
  ipa = 'maɪ',
  definition_simple = 'belonging to the person speaking',
  definition_teacher = 'determiner: first person singular possessive determiner; indicates possession or association by the speaker; precedes nouns; neutral register',
  usage_notes = 'Used before nouns to show possession. In professional contexts: "my team", "my manager", "my responsibilities". Brazilian learners sometimes confuse with "mine" (possessive pronoun used without a noun).',
  register = 'neutral',
  variety = 'international',
  examples = '["This is my office.", "My manager approved the request.", "I will send my report tomorrow.", "My team is working on the project."]'::jsonb,
  collocations = '["my team", "my manager", "my office", "my work", "my responsibility"]'::jsonb,
  patterns = '["my + noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'my';

-- Determiner: your
UPDATE lexicon_entries
SET
  ipa = 'jɔːr',
  definition_simple = 'belonging to the person you are speaking to',
  definition_teacher = 'determiner: second person singular and plural possessive determiner; indicates possession or association by the addressee(s); precedes nouns; neutral register',
  usage_notes = 'Used before nouns to show possession by the person addressed. Common in professional communication: "your request", "your team", "your feedback". Note: "your" (possessive) vs "you''re" (you are) - a common error.',
  register = 'neutral',
  variety = 'international',
  examples = '["Your presentation was excellent.", "I received your email.", "Your team did great work.", "What is your opinion?"]'::jsonb,
  collocations = '["your team", "your request", "your feedback", "your opinion", "your work"]'::jsonb,
  patterns = '["your + noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'your';

-- Determiner: his
UPDATE lexicon_entries
SET
  ipa = 'hɪz',
  definition_simple = 'belonging to a male person mentioned before',
  definition_teacher = 'determiner: third person singular masculine possessive determiner; indicates possession or association by a previously mentioned male; precedes nouns; neutral register',
  usage_notes = 'Used before nouns to show possession by a male person. In professional contexts: "his department", "his responsibilities". Note: "his" can be both determiner (his book) and pronoun (the book is his).',
  register = 'neutral',
  variety = 'international',
  examples = '["His office is on the third floor.", "I spoke with his assistant.", "His presentation was very clear.", "His team completed the project."]'::jsonb,
  collocations = '["his team", "his office", "his work", "his department"]'::jsonb,
  patterns = '["his + noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'his';

-- Determiner: her
UPDATE lexicon_entries
SET
  ipa = 'hɜːr',
  definition_simple = 'belonging to a female person mentioned before',
  definition_teacher = 'determiner: third person singular feminine possessive determiner; indicates possession or association by a previously mentioned female; precedes nouns; neutral register. Note: "her" also functions as object pronoun.',
  usage_notes = 'Used before nouns to show possession by a female person. In professional contexts: "her department", "her responsibilities". Note: "her" can be both determiner (her book) and object pronoun (I saw her).',
  register = 'neutral',
  variety = 'international',
  examples = '["Her presentation was impressive.", "I met with her team yesterday.", "Her office is next to mine.", "Her work is always excellent."]'::jsonb,
  collocations = '["her team", "her office", "her work", "her department"]'::jsonb,
  patterns = '["her + noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'her';

-- Determiner: our
UPDATE lexicon_entries
SET
  ipa = 'aʊər',
  definition_simple = 'belonging to the speaker and other people',
  definition_teacher = 'determiner: first person plural possessive determiner; indicates possession or association by the speaker and others; precedes nouns; neutral register',
  usage_notes = 'Used before nouns to show shared possession. Very common in business: "our company", "our team", "our goals". Creates sense of unity and shared ownership in professional communication.',
  register = 'neutral',
  variety = 'international',
  examples = '["Our company values innovation.", "Our team achieved the goals.", "This is our office building.", "Our meeting is at 2 PM."]'::jsonb,
  collocations = '["our company", "our team", "our goal", "our office", "our meeting"]'::jsonb,
  patterns = '["our + noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'our';

-- Determiner: their
UPDATE lexicon_entries
SET
  ipa = 'ðeər',
  definition_simple = 'belonging to people or things mentioned before',
  definition_teacher = 'determiner: third person plural possessive determiner; indicates possession or association by previously mentioned people or things; also used as singular for unknown/non-binary gender; precedes nouns; neutral register',
  usage_notes = 'Used before nouns to show possession by others. Also acceptable as singular: "Each employee should submit their report." Common error: confusing "their" (possessive), "there" (place/existence), and "they''re" (they are).',
  register = 'neutral',
  variety = 'international',
  examples = '["Their office is downtown.", "I reviewed their proposal.", "Their team won the award.", "Everyone should bring their laptop."]'::jsonb,
  collocations = '["their team", "their office", "their work", "their company"]'::jsonb,
  patterns = '["their + noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'their';

-- Pronoun: me
UPDATE lexicon_entries
SET
  ipa = 'miː',
  definition_simple = 'the person speaking (used as object)',
  definition_teacher = 'pronoun: first person singular object pronoun; used as direct object, indirect object, or object of preposition; refers to the speaker; neutral register',
  usage_notes = 'Used after verbs and prepositions. Common in professional requests: "Send me the file", "Contact me if you have questions". Brazilian learners sometimes confuse subject "I" with object "me" (e.g., "between you and I" should be "between you and me").',
  register = 'neutral',
  variety = 'international',
  examples = '["Please send me the report.", "Call me when you arrive.", "This is important to me.", "Let me know if you need help."]'::jsonb,
  collocations = '["send me", "tell me", "let me know", "contact me", "email me"]'::jsonb,
  patterns = '["verb + me", "preposition + me", "let me + verb"]'::jsonb,
  updated_at = now()
WHERE headword = 'me';

-- ============================================================================
-- ESSENTIAL VERBS (39 words)
-- ============================================================================

-- Verb: be
UPDATE lexicon_entries
SET
  ipa = 'biː',
  definition_simple = 'to exist or to have a quality',
  definition_teacher = 'verb: irregular copular verb; links subject to complement; expresses existence, identity, or state; forms: am/is/are (present), was/were (past), been (past participle); used in continuous tenses and passive voice; neutral register',
  usage_notes = 'Most fundamental English verb. Used for identity ("I am a teacher"), location ("The office is downtown"), and states ("She is happy"). Forms continuous tenses ("is working") and passive voice ("is done"). Brazilian learners often omit "be" in continuous tenses.',
  register = 'neutral',
  variety = 'international',
  examples = '["I am a project manager.", "The meeting is at 3 PM.", "They are working on the report.", "This document was approved yesterday."]'::jsonb,
  collocations = '["be able to", "be ready", "be available", "be responsible for"]'::jsonb,
  patterns = '["be + adjective", "be + noun", "be + present participle (continuous)", "be + past participle (passive)"]'::jsonb,
  updated_at = now()
WHERE headword = 'be';

-- Verb: have
UPDATE lexicon_entries
SET
  ipa = 'hæv',
  definition_simple = 'to own something or to experience something',
  definition_teacher = 'verb: irregular verb; expresses possession, relationships, experiences, or obligations; forms: have/has (present), had (past), had (past participle); also auxiliary verb for perfect tenses; neutral register',
  usage_notes = 'Used for possession ("I have a car"), experiences ("have a meeting"), and obligations ("have to work"). As auxiliary, forms perfect tenses ("have finished"). In professional contexts: "have a meeting", "have experience", "have to submit".',
  register = 'neutral',
  variety = 'international',
  examples = '["I have a meeting at 10 AM.", "She has five years of experience.", "We have to finish this today.", "They have completed the project."]'::jsonb,
  collocations = '["have a meeting", "have experience", "have time", "have to (obligation)", "have a question"]'::jsonb,
  patterns = '["have + noun", "have + to + infinitive (obligation)", "have + past participle (perfect tense)"]'::jsonb,
  updated_at = now()
WHERE headword = 'have';

-- Verb: do
UPDATE lexicon_entries
SET
  ipa = 'duː',
  definition_simple = 'to perform an action or activity',
  definition_teacher = 'verb: irregular verb; expresses action or performance; forms: do/does (present), did (past), done (past participle); also auxiliary verb for questions, negatives, and emphasis; neutral register',
  usage_notes = 'Main verb meaning "perform" ("do work", "do homework"). As auxiliary, forms questions ("Do you work here?") and negatives ("I don''t know"). In professional contexts: "do business", "do research", "do a presentation". Brazilian learners often confuse "do" with "make".',
  register = 'neutral',
  variety = 'international',
  examples = '["I do research for the company.", "What do you do? (job)", "She did a great presentation.", "We need to do this correctly."]'::jsonb,
  collocations = '["do work", "do business", "do research", "do a job", "do your best"]'::jsonb,
  patterns = '["do + noun", "do + auxiliary in questions/negatives"]'::jsonb,
  updated_at = now()
WHERE headword = 'do';

-- Verb: go
UPDATE lexicon_entries
SET
  ipa = 'ɡəʊ',
  definition_simple = 'to move from one place to another',
  definition_teacher = 'verb: irregular verb; expresses movement or departure; forms: go/goes (present), went (past), gone (past participle); used for physical movement and abstract progression; neutral register',
  usage_notes = 'Basic movement verb. In professional contexts: "go to a meeting", "go on a business trip", "go to the office". Also used for progression: "How is the project going?". Note: "go" + gerund for activities ("go shopping", "go swimming").',
  register = 'neutral',
  variety = 'international',
  examples = '["I go to the office every day.", "She went to the conference last week.", "Let''s go to the meeting room.", "The project is going well."]'::jsonb,
  collocations = '["go to work", "go to a meeting", "go on a trip", "go home", "go well"]'::jsonb,
  patterns = '["go + to + place", "go + on + noun", "go + gerund (activity)"]'::jsonb,
  updated_at = now()
WHERE headword = 'go';

-- Verb: come
UPDATE lexicon_entries
SET
  ipa = 'kʌm',
  definition_simple = 'to move toward the speaker or a place',
  definition_teacher = 'verb: irregular verb; expresses movement toward speaker or destination; forms: come/comes (present), came (past), come (past participle); opposite of "go"; neutral register',
  usage_notes = 'Movement toward speaker or reference point. In professional contexts: "come to the office", "come to a meeting", "come to an agreement". Brazilian learners sometimes confuse "come" and "go" - use "come" when moving toward the speaker''s location.',
  register = 'neutral',
  variety = 'international',
  examples = '["Please come to my office.", "She came to the meeting late.", "Can you come to work early tomorrow?", "We came to an agreement."]'::jsonb,
  collocations = '["come to work", "come to a meeting", "come to an agreement", "come back", "come from"]'::jsonb,
  patterns = '["come + to + place", "come + from + place", "come + back"]'::jsonb,
  updated_at = now()
WHERE headword = 'come';

-- Verb: get
UPDATE lexicon_entries
SET
  ipa = 'ɡet',
  definition_simple = 'to receive, obtain, or become',
  definition_teacher = 'verb: irregular verb; highly versatile with multiple meanings including receive, obtain, become, arrive; forms: get/gets (present), got (past), got/gotten (past participle - US); neutral register',
  usage_notes = 'Very common verb with many uses: receive ("get an email"), obtain ("get information"), become ("get tired"), arrive ("get home"). In professional contexts: "get feedback", "get approval", "get results". Brazilian learners often overuse "get" - sometimes more specific verbs are better.',
  register = 'neutral',
  variety = 'international',
  examples = '["I got your email this morning.", "Can you get me the report?", "She gets to work at 8 AM.", "We need to get approval first."]'::jsonb,
  collocations = '["get information", "get feedback", "get approval", "get results", "get to work"]'::jsonb,
  patterns = '["get + noun (receive)", "get + to + place (arrive)", "get + adjective (become)"]'::jsonb,
  updated_at = now()
WHERE headword = 'get';

-- Verb: make
UPDATE lexicon_entries
SET
  ipa = 'meɪk',
  definition_simple = 'to create or produce something',
  definition_teacher = 'verb: irregular verb; expresses creation, production, or causation; forms: make/makes (present), made (past), made (past participle); used for physical creation and abstract actions; neutral register',
  usage_notes = 'Used for creation and production. In professional contexts: "make a decision", "make a presentation", "make progress", "make changes". Brazilian learners often confuse "make" and "do" - generally "make" = create/produce, "do" = perform/execute.',
  register = 'neutral',
  variety = 'international',
  examples = '["We need to make a decision today.", "She made a great presentation.", "Let''s make some changes to the plan.", "They make high-quality products."]'::jsonb,
  collocations = '["make a decision", "make a presentation", "make progress", "make changes", "make a mistake"]'::jsonb,
  patterns = '["make + noun", "make + object + adjective (causative)"]'::jsonb,
  updated_at = now()
WHERE headword = 'make';

-- Verb: take
UPDATE lexicon_entries
SET
  ipa = 'teɪk',
  definition_simple = 'to get and carry something or to need time',
  definition_teacher = 'verb: irregular verb; expresses taking possession, removing, requiring time, or accepting; forms: take/takes (present), took (past), taken (past participle); highly versatile with many idiomatic uses; neutral register',
  usage_notes = 'Multiple meanings: physical taking ("take a document"), time required ("takes two hours"), participation ("take part"), responsibility ("take charge"). In professional contexts: "take notes", "take a break", "take responsibility", "take action".',
  register = 'neutral',
  variety = 'international',
  examples = '["Please take a seat.", "It takes 30 minutes to get there.", "I will take notes during the meeting.", "She took responsibility for the project."]'::jsonb,
  collocations = '["take notes", "take a break", "take time", "take responsibility", "take action"]'::jsonb,
  patterns = '["take + noun", "it takes + time", "take + part/place"]'::jsonb,
  updated_at = now()
WHERE headword = 'take';

-- Verb: give
UPDATE lexicon_entries
SET
  ipa = 'ɡɪv',
  definition_simple = 'to provide something to someone',
  definition_teacher = 'verb: irregular verb; expresses transfer or provision of something to someone; forms: give/gives (present), gave (past), given (past participle); ditransitive verb (can take two objects); neutral register',
  usage_notes = 'Used for transferring objects or information. In professional contexts: "give a presentation", "give feedback", "give permission", "give information". Can take two objects: "give someone something" or "give something to someone".',
  register = 'neutral',
  variety = 'international',
  examples = '["Please give me the report.", "She gave a presentation yesterday.", "Can you give me some feedback?", "I will give you the information tomorrow."]'::jsonb,
  collocations = '["give a presentation", "give feedback", "give information", "give permission", "give advice"]'::jsonb,
  patterns = '["give + someone + something", "give + something + to + someone", "give + noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'give';

-- Verb: see
UPDATE lexicon_entries
SET
  ipa = 'siː',
  definition_simple = 'to notice something with your eyes or to understand',
  definition_teacher = 'verb: irregular verb; expresses visual perception or understanding; forms: see/sees (present), saw (past), seen (past participle); not typically used in continuous tenses for perception; neutral register',
  usage_notes = 'Two main meanings: visual perception ("I see the building") and understanding ("I see what you mean"). In professional contexts: "see the results", "see a problem", "see you tomorrow" (meet). Note: not used in continuous for perception ("I see it" not "I am seeing it").',
  register = 'neutral',
  variety = 'international',
  examples = '["I see the problem now.", "Did you see the email I sent?", "Let''s see the results first.", "I will see you at the meeting."]'::jsonb,
  collocations = '["see the results", "see a problem", "see you (meet)", "see the difference"]'::jsonb,
  patterns = '["see + noun", "see + that clause", "see + wh-clause"]'::jsonb,
  updated_at = now()
WHERE headword = 'see';

-- Verb: know
UPDATE lexicon_entries
SET
  ipa = 'nəʊ',
  definition_simple = 'to have information about something or to be familiar with someone',
  definition_teacher = 'verb: irregular verb; expresses knowledge, familiarity, or awareness; forms: know/knows (present), knew (past), known (past participle); stative verb not typically used in continuous tenses; neutral register',
  usage_notes = 'Used for knowledge and familiarity. In professional contexts: "know the answer", "know how to do something", "know about a topic". Stative verb - not used in continuous ("I know" not "I am knowing"). Brazilian learners sometimes confuse "know" and "meet".',
  register = 'neutral',
  variety = 'international',
  examples = '["I know the answer to that question.", "Do you know how to use this software?", "She knows a lot about marketing.", "Let me know if you need help."]'::jsonb,
  collocations = '["know how to", "know about", "let someone know", "know the answer"]'::jsonb,
  patterns = '["know + noun", "know + how to + infinitive", "know + that clause", "know + about"]'::jsonb,
  updated_at = now()
WHERE headword = 'know';

-- Verb: want
UPDATE lexicon_entries
SET
  ipa = 'wɒnt',
  definition_simple = 'to have a desire for something',
  definition_teacher = 'verb: regular verb; expresses desire or wish; forms: want/wants (present), wanted (past), wanted (past participle); can be followed by noun or infinitive; neutral register',
  usage_notes = 'Expresses desire or need. In professional contexts, "would like" is often more polite than "want". Common patterns: "want something", "want to do something", "want someone to do something". Brazilian learners should note "want" is less formal than "would like" in business communication.',
  register = 'neutral',
  variety = 'international',
  examples = '["I want to improve my English.", "Do you want to join the meeting?", "She wants more information about the project.", "We want to finish this by Friday."]'::jsonb,
  collocations = '["want to know", "want to do", "want more information"]'::jsonb,
  patterns = '["want + noun", "want + to + infinitive", "want + someone + to + infinitive"]'::jsonb,
  updated_at = now()
WHERE headword = 'want';

-- Verb: need
UPDATE lexicon_entries
SET
  ipa = 'niːd',
  definition_simple = 'to require something or to have to do something',
  definition_teacher = 'verb: regular verb; expresses necessity or requirement; forms: need/needs (present), needed (past), needed (past participle); can be followed by noun or infinitive; neutral register',
  usage_notes = 'Expresses necessity or requirement. Very common in professional contexts: "need information", "need to finish", "need approval". Stronger than "want" - indicates necessity rather than desire. Can also be a noun ("a need for change").',
  register = 'neutral',
  variety = 'international',
  examples = '["I need your approval to proceed.", "We need to finish this report today.", "She needs more time to complete the task.", "Do you need any help?"]'::jsonb,
  collocations = '["need help", "need information", "need approval", "need time", "need to do"]'::jsonb,
  patterns = '["need + noun", "need + to + infinitive", "need + someone + to + infinitive"]'::jsonb,
  updated_at = now()
WHERE headword = 'need';

-- Verb: eat
UPDATE lexicon_entries
SET
  ipa = 'iːt',
  definition_simple = 'to put food in your mouth and swallow it',
  definition_teacher = 'verb: irregular verb; expresses consumption of food; forms: eat/eats (present), ate (past), eaten (past participle); basic daily activity verb; neutral register',
  usage_notes = 'Basic verb for consuming food. In professional contexts: "eat lunch", "eat breakfast", "eat together" (team building). Common in workplace discussions about breaks and meals. Note irregular past tense "ate" and past participle "eaten".',
  register = 'neutral',
  variety = 'international',
  examples = '["Let''s eat lunch together.", "I usually eat breakfast at home.", "We ate at a restaurant near the office.", "Have you eaten yet?"]'::jsonb,
  collocations = '["eat lunch", "eat breakfast", "eat dinner", "eat together"]'::jsonb,
  patterns = '["eat + meal", "eat + at + place"]'::jsonb,
  updated_at = now()
WHERE headword = 'eat';

-- Verb: drink
UPDATE lexicon_entries
SET
  ipa = 'drɪŋk',
  definition_simple = 'to take liquid into your mouth and swallow it',
  definition_teacher = 'verb: irregular verb; expresses consumption of liquids; forms: drink/drinks (present), drank (past), drunk (past participle); basic daily activity verb; neutral register',
  usage_notes = 'Basic verb for consuming liquids. In professional contexts: "drink coffee", "drink water", "have a drink" (social). Common in workplace discussions about breaks. Note irregular forms: drink-drank-drunk.',
  register = 'neutral',
  variety = 'international',
  examples = '["I drink coffee every morning.", "Would you like to drink something?", "We drank tea during the meeting.", "She drinks a lot of water."]'::jsonb,
  collocations = '["drink coffee", "drink water", "drink tea"]'::jsonb,
  patterns = '["drink + beverage"]'::jsonb,
  updated_at = now()
WHERE headword = 'drink';

-- Verb: sleep
UPDATE lexicon_entries
SET
  ipa = 'sliːp',
  definition_simple = 'to rest with your eyes closed and your mind not active',
  definition_teacher = 'verb: irregular verb; expresses the state of rest/unconsciousness; forms: sleep/sleeps (present), slept (past), slept (past participle); basic daily activity verb; neutral register',
  usage_notes = 'Basic verb for resting. In professional contexts, might discuss sleep in relation to work-life balance, jet lag, or shift work. Note: "sleep" (verb) vs "asleep" (adjective). Brazilian learners sometimes confuse "sleep" with "asleep".',
  register = 'neutral',
  variety = 'international',
  examples = '["I sleep seven hours every night.", "Did you sleep well?", "I couldn''t sleep because of the noise.", "She slept during the flight."]'::jsonb,
  collocations = '["sleep well", "sleep late", "sleep early"]'::jsonb,
  patterns = '["sleep + time duration", "sleep + adverb"]'::jsonb,
  updated_at = now()
WHERE headword = 'sleep';

-- Verb: work
UPDATE lexicon_entries
SET
  ipa = 'wɜːk',
  definition_simple = 'to do a job to earn money',
  definition_teacher = 'verb: regular verb; expresses employment, labor, or functioning; forms: work/works (present), worked (past), worked (past participle); can be intransitive or transitive; neutral register',
  usage_notes = 'Fundamental professional verb. Common patterns: "work at/for a company", "work in a field/department", "work on a project", "work with people". Brazilian learners often confuse prepositions: use "work at" for companies, "work in" for fields/locations, "work on" for projects.',
  register = 'neutral',
  variety = 'international',
  examples = '["I work at Microsoft.", "She works in the marketing department.", "We are working on a new project.", "He works from home twice a week."]'::jsonb,
  collocations = '["work at a company", "work in a field", "work on a project", "work with someone", "work from home"]'::jsonb,
  patterns = '["work + at/for + company", "work + in + field/location", "work + on + project", "work + with + person"]'::jsonb,
  updated_at = now()
WHERE headword = 'work';

-- Verb: live
UPDATE lexicon_entries
SET
  ipa = 'lɪv',
  definition_simple = 'to have your home in a place',
  definition_teacher = 'verb: regular verb; expresses residence or existence; forms: live/lives (present), lived (past), lived (past participle); used for location of residence; neutral register',
  usage_notes = 'Used for residence location. Common patterns: "live in a city/country", "live at an address", "live with someone". In professional contexts, might discuss where employees live for remote work or relocation. Note pronunciation: /lɪv/ (verb) vs /laɪv/ (adjective).',
  register = 'neutral',
  variety = 'international',
  examples = '["I live in São Paulo.", "She lives near the office.", "They live in a small apartment.", "Where do you live?"]'::jsonb,
  collocations = '["live in a city", "live near", "live with someone", "live alone"]'::jsonb,
  patterns = '["live + in + city/country", "live + at + address", "live + with + person", "live + near + place"]'::jsonb,
  updated_at = now()
WHERE headword = 'live';

-- Verb: like
UPDATE lexicon_entries
SET
  ipa = 'laɪk',
  definition_simple = 'to enjoy something or think something is good',
  definition_teacher = 'verb: regular verb; expresses preference or enjoyment; forms: like/likes (present), liked (past), liked (past participle); stative verb but can be used in continuous for temporary preferences; neutral register',
  usage_notes = 'Expresses preference or enjoyment. In professional contexts: "I would like" (polite request), "like working with", "like the idea". Note: "like" + gerund (I like working) or infinitive (I like to work) - both acceptable. "Would like" is more formal than "want".',
  register = 'neutral',
  variety = 'international',
  examples = '["I like working in a team.", "She likes the new office.", "Would you like some coffee?", "We like your proposal."]'::jsonb,
  collocations = '["would like", "like working", "like the idea"]'::jsonb,
  patterns = '["like + noun", "like + gerund", "like + to + infinitive", "would like + noun/to + infinitive"]'::jsonb,
  updated_at = now()
WHERE headword = 'like';

-- Verb: love
UPDATE lexicon_entries
SET
  ipa = 'lʌv',
  definition_simple = 'to have very strong feelings of affection or to enjoy something very much',
  definition_teacher = 'verb: regular verb; expresses strong affection or intense enjoyment; forms: love/loves (present), loved (past), loved (past participle); stronger than "like"; neutral register',
  usage_notes = 'Expresses strong positive feelings. In professional contexts, use carefully - "love" is strong. Better for enthusiasm about work: "I love this job", "love working here". For professional preferences, "really like" or "enjoy" may be more appropriate than "love".',
  register = 'neutral',
  variety = 'international',
  examples = '["I love my job.", "She loves working with international clients.", "We would love to collaborate with you.", "He loves solving complex problems."]'::jsonb,
  collocations = '["love working", "would love to", "love doing"]'::jsonb,
  patterns = '["love + noun", "love + gerund", "love + to + infinitive", "would love + to + infinitive"]'::jsonb,
  updated_at = now()
WHERE headword = 'love';

-- Verb: open
UPDATE lexicon_entries
SET
  ipa = 'əʊpən',
  definition_simple = 'to move something so it is not closed',
  definition_teacher = 'verb: regular verb; expresses action of making something accessible or not closed; forms: open/opens (present), opened (past), opened (past participle); can be transitive or intransitive; neutral register',
  usage_notes = 'Used for physical opening (doors, files) and abstract opening (accounts, businesses). In professional contexts: "open a file", "open an account", "open a meeting", "open for business". Can also be adjective ("the door is open").',
  register = 'neutral',
  variety = 'international',
  examples = '["Please open the document.", "The office opens at 8 AM.", "She opened a new account.", "Let''s open the meeting with introductions."]'::jsonb,
  collocations = '["open a file", "open an account", "open a meeting", "open for business"]'::jsonb,
  patterns = '["open + noun", "open + at + time"]'::jsonb,
  updated_at = now()
WHERE headword = 'open';

-- Verb: close
UPDATE lexicon_entries
SET
  ipa = 'kləʊz',
  definition_simple = 'to shut something or to end something',
  definition_teacher = 'verb: regular verb; expresses action of shutting or ending; forms: close/closes (present), closed (past), closed (past participle); opposite of "open"; can be transitive or intransitive; neutral register',
  usage_notes = 'Used for physical closing (doors, files) and abstract closing (accounts, deals, meetings). In professional contexts: "close a file", "close a deal", "close a meeting", "close an account". Note pronunciation: /kləʊz/ (verb) vs /kləʊs/ (adjective/adverb meaning near).',
  register = 'neutral',
  variety = 'international',
  examples = '["Please close the door.", "The office closes at 6 PM.", "We closed the deal yesterday.", "Let''s close the meeting now."]'::jsonb,
  collocations = '["close a deal", "close a meeting", "close an account", "close a file"]'::jsonb,
  patterns = '["close + noun", "close + at + time"]'::jsonb,
  updated_at = now()
WHERE headword = 'close';

-- Verb: sit
UPDATE lexicon_entries
SET
  ipa = 'sɪt',
  definition_simple = 'to be in a position with your bottom on a chair or the ground',
  definition_teacher = 'verb: irregular verb; expresses seated position or action of taking a seat; forms: sit/sits (present), sat (past), sat (past participle); intransitive verb; neutral register',
  usage_notes = 'Basic position verb. In professional contexts: "sit down" (take a seat), "sit in a meeting", "sit at a desk". Common invitation: "Please sit down" or "Please have a seat". Note: "sit" (be seated) vs "seat" (transitive - to place someone in a seat).',
  register = 'neutral',
  variety = 'international',
  examples = '["Please sit down.", "I sit at my desk all day.", "She sat in the meeting for two hours.", "Let''s sit and discuss this."]'::jsonb,
  collocations = '["sit down", "sit at a desk", "sit in a meeting"]'::jsonb,
  patterns = '["sit + down", "sit + at/on + place", "sit + in + meeting/class"]'::jsonb,
  updated_at = now()
WHERE headword = 'sit';

-- Verb: stand
UPDATE lexicon_entries
SET
  ipa = 'stænd',
  definition_simple = 'to be in an upright position on your feet',
  definition_teacher = 'verb: irregular verb; expresses upright position or action of rising; forms: stand/stands (present), stood (past), stood (past participle); can be intransitive or transitive; neutral register',
  usage_notes = 'Basic position verb. In professional contexts: "stand up" (rise), "stand for something" (represent), "stand by" (support). Common in presentations: "I''m standing here to present...". Also used figuratively: "stand for quality", "stand behind our products".',
  register = 'neutral',
  variety = 'international',
  examples = '["Please stand up.", "I stood in line for 20 minutes.", "Our company stands for innovation.", "She is standing by the door."]'::jsonb,
  collocations = '["stand up", "stand for", "stand by", "stand in line"]'::jsonb,
  patterns = '["stand + up", "stand + for + noun (represent)", "stand + by + noun (support)"]'::jsonb,
  updated_at = now()
WHERE headword = 'stand';

-- Verb: walk
UPDATE lexicon_entries
SET
  ipa = 'wɔːk',
  definition_simple = 'to move by putting one foot in front of the other',
  definition_teacher = 'verb: regular verb; expresses movement on foot; forms: walk/walks (present), walked (past), walked (past participle); basic movement verb; neutral register',
  usage_notes = 'Basic movement verb. In professional contexts: "walk to work", "walk to the meeting room", "walk through a process" (explain step by step). Also used figuratively: "walk through the presentation" means to go through it step by step.',
  register = 'neutral',
  variety = 'international',
  examples = '["I walk to work every day.", "Let''s walk to the conference room.", "She walked through the presentation.", "Can you walk me through this process?"]'::jsonb,
  collocations = '["walk to work", "walk through (explain)", "walk around"]'::jsonb,
  patterns = '["walk + to + place", "walk + through + noun (explain)"]'::jsonb,
  updated_at = now()
WHERE headword = 'walk';

-- Verb: run
UPDATE lexicon_entries
SET
  ipa = 'rʌn',
  definition_simple = 'to move very quickly on foot',
  definition_teacher = 'verb: irregular verb; expresses rapid movement or operation; forms: run/runs (present), ran (past), run (past participle); multiple meanings including movement, operation, and management; neutral register',
  usage_notes = 'Multiple meanings: physical running, operating ("run a program"), managing ("run a business"), functioning ("the system runs well"). In professional contexts: "run a company", "run a meeting", "run a test", "run smoothly". Very versatile verb.',
  register = 'neutral',
  variety = 'international',
  examples = '["She runs a successful business.", "Can you run this program?", "The meeting ran for two hours.", "The system is running smoothly."]'::jsonb,
  collocations = '["run a business", "run a meeting", "run a test", "run smoothly", "run a program"]'::jsonb,
  patterns = '["run + noun (manage)", "run + adverb (function)"]'::jsonb,
  updated_at = now()
WHERE headword = 'run';

-- Verb: buy
UPDATE lexicon_entries
SET
  ipa = 'baɪ',
  definition_simple = 'to get something by paying money',
  definition_teacher = 'verb: irregular verb; expresses purchase or acquisition through payment; forms: buy/buys (present), bought (past), bought (past participle); transitive verb; neutral register',
  usage_notes = 'Basic commercial verb. In professional contexts: "buy equipment", "buy services", "buy from a supplier". Note irregular past tense "bought". Brazilian learners sometimes confuse "buy" (purchase) with "by" (preposition) in writing.',
  register = 'neutral',
  variety = 'international',
  examples = '["We need to buy new equipment.", "She bought supplies for the office.", "The company buys from local suppliers.", "I bought this software last year."]'::jsonb,
  collocations = '["buy equipment", "buy from", "buy online"]'::jsonb,
  patterns = '["buy + noun", "buy + from + supplier"]'::jsonb,
  updated_at = now()
WHERE headword = 'buy';

-- Verb: pay
UPDATE lexicon_entries
SET
  ipa = 'peɪ',
  definition_simple = 'to give money for something',
  definition_teacher = 'verb: irregular verb; expresses giving money in exchange for goods/services or as compensation; forms: pay/pays (present), paid (past), paid (past participle); can be transitive or intransitive; neutral register',
  usage_notes = 'Used for giving money. In professional contexts: "pay for services", "pay employees", "pay attention" (idiom), "pay a bill". Common patterns: "pay someone", "pay for something", "pay by card/cash". Note: "pay attention" is a fixed expression meaning "focus".',
  register = 'neutral',
  variety = 'international',
  examples = '["We pay our employees monthly.", "Can you pay for this?", "She paid by credit card.", "Please pay attention to the details."]'::jsonb,
  collocations = '["pay for", "pay attention", "pay by card", "pay a bill", "pay employees"]'::jsonb,
  patterns = '["pay + someone", "pay + for + something", "pay + by + method", "pay attention"]'::jsonb,
  updated_at = now()
WHERE headword = 'pay';

-- Verb: call
UPDATE lexicon_entries
SET
  ipa = 'kɔːl',
  definition_simple = 'to telephone someone or to say something loudly',
  definition_teacher = 'verb: regular verb; expresses telephoning, naming, or summoning; forms: call/calls (present), called (past), called (past participle); multiple meanings; neutral register',
  usage_notes = 'Multiple meanings: telephone ("call someone"), name ("call it a success"), summon ("call a meeting"). In professional contexts: "call a client", "call a meeting", "call back" (return a call). Very common in business communication.',
  register = 'neutral',
  variety = 'international',
  examples = '["I will call you tomorrow.", "Let''s call a meeting for next week.", "She called the client this morning.", "Please call me back when you can."]'::jsonb,
  collocations = '["call someone", "call a meeting", "call back", "phone call"]'::jsonb,
  patterns = '["call + someone", "call + a meeting", "call + back"]'::jsonb,
  updated_at = now()
WHERE headword = 'call';

-- Verb: help
UPDATE lexicon_entries
SET
  ipa = 'help',
  definition_simple = 'to make it easier for someone to do something',
  definition_teacher = 'verb: regular verb; expresses assistance or support; forms: help/helps (present), helped (past), helped (past participle); can be followed by infinitive with or without "to"; neutral register',
  usage_notes = 'Expresses assistance. In professional contexts: "help someone with something", "help to improve", "can I help you?". Note: "help someone do something" or "help someone to do something" - both are correct. Very common in customer service and teamwork contexts.',
  register = 'neutral',
  variety = 'international',
  examples = '["Can I help you?", "She helped me with the report.", "This will help improve our results.", "Let me help you with that."]'::jsonb,
  collocations = '["help someone", "help with", "can I help you", "help improve"]'::jsonb,
  patterns = '["help + someone", "help + with + something", "help + (to) + infinitive"]'::jsonb,
  updated_at = now()
WHERE headword = 'help';

-- Verb: wait
UPDATE lexicon_entries
SET
  ipa = 'weɪt',
  definition_simple = 'to stay in a place until something happens or someone arrives',
  definition_teacher = 'verb: regular verb; expresses remaining in place or delaying action; forms: wait/waits (present), waited (past), waited (past participle); intransitive verb typically followed by "for"; neutral register',
  usage_notes = 'Expresses staying or delaying. In professional contexts: "wait for approval", "wait for a response", "wait a moment". Common pattern: "wait for someone/something". Note: "wait" (stay) vs "expect" (anticipate) - Brazilian learners sometimes confuse these.',
  register = 'neutral',
  variety = 'international',
  examples = '["Please wait a moment.", "I am waiting for approval.", "She waited for the meeting to start.", "We are waiting for your response."]'::jsonb,
  collocations = '["wait for", "wait a moment", "wait for approval", "wait for a response"]'::jsonb,
  patterns = '["wait + for + noun", "wait + time expression"]'::jsonb,
  updated_at = now()
WHERE headword = 'wait';

-- Verb: listen
UPDATE lexicon_entries
SET
  ipa = 'lɪsən',
  definition_simple = 'to pay attention to sounds or to what someone says',
  definition_teacher = 'verb: regular verb; expresses active attention to sound or speech; forms: listen/listens (present), listened (past), listened (past participle); intransitive verb typically followed by "to"; neutral register',
  usage_notes = 'Expresses active attention to sound. In professional contexts: "listen to feedback", "listen carefully", "listen to the presentation". Note: "listen" (active attention) vs "hear" (passive perception). Always use "listen to" not just "listen".',
  register = 'neutral',
  variety = 'international',
  examples = '["Please listen carefully.", "I listened to the presentation.", "We need to listen to customer feedback.", "Are you listening to me?"]'::jsonb,
  collocations = '["listen to", "listen carefully", "listen to feedback"]'::jsonb,
  patterns = '["listen + to + noun", "listen + adverb"]'::jsonb,
  updated_at = now()
WHERE headword = 'listen';

-- Verb: read
UPDATE lexicon_entries
SET
  ipa = 'riːd',
  definition_simple = 'to look at words and understand them',
  definition_teacher = 'verb: irregular verb; expresses understanding written text; forms: read/reads (present), read (past - pronounced /red/), read (past participle - pronounced /red/); transitive verb; neutral register',
  usage_notes = 'Basic literacy verb. In professional contexts: "read a report", "read an email", "read the instructions". Note: present tense "read" /riːd/ vs past tense "read" /red/ - same spelling, different pronunciation. Very common in business communication.',
  register = 'neutral',
  variety = 'international',
  examples = '["Please read this document.", "I read your email this morning.", "She reads all the reports carefully.", "Have you read the instructions?"]'::jsonb,
  collocations = '["read a report", "read an email", "read carefully", "read the instructions"]'::jsonb,
  patterns = '["read + noun", "read + adverb"]'::jsonb,
  updated_at = now()
WHERE headword = 'read';

-- Verb: write
UPDATE lexicon_entries
SET
  ipa = 'raɪt',
  definition_simple = 'to make letters or words on paper or a screen',
  definition_teacher = 'verb: irregular verb; expresses creating written text; forms: write/writes (present), wrote (past), written (past participle); transitive verb; neutral register',
  usage_notes = 'Basic literacy verb. In professional contexts: "write a report", "write an email", "write code", "write a proposal". Very common in business communication. Note irregular forms: write-wrote-written. Brazilian learners sometimes confuse "write" with "right" in pronunciation.',
  register = 'neutral',
  variety = 'international',
  examples = '["I need to write a report.", "She wrote an excellent proposal.", "Can you write this down?", "He writes code for the application."]'::jsonb,
  collocations = '["write a report", "write an email", "write code", "write down"]'::jsonb,
  patterns = '["write + noun", "write + to + someone", "write + down"]'::jsonb,
  updated_at = now()
WHERE headword = 'write';

-- Verb: speak
UPDATE lexicon_entries
SET
  ipa = 'spiːk',
  definition_simple = 'to say words or to talk',
  definition_teacher = 'verb: irregular verb; expresses oral communication; forms: speak/speaks (present), spoke (past), spoken (past participle); can be transitive or intransitive; neutral register',
  usage_notes = 'Expresses oral communication. In professional contexts: "speak English", "speak to someone", "speak at a conference", "speak up" (express opinion). Note: "speak" is often more formal than "talk". Common in business: "speak with a client", "speak at a meeting".',
  register = 'neutral',
  variety = 'international',
  examples = '["I speak English and Portuguese.", "Can I speak to the manager?", "She spoke at the conference.", "Please speak more slowly."]'::jsonb,
  collocations = '["speak English", "speak to someone", "speak at", "speak up"]'::jsonb,
  patterns = '["speak + language", "speak + to/with + someone", "speak + at + event"]'::jsonb,
  updated_at = now()
WHERE headword = 'speak';

-- Verb: say
UPDATE lexicon_entries
SET
  ipa = 'seɪ',
  definition_simple = 'to speak words',
  definition_teacher = 'verb: irregular verb; expresses uttering specific words; forms: say/says (present), said (past), said (past participle); transitive verb; neutral register',
  usage_notes = 'Expresses speaking specific words. In professional contexts: "say something", "say yes/no", "say that...". Note: "say" (specific words) vs "tell" (inform someone). Common error: "say to someone" should be "tell someone" or "say to someone that...". Use "say" for the words, "tell" for the person.',
  register = 'neutral',
  variety = 'international',
  examples = '["What did you say?", "She said yes to the proposal.", "I want to say something.", "He said that he would come."]'::jsonb,
  collocations = '["say something", "say yes/no", "say that"]'::jsonb,
  patterns = '["say + noun", "say + that clause", "say + to + someone + that"]'::jsonb,
  updated_at = now()
WHERE headword = 'say';

-- Verb: tell
UPDATE lexicon_entries
SET
  ipa = 'tel',
  definition_simple = 'to give information to someone by speaking or writing',
  definition_teacher = 'verb: irregular verb; expresses informing or instructing; forms: tell/tells (present), told (past), told (past participle); ditransitive verb (takes two objects); neutral register',
  usage_notes = 'Expresses giving information. In professional contexts: "tell someone something", "tell someone to do something", "tell the truth". Note: "tell" (inform a person) vs "say" (utter words). Pattern: "tell someone something" not "tell to someone". Very common in instructions and reporting.',
  register = 'neutral',
  variety = 'international',
  examples = '["Please tell me the answer.", "She told him to finish the report.", "I will tell you tomorrow.", "Can you tell me how to do this?"]'::jsonb,
  collocations = '["tell someone", "tell the truth", "tell someone to do"]'::jsonb,
  patterns = '["tell + someone + something", "tell + someone + to + infinitive", "tell + someone + that clause"]'::jsonb,
  updated_at = now()
WHERE headword = 'tell';

-- Verb: ask
UPDATE lexicon_entries
SET
  ipa = 'ɑːsk',
  definition_simple = 'to say a question or to request something',
  definition_teacher = 'verb: regular verb; expresses questioning or requesting; forms: ask/asks (present), asked (past), asked (past participle); can be transitive or intransitive; neutral register',
  usage_notes = 'Expresses questions or requests. In professional contexts: "ask a question", "ask for information", "ask someone to do something". Common patterns: "ask someone something", "ask for something", "ask someone to do something". Very common in business communication.',
  register = 'neutral',
  variety = 'international',
  examples = '["Can I ask a question?", "She asked for more information.", "I will ask him to send the file.", "Please ask if you need help."]'::jsonb,
  collocations = '["ask a question", "ask for", "ask someone to do"]'::jsonb,
  patterns = '["ask + question", "ask + for + something", "ask + someone + to + infinitive"]'::jsonb,
  updated_at = now()
WHERE headword = 'ask';

-- Verb: answer
UPDATE lexicon_entries
SET
  ipa = 'ɑːnsər',
  definition_simple = 'to say or write something when someone asks you a question',
  definition_teacher = 'verb: regular verb; expresses responding to questions or communications; forms: answer/answers (present), answered (past), answered (past participle); can be transitive or intransitive; neutral register',
  usage_notes = 'Expresses responding. In professional contexts: "answer a question", "answer an email", "answer the phone". Can be used with or without object: "I answered" or "I answered the question". Also a noun: "the answer to the question".',
  register = 'neutral',
  variety = 'international',
  examples = '["Please answer my question.", "She answered the email quickly.", "I will answer the phone.", "Can you answer this?"]'::jsonb,
  collocations = '["answer a question", "answer an email", "answer the phone"]'::jsonb,
  patterns = '["answer + noun", "answer + to + someone"]'::jsonb,
  updated_at = now()
WHERE headword = 'answer';

-- ============================================================================
-- MODAL VERBS (3 words)
-- ============================================================================

-- Modal verb: can
UPDATE lexicon_entries
SET
  ipa = 'kæn',
  definition_simple = 'to be able to do something',
  definition_teacher = 'modal verb: expresses ability, possibility, or permission; forms: can (present), could (past/conditional); followed by bare infinitive; no -s in third person; neutral register',
  usage_notes = 'Expresses ability, possibility, or permission. In professional contexts: "can do something" (ability), "can I...?" (permission/request), "you can..." (possibility). Very common in business communication. Note: "can" for ability, "may" for formal permission.',
  register = 'neutral',
  variety = 'international',
  examples = '["I can speak English.", "Can you send me the file?", "We can meet tomorrow.", "You can find the document here."]'::jsonb,
  collocations = '["can do", "can you", "can I"]'::jsonb,
  patterns = '["can + bare infinitive", "can + subject + verb (questions)"]'::jsonb,
  updated_at = now()
WHERE headword = 'can';

-- Modal verb: will
UPDATE lexicon_entries
SET
  ipa = 'wɪl',
  definition_simple = 'used to talk about the future',
  definition_teacher = 'modal verb: expresses future time, willingness, or prediction; forms: will (present/future), would (past/conditional); followed by bare infinitive; no -s in third person; neutral register',
  usage_notes = 'Primary future marker in English. In professional contexts: "will do something" (future), "will you...?" (request), "I will..." (promise/offer). Very common in business communication for commitments and predictions. Contracted form: "I''ll", "you''ll", etc.',
  register = 'neutral',
  variety = 'international',
  examples = '["I will send the report tomorrow.", "The meeting will start at 2 PM.", "Will you attend the conference?", "This will improve our results."]'::jsonb,
  collocations = '["will be", "will do", "will have"]'::jsonb,
  patterns = '["will + bare infinitive", "will + subject + verb (questions)"]'::jsonb,
  updated_at = now()
WHERE headword = 'will';

-- Modal verb: would
UPDATE lexicon_entries
SET
  ipa = 'wʊd',
  definition_simple = 'used to talk about something that might happen or to make polite requests',
  definition_teacher = 'modal verb: expresses conditional situations, past habits, or polite requests; past form of "will"; followed by bare infinitive; no -s in third person; neutral register',
  usage_notes = 'Multiple uses: polite requests ("Would you...?"), conditional ("I would if..."), past habits ("I would go there"). In professional contexts, "would" is more polite than "will" for requests: "Would you send me..." vs "Will you send me...". Very common in formal business communication.',
  register = 'neutral',
  variety = 'international',
  examples = '["Would you send me the file?", "I would like to schedule a meeting.", "That would be great.", "I would appreciate your help."]'::jsonb,
  collocations = '["would like", "would you", "would be", "would appreciate"]'::jsonb,
  patterns = '["would + bare infinitive", "would + subject + verb (questions)", "would like + to + infinitive"]'::jsonb,
  updated_at = now()
WHERE headword = 'would';

-- ============================================================================
-- COLORS (6 words)
-- ============================================================================

-- Color: black
UPDATE lexicon_entries
SET
  ipa = 'blæk',
  definition_simple = 'the darkest color, like the night sky',
  definition_teacher = 'adjective/noun: describes or names the darkest color, absence of light; can be used attributively or predicatively; neutral register',
  usage_notes = 'Basic color word. In professional contexts: "black text", "black and white" (clear/simple), "in the black" (profitable). Can be adjective ("black car") or noun ("dressed in black"). Also used figuratively: "black market", "blacklist".',
  register = 'neutral',
  variety = 'international',
  examples = '["The text is in black.", "She wore a black suit to the interview.", "The company is in the black this year.", "Please print in black and white."]'::jsonb,
  collocations = '["black and white", "in the black (profitable)"]'::jsonb,
  patterns = '["black + noun", "in black"]'::jsonb,
  updated_at = now()
WHERE headword = 'black';

-- Color: white
UPDATE lexicon_entries
SET
  ipa = 'waɪt',
  definition_simple = 'the lightest color, like snow or milk',
  definition_teacher = 'adjective/noun: describes or names the lightest color, presence of all light; can be used attributively or predicatively; neutral register',
  usage_notes = 'Basic color word. In professional contexts: "white paper" (authoritative report), "white collar" (office work). Can be adjective ("white shirt") or noun ("dressed in white"). Common in business: "white paper", "whiteboard".',
  register = 'neutral',
  variety = 'international',
  examples = '["The walls are white.", "He wore a white shirt.", "We published a white paper on the topic.", "Write it on the whiteboard."]'::jsonb,
  collocations = '["white paper", "white collar", "whiteboard"]'::jsonb,
  patterns = '["white + noun", "in white"]'::jsonb,
  updated_at = now()
WHERE headword = 'white';

-- Color: red
UPDATE lexicon_entries
SET
  ipa = 'red',
  definition_simple = 'the color of blood or fire',
  definition_teacher = 'adjective/noun: describes or names the color of blood; can be used attributively or predicatively; neutral register',
  usage_notes = 'Basic color word. In professional contexts: "in the red" (losing money), "red flag" (warning sign), "red tape" (bureaucracy). Can be adjective ("red car") or noun ("dressed in red"). Often indicates warning or danger in business contexts.',
  register = 'neutral',
  variety = 'international',
  examples = '["The logo is red and blue.", "This is a red flag for investors.", "The company is in the red.", "Click the red button."]'::jsonb,
  collocations = '["in the red (losing money)", "red flag (warning)", "red tape (bureaucracy)"]'::jsonb,
  patterns = '["red + noun", "in the red"]'::jsonb,
  updated_at = now()
WHERE headword = 'red';

-- Color: blue
UPDATE lexicon_entries
SET
  ipa = 'bluː',
  definition_simple = 'the color of the sky on a clear day',
  definition_teacher = 'adjective/noun: describes or names the color of clear sky; can be used attributively or predicatively; neutral register',
  usage_notes = 'Basic color word. In professional contexts: "blue chip" (reliable investment), "blue collar" (manual work), "out of the blue" (unexpected). Can be adjective ("blue shirt") or noun ("dressed in blue").',
  register = 'neutral',
  variety = 'international',
  examples = '["The company logo is blue.", "He wore a blue tie.", "This is a blue chip stock.", "The email came out of the blue."]'::jsonb,
  collocations = '["blue chip", "blue collar", "out of the blue"]'::jsonb,
  patterns = '["blue + noun", "in blue"]'::jsonb,
  updated_at = now()
WHERE headword = 'blue';

-- Color: green
UPDATE lexicon_entries
SET
  ipa = 'ɡriːn',
  definition_simple = 'the color of grass and leaves',
  definition_teacher = 'adjective/noun: describes or names the color of vegetation; can be used attributively or predicatively; neutral register',
  usage_notes = 'Basic color word. In professional contexts: "green light" (approval), "green technology" (environmentally friendly), "green" (environmentally conscious). Can be adjective ("green car") or noun ("dressed in green"). Increasingly used for environmental topics.',
  register = 'neutral',
  variety = 'international',
  examples = '["The company focuses on green technology.", "We got the green light for the project.", "The logo has green and blue.", "They have green initiatives."]'::jsonb,
  collocations = '["green light (approval)", "green technology", "go green"]'::jsonb,
  patterns = '["green + noun", "go green"]'::jsonb,
  updated_at = now()
WHERE headword = 'green';

-- Color: yellow
UPDATE lexicon_entries
SET
  ipa = 'jeləʊ',
  definition_simple = 'the color of the sun or a lemon',
  definition_teacher = 'adjective/noun: describes or names the color of sunlight; can be used attributively or predicatively; neutral register',
  usage_notes = 'Basic color word. In professional contexts: "yellow pages" (business directory), "yellow flag" (caution). Can be adjective ("yellow car") or noun ("dressed in yellow"). Less common in business idioms than other colors.',
  register = 'neutral',
  variety = 'international',
  examples = '["The warning sign is yellow.", "She wore a yellow dress.", "Highlight it in yellow.", "The yellow icon indicates caution."]'::jsonb,
  collocations = '[]'::jsonb,
  patterns = '["yellow + noun", "in yellow"]'::jsonb,
  updated_at = now()
WHERE headword = 'yellow';

-- ============================================================================
-- NUMBERS (12 words)
-- ============================================================================

-- Number: one
UPDATE lexicon_entries
SET
  ipa = 'wʌn',
  definition_simple = 'the number 1',
  definition_teacher = 'number/determiner/pronoun: represents the quantity 1; can function as determiner, pronoun, or noun; neutral register',
  usage_notes = 'Basic number. In professional contexts: "one option", "one of the best", "number one priority". Can be determiner ("one person"), pronoun ("this one"), or noun ("the number one"). Also used in phrases: "one by one", "one another".',
  register = 'neutral',
  variety = 'international',
  examples = '["This is our number one priority.", "One of the team members is absent.", "We have one meeting today.", "Let''s discuss them one by one."]'::jsonb,
  collocations = '["number one", "one of", "one by one", "one another"]'::jsonb,
  patterns = '["one + noun", "one of + plural noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'one';

-- Number: two
UPDATE lexicon_entries
SET
  ipa = 'tuː',
  definition_simple = 'the number 2',
  definition_teacher = 'number/determiner: represents the quantity 2; can function as determiner or noun; neutral register',
  usage_notes = 'Basic number. In professional contexts: "two options", "two weeks", "in two days". Used for counting and quantities. Note pronunciation: "two" /tuː/ sounds like "too" and "to" - common confusion for learners.',
  register = 'neutral',
  variety = 'international',
  examples = '["We have two options.", "The meeting is in two days.", "I need two copies of this document.", "There are two ways to do this."]'::jsonb,
  collocations = '["two weeks", "two days", "two options"]'::jsonb,
  patterns = '["two + noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'two';

-- Number: three
UPDATE lexicon_entries
SET
  ipa = 'θriː',
  definition_simple = 'the number 3',
  definition_teacher = 'number/determiner: represents the quantity 3; can function as determiner or noun; neutral register',
  usage_notes = 'Basic number. In professional contexts: "three options", "three months", "in three days". Used for counting and quantities. Note pronunciation: /θriː/ - the "th" sound can be challenging for Brazilian learners.',
  register = 'neutral',
  variety = 'international',
  examples = '["We have three meetings today.", "The project takes three months.", "There are three departments.", "I need three volunteers."]'::jsonb,
  collocations = '["three months", "three days", "three times"]'::jsonb,
  patterns = '["three + noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'three';

-- Number: four
UPDATE lexicon_entries
SET
  ipa = 'fɔːr',
  definition_simple = 'the number 4',
  definition_teacher = 'number/determiner: represents the quantity 4; can function as determiner or noun; neutral register',
  usage_notes = 'Basic number. In professional contexts: "four quarters", "four weeks", "four options". Used for counting and quantities. Common in business: "four quarters" (fiscal year divisions).',
  register = 'neutral',
  variety = 'international',
  examples = '["The fiscal year has four quarters.", "We need four people for this team.", "The meeting lasts four hours.", "There are four steps in the process."]'::jsonb,
  collocations = '["four quarters", "four weeks"]'::jsonb,
  patterns = '["four + noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'four';

-- Number: five
UPDATE lexicon_entries
SET
  ipa = 'faɪv',
  definition_simple = 'the number 5',
  definition_teacher = 'number/determiner: represents the quantity 5; can function as determiner or noun; neutral register',
  usage_notes = 'Basic number. In professional contexts: "five days", "five years", "five options". Used for counting and quantities. Common in work schedules: "nine to five" (standard work hours).',
  register = 'neutral',
  variety = 'international',
  examples = '["I work five days a week.", "The project takes five months.", "We have five team members.", "The office is open from nine to five."]'::jsonb,
  collocations = '["five days", "nine to five"]'::jsonb,
  patterns = '["five + noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'five';

-- Number: six
UPDATE lexicon_entries
SET
  ipa = 'sɪks',
  definition_simple = 'the number 6',
  definition_teacher = 'number/determiner: represents the quantity 6; can function as determiner or noun; neutral register',
  usage_notes = 'Basic number. In professional contexts: "six months", "six weeks", "six people". Used for counting and quantities.',
  register = 'neutral',
  variety = 'international',
  examples = '["The contract is for six months.", "We have six offices worldwide.", "The meeting is at six PM.", "There are six items on the agenda."]'::jsonb,
  collocations = '["six months", "six weeks"]'::jsonb,
  patterns = '["six + noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'six';

-- Number: seven
UPDATE lexicon_entries
SET
  ipa = 'sevən',
  definition_simple = 'the number 7',
  definition_teacher = 'number/determiner: represents the quantity 7; can function as determiner or noun; neutral register',
  usage_notes = 'Basic number. In professional contexts: "seven days", "seven people", "24/7" (twenty-four seven - always available). Used for counting and quantities.',
  register = 'neutral',
  variety = 'international',
  examples = '["We work seven days a week.", "The team has seven members.", "Our support is available 24/7.", "There are seven steps in the process."]'::jsonb,
  collocations = '["seven days", "24/7"]'::jsonb,
  patterns = '["seven + noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'seven';

-- Number: eight
UPDATE lexicon_entries
SET
  ipa = 'eɪt',
  definition_simple = 'the number 8',
  definition_teacher = 'number/determiner: represents the quantity 8; can function as determiner or noun; neutral register',
  usage_notes = 'Basic number. In professional contexts: "eight hours", "eight AM", "eight people". Used for counting and quantities. Common in work schedules: "eight-hour workday".',
  register = 'neutral',
  variety = 'international',
  examples = '["I work eight hours a day.", "The meeting starts at eight AM.", "We have eight departments.", "The project takes eight weeks."]'::jsonb,
  collocations = '["eight hours", "eight AM"]'::jsonb,
  patterns = '["eight + noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'eight';

-- Number: nine
UPDATE lexicon_entries
SET
  ipa = 'naɪn',
  definition_simple = 'the number 9',
  definition_teacher = 'number/determiner: represents the quantity 9; can function as determiner or noun; neutral register',
  usage_notes = 'Basic number. In professional contexts: "nine AM", "nine to five" (work hours), "nine months". Used for counting and quantities.',
  register = 'neutral',
  variety = 'international',
  examples = '["The office opens at nine AM.", "I work nine to five.", "We have nine team members.", "The project takes nine months."]'::jsonb,
  collocations = '["nine AM", "nine to five"]'::jsonb,
  patterns = '["nine + noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'nine';

-- Number: ten
UPDATE lexicon_entries
SET
  ipa = 'ten',
  definition_simple = 'the number 10',
  definition_teacher = 'number/determiner: represents the quantity 10; can function as determiner or noun; neutral register',
  usage_notes = 'Basic number. In professional contexts: "ten people", "ten days", "ten percent". Used for counting and quantities. Common in percentages and measurements.',
  register = 'neutral',
  variety = 'international',
  examples = '["We have ten employees.", "The meeting is at ten AM.", "Sales increased by ten percent.", "There are ten items on the list."]'::jsonb,
  collocations = '["ten percent", "ten AM"]'::jsonb,
  patterns = '["ten + noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'ten';

-- Ordinal: first
UPDATE lexicon_entries
SET
  ipa = 'fɜːst',
  definition_simple = 'coming before all others',
  definition_teacher = 'adjective/adverb/noun: ordinal number indicating position 1 in a sequence; can be used attributively, predicatively, or as adverb; neutral register',
  usage_notes = 'Ordinal number for position 1. In professional contexts: "first priority", "first quarter", "first meeting", "at first" (initially). Very common in business for priorities and sequences. Can be adjective ("first day"), adverb ("arrive first"), or noun ("the first of the month").',
  register = 'neutral',
  variety = 'international',
  examples = '["This is our first priority.", "The first quarter was successful.", "I arrived first.", "Let me say first that I appreciate your work."]'::jsonb,
  collocations = '["first priority", "first quarter", "at first", "first of all"]'::jsonb,
  patterns = '["first + noun", "at first", "first of all"]'::jsonb,
  updated_at = now()
WHERE headword = 'first';

-- Ordinal: second
UPDATE lexicon_entries
SET
  ipa = 'sekənd',
  definition_simple = 'coming after the first',
  definition_teacher = 'adjective/noun: ordinal number indicating position 2 in a sequence; also a unit of time (1/60 of a minute); can be used attributively or predicatively; neutral register',
  usage_notes = 'Ordinal number for position 2. In professional contexts: "second quarter", "second option", "second meeting". Also means a unit of time: "wait a second". Can be adjective ("second day") or noun ("the second of the month").',
  register = 'neutral',
  variety = 'international',
  examples = '["This is the second option.", "The second quarter starts in April.", "Wait a second, please.", "She finished second in the competition."]'::jsonb,
  collocations = '["second quarter", "wait a second", "second option"]'::jsonb,
  patterns = '["second + noun", "a second (time unit)"]'::jsonb,
  updated_at = now()
WHERE headword = 'second';

-- ============================================================================
-- TIME WORDS (12 words)
-- ============================================================================

-- Time: day
UPDATE lexicon_entries
SET
  ipa = 'deɪ',
  definition_simple = 'a period of 24 hours',
  definition_teacher = 'noun: period of 24 hours or the time when it is light; countable noun; neutral register',
  usage_notes = 'Basic time unit. In professional contexts: "business day", "day off", "all day", "per day". Can mean 24-hour period or daylight hours. Very common in scheduling and deadlines. Plural: "days".',
  register = 'neutral',
  variety = 'international',
  examples = '["I work five days a week.", "The deadline is in three days.", "We have a meeting every day.", "She took a day off."]'::jsonb,
  collocations = '["business day", "day off", "all day", "per day", "every day"]'::jsonb,
  patterns = '["number + days", "per day", "day + off"]'::jsonb,
  updated_at = now()
WHERE headword = 'day';

-- Time: week
UPDATE lexicon_entries
SET
  ipa = 'wiːk',
  definition_simple = 'a period of seven days',
  definition_teacher = 'noun: period of seven days, typically Monday to Sunday or Sunday to Saturday; countable noun; neutral register',
  usage_notes = 'Basic time unit. In professional contexts: "this week", "next week", "per week", "work week". Very common in scheduling and planning. Note: "week" vs "weak" (different meanings, same pronunciation).',
  register = 'neutral',
  variety = 'international',
  examples = '["The meeting is next week.", "I work 40 hours per week.", "We have three meetings this week.", "The project takes two weeks."]'::jsonb,
  collocations = '["this week", "next week", "per week", "last week", "work week"]'::jsonb,
  patterns = '["this/next/last + week", "number + weeks", "per week"]'::jsonb,
  updated_at = now()
WHERE headword = 'week';

-- Time: month
UPDATE lexicon_entries
SET
  ipa = 'mʌnθ',
  definition_simple = 'a period of about 30 days',
  definition_teacher = 'noun: one of the twelve divisions of the year (January to December); period of approximately 30 days; countable noun; neutral register',
  usage_notes = 'Basic time unit. In professional contexts: "this month", "next month", "per month", "monthly". Very common in contracts, salaries, and planning. Note pronunciation: /mʌnθ/ - the "th" sound.',
  register = 'neutral',
  variety = 'international',
  examples = '["The report is due next month.", "We pay employees monthly.", "Sales increased this month.", "The contract is for six months."]'::jsonb,
  collocations = '["this month", "next month", "per month", "last month"]'::jsonb,
  patterns = '["this/next/last + month", "number + months", "per month"]'::jsonb,
  updated_at = now()
WHERE headword = 'month';

-- Time: year
UPDATE lexicon_entries
SET
  ipa = 'jɪər',
  definition_simple = 'a period of 365 or 366 days',
  definition_teacher = 'noun: period of 365 days (366 in leap year); twelve months from January to December; countable noun; neutral register',
  usage_notes = 'Basic time unit. In professional contexts: "this year", "fiscal year", "per year", "yearly", "year-end". Very common in business planning, reports, and contracts. Can refer to calendar year or fiscal year.',
  register = 'neutral',
  variety = 'international',
  examples = '["Sales increased this year.", "The fiscal year ends in December.", "I have five years of experience.", "We review performance yearly."]'::jsonb,
  collocations = '["this year", "fiscal year", "per year", "year-end", "last year"]'::jsonb,
  patterns = '["this/next/last + year", "number + years", "per year"]'::jsonb,
  updated_at = now()
WHERE headword = 'year';

-- Time: time
UPDATE lexicon_entries
SET
  ipa = 'taɪm',
  definition_simple = 'the thing that is measured in minutes, hours, days, etc.',
  definition_teacher = 'noun: continuous measurable quantity; specific point or period; can be countable or uncountable; neutral register',
  usage_notes = 'Very versatile word. In professional contexts: "on time" (punctual), "time management", "full-time", "part-time", "at the same time", "take time". Can be uncountable ("I don''t have time") or countable ("three times"). Essential in business communication.',
  register = 'neutral',
  variety = 'international',
  examples = '["I don''t have time for this.", "The meeting is on time.", "She works full-time.", "This is the third time I''ve asked."]'::jsonb,
  collocations = '["on time", "time management", "full-time", "part-time", "at the same time", "take time"]'::jsonb,
  patterns = '["on time", "have time", "take time", "number + times"]'::jsonb,
  updated_at = now()
WHERE headword = 'time';

-- Time: today
UPDATE lexicon_entries
SET
  ipa = 'tədeɪ',
  definition_simple = 'on this day',
  definition_teacher = 'adverb/noun: on or during the present day; can function as adverb or noun; neutral register',
  usage_notes = 'Refers to current day. In professional contexts: "today''s meeting", "due today", "today''s date". Very common in scheduling and deadlines. Can be adverb ("I work today") or noun ("today is Monday").',
  register = 'neutral',
  variety = 'international',
  examples = '["We have a meeting today.", "The report is due today.", "Today is Monday.", "I will finish this today."]'::jsonb,
  collocations = '["today''s meeting", "due today"]'::jsonb,
  patterns = '["today + verb", "today''s + noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'today';

-- Time: yesterday
UPDATE lexicon_entries
SET
  ipa = 'jestərdeɪ',
  definition_simple = 'on the day before today',
  definition_teacher = 'adverb/noun: on or during the day before the present day; can function as adverb or noun; neutral register',
  usage_notes = 'Refers to previous day. In professional contexts: "yesterday''s meeting", "sent yesterday", "as of yesterday". Common in reporting and updates. Can be adverb ("I worked yesterday") or noun ("yesterday was busy").',
  register = 'neutral',
  variety = 'international',
  examples = '["I sent the email yesterday.", "Yesterday''s meeting was productive.", "She called yesterday.", "As of yesterday, we had 100 orders."]'::jsonb,
  collocations = '["yesterday''s meeting", "sent yesterday"]'::jsonb,
  patterns = '["yesterday + verb", "yesterday''s + noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'yesterday';

-- Time: morning
UPDATE lexicon_entries
SET
  ipa = 'mɔːrnɪŋ',
  definition_simple = 'the early part of the day from when the sun rises until noon',
  definition_teacher = 'noun: period from sunrise to noon; countable noun; neutral register',
  usage_notes = 'Part of day. In professional contexts: "this morning", "tomorrow morning", "morning meeting", "good morning". Very common in scheduling. Note: "in the morning" (general), "this morning" (specific today).',
  register = 'neutral',
  variety = 'international',
  examples = '["Good morning, everyone.", "The meeting is this morning.", "I work in the morning.", "She arrives every morning at 8 AM."]'::jsonb,
  collocations = '["good morning", "this morning", "tomorrow morning", "morning meeting"]'::jsonb,
  patterns = '["in the morning", "this/tomorrow + morning", "morning + noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'morning';

-- Time: night
UPDATE lexicon_entries
SET
  ipa = 'naɪt',
  definition_simple = 'the time when it is dark and people usually sleep',
  definition_teacher = 'noun: period from sunset to sunrise; time of darkness; countable noun; neutral register',
  usage_notes = 'Part of day. In professional contexts: "night shift", "last night", "overnight", "good night". Common in discussing work schedules. Note: "at night" (general), "last night" (specific yesterday).',
  register = 'neutral',
  variety = 'international',
  examples = '["I work the night shift.", "Good night, see you tomorrow.", "The system runs overnight.", "She called last night."]'::jsonb,
  collocations = '["good night", "last night", "night shift", "at night"]'::jsonb,
  patterns = '["at night", "last/tomorrow + night", "night + noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'night';

-- Time: hour
UPDATE lexicon_entries
SET
  ipa = 'aʊər',
  definition_simple = 'a period of 60 minutes',
  definition_teacher = 'noun: period of 60 minutes; unit of time; countable noun; neutral register',
  usage_notes = 'Time unit. In professional contexts: "per hour", "office hours", "working hours", "24 hours". Very common in scheduling and rates. Note pronunciation: /aʊər/ - sounds like "our" in some accents.',
  register = 'neutral',
  variety = 'international',
  examples = '["The meeting lasts two hours.", "I work eight hours a day.", "Office hours are 9 to 5.", "We are open 24 hours."]'::jsonb,
  collocations = '["per hour", "office hours", "working hours", "24 hours"]'::jsonb,
  patterns = '["number + hours", "per hour", "office/working + hours"]'::jsonb,
  updated_at = now()
WHERE headword = 'hour';

-- Time: minute
UPDATE lexicon_entries
SET
  ipa = 'mɪnɪt',
  definition_simple = 'a period of 60 seconds',
  definition_teacher = 'noun: period of 60 seconds; unit of time; countable noun; neutral register',
  usage_notes = 'Time unit. In professional contexts: "wait a minute", "in five minutes", "per minute", "last-minute". Very common in scheduling and timing. Note: "minute" (time) /mɪnɪt/ vs "minute" (tiny) /maɪnjuːt/ - different pronunciations.',
  register = 'neutral',
  variety = 'international',
  examples = '["Wait a minute, please.", "The meeting starts in five minutes.", "I will be there in ten minutes.", "This is a last-minute change."]'::jsonb,
  collocations = '["wait a minute", "in minutes", "last-minute"]'::jsonb,
  patterns = '["number + minutes", "in + minutes", "wait a minute"]'::jsonb,
  updated_at = now()
WHERE headword = 'minute';

-- Time: now
UPDATE lexicon_entries
SET
  ipa = 'naʊ',
  definition_simple = 'at the present time',
  definition_teacher = 'adverb: at the present moment; immediately; can also be conjunction meaning "since"; neutral register',
  usage_notes = 'Refers to present moment. In professional contexts: "right now", "from now on", "now that", "available now". Very common for immediacy and current status. Can be adverb ("do it now") or conjunction ("now that we have the data...").',
  register = 'neutral',
  variety = 'international',
  examples = '["I am working on it now.", "We need to decide right now.", "From now on, we will use this system.", "Now that we have the data, we can proceed."]'::jsonb,
  collocations = '["right now", "from now on", "now that"]'::jsonb,
  patterns = '["right now", "from now on", "now that + clause"]'::jsonb,
  updated_at = now()
WHERE headword = 'now';

-- ============================================================================
-- ARTICLES AND DETERMINERS (15 words)
-- ============================================================================

-- Article: a
UPDATE lexicon_entries
SET
  ipa = 'ə',
  definition_simple = 'one (used before a noun)',
  definition_teacher = 'article: indefinite article used before singular countable nouns beginning with consonant sounds; indicates non-specific reference; neutral register',
  usage_notes = 'Indefinite article. Used before singular countable nouns starting with consonant sounds. In professional contexts: "a meeting", "a report", "a company". Brazilian learners often omit articles - English requires them. Use "a" before consonant sounds, "an" before vowel sounds.',
  register = 'neutral',
  variety = 'international',
  examples = '["I have a meeting at 2 PM.", "This is a good opportunity.", "She is a manager.", "We need a solution."]'::jsonb,
  collocations = '[]'::jsonb,
  patterns = '["a + singular countable noun (consonant sound)"]'::jsonb,
  updated_at = now()
WHERE headword = 'a';

-- Article: an
UPDATE lexicon_entries
SET
  ipa = 'ən',
  definition_simple = 'one (used before a noun that starts with a vowel sound)',
  definition_teacher = 'article: indefinite article used before singular countable nouns beginning with vowel sounds; indicates non-specific reference; neutral register',
  usage_notes = 'Indefinite article. Used before singular countable nouns starting with vowel sounds. In professional contexts: "an email", "an office", "an hour" (note: "hour" starts with vowel sound). Use "an" before vowel sounds (a, e, i, o, u sounds), not just vowel letters.',
  register = 'neutral',
  variety = 'international',
  examples = '["I sent an email this morning.", "She is an engineer.", "We need an answer.", "It takes an hour to get there."]'::jsonb,
  collocations = '[]'::jsonb,
  patterns = '["an + singular countable noun (vowel sound)"]'::jsonb,
  updated_at = now()
WHERE headword = 'an';

-- Article: the
UPDATE lexicon_entries
SET
  ipa = 'ðə',
  definition_simple = 'used to talk about a specific thing that is known',
  definition_teacher = 'article: definite article used before nouns to indicate specific reference; can be used with singular, plural, countable, and uncountable nouns; neutral register',
  usage_notes = 'Definite article. Used for specific, known things. In professional contexts: "the meeting", "the report", "the company". Very common - most frequent word in English. Brazilian learners often omit or overuse "the". Use when both speaker and listener know which specific thing is meant.',
  register = 'neutral',
  variety = 'international',
  examples = '["The meeting starts at 2 PM.", "Did you read the report?", "The office is closed today.", "I sent the email yesterday."]'::jsonb,
  collocations = '[]'::jsonb,
  patterns = '["the + noun (specific reference)"]'::jsonb,
  updated_at = now()
WHERE headword = 'the';

-- Determiner: this
UPDATE lexicon_entries
SET
  ipa = 'ðɪs',
  definition_simple = 'used to talk about something near or present',
  definition_teacher = 'determiner/pronoun: indicates something near in space or time; singular form; can be used attributively or as pronoun; neutral register',
  usage_notes = 'Demonstrative for near/present things. In professional contexts: "this week", "this project", "this is important". Very common in presentations and discussions. Singular form - use "these" for plural. Can be determiner ("this report") or pronoun ("this is good").',
  register = 'neutral',
  variety = 'international',
  examples = '["This is our new product.", "I will finish this today.", "This week is very busy.", "Can you review this document?"]'::jsonb,
  collocations = '["this week", "this month", "this year", "this is"]'::jsonb,
  patterns = '["this + singular noun", "this + is/was"]'::jsonb,
  updated_at = now()
WHERE headword = 'this';

-- Determiner: that
UPDATE lexicon_entries
SET
  ipa = 'ðæt',
  definition_simple = 'used to talk about something far or not present',
  definition_teacher = 'determiner/pronoun/conjunction: indicates something distant in space or time; singular form; also used as relative pronoun and conjunction; neutral register',
  usage_notes = 'Demonstrative for distant things. In professional contexts: "that project", "that is correct", "I know that...". Very versatile word. Singular form - use "those" for plural. Can be determiner ("that report"), pronoun ("that is good"), or conjunction ("I know that you are busy").',
  register = 'neutral',
  variety = 'international',
  examples = '["That is a good idea.", "I remember that meeting.", "That project was successful.", "I think that we should proceed."]'::jsonb,
  collocations = '["that is", "I think that", "I know that"]'::jsonb,
  patterns = '["that + singular noun", "that + is/was", "verb + that + clause"]'::jsonb,
  updated_at = now()
WHERE headword = 'that';

-- Determiner: these
UPDATE lexicon_entries
SET
  ipa = 'ðiːz',
  definition_simple = 'used to talk about things near or present (plural)',
  definition_teacher = 'determiner/pronoun: indicates multiple things near in space or time; plural form of "this"; can be used attributively or as pronoun; neutral register',
  usage_notes = 'Demonstrative for near/present things (plural). In professional contexts: "these documents", "these are important", "these results". Plural form of "this". Can be determiner ("these reports") or pronoun ("these are good").',
  register = 'neutral',
  variety = 'international',
  examples = '["These are our new products.", "Please review these documents.", "These results are impressive.", "I will finish these today."]'::jsonb,
  collocations = '["these are", "these documents"]'::jsonb,
  patterns = '["these + plural noun", "these + are/were"]'::jsonb,
  updated_at = now()
WHERE headword = 'these';

-- Determiner: those
UPDATE lexicon_entries
SET
  ipa = 'ðəʊz',
  definition_simple = 'used to talk about things far or not present (plural)',
  definition_teacher = 'determiner/pronoun: indicates multiple things distant in space or time; plural form of "that"; can be used attributively or as pronoun; neutral register',
  usage_notes = 'Demonstrative for distant things (plural). In professional contexts: "those projects", "those are correct", "those results". Plural form of "that". Can be determiner ("those reports") or pronoun ("those are good").',
  register = 'neutral',
  variety = 'international',
  examples = '["Those are good ideas.", "I remember those meetings.", "Those projects were successful.", "Can you send me those files?"]'::jsonb,
  collocations = '["those are"]'::jsonb,
  patterns = '["those + plural noun", "those + are/were"]'::jsonb,
  updated_at = now()
WHERE headword = 'those';

-- Determiner: all
UPDATE lexicon_entries
SET
  ipa = 'ɔːl',
  definition_simple = 'every one or the whole amount',
  definition_teacher = 'determiner/pronoun/adverb: indicates totality or entirety; can be used with plural countable or uncountable nouns; neutral register',
  usage_notes = 'Indicates totality. In professional contexts: "all employees", "all day", "all the time", "that''s all". Very common in business communication. Can be determiner ("all people"), pronoun ("all are welcome"), or adverb ("all done").',
  register = 'neutral',
  variety = 'international',
  examples = '["All employees must attend.", "I worked all day.", "All the documents are ready.", "That''s all for today."]'::jsonb,
  collocations = '["all day", "all the time", "that''s all", "all employees"]'::jsonb,
  patterns = '["all + noun", "all + of + the + noun", "that''s all"]'::jsonb,
  updated_at = now()
WHERE headword = 'all';

-- Determiner: some
UPDATE lexicon_entries
SET
  ipa = 'sʌm',
  definition_simple = 'an amount or number that is not exact',
  definition_teacher = 'determiner/pronoun: indicates an unspecified quantity; used with plural countable or uncountable nouns; neutral register',
  usage_notes = 'Indicates unspecified quantity. In professional contexts: "some people", "some time", "some information". Very common in business communication. Use with plural countable ("some employees") or uncountable nouns ("some information"). Can be determiner or pronoun.',
  register = 'neutral',
  variety = 'international',
  examples = '["Some employees work remotely.", "I need some information.", "Can you give me some time?", "Some of the reports are ready."]'::jsonb,
  collocations = '["some time", "some information", "some people"]'::jsonb,
  patterns = '["some + plural/uncountable noun", "some + of + the + noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'some';

-- Determiner: many
UPDATE lexicon_entries
SET
  ipa = 'meni',
  definition_simple = 'a large number of',
  definition_teacher = 'determiner/pronoun: indicates a large quantity; used with plural countable nouns; neutral register',
  usage_notes = 'Indicates large quantity. In professional contexts: "many people", "many times", "how many". Used with countable nouns only. Note: "many" (countable) vs "much" (uncountable). Very common in questions: "How many employees do you have?"',
  register = 'neutral',
  variety = 'international',
  examples = '["Many employees work from home.", "How many people attended?", "We have many options.", "I''ve said this many times."]'::jsonb,
  collocations = '["how many", "many times", "many people"]'::jsonb,
  patterns = '["many + plural noun", "how many + plural noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'many';

-- Determiner: much
UPDATE lexicon_entries
SET
  ipa = 'mʌtʃ',
  definition_simple = 'a large amount of',
  definition_teacher = 'determiner/pronoun/adverb: indicates a large quantity; used with uncountable nouns; also used as adverb for degree; neutral register',
  usage_notes = 'Indicates large quantity. In professional contexts: "much time", "how much", "too much", "very much". Used with uncountable nouns only. Note: "much" (uncountable) vs "many" (countable). Common in questions: "How much does it cost?"',
  register = 'neutral',
  variety = 'international',
  examples = '["How much time do we have?", "This costs too much.", "Thank you very much.", "We don''t have much information."]'::jsonb,
  collocations = '["how much", "too much", "very much", "much time"]'::jsonb,
  patterns = '["much + uncountable noun", "how much + uncountable noun", "very much"]'::jsonb,
  updated_at = now()
WHERE headword = 'much';

-- Determiner: more
UPDATE lexicon_entries
SET
  ipa = 'mɔːr',
  definition_simple = 'a larger amount or number',
  definition_teacher = 'determiner/pronoun/adverb: comparative form indicating greater quantity or degree; used with both countable and uncountable nouns; neutral register',
  usage_notes = 'Indicates greater quantity. In professional contexts: "more time", "more people", "more information", "one more". Very common in business communication. Can be used with countable or uncountable nouns. Also forms comparative adjectives: "more important".',
  register = 'neutral',
  variety = 'international',
  examples = '["We need more time.", "Can I have more information?", "More people are working remotely.", "This is more important."]'::jsonb,
  collocations = '["more time", "more information", "one more", "more important"]'::jsonb,
  patterns = '["more + noun", "more + adjective (comparative)", "one more"]'::jsonb,
  updated_at = now()
WHERE headword = 'more';

-- ============================================================================
-- CONJUNCTIONS (3 words)
-- ============================================================================

-- Conjunction: and
UPDATE lexicon_entries
SET
  ipa = 'ænd',
  definition_simple = 'used to connect words or groups of words',
  definition_teacher = 'conjunction: coordinating conjunction connecting words, phrases, or clauses of equal grammatical status; indicates addition or continuation; neutral register',
  usage_notes = 'Basic connector. In professional contexts: "you and I", "reports and presentations", "plan and execute". Most common conjunction in English. Connects equal elements. Can connect words, phrases, or clauses. Very frequent in all types of communication.',
  register = 'neutral',
  variety = 'international',
  examples = '["I work in sales and marketing.", "She is smart and hardworking.", "We need to plan and execute.", "You and I will work together."]'::jsonb,
  collocations = '["and so on", "and then", "you and I"]'::jsonb,
  patterns = '["noun + and + noun", "adjective + and + adjective", "clause + and + clause"]'::jsonb,
  updated_at = now()
WHERE headword = 'and';

-- Conjunction: or
UPDATE lexicon_entries
SET
  ipa = 'ɔːr',
  definition_simple = 'used to connect choices or possibilities',
  definition_teacher = 'conjunction: coordinating conjunction indicating alternatives or choices; connects words, phrases, or clauses of equal grammatical status; neutral register',
  usage_notes = 'Indicates choice. In professional contexts: "yes or no", "this or that", "Monday or Tuesday". Used for alternatives and options. Very common in questions and decisions. Can connect words, phrases, or clauses.',
  register = 'neutral',
  variety = 'international',
  examples = '["Do you want coffee or tea?", "We can meet Monday or Tuesday.", "Is this correct or incorrect?", "You can email or call me."]'::jsonb,
  collocations = '["or not", "yes or no", "either...or"]'::jsonb,
  patterns = '["noun + or + noun", "adjective + or + adjective", "clause + or + clause"]'::jsonb,
  updated_at = now()
WHERE headword = 'or';

-- Conjunction: but
UPDATE lexicon_entries
SET
  ipa = 'bʌt',
  definition_simple = 'used to introduce something different or opposite',
  definition_teacher = 'conjunction: coordinating conjunction indicating contrast or exception; connects words, phrases, or clauses of equal grammatical status; neutral register',
  usage_notes = 'Indicates contrast. In professional contexts: "good but expensive", "I want to but I can''t", "not this but that". Very common for showing contrast or exception. Can connect words, phrases, or clauses. Essential for expressing limitations or contrasts.',
  register = 'neutral',
  variety = 'international',
  examples = '["The product is good but expensive.", "I want to help but I''m busy.", "Not today but tomorrow.", "She is young but experienced."]'::jsonb,
  collocations = '["but not", "yes but", "but also"]'::jsonb,
  patterns = '["adjective + but + adjective", "clause + but + clause"]'::jsonb,
  updated_at = now()
WHERE headword = 'but';

-- ============================================================================
-- BASIC ADVERBS (9 words)
-- ============================================================================

-- Adverb: yes
UPDATE lexicon_entries
SET
  ipa = 'jes',
  definition_simple = 'used to give a positive answer',
  definition_teacher = 'adverb/interjection: expresses affirmation or agreement; opposite of "no"; neutral register',
  usage_notes = 'Affirmative response. In professional contexts: "yes, I agree", "yes, that''s correct", "say yes". Very common in all communication. Can be standalone response or part of sentence. Essential for agreement and confirmation.',
  register = 'neutral',
  variety = 'international',
  examples = '["Yes, I agree with that.", "Yes, the report is ready.", "Can you help? Yes, of course.", "She said yes to the proposal."]'::jsonb,
  collocations = '["say yes", "yes or no"]'::jsonb,
  patterns = '["yes + comma + sentence", "say yes"]'::jsonb,
  updated_at = now()
WHERE headword = 'yes';

-- Adverb: no
UPDATE lexicon_entries
SET
  ipa = 'nəʊ',
  definition_simple = 'used to give a negative answer',
  definition_teacher = 'adverb/determiner/interjection: expresses negation or refusal; opposite of "yes"; also used as determiner meaning "not any"; neutral register',
  usage_notes = 'Negative response. In professional contexts: "no, I disagree", "no problem", "no time". Very common in all communication. Can be standalone response, part of sentence, or determiner ("no time"). Essential for disagreement and refusal.',
  register = 'neutral',
  variety = 'international',
  examples = '["No, I don''t agree.", "No, the report is not ready.", "Can you help? No, I''m sorry.", "We have no time for this."]'::jsonb,
  collocations = '["say no", "no problem", "no time", "yes or no"]'::jsonb,
  patterns = '["no + comma + sentence", "no + noun (not any)", "say no"]'::jsonb,
  updated_at = now()
WHERE headword = 'no';

-- Adverb: not
UPDATE lexicon_entries
SET
  ipa = 'nɒt',
  definition_simple = 'used to make a negative statement',
  definition_teacher = 'adverb: negation particle used with auxiliary verbs to form negative statements; contracted form: n''t; neutral register',
  usage_notes = 'Negation word. In professional contexts: "not ready", "not available", "not correct". Very common - essential for negative statements. Used with auxiliary verbs: "do not", "is not", "cannot". Contracted forms: "don''t", "isn''t", "can''t".',
  register = 'neutral',
  variety = 'international',
  examples = '["I am not available today.", "This is not correct.", "We do not have time.", "She cannot attend the meeting."]'::jsonb,
  collocations = '["not yet", "not available", "not ready", "if not"]'::jsonb,
  patterns = '["auxiliary + not + verb", "be + not + adjective"]'::jsonb,
  updated_at = now()
WHERE headword = 'not';

-- Adverb: very
UPDATE lexicon_entries
SET
  ipa = 'veri',
  definition_simple = 'to a high degree',
  definition_teacher = 'adverb: intensifier indicating high degree; modifies adjectives and adverbs; neutral register',
  usage_notes = 'Intensifier. In professional contexts: "very important", "very good", "very much", "very well". Very common for emphasis. Modifies adjectives ("very good") and adverbs ("very well"). Note: don''t use with absolute adjectives like "perfect" or "unique".',
  register = 'neutral',
  variety = 'international',
  examples = '["This is very important.", "She did very well.", "Thank you very much.", "The project is very successful."]'::jsonb,
  collocations = '["very important", "very good", "very much", "very well"]'::jsonb,
  patterns = '["very + adjective", "very + adverb", "very much"]'::jsonb,
  updated_at = now()
WHERE headword = 'very';

-- Adverb: well
UPDATE lexicon_entries
SET
  ipa = 'wel',
  definition_simple = 'in a good way',
  definition_teacher = 'adverb/adjective/interjection: indicates satisfactory manner or degree; can modify verbs or be used as adjective for health; neutral register',
  usage_notes = 'Manner adverb. In professional contexts: "work well", "do well", "well done", "as well". Very common in business communication. Can be adverb ("work well"), adjective ("I am well"), or interjection ("Well, let''s start"). Note: "good" (adjective) vs "well" (adverb).',
  register = 'neutral',
  variety = 'international',
  examples = '["She works very well.", "The project went well.", "Well done on the presentation.", "I hope you are well."]'::jsonb,
  collocations = '["work well", "do well", "well done", "as well", "very well"]'::jsonb,
  patterns = '["verb + well", "well + done", "as well"]'::jsonb,
  updated_at = now()
WHERE headword = 'well';

-- Adverb: here
UPDATE lexicon_entries
SET
  ipa = 'hɪər',
  definition_simple = 'in or at this place',
  definition_teacher = 'adverb: indicates location at or near the speaker; opposite of "there"; neutral register',
  usage_notes = 'Location adverb. In professional contexts: "here is the report", "work here", "come here", "here and there". Very common in presentations and instructions. Indicates speaker''s location or nearby place.',
  register = 'neutral',
  variety = 'international',
  examples = '["Here is the document you requested.", "I work here.", "Please come here.", "The office is here."]'::jsonb,
  collocations = '["here is", "here and there", "come here", "work here"]'::jsonb,
  patterns = '["here + is/are", "verb + here", "come here"]'::jsonb,
  updated_at = now()
WHERE headword = 'here';

-- Adverb: there
UPDATE lexicon_entries
SET
  ipa = 'ðeər',
  definition_simple = 'in or at that place',
  definition_teacher = 'adverb/pronoun: indicates location away from speaker; also used as existential "there" in "there is/are"; neutral register',
  usage_notes = 'Location adverb. In professional contexts: "there is a problem", "work there", "go there", "over there". Very common - especially existential "there is/are". Note: "there" (place) vs "their" (possessive) vs "they''re" (they are) - common confusion.',
  register = 'neutral',
  variety = 'international',
  examples = '["There is a meeting at 2 PM.", "I work there.", "Please go there.", "The office is over there."]'::jsonb,
  collocations = '["there is/are", "over there", "go there", "work there"]'::jsonb,
  patterns = '["there + is/are + noun", "verb + there", "over there"]'::jsonb,
  updated_at = now()
WHERE headword = 'there';

-- Adverb: too
UPDATE lexicon_entries
SET
  ipa = 'tuː',
  definition_simple = 'more than is good or necessary, or also',
  definition_teacher = 'adverb: indicates excess or addition; two meanings: excessive degree or "also"; neutral register',
  usage_notes = 'Two meanings: excess ("too much") or "also" ("me too"). In professional contexts: "too expensive", "too late", "me too", "too many". Very common. Note: "too" (excess/also) vs "to" (preposition/infinitive) vs "two" (number) - same pronunciation, different meanings.',
  register = 'neutral',
  variety = 'international',
  examples = '["This is too expensive.", "I think so too.", "There are too many errors.", "It''s too late to change."]'::jsonb,
  collocations = '["too much", "too many", "me too", "too late"]'::jsonb,
  patterns = '["too + adjective/adverb", "verb + too (also)"]'::jsonb,
  updated_at = now()
WHERE headword = 'too';

-- Adverb: also
UPDATE lexicon_entries
SET
  ipa = 'ɔːlsəʊ',
  definition_simple = 'in addition',
  definition_teacher = 'adverb: indicates addition or inclusion; more formal than "too"; typically placed before main verb or after "be"; neutral register',
  usage_notes = 'Indicates addition. In professional contexts: "also important", "also need", "also available". More formal than "too". Position: before main verb ("I also work") or after "be" ("It is also important"). Very common in business writing.',
  register = 'neutral',
  variety = 'international',
  examples = '["This is also important.", "I also need the report.", "She also works in marketing.", "We are also available on weekends."]'::jsonb,
  collocations = '["also important", "also need", "also available"]'::jsonb,
  patterns = '["also + verb", "be + also + adjective", "also + adjective"]'::jsonb,
  updated_at = now()
WHERE headword = 'also';

-- ============================================================================
-- GREETINGS AND POLITE EXPRESSIONS (4 words)
-- ============================================================================

-- Greeting: hullo
UPDATE lexicon_entries
SET
  ipa = 'həˈləʊ',
  definition_simple = 'used to greet someone',
  definition_teacher = 'interjection: greeting expression; variant spelling of "hello"; used when meeting someone or answering phone; neutral register',
  usage_notes = 'Basic greeting. In professional contexts: "Hello, how are you?", "Hello, this is [name]" (phone). Very common in all communication. Note: "hullo" is variant spelling of "hello" - both acceptable. Essential for starting conversations and phone calls.',
  register = 'neutral',
  variety = 'international',
  examples = '["Hello, how are you?", "Hello, this is John speaking.", "Hello everyone, welcome to the meeting.", "Hello, can I help you?"]'::jsonb,
  collocations = '["hello everyone", "say hello"]'::jsonb,
  patterns = '["hello + comma + sentence", "hello + name"]'::jsonb,
  updated_at = now()
WHERE headword = 'hullo';

-- Polite: please
UPDATE lexicon_entries
SET
  ipa = 'pliːz',
  definition_simple = 'used to be polite when asking for something',
  definition_teacher = 'adverb/verb: polite marker used in requests; makes requests more courteous; can also be verb meaning "to make happy"; neutral register',
  usage_notes = 'Politeness marker. In professional contexts: "please send", "please let me know", "yes please". Essential for polite requests. Can be at beginning or end of request. Very common in business communication. Makes requests sound more courteous and professional.',
  register = 'neutral',
  variety = 'international',
  examples = '["Please send me the report.", "Can you help me, please?", "Please let me know if you have questions.", "Yes, please."]'::jsonb,
  collocations = '["please send", "please let me know", "yes please"]'::jsonb,
  patterns = '["please + verb", "verb + please", "yes/no + please"]'::jsonb,
  updated_at = now()
WHERE headword = 'please';

-- Polite: thank
UPDATE lexicon_entries
SET
  ipa = 'θæŋk',
  definition_simple = 'to tell someone you are grateful',
  definition_teacher = 'verb: expresses gratitude; forms: thank/thanks (present), thanked (past), thanked (past participle); typically used in phrase "thank you"; neutral register',
  usage_notes = 'Expresses gratitude. In professional contexts: "thank you", "thank you for", "thanks". Very common in all communication. Usually used in phrase "thank you" or "thanks". Essential for politeness. Note: "thank" (verb) vs "thanks" (noun/informal interjection).',
  register = 'neutral',
  variety = 'international',
  examples = '["Thank you for your help.", "I want to thank you for your support.", "Thank you very much.", "Thanks for the information."]'::jsonb,
  collocations = '["thank you", "thank you for", "thank you very much"]'::jsonb,
  patterns = '["thank + someone", "thank you + for + noun/gerund"]'::jsonb,
  updated_at = now()
WHERE headword = 'thank';

-- Polite: welcome
UPDATE lexicon_entries
SET
  ipa = 'welkəm',
  definition_simple = 'to greet someone in a friendly way',
  definition_teacher = 'verb/adjective/noun/interjection: expresses greeting or acceptance; as verb means to greet; as adjective means gladly received; as interjection used in "you''re welcome"; neutral register',
  usage_notes = 'Multiple uses: greet ("welcome to the company"), response to thanks ("you''re welcome"), adjective ("you are welcome to join"). In professional contexts: "welcome aboard", "you''re welcome", "welcome to". Very common in hospitality and responses to gratitude.',
  register = 'neutral',
  variety = 'international',
  examples = '["Welcome to our company.", "You''re welcome.", "Welcome aboard!", "You are welcome to join us."]'::jsonb,
  collocations = '["you''re welcome", "welcome to", "welcome aboard"]'::jsonb,
  patterns = '["welcome + to + place", "you''re welcome", "welcome + noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'welcome';

-- ============================================================================
-- END OF BATCH 1
-- ============================================================================
-- Total words in this batch: 14 pronouns + 42 verbs + 6 colors + 12 numbers + 
--                            12 time words + 15 determiners + 3 conjunctions + 
--                            9 adverbs + 4 greetings = 117 A0 words
