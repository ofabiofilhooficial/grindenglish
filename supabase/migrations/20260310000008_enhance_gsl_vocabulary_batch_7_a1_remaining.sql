-- Migration: Enhance GSL Vocabulary - Batch 7 (A1 Remaining High-Frequency Words)
-- Description: Add comprehensive linguistic data for fourth batch of A1 words
-- Words: Modal verbs (can, could, will, would, should, must, may, might)
--        Common verbs (know, think, want, need, like, see, look, find, give, take, etc.)
--        Common adjectives (good, bad, big, small, new, old, important, different, etc.)
-- Target: ~150 A1 remaining high-frequency words
-- Focus: Brazilian professionals completing A1 vocabulary foundation

-- ============================================================================
-- MODAL VERBS (8 words)
-- ============================================================================

-- Modal: can
UPDATE lexicon_entries
SET
  ipa = 'kæn',
  definition_simple = 'to be able to do something or to be allowed to do something',
  definition_teacher = 'modal verb: expresses ability, possibility, or permission; neutral register; fundamental modal; negative: cannot/can''t; past: could',
  usage_notes = 'Essential ability/permission modal. Ability: "I can speak English". Permission: "Can I leave?". Possibility: "It can happen". Very common in all contexts. Brazilian learners should note: "can" for ability, "may" for formal permission.',
  register = 'neutral',
  variety = 'international',
  examples = '["I can help you.", "Can you speak English?", "You can leave now.", "This can be difficult."]'::jsonb,
  collocations = '["can help", "can speak", "can do", "can be", "can you"]'::jsonb,
  patterns = '["can + base verb", "can + be + adjective", "can you + verb"]'::jsonb,
  updated_at = now()
WHERE headword = 'can';

-- Modal: could
UPDATE lexicon_entries
SET
  ipa = 'kʊd',
  definition_simple = 'past form of can, or used to make polite requests',
  definition_teacher = 'modal verb: past of can; also expresses polite requests, suggestions, or possibility; neutral register; more polite than "can"',
  usage_notes = 'Versatile modal. Past ability: "I could swim when I was young". Polite request: "Could you help me?". Possibility: "It could rain". Suggestion: "We could try this". More polite than "can". Very common in professional contexts.',
  register = 'neutral',
  variety = 'international',
  examples = '["Could you send me the file?", "I could help you tomorrow.", "It could be a problem.", "We could meet next week."]'::jsonb,
  collocations = '["could you", "could be", "could help", "could have", "we could"]'::jsonb,
  patterns = '["could + base verb", "could you + verb", "could + be + adjective"]'::jsonb,
  updated_at = now()
WHERE headword = 'could';

-- Modal: will
UPDATE lexicon_entries
SET
  ipa = 'wɪl',
  definition_simple = 'used to talk about the future or to show willingness',
  definition_teacher = 'modal verb: expresses future, willingness, or prediction; neutral register; fundamental future marker; negative: will not/won''t',
  usage_notes = 'Essential future modal. Future: "I will call you". Willingness: "I will help". Prediction: "It will rain". Promise: "I will do it". Very common in all contexts. Brazilian learners should note: "will" for future, not present tense.',
  register = 'neutral',
  variety = 'international',
  examples = '["I will send the report tomorrow.", "Will you attend the meeting?", "It will be ready soon.", "I will help you."]'::jsonb,
  collocations = '["will be", "will send", "will help", "will you", "I will"]'::jsonb,
  patterns = '["will + base verb", "will + be + adjective", "will you + verb"]'::jsonb,
  updated_at = now()
WHERE headword = 'will';

-- Modal: would
UPDATE lexicon_entries
SET
  ipa = 'wʊd',
  definition_simple = 'used to talk about imagined situations or to make polite requests',
  definition_teacher = 'modal verb: past of will; expresses hypothetical situations, polite requests, or past habits; neutral register; very versatile modal',
  usage_notes = 'Versatile modal. Polite request: "Would you help me?". Hypothetical: "I would go if I could". Past habit: "I would walk every day". Preference: "I would like coffee". Very common in professional politeness.',
  register = 'neutral',
  variety = 'international',
  examples = '["Would you like some coffee?", "I would appreciate your help.", "What would you do?", "I would like to schedule a meeting."]'::jsonb,
  collocations = '["would like", "would you", "would be", "would appreciate", "I would"]'::jsonb,
  patterns = '["would + base verb", "would like + noun/to-infinitive", "would you + verb"]'::jsonb,
  updated_at = now()
WHERE headword = 'would';

-- Modal: should
UPDATE lexicon_entries
SET
  ipa = 'ʃʊd',
  definition_simple = 'used to say what is the right or best thing to do',
  definition_teacher = 'modal verb: expresses advice, obligation, or expectation; neutral register; fundamental modal for recommendations',
  usage_notes = 'Essential advice modal. Advice: "You should rest". Obligation: "We should finish today". Expectation: "It should arrive soon". Very common in professional recommendations. Brazilian learners should note: "should" for advice, "must" for strong obligation.',
  register = 'neutral',
  variety = 'international',
  examples = '["You should check your email.", "We should start the meeting.", "This should work.", "What should I do?"]'::jsonb,
  collocations = '["should be", "should do", "you should", "we should", "what should"]'::jsonb,
  patterns = '["should + base verb", "should + be + adjective", "what should + subject + verb"]'::jsonb,
  updated_at = now()
WHERE headword = 'should';


-- Modal: must
UPDATE lexicon_entries
SET
  ipa = 'mʌst',
  definition_simple = 'to have to do something because it is necessary or required',
  definition_teacher = 'modal verb: expresses strong obligation, necessity, or logical conclusion; neutral to formal register; no past form (use "had to")',
  usage_notes = 'Strong obligation modal. Necessity: "You must attend". Logical conclusion: "It must be true". Very common in rules and requirements. Brazilian learners should note: "must" (strong obligation) vs "should" (advice). Past: use "had to".',
  register = 'neutral',
  variety = 'international',
  examples = '["All employees must attend training.", "You must submit the form by Friday.", "She must be very busy.", "We must finish this today."]'::jsonb,
  collocations = '["must be", "must have", "must do", "you must", "we must"]'::jsonb,
  patterns = '["must + base verb", "must + be + adjective", "must have + past participle"]'::jsonb,
  updated_at = now()
WHERE headword = 'must';

-- Modal: may
UPDATE lexicon_entries
SET
  ipa = 'meɪ',
  definition_simple = 'used to say that something is possible or to ask for permission formally',
  definition_teacher = 'modal verb: expresses possibility or formal permission; formal register; more formal than "can" or "might"',
  usage_notes = 'Formal permission/possibility modal. Permission: "May I help you?". Possibility: "It may rain". More formal than "can". Common in business writing and formal speech. Brazilian learners should note: "may" for formal contexts, "can" for informal.',
  register = 'formal',
  variety = 'international',
  examples = '["May I help you?", "This may take some time.", "You may leave now.", "It may be difficult."]'::jsonb,
  collocations = '["may I", "may be", "may have", "may need", "you may"]'::jsonb,
  patterns = '["may + base verb", "may I + verb", "may + be + adjective"]'::jsonb,
  updated_at = now()
WHERE headword = 'may';

-- Modal: might
UPDATE lexicon_entries
SET
  ipa = 'maɪt',
  definition_simple = 'used to say that something is possible but not certain',
  definition_teacher = 'modal verb: expresses possibility or tentative suggestion; neutral register; less certain than "may"; past of "may" in some contexts',
  usage_notes = 'Possibility modal. Uncertain possibility: "It might rain". Tentative suggestion: "We might try this". Less certain than "may". Common in hedging and polite suggestions. Brazilian learners should note: "might" shows less certainty than "may".',
  register = 'neutral',
  variety = 'international',
  examples = '["It might be a problem.", "I might be late.", "We might need more time.", "This might work."]'::jsonb,
  collocations = '["might be", "might have", "might need", "might want", "it might"]'::jsonb,
  patterns = '["might + base verb", "might + be + adjective", "might have + past participle"]'::jsonb,
  updated_at = now()
WHERE headword = 'might';

-- ============================================================================
-- COMMON COGNITIVE VERBS (10 words)
-- ============================================================================

-- Verb: know
UPDATE lexicon_entries
SET
  ipa = 'nəʊ',
  definition_simple = 'to have information in your mind or to be familiar with someone or something',
  definition_teacher = 'verb: transitive; expresses knowledge, familiarity, or recognition; neutral register; irregular past (knew, known); fundamental cognitive verb',
  usage_notes = 'Essential knowledge verb. Information: "I know the answer". Familiarity: "I know her". Common phrases: "I don''t know", "you know" (filler), "let me know" (inform me). Very common in all contexts. Brazilian learners should note: "know" (knowledge) vs "meet" (first encounter).',
  register = 'neutral',
  variety = 'international',
  examples = '["I know the answer.", "Do you know Maria?", "Let me know when you arrive.", "I don''t know what to do."]'::jsonb,
  collocations = '["I know", "don''t know", "let me know", "you know", "know about"]'::jsonb,
  patterns = '["know + noun", "know + that clause", "know + wh-clause", "let me know"]'::jsonb,
  updated_at = now()
WHERE headword = 'know';

-- Verb: think
UPDATE lexicon_entries
SET
  ipa = 'θɪŋk',
  definition_simple = 'to have an opinion or to use your mind to consider something',
  definition_teacher = 'verb: transitive or intransitive; expresses opinion, consideration, or mental activity; neutral register; irregular past (thought); fundamental cognitive verb',
  usage_notes = 'Essential thinking verb. Opinion: "I think it''s good". Consideration: "I''m thinking about it". Common phrases: "I think so", "I don''t think so", "think about". Very common in expressing opinions. Brazilian learners should note: "I think" for opinions, not "I am thinking".',
  register = 'neutral',
  variety = 'international',
  examples = '["I think this is a good idea.", "What do you think?", "I''m thinking about the proposal.", "I think so."]'::jsonb,
  collocations = '["I think", "think about", "think so", "don''t think", "what do you think"]'::jsonb,
  patterns = '["think + that clause", "think + about", "I think so", "what do you think"]'::jsonb,
  updated_at = now()
WHERE headword = 'think';

-- Verb: want
UPDATE lexicon_entries
SET
  ipa = 'wɒnt',
  definition_simple = 'to have a desire for something or wish for something to happen',
  definition_teacher = 'verb: transitive; expresses desire or need; neutral register; fundamental desire verb',
  usage_notes = 'Essential desire verb. Patterns: "want something", "want to do", "want someone to do". Common phrases: "I want to", "do you want". Very common in requests and preferences. Brazilian learners should note: "want to do" (not "want that I do").',
  register = 'neutral',
  variety = 'international',
  examples = '["I want to learn English.", "Do you want some coffee?", "She wants to speak with you.", "We want to improve our process."]'::jsonb,
  collocations = '["want to", "do you want", "I want", "want something", "want someone to"]'::jsonb,
  patterns = '["want + to-infinitive", "want + noun", "want + person + to-infinitive"]'::jsonb,
  updated_at = now()
WHERE headword = 'want';

-- Verb: need
UPDATE lexicon_entries
SET
  ipa = 'niːd',
  definition_simple = 'to require something or to have to do something',
  definition_teacher = 'verb: transitive; also noun; expresses necessity or requirement; neutral register; fundamental necessity verb',
  usage_notes = 'Essential necessity verb. Patterns: "need something", "need to do". Also noun: "a need for". Common phrases: "I need to", "we need". Very common in professional contexts for requirements. Brazilian learners should note: "need to do" (not "need that I do").',
  register = 'neutral',
  variety = 'international',
  examples = '["I need your help.", "We need to finish today.", "Do you need anything?", "There is a need for change."]'::jsonb,
  collocations = '["need to", "need help", "I need", "we need", "need for"]'::jsonb,
  patterns = '["need + to-infinitive", "need + noun", "need + for"]'::jsonb,
  updated_at = now()
WHERE headword = 'need';

-- Verb: like
UPDATE lexicon_entries
SET
  ipa = 'laɪk',
  definition_simple = 'to enjoy something or to find someone or something pleasant',
  definition_teacher = 'verb: transitive; also preposition and noun; expresses preference or enjoyment; neutral register; fundamental preference verb',
  usage_notes = 'Essential preference verb. Patterns: "like something", "like to do", "like doing". Also: "would like" (polite want). Preposition: "like this" (similar to). Very common in expressing preferences. Brazilian learners should note: "I like" (general) vs "I would like" (polite request).',
  register = 'neutral',
  variety = 'international',
  examples = '["I like coffee.", "She likes to read.", "Would you like some tea?", "It looks like rain."]'::jsonb,
  collocations = '["would like", "I like", "like to", "like this", "looks like"]'::jsonb,
  patterns = '["like + noun", "like + to-infinitive", "like + -ing", "would like"]'::jsonb,
  updated_at = now()
WHERE headword = 'like';

-- Verb: see
UPDATE lexicon_entries
SET
  ipa = 'siː',
  definition_simple = 'to notice something with your eyes or to understand something',
  definition_teacher = 'verb: transitive; expresses vision, understanding, or meeting; neutral register; irregular past (saw, seen); fundamental perception verb',
  usage_notes = 'Essential vision/understanding verb. Vision: "I see the problem". Understanding: "I see what you mean". Meeting: "See you tomorrow". Common phrases: "let''s see", "I see", "see you". Very common in all contexts. Brazilian learners should note: "see" (perceive) vs "look" (direct gaze).',
  register = 'neutral',
  variety = 'international',
  examples = '["I see the problem now.", "Can you see the screen?", "I see what you mean.", "See you tomorrow!"]'::jsonb,
  collocations = '["I see", "see you", "let''s see", "can you see", "see what"]'::jsonb,
  patterns = '["see + noun", "see + that clause", "see you", "I see"]'::jsonb,
  updated_at = now()
WHERE headword = 'see';

-- Verb: look
UPDATE lexicon_entries
SET
  ipa = 'lʊk',
  definition_simple = 'to direct your eyes toward something or to appear in a particular way',
  definition_teacher = 'verb: intransitive (requires preposition) or linking verb; also noun; expresses directed gaze or appearance; neutral register',
  usage_notes = 'Essential vision/appearance verb. Gaze: "look at something". Appearance: "look good", "look like". Search: "look for". Common phrases: "have a look", "look forward to". Very common in all contexts. Brazilian learners should note: "look at" (not just "look").',
  register = 'neutral',
  variety = 'international',
  examples = '["Look at this report.", "You look tired.", "I''m looking for my phone.", "Let''s have a look."]'::jsonb,
  collocations = '["look at", "look for", "look like", "look forward to", "have a look"]'::jsonb,
  patterns = '["look + at", "look + for", "look + adjective", "look + like", "look forward to"]'::jsonb,
  updated_at = now()
WHERE headword = 'look';

-- Verb: find
UPDATE lexicon_entries
SET
  ipa = 'faɪnd',
  definition_simple = 'to discover something or someone by searching or by chance',
  definition_teacher = 'verb: transitive; expresses discovery, location, or judgment; neutral register; irregular past (found); fundamental discovery verb',
  usage_notes = 'Essential discovery verb. Discovery: "find something". Judgment: "find it difficult". Common phrases: "find out" (discover information), "find a solution". Very common in problem-solving contexts. Brazilian learners should note: "find" (discover) vs "find out" (learn information).',
  register = 'neutral',
  variety = 'international',
  examples = '["I can''t find my keys.", "We need to find a solution.", "I find this interesting.", "Let''s find out more information."]'::jsonb,
  collocations = '["find out", "find a solution", "find it", "can''t find", "find something"]'::jsonb,
  patterns = '["find + noun", "find + it + adjective", "find out + about"]'::jsonb,
  updated_at = now()
WHERE headword = 'find';


-- Verb: give
UPDATE lexicon_entries
SET
  ipa = 'ɡɪv',
  definition_simple = 'to provide something to someone or to hand something to someone',
  definition_teacher = 'verb: transitive; expresses transfer, provision, or causing; neutral register; irregular past (gave, given); fundamental transfer verb',
  usage_notes = 'Essential transfer verb. Patterns: "give someone something", "give something to someone". Common phrases: "give me", "give a presentation", "give feedback". Very common in professional contexts. Brazilian learners should note: double object pattern "give me the report".',
  register = 'neutral',
  variety = 'international',
  examples = '["Please give me the report.", "I will give you feedback.", "She gave a great presentation.", "Can you give this to Maria?"]'::jsonb,
  collocations = '["give me", "give feedback", "give a presentation", "give someone something", "give information"]'::jsonb,
  patterns = '["give + person + thing", "give + thing + to + person", "give a + noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'give';

-- Verb: take
UPDATE lexicon_entries
SET
  ipa = 'teɪk',
  definition_simple = 'to move something from one place to another or to accept something',
  definition_teacher = 'verb: transitive; highly versatile meaning including moving, accepting, requiring, or capturing; neutral register; irregular past (took, taken)',
  usage_notes = 'Highly versatile verb. Move: "take this". Accept: "take the job". Require: "it takes time". Common phrases: "take a break", "take place" (happen), "take part" (participate). Very common in all contexts. Multiple meanings require context.',
  register = 'neutral',
  variety = 'international',
  examples = '["Take this document to Maria.", "Let''s take a break.", "It takes two hours.", "The meeting takes place tomorrow."]'::jsonb,
  collocations = '["take a break", "take place", "take part", "take time", "it takes"]'::jsonb,
  patterns = '["take + noun", "take + time", "take place", "it takes + time"]'::jsonb,
  updated_at = now()
WHERE headword = 'take';

-- ============================================================================
-- COMMON ADJECTIVES (12 words)
-- ============================================================================

-- Adjective: good
UPDATE lexicon_entries
SET
  ipa = 'ɡʊd',
  definition_simple = 'of high quality or pleasant and satisfactory',
  definition_teacher = 'adjective: also noun; expresses positive quality, skill, or morality; neutral register; irregular comparative (better, best); fundamental positive descriptor',
  usage_notes = 'Essential positive adjective. Quality: "good work". Skill: "good at English". Greeting: "good morning". Common phrases: "good idea", "good job", "be good at". Very common in all contexts. Brazilian learners should note: "good at" (skill) vs "good in" (less common).',
  register = 'neutral',
  variety = 'international',
  examples = '["This is good work.", "She is good at English.", "Good morning!", "That''s a good idea."]'::jsonb,
  collocations = '["good morning", "good idea", "good job", "good at", "very good"]'::jsonb,
  patterns = '["good + noun", "be good at", "good morning/afternoon", "very good"]'::jsonb,
  updated_at = now()
WHERE headword = 'good';

-- Adjective: bad
UPDATE lexicon_entries
SET
  ipa = 'bæd',
  definition_simple = 'of poor quality or unpleasant and unsatisfactory',
  definition_teacher = 'adjective: also noun; expresses negative quality, harm, or severity; neutral register; irregular comparative (worse, worst); fundamental negative descriptor',
  usage_notes = 'Essential negative adjective. Quality: "bad work". Severity: "bad problem". Skill: "bad at math". Common phrases: "too bad" (unfortunate), "not bad" (quite good). Very common in all contexts. Brazilian learners should note: "not bad" is actually positive.',
  register = 'neutral',
  variety = 'international',
  examples = '["This is bad news.", "I''m bad at math.", "The weather is bad today.", "That''s too bad."]'::jsonb,
  collocations = '["bad news", "too bad", "not bad", "bad at", "bad idea"]'::jsonb,
  patterns = '["bad + noun", "be bad at", "too bad", "not bad"]'::jsonb,
  updated_at = now()
WHERE headword = 'bad';

-- Adjective: big
UPDATE lexicon_entries
SET
  ipa = 'bɪɡ',
  definition_simple = 'large in size, amount, or importance',
  definition_teacher = 'adjective: expresses large size, significance, or importance; neutral register; fundamental size descriptor',
  usage_notes = 'Essential size/importance adjective. Size: "big house". Importance: "big problem", "big deal". Common phrases: "big company", "big difference". Very common in all contexts. Brazilian learners should note: "big" for size/importance, "large" more formal.',
  register = 'neutral',
  variety = 'international',
  examples = '["This is a big company.", "We have a big problem.", "That''s a big difference.", "It''s not a big deal."]'::jsonb,
  collocations = '["big company", "big problem", "big difference", "big deal", "very big"]'::jsonb,
  patterns = '["big + noun", "very big", "not a big deal"]'::jsonb,
  updated_at = now()
WHERE headword = 'big';

-- Adjective: small
UPDATE lexicon_entries
SET
  ipa = 'smɔːl',
  definition_simple = 'little in size, amount, or importance',
  definition_teacher = 'adjective: expresses little size, limited quantity, or minor importance; neutral register; fundamental size descriptor',
  usage_notes = 'Essential size/importance adjective. Size: "small office". Quantity: "small number". Importance: "small problem". Common phrases: "small business", "small talk" (casual conversation). Very common in all contexts. Brazilian learners should note: "small" for size, "little" for size or quantity.',
  register = 'neutral',
  variety = 'international',
  examples = '["We have a small office.", "It''s a small problem.", "She owns a small business.", "Let''s make small talk."]'::jsonb,
  collocations = '["small business", "small problem", "small talk", "small number", "very small"]'::jsonb,
  patterns = '["small + noun", "very small", "small talk"]'::jsonb,
  updated_at = now()
WHERE headword = 'small';

-- Adjective: new
UPDATE lexicon_entries
SET
  ipa = 'njuː',
  definition_simple = 'recently made, built, or created, or not used before',
  definition_teacher = 'adjective: expresses recent creation, unfamiliarity, or replacement; neutral register; fundamental temporal descriptor',
  usage_notes = 'Essential newness adjective. Recent: "new product". Unused: "new car". Replacement: "new job". Common phrases: "brand new", "new to" (unfamiliar with). Very common in all contexts. Brazilian learners should note: "new" (recently created) vs "novel" (innovative).',
  register = 'neutral',
  variety = 'international',
  examples = '["We have a new product.", "I started a new job.", "This is brand new.", "I''m new to this company."]'::jsonb,
  collocations = '["new product", "new job", "brand new", "new to", "new employee"]'::jsonb,
  patterns = '["new + noun", "brand new", "new to + noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'new';

-- Adjective: old
UPDATE lexicon_entries
SET
  ipa = 'əʊld',
  definition_simple = 'having existed for a long time or used for age',
  definition_teacher = 'adjective: expresses age, long existence, or former status; neutral register; fundamental temporal descriptor',
  usage_notes = 'Essential age adjective. Age: "30 years old". Long existence: "old building". Former: "old job". Common phrases: "how old", "years old", "old friend" (long-time friend). Very common in all contexts. Brazilian learners should note: "years old" for age (not "have years").',
  register = 'neutral',
  variety = 'international',
  examples = '["How old are you?", "I''m 30 years old.", "This is an old building.", "She''s an old friend."]'::jsonb,
  collocations = '["years old", "how old", "old friend", "old building", "old job"]'::jsonb,
  patterns = '["number + years old", "how old", "old + noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'old';

-- Adjective: important
UPDATE lexicon_entries
SET
  ipa = 'ɪmˈpɔːtənt',
  definition_simple = 'having great value, significance, or effect',
  definition_teacher = 'adjective: expresses significance, value, or priority; neutral register; fundamental importance descriptor',
  usage_notes = 'Essential importance adjective. Significance: "important meeting". Priority: "important to do". Common phrases: "very important", "most important", "it''s important that". Very common in professional contexts. Brazilian learners should note: "important to do" or "important that we do".',
  register = 'neutral',
  variety = 'international',
  examples = '["This is an important meeting.", "It''s important to finish on time.", "The most important thing is quality.", "This is very important."]'::jsonb,
  collocations = '["very important", "most important", "important meeting", "important to", "it''s important"]'::jsonb,
  patterns = '["important + noun", "important + to-infinitive", "important + that clause", "very/most important"]'::jsonb,
  updated_at = now()
WHERE headword = 'important';

-- Adjective: different
UPDATE lexicon_entries
SET
  ipa = 'ˈdɪfrənt',
  definition_simple = 'not the same as another or each other',
  definition_teacher = 'adjective: expresses distinction, variety, or change; neutral register; fundamental comparison descriptor',
  usage_notes = 'Essential difference adjective. Distinction: "different from/than". Variety: "different options". Change: "something different". Common phrases: "very different", "different from". Very common in comparisons. Brazilian learners should note: "different from" (preferred) or "different than" (US informal).',
  register = 'neutral',
  variety = 'international',
  examples = '["This is different from the other one.", "We have different options.", "Let''s try something different.", "They are very different."]'::jsonb,
  collocations = '["different from", "very different", "different options", "something different", "different than"]'::jsonb,
  patterns = '["different + from/than", "very different", "something different"]'::jsonb,
  updated_at = now()
WHERE headword = 'different';

-- Adjective: same
UPDATE lexicon_entries
SET
  ipa = 'seɪm',
  definition_simple = 'exactly like another or not changed',
  definition_teacher = 'adjective/pronoun: expresses identity, similarity, or lack of change; neutral register; always used with "the"; fundamental identity descriptor',
  usage_notes = 'Essential identity adjective. Always "the same": "the same thing". Similarity: "the same as". Unchanged: "still the same". Common phrases: "at the same time", "the same way". Very common in comparisons. Brazilian learners should note: always use "the" before "same".',
  register = 'neutral',
  variety = 'international',
  examples = '["We have the same problem.", "This is the same as before.", "At the same time, we need to save money.", "It''s still the same."]'::jsonb,
  collocations = '["the same", "the same as", "at the same time", "the same way", "still the same"]'::jsonb,
  patterns = '["the same + noun", "the same as", "at the same time"]'::jsonb,
  updated_at = now()
WHERE headword = 'same';


-- Adjective: right
UPDATE lexicon_entries
SET
  ipa = 'raɪt',
  definition_simple = 'correct or true, or on the side opposite to left',
  definition_teacher = 'adjective/noun/adverb: multiple meanings including correct, appropriate, direction, or entitlement; neutral register; highly versatile term',
  usage_notes = 'Versatile term. Correct: "right answer". Direction: "turn right". Entitlement: "human rights". Common phrases: "that''s right" (correct), "right now" (immediately), "all right" (okay). Very common in all contexts. Multiple meanings require context.',
  register = 'neutral',
  variety = 'international',
  examples = '["That''s the right answer.", "Turn right at the corner.", "You have the right to know.", "I need it right now."]'::jsonb,
  collocations = '["that''s right", "right now", "right answer", "turn right", "all right"]'::jsonb,
  patterns = '["right + noun", "that''s right", "right now", "turn right"]'::jsonb,
  updated_at = now()
WHERE headword = 'right';

-- Adjective: wrong
UPDATE lexicon_entries
SET
  ipa = 'rɒŋ',
  definition_simple = 'not correct or not suitable',
  definition_teacher = 'adjective/noun/adverb: expresses incorrectness, inappropriateness, or malfunction; neutral register; fundamental error descriptor',
  usage_notes = 'Essential error adjective. Incorrect: "wrong answer". Inappropriate: "wrong time". Malfunction: "something is wrong". Common phrases: "go wrong" (fail), "what''s wrong?" (what''s the problem?). Very common in problem identification. Brazilian learners should note: "what''s wrong?" for problems.',
  register = 'neutral',
  variety = 'international',
  examples = '["That''s the wrong answer.", "What''s wrong?", "Something went wrong.", "This is the wrong file."]'::jsonb,
  collocations = '["what''s wrong", "go wrong", "wrong answer", "something wrong", "wrong time"]'::jsonb,
  patterns = '["wrong + noun", "what''s wrong", "go wrong", "something is wrong"]'::jsonb,
  updated_at = now()
WHERE headword = 'wrong';

-- Adjective: ready
UPDATE lexicon_entries
SET
  ipa = 'ˈredi',
  definition_simple = 'prepared and able to do something or be used',
  definition_teacher = 'adjective: expresses preparedness, willingness, or availability; neutral register; fundamental readiness descriptor',
  usage_notes = 'Essential readiness adjective. Prepared: "I''m ready". Willing: "ready to help". Available: "dinner is ready". Common phrases: "get ready", "ready for", "ready to go". Very common in all contexts. Brazilian learners should note: "ready to do" or "ready for something".',
  register = 'neutral',
  variety = 'international',
  examples = '["I''m ready to start.", "Are you ready for the meeting?", "The report is ready.", "Get ready to leave."]'::jsonb,
  collocations = '["get ready", "ready to", "ready for", "ready to go", "are you ready"]'::jsonb,
  patterns = '["ready + to-infinitive", "ready + for", "get ready"]'::jsonb,
  updated_at = now()
WHERE headword = 'ready';

-- ============================================================================
-- ADDITIONAL COMMON VERBS (8 words)
-- ============================================================================

-- Verb: make
UPDATE lexicon_entries
SET
  ipa = 'meɪk',
  definition_simple = 'to create, produce, or cause something to happen',
  definition_teacher = 'verb: transitive; highly versatile meaning including creating, causing, or forcing; neutral register; irregular past (made); fundamental causative verb',
  usage_notes = 'Highly versatile verb. Create: "make a plan". Cause: "make someone happy". Force: "make someone do". Common phrases: "make a decision", "make sure", "make sense". Very common in all contexts. Brazilian learners should note: "make" vs "do" distinction.',
  register = 'neutral',
  variety = 'international',
  examples = '["Let''s make a plan.", "This makes sense.", "Make sure to check your email.", "She made a good decision."]'::jsonb,
  collocations = '["make a decision", "make sure", "make sense", "make a plan", "make someone do"]'::jsonb,
  patterns = '["make + noun", "make + adjective", "make + person + verb", "make sure"]'::jsonb,
  updated_at = now()
WHERE headword = 'make';

-- Verb: do
UPDATE lexicon_entries
SET
  ipa = 'duː',
  definition_simple = 'to perform an action or activity',
  definition_teacher = 'verb: transitive or auxiliary; expresses action, completion, or forms questions/negatives; neutral register; irregular past (did, done); fundamental action verb',
  usage_notes = 'Highly versatile verb. Action: "do work". Auxiliary: "do you know?". Common phrases: "do business", "do your best", "have to do with" (relate to). Very common in all contexts. Brazilian learners should note: "do" for actions, "make" for creating.',
  register = 'neutral',
  variety = 'international',
  examples = '["What do you do?", "I do my best.", "We do business with them.", "This has to do with the project."]'::jsonb,
  collocations = '["do business", "do your best", "what do you do", "have to do with", "do work"]'::jsonb,
  patterns = '["do + noun", "do + your best", "what do you + verb", "have to do with"]'::jsonb,
  updated_at = now()
WHERE headword = 'do';

-- Verb: get
UPDATE lexicon_entries
SET
  ipa = 'ɡet',
  definition_simple = 'to obtain, receive, or become',
  definition_teacher = 'verb: transitive or intransitive; highly versatile meaning including obtaining, receiving, becoming, or arriving; neutral register; irregular past (got, gotten/got)',
  usage_notes = 'Highly versatile verb. Obtain: "get a job". Receive: "get an email". Become: "get tired". Arrive: "get home". Common phrases: "get to" (arrive), "get ready", "get started". Very common in all contexts. Multiple meanings require context.',
  register = 'neutral',
  variety = 'international',
  examples = '["I need to get more information.", "Did you get my email?", "I''m getting tired.", "Let''s get started."]'::jsonb,
  collocations = '["get started", "get ready", "get to", "get an email", "get tired"]'::jsonb,
  patterns = '["get + noun", "get + adjective", "get + to + place", "get started/ready"]'::jsonb,
  updated_at = now()
WHERE headword = 'get';

-- Verb: go
UPDATE lexicon_entries
SET
  ipa = 'ɡəʊ',
  definition_simple = 'to move or travel to a place',
  definition_teacher = 'verb: intransitive; expresses movement, departure, or progression; neutral register; irregular past (went, gone); fundamental movement verb',
  usage_notes = 'Essential movement verb. Travel: "go to work". Depart: "I have to go". Progress: "how is it going?". Common phrases: "go ahead" (proceed), "let''s go", "go on" (continue). Very common in all contexts. Brazilian learners should note: "go to" for destinations.',
  register = 'neutral',
  variety = 'international',
  examples = '["I go to work every day.", "Let''s go to the meeting.", "How is it going?", "Go ahead and start."]'::jsonb,
  collocations = '["go to work", "let''s go", "go ahead", "how is it going", "go on"]'::jsonb,
  patterns = '["go + to + place", "let''s go", "go ahead", "how is it going"]'::jsonb,
  updated_at = now()
WHERE headword = 'go';

-- Verb: come
UPDATE lexicon_entries
SET
  ipa = 'kʌm',
  definition_simple = 'to move toward or arrive at a place',
  definition_teacher = 'verb: intransitive; expresses movement toward speaker or arrival; neutral register; irregular past (came, come); fundamental movement verb',
  usage_notes = 'Essential movement verb. Toward speaker: "come here". Arrive: "I will come tomorrow". Origin: "come from Brazil". Common phrases: "come on" (hurry/encouragement), "come back", "come up with" (think of). Very common in all contexts. Brazilian learners should note: "come" (toward) vs "go" (away).',
  register = 'neutral',
  variety = 'international',
  examples = '["Please come to my office.", "I come from Brazil.", "Come on, let''s go!", "She came up with a great idea."]'::jsonb,
  collocations = '["come here", "come from", "come on", "come back", "come up with"]'::jsonb,
  patterns = '["come + to + place", "come + from", "come on", "come up with"]'::jsonb,
  updated_at = now()
WHERE headword = 'come';

-- Verb: use
UPDATE lexicon_entries
SET
  ipa = 'juːz',
  definition_simple = 'to employ something for a purpose',
  definition_teacher = 'verb: transitive; also noun /juːs/; expresses employment, consumption, or exploitation; neutral register; fundamental utilization verb',
  usage_notes = 'Essential utilization verb. Employ: "use a computer". Consume: "use time". Common phrases: "use to" (past habit - pronounced /juːst/), "used to" (accustomed). Very common in all contexts. Note: verb /juːz/ vs noun /juːs/. Brazilian learners should note: "used to" for past habits.',
  register = 'neutral',
  variety = 'international',
  examples = '["I use this software every day.", "We used to work together.", "How do you use this?", "This is easy to use."]'::jsonb,
  collocations = '["use to", "used to", "easy to use", "use this", "use for"]'::jsonb,
  patterns = '["use + noun", "used to + verb", "use + for", "easy to use"]'::jsonb,
  updated_at = now()
WHERE headword = 'use';

-- Verb: work
UPDATE lexicon_entries
SET
  ipa = 'wɜːk',
  definition_simple = 'to do a job or to function correctly',
  definition_teacher = 'verb: intransitive or transitive; also noun; expresses employment, functioning, or effort; neutral register; fundamental labor verb',
  usage_notes = 'Essential labor/function verb. Employment: "work at a company". Function: "it works". Effort: "work hard". Common phrases: "work on" (focus on), "work out" (exercise/solve). Very common in professional contexts. Brazilian learners should note: "work at" for companies.',
  register = 'neutral',
  variety = 'international',
  examples = '["I work at a technology company.", "Does this solution work?", "Let''s work on the project.", "I work out every morning."]'::jsonb,
  collocations = '["work at", "work on", "work out", "work hard", "it works"]'::jsonb,
  patterns = '["work + at + company", "work + on + project", "work out", "it works"]'::jsonb,
  updated_at = now()
WHERE headword = 'work';

-- Verb: start
UPDATE lexicon_entries
SET
  ipa = 'stɑːt',
  definition_simple = 'to begin doing something or to cause something to begin',
  definition_teacher = 'verb: transitive or intransitive; also noun; expresses beginning, initiation, or departure; neutral register; fundamental initiation verb',
  usage_notes = 'Essential beginning verb. Begin action: "start working". Initiate: "start a project". Depart: "start early". Common phrases: "get started", "to start with" (firstly), "start over" (begin again). Very common in all contexts. Brazilian learners should note: "start doing" or "start to do".',
  register = 'neutral',
  variety = 'international',
  examples = '["Let''s start the meeting.", "I start work at 9 AM.", "We need to start planning.", "To start with, let me explain."]'::jsonb,
  collocations = '["get started", "start working", "to start with", "start over", "start early"]'::jsonb,
  patterns = '["start + noun", "start + -ing/to-infinitive", "get started", "to start with"]'::jsonb,
  updated_at = now()
WHERE headword = 'start';

-- End of Batch 7
