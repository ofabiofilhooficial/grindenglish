-- Enhancement of A1 Vocabulary - Batch 1 (100 words: able → desire)
-- Professional English context for Brazilian learners
-- Migration: 20260310000013

-- able
UPDATE lexicon_entries SET
  ipa = '/ˈeɪbəl/',
  definition_simple = 'having the skill, power, or opportunity to do something',
  definition_teacher = 'Used to express capability or possibility. Common in professional contexts to describe skills and competencies.',
  usage_notes = 'Often used with "to" + infinitive. Very common in job descriptions and performance reviews.',
  examples = jsonb_build_array(
    'She is able to speak three languages fluently.',
    'We were not able to complete the project on time.',
    'Are you able to attend the meeting tomorrow?',
    'The team is able to handle multiple projects simultaneously.'
  ),
  collocations = jsonb_build_array('be able to', 'able to do', 'able to handle', 'able to manage'),
  patterns = jsonb_build_array('be able to + infinitive', 'able to + verb'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'able' AND cefr_receptive = 'A1';

-- accord
UPDATE lexicon_entries SET
  ipa = '/əˈkɔːrd/',
  definition_simple = 'to give or grant something to someone',
  definition_teacher = 'Formal verb meaning to give or allow. Often used in business and legal contexts.',
  usage_notes = 'Formal register. Common in phrases like "accord respect" or "accord priority".',
  examples = jsonb_build_array(
    'The company accords great importance to employee training.',
    'We should accord him the respect he deserves.',
    'The contract accords both parties equal rights.',
    'Management accords priority to customer satisfaction.'
  ),
  collocations = jsonb_build_array('accord respect', 'accord priority', 'accord importance', 'accord rights'),
  patterns = jsonb_build_array('accord + noun + to + noun', 'accord + object + noun'),
  register = 'formal',
  variety = 'international'
WHERE headword = 'accord' AND cefr_receptive = 'A1';

-- across
UPDATE lexicon_entries SET
  ipa = '/əˈkrɒs/',
  definition_simple = 'from one side to the other side of something',
  definition_teacher = 'Preposition indicating movement or position from one side to another. Also used figuratively in business contexts.',
  usage_notes = 'Can be used literally (physical movement) or figuratively (across departments, across the company).',
  examples = jsonb_build_array(
    'The office is located across the street from the station.',
    'We need to share this information across all departments.',
    'The new policy applies across the entire organization.',
    'She walked across the room to greet the client.'
  ),
  collocations = jsonb_build_array('across the street', 'across departments', 'across the company', 'across the board'),
  patterns = jsonb_build_array('across + noun', 'across from + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'across' AND cefr_receptive = 'A1';

-- act
UPDATE lexicon_entries SET
  ipa = '/ækt/',
  definition_simple = 'to do something or take action',
  definition_teacher = 'Verb meaning to take action or behave in a particular way. Essential in business contexts for discussing actions and decisions.',
  usage_notes = 'Can mean "to take action" or "to behave". Common in phrases like "act quickly" or "act on advice".',
  examples = jsonb_build_array(
    'We need to act quickly to resolve this issue.',
    'The manager acted on the recommendation immediately.',
    'Please act professionally in all client meetings.',
    'The company must act responsibly towards the environment.'
  ),
  collocations = jsonb_build_array('act quickly', 'act on', 'act professionally', 'act responsibly'),
  patterns = jsonb_build_array('act + adverb', 'act on + noun', 'act as + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'act' AND cefr_receptive = 'A1';

-- actual
UPDATE lexicon_entries SET
  ipa = '/ˈæktʃuəl/',
  definition_simple = 'real or existing in fact, not imagined',
  definition_teacher = 'Adjective emphasizing reality versus expectation or appearance. Important for clarifying facts in business communication.',
  usage_notes = 'Often used to contrast with estimates, plans, or expectations. Note: does not mean "current" (common mistake for Portuguese speakers).',
  examples = jsonb_build_array(
    'The actual cost was higher than the estimate.',
    'What is the actual deadline for this project?',
    'The actual results exceeded our expectations.',
    'Let me check the actual figures in the report.'
  ),
  collocations = jsonb_build_array('actual cost', 'actual results', 'actual figures', 'actual situation'),
  patterns = jsonb_build_array('the actual + noun', 'actual + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'actual' AND cefr_receptive = 'A1';

-- admit
UPDATE lexicon_entries SET
  ipa = '/ədˈmɪt/',
  definition_simple = 'to agree that something is true, especially unwillingly',
  definition_teacher = 'Verb meaning to acknowledge or confess something, often reluctantly. Also means to allow entry.',
  usage_notes = 'Can mean "to confess" or "to allow entry". Common in professional contexts for acknowledging mistakes or problems.',
  examples = jsonb_build_array(
    'I must admit that I made an error in the calculation.',
    'The company admitted responsibility for the delay.',
    'She admitted that the project was behind schedule.',
    'We need to admit new members to the committee.'
  ),
  collocations = jsonb_build_array('admit mistake', 'admit responsibility', 'admit defeat', 'admit to'),
  patterns = jsonb_build_array('admit + that clause', 'admit + noun', 'admit to + gerund'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'admit' AND cefr_receptive = 'A1';

-- adopt
UPDATE lexicon_entries SET
  ipa = '/əˈdɒpt/',
  definition_simple = 'to start to use a particular method or plan',
  definition_teacher = 'Verb meaning to take up or start using something new. Very common in business for discussing new strategies, policies, or approaches.',
  usage_notes = 'Frequently used in business contexts for implementing new policies, strategies, or technologies.',
  examples = jsonb_build_array(
    'The company decided to adopt a new marketing strategy.',
    'We will adopt this approach for all future projects.',
    'Many businesses are adopting remote work policies.',
    'The team adopted her suggestion for the presentation.'
  ),
  collocations = jsonb_build_array('adopt a strategy', 'adopt an approach', 'adopt a policy', 'adopt new technology'),
  patterns = jsonb_build_array('adopt + noun', 'adopt + possessive + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'adopt' AND cefr_receptive = 'A1';

-- advance
UPDATE lexicon_entries SET
  ipa = '/ədˈvɑːns/',
  definition_simple = 'to move forward or make progress',
  definition_teacher = 'Verb meaning to move forward, progress, or improve. Essential in business for discussing career progression and project development.',
  usage_notes = 'Can be used for physical movement, career progression, or project development. Also used as a noun.',
  examples = jsonb_build_array(
    'She advanced quickly in her career.',
    'The project is advancing according to schedule.',
    'We need to advance our technology capabilities.',
    'The team advanced several innovative proposals.'
  ),
  collocations = jsonb_build_array('advance quickly', 'advance in career', 'advance technology', 'advance a proposal'),
  patterns = jsonb_build_array('advance + adverb', 'advance in + noun', 'advance + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'advance' AND cefr_receptive = 'A1';

-- affair
UPDATE lexicon_entries SET
  ipa = '/əˈfeər/',
  definition_simple = 'an event or situation, especially an important one',
  definition_teacher = 'Noun referring to matters, events, or situations. Often used in business contexts for "business affairs" or "current affairs".',
  usage_notes = 'Usually plural in business contexts (affairs). Can also mean a romantic relationship, but less common in professional settings.',
  examples = jsonb_build_array(
    'The company handles all financial affairs internally.',
    'She manages international affairs for the organization.',
    'Current affairs knowledge is important for this position.',
    'The conference was a well-organized affair.'
  ),
  collocations = jsonb_build_array('business affairs', 'financial affairs', 'current affairs', 'international affairs'),
  patterns = jsonb_build_array('noun + affairs', 'an + adjective + affair'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'affair' AND cefr_receptive = 'A1';

-- afford
UPDATE lexicon_entries SET
  ipa = '/əˈfɔːrd/',
  definition_simple = 'to have enough money or time to buy or do something',
  definition_teacher = 'Verb meaning to have sufficient resources (money, time) for something. Common in business discussions about budgets and resources.',
  usage_notes = 'Usually used with "can" or "cannot". Often followed by "to" + infinitive.',
  examples = jsonb_build_array(
    'The company cannot afford to lose this client.',
    'We can afford to invest in new equipment this year.',
    'Can you afford the time to attend the training?',
    'Small businesses cannot afford expensive marketing campaigns.'
  ),
  collocations = jsonb_build_array('cannot afford', 'can afford to', 'afford the cost', 'afford the time'),
  patterns = jsonb_build_array('can/cannot afford + to infinitive', 'afford + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'afford' AND cefr_receptive = 'A1';

-- ago
UPDATE lexicon_entries SET
  ipa = '/əˈɡəʊ/',
  definition_simple = 'in the past, before now',
  definition_teacher = 'Adverb used to indicate time in the past. Always follows the time expression (e.g., "two days ago").',
  usage_notes = 'Always comes after the time expression. Used with past tenses. Essential for discussing past events in business.',
  examples = jsonb_build_array(
    'The meeting started ten minutes ago.',
    'We launched this product two years ago.',
    'She joined the company six months ago.',
    'The contract was signed three weeks ago.'
  ),
  collocations = jsonb_build_array('years ago', 'months ago', 'days ago', 'long ago'),
  patterns = jsonb_build_array('time expression + ago', 'number + time unit + ago'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'ago' AND cefr_receptive = 'A1';

-- air
UPDATE lexicon_entries SET
  ipa = '/eər/',
  definition_simple = 'the mixture of gases that we breathe',
  definition_teacher = 'Noun referring to the atmosphere or the space above. Also used in business phrases like "air travel" or "on air".',
  usage_notes = 'Uncountable noun. Used literally (atmosphere) and in various business contexts (air travel, air freight).',
  examples = jsonb_build_array(
    'The office needs better air conditioning.',
    'We ship products by air to international clients.',
    'The presentation will air on the company channel tomorrow.',
    'Fresh air and natural light improve workplace productivity.'
  ),
  collocations = jsonb_build_array('by air', 'air travel', 'air conditioning', 'fresh air'),
  patterns = jsonb_build_array('by air', 'air + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'air' AND cefr_receptive = 'A1';

-- almost
UPDATE lexicon_entries SET
  ipa = '/ˈɔːlməʊst/',
  definition_simple = 'nearly, not quite',
  definition_teacher = 'Adverb indicating something is very close to happening or being true, but not completely. Common in business for approximations.',
  usage_notes = 'Used before verbs, adjectives, or other adverbs. Cannot be used with negative verbs (use "hardly" instead).',
  examples = jsonb_build_array(
    'The project is almost complete.',
    'We have almost reached our sales target.',
    'Almost everyone attended the training session.',
    'The report is almost ready for submission.'
  ),
  collocations = jsonb_build_array('almost complete', 'almost ready', 'almost finished', 'almost everyone'),
  patterns = jsonb_build_array('almost + adjective', 'almost + verb', 'almost + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'almost' AND cefr_receptive = 'A1';

-- alone
UPDATE lexicon_entries SET
  ipa = '/əˈləʊn/',
  definition_simple = 'without other people, by yourself',
  definition_teacher = 'Adjective or adverb meaning by oneself, without others. Used in business contexts to emphasize individual work or responsibility.',
  usage_notes = 'Can be used as adjective (after verb) or adverb. Often used to emphasize sole responsibility or independent work.',
  examples = jsonb_build_array(
    'She completed the project alone, without any assistance.',
    'You cannot solve this problem alone; we need teamwork.',
    'The manager works alone in the office on weekends.',
    'This factor alone explains the decline in sales.'
  ),
  collocations = jsonb_build_array('work alone', 'alone in', 'leave alone', 'stand alone'),
  patterns = jsonb_build_array('verb + alone', 'alone + prepositional phrase', 'noun + alone'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'alone' AND cefr_receptive = 'A1';

-- along
UPDATE lexicon_entries SET
  ipa = '/əˈlɒŋ/',
  definition_simple = 'moving forward on or beside something',
  definition_teacher = 'Preposition or adverb indicating movement in a line or direction. Also used in phrasal verbs common in business.',
  usage_notes = 'Used literally for physical movement and figuratively in business phrases like "along with" or "get along".',
  examples = jsonb_build_array(
    'The office is located along the main street.',
    'Please bring your laptop along to the meeting.',
    'We are making progress along the right path.',
    'The team works well along with the marketing department.'
  ),
  collocations = jsonb_build_array('along with', 'along the way', 'get along', 'come along'),
  patterns = jsonb_build_array('along + noun', 'along with + noun', 'verb + along'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'along' AND cefr_receptive = 'A1';

-- always
UPDATE lexicon_entries SET
  ipa = '/ˈɔːlweɪz/',
  definition_simple = 'at all times, on every occasion',
  definition_teacher = 'Adverb of frequency meaning at all times or on every occasion. Essential for describing habits, policies, and consistent practices.',
  usage_notes = 'Usually placed before the main verb but after "be". Used to emphasize consistency in business practices.',
  examples = jsonb_build_array(
    'We always respond to customer inquiries within 24 hours.',
    'The company has always prioritized employee development.',
    'She always arrives at meetings on time.',
    'Quality is always our top priority.'
  ),
  collocations = jsonb_build_array('always on time', 'always available', 'always ready', 'always welcome'),
  patterns = jsonb_build_array('always + verb', 'be + always + adjective', 'have + always + past participle'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'always' AND cefr_receptive = 'A1';

-- ancient
UPDATE lexicon_entries SET
  ipa = '/ˈeɪnʃənt/',
  definition_simple = 'very old, from a long time ago',
  definition_teacher = 'Adjective meaning extremely old or from ancient times. Used literally for historical contexts and figuratively for outdated systems.',
  usage_notes = 'Can be used literally (ancient civilizations) or figuratively (ancient technology). Often implies something is outdated.',
  examples = jsonb_build_array(
    'The company still uses ancient computer systems.',
    'We need to replace this ancient equipment.',
    'Ancient business practices are no longer effective.',
    'The building has an ancient heating system.'
  ),
  collocations = jsonb_build_array('ancient history', 'ancient system', 'ancient equipment', 'ancient times'),
  patterns = jsonb_build_array('ancient + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'ancient' AND cefr_receptive = 'A1';

-- animal
UPDATE lexicon_entries SET
  ipa = '/ˈænɪməl/',
  definition_simple = 'a living creature that is not a plant or human',
  definition_teacher = 'Noun referring to living creatures. In business contexts, may appear in discussions about animal products, testing, or welfare policies.',
  usage_notes = 'Countable noun. In business, often appears in contexts like "animal testing", "animal products", or "animal welfare".',
  examples = jsonb_build_array(
    'The company has a strict policy against animal testing.',
    'We source animal products from ethical suppliers.',
    'Animal welfare is an important consideration for our brand.',
    'The facility does not allow animals on the premises.'
  ),
  collocations = jsonb_build_array('animal testing', 'animal products', 'animal welfare', 'wild animal'),
  patterns = jsonb_build_array('animal + noun', 'adjective + animal'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'animal' AND cefr_receptive = 'A1';

-- appoint
UPDATE lexicon_entries SET
  ipa = '/əˈpɔɪnt/',
  definition_simple = 'to choose someone for a job or position',
  definition_teacher = 'Verb meaning to officially assign someone to a position or role. Very common in business for discussing hiring and role assignments.',
  usage_notes = 'Formal verb used in professional contexts. Often used in passive voice (be appointed).',
  examples = jsonb_build_array(
    'The board appointed her as the new CEO.',
    'We need to appoint a project manager for this initiative.',
    'He was appointed to lead the sales team.',
    'The committee will appoint a new chairperson next month.'
  ),
  collocations = jsonb_build_array('appoint someone as', 'appoint to position', 'be appointed', 'appoint a manager'),
  patterns = jsonb_build_array('appoint + person + as + position', 'appoint + person + to + role', 'be appointed + position'),
  register = 'formal',
  variety = 'international'
WHERE headword = 'appoint' AND cefr_receptive = 'A1';

-- arise
UPDATE lexicon_entries SET
  ipa = '/əˈraɪz/',
  definition_simple = 'to happen or appear, especially a problem or difficulty',
  definition_teacher = 'Verb meaning to occur or come into existence, especially problems or situations. Common in business for discussing issues.',
  usage_notes = 'Formal verb. Irregular: arise, arose, arisen. Often used for problems, questions, or opportunities.',
  examples = jsonb_build_array(
    'Several issues arose during the implementation phase.',
    'If any questions arise, please contact the support team.',
    'New opportunities may arise from this partnership.',
    'Problems can arise when communication is unclear.'
  ),
  collocations = jsonb_build_array('issues arise', 'questions arise', 'problems arise', 'opportunities arise'),
  patterns = jsonb_build_array('noun + arise', 'arise from + noun', 'arise during + noun'),
  register = 'formal',
  variety = 'international'
WHERE headword = 'arise' AND cefr_receptive = 'A1';

-- arm
UPDATE lexicon_entries SET
  ipa = '/ɑːrm/',
  definition_simple = 'the part of the body between the shoulder and the hand',
  definition_teacher = 'Noun referring to the upper limb. Also used figuratively in business (armed with information, arm of the company).',
  usage_notes = 'Countable noun. Can be used literally (body part) or figuratively in business expressions.',
  examples = jsonb_build_array(
    'She raised her arm to ask a question during the presentation.',
    'The sales division is the commercial arm of the company.',
    'We need to arm ourselves with data before the negotiation.',
    'Keep your arms relaxed during video conferences.'
  ),
  collocations = jsonb_build_array('raise arm', 'arm of company', 'armed with', 'right arm'),
  patterns = jsonb_build_array('possessive + arm', 'arm of + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'arm' AND cefr_receptive = 'A1';

-- army
UPDATE lexicon_entries SET
  ipa = '/ˈɑːrmi/',
  definition_simple = 'a large organized group of soldiers',
  definition_teacher = 'Noun referring to military forces. In business, sometimes used metaphorically for large groups or teams.',
  usage_notes = 'Countable noun. Can be used literally (military) or metaphorically (army of workers, army of supporters).',
  examples = jsonb_build_array(
    'The company has an army of sales representatives worldwide.',
    'We need an army of volunteers for the event.',
    'The project requires an army of developers to complete on time.',
    'An army of consultants was brought in to solve the problem.'
  ),
  collocations = jsonb_build_array('army of', 'join the army', 'large army', 'standing army'),
  patterns = jsonb_build_array('an army of + plural noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'army' AND cefr_receptive = 'A1';

-- around
UPDATE lexicon_entries SET
  ipa = '/əˈraʊnd/',
  definition_simple = 'in a circle, on all sides, or approximately',
  definition_teacher = 'Preposition or adverb with multiple meanings: surrounding, approximately, or in various directions. Very common in business.',
  usage_notes = 'Can mean "surrounding", "approximately" (around 100 people), or "in the area". Very versatile word.',
  examples = jsonb_build_array(
    'The meeting will start around 2 PM.',
    'There are around 50 employees in this department.',
    'Please gather around the conference table.',
    'We need to turn this situation around quickly.'
  ),
  collocations = jsonb_build_array('around the table', 'around here', 'turn around', 'around the world'),
  patterns = jsonb_build_array('around + time', 'around + number', 'around + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'around' AND cefr_receptive = 'A1';

-- art
UPDATE lexicon_entries SET
  ipa = '/ɑːrt/',
  definition_simple = 'creative work like painting, music, or literature',
  definition_teacher = 'Noun referring to creative expression or skill. In business, used for "state of the art" or discussing creative industries.',
  usage_notes = 'Can be countable (an art) or uncountable (art in general). Common in business phrase "state of the art".',
  examples = jsonb_build_array(
    'The office features modern art from local artists.',
    'We use state-of-the-art technology in our production.',
    'Negotiation is an art that requires practice.',
    'The company supports the arts through sponsorship programs.'
  ),
  collocations = jsonb_build_array('state of the art', 'modern art', 'the arts', 'art of negotiation'),
  patterns = jsonb_build_array('state-of-the-art + noun', 'the art of + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'art' AND cefr_receptive = 'A1';

-- article
UPDATE lexicon_entries SET
  ipa = '/ˈɑːrtɪkəl/',
  definition_simple = 'a piece of writing in a newspaper or magazine',
  definition_teacher = 'Noun meaning a written piece or an item. In business, refers to written content, contract clauses, or products.',
  usage_notes = 'Can mean "written piece", "item/product", or "clause in a document". Context determines meaning.',
  examples = jsonb_build_array(
    'She wrote an article about workplace productivity.',
    'Please read the article before tomorrow''s meeting.',
    'Article 5 of the contract covers payment terms.',
    'We manufacture various articles for export.'
  ),
  collocations = jsonb_build_array('write an article', 'read an article', 'article about', 'article of clothing'),
  patterns = jsonb_build_array('article + about/on + topic', 'article + number'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'article' AND cefr_receptive = 'A1';

-- association
UPDATE lexicon_entries SET
  ipa = '/əˌsəʊsiˈeɪʃən/',
  definition_simple = 'an organization of people with a common purpose',
  definition_teacher = 'Noun meaning an organized group or the connection between things. Common in business for professional organizations.',
  usage_notes = 'Can mean "organization" or "connection/relationship". Often used for professional or trade groups.',
  examples = jsonb_build_array(
    'She is a member of the International Marketing Association.',
    'The trade association represents over 500 companies.',
    'There is a strong association between training and performance.',
    'Our company works in association with several partners.'
  ),
  collocations = jsonb_build_array('trade association', 'professional association', 'in association with', 'member of association'),
  patterns = jsonb_build_array('association of + noun', 'in association with', 'association between + noun + and + noun'),
  register = 'formal',
  variety = 'international'
WHERE headword = 'association' AND cefr_receptive = 'A1';

-- attack
UPDATE lexicon_entries SET
  ipa = '/əˈtæk/',
  definition_simple = 'to try to hurt or damage someone or something',
  definition_teacher = 'Verb or noun meaning to assault or criticize strongly. In business, used for cyber attacks or aggressive criticism.',
  usage_notes = 'Can be literal (physical attack) or figurative (attack a problem, cyber attack). Common in IT security contexts.',
  examples = jsonb_build_array(
    'The company suffered a cyber attack last month.',
    'We need to attack this problem systematically.',
    'The competitor attacked our market share aggressively.',
    'Security measures protect against malware attacks.'
  ),
  collocations = jsonb_build_array('cyber attack', 'attack a problem', 'under attack', 'attack strategy'),
  patterns = jsonb_build_array('attack + noun', 'under attack', 'attack on + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'attack' AND cefr_receptive = 'A1';

-- average
UPDATE lexicon_entries SET
  ipa = '/ˈævərɪdʒ/',
  definition_simple = 'typical or normal, calculated by adding amounts and dividing',
  definition_teacher = 'Adjective or noun meaning typical, ordinary, or a calculated mean. Essential in business for statistics and performance metrics.',
  usage_notes = 'Can be adjective (average performance) or noun (the average). Very common in business reports and analytics.',
  examples = jsonb_build_array(
    'The average response time is 24 hours.',
    'Sales are above average this quarter.',
    'On average, employees work 40 hours per week.',
    'The average customer spends $50 per transaction.'
  ),
  collocations = jsonb_build_array('on average', 'above average', 'below average', 'average performance'),
  patterns = jsonb_build_array('on average', 'the average + noun', 'above/below average'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'average' AND cefr_receptive = 'A1';

-- away
UPDATE lexicon_entries SET
  ipa = '/əˈweɪ/',
  definition_simple = 'at a distance from a place, not present',
  definition_teacher = 'Adverb indicating distance or absence. Common in business for discussing remote work, absence, or distance.',
  usage_notes = 'Used with verbs of movement or to indicate absence. Common in phrases like "away from office" or "right away".',
  examples = jsonb_build_array(
    'The manager is away on a business trip this week.',
    'Please respond to the email right away.',
    'The office is located 5 kilometers away from the station.',
    'She will be away from her desk until 3 PM.'
  ),
  collocations = jsonb_build_array('right away', 'away from', 'away on business', 'go away'),
  patterns = jsonb_build_array('away + from + noun', 'right away', 'be away'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'away' AND cefr_receptive = 'A1';

-- back
UPDATE lexicon_entries SET
  ipa = '/bæk/',
  definition_simple = 'in the direction behind you, or to a previous place or time',
  definition_teacher = 'Adverb, adjective, or noun indicating return, rear position, or past time. Very common in business communication.',
  usage_notes = 'Extremely versatile word. Can indicate return (come back), rear position (back door), or past time (back in 2020).',
  examples = jsonb_build_array(
    'I will call you back after the meeting.',
    'Please get back to me with your decision.',
    'The back office handles administrative tasks.',
    'We need to go back to the original plan.'
  ),
  collocations = jsonb_build_array('call back', 'get back to', 'back office', 'go back'),
  patterns = jsonb_build_array('verb + back', 'back + noun', 'back to + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'back' AND cefr_receptive = 'A1';

-- ball
UPDATE lexicon_entries SET
  ipa = '/bɔːl/',
  definition_simple = 'a round object used in games and sports',
  definition_teacher = 'Noun referring to a spherical object. In business, appears in idioms like "the ball is in your court" or "drop the ball".',
  usage_notes = 'Countable noun. Often used in business idioms about responsibility and action.',
  examples = jsonb_build_array(
    'The ball is in your court now - please make a decision.',
    'Don''t drop the ball on this important project.',
    'We need to keep the ball rolling with this initiative.',
    'Let''s get the ball rolling on the new campaign.'
  ),
  collocations = jsonb_build_array('ball is in your court', 'drop the ball', 'keep the ball rolling', 'get the ball rolling'),
  patterns = jsonb_build_array('the ball is in + possessive + court', 'drop the ball', 'keep/get the ball rolling'),
  register = 'informal',
  variety = 'international'
WHERE headword = 'ball' AND cefr_receptive = 'A1';

-- bank
UPDATE lexicon_entries SET
  ipa = '/bæŋk/',
  definition_simple = 'a financial institution that keeps and lends money',
  definition_teacher = 'Noun referring to a financial institution. Essential business vocabulary for discussing finance, accounts, and transactions.',
  usage_notes = 'Countable noun. Very common in business contexts. Can also be a verb (to bank money).',
  examples = jsonb_build_array(
    'The company has accounts with three different banks.',
    'Please transfer the payment to our bank account.',
    'We need to visit the bank to discuss the loan.',
    'Online banking has simplified financial management.'
  ),
  collocations = jsonb_build_array('bank account', 'bank transfer', 'online banking', 'investment bank'),
  patterns = jsonb_build_array('bank + noun', 'at/with the bank'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'bank' AND cefr_receptive = 'A1';

-- bar
UPDATE lexicon_entries SET
  ipa = '/bɑːr/',
  definition_simple = 'a place where alcoholic drinks are served, or a long piece of something',
  definition_teacher = 'Noun with multiple meanings: drinking establishment, counter, or obstacle. In business, used in phrases like "raise the bar".',
  usage_notes = 'Multiple meanings depending on context. Common in business idioms about standards and obstacles.',
  examples = jsonb_build_array(
    'The company has raised the bar for customer service.',
    'There are no bars to entry in this market.',
    'The hotel has a bar on the ground floor.',
    'We need to set the bar high for quality standards.'
  ),
  collocations = jsonb_build_array('raise the bar', 'set the bar', 'bar to entry', 'behind bars'),
  patterns = jsonb_build_array('raise/set the bar', 'bar to + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'bar' AND cefr_receptive = 'A1';

-- battle
UPDATE lexicon_entries SET
  ipa = '/ˈbætəl/',
  definition_simple = 'a fight between armed forces, or a difficult struggle',
  definition_teacher = 'Noun or verb meaning a fight or struggle. In business, used metaphorically for competitive struggles or challenges.',
  usage_notes = 'Can be literal (military) or metaphorical (battle for market share). Common in business for describing competition.',
  examples = jsonb_build_array(
    'The company is in a battle for market leadership.',
    'We face an uphill battle to meet the deadline.',
    'The legal battle lasted for two years.',
    'It''s a constant battle to reduce costs while maintaining quality.'
  ),
  collocations = jsonb_build_array('battle for', 'uphill battle', 'legal battle', 'constant battle'),
  patterns = jsonb_build_array('battle for + noun', 'battle to + infinitive', 'battle against + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'battle' AND cefr_receptive = 'A1';

-- bear
UPDATE lexicon_entries SET
  ipa = '/beər/',
  definition_simple = 'to carry, support, or accept something difficult',
  definition_teacher = 'Verb with multiple meanings: to carry, endure, or produce. In business, commonly used for bearing costs, responsibility, or results.',
  usage_notes = 'Irregular verb: bear, bore, borne. Multiple meanings - context is important. Formal in business contexts.',
  examples = jsonb_build_array(
    'The company will bear the cost of the training.',
    'Who will bear responsibility for this decision?',
    'We cannot bear any additional expenses this quarter.',
    'The data bears out our initial hypothesis.'
  ),
  collocations = jsonb_build_array('bear the cost', 'bear responsibility', 'bear in mind', 'bear fruit'),
  patterns = jsonb_build_array('bear + noun', 'bear + that clause'),
  register = 'formal',
  variety = 'international'
WHERE headword = 'bear' AND cefr_receptive = 'A1';

-- beauty
UPDATE lexicon_entries SET
  ipa = '/ˈbjuːti/',
  definition_simple = 'the quality of being attractive or pleasing',
  definition_teacher = 'Noun referring to attractiveness or an excellent feature. In business, used to highlight advantages or elegant solutions.',
  usage_notes = 'Uncountable when referring to the quality; countable when referring to a beautiful thing or person.',
  examples = jsonb_build_array(
    'The beauty of this solution is its simplicity.',
    'The beauty industry is highly competitive.',
    'That''s the beauty of automation - it saves time.',
    'The product combines beauty with functionality.'
  ),
  collocations = jsonb_build_array('the beauty of', 'beauty industry', 'beauty product', 'natural beauty'),
  patterns = jsonb_build_array('the beauty of + noun + is', 'beauty + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'beauty' AND cefr_receptive = 'A1';

-- behind
UPDATE lexicon_entries SET
  ipa = '/bɪˈhaɪnd/',
  definition_simple = 'at or toward the back of something',
  definition_teacher = 'Preposition or adverb indicating position at the back or delay. Common in business for discussing delays or support.',
  usage_notes = 'Can indicate physical position, delay (behind schedule), or support (behind the decision).',
  examples = jsonb_build_array(
    'The project is behind schedule by two weeks.',
    'Management is behind this decision completely.',
    'The real reason behind the delay was lack of resources.',
    'We are behind our competitors in market share.'
  ),
  collocations = jsonb_build_array('behind schedule', 'behind the scenes', 'fall behind', 'reason behind'),
  patterns = jsonb_build_array('behind + noun', 'behind in + noun', 'the reason behind + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'behind' AND cefr_receptive = 'A1';

-- being
UPDATE lexicon_entries SET
  ipa = '/ˈbiːɪŋ/',
  definition_simple = 'existence, or a living creature',
  definition_teacher = 'Noun meaning existence or a living entity. In business, appears in phrases like "human being" or "for the time being".',
  usage_notes = 'Can mean "existence" (abstract) or "creature" (countable). Common in phrase "for the time being".',
  examples = jsonb_build_array(
    'For the time being, we will continue with the current system.',
    'The well-being of employees is our priority.',
    'Human beings need clear communication in the workplace.',
    'The policy is in effect for the time being.'
  ),
  collocations = jsonb_build_array('for the time being', 'human being', 'well-being', 'come into being'),
  patterns = jsonb_build_array('for the time being', 'the + noun + of + being'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'being' AND cefr_receptive = 'A1';

-- below
UPDATE lexicon_entries SET
  ipa = '/bɪˈləʊ/',
  definition_simple = 'in a lower position or less than',
  definition_teacher = 'Preposition or adverb indicating lower position or lesser amount. Common in business for comparisons and references.',
  usage_notes = 'Can indicate physical position (below the line) or comparison (below average, below expectations).',
  examples = jsonb_build_array(
    'Sales figures are below target this month.',
    'Please see the details below for more information.',
    'Performance is below expectations in several areas.',
    'The temperature in the warehouse is below freezing.'
  ),
  collocations = jsonb_build_array('below average', 'below target', 'below expectations', 'see below'),
  patterns = jsonb_build_array('below + noun', 'below + number'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'below' AND cefr_receptive = 'A1';

-- beneath
UPDATE lexicon_entries SET
  ipa = '/bɪˈniːθ/',
  definition_simple = 'in or to a lower position, under',
  definition_teacher = 'Preposition meaning under or below. More formal than "under" or "below". Used literally and figuratively in business.',
  usage_notes = 'More formal than "under" or "below". Can indicate physical position or status/dignity.',
  examples = jsonb_build_array(
    'The parking garage is located beneath the building.',
    'Such behavior is beneath professional standards.',
    'The truth lies beneath the surface of these numbers.',
    'Beneath the positive results, there are concerns.'
  ),
  collocations = jsonb_build_array('beneath the surface', 'beneath standards', 'beneath dignity', 'lie beneath'),
  patterns = jsonb_build_array('beneath + noun', 'beneath + possessive + noun'),
  register = 'formal',
  variety = 'international'
WHERE headword = 'beneath' AND cefr_receptive = 'A1';

-- beside
UPDATE lexicon_entries SET
  ipa = '/bɪˈsaɪd/',
  definition_simple = 'next to or at the side of',
  definition_teacher = 'Preposition meaning next to or at the side of. Note: different from "besides" which means "in addition to".',
  usage_notes = 'Do not confuse with "besides" (in addition to). "Beside" means "next to".',
  examples = jsonb_build_array(
    'Please sit beside me during the presentation.',
    'The printer is located beside the copy machine.',
    'Her office is beside the conference room.',
    'Place the documents beside the computer.'
  ),
  collocations = jsonb_build_array('beside the point', 'sit beside', 'stand beside', 'beside each other'),
  patterns = jsonb_build_array('beside + noun', 'beside + possessive + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'beside' AND cefr_receptive = 'A1';

-- best
UPDATE lexicon_entries SET
  ipa = '/best/',
  definition_simple = 'of the highest quality or most suitable',
  definition_teacher = 'Adjective (superlative of good) or adverb meaning highest quality or most suitable. Essential in business for recommendations and standards.',
  usage_notes = 'Superlative form of "good". Very common in business for best practices, best regards, do your best.',
  examples = jsonb_build_array(
    'We always strive to deliver the best service.',
    'This is the best solution for our current needs.',
    'Best practices should be followed in all departments.',
    'Please do your best to meet the deadline.'
  ),
  collocations = jsonb_build_array('best practice', 'best regards', 'do your best', 'best solution'),
  patterns = jsonb_build_array('the best + noun', 'best + noun', 'do one''s best'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'best' AND cefr_receptive = 'A1';

-- better
UPDATE lexicon_entries SET
  ipa = '/ˈbetər/',
  definition_simple = 'of higher quality or more suitable than another',
  definition_teacher = 'Adjective (comparative of good) or adverb meaning superior or improved. Very common in business for comparisons and improvements.',
  usage_notes = 'Comparative form of "good". Essential for discussing improvements, comparisons, and preferences.',
  examples = jsonb_build_array(
    'We need a better strategy for customer retention.',
    'The new system works better than the old one.',
    'It would be better to postpone the meeting.',
    'Performance is getting better each quarter.'
  ),
  collocations = jsonb_build_array('better than', 'get better', 'better solution', 'better way'),
  patterns = jsonb_build_array('better than + noun', 'better + noun', 'get/become better'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'better' AND cefr_receptive = 'A1';

-- beyond
UPDATE lexicon_entries SET
  ipa = '/bɪˈjɒnd/',
  definition_simple = 'on or to the far side of something, or more than',
  definition_teacher = 'Preposition or adverb meaning further than, exceeding, or outside the limits of. Common in business for exceeding expectations or limits.',
  usage_notes = 'Can indicate physical distance, exceeding limits, or being outside scope. Formal tone.',
  examples = jsonb_build_array(
    'The results went beyond our expectations.',
    'This issue is beyond my authority to decide.',
    'We need to look beyond the immediate problem.',
    'The project scope extends beyond the original plan.'
  ),
  collocations = jsonb_build_array('beyond expectations', 'beyond control', 'beyond scope', 'go beyond'),
  patterns = jsonb_build_array('beyond + noun', 'go/be beyond + noun'),
  register = 'formal',
  variety = 'international'
WHERE headword = 'beyond' AND cefr_receptive = 'A1';

-- bill
UPDATE lexicon_entries SET
  ipa = '/bɪl/',
  definition_simple = 'a written statement of money owed for goods or services',
  definition_teacher = 'Noun meaning an invoice or statement of charges. Essential business vocabulary for financial transactions and payments.',
  usage_notes = 'Countable noun. Very common in business contexts. Can also mean proposed law, but invoice meaning is more common.',
  examples = jsonb_build_array(
    'Please send the bill to our accounts department.',
    'The electricity bill is due next week.',
    'We received a bill for the consulting services.',
    'Can you check if the bill has been paid?'
  ),
  collocations = jsonb_build_array('pay the bill', 'send a bill', 'electricity bill', 'foot the bill'),
  patterns = jsonb_build_array('pay/send/receive + the bill', 'bill for + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'bill' AND cefr_receptive = 'A1';

-- bird
UPDATE lexicon_entries SET
  ipa = '/bɜːrd/',
  definition_simple = 'an animal with feathers and wings',
  definition_teacher = 'Noun referring to feathered flying animals. In business, appears in idioms like "early bird" or "kill two birds with one stone".',
  usage_notes = 'Countable noun. Often used in business idioms about efficiency and timing.',
  examples = jsonb_build_array(
    'The early bird gets the worm - arrive early for best results.',
    'We can kill two birds with one stone by combining these meetings.',
    'Early bird registration ends next Friday.',
    'A bird''s eye view of the project shows several issues.'
  ),
  collocations = jsonb_build_array('early bird', 'kill two birds with one stone', 'bird''s eye view', 'free as a bird'),
  patterns = jsonb_build_array('early bird + noun', 'a bird''s eye view of + noun'),
  register = 'informal',
  variety = 'international'
WHERE headword = 'bird' AND cefr_receptive = 'A1';

-- bit
UPDATE lexicon_entries SET
  ipa = '/bɪt/',
  definition_simple = 'a small piece or amount of something',
  definition_teacher = 'Noun meaning a small amount or piece. Very common in business for indicating small quantities or degrees.',
  usage_notes = 'Usually used with "a" (a bit). Can mean "slightly" when used as adverb (a bit late).',
  examples = jsonb_build_array(
    'We need a bit more time to complete the analysis.',
    'The presentation is a bit too long.',
    'Can you wait a bit? I''ll be ready soon.',
    'Every bit of information helps in making decisions.'
  ),
  collocations = jsonb_build_array('a bit of', 'a bit more', 'a bit late', 'every bit'),
  patterns = jsonb_build_array('a bit + adjective/adverb', 'a bit of + noun', 'a bit more + noun'),
  register = 'informal',
  variety = 'international'
WHERE headword = 'bit' AND cefr_receptive = 'A1';

-- blood
UPDATE lexicon_entries SET
  ipa = '/blʌd/',
  definition_simple = 'the red liquid that flows through the body',
  definition_teacher = 'Noun referring to the bodily fluid. In business, appears in idioms like "new blood" or "blood, sweat, and tears".',
  usage_notes = 'Uncountable noun. Used literally (medical) or in business idioms about effort and renewal.',
  examples = jsonb_build_array(
    'The company needs new blood to drive innovation.',
    'This project required blood, sweat, and tears.',
    'Bad blood between departments affects productivity.',
    'The team put their blood, sweat, and tears into the launch.'
  ),
  collocations = jsonb_build_array('new blood', 'blood, sweat, and tears', 'bad blood', 'in cold blood'),
  patterns = jsonb_build_array('new blood', 'bad blood between + noun'),
  register = 'informal',
  variety = 'international'
WHERE headword = 'blood' AND cefr_receptive = 'A1';

-- blow
UPDATE lexicon_entries SET
  ipa = '/bləʊ/',
  definition_simple = 'to move air, or to be moved by air',
  definition_teacher = 'Verb meaning to move air or be moved by wind. In business, used in idioms like "blow the whistle" or describing setbacks.',
  usage_notes = 'Irregular verb: blow, blew, blown. Can be literal (wind) or figurative (blow a chance, blow the whistle).',
  examples = jsonb_build_array(
    'Don''t blow this opportunity - it''s important.',
    'The scandal could blow over in a few weeks.',
    'Someone blew the whistle on the accounting fraud.',
    'The unexpected costs blew our budget.'
  ),
  collocations = jsonb_build_array('blow the whistle', 'blow over', 'blow a chance', 'blow the budget'),
  patterns = jsonb_build_array('blow + noun', 'blow over', 'blow the whistle on + noun'),
  register = 'informal',
  variety = 'international'
WHERE headword = 'blow' AND cefr_receptive = 'A1';

-- boat
UPDATE lexicon_entries SET
  ipa = '/bəʊt/',
  definition_simple = 'a vehicle for traveling on water',
  definition_teacher = 'Noun referring to a watercraft. In business, appears in idioms like "in the same boat" or "miss the boat".',
  usage_notes = 'Countable noun. Often used in business idioms about shared situations or missed opportunities.',
  examples = jsonb_build_array(
    'We''re all in the same boat with this challenge.',
    'Don''t miss the boat on this investment opportunity.',
    'The company ships goods by boat to reduce costs.',
    'If we don''t act now, we''ll miss the boat.'
  ),
  collocations = jsonb_build_array('in the same boat', 'miss the boat', 'rock the boat', 'by boat'),
  patterns = jsonb_build_array('in the same boat', 'miss the boat on + noun'),
  register = 'informal',
  variety = 'international'
WHERE headword = 'boat' AND cefr_receptive = 'A1';

-- body
UPDATE lexicon_entries SET
  ipa = '/ˈbɒdi/',
  definition_simple = 'the physical structure of a person or animal',
  definition_teacher = 'Noun referring to physical form or main part. In business, used for "body of work", "governing body", or "body of evidence".',
  usage_notes = 'Countable noun. Multiple meanings: physical form, main part, organization, or collection.',
  examples = jsonb_build_array(
    'The governing body approved the new policy.',
    'The body of the report contains detailed analysis.',
    'A body of evidence supports this conclusion.',
    'The regulatory body oversees industry standards.'
  ),
  collocations = jsonb_build_array('governing body', 'body of work', 'body of evidence', 'regulatory body'),
  patterns = jsonb_build_array('governing/regulatory + body', 'body of + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'body' AND cefr_receptive = 'A1';

-- born
UPDATE lexicon_entries SET
  ipa = '/bɔːrn/',
  definition_simple = 'brought into life, or having a natural ability',
  definition_teacher = 'Past participle of "bear" used as adjective. In business, used for "born leader" or describing origins of ideas/companies.',
  usage_notes = 'Usually used in passive (was born) or as adjective (born leader). Common for describing natural talents.',
  examples = jsonb_build_array(
    'She is a born leader with excellent management skills.',
    'The company was born out of a simple idea.',
    'He''s a born entrepreneur with great instincts.',
    'The project was born from customer feedback.'
  ),
  collocations = jsonb_build_array('born leader', 'born entrepreneur', 'be born', 'born out of'),
  patterns = jsonb_build_array('a born + noun', 'be born + prepositional phrase', 'born out of + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'born' AND cefr_receptive = 'A1';

-- box
UPDATE lexicon_entries SET
  ipa = '/bɒks/',
  definition_simple = 'a container with flat sides, usually square or rectangular',
  definition_teacher = 'Noun referring to a container. In business, used literally for packaging and figuratively in "think outside the box".',
  usage_notes = 'Countable noun. Common in business idioms about creative thinking and categorization.',
  examples = jsonb_build_array(
    'We need to think outside the box for this problem.',
    'Please check the box to confirm your agreement.',
    'The products are shipped in protective boxes.',
    'Don''t put people in boxes - everyone has diverse skills.'
  ),
  collocations = jsonb_build_array('think outside the box', 'check the box', 'in a box', 'box of'),
  patterns = jsonb_build_array('think outside the box', 'check the box', 'a box of + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'box' AND cefr_receptive = 'A1';

-- breadth
UPDATE lexicon_entries SET
  ipa = '/bredθ/',
  definition_simple = 'the distance from side to side, or wide range',
  definition_teacher = 'Noun meaning width or extent of range. In business, used to describe scope, range, or diversity of experience/knowledge.',
  usage_notes = 'Uncountable noun. Often used figuratively for range or scope (breadth of experience, breadth of knowledge).',
  examples = jsonb_build_array(
    'She has impressive breadth of experience in marketing.',
    'The breadth of our product range attracts diverse customers.',
    'We need someone with breadth of knowledge in this field.',
    'The report covers the breadth of industry challenges.'
  ),
  collocations = jsonb_build_array('breadth of experience', 'breadth of knowledge', 'breadth of range', 'length and breadth'),
  patterns = jsonb_build_array('breadth of + noun'),
  register = 'formal',
  variety = 'international'
WHERE headword = 'breadth' AND cefr_receptive = 'A1';

-- break
UPDATE lexicon_entries SET
  ipa = '/breɪk/',
  definition_simple = 'to separate into pieces, or a pause in activity',
  definition_teacher = 'Verb or noun meaning to damage/separate or a pause. Essential in business for breaks, breakthroughs, and breaking news.',
  usage_notes = 'Irregular verb: break, broke, broken. Multiple meanings: damage, pause, interrupt, or achieve breakthrough.',
  examples = jsonb_build_array(
    'Let''s take a 15-minute break.',
    'We need to break this problem down into smaller parts.',
    'The team achieved a major breakthrough.',
    'Don''t break the rules - follow company policy.'
  ),
  collocations = jsonb_build_array('take a break', 'break down', 'break through', 'break the news'),
  patterns = jsonb_build_array('take a break', 'break + noun + down', 'break through + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'break' AND cefr_receptive = 'A1';

-- bridge
UPDATE lexicon_entries SET
  ipa = '/brɪdʒ/',
  definition_simple = 'a structure built over a river or road, or something that connects',
  definition_teacher = 'Noun or verb meaning a connecting structure or to make a connection. In business, used for bridging gaps or building bridges.',
  usage_notes = 'Can be literal (physical bridge) or figurative (bridge the gap, build bridges). Common in business metaphors.',
  examples = jsonb_build_array(
    'We need to bridge the gap between departments.',
    'This solution bridges the divide between old and new systems.',
    'Building bridges with stakeholders is essential.',
    'The training program bridges the skills gap.'
  ),
  collocations = jsonb_build_array('bridge the gap', 'build bridges', 'bridge the divide', 'bridge between'),
  patterns = jsonb_build_array('bridge the gap/divide', 'build bridges with + noun', 'bridge between + noun + and + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'bridge' AND cefr_receptive = 'A1';

-- bright
UPDATE lexicon_entries SET
  ipa = '/braɪt/',
  definition_simple = 'giving out or reflecting much light, or intelligent',
  definition_teacher = 'Adjective meaning luminous, vivid, or intelligent. In business, used for bright ideas, bright future, or bright employees.',
  usage_notes = 'Can describe light, colors, intelligence, or prospects. Very positive connotation in business contexts.',
  examples = jsonb_build_array(
    'She has a bright future with the company.',
    'That''s a bright idea - let''s implement it.',
    'The outlook for next quarter is bright.',
    'We need bright, motivated people on the team.'
  ),
  collocations = jsonb_build_array('bright future', 'bright idea', 'bright outlook', 'bright and early'),
  patterns = jsonb_build_array('bright + noun', 'a bright + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'bright' AND cefr_receptive = 'A1';

-- bring
UPDATE lexicon_entries SET
  ipa = '/brɪŋ/',
  definition_simple = 'to take or carry something to a place',
  definition_teacher = 'Verb meaning to carry toward the speaker or to cause something to happen. Essential in business for bringing results, ideas, or people together.',
  usage_notes = 'Irregular verb: bring, brought, brought. Very common in business contexts (bring results, bring together, bring up).',
  examples = jsonb_build_array(
    'Please bring your laptop to the meeting.',
    'This strategy will bring positive results.',
    'Let''s bring everyone together for a discussion.',
    'I''d like to bring up an important issue.'
  ),
  collocations = jsonb_build_array('bring results', 'bring together', 'bring up', 'bring to attention'),
  patterns = jsonb_build_array('bring + noun', 'bring + noun + together', 'bring up + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'bring' AND cefr_receptive = 'A1';

-- burn
UPDATE lexicon_entries SET
  ipa = '/bɜːrn/',
  definition_simple = 'to be damaged or destroyed by fire or heat',
  definition_teacher = 'Verb meaning to consume with fire or to use energy. In business, used in "burn rate" or "burning question".',
  usage_notes = 'Irregular verb: burn, burned/burnt, burned/burnt. Used literally and in business idioms about resources and urgency.',
  examples = jsonb_build_array(
    'The company''s burn rate is too high.',
    'Don''t burn bridges with former colleagues.',
    'We''re burning through our budget quickly.',
    'That''s the burning question everyone is asking.'
  ),
  collocations = jsonb_build_array('burn rate', 'burn bridges', 'burn through', 'burning question'),
  patterns = jsonb_build_array('burn + noun', 'burn through + noun', 'burning + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'burn' AND cefr_receptive = 'A1';

-- capital
UPDATE lexicon_entries SET
  ipa = '/ˈkæpɪtəl/',
  definition_simple = 'money or property used to start a business, or a city where government is located',
  definition_teacher = 'Noun meaning financial assets, main city, or uppercase letter. Essential business vocabulary for discussing finance and investment.',
  usage_notes = 'Multiple meanings: financial capital, capital city, or capital letter. Context determines meaning.',
  examples = jsonb_build_array(
    'The company needs more capital to expand.',
    'We raised capital through investor funding.',
    'Human capital is our most valuable asset.',
    'The business requires significant working capital.'
  ),
  collocations = jsonb_build_array('raise capital', 'working capital', 'human capital', 'capital investment'),
  patterns = jsonb_build_array('raise/need + capital', 'capital + noun'),
  register = 'formal',
  variety = 'international'
WHERE headword = 'capital' AND cefr_receptive = 'A1';

-- care
UPDATE lexicon_entries SET
  ipa = '/keər/',
  definition_simple = 'the process of protecting and looking after someone or something',
  definition_teacher = 'Noun or verb meaning attention, concern, or caution. Essential in business for customer care, healthcare, and expressing concern.',
  usage_notes = 'Can be noun (take care) or verb (care about). Very common in business contexts for customer service and attention to detail.',
  examples = jsonb_build_array(
    'Customer care is our top priority.',
    'Please take care when handling sensitive data.',
    'We care about employee well-being.',
    'The company provides excellent after-sales care.'
  ),
  collocations = jsonb_build_array('customer care', 'take care', 'care about', 'health care'),
  patterns = jsonb_build_array('take care of + noun', 'care about + noun', 'noun + care'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'care' AND cefr_receptive = 'A1';

-- catch
UPDATE lexicon_entries SET
  ipa = '/kætʃ/',
  definition_simple = 'to capture or get hold of something moving',
  definition_teacher = 'Verb meaning to capture, understand, or become infected. In business, used for catching up, catching attention, or catching mistakes.',
  usage_notes = 'Irregular verb: catch, caught, caught. Multiple meanings: capture, understand, or notice. Very versatile in business.',
  examples = jsonb_build_array(
    'Let me catch you up on the latest developments.',
    'We need to catch up with our competitors.',
    'Did you catch what she said in the meeting?',
    'The report caught several errors before publication.'
  ),
  collocations = jsonb_build_array('catch up', 'catch attention', 'catch on', 'catch a mistake'),
  patterns = jsonb_build_array('catch up with + noun', 'catch + possessive + attention', 'catch + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'catch' AND cefr_receptive = 'A1';

-- centre (center)
UPDATE lexicon_entries SET
  ipa = '/ˈsentər/',
  definition_simple = 'the middle point or main part of something',
  definition_teacher = 'Noun meaning the middle or main location. Essential in business for call centers, cost centers, and being central to operations.',
  usage_notes = 'Spelled "centre" in UK, "center" in US. Can be noun (the centre) or verb (centre on).',
  examples = jsonb_build_array(
    'The call centre handles customer inquiries.',
    'Our office is located in the city centre.',
    'The discussion centred on cost reduction.',
    'The training centre offers various courses.'
  ),
  collocations = jsonb_build_array('call centre', 'city centre', 'cost centre', 'training centre'),
  patterns = jsonb_build_array('noun + centre', 'in the centre of + noun', 'centre on + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'centre' AND cefr_receptive = 'A1';

-- certain
UPDATE lexicon_entries SET
  ipa = '/ˈsɜːrtən/',
  definition_simple = 'sure or definite, or some but not all',
  definition_teacher = 'Adjective meaning sure, definite, or specific but not named. Common in business for expressing certainty or referring to specific items.',
  usage_notes = 'Two main meanings: "sure/definite" or "some specific". Meaning depends on position (certain to succeed vs. certain people).',
  examples = jsonb_build_array(
    'We are certain that this strategy will work.',
    'Certain conditions must be met before approval.',
    'It''s certain that costs will increase next year.',
    'Certain employees will receive additional training.'
  ),
  collocations = jsonb_build_array('make certain', 'for certain', 'certain conditions', 'certain extent'),
  patterns = jsonb_build_array('be certain that + clause', 'certain + noun', 'to a certain extent'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'certain' AND cefr_receptive = 'A1';

-- chance
UPDATE lexicon_entries SET
  ipa = '/tʃæns/',
  definition_simple = 'a possibility or opportunity for something to happen',
  definition_teacher = 'Noun meaning opportunity, possibility, or risk. Essential in business for discussing opportunities and probabilities.',
  usage_notes = 'Can mean "opportunity" (give someone a chance) or "probability" (there''s a chance). Very common in business.',
  examples = jsonb_build_array(
    'This is a great chance to expand into new markets.',
    'There''s a good chance we''ll meet the deadline.',
    'Don''t miss this chance to improve your skills.',
    'We should take a chance on this innovative approach.'
  ),
  collocations = jsonb_build_array('take a chance', 'good chance', 'by chance', 'chance of'),
  patterns = jsonb_build_array('a chance to + infinitive', 'take a chance on + noun', 'there''s a chance that + clause'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'chance' AND cefr_receptive = 'A1';

-- chief
UPDATE lexicon_entries SET
  ipa = '/tʃiːf/',
  definition_simple = 'most important, or the person in charge',
  definition_teacher = 'Adjective meaning main/primary or noun meaning leader. Very common in business titles (Chief Executive Officer, Chief Financial Officer).',
  usage_notes = 'As adjective: means "main" or "primary". As noun: means "leader". Very common in executive titles.',
  examples = jsonb_build_array(
    'The chief reason for the delay was lack of resources.',
    'She is the Chief Operating Officer of the company.',
    'Our chief concern is customer satisfaction.',
    'The Chief Financial Officer presented the quarterly results.'
  ),
  collocations = jsonb_build_array('chief executive', 'chief concern', 'chief reason', 'chief officer'),
  patterns = jsonb_build_array('chief + noun', 'Chief + Title + Officer'),
  register = 'formal',
  variety = 'international'
WHERE headword = 'chief' AND cefr_receptive = 'A1';

-- church
UPDATE lexicon_entries SET
  ipa = '/tʃɜːrtʃ/',
  definition_simple = 'a building for Christian religious activities',
  definition_teacher = 'Noun referring to a religious building or institution. In business contexts, may appear when discussing locations or community relations.',
  usage_notes = 'Countable noun. Less common in business contexts unless discussing community relations or locations.',
  examples = jsonb_build_array(
    'The office is located near the old church.',
    'The company supports local churches through donations.',
    'The conference venue is next to the church.',
    'Community outreach includes partnerships with churches.'
  ),
  collocations = jsonb_build_array('go to church', 'local church', 'church community', 'near the church'),
  patterns = jsonb_build_array('go to church', 'the/a + adjective + church'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'church' AND cefr_receptive = 'A1';

-- circle
UPDATE lexicon_entries SET
  ipa = '/ˈsɜːrkəl/',
  definition_simple = 'a round shape, or a group of people',
  definition_teacher = 'Noun meaning a round shape or a group with shared interests. In business, used for quality circles, inner circles, or circular processes.',
  usage_notes = 'Can be literal (geometric shape) or figurative (circle of friends, business circles). Also used as verb (circle back).',
  examples = jsonb_build_array(
    'Let''s circle back to this topic next week.',
    'She moves in influential business circles.',
    'The quality circle meets monthly to discuss improvements.',
    'We''re going in circles - we need a new approach.'
  ),
  collocations = jsonb_build_array('circle back', 'business circles', 'quality circle', 'inner circle'),
  patterns = jsonb_build_array('circle back to + noun', 'in + adjective + circles', 'go in circles'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'circle' AND cefr_receptive = 'A1';

-- clean
UPDATE lexicon_entries SET
  ipa = '/kliːn/',
  definition_simple = 'free from dirt or marks, or morally good',
  definition_teacher = 'Adjective or verb meaning free from dirt, clear, or honest. In business, used for clean data, clean slate, or clean record.',
  usage_notes = 'Can be adjective (clean data) or verb (clean up). Common in business for data quality and fresh starts.',
  examples = jsonb_build_array(
    'We need clean data for accurate analysis.',
    'Let''s start with a clean slate for the new project.',
    'The company has a clean record with regulators.',
    'We need to clean up these processes.'
  ),
  collocations = jsonb_build_array('clean data', 'clean slate', 'clean record', 'clean up'),
  patterns = jsonb_build_array('clean + noun', 'clean up + noun', 'a clean + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'clean' AND cefr_receptive = 'A1';

-- clear
UPDATE lexicon_entries SET
  ipa = '/klɪər/',
  definition_simple = 'easy to understand or see, or obvious',
  definition_teacher = 'Adjective meaning transparent, obvious, or unambiguous. Essential in business for clear communication, clear goals, and clarity.',
  usage_notes = 'Very important in business contexts. Can mean "obvious", "transparent", or "unobstructed". Also used as verb (clear up confusion).',
  examples = jsonb_build_array(
    'Please make sure the instructions are clear.',
    'We need clear communication across all teams.',
    'The goals for this quarter are clear.',
    'Let me clear up any confusion about the policy.'
  ),
  collocations = jsonb_build_array('make clear', 'clear communication', 'clear goals', 'clear up'),
  patterns = jsonb_build_array('make + noun + clear', 'clear + noun', 'clear up + noun', 'it''s clear that + clause'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'clear' AND cefr_receptive = 'A1';

-- clock
UPDATE lexicon_entries SET
  ipa = '/klɒk/',
  definition_simple = 'a device that shows what time it is',
  definition_teacher = 'Noun referring to a timepiece. In business, used in phrases like "around the clock", "clock in/out", or "beat the clock".',
  usage_notes = 'Countable noun. Common in business idioms about time and continuous operation.',
  examples = jsonb_build_array(
    'The support team works around the clock.',
    'Employees must clock in when they arrive.',
    'We''re racing against the clock to finish.',
    'The project runs 24/7, around the clock.'
  ),
  collocations = jsonb_build_array('around the clock', 'clock in/out', 'against the clock', 'beat the clock'),
  patterns = jsonb_build_array('around the clock', 'clock in/out', 'against the clock'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'clock' AND cefr_receptive = 'A1';

-- club
UPDATE lexicon_entries SET
  ipa = '/klʌb/',
  definition_simple = 'an organization of people with a shared interest',
  definition_teacher = 'Noun meaning an association or organization. In business, refers to professional clubs, membership programs, or exclusive groups.',
  usage_notes = 'Countable noun. Can mean social organization, professional association, or membership program.',
  examples = jsonb_build_array(
    'She joined the business networking club.',
    'Our loyalty club offers exclusive benefits.',
    'The executive club meets quarterly.',
    'Membership in the club provides valuable connections.'
  ),
  collocations = jsonb_build_array('business club', 'loyalty club', 'join a club', 'club member'),
  patterns = jsonb_build_array('join a/the club', 'club + noun', 'member of + club'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'club' AND cefr_receptive = 'A1';

-- coast
UPDATE lexicon_entries SET
  ipa = '/kəʊst/',
  definition_simple = 'the land next to or near the sea',
  definition_teacher = 'Noun meaning seashore or shoreline. In business, used literally for coastal locations or in phrase "the coast is clear".',
  usage_notes = 'Countable noun. Can be literal (geographic) or in idiom "the coast is clear" (safe to proceed).',
  examples = jsonb_build_array(
    'The company has offices on both coasts.',
    'Coastal regions offer strategic shipping advantages.',
    'The coast is clear - we can proceed with the announcement.',
    'East coast operations differ from west coast operations.'
  ),
  collocations = jsonb_build_array('the coast is clear', 'east/west coast', 'coastal region', 'along the coast'),
  patterns = jsonb_build_array('the coast is clear', 'on the + direction + coast', 'along the coast'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'coast' AND cefr_receptive = 'A1';

-- college
UPDATE lexicon_entries SET
  ipa = '/ˈkɒlɪdʒ/',
  definition_simple = 'an educational institution for higher learning',
  definition_teacher = 'Noun referring to a higher education institution. In business, relevant for discussing education requirements and recruitment.',
  usage_notes = 'Countable noun. In US, often means university; in UK, can mean different types of educational institutions.',
  examples = jsonb_build_array(
    'The position requires a college degree.',
    'We recruit from top business colleges.',
    'She attended college in Boston.',
    'College graduates are eligible for the program.'
  ),
  collocations = jsonb_build_array('college degree', 'business college', 'attend college', 'college graduate'),
  patterns = jsonb_build_array('college + noun', 'attend/go to college'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'college' AND cefr_receptive = 'A1';

-- colour (color)
UPDATE lexicon_entries SET
  ipa = '/ˈkʌlər/',
  definition_simple = 'red, blue, green, etc., or the appearance of things',
  definition_teacher = 'Noun referring to hue or appearance. In business, used for branding, design, and adding detail or interest.',
  usage_notes = 'Spelled "colour" in UK, "color" in US. Can be countable (colors) or uncountable (color in general).',
  examples = jsonb_build_array(
    'Brand colors should be consistent across all materials.',
    'The presentation needs more color and visual interest.',
    'Please add some color to the report with examples.',
    'The company colors are blue and white.'
  ),
  collocations = jsonb_build_array('brand color', 'add color', 'color scheme', 'in color'),
  patterns = jsonb_build_array('brand/company + color(s)', 'add color to + noun', 'in color'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'colour' AND cefr_receptive = 'A1';

-- command
UPDATE lexicon_entries SET
  ipa = '/kəˈmɑːnd/',
  definition_simple = 'to give an order, or to have control over',
  definition_teacher = 'Verb or noun meaning to order, control, or deserve. In business, used for commanding respect, command of language, or chain of command.',
  usage_notes = 'Can be verb (command respect) or noun (chain of command). Formal tone in business contexts.',
  examples = jsonb_build_array(
    'She commands respect from her team.',
    'The manager has excellent command of English.',
    'Follow the chain of command for approvals.',
    'His expertise commands a high salary.'
  ),
  collocations = jsonb_build_array('command respect', 'chain of command', 'command of language', 'command attention'),
  patterns = jsonb_build_array('command + noun', 'command of + noun', 'chain of command'),
  register = 'formal',
  variety = 'international'
WHERE headword = 'command' AND cefr_receptive = 'A1';

-- common
UPDATE lexicon_entries SET
  ipa = '/ˈkɒmən/',
  definition_simple = 'happening or found often, or shared by many',
  definition_teacher = 'Adjective meaning frequent, usual, or shared. Essential in business for common practices, common ground, and frequency.',
  usage_notes = 'Very common word in business. Can mean "frequent", "usual", "ordinary", or "shared".',
  examples = jsonb_build_array(
    'This is a common problem in the industry.',
    'We need to find common ground with the client.',
    'Common sense should guide decision-making.',
    'It''s common practice to send a follow-up email.'
  ),
  collocations = jsonb_build_array('common practice', 'common ground', 'common sense', 'common problem'),
  patterns = jsonb_build_array('common + noun', 'find common ground', 'it''s common to + infinitive'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'common' AND cefr_receptive = 'A1';

-- corner
UPDATE lexicon_entries SET
  ipa = '/ˈkɔːrnər/',
  definition_simple = 'the point where two lines, edges, or sides meet',
  definition_teacher = 'Noun meaning an angle or difficult position. In business, used for "around the corner", "corner the market", or "tight corner".',
  usage_notes = 'Can be literal (physical corner) or figurative (in a corner, around the corner). Common in business idioms.',
  examples = jsonb_build_array(
    'The new product launch is just around the corner.',
    'The company has cornered the market in this segment.',
    'We''re in a tight corner with this budget issue.',
    'The office is located on the corner of Main Street.'
  ),
  collocations = jsonb_build_array('around the corner', 'corner the market', 'tight corner', 'on the corner'),
  patterns = jsonb_build_array('around the corner', 'corner the market', 'in a corner'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'corner' AND cefr_receptive = 'A1';

-- council
UPDATE lexicon_entries SET
  ipa = '/ˈkaʊnsəl/',
  definition_simple = 'a group of people elected or chosen to make decisions',
  definition_teacher = 'Noun meaning an advisory or governing body. In business, refers to advisory councils, executive councils, or governing bodies.',
  usage_notes = 'Countable noun. Don''t confuse with "counsel" (advice). Common in formal organizational structures.',
  examples = jsonb_build_array(
    'The advisory council meets quarterly.',
    'She was appointed to the executive council.',
    'The council approved the new policy.',
    'Council members represent different departments.'
  ),
  collocations = jsonb_build_array('advisory council', 'executive council', 'council member', 'council meeting'),
  patterns = jsonb_build_array('adjective + council', 'council + noun', 'member of the council'),
  register = 'formal',
  variety = 'international'
WHERE headword = 'council' AND cefr_receptive = 'A1';

-- count
UPDATE lexicon_entries SET
  ipa = '/kaʊnt/',
  definition_simple = 'to say numbers in order, or to include in a total',
  definition_teacher = 'Verb meaning to enumerate, include, or matter. In business, used for counting on someone, making things count, or what counts.',
  usage_notes = 'Can mean "enumerate", "include", "rely on", or "matter". Very versatile in business contexts.',
  examples = jsonb_build_array(
    'You can count on our team to deliver.',
    'Every customer interaction counts.',
    'Please count me in for the project.',
    'We need to make every dollar count.'
  ),
  collocations = jsonb_build_array('count on', 'count in', 'make it count', 'every minute counts'),
  patterns = jsonb_build_array('count on + noun/person', 'count + person + in/out', 'noun + counts'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'count' AND cefr_receptive = 'A1';

-- court
UPDATE lexicon_entries SET
  ipa = '/kɔːrt/',
  definition_simple = 'a place where legal trials happen, or an area for playing sports',
  definition_teacher = 'Noun meaning legal tribunal or sports area. In business, refers to legal proceedings, courting clients, or ball being in someone''s court.',
  usage_notes = 'Multiple meanings: legal court, sports court, or royal court. Common in business legal contexts.',
  examples = jsonb_build_array(
    'The case will be decided in court next month.',
    'We need to court new investors for expansion.',
    'The ball is in their court now - we''re waiting for a response.',
    'Out-of-court settlements are often preferable.'
  ),
  collocations = jsonb_build_array('in court', 'court case', 'out of court', 'ball is in your court'),
  patterns = jsonb_build_array('in/to court', 'court + noun', 'the ball is in + possessive + court'),
  register = 'formal',
  variety = 'international'
WHERE headword = 'court' AND cefr_receptive = 'A1';

-- creature
UPDATE lexicon_entries SET
  ipa = '/ˈkriːtʃər/',
  definition_simple = 'a living thing, especially an animal',
  definition_teacher = 'Noun referring to a living being. In business, occasionally used in phrase "creature of habit" or "creature comforts".',
  usage_notes = 'Countable noun. Less common in business contexts except in specific idioms.',
  examples = jsonb_build_array(
    'He''s a creature of habit - always follows the same routine.',
    'The office provides creature comforts like coffee and snacks.',
    'Humans are social creatures who need interaction.',
    'The company policy protects all living creatures.'
  ),
  collocations = jsonb_build_array('creature of habit', 'creature comforts', 'living creature', 'social creature'),
  patterns = jsonb_build_array('a creature of + noun', 'creature + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'creature' AND cefr_receptive = 'A1';

-- cross
UPDATE lexicon_entries SET
  ipa = '/krɒs/',
  definition_simple = 'to go from one side to the other, or angry',
  definition_teacher = 'Verb meaning to traverse or intersect, or adjective meaning angry. In business, used for crossing paths, cross-functional, or crossing lines.',
  usage_notes = 'Multiple uses: verb (cross the street), adjective (cross with someone), or prefix (cross-functional).',
  examples = jsonb_build_array(
    'We need cross-functional collaboration on this project.',
    'Let''s cross that bridge when we come to it.',
    'The manager was cross about the missed deadline.',
    'Our paths crossed at the conference last year.'
  ),
  collocations = jsonb_build_array('cross-functional', 'cross paths', 'cross that bridge', 'cross off'),
  patterns = jsonb_build_array('cross + noun', 'cross-functional + noun', 'cross paths with + person'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'cross' AND cefr_receptive = 'A1';

-- crowd
UPDATE lexicon_entries SET
  ipa = '/kraʊd/',
  definition_simple = 'a large number of people gathered together',
  definition_teacher = 'Noun or verb meaning a large group or to gather in large numbers. In business, used for crowdfunding, crowdsourcing, or standing out from the crowd.',
  usage_notes = 'Can be noun (a crowd) or verb (crowd into). Common in business for crowd-related concepts.',
  examples = jsonb_build_array(
    'We used crowdfunding to launch the product.',
    'The company stands out from the crowd with innovation.',
    'Crowdsourcing ideas can generate creative solutions.',
    'Don''t follow the crowd - think independently.'
  ),
  collocations = jsonb_build_array('stand out from the crowd', 'crowdfunding', 'crowdsourcing', 'follow the crowd'),
  patterns = jsonb_build_array('stand out from the crowd', 'crowd + noun (crowdfunding)', 'follow the crowd'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'crowd' AND cefr_receptive = 'A1';

-- cry
UPDATE lexicon_entries SET
  ipa = '/kraɪ/',
  definition_simple = 'to produce tears, or to shout loudly',
  definition_teacher = 'Verb or noun meaning to weep or shout. In business, used in phrases like "far cry from" or "crying need".',
  usage_notes = 'Can mean "weep" or "shout". In business, more common in idioms than literal usage.',
  examples = jsonb_build_array(
    'This result is a far cry from what we expected.',
    'There''s a crying need for better communication.',
    'Don''t cry over spilled milk - learn and move forward.',
    'The market is crying out for this type of solution.'
  ),
  collocations = jsonb_build_array('far cry from', 'crying need', 'cry out for', 'cry over spilled milk'),
  patterns = jsonb_build_array('a far cry from + noun', 'a crying need for + noun', 'cry out for + noun'),
  register = 'informal',
  variety = 'international'
WHERE headword = 'cry' AND cefr_receptive = 'A1';

-- current
UPDATE lexicon_entries SET
  ipa = '/ˈkʌrənt/',
  definition_simple = 'happening or existing now',
  definition_teacher = 'Adjective meaning present, contemporary, or up-to-date. Essential in business for current situation, current trends, and staying current.',
  usage_notes = 'Very common in business. Always refers to the present time or most recent version.',
  examples = jsonb_build_array(
    'Let''s review the current situation.',
    'Current market trends favor our product.',
    'Please update me on current developments.',
    'The current system needs improvement.'
  ),
  collocations = jsonb_build_array('current situation', 'current trends', 'current system', 'stay current'),
  patterns = jsonb_build_array('current + noun', 'stay/keep current'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'current' AND cefr_receptive = 'A1';

-- custom
UPDATE lexicon_entries SET
  ipa = '/ˈkʌstəm/',
  definition_simple = 'a traditional way of behaving, or made specially for someone',
  definition_teacher = 'Noun meaning tradition or adjective meaning customized. In business, used for customs (traditions), customer customs, or custom-made products.',
  usage_notes = 'Can be noun (customs and traditions) or adjective (custom-made). Note: "customs" (plural) also means import/export regulations.',
  examples = jsonb_build_array(
    'We offer custom solutions for each client.',
    'Understanding local business customs is important.',
    'The product is custom-made to your specifications.',
    'It''s our custom to send thank-you notes to clients.'
  ),
  collocations = jsonb_build_array('custom solution', 'custom-made', 'business customs', 'local custom'),
  patterns = jsonb_build_array('custom + noun', 'custom-made + noun', 'it''s + possessive + custom to + infinitive'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'custom' AND cefr_receptive = 'A1';

-- cut
UPDATE lexicon_entries SET
  ipa = '/kʌt/',
  definition_simple = 'to divide or reduce something using a sharp tool or by removing parts',
  definition_teacher = 'Verb or noun meaning to divide, reduce, or eliminate. Essential in business for cost cuts, cutting corners, or making the cut.',
  usage_notes = 'Irregular verb: cut, cut, cut. Very common in business for reductions and eliminations.',
  examples = jsonb_build_array(
    'We need to cut costs by 15% this quarter.',
    'Don''t cut corners on quality.',
    'The proposal didn''t make the cut.',
    'Budget cuts will affect all departments.'
  ),
  collocations = jsonb_build_array('cut costs', 'cut corners', 'make the cut', 'budget cuts'),
  patterns = jsonb_build_array('cut + noun', 'cut corners', 'make the cut', 'noun + cuts'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'cut' AND cefr_receptive = 'A1';

-- dance
UPDATE lexicon_entries SET
  ipa = '/dæns/',
  definition_simple = 'to move your body to music',
  definition_teacher = 'Verb or noun meaning rhythmic movement. In business, used metaphorically in phrases like "dance around the issue".',
  usage_notes = 'Can be literal (physical dancing) or figurative (dance around a topic). Less common in formal business.',
  examples = jsonb_build_array(
    'Stop dancing around the issue - be direct.',
    'The company annual party includes dinner and dancing.',
    'We can''t dance to their tune - we need independence.',
    'It takes two to tango - both parties must cooperate.'
  ),
  collocations = jsonb_build_array('dance around', 'dance to someone''s tune', 'song and dance', 'it takes two to tango'),
  patterns = jsonb_build_array('dance around + noun', 'dance to + possessive + tune'),
  register = 'informal',
  variety = 'international'
WHERE headword = 'dance' AND cefr_receptive = 'A1';

-- danger
UPDATE lexicon_entries SET
  ipa = '/ˈdeɪndʒər/',
  definition_simple = 'the possibility of harm or death',
  definition_teacher = 'Noun meaning risk or threat. In business, used for discussing risks, danger zones, or being in danger of failure.',
  usage_notes = 'Uncountable when general (in danger), countable when specific (dangers of). Common in risk discussions.',
  examples = jsonb_build_array(
    'The project is in danger of missing the deadline.',
    'There''s a danger that costs will exceed budget.',
    'We need to identify potential dangers early.',
    'The company is out of danger financially.'
  ),
  collocations = jsonb_build_array('in danger', 'danger of', 'out of danger', 'potential danger'),
  patterns = jsonb_build_array('in danger of + gerund', 'there''s a danger that + clause', 'danger + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'danger' AND cefr_receptive = 'A1';

-- dare
UPDATE lexicon_entries SET
  ipa = '/deər/',
  definition_simple = 'to be brave enough to do something',
  definition_teacher = 'Verb meaning to have courage or to challenge someone. In business, used for daring to innovate or taking bold actions.',
  usage_notes = 'Can mean "have courage" (dare to try) or "challenge" (I dare you). Often used with infinitive without "to".',
  examples = jsonb_build_array(
    'We need to dare to innovate in this competitive market.',
    'Few companies dare to challenge the industry leader.',
    'She dared to propose a completely new approach.',
    'Don''t dare to compromise on quality standards.'
  ),
  collocations = jsonb_build_array('dare to', 'dare say', 'how dare', 'don''t dare'),
  patterns = jsonb_build_array('dare to + infinitive', 'dare + infinitive (without to)', 'don''t dare + infinitive'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'dare' AND cefr_receptive = 'A1';

-- dark
UPDATE lexicon_entries SET
  ipa = '/dɑːrk/',
  definition_simple = 'with little or no light, or having a deep color',
  definition_teacher = 'Adjective meaning lacking light or having deep color. In business, used for "in the dark" (uninformed) or "dark horse" (unexpected competitor).',
  usage_notes = 'Can be literal (dark room) or figurative (dark times, in the dark). Common in business idioms.',
  examples = jsonb_build_array(
    'The team was kept in the dark about the changes.',
    'We''re facing dark times economically.',
    'The competitor emerged as a dark horse in the market.',
    'After dark, the office building is closed.'
  ),
  collocations = jsonb_build_array('in the dark', 'dark times', 'dark horse', 'after dark'),
  patterns = jsonb_build_array('in the dark about + noun', 'dark + noun', 'a dark horse'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'dark' AND cefr_receptive = 'A1';

-- date
UPDATE lexicon_entries SET
  ipa = '/deɪt/',
  definition_simple = 'a particular day of the month or year',
  definition_teacher = 'Noun or verb meaning a specific day or to determine age. Essential in business for deadlines, dates, and staying up to date.',
  usage_notes = 'Very common in business. Can be noun (the date) or verb (date back to). Important for scheduling and deadlines.',
  examples = jsonb_build_array(
    'What''s the date of the next meeting?',
    'Please save the date for our annual conference.',
    'We need to set a date for the product launch.',
    'Make sure all documents are up to date.'
  ),
  collocations = jsonb_build_array('save the date', 'set a date', 'up to date', 'due date'),
  patterns = jsonb_build_array('set/save the date', 'up to date', 'date + for + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'date' AND cefr_receptive = 'A1';

-- daughter
UPDATE lexicon_entries SET
  ipa = '/ˈdɔːtər/',
  definition_simple = 'a female child',
  definition_teacher = 'Noun referring to a female offspring. In business, appears in "daughter company" (subsidiary).',
  usage_notes = 'Countable noun. In business contexts, mainly appears in "daughter company" meaning subsidiary.',
  examples = jsonb_build_array(
    'The daughter company operates independently.',
    'She is the daughter of the company founder.',
    'Our daughter companies are located in five countries.',
    'The parent company oversees all daughter companies.'
  ),
  collocations = jsonb_build_array('daughter company', 'parent and daughter company', 'wholly-owned daughter'),
  patterns = jsonb_build_array('daughter + noun (company)', 'daughter of + person'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'daughter' AND cefr_receptive = 'A1';

-- dead
UPDATE lexicon_entries SET
  ipa = '/ded/',
  definition_simple = 'no longer alive, or complete/absolute',
  definition_teacher = 'Adjective meaning deceased or complete. In business, used for deadlines, dead end, dead in the water, or dead on arrival.',
  usage_notes = 'Can be literal (not alive) or figurative (dead tired, dead end, dead serious). Common in business idioms.',
  examples = jsonb_build_array(
    'The project is dead in the water without funding.',
    'We''ve reached a dead end with this approach.',
    'The proposal was dead on arrival.',
    'There''s a dead silence after the announcement.'
  ),
  collocations = jsonb_build_array('dead end', 'dead in the water', 'dead on arrival', 'dead serious'),
  patterns = jsonb_build_array('dead + noun', 'dead in the water', 'a dead end'),
  register = 'informal',
  variety = 'international'
WHERE headword = 'dead' AND cefr_receptive = 'A1';

-- declare
UPDATE lexicon_entries SET
  ipa = '/dɪˈkleər/',
  definition_simple = 'to announce something officially or firmly',
  definition_teacher = 'Verb meaning to announce formally or state clearly. In business, used for declaring results, intentions, or customs declarations.',
  usage_notes = 'Formal verb. Common in business for official announcements, declarations, and customs.',
  examples = jsonb_build_array(
    'The CEO declared the merger a success.',
    'We need to declare all income for tax purposes.',
    'The company declared bankruptcy last month.',
    'Please declare any conflicts of interest.'
  ),
  collocations = jsonb_build_array('declare bankruptcy', 'declare income', 'declare interest', 'declare results'),
  patterns = jsonb_build_array('declare + noun', 'declare that + clause', 'declare + noun + adjective'),
  register = 'formal',
  variety = 'international'
WHERE headword = 'declare' AND cefr_receptive = 'A1';

-- deep
UPDATE lexicon_entries SET
  ipa = '/diːp/',
  definition_simple = 'extending far down or inward, or intense',
  definition_teacher = 'Adjective meaning extending far down, profound, or intense. In business, used for deep analysis, deep pockets, or in deep trouble.',
  usage_notes = 'Can be literal (deep water) or figurative (deep analysis, deep trouble). Very versatile in business.',
  examples = jsonb_build_array(
    'We need a deep analysis of the market.',
    'The company has deep pockets for investment.',
    'The project is in deep trouble.',
    'Let''s take a deep dive into the data.'
  ),
  collocations = jsonb_build_array('deep analysis', 'deep pockets', 'in deep trouble', 'deep dive'),
  patterns = jsonb_build_array('deep + noun', 'in deep + noun', 'take a deep dive into + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'deep' AND cefr_receptive = 'A1';

-- degree
UPDATE lexicon_entries SET
  ipa = '/dɪˈɡriː/',
  definition_simple = 'a unit of measurement, or an academic qualification',
  definition_teacher = 'Noun meaning academic qualification, unit of measurement, or extent. Essential in business for education requirements and expressing extent.',
  usage_notes = 'Multiple meanings: academic degree, measurement unit, or extent (to some degree). Context determines meaning.',
  examples = jsonb_build_array(
    'The position requires a university degree.',
    'She has a degree in business administration.',
    'To some degree, all departments are affected.',
    'The plan succeeded to a large degree.'
  ),
  collocations = jsonb_build_array('university degree', 'to some degree', 'to a large degree', 'degree in'),
  patterns = jsonb_build_array('a degree in + subject', 'to + adjective + degree', 'have/hold a degree'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'degree' AND cefr_receptive = 'A1';

-- desert
UPDATE lexicon_entries SET
  ipa = '/ˈdezərt/',
  definition_simple = 'a large area of land with very little water and few plants',
  definition_teacher = 'Noun meaning arid land. In business, occasionally used metaphorically for "desert" (abandon) or describing barren markets.',
  usage_notes = 'As noun: /ˈdezərt/ (dry land). As verb: /dɪˈzɜːrt/ (abandon). Different pronunciation and meaning.',
  examples = jsonb_build_array(
    'The market has become a competitive desert.',
    'Don''t desert your team during difficult times.',
    'The region is an economic desert with few opportunities.',
    'Desert conditions require special equipment.'
  ),
  collocations = jsonb_build_array('desert region', 'economic desert', 'desert conditions', 'desert someone'),
  patterns = jsonb_build_array('desert + noun', 'desert + person/team'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'desert' AND cefr_receptive = 'A1';

-- desire
UPDATE lexicon_entries SET
  ipa = '/dɪˈzaɪər/',
  definition_simple = 'a strong feeling of wanting something',
  definition_teacher = 'Noun or verb meaning strong wish or wanting. In business, used for expressing wants, desires, or desirable outcomes.',
  usage_notes = 'Can be noun (a desire) or verb (to desire). Formal tone. Common in business for expressing goals and wants.',
  examples = jsonb_build_array(
    'The company has a strong desire to expand globally.',
    'We desire to maintain the highest quality standards.',
    'Customer desires drive product development.',
    'The desired outcome is increased market share.'
  ),
  collocations = jsonb_build_array('desire to', 'strong desire', 'desired outcome', 'desire for'),
  patterns = jsonb_build_array('desire to + infinitive', 'a desire for + noun', 'desired + noun'),
  register = 'formal',
  variety = 'international'
WHERE headword = 'desire' AND cefr_receptive = 'A1';
