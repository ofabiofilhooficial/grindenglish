-- Enhancement of A1 Vocabulary - Batch 2 (100 words: destroy → high)
-- Professional English context for Brazilian learners
-- Migration: 20260310000014

-- destroy
UPDATE lexicon_entries SET
  ipa = '/dɪˈstrɔɪ/',
  definition_simple = 'to damage something so badly that it cannot be used',
  definition_teacher = 'Verb meaning to ruin completely or eliminate. In business, used for destroying evidence, destroying value, or creative destruction.',
  usage_notes = 'Strong verb indicating complete damage or elimination. Common in business contexts for value destruction or data destruction.',
  examples = jsonb_build_array(
    'Poor management can destroy company value.',
    'The scandal destroyed the brand''s reputation.',
    'We must destroy all confidential documents securely.',
    'Creative destruction drives innovation in markets.'
  ),
  collocations = jsonb_build_array('destroy value', 'destroy reputation', 'destroy evidence', 'creative destruction'),
  patterns = jsonb_build_array('destroy + noun', 'be destroyed by + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'destroy' AND cefr_receptive = 'A1';

-- die
UPDATE lexicon_entries SET
  ipa = '/daɪ/',
  definition_simple = 'to stop living',
  definition_teacher = 'Verb meaning to cease living or functioning. In business, used for companies dying, ideas dying, or dying industries.',
  usage_notes = 'Can be literal (cease living) or figurative (die out, dying industry). Common in business for decline and obsolescence.',
  examples = jsonb_build_array(
    'Many traditional businesses are dying out.',
    'The project died due to lack of funding.',
    'Old habits die hard in corporate culture.',
    'The industry is dying - we need to pivot.'
  ),
  collocations = jsonb_build_array('die out', 'die hard', 'dying industry', 'die down'),
  patterns = jsonb_build_array('die + adverb particle', 'dying + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'die' AND cefr_receptive = 'A1';

-- difficult
UPDATE lexicon_entries SET
  ipa = '/ˈdɪfɪkəlt/',
  definition_simple = 'not easy, requiring effort or skill',
  definition_teacher = 'Adjective meaning challenging or hard to do. Essential in business for describing challenges, difficult decisions, and complex situations.',
  usage_notes = 'Very common in business. Can describe tasks, people, or situations. Often paired with "to" + infinitive.',
  examples = jsonb_build_array(
    'This is a difficult decision to make.',
    'The market conditions are difficult right now.',
    'It''s difficult to predict future trends.',
    'We face difficult challenges ahead.'
  ),
  collocations = jsonb_build_array('difficult decision', 'difficult situation', 'difficult to', 'difficult challenge'),
  patterns = jsonb_build_array('difficult + noun', 'difficult to + infinitive', 'it''s difficult to + infinitive'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'difficult' AND cefr_receptive = 'A1';

-- disease
UPDATE lexicon_entries SET
  ipa = '/dɪˈziːz/',
  definition_simple = 'an illness affecting people, animals, or plants',
  definition_teacher = 'Noun meaning illness or disorder. In business, used literally for health-related industries or metaphorically for organizational problems.',
  usage_notes = 'Countable or uncountable. In business, may appear in healthcare contexts or metaphorically (disease of bureaucracy).',
  examples = jsonb_build_array(
    'The company develops treatments for rare diseases.',
    'Workplace stress can lead to disease.',
    'Bureaucracy is a disease affecting productivity.',
    'Disease prevention is part of our wellness program.'
  ),
  collocations = jsonb_build_array('rare disease', 'prevent disease', 'disease prevention', 'infectious disease'),
  patterns = jsonb_build_array('disease + noun', 'prevent/treat + disease'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'disease' AND cefr_receptive = 'A1';

-- distance
UPDATE lexicon_entries SET
  ipa = '/ˈdɪstəns/',
  definition_simple = 'the amount of space between two places or things',
  definition_teacher = 'Noun meaning space between points or remoteness. In business, used for physical distance, distance learning, or keeping distance.',
  usage_notes = 'Can be literal (physical distance) or figurative (emotional distance). Common in remote work discussions.',
  examples = jsonb_build_array(
    'Distance learning has become more popular.',
    'The office is within walking distance of the station.',
    'We need to maintain professional distance.',
    'Long-distance collaboration requires good tools.'
  ),
  collocations = jsonb_build_array('distance learning', 'walking distance', 'long distance', 'keep distance'),
  patterns = jsonb_build_array('distance + noun', 'at/from a distance', 'within + adjective + distance'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'distance' AND cefr_receptive = 'A1';

-- distinguish
UPDATE lexicon_entries SET
  ipa = '/dɪˈstɪŋɡwɪʃ/',
  definition_simple = 'to recognize the difference between things',
  definition_teacher = 'Verb meaning to differentiate or make distinct. In business, used for distinguishing features, distinguishing oneself, or making distinctions.',
  usage_notes = 'Formal verb. Often used with "between" or "from". Important for analysis and differentiation in business.',
  examples = jsonb_build_array(
    'We need to distinguish between urgent and important tasks.',
    'What distinguishes our product from competitors?',
    'She distinguished herself through excellent performance.',
    'It''s important to distinguish fact from opinion.'
  ),
  collocations = jsonb_build_array('distinguish between', 'distinguish from', 'distinguish oneself', 'distinguishing feature'),
  patterns = jsonb_build_array('distinguish between + noun + and + noun', 'distinguish + noun + from + noun', 'distinguish oneself'),
  register = 'formal',
  variety = 'international'
WHERE headword = 'distinguish' AND cefr_receptive = 'A1';

-- district
UPDATE lexicon_entries SET
  ipa = '/ˈdɪstrɪkt/',
  definition_simple = 'an area of a town or country',
  definition_teacher = 'Noun meaning a defined area or region. In business, used for business districts, sales districts, or administrative divisions.',
  usage_notes = 'Countable noun. Common in business for geographic divisions and commercial areas.',
  examples = jsonb_build_array(
    'Our office is in the financial district.',
    'The sales team covers three districts.',
    'The business district has excellent infrastructure.',
    'Each district has its own manager.'
  ),
  collocations = jsonb_build_array('business district', 'financial district', 'sales district', 'district manager'),
  patterns = jsonb_build_array('adjective + district', 'in the + noun + district', 'district + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'district' AND cefr_receptive = 'A1';

-- doctor
UPDATE lexicon_entries SET
  ipa = '/ˈdɒktər/',
  definition_simple = 'a person who treats people who are ill',
  definition_teacher = 'Noun meaning medical professional or person with doctorate. In business, relevant for healthcare industry and academic qualifications.',
  usage_notes = 'Countable noun. Can mean medical doctor or PhD holder. Context determines meaning.',
  examples = jsonb_build_array(
    'The company provides access to doctors for employees.',
    'She is a doctor of business administration.',
    'Occupational health doctors visit monthly.',
    'Doctor''s appointments are covered by insurance.'
  ),
  collocations = jsonb_build_array('see a doctor', 'doctor''s appointment', 'company doctor', 'doctor of'),
  patterns = jsonb_build_array('see/visit a doctor', 'doctor of + field', 'doctor''s + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'doctor' AND cefr_receptive = 'A1';

-- dog
UPDATE lexicon_entries SET
  ipa = '/dɒɡ/',
  definition_simple = 'a common four-legged animal kept as a pet',
  definition_teacher = 'Noun referring to a canine. In business, appears in idioms like "dog eat dog", "underdog", or "top dog".',
  usage_notes = 'Countable noun. Common in business idioms about competition and hierarchy.',
  examples = jsonb_build_array(
    'It''s a dog-eat-dog world in this industry.',
    'The company started as an underdog.',
    'He''s the top dog in the sales department.',
    'Let sleeping dogs lie - don''t raise old issues.'
  ),
  collocations = jsonb_build_array('dog eat dog', 'underdog', 'top dog', 'let sleeping dogs lie'),
  patterns = jsonb_build_array('dog-eat-dog + noun', 'the underdog', 'top dog'),
  register = 'informal',
  variety = 'international'
WHERE headword = 'dog' AND cefr_receptive = 'A1';

-- double
UPDATE lexicon_entries SET
  ipa = '/ˈdʌbəl/',
  definition_simple = 'twice as much or having two parts',
  definition_teacher = 'Adjective, verb, or noun meaning twice the amount or to multiply by two. Essential in business for growth, doubling efforts, or double-checking.',
  usage_notes = 'Very versatile word. Can be adjective (double the size), verb (double sales), or noun (double the amount).',
  examples = jsonb_build_array(
    'We aim to double our revenue this year.',
    'Please double-check all figures before submission.',
    'The company experienced double-digit growth.',
    'We need to double our efforts to meet the deadline.'
  ),
  collocations = jsonb_build_array('double-check', 'double revenue', 'double-digit', 'double efforts'),
  patterns = jsonb_build_array('double + noun', 'double-check + noun', 'double-digit + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'double' AND cefr_receptive = 'A1';

-- doubt
UPDATE lexicon_entries SET
  ipa = '/daʊt/',
  definition_simple = 'a feeling of uncertainty or lack of conviction',
  definition_teacher = 'Noun or verb meaning uncertainty or to question. In business, used for expressing uncertainty, no doubt, or benefit of the doubt.',
  usage_notes = 'Can be noun (have doubts) or verb (I doubt it). Common in business for expressing uncertainty or skepticism.',
  examples = jsonb_build_array(
    'There is no doubt that quality matters.',
    'I doubt we can finish by Friday.',
    'When in doubt, ask for clarification.',
    'Give them the benefit of the doubt.'
  ),
  collocations = jsonb_build_array('no doubt', 'have doubts', 'when in doubt', 'benefit of the doubt'),
  patterns = jsonb_build_array('no doubt that + clause', 'have doubts about + noun', 'I doubt + clause', 'when in doubt'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'doubt' AND cefr_receptive = 'A1';

-- dream
UPDATE lexicon_entries SET
  ipa = '/driːm/',
  definition_simple = 'images and feelings experienced during sleep, or a cherished hope',
  definition_teacher = 'Noun or verb meaning sleep visions or aspirations. In business, used for dream job, dream team, or aspirational goals.',
  usage_notes = 'Can be literal (sleep dreams) or figurative (dreams and goals). Common in motivational business contexts.',
  examples = jsonb_build_array(
    'This is my dream job.',
    'We''re building a dream team for the project.',
    'The company helps people achieve their dreams.',
    'Don''t just dream - take action.'
  ),
  collocations = jsonb_build_array('dream job', 'dream team', 'achieve dreams', 'dream big'),
  patterns = jsonb_build_array('dream + noun', 'achieve/pursue + dreams', 'dream about/of + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'dream' AND cefr_receptive = 'A1';

-- dress
UPDATE lexicon_entries SET
  ipa = '/dres/',
  definition_simple = 'a piece of clothing for women, or to put on clothes',
  definition_teacher = 'Noun meaning garment or verb meaning to clothe. In business, used for dress code, dress professionally, or business dress.',
  usage_notes = 'Can be noun (a dress) or verb (dress appropriately). Important for workplace dress codes.',
  examples = jsonb_build_array(
    'The company has a business casual dress code.',
    'Please dress professionally for client meetings.',
    'Business dress is required for presentations.',
    'The dress code is outlined in the employee handbook.'
  ),
  collocations = jsonb_build_array('dress code', 'dress professionally', 'business dress', 'dress appropriately'),
  patterns = jsonb_build_array('dress + adverb', 'dress code', 'dress for + occasion'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'dress' AND cefr_receptive = 'A1';

-- drop
UPDATE lexicon_entries SET
  ipa = '/drɒp/',
  definition_simple = 'to fall or let something fall',
  definition_teacher = 'Verb or noun meaning to fall, decrease, or abandon. Essential in business for price drops, dropping projects, or drop in sales.',
  usage_notes = 'Very common in business. Can mean physical falling, decrease, or abandonment (drop a project).',
  examples = jsonb_build_array(
    'Sales dropped by 15% last quarter.',
    'We need to drop this unprofitable product line.',
    'Please drop me an email with the details.',
    'There was a sharp drop in customer satisfaction.'
  ),
  collocations = jsonb_build_array('drop in sales', 'drop a project', 'drop an email', 'sharp drop'),
  patterns = jsonb_build_array('drop + noun', 'drop by + percentage', 'drop in + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'drop' AND cefr_receptive = 'A1';

-- dry
UPDATE lexicon_entries SET
  ipa = '/draɪ/',
  definition_simple = 'without water or moisture',
  definition_teacher = 'Adjective meaning lacking moisture or dull. In business, used for dry run, dry spell, or dry humor in presentations.',
  usage_notes = 'Can be literal (not wet) or figurative (dry humor, dry spell). Common in business for practice runs.',
  examples = jsonb_build_array(
    'Let''s do a dry run before the actual presentation.',
    'The company is experiencing a dry spell in sales.',
    'Keep the documents in a dry place.',
    'His presentation style is quite dry.'
  ),
  collocations = jsonb_build_array('dry run', 'dry spell', 'dry humor', 'high and dry'),
  patterns = jsonb_build_array('dry + noun', 'a dry run', 'dry spell'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'dry' AND cefr_receptive = 'A1';

-- due
UPDATE lexicon_entries SET
  ipa = '/djuː/',
  definition_simple = 'expected or scheduled to happen, or owed',
  definition_teacher = 'Adjective meaning expected at a certain time or owed. Essential in business for due dates, due diligence, and payments due.',
  usage_notes = 'Very common in business. Can mean "expected" (due tomorrow) or "owed" (payment due). Also used in "due to" (because of).',
  examples = jsonb_build_array(
    'The report is due next Friday.',
    'Payment is due within 30 days.',
    'We need to conduct due diligence before the acquisition.',
    'The delay was due to technical issues.'
  ),
  collocations = jsonb_build_array('due date', 'due diligence', 'payment due', 'due to'),
  patterns = jsonb_build_array('be due + time', 'due to + noun', 'due + noun (due diligence)'),
  register = 'formal',
  variety = 'international'
WHERE headword = 'due' AND cefr_receptive = 'A1';

-- ear
UPDATE lexicon_entries SET
  ipa = '/ɪər/',
  definition_simple = 'the organ of hearing on each side of the head',
  definition_teacher = 'Noun referring to the hearing organ. In business, used in idioms like "lend an ear", "play it by ear", or "have someone''s ear".',
  usage_notes = 'Countable noun. Common in business idioms about listening and flexibility.',
  examples = jsonb_build_array(
    'Please lend me your ear for a moment.',
    'We''ll have to play it by ear and adapt.',
    'She has the CEO''s ear on this matter.',
    'Keep your ear to the ground for market changes.'
  ),
  collocations = jsonb_build_array('lend an ear', 'play it by ear', 'have someone''s ear', 'ear to the ground'),
  patterns = jsonb_build_array('lend + possessive + ear', 'play it by ear', 'have + possessive + ear'),
  register = 'informal',
  variety = 'international'
WHERE headword = 'ear' AND cefr_receptive = 'A1';

-- early
UPDATE lexicon_entries SET
  ipa = '/ˈɜːrli/',
  definition_simple = 'near the beginning of a period of time',
  definition_teacher = 'Adjective or adverb meaning near the start or before expected time. Essential in business for early stages, early adopters, and punctuality.',
  usage_notes = 'Very common in business. Can describe time (early morning), stage (early stage), or being ahead of schedule.',
  examples = jsonb_build_array(
    'We''re in the early stages of development.',
    'Early adopters are crucial for product success.',
    'Please arrive early for the meeting.',
    'The early bird gets the worm.'
  ),
  collocations = jsonb_build_array('early stage', 'early adopter', 'early bird', 'early on'),
  patterns = jsonb_build_array('early + noun', 'early in + time period', 'arrive/come early'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'early' AND cefr_receptive = 'A1';

-- earth
UPDATE lexicon_entries SET
  ipa = '/ɜːrθ/',
  definition_simple = 'the planet we live on, or the ground',
  definition_teacher = 'Noun meaning the planet or soil. In business, used in phrases like "down to earth", "cost the earth", or discussing sustainability.',
  usage_notes = 'Can be capitalized (Earth - the planet) or lowercase (earth - soil). Common in business idioms.',
  examples = jsonb_build_array(
    'We need a down-to-earth approach to this problem.',
    'The project won''t cost the earth.',
    'Environmental sustainability protects the Earth.',
    'Come back down to earth - be realistic.'
  ),
  collocations = jsonb_build_array('down to earth', 'cost the earth', 'on earth', 'come back to earth'),
  patterns = jsonb_build_array('down-to-earth + noun', 'cost the earth', 'on earth'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'earth' AND cefr_receptive = 'A1';

-- east
UPDATE lexicon_entries SET
  ipa = '/iːst/',
  definition_simple = 'the direction where the sun rises',
  definition_teacher = 'Noun or adjective indicating direction or region. In business, used for East Coast, Eastern markets, or geographic divisions.',
  usage_notes = 'Can be noun (the east), adjective (east coast), or adverb (go east). Often capitalized for regions.',
  examples = jsonb_build_array(
    'Our East Coast operations are growing.',
    'Eastern markets offer significant opportunities.',
    'The office is on the east side of the building.',
    'We''re expanding into East Asia.'
  ),
  collocations = jsonb_build_array('East Coast', 'Eastern markets', 'east side', 'East Asia'),
  patterns = jsonb_build_array('East/Eastern + noun', 'on the east + noun', 'east of + location'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'east' AND cefr_receptive = 'A1';

-- easy
UPDATE lexicon_entries SET
  ipa = '/ˈiːzi/',
  definition_simple = 'not difficult, requiring little effort',
  definition_teacher = 'Adjective meaning simple or comfortable. Essential in business for easy solutions, user-friendly products, and taking it easy.',
  usage_notes = 'Very common in business. Can describe tasks, people, or situations. Often used in phrases like "easier said than done".',
  examples = jsonb_build_array(
    'We need an easy-to-use interface.',
    'The solution is easier said than done.',
    'Take it easy - don''t stress too much.',
    'This is an easy win for the team.'
  ),
  collocations = jsonb_build_array('easy to use', 'easier said than done', 'take it easy', 'easy win'),
  patterns = jsonb_build_array('easy to + infinitive', 'easy-to-use + noun', 'take it easy', 'easy + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'easy' AND cefr_receptive = 'A1';

-- edge
UPDATE lexicon_entries SET
  ipa = '/edʒ/',
  definition_simple = 'the outside limit or border of something',
  definition_teacher = 'Noun meaning border, advantage, or sharpness. In business, used for competitive edge, cutting edge, or on the edge.',
  usage_notes = 'Multiple meanings: physical edge, competitive advantage, or state of tension. Very common in business.',
  examples = jsonb_build_array(
    'We need a competitive edge in the market.',
    'The company uses cutting-edge technology.',
    'Innovation gives us an edge over competitors.',
    'The business is on the edge of bankruptcy.'
  ),
  collocations = jsonb_build_array('competitive edge', 'cutting edge', 'have an edge', 'on the edge'),
  patterns = jsonb_build_array('competitive/cutting edge', 'have an edge over + noun', 'on the edge of + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'edge' AND cefr_receptive = 'A1';

-- else
UPDATE lexicon_entries SET
  ipa = '/els/',
  definition_simple = 'in addition, or different',
  definition_teacher = 'Adverb meaning in addition or otherwise. Common in business for alternatives, additional items, or consequences.',
  usage_notes = 'Used with question words (what else, who else) or after indefinite pronouns (something else, anyone else).',
  examples = jsonb_build_array(
    'What else do we need to discuss?',
    'Is there anything else I can help with?',
    'We need to act now, or else we''ll lose the opportunity.',
    'Someone else will handle that task.'
  ),
  collocations = jsonb_build_array('what else', 'anything else', 'or else', 'someone else'),
  patterns = jsonb_build_array('question word + else', 'indefinite pronoun + else', 'or else'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'else' AND cefr_receptive = 'A1';

-- end
UPDATE lexicon_entries SET
  ipa = '/end/',
  definition_simple = 'the final part or conclusion of something',
  definition_teacher = 'Noun or verb meaning conclusion or to finish. Essential in business for end results, year-end, and ending projects.',
  usage_notes = 'Very common in business. Can be noun (the end), verb (end the meeting), or in phrases (in the end, end result).',
  examples = jsonb_build_array(
    'In the end, quality matters most.',
    'The end result exceeded expectations.',
    'We need to end this meeting by 5 PM.',
    'Year-end reports are due next week.'
  ),
  collocations = jsonb_build_array('in the end', 'end result', 'year-end', 'end goal'),
  patterns = jsonb_build_array('in the end', 'end + noun', 'end + time period', 'the end of + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'end' AND cefr_receptive = 'A1';

-- enemy
UPDATE lexicon_entries SET
  ipa = '/ˈenəmi/',
  definition_simple = 'a person who is opposed to or hostile toward someone',
  definition_teacher = 'Noun meaning opponent or adversary. In business, used for competitors, obstacles, or the phrase "worst enemy".',
  usage_notes = 'Countable noun. Can be literal (actual enemy) or figurative (time is the enemy, worst enemy).',
  examples = jsonb_build_array(
    'Complacency is the enemy of innovation.',
    'Time is our enemy on this project.',
    'Don''t make enemies of your competitors.',
    'Perfectionism can be your worst enemy.'
  ),
  collocations = jsonb_build_array('worst enemy', 'enemy of', 'make enemies', 'public enemy'),
  patterns = jsonb_build_array('the enemy of + noun', 'worst enemy', 'make enemies of + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'enemy' AND cefr_receptive = 'A1';

-- English
UPDATE lexicon_entries SET
  ipa = '/ˈɪŋɡlɪʃ/',
  definition_simple = 'relating to England or the English language',
  definition_teacher = 'Adjective or noun referring to the language or nationality. Essential in business for English proficiency, English-speaking markets.',
  usage_notes = 'Can be adjective (English language) or noun (speak English). Always capitalized.',
  examples = jsonb_build_array(
    'English proficiency is required for this position.',
    'We operate in English-speaking markets.',
    'Business English skills are essential.',
    'The meeting will be conducted in English.'
  ),
  collocations = jsonb_build_array('English proficiency', 'English-speaking', 'business English', 'in English'),
  patterns = jsonb_build_array('English + noun', 'in English', 'speak/write English'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'English' AND cefr_receptive = 'A1';

-- enjoy
UPDATE lexicon_entries SET
  ipa = '/ɪnˈdʒɔɪ/',
  definition_simple = 'to take pleasure in something',
  definition_teacher = 'Verb meaning to take pleasure or benefit from. In business, used for enjoying work, enjoying benefits, or customer enjoyment.',
  usage_notes = 'Followed by noun or gerund (-ing form). Common in business for employee satisfaction and customer experience.',
  examples = jsonb_build_array(
    'Employees enjoy flexible working hours.',
    'We hope you enjoy working with our team.',
    'Customers enjoy the personalized service.',
    'Staff enjoy competitive benefits.'
  ),
  collocations = jsonb_build_array('enjoy working', 'enjoy benefits', 'enjoy doing', 'enjoy success'),
  patterns = jsonb_build_array('enjoy + noun', 'enjoy + gerund', 'enjoy + possessive + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'enjoy' AND cefr_receptive = 'A1';

-- enough
UPDATE lexicon_entries SET
  ipa = '/ɪˈnʌf/',
  definition_simple = 'as much or as many as required',
  definition_teacher = 'Determiner, pronoun, or adverb meaning sufficient amount. Essential in business for discussing adequacy of resources, time, or effort.',
  usage_notes = 'Can come before noun (enough time) or after adjective (good enough). Very common in business contexts.',
  examples = jsonb_build_array(
    'We don''t have enough resources for this project.',
    'Is the budget large enough?',
    'Enough is enough - we need to make a decision.',
    'The team has done enough preparation.'
  ),
  collocations = jsonb_build_array('enough time', 'good enough', 'enough is enough', 'not enough'),
  patterns = jsonb_build_array('enough + noun', 'adjective + enough', 'enough to + infinitive'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'enough' AND cefr_receptive = 'A1';

-- entire
UPDATE lexicon_entries SET
  ipa = '/ɪnˈtaɪər/',
  definition_simple = 'whole or complete, with nothing missing',
  definition_teacher = 'Adjective meaning complete or whole. Common in business for emphasizing completeness (entire team, entire organization).',
  usage_notes = 'Always used before noun. Emphasizes completeness or totality. Very common in business.',
  examples = jsonb_build_array(
    'The entire team attended the training.',
    'This affects the entire organization.',
    'We need to review the entire process.',
    'The entire project took six months.'
  ),
  collocations = jsonb_build_array('entire team', 'entire organization', 'entire process', 'entire project'),
  patterns = jsonb_build_array('the entire + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'entire' AND cefr_receptive = 'A1';

-- equal
UPDATE lexicon_entries SET
  ipa = '/ˈiːkwəl/',
  definition_simple = 'the same in amount, size, or value',
  definition_teacher = 'Adjective or verb meaning same or equivalent. Essential in business for equal opportunities, equal pay, and equality.',
  usage_notes = 'Can be adjective (equal pay) or verb (equals). Important for discussing fairness and equivalence.',
  examples = jsonb_build_array(
    'We provide equal opportunities for all employees.',
    'Equal pay for equal work is our policy.',
    'All team members have equal voice in decisions.',
    'Quality equals customer satisfaction.'
  ),
  collocations = jsonb_build_array('equal opportunity', 'equal pay', 'equal rights', 'on equal terms'),
  patterns = jsonb_build_array('equal + noun', 'equal to + noun', 'noun + equals + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'equal' AND cefr_receptive = 'A1';

-- escape
UPDATE lexicon_entries SET
  ipa = '/ɪˈskeɪp/',
  definition_simple = 'to get free from something unpleasant or dangerous',
  definition_teacher = 'Verb or noun meaning to get away or avoid. In business, used for escaping problems, escape clauses, or narrow escapes.',
  usage_notes = 'Can be verb (escape from) or noun (an escape). Common in business for avoiding problems or exit strategies.',
  examples = jsonb_build_array(
    'We cannot escape the reality of market conditions.',
    'The contract includes an escape clause.',
    'The company had a narrow escape from bankruptcy.',
    'There''s no escaping the need for change.'
  ),
  collocations = jsonb_build_array('escape clause', 'narrow escape', 'escape from', 'no escaping'),
  patterns = jsonb_build_array('escape + noun', 'escape from + noun', 'there''s no escaping + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'escape' AND cefr_receptive = 'A1';

-- even
UPDATE lexicon_entries SET
  ipa = '/ˈiːvən/',
  definition_simple = 'used to emphasize something surprising, or flat and level',
  definition_teacher = 'Adverb for emphasis or adjective meaning level. In business, used for emphasis (even better) or fairness (even playing field).',
  usage_notes = 'Multiple uses: emphasis (even more), level surface (even ground), or fair (even-handed). Very common.',
  examples = jsonb_build_array(
    'The results are even better than expected.',
    'We need an even playing field for all competitors.',
    'Even experienced managers make mistakes.',
    'The workload should be evenly distributed.'
  ),
  collocations = jsonb_build_array('even better', 'even playing field', 'even more', 'even-handed'),
  patterns = jsonb_build_array('even + comparative', 'even + noun', 'even playing field'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'even' AND cefr_receptive = 'A1';

-- evening
UPDATE lexicon_entries SET
  ipa = '/ˈiːvnɪŋ/',
  definition_simple = 'the part of the day between afternoon and night',
  definition_teacher = 'Noun referring to late afternoon/early night period. In business, relevant for evening shifts, evening events, or work-life balance.',
  usage_notes = 'Countable noun. Used with "in the" (in the evening) or "this/tomorrow" (this evening).',
  examples = jsonb_build_array(
    'The networking event is tomorrow evening.',
    'Evening shifts receive additional compensation.',
    'We offer evening classes for employees.',
    'Good evening, everyone. Let''s begin the meeting.'
  ),
  collocations = jsonb_build_array('this evening', 'tomorrow evening', 'evening shift', 'good evening'),
  patterns = jsonb_build_array('in the evening', 'this/tomorrow evening', 'evening + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'evening' AND cefr_receptive = 'A1';

-- event
UPDATE lexicon_entries SET
  ipa = '/ɪˈvent/',
  definition_simple = 'something that happens, especially something important',
  definition_teacher = 'Noun meaning occurrence or organized occasion. Essential in business for events, event planning, and discussing occurrences.',
  usage_notes = 'Countable noun. Very common in business for conferences, launches, and significant occurrences.',
  examples = jsonb_build_array(
    'The product launch event was successful.',
    'We organize networking events quarterly.',
    'In the event of a problem, contact support.',
    'This is a significant event for the company.'
  ),
  collocations = jsonb_build_array('launch event', 'networking event', 'in the event of', 'major event'),
  patterns = jsonb_build_array('noun + event', 'in the event of + noun', 'organize/host an event'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'event' AND cefr_receptive = 'A1';

-- ever
UPDATE lexicon_entries SET
  ipa = '/ˈevər/',
  definition_simple = 'at any time',
  definition_teacher = 'Adverb meaning at any time or always. Common in business for emphasis (best ever), questions (have you ever), and superlatives.',
  usage_notes = 'Used in questions, negatives, comparisons, and with superlatives. Very versatile word.',
  examples = jsonb_build_array(
    'This is the best result we''ve ever achieved.',
    'Have you ever worked in sales before?',
    'If you ever need assistance, please ask.',
    'The market is more competitive than ever.'
  ),
  collocations = jsonb_build_array('best ever', 'have you ever', 'if ever', 'more than ever'),
  patterns = jsonb_build_array('superlative + ever', 'have + subject + ever + past participle', 'if ever'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'ever' AND cefr_receptive = 'A1';

-- evil
UPDATE lexicon_entries SET
  ipa = '/ˈiːvəl/',
  definition_simple = 'very bad or harmful',
  definition_teacher = 'Adjective or noun meaning morally wrong or harmful. In business, used for necessary evil or evil practices.',
  usage_notes = 'Strong word. Can be adjective (evil practices) or noun (a necessary evil). Less common in formal business.',
  examples = jsonb_build_array(
    'Bureaucracy is sometimes a necessary evil.',
    'Unethical practices are an evil we must eliminate.',
    'The company fights against evil business practices.',
    'Regulations are a necessary evil for consumer protection.'
  ),
  collocations = jsonb_build_array('necessary evil', 'evil practices', 'lesser evil', 'fight evil'),
  patterns = jsonb_build_array('a necessary evil', 'evil + noun', 'the lesser evil'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'evil' AND cefr_receptive = 'A1';

-- excellent
UPDATE lexicon_entries SET
  ipa = '/ˈeksələnt/',
  definition_simple = 'extremely good or of very high quality',
  definition_teacher = 'Adjective meaning outstanding or superior. Very common in business for praise, quality standards, and excellence.',
  usage_notes = 'Strong positive adjective. Very common in business for describing quality, performance, and results.',
  examples = jsonb_build_array(
    'The team delivered excellent results.',
    'She has excellent communication skills.',
    'Customer feedback has been excellent.',
    'We strive for excellence in everything we do.'
  ),
  collocations = jsonb_build_array('excellent results', 'excellent performance', 'excellent quality', 'strive for excellence'),
  patterns = jsonb_build_array('excellent + noun', 'strive for excellence'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'excellent' AND cefr_receptive = 'A1';

-- except
UPDATE lexicon_entries SET
  ipa = '/ɪkˈsept/',
  definition_simple = 'not including, other than',
  definition_teacher = 'Preposition or conjunction meaning excluding or but. Common in business for stating exceptions and exclusions.',
  usage_notes = 'Used to introduce exceptions. Can be followed by noun, pronoun, or clause (except that).',
  examples = jsonb_build_array(
    'All departments except finance have submitted reports.',
    'The office is open daily except Sundays.',
    'Everyone attended except the CEO.',
    'The plan is good except that it''s too expensive.'
  ),
  collocations = jsonb_build_array('except for', 'except that', 'except when', 'everyone except'),
  patterns = jsonb_build_array('except + noun', 'except for + noun', 'except that + clause'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'except' AND cefr_receptive = 'A1';

-- exchange
UPDATE lexicon_entries SET
  ipa = '/ɪksˈtʃeɪndʒ/',
  definition_simple = 'the act of giving and receiving something',
  definition_teacher = 'Noun or verb meaning to trade or swap. Essential in business for exchange rates, stock exchanges, and information exchange.',
  usage_notes = 'Very common in business. Can be noun (an exchange) or verb (to exchange). Multiple business applications.',
  examples = jsonb_build_array(
    'The stock exchange opens at 9 AM.',
    'Let''s exchange contact information.',
    'Exchange rates affect international business.',
    'We had a productive exchange of ideas.'
  ),
  collocations = jsonb_build_array('stock exchange', 'exchange rate', 'exchange information', 'in exchange for'),
  patterns = jsonb_build_array('exchange + noun', 'in exchange for + noun', 'noun + exchange'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'exchange' AND cefr_receptive = 'A1';

-- exercise
UPDATE lexicon_entries SET
  ipa = '/ˈeksərsaɪz/',
  definition_simple = 'physical activity to stay healthy, or to use or practice something',
  definition_teacher = 'Noun or verb meaning physical activity or to use/practice. In business, used for exercising options, judgment, or team exercises.',
  usage_notes = 'Multiple meanings: physical activity, practice activity, or to use (exercise judgment, exercise options).',
  examples = jsonb_build_array(
    'The company provides exercise facilities for employees.',
    'Please exercise caution when sharing confidential data.',
    'Team-building exercises improve collaboration.',
    'Shareholders can exercise their voting rights.'
  ),
  collocations = jsonb_build_array('exercise caution', 'team-building exercise', 'exercise rights', 'exercise judgment'),
  patterns = jsonb_build_array('exercise + noun', 'noun + exercise', 'exercise + possessive + rights'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'exercise' AND cefr_receptive = 'A1';

-- expense
UPDATE lexicon_entries SET
  ipa = '/ɪkˈspens/',
  definition_simple = 'the cost or money spent on something',
  definition_teacher = 'Noun meaning cost or expenditure. Essential in business for expense reports, at the expense of, and managing expenses.',
  usage_notes = 'Can be countable (expenses) or uncountable (expense). Very common in business financial contexts.',
  examples = jsonb_build_array(
    'Please submit your expense report by Friday.',
    'We need to reduce operating expenses.',
    'Don''t cut quality at the expense of cost.',
    'Travel expenses will be reimbursed.'
  ),
  collocations = jsonb_build_array('expense report', 'operating expenses', 'at the expense of', 'travel expenses'),
  patterns = jsonb_build_array('expense + noun', 'at the expense of + noun', 'reduce/cut expenses'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'expense' AND cefr_receptive = 'A1';

-- experiment
UPDATE lexicon_entries SET
  ipa = '/ɪkˈsperɪmənt/',
  definition_simple = 'a test to discover or prove something',
  definition_teacher = 'Noun or verb meaning a test or trial. In business, used for experimenting with approaches, A/B testing, or pilot programs.',
  usage_notes = 'Can be noun (an experiment) or verb (to experiment). Common in innovation and testing contexts.',
  examples = jsonb_build_array(
    'We''re experimenting with new marketing strategies.',
    'The pilot program is an experiment.',
    'Let''s experiment with different approaches.',
    'The experiment yielded valuable insights.'
  ),
  collocations = jsonb_build_array('experiment with', 'conduct an experiment', 'pilot experiment', 'experiment shows'),
  patterns = jsonb_build_array('experiment with + noun', 'conduct/run an experiment', 'the experiment + verb'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'experiment' AND cefr_receptive = 'A1';

-- face
UPDATE lexicon_entries SET
  ipa = '/feɪs/',
  definition_simple = 'the front part of the head, or to confront something',
  definition_teacher = 'Noun or verb meaning facial features or to confront. Essential in business for face-to-face, facing challenges, and saving face.',
  usage_notes = 'Very versatile. Can be noun (the face) or verb (face challenges). Many business idioms.',
  examples = jsonb_build_array(
    'We prefer face-to-face meetings for important discussions.',
    'The company faces significant challenges.',
    'Let''s face the facts and make a decision.',
    'We need to save face in this negotiation.'
  ),
  collocations = jsonb_build_array('face-to-face', 'face challenges', 'face the facts', 'save face'),
  patterns = jsonb_build_array('face-to-face + noun', 'face + noun', 'face the + noun', 'save face'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'face' AND cefr_receptive = 'A1';

-- factory
UPDATE lexicon_entries SET
  ipa = '/ˈfæktəri/',
  definition_simple = 'a building where goods are manufactured',
  definition_teacher = 'Noun meaning manufacturing facility. Common in business for discussing production, manufacturing, and supply chains.',
  usage_notes = 'Countable noun. Essential vocabulary for manufacturing and production contexts.',
  examples = jsonb_build_array(
    'The factory produces 10,000 units daily.',
    'We''re opening a new factory in Asia.',
    'Factory workers receive competitive wages.',
    'The factory operates 24/7.'
  ),
  collocations = jsonb_build_array('factory worker', 'factory floor', 'open a factory', 'factory production'),
  patterns = jsonb_build_array('factory + noun', 'in/at the factory', 'open/close a factory'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'factory' AND cefr_receptive = 'A1';

-- fair
UPDATE lexicon_entries SET
  ipa = '/feər/',
  definition_simple = 'treating people equally, or quite good',
  definition_teacher = 'Adjective meaning just, reasonable, or moderate. Essential in business for fair treatment, fair price, and fairness.',
  usage_notes = 'Multiple meanings: just/equitable, moderate/reasonable, or quite good. Very important in business ethics.',
  examples = jsonb_build_array(
    'We ensure fair treatment for all employees.',
    'The price is fair for the quality offered.',
    'It''s only fair to give everyone a chance.',
    'Fair competition benefits consumers.'
  ),
  collocations = jsonb_build_array('fair treatment', 'fair price', 'fair competition', 'fair share'),
  patterns = jsonb_build_array('fair + noun', 'it''s fair to + infinitive', 'fair and + adjective'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'fair' AND cefr_receptive = 'A1';

-- faith
UPDATE lexicon_entries SET
  ipa = '/feɪθ/',
  definition_simple = 'strong belief or trust in someone or something',
  definition_teacher = 'Noun meaning trust, confidence, or religious belief. In business, used for having faith in team, good faith negotiations.',
  usage_notes = 'Uncountable noun. Common in business for expressing trust and confidence.',
  examples = jsonb_build_array(
    'We have faith in the team''s ability to deliver.',
    'Negotiations should be conducted in good faith.',
    'The CEO''s faith in the strategy was justified.',
    'Keep the faith - success will come.'
  ),
  collocations = jsonb_build_array('have faith in', 'good faith', 'keep the faith', 'faith in'),
  patterns = jsonb_build_array('have/keep faith in + noun', 'in good faith', 'faith that + clause'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'faith' AND cefr_receptive = 'A1';

-- fall
UPDATE lexicon_entries SET
  ipa = '/fɔːl/',
  definition_simple = 'to drop down or decrease',
  definition_teacher = 'Verb or noun meaning to drop, decrease, or autumn. Essential in business for falling prices, falling behind, or fall in sales.',
  usage_notes = 'Irregular verb: fall, fell, fallen. Multiple meanings: drop, decrease, or season (US: fall = autumn).',
  examples = jsonb_build_array(
    'Sales fell by 10% last quarter.',
    'Don''t fall behind schedule.',
    'The project falls under her responsibility.',
    'There was a sharp fall in demand.'
  ),
  collocations = jsonb_build_array('fall behind', 'fall under', 'fall in sales', 'fall short'),
  patterns = jsonb_build_array('fall + adverb', 'fall behind + noun', 'fall under + noun', 'a fall in + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'fall' AND cefr_receptive = 'A1';

-- familiar
UPDATE lexicon_entries SET
  ipa = '/fəˈmɪliər/',
  definition_simple = 'well known or easily recognized',
  definition_teacher = 'Adjective meaning well-known or knowledgeable about. In business, used for familiar with processes, familiar territory.',
  usage_notes = 'Usually followed by "with" or "to". Important for discussing knowledge and experience.',
  examples = jsonb_build_array(
    'Are you familiar with our company policies?',
    'The process should be familiar to experienced staff.',
    'We''re entering familiar territory with this project.',
    'She''s familiar with international business practices.'
  ),
  collocations = jsonb_build_array('familiar with', 'familiar to', 'familiar territory', 'familiar face'),
  patterns = jsonb_build_array('familiar with + noun', 'familiar to + person', 'familiar + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'familiar' AND cefr_receptive = 'A1';

-- famous
UPDATE lexicon_entries SET
  ipa = '/ˈfeɪməs/',
  definition_simple = 'known by many people',
  definition_teacher = 'Adjective meaning well-known or renowned. In business, used for famous brands, famous for quality, or reputation.',
  usage_notes = 'Usually followed by "for". Common in marketing and branding contexts.',
  examples = jsonb_build_array(
    'The company is famous for its innovation.',
    'We''re building a famous brand.',
    'The CEO is famous in the industry.',
    'Our products are famous for quality.'
  ),
  collocations = jsonb_build_array('famous for', 'famous brand', 'world-famous', 'become famous'),
  patterns = jsonb_build_array('famous for + noun/gerund', 'famous + noun', 'become/make famous'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'famous' AND cefr_receptive = 'A1';

-- farm
UPDATE lexicon_entries SET
  ipa = '/fɑːrm/',
  definition_simple = 'an area of land used for growing crops or keeping animals',
  definition_teacher = 'Noun or verb meaning agricultural land or to cultivate. In business, used for server farms, farming out work, or agribusiness.',
  usage_notes = 'Can be noun (a farm) or verb (farm out = outsource). Used literally and in tech contexts (server farm).',
  examples = jsonb_build_array(
    'The company operates a large server farm.',
    'We farm out some tasks to contractors.',
    'Agribusiness includes farms and food processing.',
    'The data center is like a server farm.'
  ),
  collocations = jsonb_build_array('server farm', 'farm out', 'farm work', 'farm to table'),
  patterns = jsonb_build_array('farm out + noun', 'noun + farm', 'on/at the farm'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'farm' AND cefr_receptive = 'A1';

-- fashion
UPDATE lexicon_entries SET
  ipa = '/ˈfæʃən/',
  definition_simple = 'a popular style of clothes, or a way of doing something',
  definition_teacher = 'Noun meaning style, manner, or trend. In business, used for fashion industry, in a timely fashion, or after a fashion.',
  usage_notes = 'Multiple meanings: clothing style, manner of doing, or trend. Common in various business contexts.',
  examples = jsonb_build_array(
    'Please complete the task in a timely fashion.',
    'The fashion industry is highly competitive.',
    'We need to respond in a professional fashion.',
    'After a fashion, the solution works.'
  ),
  collocations = jsonb_build_array('in a timely fashion', 'fashion industry', 'after a fashion', 'in this fashion'),
  patterns = jsonb_build_array('in a + adjective + fashion', 'fashion + noun', 'after a fashion'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'fashion' AND cefr_receptive = 'A1';

-- fast
UPDATE lexicon_entries SET
  ipa = '/fæst/',
  definition_simple = 'moving or happening quickly',
  definition_teacher = 'Adjective or adverb meaning quick or rapid. Essential in business for fast-paced, fast track, and speed of operations.',
  usage_notes = 'Can be adjective (fast service) or adverb (move fast). Very common in business for speed and efficiency.',
  examples = jsonb_build_array(
    'We operate in a fast-paced environment.',
    'The company is on the fast track to success.',
    'We need to move fast to capture the opportunity.',
    'Fast delivery is our competitive advantage.'
  ),
  collocations = jsonb_build_array('fast-paced', 'fast track', 'move fast', 'fast delivery'),
  patterns = jsonb_build_array('fast-paced + noun', 'fast track to + noun', 'move/act fast'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'fast' AND cefr_receptive = 'A1';

-- favour (favor)
UPDATE lexicon_entries SET
  ipa = '/ˈfeɪvər/',
  definition_simple = 'approval or support, or a kind act',
  definition_teacher = 'Noun or verb meaning support, preference, or kind act. In business, used for in favor of, do a favor, or favorable conditions.',
  usage_notes = 'Spelled "favour" in UK, "favor" in US. Can be noun (a favor) or verb (favor an option).',
  examples = jsonb_build_array(
    'The decision is in favor of the proposal.',
    'Could you do me a favor and review this?',
    'Market conditions favor our strategy.',
    'We need favorable terms for the contract.'
  ),
  collocations = jsonb_build_array('in favor of', 'do a favor', 'favorable conditions', 'favor over'),
  patterns = jsonb_build_array('in favor of + noun', 'do + person + a favor', 'favor + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'favour' AND cefr_receptive = 'A1';

-- favourite (favorite)
UPDATE lexicon_entries SET
  ipa = '/ˈfeɪvərɪt/',
  definition_simple = 'liked more than others',
  definition_teacher = 'Adjective or noun meaning most preferred. In business, used for favorite choice, customer favorites, or market favorites.',
  usage_notes = 'Spelled "favourite" in UK, "favorite" in US. Can be adjective or noun.',
  examples = jsonb_build_array(
    'This is our customers'' favorite product.',
    'What''s your favorite approach to problem-solving?',
    'The company is a market favorite.',
    'Customer favorites drive our product development.'
  ),
  collocations = jsonb_build_array('customer favorite', 'favorite product', 'market favorite', 'favorite choice'),
  patterns = jsonb_build_array('favorite + noun', 'possessive + favorite', 'a favorite among + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'favourite' AND cefr_receptive = 'A1';

-- fear
UPDATE lexicon_entries SET
  ipa = '/fɪər/',
  definition_simple = 'an unpleasant emotion caused by danger or threat',
  definition_teacher = 'Noun or verb meaning anxiety or to be afraid. In business, used for fear of failure, fear factor, or addressing fears.',
  usage_notes = 'Can be noun (a fear) or verb (fear that). Common in discussing risks and concerns.',
  examples = jsonb_build_array(
    'Fear of failure can prevent innovation.',
    'We fear that costs will exceed budget.',
    'Address employee fears about the reorganization.',
    'There''s no need to fear competition.'
  ),
  collocations = jsonb_build_array('fear of failure', 'fear that', 'address fears', 'no fear'),
  patterns = jsonb_build_array('fear of + noun', 'fear that + clause', 'address/overcome fears'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'fear' AND cefr_receptive = 'A1';

-- feed
UPDATE lexicon_entries SET
  ipa = '/fiːd/',
  definition_simple = 'to give food to someone or something',
  definition_teacher = 'Verb or noun meaning to provide food or information. In business, used for feedback, feed information, or news feeds.',
  usage_notes = 'Irregular verb: feed, fed, fed. Can mean provide food or provide information (feed data into system).',
  examples = jsonb_build_array(
    'Please feed the data into the system.',
    'Customer feedback feeds our improvement process.',
    'The news feed provides real-time updates.',
    'We need to feed information to stakeholders regularly.'
  ),
  collocations = jsonb_build_array('feed into', 'news feed', 'feed information', 'feedback loop'),
  patterns = jsonb_build_array('feed + noun + into + noun', 'feed + person + information', 'noun + feed'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'feed' AND cefr_receptive = 'A1';

-- fellow
UPDATE lexicon_entries SET
  ipa = '/ˈfeləʊ/',
  definition_simple = 'a person in the same group or situation',
  definition_teacher = 'Noun or adjective meaning colleague or peer. In business, used for fellow employees, fellow members, or fellowship.',
  usage_notes = 'Can be noun (a fellow) or adjective (fellow workers). Somewhat formal tone.',
  examples = jsonb_build_array(
    'Please support your fellow team members.',
    'She''s a fellow of the professional association.',
    'Fellow employees are invited to the event.',
    'We value fellowship and collaboration.'
  ),
  collocations = jsonb_build_array('fellow employee', 'fellow member', 'fellow worker', 'fellow colleague'),
  patterns = jsonb_build_array('fellow + noun', 'a fellow of + organization'),
  register = 'formal',
  variety = 'international'
WHERE headword = 'fellow' AND cefr_receptive = 'A1';

-- field
UPDATE lexicon_entries SET
  ipa = '/fiːld/',
  definition_simple = 'an area of land or a subject of study or work',
  definition_teacher = 'Noun meaning area of land, subject area, or sphere of activity. Essential in business for field of work, field research, or playing field.',
  usage_notes = 'Multiple meanings: physical field, area of expertise, or competitive arena. Very common in business.',
  examples = jsonb_build_array(
    'She''s an expert in her field.',
    'We conduct field research with customers.',
    'The playing field must be level for all competitors.',
    'This opens up new fields of opportunity.'
  ),
  collocations = jsonb_build_array('in the field', 'field research', 'playing field', 'field of work'),
  patterns = jsonb_build_array('in the field of + noun', 'field + noun', 'level playing field'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'field' AND cefr_receptive = 'A1';

-- finger
UPDATE lexicon_entries SET
  ipa = '/ˈfɪŋɡər/',
  definition_simple = 'one of the five long parts at the end of each hand',
  definition_teacher = 'Noun referring to hand digits. In business, used in idioms like "put your finger on", "fingers crossed", or "finger on the pulse".',
  usage_notes = 'Countable noun. Common in business idioms about identifying problems or staying informed.',
  examples = jsonb_build_array(
    'I can''t quite put my finger on the problem.',
    'Keep your finger on the pulse of market trends.',
    'Fingers crossed that the deal goes through.',
    'Don''t point fingers - focus on solutions.'
  ),
  collocations = jsonb_build_array('put finger on', 'finger on the pulse', 'fingers crossed', 'point fingers'),
  patterns = jsonb_build_array('put + possessive + finger on + noun', 'finger on the pulse', 'point fingers at + person'),
  register = 'informal',
  variety = 'international'
WHERE headword = 'finger' AND cefr_receptive = 'A1';

-- fire
UPDATE lexicon_entries SET
  ipa = '/ˈfaɪər/',
  definition_simple = 'the hot bright flames produced when something burns',
  definition_teacher = 'Noun or verb meaning flames or to dismiss from job. In business, used for firing employees, under fire, or fire up enthusiasm.',
  usage_notes = 'Multiple meanings: flames, dismiss employee, or energize. Context determines meaning.',
  examples = jsonb_build_array(
    'The manager was fired for misconduct.',
    'The CEO is under fire for the decision.',
    'We need to fire up the team''s enthusiasm.',
    'Fire safety training is mandatory.'
  ),
  collocations = jsonb_build_array('fire someone', 'under fire', 'fire up', 'fire safety'),
  patterns = jsonb_build_array('fire + person', 'under fire for + noun', 'fire up + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'fire' AND cefr_receptive = 'A1';

-- fish
UPDATE lexicon_entries SET
  ipa = '/fɪʃ/',
  definition_simple = 'an animal that lives in water',
  definition_teacher = 'Noun or verb meaning aquatic animal or to search. In business, used in idioms like "big fish", "fish for compliments", or "fishing expedition".',
  usage_notes = 'Can be noun (fish - same singular/plural) or verb (fish for information). Common in business idioms.',
  examples = jsonb_build_array(
    'We''re trying to land a big fish client.',
    'Don''t fish for compliments - be direct.',
    'This is a fishing expedition for information.',
    'There are bigger fish to fry - focus on priorities.'
  ),
  collocations = jsonb_build_array('big fish', 'fish for', 'fishing expedition', 'bigger fish to fry'),
  patterns = jsonb_build_array('big fish', 'fish for + noun', 'bigger fish to fry'),
  register = 'informal',
  variety = 'international'
WHERE headword = 'fish' AND cefr_receptive = 'A1';

-- floor
UPDATE lexicon_entries SET
  ipa = '/flɔːr/',
  definition_simple = 'the surface you walk on inside a building',
  definition_teacher = 'Noun meaning ground surface or level of building. In business, used for trading floor, shop floor, or having the floor.',
  usage_notes = 'Multiple meanings: surface, building level, or right to speak (have the floor).',
  examples = jsonb_build_array(
    'The trading floor is very busy today.',
    'Shop floor workers provide valuable feedback.',
    'The CEO has the floor - please listen.',
    'Our office is on the third floor.'
  ),
  collocations = jsonb_build_array('trading floor', 'shop floor', 'have the floor', 'ground floor'),
  patterns = jsonb_build_array('noun + floor', 'have/take the floor', 'on the + ordinal + floor'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'floor' AND cefr_receptive = 'A1';

-- flower
UPDATE lexicon_entries SET
  ipa = '/ˈflaʊər/',
  definition_simple = 'the colored part of a plant that produces seeds',
  definition_teacher = 'Noun or verb meaning blossom or to develop well. In business, occasionally used metaphorically for flourishing or blooming.',
  usage_notes = 'Can be noun (a flower) or verb (flower = flourish). Less common in business except metaphorically.',
  examples = jsonb_build_array(
    'The business is flowering in the new market.',
    'Ideas need time to flower into products.',
    'The office has fresh flowers weekly.',
    'Let creativity flower in the team.'
  ),
  collocations = jsonb_build_array('flower into', 'fresh flowers', 'let flower', 'flower arrangement'),
  patterns = jsonb_build_array('flower into + noun', 'let + noun + flower'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'flower' AND cefr_receptive = 'A1';

-- foreign
UPDATE lexicon_entries SET
  ipa = '/ˈfɒrən/',
  definition_simple = 'from or relating to a country that is not your own',
  definition_teacher = 'Adjective meaning from another country or unfamiliar. Essential in business for foreign markets, foreign investment, foreign exchange.',
  usage_notes = 'Very common in international business contexts. Always used before noun.',
  examples = jsonb_build_array(
    'We''re expanding into foreign markets.',
    'Foreign investment drives economic growth.',
    'Foreign exchange rates affect our pricing.',
    'The concept is foreign to many employees.'
  ),
  collocations = jsonb_build_array('foreign market', 'foreign investment', 'foreign exchange', 'foreign to'),
  patterns = jsonb_build_array('foreign + noun', 'foreign to + person'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'foreign' AND cefr_receptive = 'A1';

-- former
UPDATE lexicon_entries SET
  ipa = '/ˈfɔːrmər/',
  definition_simple = 'existing or happening in the past',
  definition_teacher = 'Adjective meaning previous or earlier. In business, used for former employees, former position, or the former option.',
  usage_notes = 'Always used before noun. Can also mean "the first of two" (the former vs. the latter).',
  examples = jsonb_build_array(
    'She''s a former CEO of a Fortune 500 company.',
    'The former system was less efficient.',
    'Of the two options, I prefer the former.',
    'Former employees are welcome to return.'
  ),
  collocations = jsonb_build_array('former employee', 'former position', 'the former', 'former CEO'),
  patterns = jsonb_build_array('former + noun', 'the former + noun'),
  register = 'formal',
  variety = 'international'
WHERE headword = 'former' AND cefr_receptive = 'A1';

-- forth
UPDATE lexicon_entries SET
  ipa = '/fɔːrθ/',
  definition_simple = 'forward in time, place, or order',
  definition_teacher = 'Adverb meaning forward or onward. In business, mainly used in phrases like "and so forth", "back and forth", or "set forth".',
  usage_notes = 'Formal and somewhat archaic. Mainly appears in fixed phrases in business contexts.',
  examples = jsonb_build_array(
    'The document sets forth our objectives.',
    'We discussed pricing, delivery, and so forth.',
    'There was much back and forth in the negotiation.',
    'From this day forth, we implement new procedures.'
  ),
  collocations = jsonb_build_array('and so forth', 'back and forth', 'set forth', 'from this day forth'),
  patterns = jsonb_build_array('and so forth', 'back and forth', 'set forth + noun'),
  register = 'formal',
  variety = 'international'
WHERE headword = 'forth' AND cefr_receptive = 'A1';

-- fortune
UPDATE lexicon_entries SET
  ipa = '/ˈfɔːrtʃuːn/',
  definition_simple = 'a large amount of money, or luck',
  definition_teacher = 'Noun meaning wealth, luck, or fate. In business, used for making a fortune, Fortune 500, or good fortune.',
  usage_notes = 'Can mean wealth (make a fortune) or luck (good fortune). Common in business success contexts.',
  examples = jsonb_build_array(
    'The company is a Fortune 500 business.',
    'He made a fortune in real estate.',
    'Good fortune favored the venture.',
    'It cost a fortune to develop the product.'
  ),
  collocations = jsonb_build_array('Fortune 500', 'make a fortune', 'good fortune', 'cost a fortune'),
  patterns = jsonb_build_array('make a fortune', 'Fortune + number', 'cost a fortune'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'fortune' AND cefr_receptive = 'A1';

-- forward
UPDATE lexicon_entries SET
  ipa = '/ˈfɔːrwərd/',
  definition_simple = 'toward the front or future',
  definition_teacher = 'Adverb, adjective, or verb meaning ahead or to send on. Essential in business for moving forward, forward-thinking, or forwarding emails.',
  usage_notes = 'Very versatile. Can be adverb (move forward), adjective (forward-thinking), or verb (forward an email).',
  examples = jsonb_build_array(
    'Let''s move forward with the plan.',
    'We need forward-thinking strategies.',
    'Please forward the email to the team.',
    'Looking forward to working with you.'
  ),
  collocations = jsonb_build_array('move forward', 'forward-thinking', 'forward email', 'look forward to'),
  patterns = jsonb_build_array('move/go forward', 'forward-thinking + noun', 'forward + noun + to + person', 'look forward to + gerund'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'forward' AND cefr_receptive = 'A1';

-- free
UPDATE lexicon_entries SET
  ipa = '/friː/',
  definition_simple = 'not costing money, or not controlled or limited',
  definition_teacher = 'Adjective or verb meaning without cost, unrestricted, or to release. Essential in business for free trial, free time, or setting free.',
  usage_notes = 'Multiple meanings: no cost, unrestricted, available, or to release. Very common in business.',
  examples = jsonb_build_array(
    'We offer a free trial period.',
    'Are you free for a meeting tomorrow?',
    'Feel free to contact me anytime.',
    'The market operates on free competition.'
  ),
  collocations = jsonb_build_array('free trial', 'feel free', 'free time', 'free market'),
  patterns = jsonb_build_array('free + noun', 'feel free to + infinitive', 'be free + time'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'free' AND cefr_receptive = 'A1';

-- full
UPDATE lexicon_entries SET
  ipa = '/fʊl/',
  definition_simple = 'containing as much as possible, or complete',
  definition_teacher = 'Adjective meaning filled, complete, or maximum. Essential in business for full-time, full capacity, or full potential.',
  usage_notes = 'Very common in business. Can mean filled, complete, or maximum (full speed, full capacity).',
  examples = jsonb_build_array(
    'She works full-time at the company.',
    'We''re operating at full capacity.',
    'Please provide full details in the report.',
    'The team is reaching its full potential.'
  ),
  collocations = jsonb_build_array('full-time', 'full capacity', 'full potential', 'full details'),
  patterns = jsonb_build_array('full-time + noun', 'at full + noun', 'full + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'full' AND cefr_receptive = 'A1';

-- further
UPDATE lexicon_entries SET
  ipa = '/ˈfɜːrðər/',
  definition_simple = 'more, additional, or to a greater degree',
  definition_teacher = 'Adjective or adverb meaning additional or more. Essential in business for further information, further discussion, or going further.',
  usage_notes = 'Can mean "additional" (further questions) or "more distant" (further away). Very common in business.',
  examples = jsonb_build_array(
    'Please contact me if you need further information.',
    'We require further discussion before deciding.',
    'Let''s take this further in the next meeting.',
    'Further analysis is needed.'
  ),
  collocations = jsonb_build_array('further information', 'further discussion', 'take further', 'further analysis'),
  patterns = jsonb_build_array('further + noun', 'take + noun + further', 'go further'),
  register = 'formal',
  variety = 'international'
WHERE headword = 'further' AND cefr_receptive = 'A1';

-- future
UPDATE lexicon_entries SET
  ipa = '/ˈfjuːtʃər/',
  definition_simple = 'the time that will come after the present',
  definition_teacher = 'Noun or adjective meaning time ahead or upcoming. Essential in business for future plans, future-proof, and discussing prospects.',
  usage_notes = 'Very common in business. Can be noun (the future) or adjective (future plans).',
  examples = jsonb_build_array(
    'We''re planning for the future.',
    'Future growth depends on innovation.',
    'The solution needs to be future-proof.',
    'In the future, we''ll automate this process.'
  ),
  collocations = jsonb_build_array('in the future', 'future plans', 'future-proof', 'future growth'),
  patterns = jsonb_build_array('in the future', 'future + noun', 'future-proof + noun', 'for the future'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'future' AND cefr_receptive = 'A1';

-- game
UPDATE lexicon_entries SET
  ipa = '/ɡeɪm/',
  definition_simple = 'an activity with rules for entertainment or competition',
  definition_teacher = 'Noun meaning activity, strategy, or industry. In business, used for game plan, game changer, or gaming industry.',
  usage_notes = 'Multiple meanings: activity, strategy, or willingness (game for). Very common in business idioms.',
  examples = jsonb_build_array(
    'What''s our game plan for the quarter?',
    'This technology is a game changer.',
    'Are you game for trying a new approach?',
    'The gaming industry is growing rapidly.'
  ),
  collocations = jsonb_build_array('game plan', 'game changer', 'be game for', 'gaming industry'),
  patterns = jsonb_build_array('game + noun', 'a game changer', 'be game for + noun'),
  register = 'informal',
  variety = 'international'
WHERE headword = 'game' AND cefr_receptive = 'A1';

-- garden
UPDATE lexicon_entries SET
  ipa = '/ˈɡɑːrdən/',
  definition_simple = 'a piece of land for growing flowers or vegetables',
  definition_teacher = 'Noun meaning cultivated outdoor space. In business, occasionally used in phrases like "lead someone up the garden path".',
  usage_notes = 'Countable noun. Less common in business except in specific idioms or landscaping contexts.',
  examples = jsonb_build_array(
    'Don''t lead clients up the garden path with false promises.',
    'The office has a rooftop garden.',
    'Everything in the garden is rosy - all is well.',
    'The company maintains gardens at headquarters.'
  ),
  collocations = jsonb_build_array('lead up the garden path', 'rooftop garden', 'everything in the garden', 'garden variety'),
  patterns = jsonb_build_array('lead + person + up the garden path', 'noun + garden'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'garden' AND cefr_receptive = 'A1';

-- gate
UPDATE lexicon_entries SET
  ipa = '/ɡeɪt/',
  definition_simple = 'a movable barrier used to close an opening',
  definition_teacher = 'Noun meaning entrance barrier or airport departure point. In business, used for gatekeeper, gateway, or starting gate.',
  usage_notes = 'Can be literal (physical gate) or figurative (gateway to success, gatekeeper).',
  examples = jsonb_build_array(
    'She''s the gatekeeper for all vendor contracts.',
    'This market is a gateway to Asia.',
    'Everyone starts at the same gate.',
    'The project is at the gate for approval.'
  ),
  collocations = jsonb_build_array('gatekeeper', 'gateway to', 'starting gate', 'at the gate'),
  patterns = jsonb_build_array('gatekeeper + for/of + noun', 'gateway to + noun', 'at the gate'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'gate' AND cefr_receptive = 'A1';

-- gather
UPDATE lexicon_entries SET
  ipa = '/ˈɡæðər/',
  definition_simple = 'to come together or collect',
  definition_teacher = 'Verb meaning to collect, assemble, or understand. In business, used for gathering data, gathering information, or gathering momentum.',
  usage_notes = 'Can mean physically collect, assemble people, or understand (I gather that...). Very common in business.',
  examples = jsonb_build_array(
    'We need to gather more data before deciding.',
    'The team will gather for a meeting at 2 PM.',
    'I gather that the project is behind schedule.',
    'The initiative is gathering momentum.'
  ),
  collocations = jsonb_build_array('gather data', 'gather information', 'gather momentum', 'I gather that'),
  patterns = jsonb_build_array('gather + noun', 'gather for + noun', 'I gather that + clause', 'gather momentum'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'gather' AND cefr_receptive = 'A1';

-- general
UPDATE lexicon_entries SET
  ipa = '/ˈdʒenərəl/',
  definition_simple = 'affecting or concerning all or most people or things',
  definition_teacher = 'Adjective meaning widespread, overall, or not specific. Essential in business for general manager, in general, or general public.',
  usage_notes = 'Very common in business. Can mean "overall", "not specific", or used in titles (General Manager).',
  examples = jsonb_build_array(
    'The General Manager oversees all operations.',
    'In general, sales are improving.',
    'We need a general overview first.',
    'The general public responded positively.'
  ),
  collocations = jsonb_build_array('General Manager', 'in general', 'general public', 'general overview'),
  patterns = jsonb_build_array('General + title', 'in general', 'general + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'general' AND cefr_receptive = 'A1';

-- gentle
UPDATE lexicon_entries SET
  ipa = '/ˈdʒentəl/',
  definition_simple = 'mild, kind, or not harsh',
  definition_teacher = 'Adjective meaning mild, kind, or gradual. In business, used for gentle reminder, gentle approach, or gentle decline.',
  usage_notes = 'Can describe manner (gentle approach), slope (gentle incline), or reminder (gentle nudge).',
  examples = jsonb_build_array(
    'This is a gentle reminder about the deadline.',
    'We need a gentle approach with this client.',
    'The market shows a gentle upward trend.',
    'Give them a gentle nudge to respond.'
  ),
  collocations = jsonb_build_array('gentle reminder', 'gentle approach', 'gentle nudge', 'gentle decline'),
  patterns = jsonb_build_array('gentle + noun', 'a gentle + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'gentle' AND cefr_receptive = 'A1';

-- glad
UPDATE lexicon_entries SET
  ipa = '/ɡlæd/',
  definition_simple = 'pleased or happy',
  definition_teacher = 'Adjective meaning pleased or willing. In business, used for expressing satisfaction or willingness to help.',
  usage_notes = 'Usually used predicatively (I am glad) rather than attributively. Common in polite business communication.',
  examples = jsonb_build_array(
    'I''m glad to hear the project is progressing.',
    'We''d be glad to assist with your inquiry.',
    'I''m glad we could reach an agreement.',
    'The team is glad to have you on board.'
  ),
  collocations = jsonb_build_array('glad to', 'be glad', 'glad that', 'glad to hear'),
  patterns = jsonb_build_array('be glad to + infinitive', 'be glad that + clause', 'glad to hear + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'glad' AND cefr_receptive = 'A1';

-- glass
UPDATE lexicon_entries SET
  ipa = '/ɡlæs/',
  definition_simple = 'a hard transparent material, or a drinking container',
  definition_teacher = 'Noun meaning material or container. In business, used for glass ceiling, glass half full/empty, or transparency.',
  usage_notes = 'Can be uncountable (material) or countable (container). Common in business idioms.',
  examples = jsonb_build_array(
    'We need to break the glass ceiling for women.',
    'Is your glass half full or half empty?',
    'The office has glass walls for transparency.',
    'Raise a glass to the team''s success.'
  ),
  collocations = jsonb_build_array('glass ceiling', 'glass half full', 'glass walls', 'raise a glass'),
  patterns = jsonb_build_array('glass + noun', 'break the glass ceiling', 'glass half full/empty'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'glass' AND cefr_receptive = 'A1';

-- God
UPDATE lexicon_entries SET
  ipa = '/ɡɒd/',
  definition_simple = 'the creator and supreme being in monotheistic religions',
  definition_teacher = 'Noun referring to deity. In business, occasionally appears in expressions like "God willing" or "act of God".',
  usage_notes = 'Capitalized when referring to monotheistic deity. Use carefully in professional contexts due to religious sensitivity.',
  examples = jsonb_build_array(
    'The contract includes an "act of God" clause.',
    'God willing, we''ll complete the project on time.',
    'Thank God the crisis was averted.',
    'For God''s sake, please be careful with the data.'
  ),
  collocations = jsonb_build_array('act of God', 'God willing', 'thank God', 'for God''s sake'),
  patterns = jsonb_build_array('act of God', 'God willing', 'thank God + clause'),
  register = 'informal',
  variety = 'international'
WHERE headword = 'God' AND cefr_receptive = 'A1';

-- gold
UPDATE lexicon_entries SET
  ipa = '/ɡəʊld/',
  definition_simple = 'a valuable yellow metal',
  definition_teacher = 'Noun or adjective meaning precious metal or golden color. In business, used for gold standard, gold mine, or striking gold.',
  usage_notes = 'Can be noun (gold metal) or adjective (gold color). Common in business metaphors for value and success.',
  examples = jsonb_build_array(
    'This is the gold standard for customer service.',
    'The new market is a gold mine of opportunities.',
    'We struck gold with this product.',
    'Gold-level membership offers premium benefits.'
  ),
  collocations = jsonb_build_array('gold standard', 'gold mine', 'strike gold', 'gold-level'),
  patterns = jsonb_build_array('gold standard', 'a gold mine of + noun', 'strike gold', 'gold-level + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'gold' AND cefr_receptive = 'A1';

-- great
UPDATE lexicon_entries SET
  ipa = '/ɡreɪt/',
  definition_simple = 'very good, large, or important',
  definition_teacher = 'Adjective meaning excellent, large, or significant. Essential in business for great work, great opportunity, or great success.',
  usage_notes = 'Very common in business. Can mean "excellent", "large", or "important". Very versatile word.',
  examples = jsonb_build_array(
    'Great work on the presentation!',
    'This is a great opportunity for growth.',
    'The team achieved great success.',
    'We have great expectations for the quarter.'
  ),
  collocations = jsonb_build_array('great work', 'great opportunity', 'great success', 'great expectations'),
  patterns = jsonb_build_array('great + noun', 'great for + noun', 'great at + gerund'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'great' AND cefr_receptive = 'A1';

-- ground
UPDATE lexicon_entries SET
  ipa = '/ɡraʊnd/',
  definition_simple = 'the solid surface of the earth',
  definition_teacher = 'Noun or verb meaning earth surface, basis, or to base. Essential in business for common ground, ground rules, or breaking new ground.',
  usage_notes = 'Multiple meanings: surface, basis, or to prohibit (grounded). Very common in business idioms.',
  examples = jsonb_build_array(
    'We need to find common ground with the client.',
    'Let''s establish ground rules for the project.',
    'The company is breaking new ground in AI.',
    'Get in on the ground floor of this opportunity.'
  ),
  collocations = jsonb_build_array('common ground', 'ground rules', 'break new ground', 'ground floor'),
  patterns = jsonb_build_array('common ground', 'ground rules', 'break new ground', 'ground floor'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'ground' AND cefr_receptive = 'A1';

-- group
UPDATE lexicon_entries SET
  ipa = '/ɡruːp/',
  definition_simple = 'a number of people or things together',
  definition_teacher = 'Noun or verb meaning collection or to arrange together. Essential in business for group work, focus groups, or grouping data.',
  usage_notes = 'Very common in business. Can be noun (a group) or verb (to group). Used for teams, categories, and organizations.',
  examples = jsonb_build_array(
    'The project team is divided into three groups.',
    'We conducted focus groups with customers.',
    'Please group the data by category.',
    'The parent group owns several subsidiaries.'
  ),
  collocations = jsonb_build_array('focus group', 'working group', 'group work', 'parent group'),
  patterns = jsonb_build_array('noun + group', 'group + noun', 'group by + noun', 'in groups'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'group' AND cefr_receptive = 'A1';

-- guard
UPDATE lexicon_entries SET
  ipa = '/ɡɑːrd/',
  definition_simple = 'to protect or watch over something',
  definition_teacher = 'Noun or verb meaning protector or to protect. In business, used for security guards, guard against risks, or off guard.',
  usage_notes = 'Can be noun (a guard) or verb (guard against). Common in security and risk management contexts.',
  examples = jsonb_build_array(
    'We need to guard against cybersecurity threats.',
    'Security guards patrol the premises 24/7.',
    'The announcement caught us off guard.',
    'Guard your intellectual property carefully.'
  ),
  collocations = jsonb_build_array('guard against', 'security guard', 'off guard', 'on guard'),
  patterns = jsonb_build_array('guard against + noun', 'security guard', 'catch + person + off guard', 'guard + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'guard' AND cefr_receptive = 'A1';

-- habit
UPDATE lexicon_entries SET
  ipa = '/ˈhæbɪt/',
  definition_simple = 'something you do regularly, often without thinking',
  definition_teacher = 'Noun meaning regular behavior or custom. In business, used for good habits, bad habits, or breaking habits.',
  usage_notes = 'Countable noun. Important for discussing workplace behaviors and organizational culture.',
  examples = jsonb_build_array(
    'Successful people develop good work habits.',
    'We need to break the habit of last-minute planning.',
    'Make it a habit to review your goals weekly.',
    'Old habits die hard in corporate culture.'
  ),
  collocations = jsonb_build_array('good habit', 'bad habit', 'break a habit', 'make it a habit'),
  patterns = jsonb_build_array('good/bad habit', 'break/form a habit', 'make it a habit to + infinitive', 'habit of + gerund'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'habit' AND cefr_receptive = 'A1';

-- half
UPDATE lexicon_entries SET
  ipa = '/hæf/',
  definition_simple = 'one of two equal parts',
  definition_teacher = 'Noun, adjective, or adverb meaning 50% or partial. Essential in business for half-time, half the cost, or meeting halfway.',
  usage_notes = 'Very common in business. Can be noun (a half), adjective (half price), or adverb (half finished).',
  examples = jsonb_build_array(
    'The project is half finished.',
    'We offer products at half the cost of competitors.',
    'Let''s meet halfway on the price.',
    'Half the team works remotely.'
  ),
  collocations = jsonb_build_array('half the cost', 'meet halfway', 'half-time', 'half finished'),
  patterns = jsonb_build_array('half + noun', 'half + adjective', 'meet halfway', 'at half + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'half' AND cefr_receptive = 'A1';

-- hall
UPDATE lexicon_entries SET
  ipa = '/hɔːl/',
  definition_simple = 'a large room or building for meetings or events',
  definition_teacher = 'Noun meaning large room, corridor, or building. In business, used for conference halls, town halls, or hallway conversations.',
  usage_notes = 'Can mean large room, corridor, or building entrance. Context determines meaning.',
  examples = jsonb_build_array(
    'The conference hall seats 500 people.',
    'We''re holding a town hall meeting next week.',
    'The executive offices are down the hall.',
    'City Hall approved the business permit.'
  ),
  collocations = jsonb_build_array('conference hall', 'town hall', 'down the hall', 'City Hall'),
  patterns = jsonb_build_array('noun + hall', 'down/along the hall', 'in the hall'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'hall' AND cefr_receptive = 'A1';

-- hang
UPDATE lexicon_entries SET
  ipa = '/hæŋ/',
  definition_simple = 'to attach something at the top so the lower part is free',
  definition_teacher = 'Verb meaning to suspend or wait. In business, used for hang in there, hang up, or getting the hang of something.',
  usage_notes = 'Irregular verb: hang, hung, hung (or hanged for execution). Many business idioms.',
  examples = jsonb_build_array(
    'Hang in there - the project will improve.',
    'Please don''t hang up; I''ll transfer you.',
    'She''s getting the hang of the new system.',
    'Let''s hang tight until we hear back.'
  ),
  collocations = jsonb_build_array('hang in there', 'hang up', 'get the hang of', 'hang tight'),
  patterns = jsonb_build_array('hang in there', 'hang up', 'get the hang of + noun', 'hang tight'),
  register = 'informal',
  variety = 'international'
WHERE headword = 'hang' AND cefr_receptive = 'A1';

-- happen
UPDATE lexicon_entries SET
  ipa = '/ˈhæpən/',
  definition_simple = 'to take place or occur',
  definition_teacher = 'Verb meaning to occur or take place. Essential in business for discussing events, outcomes, and possibilities.',
  usage_notes = 'Very common in business. Often used with "to" (happen to someone) or in questions (what happened?).',
  examples = jsonb_build_array(
    'What happened at the client meeting?',
    'These things happen in business.',
    'If problems happen, contact support immediately.',
    'The merger happened faster than expected.'
  ),
  collocations = jsonb_build_array('what happened', 'happen to', 'things happen', 'happen quickly'),
  patterns = jsonb_build_array('what happened', 'happen to + person', 'if + noun + happens', 'happen + adverb'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'happen' AND cefr_receptive = 'A1';

-- hard
UPDATE lexicon_entries SET
  ipa = '/hɑːrd/',
  definition_simple = 'solid and firm, or difficult',
  definition_teacher = 'Adjective or adverb meaning difficult, solid, or with effort. Essential in business for hard work, hard facts, or working hard.',
  usage_notes = 'Very common in business. Can mean "difficult", "solid", or "with effort" (work hard).',
  examples = jsonb_build_array(
    'The team works hard to meet deadlines.',
    'These are hard facts we must accept.',
    'It''s hard to predict market changes.',
    'We learned a hard lesson from that mistake.'
  ),
  collocations = jsonb_build_array('work hard', 'hard work', 'hard facts', 'hard lesson'),
  patterns = jsonb_build_array('work hard', 'hard + noun', 'it''s hard to + infinitive', 'hard-working'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'hard' AND cefr_receptive = 'A1';

-- hardly
UPDATE lexicon_entries SET
  ipa = '/ˈhɑːrdli/',
  definition_simple = 'almost not, or only just',
  definition_teacher = 'Adverb meaning barely or scarcely. In business, used to express minimal degree or near impossibility.',
  usage_notes = 'Means "almost not" (not "in a hard way"). Often used with "any", "ever", or "anyone".',
  examples = jsonb_build_array(
    'We can hardly afford to lose this client.',
    'There''s hardly any time left to prepare.',
    'The results are hardly surprising.',
    'Hardly anyone attended the optional training.'
  ),
  collocations = jsonb_build_array('hardly any', 'hardly ever', 'hardly anyone', 'can hardly'),
  patterns = jsonb_build_array('hardly + any/ever/anyone', 'can hardly + infinitive', 'hardly + adjective'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'hardly' AND cefr_receptive = 'A1';

-- health
UPDATE lexicon_entries SET
  ipa = '/helθ/',
  definition_simple = 'the condition of your body and mind',
  definition_teacher = 'Noun meaning physical/mental condition or wellbeing. Essential in business for health insurance, health and safety, or company health.',
  usage_notes = 'Uncountable noun. Very important in workplace contexts for employee wellbeing and organizational health.',
  examples = jsonb_build_array(
    'The company provides comprehensive health insurance.',
    'Health and safety regulations must be followed.',
    'Employee health is a top priority.',
    'The financial health of the company is strong.'
  ),
  collocations = jsonb_build_array('health insurance', 'health and safety', 'employee health', 'financial health'),
  patterns = jsonb_build_array('health + noun', 'noun + health', 'health of + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'health' AND cefr_receptive = 'A1';

-- hear
UPDATE lexicon_entries SET
  ipa = '/hɪər/',
  definition_simple = 'to receive sound through your ears',
  definition_teacher = 'Verb meaning to perceive sound or receive information. Essential in business for hearing from someone, hearing about news.',
  usage_notes = 'Irregular verb: hear, heard, heard. Can mean perceive sound or receive information (I heard that...).',
  examples = jsonb_build_array(
    'I''d like to hear your thoughts on this.',
    'Have you heard from the client yet?',
    'We heard that the deal fell through.',
    'I hear what you''re saying, but I disagree.'
  ),
  collocations = jsonb_build_array('hear from', 'hear about', 'hear that', 'I hear'),
  patterns = jsonb_build_array('hear from + person', 'hear about + noun', 'hear that + clause', 'I hear + clause'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'hear' AND cefr_receptive = 'A1';

-- heat
UPDATE lexicon_entries SET
  ipa = '/hiːt/',
  definition_simple = 'the quality of being hot, or warmth',
  definition_teacher = 'Noun or verb meaning warmth, pressure, or to make hot. In business, used for heat of the moment, turn up the heat, or heated discussion.',
  usage_notes = 'Can be noun (heat) or verb (heat up). Common in business idioms about pressure and intensity.',
  examples = jsonb_build_array(
    'Don''t make decisions in the heat of the moment.',
    'We need to turn up the heat on this negotiation.',
    'The discussion became quite heated.',
    'Competition is heating up in the market.'
  ),
  collocations = jsonb_build_array('heat of the moment', 'turn up the heat', 'heated discussion', 'heat up'),
  patterns = jsonb_build_array('in the heat of + noun', 'turn up the heat on + noun', 'heated + noun', 'heat up'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'heat' AND cefr_receptive = 'A1';

-- heaven
UPDATE lexicon_entries SET
  ipa = '/ˈhevən/',
  definition_simple = 'the place where God is believed to live, or a wonderful place',
  definition_teacher = 'Noun meaning paradise or wonderful state. In business, used in expressions like "heaven forbid" or "heaven knows".',
  usage_notes = 'Can be religious concept or expression of excellence. Use carefully in professional contexts.',
  examples = jsonb_build_array(
    'Heaven forbid we lose this major client.',
    'Heaven knows we''ve tried everything.',
    'This new system is heaven compared to the old one.',
    'Thank heaven the crisis was averted.'
  ),
  collocations = jsonb_build_array('heaven forbid', 'heaven knows', 'thank heaven', 'heaven compared to'),
  patterns = jsonb_build_array('heaven forbid + clause', 'heaven knows + clause', 'thank heaven + clause'),
  register = 'informal',
  variety = 'international'
WHERE headword = 'heaven' AND cefr_receptive = 'A1';

-- heavy
UPDATE lexicon_entries SET
  ipa = '/ˈhevi/',
  definition_simple = 'weighing a lot, or great in amount',
  definition_teacher = 'Adjective meaning weighty, intense, or substantial. In business, used for heavy workload, heavy investment, or heavy-handed approach.',
  usage_notes = 'Can mean physical weight or figurative intensity/amount. Very common in business contexts.',
  examples = jsonb_build_array(
    'The team has a heavy workload this month.',
    'The project requires heavy investment.',
    'Don''t be too heavy-handed with the criticism.',
    'We''re experiencing heavy demand for the product.'
  ),
  collocations = jsonb_build_array('heavy workload', 'heavy investment', 'heavy-handed', 'heavy demand'),
  patterns = jsonb_build_array('heavy + noun', 'heavy-handed + noun', 'too heavy'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'heavy' AND cefr_receptive = 'A1';

-- hide
UPDATE lexicon_entries SET
  ipa = '/haɪd/',
  definition_simple = 'to put something where it cannot be seen or found',
  definition_teacher = 'Verb meaning to conceal or keep secret. In business, used for hiding information, hiding costs, or nothing to hide.',
  usage_notes = 'Irregular verb: hide, hid, hidden. Can be literal (conceal physically) or figurative (hide information).',
  examples = jsonb_build_array(
    'Don''t hide problems - address them openly.',
    'The company has nothing to hide from investors.',
    'Hidden costs can damage customer trust.',
    'We need to hide sensitive data from unauthorized users.'
  ),
  collocations = jsonb_build_array('hide information', 'nothing to hide', 'hidden costs', 'hide from'),
  patterns = jsonb_build_array('hide + noun', 'nothing to hide', 'hidden + noun', 'hide from + person'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'hide' AND cefr_receptive = 'A1';

-- high
UPDATE lexicon_entries SET
  ipa = '/haɪ/',
  definition_simple = 'measuring a long distance from bottom to top, or great in amount',
  definition_teacher = 'Adjective or noun meaning tall, elevated, or great in degree. Essential in business for high quality, high priority, or reaching new highs.',
  usage_notes = 'Very common in business. Can describe physical height, degree, or importance.',
  examples = jsonb_build_array(
    'Quality is our highest priority.',
    'The company sets high standards for performance.',
    'Sales reached an all-time high last quarter.',
    'We have high expectations for the new product.'
  ),
  collocations = jsonb_build_array('high priority', 'high quality', 'high standards', 'all-time high'),
  patterns = jsonb_build_array('high + noun', 'highest + noun', 'all-time high', 'high expectations'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'high' AND cefr_receptive = 'A1';
