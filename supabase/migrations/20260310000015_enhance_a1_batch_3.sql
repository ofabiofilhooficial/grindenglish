-- Enhancement of A1 Vocabulary - Batch 3 (100 words: hill → occasion)
-- Professional English context for Brazilian learners
-- Migration: 20260310000015

-- hill
UPDATE lexicon_entries SET
  ipa = '/hɪl/',
  definition_simple = 'an area of land that is higher than the land around it',
  definition_teacher = 'Noun meaning elevated land. In business, used in idioms like "over the hill" or "uphill battle".',
  usage_notes = 'Countable noun. Common in business idioms about challenges and age.',
  examples = jsonb_build_array(
    'We face an uphill battle to win this contract.',
    'The company is over the hill - past its prime.',
    'Don''t make a mountain out of a molehill.',
    'The office is located on a hill overlooking the city.'
  ),
  collocations = jsonb_build_array('uphill battle', 'over the hill', 'mountain out of molehill', 'on a hill'),
  patterns = jsonb_build_array('uphill battle', 'over the hill', 'on/up the hill'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'hill' AND cefr_receptive = 'A1';

-- history
UPDATE lexicon_entries SET
  ipa = '/ˈhɪstəri/',
  definition_simple = 'past events or the study of the past',
  definition_teacher = 'Noun meaning past events or record. In business, used for company history, track record, or making history.',
  usage_notes = 'Can be countable (a history) or uncountable (history in general). Important for discussing background and precedent.',
  examples = jsonb_build_array(
    'The company has a long history of innovation.',
    'Let''s review the history of this project.',
    'That''s history now - let''s move forward.',
    'We''re making history with this product launch.'
  ),
  collocations = jsonb_build_array('company history', 'track history', 'make history', 'that''s history'),
  patterns = jsonb_build_array('history of + noun', 'make history', 'that''s history'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'history' AND cefr_receptive = 'A1';

-- honour (honor)
UPDATE lexicon_entries SET
  ipa = '/ˈɒnər/',
  definition_simple = 'great respect or a privilege',
  definition_teacher = 'Noun or verb meaning respect, integrity, or to show respect. In business, used for honoring commitments or code of honor.',
  usage_notes = 'Spelled "honour" in UK, "honor" in US. Can be noun (an honor) or verb (honor commitments).',
  examples = jsonb_build_array(
    'We honor all commitments to our clients.',
    'It''s an honor to work with such a talented team.',
    'The company has a code of honor for business practices.',
    'Please honor the terms of the agreement.'
  ),
  collocations = jsonb_build_array('honor commitments', 'code of honor', 'an honor', 'honor agreement'),
  patterns = jsonb_build_array('honor + noun', 'an honor to + infinitive', 'code of honor'),
  register = 'formal',
  variety = 'international'
WHERE headword = 'honour' AND cefr_receptive = 'A1';

-- hope
UPDATE lexicon_entries SET
  ipa = '/həʊp/',
  definition_simple = 'a feeling of expectation and desire for something to happen',
  definition_teacher = 'Noun or verb meaning expectation or to wish. Essential in business for expressing optimism and expectations.',
  usage_notes = 'Very common in business. Can be noun (have hope) or verb (hope that). Used for expressing positive expectations.',
  examples = jsonb_build_array(
    'We hope to complete the project by June.',
    'There''s hope for improvement next quarter.',
    'I hope this email finds you well.',
    'The team has high hopes for the new product.'
  ),
  collocations = jsonb_build_array('hope to', 'have hope', 'high hopes', 'hope that'),
  patterns = jsonb_build_array('hope to + infinitive', 'hope that + clause', 'have hope for + noun', 'high hopes'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'hope' AND cefr_receptive = 'A1';

-- horse
UPDATE lexicon_entries SET
  ipa = '/hɔːrs/',
  definition_simple = 'a large animal with four legs that people ride',
  definition_teacher = 'Noun referring to equine animal. In business, used in idioms like "dark horse", "horse trading", or "straight from the horse''s mouth".',
  usage_notes = 'Countable noun. Common in business idioms about competition, negotiation, and information sources.',
  examples = jsonb_build_array(
    'She''s a dark horse candidate for the promotion.',
    'There was some horse trading in the negotiation.',
    'I heard it straight from the horse''s mouth.',
    'Don''t put the cart before the horse - plan first.'
  ),
  collocations = jsonb_build_array('dark horse', 'horse trading', 'straight from the horse''s mouth', 'cart before horse'),
  patterns = jsonb_build_array('dark horse', 'horse trading', 'straight from the horse''s mouth'),
  register = 'informal',
  variety = 'international'
WHERE headword = 'horse' AND cefr_receptive = 'A1';

-- husband
UPDATE lexicon_entries SET
  ipa = '/ˈhʌzbənd/',
  definition_simple = 'a married man in relation to his wife',
  definition_teacher = 'Noun referring to male spouse. In business contexts, may appear in discussions about work-life balance or family benefits.',
  usage_notes = 'Countable noun. Less common in business contexts unless discussing family-related policies.',
  examples = jsonb_build_array(
    'The company offers benefits for employees and their husbands or wives.',
    'Work-life balance allows time with husband and family.',
    'Parental leave is available for husbands and wives.',
    'The CEO''s husband also works in the industry.'
  ),
  collocations = jsonb_build_array('husband and wife', 'husband or wife', 'husband and family', 'employee''s husband'),
  patterns = jsonb_build_array('husband and wife', 'possessive + husband'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'husband' AND cefr_receptive = 'A1';

-- impossible
UPDATE lexicon_entries SET
  ipa = '/ɪmˈpɒsəbəl/',
  definition_simple = 'not able to happen or be done',
  definition_teacher = 'Adjective meaning not possible or very difficult. In business, used for impossible deadlines, impossible demands, or nothing is impossible.',
  usage_notes = 'Strong word indicating complete impossibility. Often used hyperbolically in business.',
  examples = jsonb_build_array(
    'The deadline is impossible to meet.',
    'Nothing is impossible with the right team.',
    'These demands are virtually impossible.',
    'It''s impossible to predict all market changes.'
  ),
  collocations = jsonb_build_array('impossible to', 'virtually impossible', 'nothing is impossible', 'impossible deadline'),
  patterns = jsonb_build_array('impossible to + infinitive', 'it''s impossible to + infinitive', 'impossible + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'impossible' AND cefr_receptive = 'A1';

-- inch
UPDATE lexicon_entries SET
  ipa = '/ɪntʃ/',
  definition_simple = 'a unit of length equal to 2.54 centimeters',
  definition_teacher = 'Noun meaning unit of measurement. In business, used in idioms like "inch by inch" or "give an inch".',
  usage_notes = 'Countable noun. Common in US measurements. Used in business idioms about gradual progress.',
  examples = jsonb_build_array(
    'We''re making progress inch by inch.',
    'Give them an inch and they''ll take a mile.',
    'The screen measures 15 inches diagonally.',
    'Every inch of space is utilized efficiently.'
  ),
  collocations = jsonb_build_array('inch by inch', 'give an inch', 'every inch', 'inches tall'),
  patterns = jsonb_build_array('inch by inch', 'give an inch', 'number + inches'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'inch' AND cefr_receptive = 'A1';

-- indeed
UPDATE lexicon_entries SET
  ipa = '/ɪnˈdiːd/',
  definition_simple = 'used to emphasize a statement or response',
  definition_teacher = 'Adverb meaning truly or in fact. In business, used for emphasis, confirmation, or introducing stronger statements.',
  usage_notes = 'Formal tone. Used to emphasize or confirm. Can stand alone as response or within sentence.',
  examples = jsonb_build_array(
    'The results are indeed impressive.',
    'Indeed, we need to reconsider our strategy.',
    'This is indeed a challenging situation.',
    'The project was successful. Indeed, it exceeded expectations.'
  ),
  collocations = jsonb_build_array('indeed impressive', 'indeed challenging', 'yes indeed', 'indeed it is'),
  patterns = jsonb_build_array('indeed + adjective', 'indeed, + clause', 'yes indeed'),
  register = 'formal',
  variety = 'international'
WHERE headword = 'indeed' AND cefr_receptive = 'A1';

-- independent
UPDATE lexicon_entries SET
  ipa = '/ˌɪndɪˈpendənt/',
  definition_simple = 'not controlled by others or not needing help',
  definition_teacher = 'Adjective meaning autonomous or self-sufficient. Essential in business for independent contractors, independent thinking, or independence.',
  usage_notes = 'Very common in business. Can describe people, organizations, or thinking. Important for discussing autonomy.',
  examples = jsonb_build_array(
    'We hire independent contractors for specific projects.',
    'Independent thinking is valued in our culture.',
    'The subsidiary operates as an independent entity.',
    'She works as an independent consultant.'
  ),
  collocations = jsonb_build_array('independent contractor', 'independent thinking', 'independent entity', 'independent consultant'),
  patterns = jsonb_build_array('independent + noun', 'independent of + noun', 'work independently'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'independent' AND cefr_receptive = 'A1';

-- influence
UPDATE lexicon_entries SET
  ipa = '/ˈɪnfluəns/',
  definition_simple = 'the power to affect someone or something',
  definition_teacher = 'Noun or verb meaning power to affect or to have an effect. Essential in business for discussing impact and persuasion.',
  usage_notes = 'Very common in business. Can be noun (have influence) or verb (influence decisions). Important for leadership discussions.',
  examples = jsonb_build_array(
    'She has significant influence in the industry.',
    'Market trends influence our strategy.',
    'The CEO''s influence extends beyond the company.',
    'We need to influence stakeholder opinions.'
  ),
  collocations = jsonb_build_array('have influence', 'influence decisions', 'under the influence', 'sphere of influence'),
  patterns = jsonb_build_array('have/exert influence', 'influence + noun', 'influence on + noun', 'under the influence of'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'influence' AND cefr_receptive = 'A1';

-- instead
UPDATE lexicon_entries SET
  ipa = '/ɪnˈsted/',
  definition_simple = 'as an alternative or substitute',
  definition_teacher = 'Adverb meaning as an alternative. Essential in business for suggesting alternatives or changes in approach.',
  usage_notes = 'Very common in business. Usually followed by "of". Used to present alternatives or corrections.',
  examples = jsonb_build_array(
    'Instead of cutting costs, let''s increase revenue.',
    'Use email instead of phone for this communication.',
    'Instead, we should focus on customer retention.',
    'The meeting was postponed; instead, we''ll meet next week.'
  ),
  collocations = jsonb_build_array('instead of', 'instead we', 'use instead', 'do instead'),
  patterns = jsonb_build_array('instead of + noun/gerund', 'instead, + clause', 'use + noun + instead'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'instead' AND cefr_receptive = 'A1';

-- intend
UPDATE lexicon_entries SET
  ipa = '/ɪnˈtend/',
  definition_simple = 'to have a plan or purpose to do something',
  definition_teacher = 'Verb meaning to plan or mean. In business, used for expressing intentions, plans, and purposes.',
  usage_notes = 'Formal verb. Usually followed by "to" + infinitive. Important for stating plans and intentions.',
  examples = jsonb_build_array(
    'We intend to launch the product in Q3.',
    'The policy is intended to improve efficiency.',
    'What do you intend to do about this issue?',
    'The message was not intended to offend.'
  ),
  collocations = jsonb_build_array('intend to', 'intended to', 'intend for', 'as intended'),
  patterns = jsonb_build_array('intend to + infinitive', 'be intended to + infinitive', 'intend for + noun'),
  register = 'formal',
  variety = 'international'
WHERE headword = 'intend' AND cefr_receptive = 'A1';

-- interest
UPDATE lexicon_entries SET
  ipa = '/ˈɪntrəst/',
  definition_simple = 'the feeling of wanting to know or learn about something',
  definition_teacher = 'Noun or verb meaning curiosity, benefit, or financial charge. Essential in business for multiple contexts: interest rates, vested interest, or showing interest.',
  usage_notes = 'Very versatile word. Can mean curiosity, benefit, or financial charge. Context determines meaning.',
  examples = jsonb_build_array(
    'There''s strong interest in the new product.',
    'The interest rate is 5% per annum.',
    'We have a vested interest in the project''s success.',
    'This may interest potential investors.'
  ),
  collocations = jsonb_build_array('interest rate', 'vested interest', 'show interest', 'of interest'),
  patterns = jsonb_build_array('interest in + noun', 'interest rate', 'vested interest in + noun', 'of interest to + person'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'interest' AND cefr_receptive = 'A1';

-- introduce
UPDATE lexicon_entries SET
  ipa = '/ˌɪntrəˈdjuːs/',
  definition_simple = 'to bring something into use or make people meet for the first time',
  definition_teacher = 'Verb meaning to present, implement, or make known. Essential in business for introducing products, people, or changes.',
  usage_notes = 'Very common in business. Can mean present people, implement changes, or bring in new things.',
  examples = jsonb_build_array(
    'Let me introduce you to our new team member.',
    'We''re introducing a new product line next month.',
    'The company introduced flexible working hours.',
    'Please introduce yourself to the group.'
  ),
  collocations = jsonb_build_array('introduce someone to', 'introduce changes', 'introduce product', 'introduce yourself'),
  patterns = jsonb_build_array('introduce + person + to + person', 'introduce + noun', 'introduce yourself'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'introduce' AND cefr_receptive = 'A1';

-- iron
UPDATE lexicon_entries SET
  ipa = '/ˈaɪərn/',
  definition_simple = 'a strong hard metal, or a device for making clothes smooth',
  definition_teacher = 'Noun or verb meaning metal, pressing device, or to smooth. In business, used for "iron out" problems or "iron will".',
  usage_notes = 'Multiple meanings: metal, pressing device, or verb (iron out issues). Common in business idioms.',
  examples = jsonb_build_array(
    'We need to iron out the details before signing.',
    'She has an iron will to succeed.',
    'The contract has iron-clad terms.',
    'Let''s iron out any remaining issues.'
  ),
  collocations = jsonb_build_array('iron out', 'iron will', 'iron-clad', 'strike while iron is hot'),
  patterns = jsonb_build_array('iron out + noun', 'iron will', 'iron-clad + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'iron' AND cefr_receptive = 'A1';

-- its
UPDATE lexicon_entries SET
  ipa = '/ɪts/',
  definition_simple = 'belonging to or associated with a thing',
  definition_teacher = 'Possessive determiner for things or animals. Essential in business for referring to company, product, or organization attributes.',
  usage_notes = 'No apostrophe (its = possessive; it''s = it is). Very common in business writing.',
  examples = jsonb_build_array(
    'The company announced its quarterly results.',
    'The product exceeded its sales targets.',
    'The organization is known for its innovation.',
    'Each department has its own budget.'
  ),
  collocations = jsonb_build_array('its own', 'its results', 'its success', 'on its own'),
  patterns = jsonb_build_array('its + noun', 'its own + noun', 'on its own'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'its' AND cefr_receptive = 'A1';

-- judge
UPDATE lexicon_entries SET
  ipa = '/dʒʌdʒ/',
  definition_simple = 'a person who decides cases in a law court, or to form an opinion',
  definition_teacher = 'Noun or verb meaning legal official or to evaluate. In business, used for judging performance, don''t judge a book by its cover.',
  usage_notes = 'Can be noun (a judge) or verb (judge performance). Important for evaluation and assessment contexts.',
  examples = jsonb_build_array(
    'Don''t judge a book by its cover.',
    'We judge performance based on results.',
    'It''s too early to judge the success.',
    'The judge ruled in favor of the company.'
  ),
  collocations = jsonb_build_array('judge performance', 'judge by', 'don''t judge', 'judge success'),
  patterns = jsonb_build_array('judge + noun', 'judge by + noun', 'judge + that clause', 'don''t judge a book by its cover'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'judge' AND cefr_receptive = 'A1';

-- just
UPDATE lexicon_entries SET
  ipa = '/dʒʌst/',
  definition_simple = 'exactly, only, or very recently',
  definition_teacher = 'Adverb or adjective meaning exactly, only, recently, or fair. Very common in business for emphasis and timing.',
  usage_notes = 'Extremely versatile word. Can mean "exactly", "only", "recently", or "fair". Very common in business.',
  examples = jsonb_build_array(
    'We just received the report.',
    'This is just what we needed.',
    'Just to clarify, the deadline is Friday.',
    'The decision was just and fair.'
  ),
  collocations = jsonb_build_array('just received', 'just in time', 'just to clarify', 'just and fair'),
  patterns = jsonb_build_array('just + past tense', 'just + noun', 'just to + infinitive', 'just and + adjective'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'just' AND cefr_receptive = 'A1';

-- keep
UPDATE lexicon_entries SET
  ipa = '/kiːp/',
  definition_simple = 'to continue to have or do something',
  definition_teacher = 'Verb meaning to retain, maintain, or continue. Essential in business for keeping records, keeping promises, or keeping up.',
  usage_notes = 'Irregular verb: keep, kept, kept. Very common in business. Multiple uses: retain, maintain, continue.',
  examples = jsonb_build_array(
    'Please keep all receipts for expenses.',
    'We need to keep our promises to clients.',
    'Keep up the good work!',
    'The company keeps detailed records.'
  ),
  collocations = jsonb_build_array('keep records', 'keep promises', 'keep up', 'keep in mind'),
  patterns = jsonb_build_array('keep + noun', 'keep + gerund', 'keep up with + noun', 'keep in mind'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'keep' AND cefr_receptive = 'A1';

-- kill
UPDATE lexicon_entries SET
  ipa = '/kɪl/',
  definition_simple = 'to cause death or to stop something',
  definition_teacher = 'Verb meaning to cause death or end. In business, used for killing projects, killing time, or killing two birds with one stone.',
  usage_notes = 'Can be literal (cause death) or figurative (kill a project, kill time). Common in business idioms.',
  examples = jsonb_build_array(
    'We had to kill the project due to budget cuts.',
    'This delay is killing our productivity.',
    'Let''s kill two birds with one stone.',
    'The competition is killing us in the market.'
  ),
  collocations = jsonb_build_array('kill project', 'kill time', 'kill two birds', 'killing productivity'),
  patterns = jsonb_build_array('kill + noun', 'kill two birds with one stone', 'be killing + noun'),
  register = 'informal',
  variety = 'international'
WHERE headword = 'kill' AND cefr_receptive = 'A1';

-- kind
UPDATE lexicon_entries SET
  ipa = '/kaɪnd/',
  definition_simple = 'a type or sort, or showing care and consideration',
  definition_teacher = 'Noun meaning type or adjective meaning considerate. In business, used for kind of (type), kind regards, or payment in kind.',
  usage_notes = 'Multiple uses: noun (a kind of), adjective (kind person), or informal filler (kind of = somewhat).',
  examples = jsonb_build_array(
    'What kind of solution are you looking for?',
    'Kind regards, [signature]',
    'The team is kind and supportive.',
    'Payment in kind is sometimes acceptable.'
  ),
  collocations = jsonb_build_array('kind of', 'kind regards', 'what kind', 'payment in kind'),
  patterns = jsonb_build_array('what kind of + noun', 'kind regards', 'kind + noun', 'payment in kind'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'kind' AND cefr_receptive = 'A1';

-- lack
UPDATE lexicon_entries SET
  ipa = '/læk/',
  definition_simple = 'the state of not having something',
  definition_teacher = 'Noun or verb meaning absence or to be without. Essential in business for discussing deficiencies and shortages.',
  usage_notes = 'Can be noun (a lack of) or verb (lack resources). Very common in business for identifying problems.',
  examples = jsonb_build_array(
    'The project failed due to lack of funding.',
    'We lack the resources to expand now.',
    'There''s no lack of opportunities in this market.',
    'The team lacks experience in this area.'
  ),
  collocations = jsonb_build_array('lack of', 'lack resources', 'no lack of', 'lack experience'),
  patterns = jsonb_build_array('lack of + noun', 'lack + noun', 'no lack of + noun', 'due to lack of'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'lack' AND cefr_receptive = 'A1';

-- lady
UPDATE lexicon_entries SET
  ipa = '/ˈleɪdi/',
  definition_simple = 'a polite word for a woman',
  definition_teacher = 'Noun meaning woman or female person. In business, used politely or in formal contexts (ladies and gentlemen).',
  usage_notes = 'Somewhat formal. Common in greetings (ladies and gentlemen) or polite references.',
  examples = jsonb_build_array(
    'Ladies and gentlemen, welcome to the conference.',
    'The lady at reception will assist you.',
    'First Lady of the company refers to the CEO''s wife.',
    'The cleaning lady comes on Tuesdays.'
  ),
  collocations = jsonb_build_array('ladies and gentlemen', 'young lady', 'first lady', 'lady at'),
  patterns = jsonb_build_array('ladies and gentlemen', 'the lady + prepositional phrase'),
  register = 'formal',
  variety = 'international'
WHERE headword = 'lady' AND cefr_receptive = 'A1';

-- land
UPDATE lexicon_entries SET
  ipa = '/lænd/',
  definition_simple = 'the solid part of the earth''s surface, or to arrive',
  definition_teacher = 'Noun or verb meaning ground, property, or to arrive/secure. Essential in business for landing deals, real estate, or landing a job.',
  usage_notes = 'Multiple meanings: ground/property (noun) or to arrive/secure (verb). Very common in business.',
  examples = jsonb_build_array(
    'We landed a major contract with the client.',
    'The company owns land in three countries.',
    'She landed her dream job.',
    'The project finally landed on my desk.'
  ),
  collocations = jsonb_build_array('land a deal', 'land a job', 'own land', 'land on'),
  patterns = jsonb_build_array('land + noun (deal/job)', 'own/buy land', 'land on + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'land' AND cefr_receptive = 'A1';

-- large
UPDATE lexicon_entries SET
  ipa = '/lɑːrdʒ/',
  definition_simple = 'big in size, amount, or extent',
  definition_teacher = 'Adjective meaning big or extensive. Essential in business for large companies, large scale, or by and large.',
  usage_notes = 'Very common in business. Can describe physical size, quantity, or scope.',
  examples = jsonb_build_array(
    'We''re a large multinational corporation.',
    'The project operates on a large scale.',
    'By and large, the results are positive.',
    'A large number of customers responded.'
  ),
  collocations = jsonb_build_array('large company', 'large scale', 'by and large', 'large number'),
  patterns = jsonb_build_array('large + noun', 'on a large scale', 'by and large', 'a large number of'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'large' AND cefr_receptive = 'A1';

-- last
UPDATE lexicon_entries SET
  ipa = '/læst/',
  definition_simple = 'coming after all others in time or order',
  definition_teacher = 'Adjective, adverb, or verb meaning final, most recent, or to continue. Essential in business for last quarter, last but not least, or making it last.',
  usage_notes = 'Very versatile. Can mean "final", "most recent", or "continue" (verb). Very common in business.',
  examples = jsonb_build_array(
    'Last quarter''s results exceeded expectations.',
    'Last but not least, I''d like to thank the team.',
    'When did you last review the policy?',
    'We need to make our resources last.'
  ),
  collocations = jsonb_build_array('last quarter', 'last but not least', 'last year', 'make it last'),
  patterns = jsonb_build_array('last + time period', 'last but not least', 'when + subject + last + verb', 'make + noun + last'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'last' AND cefr_receptive = 'A1';

-- late
UPDATE lexicon_entries SET
  ipa = '/leɪt/',
  definition_simple = 'after the expected or usual time',
  definition_teacher = 'Adjective or adverb meaning delayed or deceased. In business, used for late delivery, better late than never, or running late.',
  usage_notes = 'Can mean "delayed" or "deceased" (the late CEO). Very common in business for timing issues.',
  examples = jsonb_build_array(
    'The delivery is running late.',
    'Better late than never.',
    'We''re working late to meet the deadline.',
    'Late payments incur additional fees.'
  ),
  collocations = jsonb_build_array('running late', 'better late than never', 'work late', 'late payment'),
  patterns = jsonb_build_array('running late', 'work/arrive late', 'late + noun', 'better late than never'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'late' AND cefr_receptive = 'A1';

-- law
UPDATE lexicon_entries SET
  ipa = '/lɔː/',
  definition_simple = 'a rule made by government or authority',
  definition_teacher = 'Noun meaning legal rule or principle. Essential in business for law firm, break the law, or law and order.',
  usage_notes = 'Can be countable (laws) or uncountable (the law). Very important in business compliance contexts.',
  examples = jsonb_build_array(
    'The company complies with all applicable laws.',
    'Our law firm handles corporate matters.',
    'Breaking the law has serious consequences.',
    'Employment law protects workers'' rights.'
  ),
  collocations = jsonb_build_array('law firm', 'break the law', 'employment law', 'comply with law'),
  patterns = jsonb_build_array('law + noun', 'break/obey the law', 'comply with + law', 'noun + law'),
  register = 'formal',
  variety = 'international'
WHERE headword = 'law' AND cefr_receptive = 'A1';

-- lay
UPDATE lexicon_entries SET
  ipa = '/leɪ/',
  definition_simple = 'to put something down carefully or to produce eggs',
  definition_teacher = 'Verb meaning to place, establish, or dismiss. In business, used for laying groundwork, laying off employees, or laying down rules.',
  usage_notes = 'Irregular verb: lay, laid, laid. Multiple meanings: place, establish, or dismiss (lay off). Don''t confuse with "lie".',
  examples = jsonb_build_array(
    'We need to lay the groundwork for the project.',
    'The company had to lay off 50 employees.',
    'Let''s lay down some ground rules.',
    'The CEO laid out the vision for the future.'
  ),
  collocations = jsonb_build_array('lay groundwork', 'lay off', 'lay down rules', 'lay out'),
  patterns = jsonb_build_array('lay the groundwork for + noun', 'lay off + employees', 'lay down + rules', 'lay out + plan'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'lay' AND cefr_receptive = 'A1';

-- learn
UPDATE lexicon_entries SET
  ipa = '/lɜːrn/',
  definition_simple = 'to gain knowledge or skill',
  definition_teacher = 'Verb meaning to acquire knowledge or discover. Essential in business for learning from mistakes, learning curve, or continuous learning.',
  usage_notes = 'Very common in business. Can mean acquire knowledge or discover information (I learned that...).',
  examples = jsonb_build_array(
    'We learn from our mistakes.',
    'The team is on a steep learning curve.',
    'Employees learn new skills through training.',
    'I learned that the meeting was postponed.'
  ),
  collocations = jsonb_build_array('learn from', 'learning curve', 'learn skills', 'learn that'),
  patterns = jsonb_build_array('learn from + noun', 'learn + noun', 'learn to + infinitive', 'learn that + clause'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'learn' AND cefr_receptive = 'A1';

-- least
UPDATE lexicon_entries SET
  ipa = '/liːst/',
  definition_simple = 'smallest in amount or degree',
  definition_teacher = 'Determiner, pronoun, or adverb meaning smallest amount. Essential in business for at least, least expensive, or last but not least.',
  usage_notes = 'Superlative of "little". Very common in business phrases like "at least" or "least expensive".',
  examples = jsonb_build_array(
    'At least 50 people attended the meeting.',
    'This is the least expensive option.',
    'Last but not least, thank you all.',
    'We need at least three more days.'
  ),
  collocations = jsonb_build_array('at least', 'least expensive', 'last but not least', 'the least'),
  patterns = jsonb_build_array('at least + number/noun', 'the least + adjective', 'last but not least'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'least' AND cefr_receptive = 'A1';

-- leave
UPDATE lexicon_entries SET
  ipa = '/liːv/',
  definition_simple = 'to go away from or to allow to remain',
  definition_teacher = 'Verb or noun meaning to depart, allow to remain, or time off. Essential in business for leaving company, sick leave, or leaving message.',
  usage_notes = 'Irregular verb: leave, left, left. Multiple meanings: depart, allow to remain, or time off (noun).',
  examples = jsonb_build_array(
    'She''s leaving the company next month.',
    'Please leave a message after the tone.',
    'Employees are entitled to annual leave.',
    'Leave the details to me.'
  ),
  collocations = jsonb_build_array('leave company', 'leave message', 'annual leave', 'sick leave'),
  patterns = jsonb_build_array('leave + noun', 'leave + person + noun', 'on leave', 'leave to + person'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'leave' AND cefr_receptive = 'A1';

-- length
UPDATE lexicon_entries SET
  ipa = '/leŋθ/',
  definition_simple = 'the measurement of something from end to end',
  definition_teacher = 'Noun meaning distance, duration, or extent. In business, used for at length, go to great lengths, or length of time.',
  usage_notes = 'Can mean physical distance or duration. Common in business for discussing extent of effort or time.',
  examples = jsonb_build_array(
    'We discussed the issue at length.',
    'The company went to great lengths to satisfy customers.',
    'The length of the project is six months.',
    'At length, we reached an agreement.'
  ),
  collocations = jsonb_build_array('at length', 'go to great lengths', 'length of time', 'length of project'),
  patterns = jsonb_build_array('at length', 'go to great lengths to + infinitive', 'the length of + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'length' AND cefr_receptive = 'A1';

-- less
UPDATE lexicon_entries SET
  ipa = '/les/',
  definition_simple = 'a smaller amount or not as much',
  definition_teacher = 'Determiner, pronoun, or adverb meaning smaller amount. Essential in business for less expensive, less than, or more or less.',
  usage_notes = 'Comparative of "little". Used with uncountable nouns (less time, not less people). Very common in business.',
  examples = jsonb_build_array(
    'We need to spend less money on overhead.',
    'The solution is less complicated than expected.',
    'More or less, the project is complete.',
    'Nothing less than excellence is acceptable.'
  ),
  collocations = jsonb_build_array('less expensive', 'less than', 'more or less', 'nothing less than'),
  patterns = jsonb_build_array('less + uncountable noun', 'less than + number', 'more or less', 'less + adjective'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'less' AND cefr_receptive = 'A1';

-- let
UPDATE lexicon_entries SET
  ipa = '/let/',
  definition_simple = 'to allow or give permission',
  definition_teacher = 'Verb meaning to allow or permit. Essential in business for let me know, let''s (let us), or letting someone down.',
  usage_notes = 'Irregular verb: let, let, let. Very common in business. Used for permission, suggestions (let''s), or disappointment (let down).',
  examples = jsonb_build_array(
    'Please let me know if you have questions.',
    'Let''s schedule a meeting for next week.',
    'Don''t let the team down.',
    'We let the opportunity slip away.'
  ),
  collocations = jsonb_build_array('let me know', 'let''s do', 'let down', 'let go'),
  patterns = jsonb_build_array('let + person + know', 'let''s + infinitive', 'let + person + down', 'let + noun + go'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'let' AND cefr_receptive = 'A1';

-- letter
UPDATE lexicon_entries SET
  ipa = '/ˈletər/',
  definition_simple = 'a written message or a character of the alphabet',
  definition_teacher = 'Noun meaning written correspondence or alphabet character. In business, used for cover letter, letter of intent, or to the letter.',
  usage_notes = 'Can mean written message or alphabet character. Very common in business correspondence.',
  examples = jsonb_build_array(
    'Please send a cover letter with your application.',
    'We received a letter of intent from the buyer.',
    'Follow the instructions to the letter.',
    'The contract is written in small letters.'
  ),
  collocations = jsonb_build_array('cover letter', 'letter of intent', 'to the letter', 'send a letter'),
  patterns = jsonb_build_array('noun + letter', 'to the letter', 'send/receive a letter'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'letter' AND cefr_receptive = 'A1';

-- level
UPDATE lexicon_entries SET
  ipa = '/ˈlevəl/',
  definition_simple = 'a position on a scale or a flat surface',
  definition_teacher = 'Noun or adjective meaning position, degree, or flat. Essential in business for level of experience, entry level, or level playing field.',
  usage_notes = 'Very common in business. Can be noun (level of), adjective (level surface), or verb (level with someone).',
  examples = jsonb_build_array(
    'What level of experience do you have?',
    'This is an entry-level position.',
    'We need a level playing field for competition.',
    'Sales reached record levels last quarter.'
  ),
  collocations = jsonb_build_array('level of', 'entry level', 'level playing field', 'high level'),
  patterns = jsonb_build_array('level of + noun', 'entry-level + noun', 'level playing field', 'at + adjective + level'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'level' AND cefr_receptive = 'A1';

-- library
UPDATE lexicon_entries SET
  ipa = '/ˈlaɪbrəri/',
  definition_simple = 'a place where books are kept for reading or borrowing',
  definition_teacher = 'Noun meaning book collection or building. In business, may refer to resource libraries, code libraries, or corporate libraries.',
  usage_notes = 'Countable noun. In tech contexts, can mean code library. Less common in general business.',
  examples = jsonb_build_array(
    'The company has an extensive resource library.',
    'Developers use code libraries to speed up work.',
    'The corporate library offers business publications.',
    'We maintain a library of templates.'
  ),
  collocations = jsonb_build_array('resource library', 'code library', 'corporate library', 'library of'),
  patterns = jsonb_build_array('noun + library', 'library of + noun', 'in/at the library'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'library' AND cefr_receptive = 'A1';

-- lie
UPDATE lexicon_entries SET
  ipa = '/laɪ/',
  definition_simple = 'to be in a flat position, or to say something untrue',
  definition_teacher = 'Verb meaning to recline, be located, or deceive. In business, used for where responsibility lies, lie low, or telling lies.',
  usage_notes = 'Two different verbs: lie (recline: lie, lay, lain) and lie (deceive: lie, lied, lied). Context determines meaning.',
  examples = jsonb_build_array(
    'The solution lies in better communication.',
    'Responsibility lies with the manager.',
    'Don''t lie to clients about capabilities.',
    'The company decided to lie low during the controversy.'
  ),
  collocations = jsonb_build_array('lie in', 'lie with', 'tell lies', 'lie low'),
  patterns = jsonb_build_array('lie in + noun', 'lie with + person', 'tell lies', 'lie low'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'lie' AND cefr_receptive = 'A1';

-- life
UPDATE lexicon_entries SET
  ipa = '/laɪf/',
  definition_simple = 'the existence of a person, animal, or plant',
  definition_teacher = 'Noun meaning existence, vitality, or lifespan. Essential in business for work-life balance, product life cycle, or bringing to life.',
  usage_notes = 'Uncountable (life in general) or countable (lives). Very common in business for various contexts.',
  examples = jsonb_build_array(
    'Work-life balance is important for employees.',
    'The product life cycle is approximately five years.',
    'Let''s bring this idea to life.',
    'Real-life examples help illustrate the concept.'
  ),
  collocations = jsonb_build_array('work-life balance', 'product life cycle', 'bring to life', 'real-life'),
  patterns = jsonb_build_array('work-life balance', 'life cycle', 'bring + noun + to life', 'real-life + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'life' AND cefr_receptive = 'A1';

-- lift
UPDATE lexicon_entries SET
  ipa = '/lɪft/',
  definition_simple = 'to raise something to a higher position',
  definition_teacher = 'Verb or noun meaning to raise, elevate, or elevator (UK). In business, used for lifting spirits, lifting restrictions, or giving a lift.',
  usage_notes = 'Can be verb (lift up) or noun (give a lift, or elevator in UK). Common in business for improvement.',
  examples = jsonb_build_array(
    'The good news lifted team morale.',
    'We''re lifting restrictions on remote work.',
    'The new strategy gave sales a lift.',
    'Can you give me a lift to the meeting?'
  ),
  collocations = jsonb_build_array('lift spirits', 'lift restrictions', 'give a lift', 'lift morale'),
  patterns = jsonb_build_array('lift + noun', 'lift restrictions on + noun', 'give + person + a lift'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'lift' AND cefr_receptive = 'A1';

-- light
UPDATE lexicon_entries SET
  ipa = '/laɪt/',
  definition_simple = 'brightness that allows you to see, or not heavy',
  definition_teacher = 'Noun or adjective meaning illumination, not heavy, or pale. In business, used for green light, light workload, or shed light on.',
  usage_notes = 'Multiple meanings: illumination, not heavy, or pale color. Very versatile in business contexts.',
  examples = jsonb_build_array(
    'The project got the green light from management.',
    'Please shed some light on this issue.',
    'The workload is light this week.',
    'We need to bring this problem to light.'
  ),
  collocations = jsonb_build_array('green light', 'shed light on', 'light workload', 'bring to light'),
  patterns = jsonb_build_array('green light', 'shed light on + noun', 'light + noun', 'bring to light'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'light' AND cefr_receptive = 'A1';

-- likely
UPDATE lexicon_entries SET
  ipa = '/ˈlaɪkli/',
  definition_simple = 'probable or expected to happen',
  definition_teacher = 'Adjective or adverb meaning probable. Essential in business for discussing probabilities and expectations.',
  usage_notes = 'Very common in business. Can be adjective (likely outcome) or adverb (most likely). Used for predictions.',
  examples = jsonb_build_array(
    'Sales are likely to increase next quarter.',
    'The most likely scenario is a merger.',
    'It''s likely that costs will rise.',
    'Likely candidates for promotion include three managers.'
  ),
  collocations = jsonb_build_array('likely to', 'most likely', 'likely outcome', 'likely that'),
  patterns = jsonb_build_array('likely to + infinitive', 'most likely', 'it''s likely that + clause', 'likely + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'likely' AND cefr_receptive = 'A1';

-- limit
UPDATE lexicon_entries SET
  ipa = '/ˈlɪmɪt/',
  definition_simple = 'the greatest or smallest amount allowed',
  definition_teacher = 'Noun or verb meaning boundary or to restrict. Essential in business for time limits, budget limits, or limiting factors.',
  usage_notes = 'Very common in business. Can be noun (a limit) or verb (to limit). Important for discussing constraints.',
  examples = jsonb_build_array(
    'There''s a limit to what we can achieve.',
    'We need to limit expenses this quarter.',
    'The time limit for responses is 48 hours.',
    'Budget limitations affect our options.'
  ),
  collocations = jsonb_build_array('time limit', 'limit to', 'budget limit', 'limit expenses'),
  patterns = jsonb_build_array('a limit to + noun', 'limit + noun', 'time/budget limit', 'within limits'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'limit' AND cefr_receptive = 'A1';

-- line
UPDATE lexicon_entries SET
  ipa = '/laɪn/',
  definition_simple = 'a long thin mark or a row of people or things',
  definition_teacher = 'Noun or verb meaning mark, row, product range, or to align. Essential in business for bottom line, product line, or in line with.',
  usage_notes = 'Very versatile word. Multiple meanings: mark, row, product range, or boundary. Very common in business.',
  examples = jsonb_build_array(
    'The bottom line is profitability.',
    'We''re launching a new product line.',
    'This decision is in line with our strategy.',
    'Draw a line under the past and move forward.'
  ),
  collocations = jsonb_build_array('bottom line', 'product line', 'in line with', 'draw a line'),
  patterns = jsonb_build_array('the bottom line', 'product line', 'in line with + noun', 'draw a line under + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'line' AND cefr_receptive = 'A1';

-- local
UPDATE lexicon_entries SET
  ipa = '/ˈləʊkəl/',
  definition_simple = 'belonging to or connected with a particular area',
  definition_teacher = 'Adjective meaning nearby or regional. In business, used for local market, local office, or think global act local.',
  usage_notes = 'Very common in business. Can describe markets, offices, or customs. Important for regional operations.',
  examples = jsonb_build_array(
    'We need to understand local market conditions.',
    'The local office handles regional sales.',
    'Think global, act local.',
    'Local regulations vary by region.'
  ),
  collocations = jsonb_build_array('local market', 'local office', 'local regulations', 'local customs'),
  patterns = jsonb_build_array('local + noun', 'think global act local'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'local' AND cefr_receptive = 'A1';

-- lose
UPDATE lexicon_entries SET
  ipa = '/luːz/',
  definition_simple = 'to no longer have something or to be defeated',
  definition_teacher = 'Verb meaning to misplace, be defeated, or waste. Essential in business for losing clients, losing money, or win-lose situations.',
  usage_notes = 'Irregular verb: lose, lost, lost. Very common in business. Can mean misplace, be defeated, or waste.',
  examples = jsonb_build_array(
    'We cannot afford to lose this client.',
    'The company lost money last quarter.',
    'Don''t lose sight of our main objectives.',
    'We''re losing market share to competitors.'
  ),
  collocations = jsonb_build_array('lose client', 'lose money', 'lose sight of', 'lose market share'),
  patterns = jsonb_build_array('lose + noun', 'lose sight of + noun', 'lose to + competitor'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'lose' AND cefr_receptive = 'A1';

-- lost
UPDATE lexicon_entries SET
  ipa = '/lɒst/',
  definition_simple = 'unable to find your way or no longer possessed',
  definition_teacher = 'Adjective or past tense of lose. In business, used for lost opportunity, lost time, or lost cause.',
  usage_notes = 'Can be past tense of "lose" or adjective. Common in business for missed opportunities or wasted resources.',
  examples = jsonb_build_array(
    'This is a lost opportunity we can''t recover.',
    'Lost time cannot be regained.',
    'The project is a lost cause.',
    'We need to make up for lost ground.'
  ),
  collocations = jsonb_build_array('lost opportunity', 'lost time', 'lost cause', 'lost ground'),
  patterns = jsonb_build_array('lost + noun', 'a lost cause', 'make up for lost + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'lost' AND cefr_receptive = 'A1';

-- lot
UPDATE lexicon_entries SET
  ipa = '/lɒt/',
  definition_simple = 'a large number or amount',
  definition_teacher = 'Noun meaning large quantity or group. Essential in business for a lot of, parking lot, or drawing lots.',
  usage_notes = 'Very common in business. Usually used with "a" (a lot of). Can also mean plot of land or fate.',
  examples = jsonb_build_array(
    'We have a lot of work to complete.',
    'A lot of customers prefer online shopping.',
    'The parking lot is behind the building.',
    'Thanks a lot for your help.'
  ),
  collocations = jsonb_build_array('a lot of', 'parking lot', 'thanks a lot', 'quite a lot'),
  patterns = jsonb_build_array('a lot of + noun', 'thanks a lot', 'quite a lot'),
  register = 'informal',
  variety = 'international'
WHERE headword = 'lot' AND cefr_receptive = 'A1';

-- low
UPDATE lexicon_entries SET
  ipa = '/ləʊ/',
  definition_simple = 'not high or not much',
  definition_teacher = 'Adjective or adverb meaning not high, small amount, or depressed. Essential in business for low cost, low profile, or all-time low.',
  usage_notes = 'Very common in business. Can describe height, amount, quality, or mood.',
  examples = jsonb_build_array(
    'We offer high quality at low cost.',
    'Keep a low profile during the investigation.',
    'Morale is low after the layoffs.',
    'Sales hit an all-time low last month.'
  ),
  collocations = jsonb_build_array('low cost', 'low profile', 'all-time low', 'low morale'),
  patterns = jsonb_build_array('low + noun', 'keep a low profile', 'all-time low', 'low on + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'low' AND cefr_receptive = 'A1';

-- machine
UPDATE lexicon_entries SET
  ipa = '/məˈʃiːn/',
  definition_simple = 'a piece of equipment with moving parts that does work',
  definition_teacher = 'Noun meaning mechanical device or system. In business, used for well-oiled machine, machine learning, or vending machine.',
  usage_notes = 'Countable noun. Can be literal (physical machine) or figurative (the company is a machine).',
  examples = jsonb_build_array(
    'The team operates like a well-oiled machine.',
    'Machine learning is transforming our industry.',
    'The manufacturing machines run 24/7.',
    'We need to replace the old copy machine.'
  ),
  collocations = jsonb_build_array('well-oiled machine', 'machine learning', 'vending machine', 'copy machine'),
  patterns = jsonb_build_array('like a well-oiled machine', 'machine learning', 'noun + machine'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'machine' AND cefr_receptive = 'A1';

-- main
UPDATE lexicon_entries SET
  ipa = '/meɪn/',
  definition_simple = 'most important or largest',
  definition_teacher = 'Adjective meaning primary or principal. Essential in business for main office, main goal, or in the main.',
  usage_notes = 'Always used before noun. Very common in business for identifying primary elements.',
  examples = jsonb_build_array(
    'Our main office is in New York.',
    'The main goal is customer satisfaction.',
    'In the main, the results are positive.',
    'What''s the main reason for the delay?'
  ),
  collocations = jsonb_build_array('main office', 'main goal', 'in the main', 'main reason'),
  patterns = jsonb_build_array('main + noun', 'in the main', 'the main + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'main' AND cefr_receptive = 'A1';

-- manner
UPDATE lexicon_entries SET
  ipa = '/ˈmænər/',
  definition_simple = 'the way something is done or happens',
  definition_teacher = 'Noun meaning method, style, or behavior. In business, used for in a timely manner, professional manner, or manner of speaking.',
  usage_notes = 'Formal word. Often used in phrase "in a [adjective] manner". Important for describing approach or style.',
  examples = jsonb_build_array(
    'Please respond in a timely manner.',
    'Handle complaints in a professional manner.',
    'The manner in which we communicate matters.',
    'She conducted herself in an appropriate manner.'
  ),
  collocations = jsonb_build_array('in a timely manner', 'professional manner', 'manner of speaking', 'in this manner'),
  patterns = jsonb_build_array('in a + adjective + manner', 'the manner in which + clause', 'manner of + noun'),
  register = 'formal',
  variety = 'international'
WHERE headword = 'manner' AND cefr_receptive = 'A1';

-- manners
UPDATE lexicon_entries SET
  ipa = '/ˈmænərz/',
  definition_simple = 'polite ways of behaving in social situations',
  definition_teacher = 'Noun (plural) meaning etiquette or polite behavior. In business, used for business manners, good manners, or table manners.',
  usage_notes = 'Usually plural. Important for discussing professional etiquette and cultural norms.',
  examples = jsonb_build_array(
    'Good business manners are essential for success.',
    'Understanding local manners helps in negotiations.',
    'It''s bad manners to interrupt during presentations.',
    'Professional manners include punctuality and respect.'
  ),
  collocations = jsonb_build_array('good manners', 'bad manners', 'business manners', 'table manners'),
  patterns = jsonb_build_array('good/bad manners', 'business manners', 'it''s + adjective + manners to + infinitive'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'manners' AND cefr_receptive = 'A1';

-- march
UPDATE lexicon_entries SET
  ipa = '/mɑːrtʃ/',
  definition_simple = 'to walk with regular steps like soldiers, or the third month',
  definition_teacher = 'Verb or noun meaning military walk, protest walk, or month. In business, used for marching orders or time marches on.',
  usage_notes = 'Can be verb (march forward), noun (a march), or month name (March). Context determines meaning.',
  examples = jsonb_build_array(
    'The project is marching forward on schedule.',
    'Time marches on - we need to act now.',
    'The CEO gave marching orders to the team.',
    'The fiscal year ends in March.'
  ),
  collocations = jsonb_build_array('march forward', 'marching orders', 'time marches on', 'in March'),
  patterns = jsonb_build_array('march forward/on', 'marching orders', 'time marches on', 'in March'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'march' AND cefr_receptive = 'A1';

-- mark
UPDATE lexicon_entries SET
  ipa = '/mɑːrk/',
  definition_simple = 'a visible sign or to make a sign on something',
  definition_teacher = 'Noun or verb meaning sign, target, or to indicate. Essential in business for benchmark, mark down, or hit the mark.',
  usage_notes = 'Very versatile. Can be noun (a mark) or verb (mark progress). Common in business for targets and indicators.',
  examples = jsonb_build_array(
    'This milestone marks significant progress.',
    'We need to hit the mark with this campaign.',
    'The company is a benchmark in the industry.',
    'Mark my words - this will succeed.'
  ),
  collocations = jsonb_build_array('hit the mark', 'mark progress', 'benchmark', 'mark my words'),
  patterns = jsonb_build_array('mark + noun', 'hit/miss the mark', 'mark my words', 'benchmark'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'mark' AND cefr_receptive = 'A1';

-- market
UPDATE lexicon_entries SET
  ipa = '/ˈmɑːrkɪt/',
  definition_simple = 'a place where goods are bought and sold',
  definition_teacher = 'Noun or verb meaning marketplace, demand, or to promote. Essential in business for market share, target market, or marketing.',
  usage_notes = 'Very common in business. Can be noun (the market) or verb (to market products). Central business concept.',
  examples = jsonb_build_array(
    'We''re expanding into new markets.',
    'Our market share increased by 5%.',
    'The target market is young professionals.',
    'How will we market this product?'
  ),
  collocations = jsonb_build_array('market share', 'target market', 'market research', 'market to'),
  patterns = jsonb_build_array('market + noun', 'in the market', 'market to + audience', 'market share'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'market' AND cefr_receptive = 'A1';

-- marry
UPDATE lexicon_entries SET
  ipa = '/ˈmæri/',
  definition_simple = 'to become someone''s husband or wife',
  definition_teacher = 'Verb meaning to wed or combine. In business, occasionally used metaphorically for marrying ideas or concepts.',
  usage_notes = 'Can be literal (marry a person) or figurative (marry two concepts). Less common in business contexts.',
  examples = jsonb_build_array(
    'We need to marry innovation with practicality.',
    'The solution marries technology and tradition.',
    'Married employees receive additional benefits.',
    'Let''s marry these two approaches.'
  ),
  collocations = jsonb_build_array('marry with', 'marry concepts', 'married to', 'get married'),
  patterns = jsonb_build_array('marry + noun + with + noun', 'marry + person', 'be married to'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'marry' AND cefr_receptive = 'A1';

-- mass
UPDATE lexicon_entries SET
  ipa = '/mæs/',
  definition_simple = 'a large amount or number',
  definition_teacher = 'Noun or adjective meaning large quantity or affecting many. In business, used for mass production, mass market, or critical mass.',
  usage_notes = 'Can be noun (a mass of) or adjective (mass production). Important for discussing scale.',
  examples = jsonb_build_array(
    'Mass production reduces unit costs.',
    'We target the mass market, not niche segments.',
    'The project reached critical mass.',
    'A mass of data needs analysis.'
  ),
  collocations = jsonb_build_array('mass production', 'mass market', 'critical mass', 'mass of'),
  patterns = jsonb_build_array('mass + noun', 'mass market', 'critical mass', 'a mass of + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'mass' AND cefr_receptive = 'A1';

-- material
UPDATE lexicon_entries SET
  ipa = '/məˈtɪəriəl/',
  definition_simple = 'substance from which things are made, or information',
  definition_teacher = 'Noun or adjective meaning substance, information, or significant. Essential in business for raw materials, marketing materials, or material impact.',
  usage_notes = 'Very common in business. Can be noun (materials) or adjective (material difference). Multiple contexts.',
  examples = jsonb_build_array(
    'Raw materials costs are increasing.',
    'Please review the training materials.',
    'This has a material impact on profits.',
    'Marketing materials need updating.'
  ),
  collocations = jsonb_build_array('raw materials', 'training materials', 'material impact', 'marketing materials'),
  patterns = jsonb_build_array('raw materials', 'noun + materials', 'material + noun', 'material impact on'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'material' AND cefr_receptive = 'A1';

-- matter
UPDATE lexicon_entries SET
  ipa = '/ˈmætər/',
  definition_simple = 'a subject or situation, or to be important',
  definition_teacher = 'Noun or verb meaning subject, issue, or to be important. Essential in business for discussing issues and importance.',
  usage_notes = 'Very common in business. Can be noun (a matter) or verb (it matters). Used for issues and importance.',
  examples = jsonb_build_array(
    'This is an urgent matter requiring attention.',
    'Quality matters more than speed.',
    'As a matter of fact, sales are up.',
    'No matter what happens, we''ll adapt.'
  ),
  collocations = jsonb_build_array('urgent matter', 'it matters', 'as a matter of fact', 'no matter what'),
  patterns = jsonb_build_array('a matter of + noun', 'it matters', 'as a matter of fact', 'no matter + question word'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'matter' AND cefr_receptive = 'A1';

-- measure
UPDATE lexicon_entries SET
  ipa = '/ˈmeʒər/',
  definition_simple = 'to find the size or amount of something',
  definition_teacher = 'Verb or noun meaning to quantify, action, or standard. Essential in business for measuring performance, taking measures, or beyond measure.',
  usage_notes = 'Very common in business. Can be verb (measure results) or noun (take measures). Important for metrics.',
  examples = jsonb_build_array(
    'We measure success by customer satisfaction.',
    'Take measures to prevent data breaches.',
    'Key performance measures include revenue and retention.',
    'The impact is beyond measure.'
  ),
  collocations = jsonb_build_array('measure success', 'take measures', 'performance measures', 'beyond measure'),
  patterns = jsonb_build_array('measure + noun', 'take measures to + infinitive', 'performance measures', 'beyond measure'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'measure' AND cefr_receptive = 'A1';

-- meet
UPDATE lexicon_entries SET
  ipa = '/miːt/',
  definition_simple = 'to come together with someone',
  definition_teacher = 'Verb meaning to encounter, satisfy, or assemble. Essential in business for meeting deadlines, meeting expectations, or meetings.',
  usage_notes = 'Irregular verb: meet, met, met. Very common in business. Multiple meanings: encounter, satisfy requirements, or gather.',
  examples = jsonb_build_array(
    'Let''s meet to discuss the proposal.',
    'We need to meet the deadline.',
    'The product meets customer expectations.',
    'Nice to meet you.'
  ),
  collocations = jsonb_build_array('meet deadline', 'meet expectations', 'meet with', 'nice to meet'),
  patterns = jsonb_build_array('meet + person', 'meet + deadline/expectations', 'meet with + person', 'nice to meet you'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'meet' AND cefr_receptive = 'A1';

-- member
UPDATE lexicon_entries SET
  ipa = '/ˈmembər/',
  definition_simple = 'a person belonging to a group or organization',
  definition_teacher = 'Noun meaning participant or part of group. Essential in business for team members, board members, or membership.',
  usage_notes = 'Countable noun. Very common in business for discussing teams, boards, and organizations.',
  examples = jsonb_build_array(
    'All team members attended the training.',
    'She''s a board member of three companies.',
    'Membership benefits include discounts.',
    'Staff members receive annual bonuses.'
  ),
  collocations = jsonb_build_array('team member', 'board member', 'staff member', 'membership benefits'),
  patterns = jsonb_build_array('noun + member', 'member of + organization', 'membership + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'member' AND cefr_receptive = 'A1';

-- memory
UPDATE lexicon_entries SET
  ipa = '/ˈmeməri/',
  definition_simple = 'the ability to remember things or something remembered',
  definition_teacher = 'Noun meaning recall ability, remembrance, or computer storage. In business, used for in memory of, memory lane, or computer memory.',
  usage_notes = 'Can be countable (memories) or uncountable (memory). Multiple contexts: human memory or computer memory.',
  examples = jsonb_build_array(
    'The system has 16GB of memory.',
    'From memory, the meeting is at 2 PM.',
    'We honor the memory of our founder.',
    'Refresh my memory about the details.'
  ),
  collocations = jsonb_build_array('from memory', 'in memory of', 'refresh memory', 'computer memory'),
  patterns = jsonb_build_array('from memory', 'in memory of + person', 'refresh + possessive + memory', 'memory of + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'memory' AND cefr_receptive = 'A1';

-- mention
UPDATE lexicon_entries SET
  ipa = '/ˈmenʃən/',
  definition_simple = 'to refer to something briefly',
  definition_teacher = 'Verb or noun meaning to refer to or reference. Essential in business for mentioning points, not to mention, or honorable mention.',
  usage_notes = 'Very common in business. Can be verb (mention that) or noun (make mention of). Used for brief references.',
  examples = jsonb_build_array(
    'Did anyone mention the budget concerns?',
    'Not to mention the time constraints.',
    'I should mention that deadlines are tight.',
    'The report makes no mention of risks.'
  ),
  collocations = jsonb_build_array('mention that', 'not to mention', 'should mention', 'make mention of'),
  patterns = jsonb_build_array('mention + noun', 'mention that + clause', 'not to mention', 'make mention of + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'mention' AND cefr_receptive = 'A1';

-- mere
UPDATE lexicon_entries SET
  ipa = '/mɪər/',
  definition_simple = 'used to emphasize how small or unimportant something is',
  definition_teacher = 'Adjective meaning only or just. Formal word used for emphasis in business contexts.',
  usage_notes = 'Formal adjective. Always used before noun. Emphasizes smallness or insignificance.',
  examples = jsonb_build_array(
    'A mere 5% of customers complained.',
    'This is a mere formality.',
    'The cost is a mere fraction of the budget.',
    'It took a mere two hours to complete.'
  ),
  collocations = jsonb_build_array('a mere', 'mere formality', 'mere fraction', 'mere fact'),
  patterns = jsonb_build_array('a mere + number/noun', 'mere + noun'),
  register = 'formal',
  variety = 'international'
WHERE headword = 'mere' AND cefr_receptive = 'A1';

-- metal
UPDATE lexicon_entries SET
  ipa = '/ˈmetəl/',
  definition_simple = 'a hard shiny material like iron or gold',
  definition_teacher = 'Noun meaning metallic element or material. In business, used for precious metals, metal industry, or heavy metal (music/industry).',
  usage_notes = 'Can be countable (metals) or uncountable (metal). Important in manufacturing and commodities contexts.',
  examples = jsonb_build_array(
    'Precious metals prices are rising.',
    'The metal industry faces supply challenges.',
    'Metal components require special handling.',
    'We trade in base metals and alloys.'
  ),
  collocations = jsonb_build_array('precious metals', 'metal industry', 'base metals', 'metal components'),
  patterns = jsonb_build_array('precious/base metals', 'metal + noun', 'made of metal'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'metal' AND cefr_receptive = 'A1';

-- middle
UPDATE lexicon_entries SET
  ipa = '/ˈmɪdəl/',
  definition_simple = 'the center point or position',
  definition_teacher = 'Noun or adjective meaning center or intermediate. Essential in business for middle management, in the middle of, or middle ground.',
  usage_notes = 'Very common in business. Can be noun (the middle) or adjective (middle management). Important for hierarchy.',
  examples = jsonb_build_array(
    'Middle management implements strategy.',
    'We''re in the middle of a major transition.',
    'Let''s find middle ground in the negotiation.',
    'The middle class is our target market.'
  ),
  collocations = jsonb_build_array('middle management', 'in the middle of', 'middle ground', 'middle class'),
  patterns = jsonb_build_array('middle + noun', 'in the middle of + noun', 'find middle ground'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'middle' AND cefr_receptive = 'A1';

-- mile
UPDATE lexicon_entries SET
  ipa = '/maɪl/',
  definition_simple = 'a unit of distance equal to 1.6 kilometers',
  definition_teacher = 'Noun meaning unit of distance. In business, used in idioms like go the extra mile, miles ahead, or milestone.',
  usage_notes = 'Countable noun. Common in business idioms about effort and progress.',
  examples = jsonb_build_array(
    'We go the extra mile for customers.',
    'The company is miles ahead of competitors.',
    'This is a major milestone for the project.',
    'We''re miles away from reaching the goal.'
  ),
  collocations = jsonb_build_array('extra mile', 'miles ahead', 'milestone', 'miles away'),
  patterns = jsonb_build_array('go the extra mile', 'miles ahead of + noun', 'milestone', 'miles away from + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'mile' AND cefr_receptive = 'A1';

-- mind
UPDATE lexicon_entries SET
  ipa = '/maɪnd/',
  definition_simple = 'the part of you that thinks and remembers',
  definition_teacher = 'Noun or verb meaning intellect, attention, or to object. Essential in business for keep in mind, mind the gap, or never mind.',
  usage_notes = 'Very versatile. Can be noun (the mind) or verb (mind if). Many business idioms.',
  examples = jsonb_build_array(
    'Keep in mind that deadlines are firm.',
    'Do you mind if we reschedule?',
    'Great minds think alike.',
    'Never mind the details - focus on results.'
  ),
  collocations = jsonb_build_array('keep in mind', 'do you mind', 'never mind', 'change your mind'),
  patterns = jsonb_build_array('keep in mind that + clause', 'do you mind if + clause', 'never mind', 'change + possessive + mind'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'mind' AND cefr_receptive = 'A1';

-- mine
UPDATE lexicon_entries SET
  ipa = '/maɪn/',
  definition_simple = 'belonging to me',
  definition_teacher = 'Possessive pronoun or noun meaning belonging to speaker or excavation site. In business, used for data mining or gold mine of information.',
  usage_notes = 'Can be pronoun (that''s mine) or noun (a mine). Also verb (mine data). Context determines meaning.',
  examples = jsonb_build_array(
    'The responsibility is mine.',
    'We mine customer data for insights.',
    'This market is a gold mine of opportunities.',
    'A friend of mine works there.'
  ),
  collocations = jsonb_build_array('mine data', 'gold mine', 'friend of mine', 'mine for'),
  patterns = jsonb_build_array('possessive + is mine', 'mine + noun (data)', 'a gold mine of + noun', 'friend of mine'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'mine' AND cefr_receptive = 'A1';

-- minister
UPDATE lexicon_entries SET
  ipa = '/ˈmɪnɪstər/',
  definition_simple = 'a government official or religious leader',
  definition_teacher = 'Noun meaning government official or clergy. In business, relevant when discussing government relations or Prime Minister.',
  usage_notes = 'Countable noun. Important in contexts involving government or international business.',
  examples = jsonb_build_array(
    'The Finance Minister announced new policies.',
    'We met with the Prime Minister''s office.',
    'The minister approved the business permit.',
    'Ministers from several countries attended.'
  ),
  collocations = jsonb_build_array('Prime Minister', 'Finance Minister', 'minister of', 'government minister'),
  patterns = jsonb_build_array('Prime/Finance Minister', 'minister of + department', 'the minister + verb'),
  register = 'formal',
  variety = 'international'
WHERE headword = 'minister' AND cefr_receptive = 'A1';

-- miss
UPDATE lexicon_entries SET
  ipa = '/mɪs/',
  definition_simple = 'to fail to hit, catch, or reach something',
  definition_teacher = 'Verb or noun meaning to fail to achieve, feel absence, or title. Essential in business for missing deadlines, near miss, or hit or miss.',
  usage_notes = 'Very common in business. Can be verb (miss deadline) or noun (a miss). Multiple meanings.',
  examples = jsonb_build_array(
    'We cannot miss this deadline.',
    'Don''t miss the opportunity to expand.',
    'That was a near miss with the budget.',
    'The campaign was hit or miss.'
  ),
  collocations = jsonb_build_array('miss deadline', 'miss opportunity', 'near miss', 'hit or miss'),
  patterns = jsonb_build_array('miss + noun', 'don''t miss + noun', 'a near miss', 'hit or miss'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'miss' AND cefr_receptive = 'A1';

-- modern
UPDATE lexicon_entries SET
  ipa = '/ˈmɒdərn/',
  definition_simple = 'relating to the present or recent times',
  definition_teacher = 'Adjective meaning contemporary or current. Essential in business for modern technology, modern methods, or modernization.',
  usage_notes = 'Very common in business. Used to describe current approaches, technology, or thinking.',
  examples = jsonb_build_array(
    'We use modern technology in all operations.',
    'Modern business practices emphasize agility.',
    'The office has a modern design.',
    'Modernization is essential for competitiveness.'
  ),
  collocations = jsonb_build_array('modern technology', 'modern methods', 'modern business', 'modern design'),
  patterns = jsonb_build_array('modern + noun', 'modernization'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'modern' AND cefr_receptive = 'A1';

-- moon
UPDATE lexicon_entries SET
  ipa = '/muːn/',
  definition_simple = 'the natural satellite that orbits the Earth',
  definition_teacher = 'Noun referring to Earth''s satellite. In business, used in idioms like over the moon, shoot for the moon, or moonlighting.',
  usage_notes = 'Usually singular with "the". Common in business idioms about ambition and happiness.',
  examples = jsonb_build_array(
    'The team is over the moon about the results.',
    'Shoot for the moon with your goals.',
    'Some employees moonlight at second jobs.',
    'Once in a blue moon, we get such opportunities.'
  ),
  collocations = jsonb_build_array('over the moon', 'shoot for the moon', 'moonlighting', 'blue moon'),
  patterns = jsonb_build_array('over the moon', 'shoot for the moon', 'once in a blue moon'),
  register = 'informal',
  variety = 'international'
WHERE headword = 'moon' AND cefr_receptive = 'A1';

-- moreover
UPDATE lexicon_entries SET
  ipa = '/mɔːrˈəʊvər/',
  definition_simple = 'in addition to what has been said',
  definition_teacher = 'Adverb meaning furthermore or additionally. Formal connector used in business writing and presentations.',
  usage_notes = 'Formal linking word. Used to add information or strengthen an argument. Common in business writing.',
  examples = jsonb_build_array(
    'The product is innovative. Moreover, it''s affordable.',
    'Sales increased. Moreover, customer satisfaction improved.',
    'Moreover, the timeline is achievable.',
    'The strategy is sound; moreover, it''s proven.'
  ),
  collocations = jsonb_build_array('moreover it', 'moreover the', 'moreover we', 'moreover this'),
  patterns = jsonb_build_array('sentence. Moreover, + sentence', 'moreover + clause'),
  register = 'formal',
  variety = 'international'
WHERE headword = 'moreover' AND cefr_receptive = 'A1';

-- motor
UPDATE lexicon_entries SET
  ipa = '/ˈməʊtər/',
  definition_simple = 'a machine that produces power to make something move',
  definition_teacher = 'Noun or adjective meaning engine or relating to vehicles. In business, used for motor industry, motor skills, or what motors the company.',
  usage_notes = 'Can be noun (a motor) or adjective (motor industry). Important in automotive and manufacturing contexts.',
  examples = jsonb_build_array(
    'The motor industry is evolving rapidly.',
    'Innovation is the motor driving our growth.',
    'Motor vehicle sales increased last quarter.',
    'The project is the motor of change.'
  ),
  collocations = jsonb_build_array('motor industry', 'motor vehicle', 'motor skills', 'motor of'),
  patterns = jsonb_build_array('motor + noun', 'the motor of/driving + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'motor' AND cefr_receptive = 'A1';

-- mountain
UPDATE lexicon_entries SET
  ipa = '/ˈmaʊntɪn/',
  definition_simple = 'a very high hill',
  definition_teacher = 'Noun meaning large elevation. In business, used in idioms like mountain of work, make a mountain out of a molehill.',
  usage_notes = 'Countable noun. Common in business idioms about challenges and exaggeration.',
  examples = jsonb_build_array(
    'We have a mountain of work to complete.',
    'Don''t make a mountain out of a molehill.',
    'The team moved mountains to meet the deadline.',
    'This is just the tip of the mountain.'
  ),
  collocations = jsonb_build_array('mountain of work', 'make a mountain', 'move mountains', 'mountain to climb'),
  patterns = jsonb_build_array('a mountain of + noun', 'make a mountain out of a molehill', 'move mountains'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'mountain' AND cefr_receptive = 'A1';

-- mouth
UPDATE lexicon_entries SET
  ipa = '/maʊθ/',
  definition_simple = 'the opening in the face used for eating and speaking',
  definition_teacher = 'Noun referring to oral cavity. In business, used in idioms like word of mouth, straight from the horse''s mouth, or put money where mouth is.',
  usage_notes = 'Countable noun. Common in business idioms about communication and commitment.',
  examples = jsonb_build_array(
    'Word of mouth is our best marketing.',
    'Put your money where your mouth is.',
    'I heard it straight from the horse''s mouth.',
    'Don''t shoot your mouth off about confidential matters.'
  ),
  collocations = jsonb_build_array('word of mouth', 'put money where mouth is', 'from the horse''s mouth', 'shoot mouth off'),
  patterns = jsonb_build_array('word of mouth', 'put + possessive + money where + possessive + mouth is', 'straight from the horse''s mouth'),
  register = 'informal',
  variety = 'international'
WHERE headword = 'mouth' AND cefr_receptive = 'A1';

-- move
UPDATE lexicon_entries SET
  ipa = '/muːv/',
  definition_simple = 'to change position or location',
  definition_teacher = 'Verb or noun meaning to change position, progress, or action. Essential in business for making moves, moving forward, or strategic moves.',
  usage_notes = 'Very common in business. Can be verb (move forward) or noun (a smart move). Multiple contexts.',
  examples = jsonb_build_array(
    'Let''s move forward with the plan.',
    'That was a smart move by the CEO.',
    'We need to move quickly on this opportunity.',
    'The company is making strategic moves.'
  ),
  collocations = jsonb_build_array('move forward', 'smart move', 'move quickly', 'strategic move'),
  patterns = jsonb_build_array('move forward/ahead', 'a + adjective + move', 'move on + noun', 'make a move'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'move' AND cefr_receptive = 'A1';

-- music
UPDATE lexicon_entries SET
  ipa = '/ˈmjuːzɪk/',
  definition_simple = 'sounds arranged in a pleasing way',
  definition_teacher = 'Noun referring to organized sound. In business, used in phrases like face the music or music to my ears.',
  usage_notes = 'Uncountable noun. Less common in business except in specific idioms.',
  examples = jsonb_build_array(
    'That''s music to my ears - great news!',
    'We need to face the music about the losses.',
    'The numbers don''t add up - time to face the music.',
    'Background music plays in the office.'
  ),
  collocations = jsonb_build_array('music to ears', 'face the music', 'background music', 'music industry'),
  patterns = jsonb_build_array('music to + possessive + ears', 'face the music', 'background music'),
  register = 'informal',
  variety = 'international'
WHERE headword = 'music' AND cefr_receptive = 'A1';

-- narrow
UPDATE lexicon_entries SET
  ipa = '/ˈnærəʊ/',
  definition_simple = 'having a small width or limited',
  definition_teacher = 'Adjective or verb meaning thin, limited, or to reduce. In business, used for narrow margin, narrow down options, or narrow focus.',
  usage_notes = 'Can be adjective (narrow margin) or verb (narrow down). Common in business for discussing limits and focus.',
  examples = jsonb_build_array(
    'We operate on narrow profit margins.',
    'Let''s narrow down the options to three.',
    'The focus is too narrow - broaden it.',
    'We had a narrow escape from bankruptcy.'
  ),
  collocations = jsonb_build_array('narrow margin', 'narrow down', 'narrow focus', 'narrow escape'),
  patterns = jsonb_build_array('narrow + noun', 'narrow down + noun', 'narrow escape from + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'narrow' AND cefr_receptive = 'A1';

-- nation
UPDATE lexicon_entries SET
  ipa = '/ˈneɪʃən/',
  definition_simple = 'a country or large group of people',
  definition_teacher = 'Noun meaning country or people. In business, used for multinational, nation-state, or national markets.',
  usage_notes = 'Countable noun. Important in international business contexts.',
  examples = jsonb_build_array(
    'We operate as a multinational corporation.',
    'National regulations vary by country.',
    'The nation''s economy is growing.',
    'International trade benefits all nations.'
  ),
  collocations = jsonb_build_array('multinational', 'nation-state', 'national market', 'nation''s economy'),
  patterns = jsonb_build_array('multinational + noun', 'national + noun', 'the nation''s + noun'),
  register = 'formal',
  variety = 'international'
WHERE headword = 'nation' AND cefr_receptive = 'A1';

-- native
UPDATE lexicon_entries SET
  ipa = '/ˈneɪtɪv/',
  definition_simple = 'belonging to a place by birth or origin',
  definition_teacher = 'Adjective or noun meaning indigenous or original. In business, used for native speaker, native language, or native app.',
  usage_notes = 'Can be adjective (native language) or noun (a native). Important in international business and tech contexts.',
  examples = jsonb_build_array(
    'We need a native English speaker for this role.',
    'The native language of business here is Portuguese.',
    'Native apps perform better than web apps.',
    'Understanding native customs helps in negotiations.'
  ),
  collocations = jsonb_build_array('native speaker', 'native language', 'native app', 'native to'),
  patterns = jsonb_build_array('native + noun', 'native speaker of + language', 'native to + place'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'native' AND cefr_receptive = 'A1';

-- nature
UPDATE lexicon_entries SET
  ipa = '/ˈneɪtʃər/',
  definition_simple = 'the physical world or the basic character of something',
  definition_teacher = 'Noun meaning natural world or essential character. In business, used for nature of business, by nature, or second nature.',
  usage_notes = 'Can mean natural world or essential character. Very common in business for describing characteristics.',
  examples = jsonb_build_array(
    'The nature of our business is consulting.',
    'By nature, she''s a problem solver.',
    'Customer service is second nature to our team.',
    'The confidential nature of this requires discretion.'
  ),
  collocations = jsonb_build_array('nature of business', 'by nature', 'second nature', 'nature of work'),
  patterns = jsonb_build_array('the nature of + noun', 'by nature', 'second nature to + person', 'adjective + nature'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'nature' AND cefr_receptive = 'A1';

-- necessary
UPDATE lexicon_entries SET
  ipa = '/ˈnesəsəri/',
  definition_simple = 'needed or required',
  definition_teacher = 'Adjective meaning required or essential. Essential in business for discussing requirements and necessities.',
  usage_notes = 'Very common in business. Often followed by "to" + infinitive or "for" + noun. Important for requirements.',
  examples = jsonb_build_array(
    'It''s necessary to review the contract carefully.',
    'Take all necessary steps to prevent errors.',
    'Training is necessary for success.',
    'We''ll do whatever is necessary.'
  ),
  collocations = jsonb_build_array('necessary to', 'necessary for', 'necessary steps', 'if necessary'),
  patterns = jsonb_build_array('it''s necessary to + infinitive', 'necessary for + noun', 'necessary + noun', 'if necessary'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'necessary' AND cefr_receptive = 'A1';

-- neck
UPDATE lexicon_entries SET
  ipa = '/nek/',
  definition_simple = 'the part of the body connecting the head to the shoulders',
  definition_teacher = 'Noun referring to body part. In business, used in idioms like neck and neck, stick neck out, or pain in the neck.',
  usage_notes = 'Countable noun. Common in business idioms about competition and risk.',
  examples = jsonb_build_array(
    'The two companies are neck and neck in the race.',
    'She stuck her neck out to support the proposal.',
    'This problem is a real pain in the neck.',
    'We''re up to our necks in work.'
  ),
  collocations = jsonb_build_array('neck and neck', 'stick neck out', 'pain in the neck', 'up to neck in'),
  patterns = jsonb_build_array('neck and neck', 'stick + possessive + neck out', 'a pain in the neck', 'up to + possessive + neck in'),
  register = 'informal',
  variety = 'international'
WHERE headword = 'neck' AND cefr_receptive = 'A1';

-- neighbour (neighbor)
UPDATE lexicon_entries SET
  ipa = '/ˈneɪbər/',
  definition_simple = 'a person living next to or near you',
  definition_teacher = 'Noun meaning adjacent person or entity. In business, used for neighboring countries, good neighbor policy, or neighboring businesses.',
  usage_notes = 'Spelled "neighbour" in UK, "neighbor" in US. Can refer to people, businesses, or countries.',
  examples = jsonb_build_array(
    'We maintain good relations with neighboring businesses.',
    'Neighboring countries are key trading partners.',
    'The company is a good corporate neighbor.',
    'Our nearest neighbor is a tech startup.'
  ),
  collocations = jsonb_build_array('neighboring countries', 'good neighbor', 'neighboring businesses', 'nearest neighbor'),
  patterns = jsonb_build_array('neighboring + noun', 'good neighbor', 'nearest neighbor'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'neighbour' AND cefr_receptive = 'A1';

-- never
UPDATE lexicon_entries SET
  ipa = '/ˈnevər/',
  definition_simple = 'not at any time or not ever',
  definition_teacher = 'Adverb meaning at no time. Essential in business for emphasis and making strong statements.',
  usage_notes = 'Very common in business. Used for strong negatives. Often in phrases like "never say never" or "better late than never".',
  examples = jsonb_build_array(
    'We never compromise on quality.',
    'Never say never in business.',
    'Better late than never.',
    'I''ve never seen such dedication.'
  ),
  collocations = jsonb_build_array('never say never', 'better late than never', 'never before', 'never again'),
  patterns = jsonb_build_array('never + verb', 'never say never', 'better late than never', 'have never + past participle'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'never' AND cefr_receptive = 'A1';

-- next
UPDATE lexicon_entries SET
  ipa = '/nekst/',
  definition_simple = 'coming immediately after in time, order, or position',
  definition_teacher = 'Adjective, adverb, or noun meaning following or subsequent. Essential in business for next steps, next quarter, or what''s next.',
  usage_notes = 'Very common in business. Can be adjective (next week), adverb (what comes next), or noun (the next).',
  examples = jsonb_build_array(
    'What are the next steps?',
    'Next quarter''s targets are ambitious.',
    'Who''s next in line for promotion?',
    'Next, we''ll review the budget.'
  ),
  collocations = jsonb_build_array('next steps', 'next quarter', 'next in line', 'what''s next'),
  patterns = jsonb_build_array('next + time period', 'next steps', 'next in line', 'what''s next'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'next' AND cefr_receptive = 'A1';

-- none
UPDATE lexicon_entries SET
  ipa = '/nʌn/',
  definition_simple = 'not any or not one',
  definition_teacher = 'Pronoun meaning not any or zero. In business, used for none of, none other than, or second to none.',
  usage_notes = 'Can be singular or plural. Common in business for emphasis and exclusion.',
  examples = jsonb_build_array(
    'None of the proposals met our requirements.',
    'Our service is second to none.',
    'None other than the CEO attended.',
    'There are none available at this time.'
  ),
  collocations = jsonb_build_array('none of', 'second to none', 'none other than', 'none available'),
  patterns = jsonb_build_array('none of + noun', 'second to none', 'none other than + person', 'none + adjective'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'none' AND cefr_receptive = 'A1';

-- nor
UPDATE lexicon_entries SET
  ipa = '/nɔːr/',
  definition_simple = 'and not, used with neither',
  definition_teacher = 'Conjunction meaning and not. Formal connector used in business writing, typically with neither.',
  usage_notes = 'Formal conjunction. Usually paired with "neither". Used in negative constructions.',
  examples = jsonb_build_array(
    'Neither the CEO nor the CFO was available.',
    'We have neither the time nor the resources.',
    'The product is neither cheap nor expensive.',
    'Nor should we forget the risks involved.'
  ),
  collocations = jsonb_build_array('neither nor', 'nor should', 'nor can', 'nor will'),
  patterns = jsonb_build_array('neither + noun + nor + noun', 'nor + auxiliary + subject + verb'),
  register = 'formal',
  variety = 'international'
WHERE headword = 'nor' AND cefr_receptive = 'A1';

-- north
UPDATE lexicon_entries SET
  ipa = '/nɔːrθ/',
  definition_simple = 'the direction toward the top of a map',
  definition_teacher = 'Noun, adjective, or adverb indicating direction. In business, used for North America, northern markets, or geographic divisions.',
  usage_notes = 'Can be noun (the north), adjective (north side), or adverb (go north). Often capitalized for regions.',
  examples = jsonb_build_array(
    'We''re expanding into North America.',
    'Northern markets show strong growth.',
    'The north side of the building has offices.',
    'Sales are heading north - increasing.'
  ),
  collocations = jsonb_build_array('North America', 'northern markets', 'north side', 'heading north'),
  patterns = jsonb_build_array('North + region', 'northern + noun', 'north of + location', 'heading north'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'north' AND cefr_receptive = 'A1';

-- note
UPDATE lexicon_entries SET
  ipa = '/nəʊt/',
  definition_simple = 'a short written message or to notice something',
  definition_teacher = 'Noun or verb meaning written message, musical tone, or to observe. Essential in business for taking notes, of note, or please note.',
  usage_notes = 'Very versatile. Can be noun (a note) or verb (note that). Very common in business communication.',
  examples = jsonb_build_array(
    'Please note that the deadline has changed.',
    'Take notes during the meeting.',
    'This is a matter of note.',
    'Note the key points in the presentation.'
  ),
  collocations = jsonb_build_array('please note', 'take notes', 'of note', 'note that'),
  patterns = jsonb_build_array('please note that + clause', 'take notes', 'of note', 'note + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'note' AND cefr_receptive = 'A1';

-- notice
UPDATE lexicon_entries SET
  ipa = '/ˈnəʊtɪs/',
  definition_simple = 'to become aware of something or a warning',
  definition_teacher = 'Verb or noun meaning to observe or advance warning. Essential in business for giving notice, short notice, or take notice.',
  usage_notes = 'Very common in business. Can be verb (notice that) or noun (give notice). Important for resignations and warnings.',
  examples = jsonb_build_array(
    'Did you notice the error in the report?',
    'Please give two weeks'' notice before leaving.',
    'We received short notice about the meeting.',
    'Take notice of the new procedures.'
  ),
  collocations = jsonb_build_array('give notice', 'short notice', 'take notice', 'notice that'),
  patterns = jsonb_build_array('notice + noun', 'notice that + clause', 'give + time period + notice', 'on short notice'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'notice' AND cefr_receptive = 'A1';

-- object
UPDATE lexicon_entries SET
  ipa = '/ˈɒbdʒɪkt/ (noun), /əbˈdʒekt/ (verb)',
  definition_simple = 'a thing you can see or touch, or to disagree',
  definition_teacher = 'Noun meaning thing or goal, or verb meaning to oppose. In business, used for business objects, object to decision, or objective.',
  usage_notes = 'Different pronunciation for noun and verb. Can mean physical thing, goal, or to oppose.',
  examples = jsonb_build_array(
    'The object of this meeting is to decide.',
    'I object to the proposed changes.',
    'Physical objects are stored in the warehouse.',
    'Money is no object for this project.'
  ),
  collocations = jsonb_build_array('object to', 'object of', 'money is no object', 'business object'),
  patterns = jsonb_build_array('object to + noun', 'the object of + noun', 'money is no object', 'object + that clause'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'object' AND cefr_receptive = 'A1';

-- observe
UPDATE lexicon_entries SET
  ipa = '/əbˈzɜːrv/',
  definition_simple = 'to watch carefully or to obey',
  definition_teacher = 'Verb meaning to watch, notice, or comply with. In business, used for observing trends, observing rules, or making observations.',
  usage_notes = 'Formal verb. Can mean watch, notice, or comply with. Common in business analysis and compliance.',
  examples = jsonb_build_array(
    'We observe strict quality standards.',
    'Observe how competitors approach the market.',
    'I observed several issues during the audit.',
    'Please observe the confidentiality agreement.'
  ),
  collocations = jsonb_build_array('observe standards', 'observe trends', 'observe that', 'observe rules'),
  patterns = jsonb_build_array('observe + noun', 'observe that + clause', 'observe + question word + clause'),
  register = 'formal',
  variety = 'international'
WHERE headword = 'observe' AND cefr_receptive = 'A1';

-- occasion
UPDATE lexicon_entries SET
  ipa = '/əˈkeɪʒən/',
  definition_simple = 'a particular time when something happens',
  definition_teacher = 'Noun meaning event, opportunity, or instance. In business, used for special occasions, on occasion, or rise to the occasion.',
  usage_notes = 'Countable noun. Can mean event, opportunity, or instance. Common in business for discussing events and opportunities.',
  examples = jsonb_build_array(
    'This is a special occasion for the company.',
    'On occasion, we work weekends.',
    'The team rose to the occasion.',
    'We meet on several occasions throughout the year.'
  ),
  collocations = jsonb_build_array('special occasion', 'on occasion', 'rise to the occasion', 'on several occasions'),
  patterns = jsonb_build_array('special occasion', 'on occasion', 'rise to the occasion', 'on + number + occasions'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'occasion' AND cefr_receptive = 'A1';
