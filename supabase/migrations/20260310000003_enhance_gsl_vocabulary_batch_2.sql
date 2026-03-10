-- Migration: Enhance GSL Vocabulary - Batch 2 (A0 Common Nouns and Basic Adjectives)
-- Description: Add comprehensive linguistic data for second batch of A0 words
-- Words: Common nouns (time, person, year, way, day, thing, man, world, life, hand, part, child, eye, woman, place, work, case, point, government, company, number, group, problem, fact, etc.)
--        Basic adjectives (good, new, first, last, long, great, little, own, other, old, right, big, high, different, small, large, next, early, young, important, few, public, bad, same, able, etc.)
-- Target: ~150 A0 words (common nouns and adjectives)

-- ============================================================================
-- COMMON NOUNS - TIME AND LIFE (20 words)
-- ============================================================================

-- Noun: time
UPDATE lexicon_entries
SET
  ipa = 'taɪm',
  definition_simple = 'the minutes, hours, days, or years when something happens',
  definition_teacher = 'noun: uncountable/countable; refers to the continuous passage of moments, or specific points/periods; highly versatile with multiple meanings including duration, occasion, era; neutral register',
  usage_notes = 'Fundamental concept word. In professional contexts: "on time" (punctual), "in time" (before deadline), "time management", "full-time/part-time". Can be countable ("three times") or uncountable ("I don''t have time"). Very common in business communication.',
  register = 'neutral',
  variety = 'international',
  examples = '["What time is the meeting?", "I don''t have time to finish this today.", "She works full-time at the company.", "We need better time management."]'::jsonb,
  collocations = '["on time", "in time", "time management", "full-time", "part-time", "save time", "waste time"]'::jsonb,
  patterns = '["at + time", "on time", "in time", "time + to + infinitive"]'::jsonb,
  updated_at = now()
WHERE headword = 'time';

-- Noun: year
UPDATE lexicon_entries
SET
  ipa = 'jɪər',
  definition_simple = 'a period of 365 days or 12 months',
  definition_teacher = 'noun: countable; refers to a 365-day period or calendar year; used for measuring long durations and dates; neutral register',
  usage_notes = 'Basic time unit. In professional contexts: "fiscal year", "years of experience", "year-end report", "this year/last year/next year". Common in CVs and business planning. Note: "year" (period) vs "years old" (age).',
  register = 'neutral',
  variety = 'international',
  examples = '["I have five years of experience.", "The fiscal year ends in December.", "She joined the company last year.", "We plan to expand next year."]'::jsonb,
  collocations = '["fiscal year", "years of experience", "last year", "next year", "this year", "year-end"]'::jsonb,
  patterns = '["number + years", "this/last/next + year", "year + of + noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'year';

-- Noun: day
UPDATE lexicon_entries
SET
  ipa = 'deɪ',
  definition_simple = 'a period of 24 hours',
  definition_teacher = 'noun: countable; refers to a 24-hour period, daylight hours, or specific date; neutral register',
  usage_notes = 'Basic time unit. In professional contexts: "business day", "day off", "per day", "these days" (nowadays), "one day" (future). Common in scheduling and deadlines. Note: "day" (24 hours) vs "daytime" (daylight hours).',
  register = 'neutral',
  variety = 'international',
  examples = '["The deadline is in three days.", "I work eight hours per day.", "She has a day off tomorrow.", "We ship within two business days."]'::jsonb,
  collocations = '["business day", "day off", "per day", "these days", "one day", "all day"]'::jsonb,
  patterns = '["number + days", "per day", "day + off"]'::jsonb,
  updated_at = now()
WHERE headword = 'day';

-- Noun: week
UPDATE lexicon_entries
SET
  ipa = 'wiːk',
  definition_simple = 'a period of seven days',
  definition_teacher = 'noun: countable; refers to a seven-day period, typically Monday to Sunday or Sunday to Saturday; neutral register',
  usage_notes = 'Basic time unit. In professional contexts: "this week", "next week", "per week", "work week", "week ending". Common in scheduling and planning. Note: "week" (period) vs "weak" (not strong) - common spelling error.',
  register = 'neutral',
  variety = 'international',
  examples = '["The meeting is next week.", "I work 40 hours per week.", "We have a deadline this week.", "She travels twice a week."]'::jsonb,
  collocations = '["this week", "next week", "last week", "per week", "work week"]'::jsonb,
  patterns = '["this/next/last + week", "per week", "number + weeks"]'::jsonb,
  updated_at = now()
WHERE headword = 'week';

-- Noun: month
UPDATE lexicon_entries
SET
  ipa = 'mʌnθ',
  definition_simple = 'one of the twelve periods of time that a year is divided into',
  definition_teacher = 'noun: countable; refers to a calendar month (approximately 30 days) or a 30-day period; neutral register',
  usage_notes = 'Basic time unit. In professional contexts: "per month", "this month", "monthly report", "months of experience". Common in contracts and billing. Note pronunciation: silent "th" at end.',
  register = 'neutral',
  variety = 'international',
  examples = '["The report is due next month.", "I earn $5000 per month.", "She has been here for six months.", "We meet once a month."]'::jsonb,
  collocations = '["per month", "this month", "next month", "last month", "monthly report"]'::jsonb,
  patterns = '["this/next/last + month", "per month", "number + months"]'::jsonb,
  updated_at = now()
WHERE headword = 'month';

-- Noun: hour
UPDATE lexicon_entries
SET
  ipa = 'aʊər',
  definition_simple = 'a period of 60 minutes',
  definition_teacher = 'noun: countable; refers to a 60-minute period or specific time on the clock; neutral register',
  usage_notes = 'Basic time unit. In professional contexts: "per hour", "office hours", "working hours", "hours of operation". Common in scheduling and wages. Note: "hour" (60 minutes) vs "our" (possessive) - same pronunciation, different spelling.',
  register = 'neutral',
  variety = 'international',
  examples = '["The meeting lasted two hours.", "I work eight hours per day.", "Our office hours are 9 AM to 5 PM.", "She earns $25 per hour."]'::jsonb,
  collocations = '["per hour", "office hours", "working hours", "hours of operation"]'::jsonb,
  patterns = '["number + hours", "per hour", "hours + of + noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'hour';

-- Noun: minute
UPDATE lexicon_entries
SET
  ipa = 'mɪnɪt',
  definition_simple = 'a period of 60 seconds',
  definition_teacher = 'noun: countable; refers to a 60-second period; neutral register. Note: different pronunciation when used as adjective meaning "very small" (maɪˈnjuːt)',
  usage_notes = 'Basic time unit. In professional contexts: "in a minute" (soon), "just a minute" (wait), "minutes" (meeting notes). Common in scheduling. Note: "minute" (time) vs "minutes" (meeting notes) - same word, different meanings.',
  register = 'neutral',
  variety = 'international',
  examples = '["The meeting starts in five minutes.", "Just a minute, please.", "I need a few minutes to finish this.", "Please read the meeting minutes."]'::jsonb,
  collocations = '["in a minute", "just a minute", "few minutes", "meeting minutes"]'::jsonb,
  patterns = '["number + minutes", "in + number + minutes"]'::jsonb,
  updated_at = now()
WHERE headword = 'minute';

-- Noun: life
UPDATE lexicon_entries
SET
  ipa = 'laɪf',
  definition_simple = 'the time when a person or thing is alive or exists',
  definition_teacher = 'noun: countable/uncountable; refers to existence, living state, or way of living; plural "lives"; neutral register',
  usage_notes = 'Fundamental concept. In professional contexts: "work-life balance", "professional life", "life insurance", "shelf life" (product). Can be countable (plural "lives") or uncountable. Common in HR and benefits discussions.',
  register = 'neutral',
  variety = 'international',
  examples = '["Work-life balance is important.", "She has a busy professional life.", "The company offers life insurance.", "This product has a long shelf life."]'::jsonb,
  collocations = '["work-life balance", "professional life", "life insurance", "shelf life", "real life"]'::jsonb,
  patterns = '["life + noun (compound)", "adjective + life"]'::jsonb,
  updated_at = now()
WHERE headword = 'life';

-- Noun: world
UPDATE lexicon_entries
SET
  ipa = 'wɜːld',
  definition_simple = 'the earth and all the people and things on it',
  definition_teacher = 'noun: countable (usually singular); refers to the earth, global society, or a particular sphere of activity; neutral register',
  usage_notes = 'Used for global context. In professional contexts: "around the world", "world market", "business world", "world-class". Common in international business. Often used with "the": "the world", "the business world".',
  register = 'neutral',
  variety = 'international',
  examples = '["Our company operates around the world.", "She is known in the business world.", "We offer world-class service.", "The world economy is growing."]'::jsonb,
  collocations = '["around the world", "world market", "business world", "world-class", "world economy"]'::jsonb,
  patterns = '["around the world", "the + world", "world + noun (compound)"]'::jsonb,
  updated_at = now()
WHERE headword = 'world';

-- Noun: hand
UPDATE lexicon_entries
SET
  ipa = 'hænd',
  definition_simple = 'the part of your body at the end of your arm',
  definition_teacher = 'noun: countable; refers to the body part or assistance/help; also used in many idioms; neutral register',
  usage_notes = 'Body part with many idiomatic uses. In professional contexts: "on hand" (available), "hand in" (submit), "hands-on" (practical), "give someone a hand" (help). Very common in business idioms.',
  register = 'neutral',
  variety = 'international',
  examples = '["We have supplies on hand.", "Please hand in your report by Friday.", "She has hands-on experience.", "Can you give me a hand with this?"]'::jsonb,
  collocations = '["on hand", "hand in", "hands-on", "give a hand", "by hand"]'::jsonb,
  patterns = '["on hand", "hand + in", "hands-on + noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'hand';

-- Noun: part
UPDATE lexicon_entries
SET
  ipa = 'pɑːrt',
  definition_simple = 'one piece or section of something',
  definition_teacher = 'noun: countable; refers to a component, section, or role; also used as verb meaning "to separate"; neutral register',
  usage_notes = 'Used for components and sections. In professional contexts: "part of", "take part in" (participate), "part-time", "spare parts". Very common in technical and business contexts. Note: "part" (section) vs "party" (celebration/group).',
  register = 'neutral',
  variety = 'international',
  examples = '["This is part of the project.", "She works part-time.", "We need spare parts for the machine.", "I want to take part in the meeting."]'::jsonb,
  collocations = '["part of", "take part in", "part-time", "spare parts", "in part"]'::jsonb,
  patterns = '["part + of", "take part + in", "part-time"]'::jsonb,
  updated_at = now()
WHERE headword = 'part';

-- ============================================================================
-- COMMON NOUNS - PEOPLE (15 words)
-- ============================================================================

-- Noun: person
UPDATE lexicon_entries
SET
  ipa = 'pɜːrsən',
  definition_simple = 'a man, woman, or child',
  definition_teacher = 'noun: countable; refers to an individual human being; plural "people" (informal) or "persons" (formal/legal); neutral register',
  usage_notes = 'General term for human. In professional contexts: "per person", "contact person", "in person" (face-to-face). Note: plural is usually "people" in everyday use, "persons" in formal/legal contexts. Common in business communication.',
  register = 'neutral',
  variety = 'international',
  examples = '["The cost is $50 per person.", "Who is the contact person for this project?", "We should meet in person.", "Each person has different needs."]'::jsonb,
  collocations = '["per person", "contact person", "in person", "sales person"]'::jsonb,
  patterns = '["per person", "in person", "person + for/of"]'::jsonb,
  updated_at = now()
WHERE headword = 'person';

-- Noun: man
UPDATE lexicon_entries
SET
  ipa = 'mæn',
  definition_simple = 'an adult male person',
  definition_teacher = 'noun: countable; refers to an adult male human; plural "men"; can also mean humanity in general (dated usage); neutral register',
  usage_notes = 'Refers to adult male. In professional contexts, use gender-neutral terms when possible: "businessperson" instead of "businessman", "workforce" instead of "manpower". Note: "man" (male) vs "men" (plural).',
  register = 'neutral',
  variety = 'international',
  examples = '["The man in the blue suit is our CEO.", "We hired three new men for the team.", "Every man and woman in the company received the memo.", "He is a man of his word."]'::jsonb,
  collocations = '["business man", "young man", "old man"]'::jsonb,
  patterns = '["the + man", "a + man + of"]'::jsonb,
  updated_at = now()
WHERE headword = 'man';

-- Noun: woman
UPDATE lexicon_entries
SET
  ipa = 'wʊmən',
  definition_simple = 'an adult female person',
  definition_teacher = 'noun: countable; refers to an adult female human; plural "women" (pronounced wɪmɪn); neutral register',
  usage_notes = 'Refers to adult female. In professional contexts, use gender-neutral terms when possible: "businessperson" instead of "businesswoman". Note: "woman" (singular) vs "women" (plural) - different pronunciation.',
  register = 'neutral',
  variety = 'international',
  examples = '["The woman in charge is very experienced.", "We have many talented women in our company.", "She is a successful business woman.", "Every woman on the team contributed."]'::jsonb,
  collocations = '["business woman", "young woman", "working woman"]'::jsonb,
  patterns = '["the + woman", "a + woman + of"]'::jsonb,
  updated_at = now()
WHERE headword = 'woman';

-- Noun: child
UPDATE lexicon_entries
SET
  ipa = 'tʃaɪld',
  definition_simple = 'a young person who is not yet an adult',
  definition_teacher = 'noun: countable; refers to a young human, typically under 18 years old; plural "children"; neutral register',
  usage_notes = 'Refers to young person. In professional contexts: "child care", "child support", "children" (plural). Common in HR benefits discussions. Note irregular plural: "child" → "children".',
  register = 'neutral',
  variety = 'international',
  examples = '["The company offers child care benefits.", "She has two children.", "Child support is included in the benefits package.", "Every child deserves education."]'::jsonb,
  collocations = '["child care", "child support", "young child"]'::jsonb,
  patterns = '["child + noun (compound)", "number + children"]'::jsonb,
  updated_at = now()
WHERE headword = 'child';

-- Noun: eye
UPDATE lexicon_entries
SET
  ipa = 'aɪ',
  definition_simple = 'the part of your body that you see with',
  definition_teacher = 'noun: countable; refers to the organ of sight; also used in many idioms; neutral register',
  usage_notes = 'Body part with many idiomatic uses. In professional contexts: "keep an eye on" (monitor), "eye contact", "eye-catching" (attractive), "see eye to eye" (agree). Common in business communication.',
  register = 'neutral',
  variety = 'international',
  examples = '["Please keep an eye on the project.", "Good eye contact is important in presentations.", "The design is very eye-catching.", "We don''t always see eye to eye."]'::jsonb,
  collocations = '["keep an eye on", "eye contact", "eye-catching", "see eye to eye"]'::jsonb,
  patterns = '["keep an eye + on", "eye + contact", "eye-catching"]'::jsonb,
  updated_at = now()
WHERE headword = 'eye';

-- Noun: people
UPDATE lexicon_entries
SET
  ipa = 'piːpəl',
  definition_simple = 'more than one person',
  definition_teacher = 'noun: plural of "person" (informal usage); refers to multiple human beings; can also be countable meaning "nation/ethnic group" (plural "peoples"); neutral register',
  usage_notes = 'Plural of "person" in everyday use. In professional contexts: "people management", "people skills", "business people". Very common in HR and management. Note: "people" is already plural, don''t add "s".',
  register = 'neutral',
  variety = 'international',
  examples = '["Many people work from home now.", "She has excellent people skills.", "The people in our team are very talented.", "We need to hire more people."]'::jsonb,
  collocations = '["people skills", "people management", "business people", "many people"]'::jsonb,
  patterns = '["number/quantifier + people", "people + verb (plural)"]'::jsonb,
  updated_at = now()
WHERE headword = 'people';

-- Noun: family
UPDATE lexicon_entries
SET
  ipa = 'fæməli',
  definition_simple = 'a group of people who are related, especially parents and children',
  definition_teacher = 'noun: countable; refers to related people living together or a group of related things; can be treated as singular or plural; neutral register',
  usage_notes = 'Refers to related people. In professional contexts: "family leave", "family benefits", "work-family balance". Common in HR policies. Can be singular ("my family is") or plural ("my family are") depending on emphasis.',
  register = 'neutral',
  variety = 'international',
  examples = '["The company offers family leave.", "She has a large family.", "Family benefits include health insurance.", "Work-family balance is important."]'::jsonb,
  collocations = '["family leave", "family benefits", "work-family balance", "family member"]'::jsonb,
  patterns = '["family + noun (compound)", "family + of"]'::jsonb,
  updated_at = now()
WHERE headword = 'family';

-- Noun: friend
UPDATE lexicon_entries
SET
  ipa = 'frend',
  definition_simple = 'a person you know well and like',
  definition_teacher = 'noun: countable; refers to a person with whom one has a bond of mutual affection; neutral register',
  usage_notes = 'Refers to close acquaintance. In professional contexts: "make friends", "friend of the company", "user-friendly". Note: "friend" (noun) vs "friendly" (adjective). Brazilian learners sometimes confuse these.',
  register = 'neutral',
  variety = 'international',
  examples = '["I made many friends at work.", "She is a friend of the CEO.", "The software is user-friendly.", "We have a friend in the industry."]'::jsonb,
  collocations = '["make friends", "close friend", "user-friendly", "friend of"]'::jsonb,
  patterns = '["make + friends", "friend + of", "user-friendly"]'::jsonb,
  updated_at = now()
WHERE headword = 'friend';

-- Noun: group
UPDATE lexicon_entries
SET
  ipa = 'ɡruːp',
  definition_simple = 'a number of people or things that are together',
  definition_teacher = 'noun: countable; refers to a collection of people or things; can be treated as singular or plural; neutral register',
  usage_notes = 'Refers to collection. In professional contexts: "work group", "group meeting", "focus group", "group project". Very common in business organization. Can be singular ("the group is") or plural ("the group are").',
  register = 'neutral',
  variety = 'international',
  examples = '["We work in small groups.", "The group meets every Monday.", "She leads a focus group.", "Our group project is due next week."]'::jsonb,
  collocations = '["work group", "group meeting", "focus group", "group project", "in groups"]'::jsonb,
  patterns = '["in + groups", "group + of", "group + noun (compound)"]'::jsonb,
  updated_at = now()
WHERE headword = 'group';

-- Noun: team
UPDATE lexicon_entries
SET
  ipa = 'tiːm',
  definition_simple = 'a group of people who work together',
  definition_teacher = 'noun: countable; refers to a group working together toward a common goal; can be treated as singular or plural; neutral register',
  usage_notes = 'Fundamental business term. In professional contexts: "team member", "team work", "team leader", "team building". Very common in business. Can be singular ("the team is") or plural ("the team are").',
  register = 'neutral',
  variety = 'international',
  examples = '["I work with a great team.", "She is a team leader.", "Team work is essential for success.", "Our team meets every morning."]'::jsonb,
  collocations = '["team member", "team work", "team leader", "team building", "team meeting"]'::jsonb,
  patterns = '["team + noun (compound)", "on the team", "team + of"]'::jsonb,
  updated_at = now()
WHERE headword = 'team';

-- ============================================================================
-- COMMON NOUNS - BUSINESS AND WORK (20 words)
-- ============================================================================

-- Noun: work
UPDATE lexicon_entries
SET
  ipa = 'wɜːrk',
  definition_simple = 'the job that you do to earn money, or the place where you do it',
  definition_teacher = 'noun: uncountable (job/labor) or countable (artistic creation); refers to employment, tasks, or place of employment; neutral register',
  usage_notes = 'Fundamental business term. In professional contexts: "at work", "go to work", "work experience", "work environment". Usually uncountable when meaning "labor" ("I have work to do"), countable for artistic works ("a work of art").',
  register = 'neutral',
  variety = 'international',
  examples = '["I have a lot of work to do.", "She is at work right now.", "He has five years of work experience.", "The work environment is excellent."]'::jsonb,
  collocations = '["at work", "go to work", "work experience", "work environment", "hard work"]'::jsonb,
  patterns = '["at work", "work + noun (compound)", "do + work"]'::jsonb,
  updated_at = now()
WHERE headword = 'work';

-- Noun: job
UPDATE lexicon_entries
SET
  ipa = 'dʒɑːb',
  definition_simple = 'the work that you do regularly to earn money',
  definition_teacher = 'noun: countable; refers to a position of employment or a specific task; neutral register',
  usage_notes = 'Fundamental employment term. In professional contexts: "job description", "job interview", "job offer", "do a good job". Countable - "a job", "two jobs". Brazilian learners often confuse "work" (uncountable) with "job" (countable).',
  register = 'neutral',
  variety = 'international',
  examples = '["I have a new job.", "She did a great job on the project.", "The job description is very clear.", "He is looking for a job."]'::jsonb,
  collocations = '["job description", "job interview", "job offer", "do a good job", "job search"]'::jsonb,
  patterns = '["have a job", "do a job", "job + noun (compound)"]'::jsonb,
  updated_at = now()
WHERE headword = 'job';

-- Noun: company
UPDATE lexicon_entries
SET
  ipa = 'kʌmpəni',
  definition_simple = 'a business organization that sells goods or services',
  definition_teacher = 'noun: countable; refers to a business entity or the state of being with others; neutral register',
  usage_notes = 'Fundamental business term. In professional contexts: "work for a company", "company policy", "company culture", "parent company". Can be treated as singular or plural. Also means "companionship" in different context.',
  register = 'neutral',
  variety = 'international',
  examples = '["I work for a technology company.", "Our company has 500 employees.", "The company policy is very clear.", "She started her own company."]'::jsonb,
  collocations = '["work for a company", "company policy", "company culture", "parent company", "company name"]'::jsonb,
  patterns = '["work + for + company", "company + noun (compound)", "the company"]'::jsonb,
  updated_at = now()
WHERE headword = 'company';

-- Noun: business
UPDATE lexicon_entries
SET
  ipa = 'bɪznəs',
  definition_simple = 'the activity of buying and selling goods or services',
  definition_teacher = 'noun: uncountable (commerce) or countable (company); refers to commercial activity or a company; neutral register',
  usage_notes = 'Fundamental commercial term. In professional contexts: "do business", "business meeting", "business plan", "on business" (for work). Can be uncountable ("business is good") or countable ("a small business").',
  register = 'neutral',
  variety = 'international',
  examples = '["We do business with many countries.", "I have a business meeting tomorrow.", "She owns a small business.", "He is traveling on business."]'::jsonb,
  collocations = '["do business", "business meeting", "business plan", "on business", "business trip"]'::jsonb,
  patterns = '["do + business", "business + noun (compound)", "on business"]'::jsonb,
  updated_at = now()
WHERE headword = 'business';

-- Noun: office
UPDATE lexicon_entries
SET
  ipa = 'ɔːfɪs',
  definition_simple = 'a room or building where people work at desks',
  definition_teacher = 'noun: countable; refers to a workplace, room for work, or position of authority; neutral register',
  usage_notes = 'Common workplace term. In professional contexts: "at the office", "office hours", "home office", "office manager". Can mean physical space or position ("hold office"). Very common in business communication.',
  register = 'neutral',
  variety = 'international',
  examples = '["I work at the office three days a week.", "Our office hours are 9 to 5.", "She has a home office.", "He is the office manager."]'::jsonb,
  collocations = '["at the office", "office hours", "home office", "office manager", "office space"]'::jsonb,
  patterns = '["at the office", "office + noun (compound)", "in the office"]'::jsonb,
  updated_at = now()
WHERE headword = 'office';

-- Noun: meeting
UPDATE lexicon_entries
SET
  ipa = 'miːtɪŋ',
  definition_simple = 'an event when people come together to discuss something',
  definition_teacher = 'noun: countable; refers to a gathering for discussion or decision-making; neutral register',
  usage_notes = 'Essential business term. In professional contexts: "have a meeting", "meeting room", "meeting agenda", "attend a meeting". Very common in business. Note: "meeting" (noun) vs "meet" (verb).',
  register = 'neutral',
  variety = 'international',
  examples = '["We have a meeting at 2 PM.", "The meeting room is on the third floor.", "Please send the meeting agenda.", "She attends many meetings."]'::jsonb,
  collocations = '["have a meeting", "meeting room", "meeting agenda", "attend a meeting", "meeting minutes"]'::jsonb,
  patterns = '["have a meeting", "meeting + noun (compound)", "in a meeting"]'::jsonb,
  updated_at = now()
WHERE headword = 'meeting';

-- Noun: project
UPDATE lexicon_entries
SET
  ipa = 'prɑːdʒekt',
  definition_simple = 'a planned piece of work that has a specific purpose',
  definition_teacher = 'noun: countable; refers to a planned undertaking with specific goals and timeline; also verb (prəˈdʒekt) meaning to estimate or display; neutral register',
  usage_notes = 'Essential business term. In professional contexts: "work on a project", "project manager", "project deadline", "project team". Very common in business. Note: noun pronunciation /prɑːdʒekt/ vs verb /prəˈdʒekt/.',
  register = 'neutral',
  variety = 'international',
  examples = '["I am working on a new project.", "She is the project manager.", "The project deadline is next month.", "Our project team has five members."]'::jsonb,
  collocations = '["work on a project", "project manager", "project deadline", "project team", "project plan"]'::jsonb,
  patterns = '["work + on + project", "project + noun (compound)"]'::jsonb,
  updated_at = now()
WHERE headword = 'project';

-- Noun: plan
UPDATE lexicon_entries
SET
  ipa = 'plæn',
  definition_simple = 'something you have decided to do',
  definition_teacher = 'noun: countable; refers to an intended course of action or detailed proposal; also verb meaning to make plans; neutral register',
  usage_notes = 'Common planning term. In professional contexts: "business plan", "project plan", "make a plan", "according to plan". Can be noun or verb. Very common in business planning.',
  register = 'neutral',
  variety = 'international',
  examples = '["We need to make a plan.", "The business plan is ready.", "Everything went according to plan.", "What are your plans for the project?"]'::jsonb,
  collocations = '["business plan", "project plan", "make a plan", "according to plan", "action plan"]'::jsonb,
  patterns = '["make a plan", "plan + for", "plan + noun (compound)"]'::jsonb,
  updated_at = now()
WHERE headword = 'plan';

-- Noun: report
UPDATE lexicon_entries
SET
  ipa = 'rɪpɔːrt',
  definition_simple = 'a written or spoken description of a situation or event',
  definition_teacher = 'noun: countable; refers to a formal account or document; also verb meaning to give information; neutral register',
  usage_notes = 'Essential business document. In professional contexts: "write a report", "annual report", "report on", "status report". Can be noun or verb. Very common in business communication.',
  register = 'neutral',
  variety = 'international',
  examples = '["I need to write a report.", "The annual report is published in March.", "She gave a report on the project.", "Please send me the status report."]'::jsonb,
  collocations = '["write a report", "annual report", "status report", "report on", "monthly report"]'::jsonb,
  patterns = '["write a report", "report + on", "report + noun (compound)"]'::jsonb,
  updated_at = now()
WHERE headword = 'report';

-- Noun: problem
UPDATE lexicon_entries
SET
  ipa = 'prɑːbləm',
  definition_simple = 'a situation that causes difficulties',
  definition_teacher = 'noun: countable; refers to a difficulty, question to be solved, or challenge; neutral register',
  usage_notes = 'Common business term. In professional contexts: "solve a problem", "problem solving", "no problem" (you''re welcome), "have a problem". Very common in troubleshooting and customer service.',
  register = 'neutral',
  variety = 'international',
  examples = '["We need to solve this problem.", "She is good at problem solving.", "No problem, I can help you.", "Do you have any problems?"]'::jsonb,
  collocations = '["solve a problem", "problem solving", "no problem", "have a problem", "technical problem"]'::jsonb,
  patterns = '["solve a problem", "problem + with", "problem solving"]'::jsonb,
  updated_at = now()
WHERE headword = 'problem';

-- Noun: question
UPDATE lexicon_entries
SET
  ipa = 'kwestʃən',
  definition_simple = 'something you ask to get information',
  definition_teacher = 'noun: countable; refers to an inquiry or matter requiring resolution; also verb meaning to ask or doubt; neutral register',
  usage_notes = 'Common communication term. In professional contexts: "ask a question", "answer a question", "question and answer", "good question". Can be noun or verb. Very common in meetings and presentations.',
  register = 'neutral',
  variety = 'international',
  examples = '["Do you have any questions?", "That''s a good question.", "I need to ask a question.", "Please answer the question."]'::jsonb,
  collocations = '["ask a question", "answer a question", "good question", "have a question"]'::jsonb,
  patterns = '["ask a question", "answer a question", "question + about"]'::jsonb,
  updated_at = now()
WHERE headword = 'question';

-- Noun: answer
UPDATE lexicon_entries
SET
  ipa = 'ænsər',
  definition_simple = 'something you say or write when someone asks you a question',
  definition_teacher = 'noun: countable; refers to a response to a question or solution to a problem; also verb meaning to respond; neutral register',
  usage_notes = 'Common communication term. In professional contexts: "the answer to", "find an answer", "give an answer". Can be noun or verb. Note: "answer to" (not "answer of").',
  register = 'neutral',
  variety = 'international',
  examples = '["I don''t know the answer.", "She gave a good answer.", "We need to find an answer to this problem.", "What is the answer to question 3?"]'::jsonb,
  collocations = '["the answer to", "find an answer", "give an answer", "right answer"]'::jsonb,
  patterns = '["answer + to", "find an answer", "give an answer"]'::jsonb,
  updated_at = now()
WHERE headword = 'answer';

-- Noun: information
UPDATE lexicon_entries
SET
  ipa = 'ɪnfərmeɪʃən',
  definition_simple = 'facts or details about something',
  definition_teacher = 'noun: uncountable; refers to facts, data, or knowledge; neutral register. Note: always uncountable in English, unlike Portuguese "informações"',
  usage_notes = 'Essential business term. In professional contexts: "get information", "provide information", "information technology", "for your information". Always uncountable - no "s" at end. Brazilian learners often make it countable (influenced by Portuguese).',
  register = 'neutral',
  variety = 'international',
  examples = '["I need more information about the project.", "Please provide the information by Friday.", "For your information, the meeting is at 3 PM.", "She works in information technology."]'::jsonb,
  collocations = '["get information", "provide information", "information technology", "for your information", "more information"]'::jsonb,
  patterns = '["information + about", "provide + information", "information + noun (compound)"]'::jsonb,
  updated_at = now()
WHERE headword = 'information';

-- Noun: idea
UPDATE lexicon_entries
SET
  ipa = 'aɪdiːə',
  definition_simple = 'a thought or suggestion about what to do',
  definition_teacher = 'noun: countable; refers to a thought, concept, or suggestion; neutral register',
  usage_notes = 'Common creative term. In professional contexts: "good idea", "have an idea", "idea about", "no idea" (don''t know). Very common in brainstorming and planning.',
  register = 'neutral',
  variety = 'international',
  examples = '["That''s a good idea.", "I have an idea for the project.", "She has no idea about the deadline.", "Do you have any ideas?"]'::jsonb,
  collocations = '["good idea", "have an idea", "no idea", "great idea", "idea about"]'::jsonb,
  patterns = '["have an idea", "idea + about/for", "good/great + idea"]'::jsonb,
  updated_at = now()
WHERE headword = 'idea';

-- Noun: way
UPDATE lexicon_entries
SET
  ipa = 'weɪ',
  definition_simple = 'a method of doing something or a road or path',
  definition_teacher = 'noun: countable; refers to a method, manner, direction, or path; highly versatile with multiple meanings; neutral register',
  usage_notes = 'Very versatile word. In professional contexts: "the best way", "this way" (direction/method), "by the way" (incidentally), "on the way". Can mean method or direction. Very common in instructions.',
  register = 'neutral',
  variety = 'international',
  examples = '["This is the best way to solve the problem.", "The office is this way.", "By the way, the meeting is tomorrow.", "We are on the way to success."]'::jsonb,
  collocations = '["the best way", "this way", "by the way", "on the way", "in a way"]'::jsonb,
  patterns = '["way + to + infinitive", "this/that + way", "by the way"]'::jsonb,
  updated_at = now()
WHERE headword = 'way';

-- Noun: thing
UPDATE lexicon_entries
SET
  ipa = 'θɪŋ',
  definition_simple = 'an object or an idea that you can talk about',
  definition_teacher = 'noun: countable; refers to an object, matter, or concept; very general and versatile; neutral register',
  usage_notes = 'Very general term. In professional contexts: "the important thing", "things to do", "first thing" (priority), "among other things". Very common when being non-specific. Plural "things" often means "matters" or "situation".',
  register = 'neutral',
  variety = 'international',
  examples = '["The important thing is to finish on time.", "I have many things to do today.", "First thing tomorrow, I will call you.", "Among other things, we discussed the budget."]'::jsonb,
  collocations = '["the important thing", "things to do", "first thing", "among other things", "the right thing"]'::jsonb,
  patterns = '["the + adjective + thing", "things + to + infinitive"]'::jsonb,
  updated_at = now()
WHERE headword = 'thing';

-- ============================================================================
-- COMMON NOUNS - ABSTRACT CONCEPTS (15 words)
-- ============================================================================

-- Noun: place
UPDATE lexicon_entries
SET
  ipa = 'pleɪs',
  definition_simple = 'a particular position, point, or area',
  definition_teacher = 'noun: countable; refers to a location, position, or role; also verb meaning to put; neutral register',
  usage_notes = 'Common location term. In professional contexts: "take place" (happen), "in place" (established), "workplace", "place of work". Can be noun or verb. Very common in business.',
  register = 'neutral',
  variety = 'international',
  examples = '["The meeting will take place tomorrow.", "We have safety measures in place.", "This is a great place to work.", "She placed the order yesterday."]'::jsonb,
  collocations = '["take place", "in place", "workplace", "place of work", "first place"]'::jsonb,
  patterns = '["take place", "in place", "place + of"]'::jsonb,
  updated_at = now()
WHERE headword = 'place';

-- Noun: case
UPDATE lexicon_entries
SET
  ipa = 'keɪs',
  definition_simple = 'a particular situation or example',
    definition_teacher = 'noun: countable; refers to instance, situation, legal matter, container, or argument; neutral register; highly versatile with multiple meanings',
  usage_notes = 'Versatile business term. Situation: "in this case", "in case of" (if), "use case". Legal: "court case", "case study". Container: "briefcase", "case for phone". Very common in business analysis and law. Brazilian learners should note: "in case of" (if) vs "in this case" (in this situation).',
  register = 'neutral',
  variety = 'international',
  examples = '["In this case, we need approval.", "In case of emergency, call this number.", "We studied several case studies.", "I need a case for my laptop."]'::jsonb,
  collocations = '["in this case", "in case of", "case study", "use case", "court case"]'::jsonb,
  patterns = '["in + case", "in case + of", "case study"]'::jsonb,
  frequency_band = 'A1',
  updated_at = now()
WHERE headword = 'case';
