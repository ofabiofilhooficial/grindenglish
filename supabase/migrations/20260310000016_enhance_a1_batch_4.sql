-- Enhancement of A1 Vocabulary - Batch 4 (100 words: offer → result)
-- Professional English context for Brazilian learners
-- Migration: 20260310000016

-- offer
UPDATE lexicon_entries SET
  ipa = '/ˈɒfər/',
  definition_simple = 'to present something for someone to accept or refuse',
  definition_teacher = 'Verb or noun meaning to propose or proposal. Essential in business for job offers, making offers, or special offers.',
  usage_notes = 'Very common in business. Can be verb (offer a job) or noun (an offer). Central to negotiations and sales.',
  examples = jsonb_build_array(
    'We''d like to offer you the position.',
    'The company made a generous offer.',
    'This is a limited-time offer.',
    'What can we offer to attract top talent?'
  ),
  collocations = jsonb_build_array('job offer', 'make an offer', 'special offer', 'offer to'),
  patterns = jsonb_build_array('offer + person + noun', 'make an offer', 'offer to + infinitive', 'special offer'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'offer' AND cefr_receptive = 'A1';

-- often
UPDATE lexicon_entries SET
  ipa = '/ˈɒfən/',
  definition_simple = 'many times or frequently',
  definition_teacher = 'Adverb meaning frequently. Essential in business for discussing frequency of actions, events, or occurrences.',
  usage_notes = 'Very common in business. Indicates high frequency. Can be modified (more often, most often, quite often).',
  examples = jsonb_build_array(
    'We often meet with clients on Fridays.',
    'How often do you review performance?',
    'More often than not, quality wins.',
    'Customers often request this feature.'
  ),
  collocations = jsonb_build_array('how often', 'more often', 'quite often', 'often enough'),
  patterns = jsonb_build_array('often + verb', 'how often', 'more often than not'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'often' AND cefr_receptive = 'A1';

-- oil
UPDATE lexicon_entries SET
  ipa = '/ɔɪl/',
  definition_simple = 'a thick liquid from plants or underground used for fuel or cooking',
  definition_teacher = 'Noun meaning petroleum or lubricant. In business, used for oil industry, oil prices, or oil the wheels (facilitate).',
  usage_notes = 'Uncountable noun. Important in energy, commodities, and manufacturing contexts.',
  examples = jsonb_build_array(
    'Oil prices affect transportation costs.',
    'The oil industry is transitioning to renewables.',
    'We need to oil the wheels of bureaucracy.',
    'Olive oil is used in food production.'
  ),
  collocations = jsonb_build_array('oil prices', 'oil industry', 'oil the wheels', 'crude oil'),
  patterns = jsonb_build_array('oil + noun', 'oil the wheels', 'oil prices'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'oil' AND cefr_receptive = 'A1';

-- only
UPDATE lexicon_entries SET
  ipa = '/ˈəʊnli/',
  definition_simple = 'and no one or nothing more',
  definition_teacher = 'Adverb or adjective meaning solely or exclusively. Essential in business for emphasis and limitation.',
  usage_notes = 'Very common in business. Can be adverb (only one) or adjective (the only option). Used for emphasis.',
  examples = jsonb_build_array(
    'This is the only solution that works.',
    'We only have two days to complete it.',
    'If only we had more resources.',
    'The only way forward is innovation.'
  ),
  collocations = jsonb_build_array('the only', 'only one', 'if only', 'only way'),
  patterns = jsonb_build_array('the only + noun', 'only + number', 'if only + clause', 'only way to + infinitive'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'only' AND cefr_receptive = 'A1';

-- operation
UPDATE lexicon_entries SET
  ipa = '/ˌɒpəˈreɪʃən/',
  definition_simple = 'the process of working or functioning',
  definition_teacher = 'Noun meaning functioning, business activity, or procedure. Essential in business for operations, operational efficiency.',
  usage_notes = 'Very common in business. Can mean business activities, functioning, or medical procedure. Context determines meaning.',
  examples = jsonb_build_array(
    'Operations are running smoothly.',
    'The Chief Operating Officer oversees daily operations.',
    'We need to streamline our operations.',
    'The operation was a success.'
  ),
  collocations = jsonb_build_array('business operations', 'daily operations', 'operational efficiency', 'in operation'),
  patterns = jsonb_build_array('noun + operations', 'in operation', 'operational + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'operation' AND cefr_receptive = 'A1';

-- opinion
UPDATE lexicon_entries SET
  ipa = '/əˈpɪnjən/',
  definition_simple = 'what you think or believe about something',
  definition_teacher = 'Noun meaning a personal view or judgment. Essential in business for expressing views, gathering feedback, and decision-making.',
  usage_notes = 'Countable noun. Common in phrases like "in my opinion" or "public opinion". Important for professional discussions.',
  examples = jsonb_build_array(
    'In my opinion, we should invest in new technology.',
    'What is your opinion on the proposed changes?',
    'Public opinion strongly supports this initiative.',
    'We value your professional opinion on this matter.'
  ),
  collocations = jsonb_build_array('in my opinion', 'public opinion', 'expert opinion', 'difference of opinion'),
  patterns = jsonb_build_array('in + possessive + opinion', 'opinion on/about + noun', 'have an opinion'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'opinion' AND cefr_receptive = 'A1';

-- opportunity
UPDATE lexicon_entries SET
  ipa = '/ˌɒpəˈtjuːnəti/',
  definition_simple = 'a chance to do something',
  definition_teacher = 'Noun meaning a favorable chance or occasion. Very common in business for discussing career opportunities, business opportunities.',
  usage_notes = 'Countable noun. Very common in business contexts. Often followed by "to" + infinitive or "for" + noun.',
  examples = jsonb_build_array(
    'This is a great opportunity to expand our market.',
    'We offer excellent career opportunities for graduates.',
    'Don''t miss this opportunity to network with industry leaders.',
    'The merger creates new opportunities for growth.'
  ),
  collocations = jsonb_build_array('great opportunity', 'career opportunity', 'business opportunity', 'opportunity to'),
  patterns = jsonb_build_array('opportunity + to infinitive', 'opportunity for + noun', 'take/seize an opportunity'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'opportunity' AND cefr_receptive = 'A1';

-- order
UPDATE lexicon_entries SET
  ipa = '/ˈɔːrdər/',
  definition_simple = 'a request for goods or services, or the arrangement of things',
  definition_teacher = 'Noun or verb with multiple meanings: purchase request, sequence, or command. Essential in business for orders, ordering.',
  usage_notes = 'Very common in business. Can mean "purchase order", "sequence", or "command". Context determines meaning.',
  examples = jsonb_build_array(
    'We received a large order from our biggest client.',
    'Please place your order by Friday.',
    'The files are arranged in alphabetical order.',
    'In order to succeed, we need better planning.'
  ),
  collocations = jsonb_build_array('place an order', 'in order to', 'purchase order', 'in order'),
  patterns = jsonb_build_array('place/make an order', 'in order to + infinitive', 'in + adjective + order'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'order' AND cefr_receptive = 'A1';

-- ordinary
UPDATE lexicon_entries SET
  ipa = '/ˈɔːrdənəri/',
  definition_simple = 'normal, not special or different',
  definition_teacher = 'Adjective meaning usual, normal, or average. Used in business to describe standard procedures or typical situations.',
  usage_notes = 'Can be neutral (ordinary day) or slightly negative (just ordinary). Often contrasted with "extraordinary".',
  examples = jsonb_build_array(
    'This is just an ordinary business meeting.',
    'We follow ordinary accounting procedures.',
    'The results were better than ordinary.',
    'Ordinary employees can also contribute great ideas.'
  ),
  collocations = jsonb_build_array('ordinary day', 'ordinary people', 'out of the ordinary', 'ordinary circumstances'),
  patterns = jsonb_build_array('ordinary + noun', 'out of the ordinary'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'ordinary' AND cefr_receptive = 'A1';

-- organize
UPDATE lexicon_entries SET
  ipa = '/ˈɔːrɡənaɪz/',
  definition_simple = 'to arrange or plan something in an orderly way',
  definition_teacher = 'Verb meaning to arrange, plan, or coordinate. Essential in business for project management, event planning, and workflow.',
  usage_notes = 'Common in business contexts. British spelling: organise. Related: organization, organized, organizer.',
  examples = jsonb_build_array(
    'She organized the conference for 500 attendees.',
    'We need to organize our files more efficiently.',
    'The team is well organized and productive.',
    'Can you organize a meeting for next week?'
  ),
  collocations = jsonb_build_array('organize a meeting', 'well organized', 'organize files', 'organize an event'),
  patterns = jsonb_build_array('organize + noun', 'organize + to infinitive', 'well/poorly organized'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'organize' AND cefr_receptive = 'A1';

-- otherwise
UPDATE lexicon_entries SET
  ipa = '/ˈʌðərwaɪz/',
  definition_simple = 'in a different way, or if not',
  definition_teacher = 'Adverb meaning differently or if not. Common in business for presenting alternatives or consequences.',
  usage_notes = 'Can mean "in a different way" or "if not" (conditional). Important for logical arguments and conditions.',
  examples = jsonb_build_array(
    'Submit the report by Friday, otherwise it will be late.',
    'The project went well; otherwise, we would have missed the deadline.',
    'Unless otherwise stated, all meetings are in Conference Room A.',
    'We must act now, otherwise we''ll lose the opportunity.'
  ),
  collocations = jsonb_build_array('unless otherwise', 'or otherwise', 'otherwise stated', 'otherwise known as'),
  patterns = jsonb_build_array('verb, otherwise + clause', 'unless otherwise + past participle'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'otherwise' AND cefr_receptive = 'A1';

-- ought
UPDATE lexicon_entries SET
  ipa = '/ɔːt/',
  definition_simple = 'should, used to say what is right or advisable',
  definition_teacher = 'Modal verb expressing obligation, duty, or advisability. Similar to "should" but slightly more formal.',
  usage_notes = 'Formal modal verb. Always followed by "to" + infinitive. Less common than "should" in modern business English.',
  examples = jsonb_build_array(
    'We ought to review the contract before signing.',
    'You ought to inform the client about the delay.',
    'The company ought to invest more in training.',
    'Employees ought to follow safety procedures.'
  ),
  collocations = jsonb_build_array('ought to do', 'ought to be', 'ought to have'),
  patterns = jsonb_build_array('ought to + infinitive', 'ought to have + past participle'),
  register = 'formal',
  variety = 'international'
WHERE headword = 'ought' AND cefr_receptive = 'A1';

-- ounce
UPDATE lexicon_entries SET
  ipa = '/aʊns/',
  definition_simple = 'a unit of weight equal to about 28 grams',
  definition_teacher = 'Noun meaning a unit of measurement. In business, used literally for weight or figuratively (ounce of truth).',
  usage_notes = 'Imperial measurement unit. Common in US contexts. Abbreviation: oz. Also used in idioms.',
  examples = jsonb_build_array(
    'The package weighs 16 ounces.',
    'There isn''t an ounce of truth in that claim.',
    'Gold is sold by the ounce.',
    'Every ounce of effort counts in this project.'
  ),
  collocations = jsonb_build_array('ounce of', 'per ounce', 'fluid ounce', 'not an ounce'),
  patterns = jsonb_build_array('number + ounce(s)', 'an ounce of + noun'),
  register = 'neutral',
  variety = 'US/international'
WHERE headword = 'ounce' AND cefr_receptive = 'A1';

-- out of
UPDATE lexicon_entries SET
  ipa = '/aʊt əv/',
  definition_simple = 'from inside to outside, or no longer having something',
  definition_teacher = 'Prepositional phrase with multiple meanings: from inside, lacking, or made from. Very common in business.',
  usage_notes = 'Very versatile phrase. Can mean "from inside", "lacking" (out of stock), or "from" (made out of).',
  examples = jsonb_build_array(
    'The product is currently out of stock.',
    'We are out of time for this meeting.',
    'She walked out of the office at 5 PM.',
    'Nine out of ten customers recommend our service.'
  ),
  collocations = jsonb_build_array('out of stock', 'out of time', 'out of office', 'out of order'),
  patterns = jsonb_build_array('out of + noun', 'number + out of + number'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'out of' AND cefr_receptive = 'A1';

-- owe
UPDATE lexicon_entries SET
  ipa = '/əʊ/',
  definition_simple = 'to have to pay or give something to someone',
  definition_teacher = 'Verb meaning to be in debt or obligated to someone. Common in business for financial obligations and gratitude.',
  usage_notes = 'Can mean financial debt or moral obligation. Common in phrases like "owe money" or "owe thanks".',
  examples = jsonb_build_array(
    'The company owes $50,000 to suppliers.',
    'We owe our success to excellent teamwork.',
    'How much do I owe you for the supplies?',
    'I owe you an apology for the misunderstanding.'
  ),
  collocations = jsonb_build_array('owe money', 'owe to', 'owe an apology', 'owe thanks'),
  patterns = jsonb_build_array('owe + person + noun', 'owe + noun + to + person'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'owe' AND cefr_receptive = 'A1';

-- own
UPDATE lexicon_entries SET
  ipa = '/əʊn/',
  definition_simple = 'belonging to yourself, not shared',
  definition_teacher = 'Adjective or verb meaning belonging to oneself or to possess. Essential in business for ownership and possession.',
  usage_notes = 'Can be adjective (my own office) or verb (own a business). Very common in business contexts.',
  examples = jsonb_build_array(
    'She has her own consulting business.',
    'Each employee has their own workspace.',
    'The company owns several properties downtown.',
    'We need to take ownership of our own mistakes.'
  ),
  collocations = jsonb_build_array('my own', 'own business', 'on your own', 'own up to'),
  patterns = jsonb_build_array('possessive + own + noun', 'own + noun', 'on + possessive + own'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'own' AND cefr_receptive = 'A1';

-- page
UPDATE lexicon_entries SET
  ipa = '/peɪdʒ/',
  definition_simple = 'one side of a sheet of paper in a book or document',
  definition_teacher = 'Noun meaning a sheet in a document or web page. Common in business for documents, reports, and websites.',
  usage_notes = 'Countable noun. Can refer to physical pages or web pages. Common in business documentation.',
  examples = jsonb_build_array(
    'Please refer to page 5 of the report.',
    'The contract is 20 pages long.',
    'Visit our website''s contact page for more information.',
    'Turn to the next page for the financial summary.'
  ),
  collocations = jsonb_build_array('web page', 'front page', 'next page', 'page number'),
  patterns = jsonb_build_array('page + number', 'number + pages', 'on page + number'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'page' AND cefr_receptive = 'A1';

-- pain
UPDATE lexicon_entries SET
  ipa = '/peɪn/',
  definition_simple = 'physical or emotional suffering',
  definition_teacher = 'Noun meaning physical or emotional discomfort. In business, used literally or in phrases like "pain point".',
  usage_notes = 'Can be countable (a pain) or uncountable (in pain). Common in business for "pain points" (problems).',
  examples = jsonb_build_array(
    'Customer pain points drive product innovation.',
    'The transition was painful but necessary.',
    'We need to identify the pain points in our process.',
    'No pain, no gain - change requires effort.'
  ),
  collocations = jsonb_build_array('pain point', 'in pain', 'cause pain', 'no pain no gain'),
  patterns = jsonb_build_array('pain point', 'in pain', 'cause + pain'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'pain' AND cefr_receptive = 'A1';

-- paint
UPDATE lexicon_entries SET
  ipa = '/peɪnt/',
  definition_simple = 'to cover a surface with colored liquid, or the liquid itself',
  definition_teacher = 'Verb or noun meaning to apply color or the coloring substance. In business, used literally or figuratively (paint a picture).',
  usage_notes = 'Can be verb (paint a wall) or noun (a can of paint). Used figuratively in business communication.',
  examples = jsonb_build_array(
    'The office needs to be painted before the opening.',
    'Let me paint a picture of our market position.',
    'The report paints a positive outlook for growth.',
    'Fresh paint can improve workplace atmosphere.'
  ),
  collocations = jsonb_build_array('paint a picture', 'fresh paint', 'paint a wall', 'paint a portrait'),
  patterns = jsonb_build_array('paint + noun', 'paint a picture of + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'paint' AND cefr_receptive = 'A1';

-- paper
UPDATE lexicon_entries SET
  ipa = '/ˈpeɪpər/',
  definition_simple = 'thin material for writing on, or a document',
  definition_teacher = 'Noun meaning writing material or documents. Essential in business for paperwork, documents, and written materials.',
  usage_notes = 'Can be uncountable (paper material) or countable (a paper = document). Very common in business.',
  examples = jsonb_build_array(
    'Please print the contract on company paper.',
    'We are moving towards a paperless office.',
    'The research paper was published last month.',
    'All papers must be signed by Friday.'
  ),
  collocations = jsonb_build_array('on paper', 'paperwork', 'research paper', 'white paper'),
  patterns = jsonb_build_array('on paper', 'piece of paper', 'paper + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'paper' AND cefr_receptive = 'A1';

-- party
UPDATE lexicon_entries SET
  ipa = '/ˈpɑːrti/',
  definition_simple = 'a social gathering, or a person or group involved in something',
  definition_teacher = 'Noun with multiple meanings: social event, political group, or legal party. In business, often means "involved party".',
  usage_notes = 'Multiple meanings. In business, often refers to parties in a contract or agreement.',
  examples = jsonb_build_array(
    'Both parties agreed to the terms of the contract.',
    'The company is hosting a holiday party next week.',
    'Third-party vendors provide additional services.',
    'All interested parties should attend the meeting.'
  ),
  collocations = jsonb_build_array('third party', 'both parties', 'interested party', 'party to'),
  patterns = jsonb_build_array('party to + noun', 'third-party + noun', 'both/all parties'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'party' AND cefr_receptive = 'A1';

-- pass
UPDATE lexicon_entries SET
  ipa = '/pɑːs/',
  definition_simple = 'to move past something, or to succeed in a test',
  definition_teacher = 'Verb with multiple meanings: move past, succeed, or transfer. Very common in business contexts.',
  usage_notes = 'Very versatile verb. Can mean "go past", "succeed", "transfer", or "approve". Context determines meaning.',
  examples = jsonb_build_array(
    'Please pass this information to your team.',
    'The proposal passed with unanimous approval.',
    'Time passes quickly when you''re busy.',
    'She passed the certification exam on her first attempt.'
  ),
  collocations = jsonb_build_array('pass information', 'pass a test', 'pass approval', 'pass on'),
  patterns = jsonb_build_array('pass + noun + to + person', 'pass + test/exam', 'pass on + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'pass' AND cefr_receptive = 'A1';

-- past
UPDATE lexicon_entries SET
  ipa = '/pɑːst/',
  definition_simple = 'the time before now, or beyond in position',
  definition_teacher = 'Noun, adjective, or preposition referring to previous time or position. Essential in business for discussing history.',
  usage_notes = 'Can be noun (the past), adjective (past experience), or preposition (past the deadline).',
  examples = jsonb_build_array(
    'Past performance indicates future success.',
    'We need to learn from past mistakes.',
    'The deadline is past - we missed it.',
    'In the past, we used different methods.'
  ),
  collocations = jsonb_build_array('in the past', 'past experience', 'past performance', 'past the deadline'),
  patterns = jsonb_build_array('in the past', 'past + noun', 'past + time/place'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'past' AND cefr_receptive = 'A1';

-- peace
UPDATE lexicon_entries SET
  ipa = '/piːs/',
  definition_simple = 'a state of calm and quiet, without war or conflict',
  definition_teacher = 'Noun meaning absence of conflict or tranquility. In business, used for "peace of mind" or workplace harmony.',
  usage_notes = 'Uncountable noun. Common in business phrases like "peace of mind" or "make peace with".',
  examples = jsonb_build_array(
    'The warranty provides peace of mind for customers.',
    'We need to make peace with the changes.',
    'A peaceful work environment increases productivity.',
    'The agreement brought peace to the negotiation.'
  ),
  collocations = jsonb_build_array('peace of mind', 'make peace', 'peaceful environment', 'at peace'),
  patterns = jsonb_build_array('peace of mind', 'make peace with + noun', 'peaceful + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'peace' AND cefr_receptive = 'A1';

-- perfect
UPDATE lexicon_entries SET
  ipa = '/ˈpɜːrfɪkt/',
  definition_simple = 'without any mistakes or faults, completely correct',
  definition_teacher = 'Adjective meaning flawless or ideal. Common in business for describing ideal solutions or outcomes.',
  usage_notes = 'Can be adjective (perfect solution) or verb /pərˈfekt/ (to perfect a skill). Often used for emphasis.',
  examples = jsonb_build_array(
    'This is the perfect solution for our needs.',
    'Nobody is perfect - we all make mistakes.',
    'The timing is perfect for launching the product.',
    'We need to perfect our customer service process.'
  ),
  collocations = jsonb_build_array('perfect solution', 'perfect timing', 'perfect for', 'nobody is perfect'),
  patterns = jsonb_build_array('perfect + noun', 'perfect for + noun', 'perfect + to infinitive'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'perfect' AND cefr_receptive = 'A1';

-- perhaps
UPDATE lexicon_entries SET
  ipa = '/pərˈhæps/',
  definition_simple = 'possibly, maybe',
  definition_teacher = 'Adverb expressing possibility or uncertainty. Common in business for making suggestions or expressing uncertainty.',
  usage_notes = 'More formal than "maybe". Often used to make polite suggestions or express uncertainty professionally.',
  examples = jsonb_build_array(
    'Perhaps we should reconsider our strategy.',
    'The delay is perhaps due to supply chain issues.',
    'Perhaps you could review the document before the meeting.',
    'This is perhaps the best option available.'
  ),
  collocations = jsonb_build_array('perhaps the best', 'perhaps we should', 'perhaps due to', 'perhaps not'),
  patterns = jsonb_build_array('perhaps + clause', 'perhaps + adjective/adverb'),
  register = 'formal',
  variety = 'international'
WHERE headword = 'perhaps' AND cefr_receptive = 'A1';

-- permanent
UPDATE lexicon_entries SET
  ipa = '/ˈpɜːrmənənt/',
  definition_simple = 'lasting forever or for a very long time',
  definition_teacher = 'Adjective meaning lasting or enduring. Essential in business for discussing employment types and long-term solutions.',
  usage_notes = 'Opposite of "temporary". Very common in HR contexts (permanent position, permanent employee).',
  examples = jsonb_build_array(
    'We are offering a permanent position with benefits.',
    'The company relocated to a permanent office space.',
    'This is a permanent solution, not a temporary fix.',
    'Permanent employees receive full benefits.'
  ),
  collocations = jsonb_build_array('permanent position', 'permanent employee', 'permanent solution', 'permanent address'),
  patterns = jsonb_build_array('permanent + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'permanent' AND cefr_receptive = 'A1';

-- permit
UPDATE lexicon_entries SET
  ipa = '/pərˈmɪt/',
  definition_simple = 'to allow something to happen, or an official document giving permission',
  definition_teacher = 'Verb meaning to allow, or noun meaning official permission. Common in business for permissions and authorizations.',
  usage_notes = 'Formal verb. Can also be noun /ˈpɜːrmɪt/ (work permit). More formal than "allow".',
  examples = jsonb_build_array(
    'Company policy does not permit personal use of equipment.',
    'You need a work permit to be employed here.',
    'Time permitting, we will discuss the budget.',
    'The building permit was approved last week.'
  ),
  collocations = jsonb_build_array('work permit', 'building permit', 'permit to', 'time permitting'),
  patterns = jsonb_build_array('permit + noun', 'permit + person + to infinitive', 'time permitting'),
  register = 'formal',
  variety = 'international'
WHERE headword = 'permit' AND cefr_receptive = 'A1';

-- picture
UPDATE lexicon_entries SET
  ipa = '/ˈpɪktʃər/',
  definition_simple = 'an image or photograph, or the general situation',
  definition_teacher = 'Noun meaning image or overall situation. In business, often used figuratively (big picture, get the picture).',
  usage_notes = 'Can be literal (photograph) or figurative (overall situation). Very common in business idioms.',
  examples = jsonb_build_array(
    'Let me show you the big picture of our strategy.',
    'Do you get the picture of what we''re trying to achieve?',
    'The financial picture looks positive this quarter.',
    'Please include pictures in the presentation.'
  ),
  collocations = jsonb_build_array('big picture', 'get the picture', 'overall picture', 'take a picture'),
  patterns = jsonb_build_array('the big picture', 'get the picture', 'picture of + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'picture' AND cefr_receptive = 'A1';

-- piece
UPDATE lexicon_entries SET
  ipa = '/piːs/',
  definition_simple = 'a part or portion of something',
  definition_teacher = 'Noun meaning a part, portion, or single item. Very common in business for discussing components or advice.',
  usage_notes = 'Countable noun. Used with uncountable nouns (a piece of advice). Common in many business contexts.',
  examples = jsonb_build_array(
    'Let me give you a piece of advice.',
    'Each piece of the puzzle is important.',
    'We need to piece together the information.',
    'This is a key piece of our strategy.'
  ),
  collocations = jsonb_build_array('piece of advice', 'piece of information', 'piece together', 'key piece'),
  patterns = jsonb_build_array('a piece of + uncountable noun', 'piece together + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'piece' AND cefr_receptive = 'A1';

-- plant
UPDATE lexicon_entries SET
  ipa = '/plɑːnt/',
  definition_simple = 'a living thing that grows in soil, or a factory',
  definition_teacher = 'Noun meaning vegetation or industrial facility. In business, often refers to manufacturing plants.',
  usage_notes = 'Multiple meanings: living organism or factory/facility. Context determines meaning.',
  examples = jsonb_build_array(
    'The manufacturing plant operates 24/7.',
    'We are opening a new plant in Brazil.',
    'The office has plants to improve air quality.',
    'Plant safety is our top priority.'
  ),
  collocations = jsonb_build_array('manufacturing plant', 'production plant', 'plant safety', 'plant manager'),
  patterns = jsonb_build_array('noun + plant', 'plant + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'plant' AND cefr_receptive = 'A1';

-- play
UPDATE lexicon_entries SET
  ipa = '/pleɪ/',
  definition_simple = 'to take part in a game or activity',
  definition_teacher = 'Verb meaning to participate or perform. In business, used in phrases like "play a role" or "come into play".',
  usage_notes = 'Very versatile verb. In business, often used figuratively (play a role, play by the rules).',
  examples = jsonb_build_array(
    'Marketing plays a crucial role in our success.',
    'We need to play by the rules and follow regulations.',
    'Several factors come into play in this decision.',
    'Let''s play it safe and get legal approval first.'
  ),
  collocations = jsonb_build_array('play a role', 'play by the rules', 'come into play', 'play it safe'),
  patterns = jsonb_build_array('play a role in + noun', 'play by + noun', 'come into play'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'play' AND cefr_receptive = 'A1';

-- political
UPDATE lexicon_entries SET
  ipa = '/pəˈlɪtɪkəl/',
  definition_simple = 'relating to government and public affairs',
  definition_teacher = 'Adjective relating to politics or government. In business, used for political environment, political risk.',
  usage_notes = 'Common in business contexts for discussing external factors affecting business (political climate, political risk).',
  examples = jsonb_build_array(
    'Political stability is important for investment.',
    'We need to consider the political climate before expanding.',
    'Political factors affect our international operations.',
    'The company avoids political controversies.'
  ),
  collocations = jsonb_build_array('political climate', 'political risk', 'political stability', 'political factors'),
  patterns = jsonb_build_array('political + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'political' AND cefr_receptive = 'A1';

-- poor
UPDATE lexicon_entries SET
  ipa = '/pʊr/',
  definition_simple = 'having little money, or of low quality',
  definition_teacher = 'Adjective meaning lacking money or quality. Common in business for describing performance, quality, or conditions.',
  usage_notes = 'Can mean "lacking money" or "low quality". Context determines meaning. Opposite of "rich" or "good".',
  examples = jsonb_build_array(
    'Poor communication led to the misunderstanding.',
    'The product received poor reviews from customers.',
    'Poor planning results in project delays.',
    'We need to improve our poor performance this quarter.'
  ),
  collocations = jsonb_build_array('poor performance', 'poor quality', 'poor communication', 'poor planning'),
  patterns = jsonb_build_array('poor + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'poor' AND cefr_receptive = 'A1';

-- popular
UPDATE lexicon_entries SET
  ipa = '/ˈpɒpjələr/',
  definition_simple = 'liked or enjoyed by many people',
  definition_teacher = 'Adjective meaning well-liked or widely accepted. Common in business for discussing products, trends, or opinions.',
  usage_notes = 'Very common in business contexts. Often used with "among" or "with" to specify the group.',
  examples = jsonb_build_array(
    'This is our most popular product among young professionals.',
    'Remote work has become increasingly popular.',
    'The new policy is popular with employees.',
    'Popular opinion supports the initiative.'
  ),
  collocations = jsonb_build_array('most popular', 'increasingly popular', 'popular with', 'popular among'),
  patterns = jsonb_build_array('popular + with/among + noun', 'increasingly popular'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'popular' AND cefr_receptive = 'A1';

-- population
UPDATE lexicon_entries SET
  ipa = '/ˌpɒpjuˈleɪʃən/',
  definition_simple = 'all the people living in a particular area',
  definition_teacher = 'Noun meaning the total number of people in an area. In business, used for market analysis and demographics.',
  usage_notes = 'Countable or uncountable. Important in business for market sizing and demographic analysis.',
  examples = jsonb_build_array(
    'The target population for this product is urban professionals.',
    'Population growth drives market expansion.',
    'We serve a population of 5 million customers.',
    'The aging population creates new business opportunities.'
  ),
  collocations = jsonb_build_array('target population', 'population growth', 'aging population', 'general population'),
  patterns = jsonb_build_array('target population', 'population of + number', 'adjective + population'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'population' AND cefr_receptive = 'A1';

-- position
UPDATE lexicon_entries SET
  ipa = '/pəˈzɪʃən/',
  definition_simple = 'a place where someone or something is, or a job',
  definition_teacher = 'Noun meaning location, job role, or situation. Essential in business for discussing jobs and competitive standing.',
  usage_notes = 'Multiple meanings: physical location, job role, or market position. Very common in business.',
  examples = jsonb_build_array(
    'We are hiring for several open positions.',
    'The company holds a strong market position.',
    'What is your position on this issue?',
    'She was promoted to a senior position.'
  ),
  collocations = jsonb_build_array('job position', 'market position', 'senior position', 'in a position to'),
  patterns = jsonb_build_array('position + in/on + noun', 'in a position to + infinitive'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'position' AND cefr_receptive = 'A1';

-- possess
UPDATE lexicon_entries SET
  ipa = '/pəˈzes/',
  definition_simple = 'to have or own something',
  definition_teacher = 'Verb meaning to own or have. Formal alternative to "have" or "own", common in business and legal contexts.',
  usage_notes = 'Formal verb. More formal than "have" or "own". Common in legal and business documents.',
  examples = jsonb_build_array(
    'The company possesses valuable intellectual property.',
    'She possesses excellent leadership skills.',
    'We possess the resources needed for expansion.',
    'Candidates must possess relevant experience.'
  ),
  collocations = jsonb_build_array('possess skills', 'possess knowledge', 'possess property', 'possess experience'),
  patterns = jsonb_build_array('possess + noun'),
  register = 'formal',
  variety = 'international'
WHERE headword = 'possess' AND cefr_receptive = 'A1';

-- possible
UPDATE lexicon_entries SET
  ipa = '/ˈpɒsəbəl/',
  definition_simple = 'able to happen or be done',
  definition_teacher = 'Adjective meaning feasible or achievable. Essential in business for discussing options and feasibility.',
  usage_notes = 'Very common in business. Often used with "it is possible" or "as soon as possible".',
  examples = jsonb_build_array(
    'Is it possible to complete the project by Friday?',
    'Please respond as soon as possible.',
    'We will explore all possible solutions.',
    'It''s possible that we''ll need additional resources.'
  ),
  collocations = jsonb_build_array('as soon as possible', 'if possible', 'possible solution', 'it is possible'),
  patterns = jsonb_build_array('it is possible + to infinitive', 'as + adjective + as possible', 'possible + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'possible' AND cefr_receptive = 'A1';

-- post
UPDATE lexicon_entries SET
  ipa = '/pəʊst/',
  definition_simple = 'mail, a job position, or to publish something online',
  definition_teacher = 'Noun or verb with multiple meanings: mail, position, or publish. Very common in modern business contexts.',
  usage_notes = 'Multiple meanings: mail (UK), job position, or social media post. Context determines meaning.',
  examples = jsonb_build_array(
    'Please post the announcement on the company website.',
    'The post of Marketing Director is now open.',
    'We received your application by post.',
    'She posted an update about the project on LinkedIn.'
  ),
  collocations = jsonb_build_array('post a message', 'job post', 'by post', 'post online'),
  patterns = jsonb_build_array('post + noun', 'post of + job title', 'by post'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'post' AND cefr_receptive = 'A1';

-- pound
UPDATE lexicon_entries SET
  ipa = '/paʊnd/',
  definition_simple = 'a unit of weight or British currency',
  definition_teacher = 'Noun meaning unit of weight or UK currency. In business, used for measurements or financial amounts.',
  usage_notes = 'Multiple meanings: weight (lb) or currency (£). Context and symbol determine meaning.',
  examples = jsonb_build_array(
    'The package weighs five pounds.',
    'The contract is worth 50,000 pounds.',
    'Prices are listed in pounds sterling.',
    'The pound has strengthened against the dollar.'
  ),
  collocations = jsonb_build_array('pounds sterling', 'British pound', 'per pound', 'pound sign'),
  patterns = jsonb_build_array('number + pound(s)', 'pound + currency'),
  register = 'neutral',
  variety = 'UK/international'
WHERE headword = 'pound' AND cefr_receptive = 'A1';

-- poverty
UPDATE lexicon_entries SET
  ipa = '/ˈpɒvərti/',
  definition_simple = 'the state of being very poor',
  definition_teacher = 'Noun meaning extreme lack of money or resources. In business, relevant for CSR and social impact discussions.',
  usage_notes = 'Uncountable noun. Important in discussions about corporate social responsibility and social impact.',
  examples = jsonb_build_array(
    'The company supports programs to reduce poverty.',
    'Poverty alleviation is part of our CSR strategy.',
    'Economic growth helps lift people out of poverty.',
    'We partner with organizations fighting poverty.'
  ),
  collocations = jsonb_build_array('reduce poverty', 'poverty alleviation', 'fight poverty', 'extreme poverty'),
  patterns = jsonb_build_array('reduce/fight + poverty', 'poverty + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'poverty' AND cefr_receptive = 'A1';

-- power
UPDATE lexicon_entries SET
  ipa = '/ˈpaʊər/',
  definition_simple = 'the ability to control or influence, or energy',
  definition_teacher = 'Noun meaning authority, energy, or capability. Essential in business for discussing influence, energy, and capabilities.',
  usage_notes = 'Multiple meanings: authority, energy, or capability. Very common in business contexts.',
  examples = jsonb_build_array(
    'The CEO has the power to make final decisions.',
    'We need backup power for the data center.',
    'Knowledge is power in negotiations.',
    'The company is a major power in the industry.'
  ),
  collocations = jsonb_build_array('purchasing power', 'power supply', 'in power', 'power to'),
  patterns = jsonb_build_array('power to + infinitive', 'power over + noun', 'in power'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'power' AND cefr_receptive = 'A1';

-- practical
UPDATE lexicon_entries SET
  ipa = '/ˈpræktɪkəl/',
  definition_simple = 'relating to real situations and actions rather than ideas',
  definition_teacher = 'Adjective meaning useful, realistic, or applied. Common in business for discussing feasible solutions.',
  usage_notes = 'Emphasizes usefulness and real-world application. Opposite of "theoretical".',
  examples = jsonb_build_array(
    'We need practical solutions, not just theories.',
    'She has practical experience in project management.',
    'Let''s take a practical approach to this problem.',
    'The training provides practical skills for the workplace.'
  ),
  collocations = jsonb_build_array('practical experience', 'practical solution', 'practical approach', 'practical skills'),
  patterns = jsonb_build_array('practical + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'practical' AND cefr_receptive = 'A1';

-- prepare
UPDATE lexicon_entries SET
  ipa = '/prɪˈper/',
  definition_simple = 'to make ready for something',
  definition_teacher = 'Verb meaning to get ready or make arrangements. Essential in business for planning and readiness.',
  usage_notes = 'Very common in business. Can be followed by "for" + noun or "to" + infinitive.',
  examples = jsonb_build_array(
    'Please prepare the presentation for tomorrow''s meeting.',
    'We need to prepare for the audit next month.',
    'The team is preparing to launch the new product.',
    'Proper preparation prevents poor performance.'
  ),
  collocations = jsonb_build_array('prepare for', 'prepare to', 'well prepared', 'prepare a report'),
  patterns = jsonb_build_array('prepare + noun', 'prepare for + noun', 'prepare to + infinitive'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'prepare' AND cefr_receptive = 'A1';

-- present
UPDATE lexicon_entries SET
  ipa = '/ˈprezənt/',
  definition_simple = 'existing or happening now, or to give or show something',
  definition_teacher = 'Adjective meaning current, or verb /prɪˈzent/ meaning to show or give. Essential in business presentations.',
  usage_notes = 'Multiple meanings and pronunciations. As adjective: current. As verb: to show or deliver.',
  examples = jsonb_build_array(
    'All team members must be present at the meeting.',
    'She will present the quarterly results tomorrow.',
    'The present situation requires immediate action.',
    'Let me present our proposal to the board.'
  ),
  collocations = jsonb_build_array('be present', 'present a proposal', 'present situation', 'present results'),
  patterns = jsonb_build_array('be present at + noun', 'present + noun + to + person'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'present' AND cefr_receptive = 'A1';

-- preserve
UPDATE lexicon_entries SET
  ipa = '/prɪˈzɜːrv/',
  definition_simple = 'to keep something in its original state or good condition',
  definition_teacher = 'Verb meaning to maintain or protect. In business, used for preserving assets, relationships, or reputation.',
  usage_notes = 'Formal verb. Common in business for discussing protection of assets, reputation, or relationships.',
  examples = jsonb_build_array(
    'We must preserve our company''s reputation.',
    'The archive preserves important historical documents.',
    'It''s important to preserve good client relationships.',
    'These measures will help preserve our market position.'
  ),
  collocations = jsonb_build_array('preserve reputation', 'preserve relationships', 'preserve assets', 'preserve quality'),
  patterns = jsonb_build_array('preserve + noun'),
  register = 'formal',
  variety = 'international'
WHERE headword = 'preserve' AND cefr_receptive = 'A1';

-- press
UPDATE lexicon_entries SET
  ipa = '/pres/',
  definition_simple = 'to push firmly, or newspapers and journalists',
  definition_teacher = 'Verb meaning to push, or noun meaning media/journalists. Common in business for press releases and media relations.',
  usage_notes = 'Multiple meanings: to push (verb) or media (noun). "The press" refers to news media.',
  examples = jsonb_build_array(
    'Press the button to start the system.',
    'We issued a press release about the merger.',
    'The press covered the product launch extensively.',
    'Time is pressing - we need to decide quickly.'
  ),
  collocations = jsonb_build_array('press release', 'press conference', 'the press', 'press for'),
  patterns = jsonb_build_array('press + noun', 'press release', 'press for + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'press' AND cefr_receptive = 'A1';

-- pretty
UPDATE lexicon_entries SET
  ipa = '/ˈprɪti/',
  definition_simple = 'attractive, or fairly/quite (informal)',
  definition_teacher = 'Adjective meaning attractive, or adverb meaning fairly. As adverb, common in informal business speech.',
  usage_notes = 'As adjective: attractive. As adverb (informal): fairly, quite. The adverb use is common in spoken business English.',
  examples = jsonb_build_array(
    'The results are pretty good this quarter.',
    'We''re pretty confident about the outcome.',
    'The office has a pretty modern design.',
    'That''s a pretty significant achievement.'
  ),
  collocations = jsonb_build_array('pretty good', 'pretty much', 'pretty sure', 'pretty well'),
  patterns = jsonb_build_array('pretty + adjective', 'pretty much'),
  register = 'informal',
  variety = 'international'
WHERE headword = 'pretty' AND cefr_receptive = 'A1';

-- prevent
UPDATE lexicon_entries SET
  ipa = '/prɪˈvent/',
  definition_simple = 'to stop something from happening',
  definition_teacher = 'Verb meaning to stop or hinder. Essential in business for discussing risk management and problem prevention.',
  usage_notes = 'Common in business contexts. Usually followed by "from" + gerund or direct object.',
  examples = jsonb_build_array(
    'We need to prevent errors before they occur.',
    'Security measures prevent unauthorized access.',
    'Good planning prevents project delays.',
    'This policy prevents conflicts of interest.'
  ),
  collocations = jsonb_build_array('prevent errors', 'prevent problems', 'prevent from', 'prevent access'),
  patterns = jsonb_build_array('prevent + noun', 'prevent + person/thing + from + gerund'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'prevent' AND cefr_receptive = 'A1';

-- price
UPDATE lexicon_entries SET
  ipa = '/praɪs/',
  definition_simple = 'the amount of money needed to buy something',
  definition_teacher = 'Noun meaning cost or value. Essential in business for pricing, sales, and financial discussions.',
  usage_notes = 'Very common in business. Can be countable (prices) or uncountable (price in general).',
  examples = jsonb_build_array(
    'The price includes shipping and handling.',
    'We offer competitive prices for bulk orders.',
    'Price is a key factor in purchasing decisions.',
    'The market price fluctuates daily.'
  ),
  collocations = jsonb_build_array('competitive price', 'market price', 'price point', 'at a price'),
  patterns = jsonb_build_array('at a price', 'price of + noun', 'price + verb'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'price' AND cefr_receptive = 'A1';

-- print
UPDATE lexicon_entries SET
  ipa = '/prɪnt/',
  definition_simple = 'to produce text or images on paper using a machine',
  definition_teacher = 'Verb or noun meaning to produce printed material. Common in business for documents and publications.',
  usage_notes = 'Can be verb (print a document) or noun (in print). Still relevant despite digital transformation.',
  examples = jsonb_build_array(
    'Please print two copies of the contract.',
    'The report will be available in print and digital formats.',
    'We need to print business cards for the new employees.',
    'The article appeared in print last month.'
  ),
  collocations = jsonb_build_array('print a document', 'in print', 'print out', 'print version'),
  patterns = jsonb_build_array('print + noun', 'in print', 'print out + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'print' AND cefr_receptive = 'A1';

-- private
UPDATE lexicon_entries SET
  ipa = '/ˈpraɪvət/',
  definition_simple = 'belonging to or for one person or group, not public',
  definition_teacher = 'Adjective meaning personal, confidential, or non-public. Essential in business for privacy and ownership discussions.',
  usage_notes = 'Opposite of "public". Common in business for private companies, private information, private sector.',
  examples = jsonb_build_array(
    'This is a private company, not publicly traded.',
    'Please keep this information private and confidential.',
    'The meeting will be held in a private conference room.',
    'She works in the private sector.'
  ),
  collocations = jsonb_build_array('private company', 'private sector', 'private information', 'keep private'),
  patterns = jsonb_build_array('private + noun', 'keep + noun + private'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'private' AND cefr_receptive = 'A1';

-- produce
UPDATE lexicon_entries SET
  ipa = '/prəˈdjuːs/',
  definition_simple = 'to make or create something',
  definition_teacher = 'Verb meaning to manufacture or create. Essential in business for production, manufacturing, and output.',
  usage_notes = 'Very common in business. Can mean manufacture, create, or generate. Related: product, production, producer.',
  examples = jsonb_build_array(
    'The factory produces 10,000 units per day.',
    'We need to produce better results next quarter.',
    'The team produced an excellent report.',
    'This process produces high-quality output.'
  ),
  collocations = jsonb_build_array('produce results', 'produce goods', 'produce a report', 'mass produce'),
  patterns = jsonb_build_array('produce + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'produce' AND cefr_receptive = 'A1';

-- product
UPDATE lexicon_entries SET
  ipa = '/ˈprɒdʌkt/',
  definition_simple = 'something that is made or grown to be sold',
  definition_teacher = 'Noun meaning an item for sale or the result of a process. Essential in business for products and services.',
  usage_notes = 'Very common in business. Can be physical goods or the result of work. Related: produce, production.',
  examples = jsonb_build_array(
    'Our flagship product has won several awards.',
    'Product quality is our top priority.',
    'We are launching three new products this year.',
    'The product line includes software and hardware.'
  ),
  collocations = jsonb_build_array('new product', 'product quality', 'product line', 'flagship product'),
  patterns = jsonb_build_array('product + noun', 'adjective + product'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'product' AND cefr_receptive = 'A1';

-- production
UPDATE lexicon_entries SET
  ipa = '/prəˈdʌkʃən/',
  definition_simple = 'the process of making or growing things',
  definition_teacher = 'Noun meaning manufacturing or creation process. Essential in business for operations and manufacturing.',
  usage_notes = 'Uncountable noun. Very common in business for manufacturing, output, and creation processes.',
  examples = jsonb_build_array(
    'Production has increased by 20% this year.',
    'We are moving production to a new facility.',
    'The production process needs optimization.',
    'Production costs have decreased significantly.'
  ),
  collocations = jsonb_build_array('production process', 'production costs', 'mass production', 'in production'),
  patterns = jsonb_build_array('production + noun', 'in production'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'production' AND cefr_receptive = 'A1';

-- program
UPDATE lexicon_entries SET
  ipa = '/ˈprəʊɡræm/',
  definition_simple = 'a planned series of activities or a computer software',
  definition_teacher = 'Noun meaning a plan, software, or series of activities. Essential in business for programs and initiatives.',
  usage_notes = 'US spelling. Multiple meanings: training program, software program, or planned activities.',
  examples = jsonb_build_array(
    'We offer a comprehensive training program for new hires.',
    'The software program needs an update.',
    'Our mentorship program has been very successful.',
    'The loyalty program rewards frequent customers.'
  ),
  collocations = jsonb_build_array('training program', 'software program', 'loyalty program', 'pilot program'),
  patterns = jsonb_build_array('noun + program', 'program for + noun'),
  register = 'neutral',
  variety = 'US/international'
WHERE headword = 'program' AND cefr_receptive = 'A1';

-- programme
UPDATE lexicon_entries SET
  ipa = '/ˈprəʊɡræm/',
  definition_simple = 'a planned series of activities (British spelling)',
  definition_teacher = 'Noun meaning a plan or series of activities. British spelling of "program".',
  usage_notes = 'British spelling. Same meaning as "program" but typically not used for computer software in UK.',
  examples = jsonb_build_array(
    'The development programme runs for six months.',
    'We have a comprehensive wellness programme.',
    'The programme includes workshops and seminars.',
    'Our graduate programme attracts top talent.'
  ),
  collocations = jsonb_build_array('training programme', 'development programme', 'graduate programme', 'wellness programme'),
  patterns = jsonb_build_array('noun + programme', 'programme for + noun'),
  register = 'neutral',
  variety = 'UK'
WHERE headword = 'programme' AND cefr_receptive = 'A1';

-- progress
UPDATE lexicon_entries SET
  ipa = '/ˈprəʊɡres/',
  definition_simple = 'forward movement towards a goal or improvement',
  definition_teacher = 'Noun or verb meaning advancement or development. Essential in business for tracking project and performance progress.',
  usage_notes = 'As noun: /ˈprəʊɡres/. As verb: /prəˈɡres/. Very common in business for progress reports and updates.',
  examples = jsonb_build_array(
    'The project is making good progress.',
    'We need to track progress against our goals.',
    'Please provide a progress report by Friday.',
    'The team has progressed significantly this quarter.'
  ),
  collocations = jsonb_build_array('make progress', 'progress report', 'in progress', 'track progress'),
  patterns = jsonb_build_array('make progress', 'progress towards + noun', 'in progress'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'progress' AND cefr_receptive = 'A1';

-- promise
UPDATE lexicon_entries SET
  ipa = '/ˈprɒmɪs/',
  definition_simple = 'to say you will definitely do something',
  definition_teacher = 'Verb or noun meaning commitment or assurance. Common in business for commitments and guarantees.',
  usage_notes = 'Can be verb (promise to do) or noun (make a promise). Important for commitments and reliability.',
  examples = jsonb_build_array(
    'We promise to deliver on time.',
    'The company made a promise to improve quality.',
    'This technology shows great promise.',
    'I promise to review your proposal by tomorrow.'
  ),
  collocations = jsonb_build_array('make a promise', 'keep a promise', 'promise to', 'show promise'),
  patterns = jsonb_build_array('promise + to infinitive', 'make/keep a promise', 'show promise'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'promise' AND cefr_receptive = 'A1';

-- proof
UPDATE lexicon_entries SET
  ipa = '/pruːf/',
  definition_simple = 'evidence that shows something is true',
  definition_teacher = 'Noun meaning evidence or verification. Essential in business for documentation and verification.',
  usage_notes = 'Uncountable noun. Common in business for proof of concept, proof of purchase, burden of proof.',
  examples = jsonb_build_array(
    'Please provide proof of purchase for the warranty.',
    'We need proof of concept before full investment.',
    'The data provides proof of our hypothesis.',
    'Do you have proof that the payment was made?'
  ),
  collocations = jsonb_build_array('proof of purchase', 'proof of concept', 'burden of proof', 'living proof'),
  patterns = jsonb_build_array('proof of + noun', 'proof that + clause'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'proof' AND cefr_receptive = 'A1';

-- proper
UPDATE lexicon_entries SET
  ipa = '/ˈprɒpər/',
  definition_simple = 'correct, suitable, or appropriate',
  definition_teacher = 'Adjective meaning correct, appropriate, or suitable. Common in business for proper procedures and protocols.',
  usage_notes = 'Emphasizes correctness and appropriateness. Common in business for procedures, protocols, and standards.',
  examples = jsonb_build_array(
    'Please follow the proper procedures for expense reports.',
    'Proper planning prevents poor performance.',
    'We need proper documentation for the audit.',
    'Is this the proper way to format the report?'
  ),
  collocations = jsonb_build_array('proper procedures', 'proper planning', 'proper documentation', 'proper way'),
  patterns = jsonb_build_array('proper + noun', 'the proper way to + infinitive'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'proper' AND cefr_receptive = 'A1';

-- propose
UPDATE lexicon_entries SET
  ipa = '/prəˈpəʊz/',
  definition_simple = 'to suggest a plan or idea',
  definition_teacher = 'Verb meaning to suggest or put forward. Essential in business for proposals and suggestions.',
  usage_notes = 'Formal verb. Common in business for making proposals, suggestions, or recommendations.',
  examples = jsonb_build_array(
    'I propose that we meet weekly to review progress.',
    'The committee proposed several changes to the policy.',
    'We propose a new approach to customer service.',
    'She proposed an innovative solution to the problem.'
  ),
  collocations = jsonb_build_array('propose a solution', 'propose changes', 'propose that', 'propose to'),
  patterns = jsonb_build_array('propose + noun', 'propose that + clause', 'propose + to infinitive'),
  register = 'formal',
  variety = 'international'
WHERE headword = 'propose' AND cefr_receptive = 'A1';

-- protect
UPDATE lexicon_entries SET
  ipa = '/prəˈtekt/',
  definition_simple = 'to keep safe from harm or danger',
  definition_teacher = 'Verb meaning to safeguard or defend. Essential in business for security, legal protection, and risk management.',
  usage_notes = 'Very common in business. Used for protecting assets, data, rights, and interests.',
  examples = jsonb_build_array(
    'We must protect customer data and privacy.',
    'Insurance protects the company against losses.',
    'Patents protect intellectual property rights.',
    'Security measures protect against cyber attacks.'
  ),
  collocations = jsonb_build_array('protect data', 'protect against', 'protect rights', 'protect interests'),
  patterns = jsonb_build_array('protect + noun', 'protect against + noun', 'protect + noun + from + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'protect' AND cefr_receptive = 'A1';

-- prove
UPDATE lexicon_entries SET
  ipa = '/pruːv/',
  definition_simple = 'to show that something is true using evidence',
  definition_teacher = 'Verb meaning to demonstrate or verify. Common in business for proving concepts, capabilities, or claims.',
  usage_notes = 'Can be followed by noun or "that" clause. Important for validation and verification in business.',
  examples = jsonb_build_array(
    'The pilot project proved the concept works.',
    'We need to prove our value to potential clients.',
    'The data proves that our strategy is effective.',
    'She proved herself to be an excellent manager.'
  ),
  collocations = jsonb_build_array('prove a point', 'prove yourself', 'prove that', 'prove to be'),
  patterns = jsonb_build_array('prove + noun', 'prove that + clause', 'prove + to be + adjective'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'prove' AND cefr_receptive = 'A1';

-- provide
UPDATE lexicon_entries SET
  ipa = '/prəˈvaɪd/',
  definition_simple = 'to give or supply something that is needed',
  definition_teacher = 'Verb meaning to supply or furnish. Essential in business for discussing services, resources, and support.',
  usage_notes = 'Very common in business. Can be followed by direct object or "with". Related: provider, provision.',
  examples = jsonb_build_array(
    'We provide comprehensive training for all employees.',
    'The company provides health insurance benefits.',
    'Please provide the requested documents by Friday.',
    'Our service provides 24/7 customer support.'
  ),
  collocations = jsonb_build_array('provide services', 'provide support', 'provide information', 'provide with'),
  patterns = jsonb_build_array('provide + noun', 'provide + person + with + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'provide' AND cefr_receptive = 'A1';

-- public
UPDATE lexicon_entries SET
  ipa = '/ˈpʌblɪk/',
  definition_simple = 'relating to all people, not private',
  definition_teacher = 'Adjective or noun meaning open to all or the general population. Essential in business for public companies and relations.',
  usage_notes = 'Opposite of "private". Common in business for public companies, public relations, public sector.',
  examples = jsonb_build_array(
    'The company went public last year.',
    'We need to improve our public image.',
    'Public opinion influences our marketing strategy.',
    'The announcement will be made public tomorrow.'
  ),
  collocations = jsonb_build_array('go public', 'public company', 'public relations', 'general public'),
  patterns = jsonb_build_array('go public', 'public + noun', 'make + noun + public'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'public' AND cefr_receptive = 'A1';

-- pull
UPDATE lexicon_entries SET
  ipa = '/pʊl/',
  definition_simple = 'to move something towards you using force',
  definition_teacher = 'Verb meaning to draw or attract. In business, used literally and in phrases like "pull together" or "pull off".',
  usage_notes = 'Opposite of "push". Common in business idioms: pull together, pull off, pull out.',
  examples = jsonb_build_array(
    'We need to pull together as a team.',
    'The campaign pulled in new customers.',
    'Can we pull off this project in time?',
    'The company decided to pull out of that market.'
  ),
  collocations = jsonb_build_array('pull together', 'pull off', 'pull out', 'pull in'),
  patterns = jsonb_build_array('pull + noun', 'pull together', 'pull off + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'pull' AND cefr_receptive = 'A1';

-- purpose
UPDATE lexicon_entries SET
  ipa = '/ˈpɜːrpəs/',
  definition_simple = 'the reason for doing something or why something exists',
  definition_teacher = 'Noun meaning intention, goal, or function. Essential in business for discussing objectives and intentions.',
  usage_notes = 'Common in business for discussing goals, intentions, and reasons. Often used in "on purpose" or "for the purpose of".',
  examples = jsonb_build_array(
    'The purpose of this meeting is to review progress.',
    'What is the purpose of this new policy?',
    'We need a clear sense of purpose.',
    'The tool serves multiple purposes.'
  ),
  collocations = jsonb_build_array('on purpose', 'for the purpose of', 'sense of purpose', 'serve a purpose'),
  patterns = jsonb_build_array('purpose of + noun', 'for the purpose of + gerund', 'on purpose'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'purpose' AND cefr_receptive = 'A1';

-- put
UPDATE lexicon_entries SET
  ipa = '/pʊt/',
  definition_simple = 'to move something to a place or position',
  definition_teacher = 'Verb meaning to place or position. Very common in business, used in many phrasal verbs and expressions.',
  usage_notes = 'Extremely versatile verb. Irregular: put, put, put. Used in many business phrases and phrasal verbs.',
  examples = jsonb_build_array(
    'Please put the report on my desk.',
    'We need to put this plan into action.',
    'Let me put it another way.',
    'The company put a lot of effort into the project.'
  ),
  collocations = jsonb_build_array('put into action', 'put effort into', 'put forward', 'put together'),
  patterns = jsonb_build_array('put + noun + preposition + place', 'put + noun + into + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'put' AND cefr_receptive = 'A1';

-- quality
UPDATE lexicon_entries SET
  ipa = '/ˈkwɒləti/',
  definition_simple = 'how good or bad something is',
  definition_teacher = 'Noun meaning standard or characteristic. Essential in business for quality control, quality assurance.',
  usage_notes = 'Can be countable (qualities = characteristics) or uncountable (quality = standard). Very common in business.',
  examples = jsonb_build_array(
    'Quality is our top priority.',
    'We maintain high quality standards.',
    'The product has excellent quality.',
    'Quality control ensures consistency.'
  ),
  collocations = jsonb_build_array('high quality', 'quality control', 'quality assurance', 'quality standards'),
  patterns = jsonb_build_array('quality + noun', 'adjective + quality', 'quality of + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'quality' AND cefr_receptive = 'A1';

-- quarter
UPDATE lexicon_entries SET
  ipa = '/ˈkwɔːrtər/',
  definition_simple = 'one of four equal parts, or a three-month period',
  definition_teacher = 'Noun meaning one-fourth or a business quarter. Essential in business for quarterly reports and financial periods.',
  usage_notes = 'Multiple meanings: fraction (1/4), business period (3 months), or area. Very common in business finance.',
  examples = jsonb_build_array(
    'Sales increased by 15% this quarter.',
    'We report earnings every quarter.',
    'The first quarter results exceeded expectations.',
    'A quarter of our revenue comes from exports.'
  ),
  collocations = jsonb_build_array('this quarter', 'quarterly report', 'first quarter', 'quarter of'),
  patterns = jsonb_build_array('this/next/last quarter', 'a quarter of + noun', 'quarterly + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'quarter' AND cefr_receptive = 'A1';

-- quiet
UPDATE lexicon_entries SET
  ipa = '/ˈkwaɪət/',
  definition_simple = 'making little or no noise',
  definition_teacher = 'Adjective meaning silent or calm. In business, used for quiet periods, quiet confidence, or keeping things quiet.',
  usage_notes = 'Can describe sound level, activity level, or discretion. Common in business contexts.',
  examples = jsonb_build_array(
    'Please keep this information quiet until the announcement.',
    'Business is quiet during the holiday season.',
    'We need a quiet space for the conference call.',
    'She has a quiet confidence that inspires trust.'
  ),
  collocations = jsonb_build_array('keep quiet', 'quiet period', 'quiet confidence', 'quiet time'),
  patterns = jsonb_build_array('keep + noun + quiet', 'quiet + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'quiet' AND cefr_receptive = 'A1';

-- quite
UPDATE lexicon_entries SET
  ipa = '/kwaɪt/',
  definition_simple = 'completely, or to a large degree',
  definition_teacher = 'Adverb meaning completely or fairly. Common in business for emphasis or moderation.',
  usage_notes = 'Can mean "completely" (quite right) or "fairly" (quite good). Meaning depends on context.',
  examples = jsonb_build_array(
    'The results are quite impressive.',
    'I''m not quite sure about that approach.',
    'That''s quite a significant achievement.',
    'The project is quite complex.'
  ),
  collocations = jsonb_build_array('quite good', 'quite sure', 'quite a', 'not quite'),
  patterns = jsonb_build_array('quite + adjective', 'quite a + noun', 'not quite'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'quite' AND cefr_receptive = 'A1';

-- race
UPDATE lexicon_entries SET
  ipa = '/reɪs/',
  definition_simple = 'a competition of speed, or to move very fast',
  definition_teacher = 'Noun or verb meaning competition or rapid movement. In business, used for competitive situations and urgency.',
  usage_notes = 'Can be literal (running race) or figurative (race against time, race to market).',
  examples = jsonb_build_array(
    'We are in a race to launch before competitors.',
    'It''s a race against time to meet the deadline.',
    'The company is racing to complete the project.',
    'The race for market share is intensifying.'
  ),
  collocations = jsonb_build_array('race against time', 'race to market', 'race for', 'rat race'),
  patterns = jsonb_build_array('race against + noun', 'race to + infinitive', 'race for + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'race' AND cefr_receptive = 'A1';

-- raise
UPDATE lexicon_entries SET
  ipa = '/reɪz/',
  definition_simple = 'to lift something up, or to increase',
  definition_teacher = 'Verb meaning to lift, increase, or bring up. Essential in business for raising funds, issues, or salaries.',
  usage_notes = 'Very common in business. Can mean lift physically, increase amount, or bring up a topic.',
  examples = jsonb_build_array(
    'We need to raise capital for expansion.',
    'Please raise any concerns during the meeting.',
    'The company raised salaries by 5% this year.',
    'She raised an important point about the budget.'
  ),
  collocations = jsonb_build_array('raise capital', 'raise concerns', 'raise awareness', 'raise a question'),
  patterns = jsonb_build_array('raise + noun', 'raise + noun + by + amount'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'raise' AND cefr_receptive = 'A1';

-- rank
UPDATE lexicon_entries SET
  ipa = '/ræŋk/',
  definition_simple = 'a position in a scale or order',
  definition_teacher = 'Noun or verb meaning position or to order. Common in business for rankings, hierarchy, and performance.',
  usage_notes = 'Can be noun (a rank) or verb (to rank). Common in business for rankings and hierarchies.',
  examples = jsonb_build_array(
    'The company ranks among the top 10 in the industry.',
    'She holds a senior rank in the organization.',
    'How do we rank compared to competitors?',
    'Employee satisfaction ranks high on our priorities.'
  ),
  collocations = jsonb_build_array('rank among', 'senior rank', 'rank high', 'rank and file'),
  patterns = jsonb_build_array('rank + among/as + noun', 'rank + adverb', 'hold a rank'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'rank' AND cefr_receptive = 'A1';

-- rate
UPDATE lexicon_entries SET
  ipa = '/reɪt/',
  definition_simple = 'a measure or speed of something, or to judge the value',
  definition_teacher = 'Noun or verb meaning speed, price, or evaluation. Essential in business for rates, ratings, and measurements.',
  usage_notes = 'Very common in business. Can mean speed (growth rate), price (interest rate), or evaluation (rating).',
  examples = jsonb_build_array(
    'The interest rate is 5% per year.',
    'Our growth rate exceeded expectations.',
    'How would you rate our customer service?',
    'The success rate for this program is 85%.'
  ),
  collocations = jsonb_build_array('interest rate', 'growth rate', 'success rate', 'at this rate'),
  patterns = jsonb_build_array('noun + rate', 'rate + of + noun', 'at this/that rate'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'rate' AND cefr_receptive = 'A1';

-- rather
UPDATE lexicon_entries SET
  ipa = '/ˈrɑːðər/',
  definition_simple = 'to a certain degree, or preferably',
  definition_teacher = 'Adverb meaning somewhat, preferably, or instead. Common in business for expressing preferences and corrections.',
  usage_notes = 'Multiple uses: preference (rather than), degree (rather good), or correction (or rather).',
  examples = jsonb_build_array(
    'I would rather meet in person than by video.',
    'The results are rather disappointing.',
    'We should focus on quality rather than quantity.',
    'The project is challenging, or rather, very complex.'
  ),
  collocations = jsonb_build_array('rather than', 'would rather', 'or rather', 'rather good'),
  patterns = jsonb_build_array('rather than + noun/gerund', 'would rather + infinitive', 'rather + adjective'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'rather' AND cefr_receptive = 'A1';

-- reach
UPDATE lexicon_entries SET
  ipa = '/riːtʃ/',
  definition_simple = 'to arrive at a place or achieve something',
  definition_teacher = 'Verb meaning to arrive, achieve, or contact. Essential in business for reaching goals, agreements, or audiences.',
  usage_notes = 'Very common in business. Can mean physical arrival, achievement, or making contact.',
  examples = jsonb_build_array(
    'We reached our sales target ahead of schedule.',
    'The parties reached an agreement yesterday.',
    'How can we reach our target audience?',
    'Please reach out if you have any questions.'
  ),
  collocations = jsonb_build_array('reach a goal', 'reach an agreement', 'reach out', 'reach a decision'),
  patterns = jsonb_build_array('reach + noun', 'reach out to + person'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'reach' AND cefr_receptive = 'A1';

-- real
UPDATE lexicon_entries SET
  ipa = '/riːəl/',
  definition_simple = 'actually existing, not imagined or fake',
  definition_teacher = 'Adjective meaning genuine, actual, or authentic. Common in business for emphasizing authenticity and reality.',
  usage_notes = 'Can mean "genuine" (real leather), "actual" (real cost), or "significant" (real problem).',
  examples = jsonb_build_array(
    'What is the real cost of this project?',
    'We need to address the real issues.',
    'This represents a real opportunity for growth.',
    'The real challenge is implementation.'
  ),
  collocations = jsonb_build_array('real cost', 'real issue', 'real opportunity', 'real challenge'),
  patterns = jsonb_build_array('the real + noun', 'real + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'real' AND cefr_receptive = 'A1';

-- receive
UPDATE lexicon_entries SET
  ipa = '/rɪˈsiːv/',
  definition_simple = 'to get or be given something',
  definition_teacher = 'Verb meaning to get or accept. Essential in business for receiving payments, communications, or deliveries.',
  usage_notes = 'More formal than "get". Very common in business correspondence and transactions.',
  examples = jsonb_build_array(
    'We received your application yesterday.',
    'The client received the shipment on time.',
    'Did you receive my email about the meeting?',
    'Employees receive annual performance reviews.'
  ),
  collocations = jsonb_build_array('receive payment', 'receive an email', 'receive feedback', 'receive approval'),
  patterns = jsonb_build_array('receive + noun', 'receive + noun + from + person'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'receive' AND cefr_receptive = 'A1';

-- recent
UPDATE lexicon_entries SET
  ipa = '/ˈriːsənt/',
  definition_simple = 'happening or starting a short time ago',
  definition_teacher = 'Adjective meaning new or from the near past. Common in business for discussing recent developments or changes.',
  usage_notes = 'Used to describe things from the near past. Related: recently (adverb).',
  examples = jsonb_build_array(
    'Recent changes have improved efficiency.',
    'The recent report shows positive trends.',
    'In recent years, we have expanded globally.',
    'Recent developments require us to adapt our strategy.'
  ),
  collocations = jsonb_build_array('recent changes', 'recent years', 'recent developments', 'in recent'),
  patterns = jsonb_build_array('recent + noun', 'in recent + time period'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'recent' AND cefr_receptive = 'A1';

-- recognize
UPDATE lexicon_entries SET
  ipa = '/ˈrekəɡnaɪz/',
  definition_simple = 'to know someone or something because you have seen them before',
  definition_teacher = 'Verb meaning to identify, acknowledge, or accept. Common in business for recognition and acknowledgment.',
  usage_notes = 'Can mean "identify" (recognize a person), "acknowledge" (recognize achievement), or "accept" (recognize authority).',
  examples = jsonb_build_array(
    'We recognize the need for change.',
    'The company recognizes employee achievements.',
    'I recognize that this is a challenging situation.',
    'The industry recognizes her as an expert.'
  ),
  collocations = jsonb_build_array('recognize the need', 'recognize achievement', 'recognize that', 'recognize as'),
  patterns = jsonb_build_array('recognize + noun', 'recognize that + clause', 'recognize + person + as + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'recognize' AND cefr_receptive = 'A1';

-- record
UPDATE lexicon_entries SET
  ipa = '/ˈrekɔːrd/',
  definition_simple = 'information kept about something, or the best achievement',
  definition_teacher = 'Noun or verb meaning documentation or to document. Essential in business for record-keeping and achievements.',
  usage_notes = 'As noun: /ˈrekɔːrd/. As verb: /rɪˈkɔːrd/. Very common in business for records and documentation.',
  examples = jsonb_build_array(
    'Please keep a record of all expenses.',
    'The company achieved record profits this year.',
    'We need to record the meeting minutes.',
    'Our track record speaks for itself.'
  ),
  collocations = jsonb_build_array('keep a record', 'track record', 'record profits', 'on record'),
  patterns = jsonb_build_array('keep/maintain a record', 'record + noun', 'on record'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'record' AND cefr_receptive = 'A1';

-- reduce
UPDATE lexicon_entries SET
  ipa = '/rɪˈdjuːs/',
  definition_simple = 'to make something smaller or less',
  definition_teacher = 'Verb meaning to decrease or diminish. Essential in business for cost reduction, efficiency, and optimization.',
  usage_notes = 'Very common in business. Opposite of "increase". Related: reduction (noun).',
  examples = jsonb_build_array(
    'We need to reduce costs by 10%.',
    'The new process reduces production time.',
    'Automation can reduce errors significantly.',
    'The company reduced its workforce last year.'
  ),
  collocations = jsonb_build_array('reduce costs', 'reduce time', 'reduce errors', 'reduce by'),
  patterns = jsonb_build_array('reduce + noun', 'reduce + noun + by + amount'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'reduce' AND cefr_receptive = 'A1';

-- refuse
UPDATE lexicon_entries SET
  ipa = '/rɪˈfjuːz/',
  definition_simple = 'to say you will not do or accept something',
  definition_teacher = 'Verb meaning to decline or reject. Common in business for refusing offers, requests, or proposals.',
  usage_notes = 'Can be followed by "to" + infinitive or direct object. More direct than "decline".',
  examples = jsonb_build_array(
    'The client refused our initial proposal.',
    'We cannot refuse such a generous offer.',
    'She refused to compromise on quality.',
    'The board refused to approve the budget.'
  ),
  collocations = jsonb_build_array('refuse to', 'refuse an offer', 'refuse a request', 'refuse permission'),
  patterns = jsonb_build_array('refuse + to infinitive', 'refuse + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'refuse' AND cefr_receptive = 'A1';

-- regard
UPDATE lexicon_entries SET
  ipa = '/rɪˈɡɑːrd/',
  definition_simple = 'to think of someone or something in a particular way',
  definition_teacher = 'Verb or noun meaning to consider or respect. Common in business phrases like "with regard to" or "highly regarded".',
  usage_notes = 'Formal. Common in phrases: "with regard to", "in this regard", "highly regarded".',
  examples = jsonb_build_array(
    'We regard customer satisfaction as our priority.',
    'With regard to your question, here is our response.',
    'She is highly regarded in the industry.',
    'In this regard, we need to improve communication.'
  ),
  collocations = jsonb_build_array('with regard to', 'highly regarded', 'in this regard', 'regard as'),
  patterns = jsonb_build_array('regard + noun + as + noun', 'with regard to + noun', 'in this regard'),
  register = 'formal',
  variety = 'international'
WHERE headword = 'regard' AND cefr_receptive = 'A1';

-- regular
UPDATE lexicon_entries SET
  ipa = '/ˈreɡjələr/',
  definition_simple = 'happening or done often and at the same time',
  definition_teacher = 'Adjective meaning consistent, frequent, or standard. Common in business for regular meetings, customers, or patterns.',
  usage_notes = 'Can mean "frequent" (regular meetings), "consistent" (regular pattern), or "standard" (regular size).',
  examples = jsonb_build_array(
    'We hold regular team meetings every Monday.',
    'Regular customers receive special discounts.',
    'The company maintains regular communication with clients.',
    'Regular feedback helps improve performance.'
  ),
  collocations = jsonb_build_array('regular meetings', 'regular customers', 'regular basis', 'on a regular basis'),
  patterns = jsonb_build_array('regular + noun', 'on a regular basis'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'regular' AND cefr_receptive = 'A1';

-- relation
UPDATE lexicon_entries SET
  ipa = '/rɪˈleɪʃən/',
  definition_simple = 'the way things or people are connected',
  definition_teacher = 'Noun meaning connection or relationship. Essential in business for business relations, public relations.',
  usage_notes = 'Often plural (relations). Common in business for relationships between entities or people.',
  examples = jsonb_build_array(
    'We maintain good relations with all suppliers.',
    'Public relations is crucial for brand image.',
    'The relation between cost and quality is important.',
    'International relations affect our business.'
  ),
  collocations = jsonb_build_array('public relations', 'business relations', 'in relation to', 'good relations'),
  patterns = jsonb_build_array('noun + relations', 'in relation to + noun', 'relation between + noun + and + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'relation' AND cefr_receptive = 'A1';

-- religion
UPDATE lexicon_entries SET
  ipa = '/rɪˈlɪdʒən/',
  definition_simple = 'belief in and worship of a god or gods',
  definition_teacher = 'Noun meaning faith or belief system. In business, relevant for diversity, inclusion, and workplace policies.',
  usage_notes = 'Countable or uncountable. Important in business for diversity and inclusion policies.',
  examples = jsonb_build_array(
    'The company respects all religions and beliefs.',
    'Religious holidays are recognized in our calendar.',
    'We have a policy against religious discrimination.',
    'Diversity includes religion, culture, and background.'
  ),
  collocations = jsonb_build_array('religious beliefs', 'religious holidays', 'religious discrimination', 'respect religion'),
  patterns = jsonb_build_array('religious + noun', 'respect + religion'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'religion' AND cefr_receptive = 'A1';

-- remain
UPDATE lexicon_entries SET
  ipa = '/rɪˈmeɪn/',
  definition_simple = 'to stay in the same place or condition',
  definition_teacher = 'Verb meaning to stay or continue. Common in business for remaining competitive, committed, or unchanged.',
  usage_notes = 'Formal verb. Can mean "stay" (remain in position) or "continue to be" (remain competitive).',
  examples = jsonb_build_array(
    'We remain committed to quality.',
    'The issue remains unresolved.',
    'Only two candidates remain in consideration.',
    'The company remains profitable despite challenges.'
  ),
  collocations = jsonb_build_array('remain committed', 'remain competitive', 'remain unchanged', 'remain to be seen'),
  patterns = jsonb_build_array('remain + adjective', 'remain + to be + past participle'),
  register = 'formal',
  variety = 'international'
WHERE headword = 'remain' AND cefr_receptive = 'A1';

-- remark
UPDATE lexicon_entries SET
  ipa = '/rɪˈmɑːrk/',
  definition_simple = 'something you say, or to say something',
  definition_teacher = 'Noun or verb meaning comment or to comment. Common in business for making observations or comments.',
  usage_notes = 'Formal. Can be noun (a remark) or verb (to remark). Often used for brief comments or observations.',
  examples = jsonb_build_array(
    'She made an interesting remark about the market.',
    'The CEO remarked that growth exceeded expectations.',
    'His remarks were well received by the audience.',
    'I would like to remark on the excellent teamwork.'
  ),
  collocations = jsonb_build_array('make a remark', 'remark on', 'remark that', 'opening remarks'),
  patterns = jsonb_build_array('make a remark', 'remark on + noun', 'remark that + clause'),
  register = 'formal',
  variety = 'international'
WHERE headword = 'remark' AND cefr_receptive = 'A1';

-- remember
UPDATE lexicon_entries SET
  ipa = '/rɪˈmembər/',
  definition_simple = 'to keep something in your mind or bring it back to mind',
  definition_teacher = 'Verb meaning to recall or not forget. Essential in business for reminders and recollection.',
  usage_notes = 'Can be followed by noun, gerund (remember doing), or infinitive (remember to do). Meaning changes with form.',
  examples = jsonb_build_array(
    'Please remember to submit your timesheet.',
    'I remember discussing this in the last meeting.',
    'Remember that the deadline is Friday.',
    'Do you remember the client''s name?'
  ),
  collocations = jsonb_build_array('remember to', 'remember that', 'remember doing', 'always remember'),
  patterns = jsonb_build_array('remember + to infinitive', 'remember + gerund', 'remember that + clause'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'remember' AND cefr_receptive = 'A1';

-- repeat
UPDATE lexicon_entries SET
  ipa = '/rɪˈpiːt/',
  definition_simple = 'to say or do something again',
  definition_teacher = 'Verb or noun meaning to do again or repetition. Common in business for repeating processes or information.',
  usage_notes = 'Can be verb (repeat the process) or noun (a repeat). Common in business contexts.',
  examples = jsonb_build_array(
    'Could you please repeat that information?',
    'We need to avoid repeating past mistakes.',
    'The success was difficult to repeat.',
    'Repeat customers are valuable to our business.'
  ),
  collocations = jsonb_build_array('repeat customer', 'repeat the process', 'repeat business', 'repeat after'),
  patterns = jsonb_build_array('repeat + noun', 'repeat + that clause', 'repeat + adjective + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'repeat' AND cefr_receptive = 'A1';

-- reply
UPDATE lexicon_entries SET
  ipa = '/rɪˈplaɪ/',
  definition_simple = 'to answer or respond to something',
  definition_teacher = 'Verb or noun meaning to respond or a response. Common in business communication for replies and responses.',
  usage_notes = 'Can be verb (reply to) or noun (a reply). Similar to "respond" but slightly less formal.',
  examples = jsonb_build_array(
    'Please reply to this email by tomorrow.',
    'We are waiting for a reply from the client.',
    'She replied immediately to the inquiry.',
    'Your prompt reply would be appreciated.'
  ),
  collocations = jsonb_build_array('reply to', 'in reply to', 'prompt reply', 'await a reply'),
  patterns = jsonb_build_array('reply to + noun', 'in reply to + noun', 'reply that + clause'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'reply' AND cefr_receptive = 'A1';

-- represent
UPDATE lexicon_entries SET
  ipa = '/ˌreprɪˈzent/',
  definition_simple = 'to speak or act for someone, or to be a sign of something',
  definition_teacher = 'Verb meaning to act for, symbolize, or constitute. Essential in business for representation and symbolism.',
  usage_notes = 'Multiple meanings: act on behalf of, symbolize, or constitute. Very common in business.',
  examples = jsonb_build_array(
    'Our lawyers represent the company in negotiations.',
    'This chart represents our market share.',
    'Women represent 40% of our workforce.',
    'The logo represents our brand values.'
  ),
  collocations = jsonb_build_array('represent the company', 'represent interests', 'represent a percentage', 'represent values'),
  patterns = jsonb_build_array('represent + noun', 'represent + percentage + of + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'represent' AND cefr_receptive = 'A1';

-- respect
UPDATE lexicon_entries SET
  ipa = '/rɪˈspekt/',
  definition_simple = 'admiration for someone, or to admire someone',
  definition_teacher = 'Noun or verb meaning admiration or to admire. Essential in business for professional relationships and regard.',
  usage_notes = 'Can be noun (show respect) or verb (respect someone). Very important in professional contexts.',
  examples = jsonb_build_array(
    'We respect all employees equally.',
    'The team has great respect for her leadership.',
    'With respect to your question, here is our answer.',
    'Mutual respect is essential for collaboration.'
  ),
  collocations = jsonb_build_array('show respect', 'with respect to', 'mutual respect', 'respect for'),
  patterns = jsonb_build_array('respect + noun', 'show respect for + noun', 'with respect to + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'respect' AND cefr_receptive = 'A1';

-- rest
UPDATE lexicon_entries SET
  ipa = '/rest/',
  definition_simple = 'the remaining part, or to relax',
  definition_teacher = 'Noun or verb meaning remainder or to relax. In business, used for "the rest" or taking breaks.',
  usage_notes = 'Multiple meanings: remainder (the rest), relaxation (take a rest), or to relax (rest).',
  examples = jsonb_build_array(
    'The rest of the team will arrive tomorrow.',
    'Let''s discuss the rest of the agenda after lunch.',
    'Employees need adequate rest to maintain productivity.',
    'The rest of the budget is allocated to marketing.'
  ),
  collocations = jsonb_build_array('the rest of', 'rest assured', 'take a rest', 'for the rest'),
  patterns = jsonb_build_array('the rest of + noun', 'rest assured that + clause'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'rest' AND cefr_receptive = 'A1';

-- result
UPDATE lexicon_entries SET
  ipa = '/rɪˈzʌlt/',
  definition_simple = 'something that happens because of something else',
  definition_teacher = 'Noun or verb meaning outcome or to occur as consequence. Essential in business for results and outcomes.',
  usage_notes = 'Very common in business. Can be noun (the result) or verb (result from/in). Related: resulting.',
  examples = jsonb_build_array(
    'The results exceeded our expectations.',
    'Poor planning resulted in project delays.',
    'As a result, we need to adjust our strategy.',
    'The audit results will be available next week.'
  ),
  collocations = jsonb_build_array('as a result', 'result in', 'result from', 'positive results'),
  patterns = jsonb_build_array('as a result', 'result in + noun', 'result from + noun', 'the result of + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'result' AND cefr_receptive = 'A1';
