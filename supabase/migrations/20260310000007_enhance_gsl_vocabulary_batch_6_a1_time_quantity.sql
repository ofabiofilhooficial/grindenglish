-- Migration: Enhance GSL Vocabulary - Batch 6 (A1 Time and Quantity)
-- Description: Add comprehensive linguistic data for third batch of A1 words
-- Words: Time expressions (today, tomorrow, yesterday, week, month, year, hour, minute, etc.)
--        Quantity words (many, much, few, little, some, all, every, each, most, etc.)
--        Temporal concepts (now, then, when, while, during, before, after, etc.)
-- Target: ~150 A1 words focused on time and quantity expressions
-- Focus: Brazilian professionals learning temporal and quantitative communication

-- ============================================================================
-- TIME NOUNS (12 words)
-- ============================================================================

-- Noun: time
UPDATE lexicon_entries
SET
  ipa = 'taɪm',
  definition_simple = 'the thing that is measured in minutes, hours, days, etc.',
  definition_teacher = 'noun: uncountable (general concept) or countable (occasion/instance); also verb meaning to measure duration or schedule; neutral register; fundamental temporal term',
  usage_notes = 'Essential time term. Uncountable: "have time", "no time", "save time". Countable: "three times" (occasions), "a good time" (experience). Common phrases: "on time" (punctual), "in time" (before deadline), "at the same time". Very common in all contexts.',
  register = 'neutral',
  variety = 'international',
  examples = '["I don''t have time right now.", "The meeting is on time.", "We visited Paris three times.", "What time is it?"]'::jsonb,
  collocations = '["have time", "on time", "in time", "at the same time", "what time", "save time"]'::jsonb,
  patterns = '["have time", "on/in time", "what time", "time + to-infinitive"]'::jsonb,
  updated_at = now()
WHERE headword = 'time';

-- Noun: day
UPDATE lexicon_entries
SET
  ipa = 'deɪ',
  definition_simple = 'a period of 24 hours',
  definition_teacher = 'noun: countable; refers to 24-hour period, daylight hours, or era; neutral register; fundamental temporal unit',
  usage_notes = 'Essential time unit. Common phrases: "every day", "all day", "one day" (someday), "these days" (nowadays), "day by day". Very common in scheduling and planning. Brazilian learners should note: "every day" (always) vs "everyday" (adjective meaning common).',
  register = 'neutral',
  variety = 'international',
  examples = '["I work every day.", "Have a nice day!", "One day I will visit Japan.", "The meeting is in three days."]'::jsonb,
  collocations = '["every day", "all day", "one day", "these days", "day by day", "nice day"]'::jsonb,
  patterns = '["every day", "all day", "in + number + days", "one day"]'::jsonb,
  updated_at = now()
WHERE headword = 'day';

-- Noun: week
UPDATE lexicon_entries
SET
  ipa = 'wiːk',
  definition_simple = 'a period of seven days',
  definition_teacher = 'noun: countable; refers to seven-day period, typically Monday to Sunday or Sunday to Saturday; neutral register; fundamental temporal unit',
  usage_notes = 'Essential time unit. Common phrases: "this week", "next week", "last week", "every week", "per week". Very common in scheduling and planning. Brazilian learners should note: "in a week" (after seven days) vs "in one week" (same meaning).',
  register = 'neutral',
  variety = 'international',
  examples = '["The deadline is next week.", "I exercise three times a week.", "We met last week.", "This week is very busy."]'::jsonb,
  collocations = '["this week", "next week", "last week", "every week", "per week", "times a week"]'::jsonb,
  patterns = '["this/next/last week", "in a week", "per week", "times a week"]'::jsonb,
  updated_at = now()
WHERE headword = 'week';

-- Noun: month
UPDATE lexicon_entries
SET
  ipa = 'mʌnθ',
  definition_simple = 'one of the twelve periods of time that a year is divided into',
  definition_teacher = 'noun: countable; refers to calendar month or approximately 30-day period; neutral register; fundamental temporal unit',
  usage_notes = 'Essential time unit. Common phrases: "this month", "next month", "last month", "every month", "per month". Very common in business planning and scheduling. Brazilian learners should note pronunciation: /mʌnθ/ (not /mɔnθ/).',
  register = 'neutral',
  variety = 'international',
  examples = '["The report is due next month.", "I travel once a month.", "Last month was very productive.", "We pay rent every month."]'::jsonb,
  collocations = '["this month", "next month", "last month", "every month", "per month", "once a month"]'::jsonb,
  patterns = '["this/next/last month", "in a month", "per month", "once a month"]'::jsonb,
  updated_at = now()
WHERE headword = 'month';

-- Noun: year
UPDATE lexicon_entries
SET
  ipa = 'jɪə',
  definition_simple = 'a period of 365 or 366 days',
  definition_teacher = 'noun: countable; refers to calendar year or 12-month period; neutral register; fundamental temporal unit',
  usage_notes = 'Essential time unit. Common phrases: "this year", "next year", "last year", "every year", "per year", "years old" (age). Very common in planning and age expressions. Brazilian learners should note: "I am 30 years old" (not "I have 30 years").',
  register = 'neutral',
  variety = 'international',
  examples = '["I started this job last year.", "She is 25 years old.", "We plan to expand next year.", "The company was founded in 2010."]'::jsonb,
  collocations = '["this year", "next year", "last year", "every year", "years old", "per year"]'::jsonb,
  patterns = '["this/next/last year", "number + years old", "in + year", "per year"]'::jsonb,
  updated_at = now()
WHERE headword = 'year';


-- Noun: hour
UPDATE lexicon_entries
SET
  ipa = 'aʊə',
  definition_simple = 'a period of 60 minutes',
  definition_teacher = 'noun: countable; refers to 60-minute period or time of day; neutral register; fundamental temporal unit',
  usage_notes = 'Essential time unit. Common phrases: "per hour", "office hours", "rush hour", "an hour ago", "half an hour". Very common in scheduling and duration expressions. Brazilian learners should note: silent "h" in pronunciation /aʊə/.',
  register = 'neutral',
  variety = 'international',
  examples = '["The meeting lasts one hour.", "I will arrive in two hours.", "Office hours are 9 to 5.", "We left an hour ago."]'::jsonb,
  collocations = '["per hour", "office hours", "rush hour", "an hour ago", "half an hour"]'::jsonb,
  patterns = '["number + hours", "per hour", "in + number + hours", "an hour + ago"]'::jsonb,
  updated_at = now()
WHERE headword = 'hour';

-- Noun: minute
UPDATE lexicon_entries
SET
  ipa = 'ˈmɪnɪt',
  definition_simple = 'a period of 60 seconds',
  definition_teacher = 'noun: countable; refers to 60-second period; also adjective /maɪˈnjuːt/ meaning very small; neutral register; fundamental temporal unit',
  usage_notes = 'Essential time unit. Common phrases: "in a minute" (soon), "just a minute" (wait), "per minute", "last minute" (final moment). Very common in short duration expressions. Note: noun /ˈmɪnɪt/ vs adjective /maɪˈnjuːt/ (tiny).',
  register = 'neutral',
  variety = 'international',
  examples = '["Wait a minute, please.", "The presentation is 10 minutes long.", "I will be ready in a few minutes.", "We finished at the last minute."]'::jsonb,
  collocations = '["a minute", "just a minute", "in a minute", "per minute", "last minute", "few minutes"]'::jsonb,
  patterns = '["number + minutes", "in a minute", "just a minute", "last minute"]'::jsonb,
  updated_at = now()
WHERE headword = 'minute';

-- Noun: moment
UPDATE lexicon_entries
SET
  ipa = 'ˈməʊmənt',
  definition_simple = 'a very short period of time',
  definition_teacher = 'noun: countable; refers to brief instant or particular point in time; neutral register; common temporal expression',
  usage_notes = 'Common time expression. Phrases: "at the moment" (now), "in a moment" (soon), "just a moment" (wait), "for a moment" (briefly). Very common in polite requests and current time references. Brazilian learners should note: "at the moment" means "right now".',
  register = 'neutral',
  variety = 'international',
  examples = '["Just a moment, please.", "I am busy at the moment.", "She will arrive in a moment.", "Can I speak with you for a moment?"]'::jsonb,
  collocations = '["at the moment", "in a moment", "just a moment", "for a moment", "this moment"]'::jsonb,
  patterns = '["at the moment", "in/for a moment", "just a moment"]'::jsonb,
  updated_at = now()
WHERE headword = 'moment';

-- Adverb: today
UPDATE lexicon_entries
SET
  ipa = 'təˈdeɪ',
  definition_simple = 'on this day or during this day',
  definition_teacher = 'adverb: also noun; refers to current day or present time; neutral register; fundamental temporal reference',
  usage_notes = 'Essential time reference. Common phrases: "today''s meeting", "earlier today", "later today". No preposition needed: "I work today" (not "in today"). Very common in scheduling. Brazilian learners should note: no article needed ("today" not "the today").',
  register = 'neutral',
  variety = 'international',
  examples = '["I have a meeting today.", "Today is Monday.", "Earlier today, I sent an email.", "What are you doing today?"]'::jsonb,
  collocations = '["earlier today", "later today", "today''s meeting", "as of today"]'::jsonb,
  patterns = '["verb + today", "earlier/later today", "today''s + noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'today';

-- Adverb: tomorrow
UPDATE lexicon_entries
SET
  ipa = 'təˈmɒrəʊ',
  definition_simple = 'on the day after today',
  definition_teacher = 'adverb: also noun; refers to next day or future time; neutral register; fundamental temporal reference',
  usage_notes = 'Essential time reference. Common phrases: "tomorrow morning", "tomorrow''s deadline", "see you tomorrow". No preposition needed: "I work tomorrow" (not "in tomorrow"). Very common in scheduling. Brazilian learners should note: no article needed.',
  register = 'neutral',
  variety = 'international',
  examples = '["The meeting is tomorrow.", "I will call you tomorrow.", "Tomorrow morning at 9 AM.", "See you tomorrow!"]'::jsonb,
  collocations = '["tomorrow morning", "tomorrow''s deadline", "see you tomorrow", "tomorrow afternoon"]'::jsonb,
  patterns = '["verb + tomorrow", "tomorrow + morning/afternoon", "tomorrow''s + noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'tomorrow';

-- Adverb: yesterday
UPDATE lexicon_entries
SET
  ipa = 'ˈjestədeɪ',
  definition_simple = 'on the day before today',
  definition_teacher = 'adverb: also noun; refers to previous day or recent past; neutral register; fundamental temporal reference',
  usage_notes = 'Essential time reference. Common phrases: "yesterday morning", "yesterday''s meeting". No preposition needed: "I worked yesterday" (not "in yesterday"). Very common in past time references. Brazilian learners should note: no article needed.',
  register = 'neutral',
  variety = 'international',
  examples = '["I sent the email yesterday.", "Yesterday was very busy.", "We met yesterday afternoon.", "Yesterday''s presentation was good."]'::jsonb,
  collocations = '["yesterday morning", "yesterday afternoon", "yesterday''s meeting", "since yesterday"]'::jsonb,
  patterns = '["verb + yesterday", "yesterday + morning/afternoon", "yesterday''s + noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'yesterday';

-- Adverb: now
UPDATE lexicon_entries
SET
  ipa = 'naʊ',
  definition_simple = 'at the present time or at this moment',
  definition_teacher = 'adverb: also conjunction; refers to present moment or current situation; neutral register; fundamental temporal reference',
  usage_notes = 'Essential present time reference. Common phrases: "right now" (immediately), "for now" (temporarily), "by now" (already), "now that" (since/because). Very common in all contexts. Brazilian learners should note: "right now" emphasizes immediacy.',
  register = 'neutral',
  variety = 'international',
  examples = '["I am working now.", "We need to decide right now.", "For now, this solution works.", "By now, everyone should know."]'::jsonb,
  collocations = '["right now", "for now", "by now", "now that", "just now"]'::jsonb,
  patterns = '["right now", "for now", "by now", "now + that clause"]'::jsonb,
  updated_at = now()
WHERE headword = 'now';

-- ============================================================================
-- QUANTITY DETERMINERS AND PRONOUNS (15 words)
-- ============================================================================

-- Determiner/Pronoun: many
UPDATE lexicon_entries
SET
  ipa = 'ˈmeni',
  definition_simple = 'a large number of people or things',
  definition_teacher = 'determiner/pronoun: used with countable nouns; refers to large quantity; neutral register; fundamental quantifier',
  usage_notes = 'Essential quantity word for countable nouns. Use "many" with countable: "many people", "many times". Questions: "how many?". Negative: "not many". Compare with "much" (uncountable). Brazilian learners often confuse "many" and "much".',
  register = 'neutral',
  variety = 'international',
  examples = '["Many people attended the meeting.", "How many employees do you have?", "There are not many options.", "I have been there many times."]'::jsonb,
  collocations = '["many people", "many times", "how many", "not many", "so many", "too many"]'::jsonb,
  patterns = '["many + countable noun", "how many", "not/so/too many"]'::jsonb,
  updated_at = now()
WHERE headword = 'many';

-- Determiner/Pronoun: much
UPDATE lexicon_entries
SET
  ipa = 'mʌtʃ',
  definition_simple = 'a large amount of something',
  definition_teacher = 'determiner/pronoun/adverb: used with uncountable nouns; refers to large quantity or degree; neutral register; fundamental quantifier',
  usage_notes = 'Essential quantity word for uncountable nouns. Use "much" with uncountable: "much time", "much money". Questions: "how much?". Negative: "not much". Also adverb: "much better". Compare with "many" (countable). Brazilian learners often confuse these.',
  register = 'neutral',
  variety = 'international',
  examples = '["How much time do we have?", "There is not much information.", "This is much better.", "Thank you very much."]'::jsonb,
  collocations = '["how much", "not much", "so much", "too much", "very much", "much better"]'::jsonb,
  patterns = '["much + uncountable noun", "how much", "not/so/too much", "much + comparative"]'::jsonb,
  updated_at = now()
WHERE headword = 'much';


-- Determiner/Pronoun: some
UPDATE lexicon_entries
SET
  ipa = 'sʌm',
  definition_simple = 'an amount or number that is not stated exactly',
  definition_teacher = 'determiner/pronoun: used with both countable and uncountable nouns; refers to unspecified quantity; neutral register; fundamental quantifier',
  usage_notes = 'Versatile quantity word. Countable: "some people". Uncountable: "some water". Offers: "Would you like some coffee?". Positive contexts preferred. Compare "any" (questions/negatives). Brazilian learners should note: "some" in offers, "any" in questions.',
  register = 'neutral',
  variety = 'international',
  examples = '["I need some help.", "Some people prefer tea.", "Would you like some coffee?", "Can I have some information?"]'::jsonb,
  collocations = '["some people", "some time", "some help", "some information", "would you like some"]'::jsonb,
  patterns = '["some + noun", "would you like some", "some + of"]'::jsonb,
  updated_at = now()
WHERE headword = 'some';

-- Determiner/Pronoun: any
UPDATE lexicon_entries
SET
  ipa = 'ˈeni',
  definition_simple = 'some, or even the smallest amount or number',
  definition_teacher = 'determiner/pronoun: used with both countable and uncountable nouns; typically in questions and negatives; neutral register; fundamental quantifier',
  usage_notes = 'Essential quantity word for questions and negatives. Questions: "Do you have any questions?". Negatives: "I don''t have any time". Positive: "any person" (whoever). Compare "some" (positive contexts). Brazilian learners often confuse these.',
  register = 'neutral',
  variety = 'international',
  examples = '["Do you have any questions?", "I don''t have any information.", "Any employee can apply.", "Is there any coffee left?"]'::jsonb,
  collocations = '["any questions", "any time", "any information", "not any", "if any"]'::jsonb,
  patterns = '["any + noun", "do you have any", "not any", "if any"]'::jsonb,
  updated_at = now()
WHERE headword = 'any';

-- Determiner/Pronoun: all
UPDATE lexicon_entries
SET
  ipa = 'ɔːl',
  definition_simple = 'every one of a group, or the whole of something',
  definition_teacher = 'determiner/pronoun/adverb: refers to totality or entirety; neutral register; fundamental universal quantifier',
  usage_notes = 'Essential totality word. With countable: "all people", "all employees". With uncountable: "all time", "all information". Phrases: "all day", "all of us", "not at all" (emphatic negative). Very common in all contexts. Brazilian learners should note: "all" vs "everything".',
  register = 'neutral',
  variety = 'international',
  examples = '["All employees must attend.", "I worked all day.", "All of us agree.", "Thank you. - Not at all."]'::jsonb,
  collocations = '["all day", "all of us", "all employees", "not at all", "all the time"]'::jsonb,
  patterns = '["all + noun", "all of + pronoun", "all day/week/year", "not at all"]'::jsonb,
  updated_at = now()
WHERE headword = 'all';

-- Determiner: every
UPDATE lexicon_entries
SET
  ipa = 'ˈevri',
  definition_simple = 'each one of a group, without exception',
  definition_teacher = 'determiner: used with singular countable nouns; refers to all members individually; neutral register; fundamental distributive quantifier',
  usage_notes = 'Essential distributive word. Always singular: "every person" (not "every persons"). Common phrases: "every day", "every time", "every one" (each individual). Compare "all" (group) vs "every" (individuals). Brazilian learners should note: always singular noun after "every".',
  register = 'neutral',
  variety = 'international',
  examples = '["Every employee receives training.", "I exercise every day.", "Every time I call, you are busy.", "Every one of them agreed."]'::jsonb,
  collocations = '["every day", "every time", "every one", "every employee", "every week"]'::jsonb,
  patterns = '["every + singular noun", "every day/week/month", "every time"]'::jsonb,
  updated_at = now()
WHERE headword = 'every';

-- Determiner/Pronoun: each
UPDATE lexicon_entries
SET
  ipa = 'iːtʃ',
  definition_simple = 'every one of two or more things or people, considered separately',
  definition_teacher = 'determiner/pronoun: used with singular countable nouns; emphasizes individuals in a group; neutral register; distributive quantifier',
  usage_notes = 'Distributive word emphasizing individuals. Always singular: "each person". Phrases: "each of us", "each time", "each other" (reciprocal). More formal than "every". Common in professional contexts. Brazilian learners should note: "each" emphasizes individuals more than "every".',
  register = 'neutral',
  variety = 'international',
  examples = '["Each employee has a desk.", "Each of us has responsibilities.", "We help each other.", "Each time is different."]'::jsonb,
  collocations = '["each of us", "each other", "each time", "each employee", "each person"]'::jsonb,
  patterns = '["each + singular noun", "each of + pronoun", "each other"]'::jsonb,
  updated_at = now()
WHERE headword = 'each';

-- Determiner/Pronoun: most
UPDATE lexicon_entries
SET
  ipa = 'məʊst',
  definition_simple = 'the largest number or amount, or more than half',
  definition_teacher = 'determiner/pronoun/adverb: refers to majority or greatest degree; also forms superlatives; neutral register; fundamental quantifier',
  usage_notes = 'Essential majority word. Determiner: "most people", "most of the time". Superlative: "the most important". Adverb: "most likely". Very common in all contexts. Brazilian learners should note: "most" (majority) vs "the most" (superlative).',
  register = 'neutral',
  variety = 'international',
  examples = '["Most people agree.", "I spend most of my time working.", "This is the most important point.", "She is most likely to succeed."]'::jsonb,
  collocations = '["most people", "most of the time", "the most important", "most likely", "most of us"]'::jsonb,
  patterns = '["most + noun", "most of + noun", "the most + adjective", "most likely"]'::jsonb,
  updated_at = now()
WHERE headword = 'most';

-- Determiner/Pronoun: few
UPDATE lexicon_entries
SET
  ipa = 'fjuː',
  definition_simple = 'a small number of things or people',
  definition_teacher = 'determiner/pronoun: used with countable nouns; refers to small quantity; neutral register; note: "a few" (some) vs "few" (not many)',
  usage_notes = 'Quantity word for countable nouns. "A few" (positive - some): "a few people". "Few" (negative - not many): "few options". Common phrases: "a few minutes", "quite a few" (many). Brazilian learners should note the difference between "a few" and "few".',
  register = 'neutral',
  variety = 'international',
  examples = '["I need a few minutes.", "Few people know about this.", "Quite a few employees attended.", "We have a few options."]'::jsonb,
  collocations = '["a few minutes", "a few people", "quite a few", "few options", "a few days"]'::jsonb,
  patterns = '["a few + countable noun", "few + countable noun", "quite a few"]'::jsonb,
  updated_at = now()
WHERE headword = 'few';

-- Determiner/Pronoun: little
UPDATE lexicon_entries
SET
  ipa = 'ˈlɪtəl',
  definition_simple = 'a small amount of something, or not much',
  definition_teacher = 'determiner/pronoun/adjective: used with uncountable nouns for quantity; also adjective meaning small in size; neutral register; note: "a little" (some) vs "little" (not much)',
  usage_notes = 'Quantity word for uncountable nouns. "A little" (positive - some): "a little time". "Little" (negative - not much): "little information". Also adjective: "little house" (small). Brazilian learners should note: quantity vs size meanings.',
  register = 'neutral',
  variety = 'international',
  examples = '["I need a little help.", "There is little time left.", "She has a little experience.", "We have little information."]'::jsonb,
  collocations = '["a little time", "a little help", "little information", "a little bit", "very little"]'::jsonb,
  patterns = '["a little + uncountable noun", "little + uncountable noun", "a little bit"]'::jsonb,
  updated_at = now()
WHERE headword = 'little';

-- Determiner: other
UPDATE lexicon_entries
SET
  ipa = 'ˈʌðə',
  definition_simple = 'different from or additional to the one already mentioned',
  definition_teacher = 'determiner/pronoun/adjective: refers to alternative, additional, or remaining items; neutral register; fundamental alternative reference',
  usage_notes = 'Essential alternative word. Singular: "the other person" (specific), "another" (one more). Plural: "other people", "the others" (remaining ones). Phrases: "each other", "on the other hand". Very common in comparisons and alternatives.',
  register = 'neutral',
  variety = 'international',
  examples = '["The other option is better.", "Do you have other questions?", "On the other hand, it costs more.", "We help each other."]'::jsonb,
  collocations = '["the other", "other people", "each other", "on the other hand", "other options"]'::jsonb,
  patterns = '["the other + noun", "other + plural noun", "each other", "on the other hand"]'::jsonb,
  updated_at = now()
WHERE headword = 'other';

-- Determiner: another
UPDATE lexicon_entries
SET
  ipa = 'əˈnʌðə',
  definition_simple = 'one more person or thing, or a different one',
  definition_teacher = 'determiner/pronoun: contraction of "an other"; refers to additional or alternative singular item; neutral register; fundamental additive reference',
  usage_notes = 'Essential additional word. Always singular: "another person", "another day". Means "one more" or "a different one". Common phrases: "another time" (later), "one another" (reciprocal). Brazilian learners should note: "another" = "an" + "other".',
  register = 'neutral',
  variety = 'international',
  examples = '["Can I have another coffee?", "Let''s try another approach.", "We can discuss this another time.", "They help one another."]'::jsonb,
  collocations = '["another time", "another day", "another option", "one another", "another way"]'::jsonb,
  patterns = '["another + singular noun", "another time/day", "one another"]'::jsonb,
  updated_at = now()
WHERE headword = 'another';


-- ============================================================================
-- TEMPORAL PREPOSITIONS AND CONJUNCTIONS (10 words)
-- ============================================================================

-- Preposition/Conjunction: before
UPDATE lexicon_entries
SET
  ipa = 'bɪˈfɔː',
  definition_simple = 'at an earlier time than something, or in front of',
  definition_teacher = 'preposition/conjunction/adverb: refers to earlier time or position in front; neutral register; fundamental temporal and spatial term',
  usage_notes = 'Essential time/position word. Time: "before the meeting", "before 5 PM". Position: "before me" (in front). Conjunction: "before you leave". Common phrases: "before long" (soon), "the day before". Very common in scheduling and sequencing.',
  register = 'neutral',
  variety = 'international',
  examples = '["Please arrive before 9 AM.", "I met her before.", "Call me before you leave.", "The day before yesterday."]'::jsonb,
  collocations = '["before the meeting", "before long", "the day before", "before you", "just before"]'::jsonb,
  patterns = '["before + time", "before + noun", "before + clause"]'::jsonb,
  updated_at = now()
WHERE headword = 'before';

-- Preposition/Conjunction: after
UPDATE lexicon_entries
SET
  ipa = 'ˈɑːftə',
  definition_simple = 'at a later time than something, or following in position',
  definition_teacher = 'preposition/conjunction/adverb: refers to later time or position following; neutral register; fundamental temporal and spatial term',
  usage_notes = 'Essential time/position word. Time: "after the meeting", "after 5 PM". Position: "after me" (following). Conjunction: "after you finish". Common phrases: "after all" (despite everything), "day after day". Very common in scheduling and sequencing.',
  register = 'neutral',
  variety = 'international',
  examples = '["Let''s meet after work.", "I will call you after the meeting.", "After you finish, send me the file.", "Day after day, we improve."]'::jsonb,
  collocations = '["after work", "after the meeting", "after all", "day after day", "soon after"]'::jsonb,
  patterns = '["after + time", "after + noun", "after + clause"]'::jsonb,
  updated_at = now()
WHERE headword = 'after';

-- Preposition: during
UPDATE lexicon_entries
SET
  ipa = 'ˈdjʊərɪŋ',
  definition_simple = 'throughout the time that something continues',
  definition_teacher = 'preposition: refers to time period when something happens; neutral register; fundamental temporal term; note: not used with time periods like "two hours"',
  usage_notes = 'Essential time period word. Use with events/periods: "during the meeting", "during the day", "during my vacation". Not with duration: use "for" instead ("for two hours" not "during two hours"). Brazilian learners often confuse "during" and "for".',
  register = 'neutral',
  variety = 'international',
  examples = '["Please turn off phones during the meeting.", "I work during the day.", "During my vacation, I visited Paris.", "What happened during the presentation?"]'::jsonb,
  collocations = '["during the meeting", "during the day", "during the week", "during my vacation", "during this time"]'::jsonb,
  patterns = '["during + event/period", "during + possessive + noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'during';

-- Preposition/Conjunction: while
UPDATE lexicon_entries
SET
  ipa = 'waɪl',
  definition_simple = 'during the time that something is happening',
  definition_teacher = 'conjunction/noun: refers to simultaneous time period; also noun meaning period of time; neutral register; fundamental temporal conjunction',
  usage_notes = 'Essential simultaneity word. Conjunction: "while I work", "while you wait". Noun: "a while" (period), "for a while" (temporarily). Common phrases: "in a while" (soon), "once in a while" (occasionally). Very common for simultaneous actions.',
  register = 'neutral',
  variety = 'international',
  examples = '["I listen to music while I work.", "Please wait while I check.", "I lived there for a while.", "I will call you in a while."]'::jsonb,
  collocations = '["while I work", "for a while", "in a while", "once in a while", "while you wait"]'::jsonb,
  patterns = '["while + clause", "for a while", "in a while", "once in a while"]'::jsonb,
  updated_at = now()
WHERE headword = 'while';

-- Conjunction: when
UPDATE lexicon_entries
SET
  ipa = 'wen',
  definition_simple = 'at what time, or at the time that',
  definition_teacher = 'conjunction/adverb: refers to time of occurrence; used in questions and time clauses; neutral register; fundamental temporal term',
  usage_notes = 'Essential time question and conjunction. Questions: "When is the meeting?". Time clause: "when I arrive", "when you finish". Very common in scheduling and conditional time expressions. Brazilian learners should note: "when" for specific time, "if" for condition.',
  register = 'neutral',
  variety = 'international',
  examples = '["When is the deadline?", "Call me when you arrive.", "I don''t know when she will come.", "When I was young, I lived in Rio."]'::jsonb,
  collocations = '["when is", "when you", "when I", "when we", "I don''t know when"]'::jsonb,
  patterns = '["when + is/are", "when + clause", "I don''t know when"]'::jsonb,
  updated_at = now()
WHERE headword = 'when';

-- Adverb: then
UPDATE lexicon_entries
SET
  ipa = 'ðen',
  definition_simple = 'at that time, or next in order',
  definition_teacher = 'adverb: refers to past/future time or sequence; neutral register; fundamental temporal and sequential term',
  usage_notes = 'Versatile time/sequence word. Past time: "I lived in Rio then". Future: "See you then". Sequence: "First this, then that". Logical: "If..., then...". Common phrases: "by then" (by that time), "since then", "now and then" (occasionally).',
  register = 'neutral',
  variety = 'international',
  examples = '["I was young then.", "See you tomorrow, then.", "First read, then write.", "If you agree, then sign here."]'::jsonb,
  collocations = '["by then", "since then", "now and then", "if... then", "see you then"]'::jsonb,
  patterns = '["by/since then", "first... then", "if... then", "now and then"]'::jsonb,
  updated_at = now()
WHERE headword = 'then';

-- Adverb: already
UPDATE lexicon_entries
SET
  ipa = 'ɔːlˈredi',
  definition_simple = 'before now or before a particular time',
  definition_teacher = 'adverb: indicates action completed before expected time; neutral register; fundamental temporal marker for completed actions',
  usage_notes = 'Essential completion marker. Indicates earlier-than-expected completion: "I already finished", "She already knows". Position: usually mid-sentence or end. Common in present perfect: "I have already done it". Brazilian learners should note: "already" emphasizes earliness.',
  register = 'neutral',
  variety = 'international',
  examples = '["I already sent the email.", "She already knows about it.", "Have you already finished?", "We already discussed this."]'::jsonb,
  collocations = '["already finished", "already know", "already done", "have already", "already sent"]'::jsonb,
  patterns = '["already + past participle", "have already + past participle", "already + verb"]'::jsonb,
  updated_at = now()
WHERE headword = 'already';

-- Adverb: yet
UPDATE lexicon_entries
SET
  ipa = 'jet',
  definition_simple = 'until now or until a particular time',
  definition_teacher = 'adverb/conjunction: indicates action not completed by now; used in questions and negatives; neutral register; fundamental temporal marker',
  usage_notes = 'Essential non-completion marker. Questions: "Have you finished yet?". Negatives: "I haven''t finished yet". Position: usually end of sentence. Conjunction: "yet" (but/however). Brazilian learners should note: "yet" in questions/negatives, "already" in positives.',
  register = 'neutral',
  variety = 'international',
  examples = '["Have you finished yet?", "I haven''t received it yet.", "Not yet.", "It''s simple yet effective."]'::jsonb,
  collocations = '["not yet", "have you... yet", "haven''t... yet", "finished yet", "received yet"]'::jsonb,
  patterns = '["have/has + past participle + yet", "not yet", "yet + adjective"]'::jsonb,
  updated_at = now()
WHERE headword = 'yet';

-- Adverb: still
UPDATE lexicon_entries
SET
  ipa = 'stɪl',
  definition_simple = 'continuing to happen or be true up to now or a particular time',
  definition_teacher = 'adverb/adjective: indicates continuation of state or action; neutral register; fundamental continuity marker; also adjective meaning motionless',
  usage_notes = 'Essential continuation marker. Indicates ongoing state: "I still work here", "She is still busy". Position: before main verb, after "be". Common phrases: "still not" (continuing negative). Brazilian learners should note: "still" for continuation, "yet" for non-completion.',
  register = 'neutral',
  variety = 'international',
  examples = '["I still work at the same company.", "She is still in the meeting.", "Do you still live in São Paulo?", "I still don''t understand."]'::jsonb,
  collocations = '["still work", "still live", "still not", "still have", "still waiting"]'::jsonb,
  patterns = '["still + verb", "be + still + adjective", "still + not"]'::jsonb,
  updated_at = now()
WHERE headword = 'still';

-- Adverb: soon
UPDATE lexicon_entries
SET
  ipa = 'suːn',
  definition_simple = 'in or after a short time from now',
  definition_teacher = 'adverb: refers to near future time; neutral register; fundamental temporal reference for imminent events',
  usage_notes = 'Essential near-future marker. Common phrases: "see you soon", "as soon as" (immediately when), "soon after", "sooner or later" (eventually). Very common in scheduling and promises. Brazilian learners should note: "as soon as" for immediate sequence.',
  register = 'neutral',
  variety = 'international',
  examples = '["I will call you soon.", "See you soon!", "As soon as I arrive, I will email you.", "The meeting will start soon."]'::jsonb,
  collocations = '["see you soon", "as soon as", "soon after", "very soon", "sooner or later"]'::jsonb,
  patterns = '["will + verb + soon", "as soon as + clause", "soon after"]'::jsonb,
  updated_at = now()
WHERE headword = 'soon';

-- End of Batch 6
