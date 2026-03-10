-- Enhancement of A1 Vocabulary - Batch 5 (100 words: return → strong)
-- Professional English context for Brazilian learners
-- Migration: 20260310000017

-- return
UPDATE lexicon_entries SET
  ipa = '/rɪˈtɜːrn/',
  definition_simple = 'to go back or give something back',
  definition_teacher = 'Verb or noun meaning to come back or give back. Essential in business for returns, ROI (return on investment).',
  usage_notes = 'Very common in business. Can mean "go back", "give back", or "profit" (noun). Multiple business uses.',
  examples = jsonb_build_array(
    'Please return the signed contract by Friday.',
    'The return on investment was 15% this year.',
    'She will return from vacation next week.',
    'Customers can return products within 30 days.'
  ),
  collocations = jsonb_build_array('return on investment', 'in return', 'return to', 'return policy'),
  patterns = jsonb_build_array('return + noun', 'return to + place', 'in return for + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'return' AND cefr_receptive = 'A1';

-- rich
UPDATE lexicon_entries SET
  ipa = '/rɪtʃ/',
  definition_simple = 'having a lot of money or valuable things',
  definition_teacher = 'Adjective meaning wealthy or abundant. In business, used for rich resources, rich experience, or wealthy.',
  usage_notes = 'Can mean "wealthy" (rich person) or "abundant" (rich in resources). Context determines meaning.',
  examples = jsonb_build_array(
    'The region is rich in natural resources.',
    'She has rich experience in international business.',
    'The company targets rich markets.',
    'This dataset is rich with valuable insights.'
  ),
  collocations = jsonb_build_array('rich in', 'rich experience', 'rich resources', 'rich market'),
  patterns = jsonb_build_array('rich in + noun', 'rich + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'rich' AND cefr_receptive = 'A1';

-- ride
UPDATE lexicon_entries SET
  ipa = '/raɪd/',
  definition_simple = 'to travel on or in a vehicle or animal',
  definition_teacher = 'Verb or noun meaning to travel or a journey. In business, used in phrases like "along for the ride".',
  usage_notes = 'Can be literal (ride a bike) or figurative (ride out the storm). Irregular: ride, rode, ridden.',
  examples = jsonb_build_array(
    'We need to ride out this economic downturn.',
    'The company is riding a wave of success.',
    'It''s been quite a ride building this business.',
    'Some investors are just along for the ride.'
  ),
  collocations = jsonb_build_array('ride out', 'along for the ride', 'ride a wave', 'rough ride'),
  patterns = jsonb_build_array('ride out + noun', 'ride a wave of + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'ride' AND cefr_receptive = 'A1';

-- ring
UPDATE lexicon_entries SET
  ipa = '/rɪŋ/',
  definition_simple = 'a circular band, or to make a bell sound',
  definition_teacher = 'Noun or verb meaning circular object or to call. In business, used for phone calls or circular arrangements.',
  usage_notes = 'Multiple meanings: jewelry, phone call (UK), or circular shape. "Give someone a ring" = call them (UK).',
  examples = jsonb_build_array(
    'I''ll give you a ring tomorrow to discuss the proposal.',
    'The phone is ringing - please answer it.',
    'We arranged the chairs in a ring for the meeting.',
    'That name rings a bell - I think we''ve met before.'
  ),
  collocations = jsonb_build_array('give a ring', 'ring a bell', 'phone ring', 'ring back'),
  patterns = jsonb_build_array('give + person + a ring', 'ring a bell', 'ring + person'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'ring' AND cefr_receptive = 'A1';

-- rise
UPDATE lexicon_entries SET
  ipa = '/raɪz/',
  definition_simple = 'to move upward or increase',
  definition_teacher = 'Verb or noun meaning to go up or increase. Essential in business for rising costs, prices, or growth.',
  usage_notes = 'Irregular verb: rise, rose, risen. Very common in business for increases and growth. Different from "raise".',
  examples = jsonb_build_array(
    'Costs have risen by 10% this year.',
    'The company experienced a rapid rise in sales.',
    'Stock prices rose sharply after the announcement.',
    'We need to address rising customer complaints.'
  ),
  collocations = jsonb_build_array('rise in', 'rising costs', 'give rise to', 'on the rise'),
  patterns = jsonb_build_array('rise + by + amount', 'rise in + noun', 'give rise to + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'rise' AND cefr_receptive = 'A1';

-- river
UPDATE lexicon_entries SET
  ipa = '/ˈrɪvər/',
  definition_simple = 'a large natural stream of water',
  definition_teacher = 'Noun meaning a large watercourse. In business, used in location descriptions or metaphorically.',
  usage_notes = 'Countable noun. Can be used literally or in business metaphors about flow and direction.',
  examples = jsonb_build_array(
    'The office is located near the river.',
    'We need to go with the flow, not against the river.',
    'The supply chain flows like a river from source to customer.',
    'River transport is cost-effective for bulk goods.'
  ),
  collocations = jsonb_build_array('near the river', 'river transport', 'go with the flow', 'river of'),
  patterns = jsonb_build_array('near/by the river', 'river + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'river' AND cefr_receptive = 'A1';

-- road
UPDATE lexicon_entries SET
  ipa = '/rəʊd/',
  definition_simple = 'a way between places for vehicles to travel on',
  definition_teacher = 'Noun meaning a route or path. In business, used literally and in phrases like "roadmap" or "on the road".',
  usage_notes = 'Very common in business. Used literally (physical road) and figuratively (road to success, roadmap).',
  examples = jsonb_build_array(
    'The road to success requires hard work.',
    'Our sales team is on the road this week.',
    'We have a clear roadmap for the next quarter.',
    'The office is accessible by road and rail.'
  ),
  collocations = jsonb_build_array('on the road', 'road to', 'roadmap', 'road ahead'),
  patterns = jsonb_build_array('on the road', 'road to + noun', 'the road ahead'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'road' AND cefr_receptive = 'A1';

-- roll
UPDATE lexicon_entries SET
  ipa = '/rəʊl/',
  definition_simple = 'to move by turning over, or a list of names',
  definition_teacher = 'Verb or noun with multiple meanings. In business, used in "roll out" (launch) or "on a roll" (succeeding).',
  usage_notes = 'Multiple meanings: turn over, launch (roll out), or list. Common in business phrasal verbs.',
  examples = jsonb_build_array(
    'We will roll out the new system next month.',
    'The team is on a roll with three successful projects.',
    'Let''s get the ball rolling on this initiative.',
    'The company rolled out updates across all departments.'
  ),
  collocations = jsonb_build_array('roll out', 'on a roll', 'get the ball rolling', 'roll call'),
  patterns = jsonb_build_array('roll out + noun', 'on a roll', 'get the ball rolling'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'roll' AND cefr_receptive = 'A1';

-- rough
UPDATE lexicon_entries SET
  ipa = '/rʌf/',
  definition_simple = 'not smooth or exact, or difficult',
  definition_teacher = 'Adjective meaning uneven, approximate, or difficult. Common in business for rough estimates or rough patches.',
  usage_notes = 'Multiple meanings: not smooth, approximate (rough estimate), or difficult (rough time).',
  examples = jsonb_build_array(
    'This is a rough estimate of the costs.',
    'The company went through a rough patch last year.',
    'Can you give me a rough idea of the timeline?',
    'The rough draft needs significant revision.'
  ),
  collocations = jsonb_build_array('rough estimate', 'rough patch', 'rough idea', 'rough draft'),
  patterns = jsonb_build_array('rough + noun', 'go through a rough patch'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'rough' AND cefr_receptive = 'A1';

-- round
UPDATE lexicon_entries SET
  ipa = '/raʊnd/',
  definition_simple = 'shaped like a circle or sphere',
  definition_teacher = 'Adjective, noun, or preposition with multiple meanings. In business, used for rounds of funding or negotiations.',
  usage_notes = 'Very versatile word. Can mean circular, a stage (round of negotiations), or approximately.',
  examples = jsonb_build_array(
    'We completed the first round of interviews.',
    'The company raised $5 million in Series A round.',
    'Let''s schedule another round of discussions.',
    'Round numbers are easier to remember.'
  ),
  collocations = jsonb_build_array('round of', 'funding round', 'round table', 'round number'),
  patterns = jsonb_build_array('round of + noun', 'round + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'round' AND cefr_receptive = 'A1';

-- rule
UPDATE lexicon_entries SET
  ipa = '/ruːl/',
  definition_simple = 'an official instruction about what is allowed',
  definition_teacher = 'Noun or verb meaning regulation or to govern. Essential in business for rules, regulations, and governance.',
  usage_notes = 'Very common in business. Can be noun (a rule) or verb (to rule/govern). Related: ruling, ruler.',
  examples = jsonb_build_array(
    'Company rules prohibit conflicts of interest.',
    'As a rule, we respond to emails within 24 hours.',
    'The new regulations rule out certain practices.',
    'We need to follow the rules and regulations.'
  ),
  collocations = jsonb_build_array('company rules', 'as a rule', 'rule out', 'rules and regulations'),
  patterns = jsonb_build_array('as a rule', 'rule out + noun', 'follow the rules'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'rule' AND cefr_receptive = 'A1';

-- ruler
UPDATE lexicon_entries SET
  ipa = '/ˈruːlər/',
  definition_simple = 'a person who rules, or a measuring tool',
  definition_teacher = 'Noun meaning a leader or measuring instrument. In business, rarely used for leaders, more for measurement.',
  usage_notes = 'Two meanings: person who governs, or measuring tool. In business, measuring tool is more common.',
  examples = jsonb_build_array(
    'Use a ruler to draw straight lines on the chart.',
    'The ruler shows measurements in centimeters.',
    'We need a ruler to measure the dimensions.',
    'Ancient rulers established trade routes.'
  ),
  collocations = jsonb_build_array('use a ruler', 'measuring ruler', 'straight ruler'),
  patterns = jsonb_build_array('use a ruler', 'ruler + for + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'ruler' AND cefr_receptive = 'A1';

-- rush
UPDATE lexicon_entries SET
  ipa = '/rʌʃ/',
  definition_simple = 'to move or do something very quickly',
  definition_teacher = 'Verb or noun meaning to hurry or urgency. Common in business for rush orders, rush hour, or rushing tasks.',
  usage_notes = 'Can be verb (rush to finish) or noun (in a rush). Very common in business contexts.',
  examples = jsonb_build_array(
    'Don''t rush the decision - take time to analyze.',
    'We have a rush order that needs immediate attention.',
    'There''s no need to rush - the deadline is flexible.',
    'The morning rush hour affects commute times.'
  ),
  collocations = jsonb_build_array('rush order', 'in a rush', 'rush hour', 'rush to'),
  patterns = jsonb_build_array('rush + to infinitive', 'in a rush', 'rush order'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'rush' AND cefr_receptive = 'A1';

-- safe
UPDATE lexicon_entries SET
  ipa = '/seɪf/',
  definition_simple = 'protected from danger or harm',
  definition_teacher = 'Adjective or noun meaning secure or a secure container. Essential in business for safety and security.',
  usage_notes = 'Very common in business. Can be adjective (safe environment) or noun (a safe for valuables).',
  examples = jsonb_build_array(
    'Workplace safety is our top priority.',
    'It''s safe to say that the project will succeed.',
    'Keep important documents in the safe.',
    'We need to ensure safe working conditions.'
  ),
  collocations = jsonb_build_array('safe to say', 'safe environment', 'play it safe', 'safe and sound'),
  patterns = jsonb_build_array('safe to + infinitive', 'safe + noun', 'play it safe'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'safe' AND cefr_receptive = 'A1';

-- sail
UPDATE lexicon_entries SET
  ipa = '/seɪl/',
  definition_simple = 'to travel on water, or to move smoothly',
  definition_teacher = 'Verb or noun meaning to navigate water or move smoothly. In business, used figuratively for smooth progress.',
  usage_notes = 'Can be literal (sail a boat) or figurative (sail through a task). Used in business metaphors.',
  examples = jsonb_build_array(
    'The project sailed through approval without issues.',
    'We need to set sail on this initiative soon.',
    'The transition sailed smoothly.',
    'The proposal sailed through the committee.'
  ),
  collocations = jsonb_build_array('sail through', 'set sail', 'smooth sailing', 'sail past'),
  patterns = jsonb_build_array('sail through + noun', 'set sail on + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'sail' AND cefr_receptive = 'A1';

-- save
UPDATE lexicon_entries SET
  ipa = '/seɪv/',
  definition_simple = 'to keep something safe or keep money for later',
  definition_teacher = 'Verb meaning to rescue, preserve, or economize. Essential in business for saving costs, time, or data.',
  usage_notes = 'Very common in business. Multiple meanings: rescue, preserve, economize, or store (save data).',
  examples = jsonb_build_array(
    'This solution will save time and money.',
    'Please save your work frequently.',
    'The new process saves 20% in costs.',
    'We need to save resources for future projects.'
  ),
  collocations = jsonb_build_array('save time', 'save money', 'save costs', 'save data'),
  patterns = jsonb_build_array('save + noun', 'save + amount + in + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'save' AND cefr_receptive = 'A1';

-- saw
UPDATE lexicon_entries SET
  ipa = '/sɔː/',
  definition_simple = 'past tense of see, or a cutting tool',
  definition_teacher = 'Verb (past of see) or noun (cutting tool). In business, mainly used as past tense of "see".',
  usage_notes = 'Two meanings: past tense of "see" (most common in business) or cutting tool (less common).',
  examples = jsonb_build_array(
    'We saw significant growth last quarter.',
    'I saw the report you sent yesterday.',
    'The team saw an opportunity and acted quickly.',
    'She saw the potential in the new market.'
  ),
  collocations = jsonb_build_array('saw growth', 'saw an opportunity', 'saw potential', 'as we saw'),
  patterns = jsonb_build_array('saw + noun', 'saw that + clause'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'saw' AND cefr_receptive = 'A1';

-- scale
UPDATE lexicon_entries SET
  ipa = '/skeɪl/',
  definition_simple = 'the size or level of something, or to climb',
  definition_teacher = 'Noun or verb meaning size, measurement system, or to climb. Essential in business for scale and scaling.',
  usage_notes = 'Very common in business. Can mean size (large scale), measurement (scale of 1-10), or to grow (scale up).',
  examples = jsonb_build_array(
    'We need to scale up operations to meet demand.',
    'The project is large scale and complex.',
    'On a scale of 1 to 10, how satisfied are you?',
    'Economies of scale reduce unit costs.'
  ),
  collocations = jsonb_build_array('scale up', 'large scale', 'economies of scale', 'on a scale'),
  patterns = jsonb_build_array('scale up/down + noun', 'on a scale of + numbers', 'large/small scale'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'scale' AND cefr_receptive = 'A1';

-- scarce
UPDATE lexicon_entries SET
  ipa = '/skeərs/',
  definition_simple = 'not enough, rare or hard to find',
  definition_teacher = 'Adjective meaning insufficient or rare. Common in business for discussing limited resources or scarcity.',
  usage_notes = 'Formal adjective. Common in business for scarce resources, scarce talent, or scarcity.',
  examples = jsonb_build_array(
    'Skilled workers are scarce in this market.',
    'Resources are scarce, so we must prioritize.',
    'Time is scarce - we need to act quickly.',
    'Scarce materials drive up production costs.'
  ),
  collocations = jsonb_build_array('scarce resources', 'increasingly scarce', 'scarce talent', 'make scarce'),
  patterns = jsonb_build_array('scarce + noun', 'increasingly scarce'),
  register = 'formal',
  variety = 'international'
WHERE headword = 'scarce' AND cefr_receptive = 'A1';

-- scene
UPDATE lexicon_entries SET
  ipa = '/siːn/',
  definition_simple = 'a place where something happens, or part of a play',
  definition_teacher = 'Noun meaning location, situation, or setting. In business, used for "behind the scenes" or "on the scene".',
  usage_notes = 'Multiple meanings: location of event, part of performance, or situation. Common in business phrases.',
  examples = jsonb_build_array(
    'Behind the scenes, the team worked tirelessly.',
    'The tech scene in this city is thriving.',
    'We need someone on the scene to assess the situation.',
    'The business scene has changed dramatically.'
  ),
  collocations = jsonb_build_array('behind the scenes', 'on the scene', 'business scene', 'set the scene'),
  patterns = jsonb_build_array('behind the scenes', 'on the scene', 'noun + scene'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'scene' AND cefr_receptive = 'A1';

-- science
UPDATE lexicon_entries SET
  ipa = '/ˈsaɪəns/',
  definition_simple = 'the study of the physical world through observation and experiment',
  definition_teacher = 'Noun meaning systematic study or knowledge. In business, used for data science, computer science, or scientific approach.',
  usage_notes = 'Can be countable (sciences) or uncountable (science). Very relevant in modern business contexts.',
  examples = jsonb_build_array(
    'Data science drives our decision-making process.',
    'We apply scientific methods to problem-solving.',
    'Computer science skills are in high demand.',
    'The science behind our product is solid.'
  ),
  collocations = jsonb_build_array('data science', 'computer science', 'scientific method', 'science behind'),
  patterns = jsonb_build_array('noun + science', 'scientific + noun', 'the science behind + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'science' AND cefr_receptive = 'A1';

-- sea
UPDATE lexicon_entries SET
  ipa = '/siː/',
  definition_simple = 'a large body of salt water',
  definition_teacher = 'Noun meaning ocean or large water body. In business, used in shipping, trade, or metaphorically (sea of change).',
  usage_notes = 'Can be literal (by sea) or figurative (sea of change, sea of data). Common in international trade.',
  examples = jsonb_build_array(
    'We ship products by sea to reduce costs.',
    'The company faces a sea of challenges.',
    'Sea freight is economical for bulk shipments.',
    'There''s been a sea change in consumer behavior.'
  ),
  collocations = jsonb_build_array('by sea', 'sea change', 'sea of', 'sea freight'),
  patterns = jsonb_build_array('by sea', 'sea of + noun', 'sea change'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'sea' AND cefr_receptive = 'A1';

-- season
UPDATE lexicon_entries SET
  ipa = '/ˈsiːzən/',
  definition_simple = 'one of the four periods of the year, or a particular time',
  definition_teacher = 'Noun meaning time period or cycle. In business, used for busy season, holiday season, or seasonal patterns.',
  usage_notes = 'Very common in business for seasonal trends, busy seasons, and cyclical patterns.',
  examples = jsonb_build_array(
    'The holiday season is our busiest time.',
    'Sales are seasonal in this industry.',
    'We hire additional staff during peak season.',
    'The tax season runs from January to April.'
  ),
  collocations = jsonb_build_array('busy season', 'holiday season', 'peak season', 'seasonal trends'),
  patterns = jsonb_build_array('adjective + season', 'during + season', 'seasonal + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'season' AND cefr_receptive = 'A1';

-- seat
UPDATE lexicon_entries SET
  ipa = '/siːt/',
  definition_simple = 'something to sit on, or a position',
  definition_teacher = 'Noun or verb meaning chair, position, or to place. In business, used for board seats or seating arrangements.',
  usage_notes = 'Multiple meanings: chair, position (board seat), or location. Common in business contexts.',
  examples = jsonb_build_array(
    'She holds a seat on the board of directors.',
    'Please take a seat in the conference room.',
    'The company has a seat at the negotiating table.',
    'We need to seat 50 people for the presentation.'
  ),
  collocations = jsonb_build_array('board seat', 'take a seat', 'seat at the table', 'seating arrangement'),
  patterns = jsonb_build_array('take a seat', 'seat on + noun', 'seat at + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'seat' AND cefr_receptive = 'A1';

-- secret
UPDATE lexicon_entries SET
  ipa = '/ˈsiːkrət/',
  definition_simple = 'something kept hidden or not known by others',
  definition_teacher = 'Noun or adjective meaning confidential or hidden. Essential in business for confidentiality and trade secrets.',
  usage_notes = 'Very important in business. Can be noun (a secret) or adjective (secret information).',
  examples = jsonb_build_array(
    'The formula is a closely guarded trade secret.',
    'Please keep this information secret until the announcement.',
    'The secret to success is consistent effort.',
    'We signed a non-disclosure agreement to protect secrets.'
  ),
  collocations = jsonb_build_array('trade secret', 'keep secret', 'secret to success', 'top secret'),
  patterns = jsonb_build_array('keep + noun + secret', 'the secret to + noun', 'trade secret'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'secret' AND cefr_receptive = 'A1';

-- secretary
UPDATE lexicon_entries SET
  ipa = '/ˈsekrətəri/',
  definition_simple = 'a person who does office work and administrative tasks',
  definition_teacher = 'Noun meaning administrative assistant or official. In business, refers to administrative roles or company secretary.',
  usage_notes = 'Can mean administrative assistant or high-level official (company secretary, secretary of state).',
  examples = jsonb_build_array(
    'The company secretary handles corporate governance.',
    'Please contact my secretary to schedule a meeting.',
    'The executive secretary manages the CEO''s calendar.',
    'We need to hire a new administrative secretary.'
  ),
  collocations = jsonb_build_array('company secretary', 'executive secretary', 'administrative secretary', 'personal secretary'),
  patterns = jsonb_build_array('adjective + secretary', 'secretary to + person'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'secretary' AND cefr_receptive = 'A1';

-- seem
UPDATE lexicon_entries SET
  ipa = '/siːm/',
  definition_simple = 'to appear to be or give the impression of being',
  definition_teacher = 'Verb meaning to appear or give impression. Very common in business for expressing perceptions or opinions.',
  usage_notes = 'Very common in business. Used to express perceptions, opinions, or tentative conclusions.',
  examples = jsonb_build_array(
    'The proposal seems reasonable and well-thought-out.',
    'It seems that we need more time for analysis.',
    'The market seems to be recovering.',
    'This approach seems like the best option.'
  ),
  collocations = jsonb_build_array('seem to be', 'it seems that', 'seem like', 'seem reasonable'),
  patterns = jsonb_build_array('seem + adjective', 'seem to + infinitive', 'it seems that + clause'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'seem' AND cefr_receptive = 'A1';

-- seize
UPDATE lexicon_entries SET
  ipa = '/siːz/',
  definition_simple = 'to take hold of suddenly and forcefully',
  definition_teacher = 'Verb meaning to grab or take advantage of. Common in business for seizing opportunities or taking control.',
  usage_notes = 'Formal verb. Very common in business phrase "seize the opportunity". Related: seizure.',
  examples = jsonb_build_array(
    'We need to seize this opportunity before competitors do.',
    'The company seized control of the market.',
    'Let''s seize the moment and launch now.',
    'They seized the chance to expand internationally.'
  ),
  collocations = jsonb_build_array('seize the opportunity', 'seize control', 'seize the moment', 'seize the chance'),
  patterns = jsonb_build_array('seize + noun', 'seize the opportunity to + infinitive'),
  register = 'formal',
  variety = 'international'
WHERE headword = 'seize' AND cefr_receptive = 'A1';

-- sell
UPDATE lexicon_entries SET
  ipa = '/sel/',
  definition_simple = 'to give something to someone in exchange for money',
  definition_teacher = 'Verb meaning to exchange for money or persuade. Essential in business for sales and persuasion.',
  usage_notes = 'Very common in business. Irregular: sell, sold, sold. Can mean exchange for money or persuade (sell an idea).',
  examples = jsonb_build_array(
    'We sell products to customers worldwide.',
    'The company sold 10,000 units last month.',
    'You need to sell your idea to the board.',
    'This product sells itself - no marketing needed.'
  ),
  collocations = jsonb_build_array('sell products', 'sell an idea', 'sell out', 'sell for'),
  patterns = jsonb_build_array('sell + noun', 'sell + noun + to + person', 'sell for + price'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'sell' AND cefr_receptive = 'A1';

-- sense
UPDATE lexicon_entries SET
  ipa = '/sens/',
  definition_simple = 'a feeling or awareness, or good judgment',
  definition_teacher = 'Noun or verb meaning perception, meaning, or to detect. Essential in business for making sense or common sense.',
  usage_notes = 'Very versatile word. Can mean perception, meaning, judgment, or to detect. Very common in business.',
  examples = jsonb_build_array(
    'It makes sense to invest in training.',
    'Use common sense when making decisions.',
    'I sense some resistance to the changes.',
    'In what sense is this approach better?'
  ),
  collocations = jsonb_build_array('make sense', 'common sense', 'sense of', 'in a sense'),
  patterns = jsonb_build_array('make sense', 'sense of + noun', 'in a/that sense'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'sense' AND cefr_receptive = 'A1';

-- separate
UPDATE lexicon_entries SET
  ipa = '/ˈseprət/',
  definition_simple = 'not joined or connected, or to divide',
  definition_teacher = 'Adjective or verb meaning distinct or to divide. Common in business for separate entities or separating concerns.',
  usage_notes = 'As adjective: /ˈseprət/. As verb: /ˈsepəreɪt/. Very common in business contexts.',
  examples = jsonb_build_array(
    'We keep personal and business finances separate.',
    'The company operates as a separate legal entity.',
    'Let''s separate the issues and address them individually.',
    'Each department has separate budgets.'
  ),
  collocations = jsonb_build_array('separate entity', 'keep separate', 'separate from', 'separate issue'),
  patterns = jsonb_build_array('separate + noun', 'keep + noun + separate', 'separate from + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'separate' AND cefr_receptive = 'A1';

-- serious
UPDATE lexicon_entries SET
  ipa = '/ˈsɪəriəs/',
  definition_simple = 'important and needing careful thought, or not joking',
  definition_teacher = 'Adjective meaning important, grave, or sincere. Common in business for serious issues or serious consideration.',
  usage_notes = 'Very common in business. Can mean "important" (serious issue), "sincere" (serious offer), or "grave" (serious problem).',
  examples = jsonb_build_array(
    'This is a serious issue that requires immediate attention.',
    'We are making a serious offer to acquire the company.',
    'The situation is more serious than we thought.',
    'Are you serious about this proposal?'
  ),
  collocations = jsonb_build_array('serious issue', 'serious consideration', 'serious problem', 'take seriously'),
  patterns = jsonb_build_array('serious + noun', 'take + noun + seriously', 'serious about + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'serious' AND cefr_receptive = 'A1';

-- serve
UPDATE lexicon_entries SET
  ipa = '/sɜːrv/',
  definition_simple = 'to provide food or help to someone',
  definition_teacher = 'Verb meaning to provide service, help, or function. Essential in business for serving customers or serving a purpose.',
  usage_notes = 'Very common in business. Multiple meanings: provide service, help, or function as.',
  examples = jsonb_build_array(
    'We serve customers in 50 countries.',
    'This tool serves multiple purposes.',
    'The company has served the community for 30 years.',
    'How can we better serve our clients?'
  ),
  collocations = jsonb_build_array('serve customers', 'serve a purpose', 'serve as', 'serve the needs'),
  patterns = jsonb_build_array('serve + noun', 'serve as + noun', 'serve + purpose'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'serve' AND cefr_receptive = 'A1';

-- set
UPDATE lexicon_entries SET
  ipa = '/set/',
  definition_simple = 'to put something in a position, or a group of things',
  definition_teacher = 'Verb or noun with many meanings. Essential in business for setting goals, standards, or deadlines.',
  usage_notes = 'Extremely versatile word. Irregular: set, set, set. Very common in business contexts.',
  examples = jsonb_build_array(
    'We need to set clear goals for the quarter.',
    'The company sets high standards for quality.',
    'Let''s set a deadline for project completion.',
    'This product comes as a complete set.'
  ),
  collocations = jsonb_build_array('set goals', 'set standards', 'set a deadline', 'set up'),
  patterns = jsonb_build_array('set + noun', 'set up + noun', 'set + noun + for + time'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'set' AND cefr_receptive = 'A1';

-- settle
UPDATE lexicon_entries SET
  ipa = '/ˈsetəl/',
  definition_simple = 'to end a disagreement, or to make a place your home',
  definition_teacher = 'Verb meaning to resolve, establish, or pay. Common in business for settling disputes, accounts, or settling in.',
  usage_notes = 'Multiple meanings: resolve (settle a dispute), establish (settle in), or pay (settle an account).',
  examples = jsonb_build_array(
    'We settled the dispute through mediation.',
    'Please settle your account by the end of the month.',
    'The team is settling into the new office.',
    'Let''s settle on a date for the meeting.'
  ),
  collocations = jsonb_build_array('settle a dispute', 'settle an account', 'settle on', 'settle in'),
  patterns = jsonb_build_array('settle + noun', 'settle on + noun', 'settle for + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'settle' AND cefr_receptive = 'A1';

-- several
UPDATE lexicon_entries SET
  ipa = '/ˈsevrəl/',
  definition_simple = 'more than two but not many',
  definition_teacher = 'Determiner meaning some or a few. Very common in business for indicating multiple but not many items.',
  usage_notes = 'Very common in business. Means "more than two but not many". Always plural.',
  examples = jsonb_build_array(
    'We have several options to consider.',
    'Several clients have expressed interest.',
    'The project will take several months to complete.',
    'Several factors contributed to the success.'
  ),
  collocations = jsonb_build_array('several options', 'several months', 'several factors', 'several times'),
  patterns = jsonb_build_array('several + plural noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'several' AND cefr_receptive = 'A1';

-- shadow
UPDATE lexicon_entries SET
  ipa = '/ˈʃædəʊ/',
  definition_simple = 'a dark shape made when something blocks light',
  definition_teacher = 'Noun or verb meaning dark area or to follow closely. In business, used for shadow economy or job shadowing.',
  usage_notes = 'Can be literal (dark shape) or figurative (shadow of doubt, job shadowing).',
  examples = jsonb_build_array(
    'New employees shadow experienced staff for training.',
    'There''s no shadow of doubt about the decision.',
    'The shadow economy affects tax revenues.',
    'The scandal cast a shadow over the company.'
  ),
  collocations = jsonb_build_array('job shadowing', 'shadow of doubt', 'cast a shadow', 'shadow economy'),
  patterns = jsonb_build_array('shadow + noun', 'cast a shadow over + noun', 'no shadow of doubt'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'shadow' AND cefr_receptive = 'A1';

-- shake
UPDATE lexicon_entries SET
  ipa = '/ʃeɪk/',
  definition_simple = 'to move quickly up and down or side to side',
  definition_teacher = 'Verb or noun meaning to vibrate or disturb. In business, used for shake hands, shake up, or shake confidence.',
  usage_notes = 'Irregular: shake, shook, shaken. Common in business phrases like "shake hands" or "shake up".',
  examples = jsonb_build_array(
    'Let''s shake hands on the deal.',
    'The news shook investor confidence.',
    'We need to shake up our approach.',
    'The market shake-up created opportunities.'
  ),
  collocations = jsonb_build_array('shake hands', 'shake up', 'shake confidence', 'shake-up'),
  patterns = jsonb_build_array('shake hands on + noun', 'shake up + noun', 'shake + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'shake' AND cefr_receptive = 'A1';

-- shall
UPDATE lexicon_entries SET
  ipa = '/ʃæl/',
  definition_simple = 'used to make suggestions or talk about the future',
  definition_teacher = 'Modal verb for suggestions or future (formal). In business, used in formal contexts or legal language.',
  usage_notes = 'Formal modal verb. More common in UK English. Used for suggestions (Shall we?) or formal future.',
  examples = jsonb_build_array(
    'Shall we schedule a meeting for next week?',
    'The contract shall be valid for one year.',
    'What shall we do about this issue?',
    'The parties shall comply with all regulations.'
  ),
  collocations = jsonb_build_array('shall we', 'shall be', 'shall comply', 'shall not'),
  patterns = jsonb_build_array('shall we + infinitive', 'shall + infinitive'),
  register = 'formal',
  variety = 'UK/international'
WHERE headword = 'shall' AND cefr_receptive = 'A1';

-- shape
UPDATE lexicon_entries SET
  ipa = '/ʃeɪp/',
  definition_simple = 'the form or outline of something',
  definition_teacher = 'Noun or verb meaning form or to mold. In business, used for shaping strategy, in good shape, or taking shape.',
  usage_notes = 'Very common in business. Can be noun (a shape) or verb (to shape). Used literally and figuratively.',
  examples = jsonb_build_array(
    'The strategy is taking shape nicely.',
    'We need to shape our approach to market conditions.',
    'The company is in good financial shape.',
    'Leadership shapes organizational culture.'
  ),
  collocations = jsonb_build_array('take shape', 'in good shape', 'shape strategy', 'shape the future'),
  patterns = jsonb_build_array('take shape', 'in + adjective + shape', 'shape + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'shape' AND cefr_receptive = 'A1';

-- share
UPDATE lexicon_entries SET
  ipa = '/ʃeər/',
  definition_simple = 'to have or use something with others, or a part of something',
  definition_teacher = 'Verb or noun meaning to divide or portion. Essential in business for market share, sharing information, or stock shares.',
  usage_notes = 'Very common in business. Can be verb (share information) or noun (market share, stock shares).',
  examples = jsonb_build_array(
    'Please share your insights with the team.',
    'Our market share increased by 5%.',
    'The company issued new shares to investors.',
    'Let''s share the costs equally.'
  ),
  collocations = jsonb_build_array('market share', 'share information', 'share price', 'fair share'),
  patterns = jsonb_build_array('share + noun + with + person', 'market share', 'share of + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'share' AND cefr_receptive = 'A1';

-- shave
UPDATE lexicon_entries SET
  ipa = '/ʃeɪv/',
  definition_simple = 'to cut hair very close to the skin',
  definition_teacher = 'Verb or noun meaning to cut close or reduce slightly. In business, used figuratively for shaving costs or time.',
  usage_notes = 'Can be literal (shave beard) or figurative (shave costs). Business use is usually figurative.',
  examples = jsonb_build_array(
    'We need to shave costs without affecting quality.',
    'The new process shaves 10 minutes off production time.',
    'Can we shave anything off the budget?',
    'Every efficiency gain shaves costs.'
  ),
  collocations = jsonb_build_array('shave costs', 'shave time', 'shave off', 'close shave'),
  patterns = jsonb_build_array('shave + noun', 'shave + amount + off + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'shave' AND cefr_receptive = 'A1';

-- shine
UPDATE lexicon_entries SET
  ipa = '/ʃaɪn/',
  definition_simple = 'to produce or reflect bright light',
  definition_teacher = 'Verb or noun meaning to emit light or excel. In business, used for shining in performance or shining example.',
  usage_notes = 'Can be literal (shine light) or figurative (shine in role). Irregular: shine, shone, shone.',
  examples = jsonb_build_array(
    'She really shines in client presentations.',
    'This is a shining example of excellent service.',
    'The team''s performance shone through the challenges.',
    'Let your strengths shine in the interview.'
  ),
  collocations = jsonb_build_array('shine in', 'shining example', 'shine through', 'time to shine'),
  patterns = jsonb_build_array('shine in + noun', 'shining example of + noun', 'shine through + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'shine' AND cefr_receptive = 'A1';

-- shoe
UPDATE lexicon_entries SET
  ipa = '/ʃuː/',
  definition_simple = 'a covering for the foot',
  definition_teacher = 'Noun meaning footwear. In business, used in idiom "in someone''s shoes" (in their position).',
  usage_notes = 'Usually plural (shoes). Common in business idiom about understanding someone''s perspective.',
  examples = jsonb_build_array(
    'Put yourself in the customer''s shoes.',
    'If I were in your shoes, I would accept the offer.',
    'The dress code requires formal shoes.',
    'Walk a mile in their shoes before judging.'
  ),
  collocations = jsonb_build_array('in someone''s shoes', 'put yourself in', 'walk in shoes', 'formal shoes'),
  patterns = jsonb_build_array('in + possessive + shoes', 'put yourself in + possessive + shoes'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'shoe' AND cefr_receptive = 'A1';

-- shoot
UPDATE lexicon_entries SET
  ipa = '/ʃuːt/',
  definition_simple = 'to fire a weapon, or to move very quickly',
  definition_teacher = 'Verb meaning to fire, move quickly, or photograph. In business, used for shoot up (increase), troubleshoot, or photo shoots.',
  usage_notes = 'Irregular: shoot, shot, shot. Multiple meanings in business contexts.',
  examples = jsonb_build_array(
    'Sales shot up after the marketing campaign.',
    'Let''s shoot for a 20% increase.',
    'We need to troubleshoot the system issues.',
    'The photo shoot is scheduled for tomorrow.'
  ),
  collocations = jsonb_build_array('shoot up', 'shoot for', 'troubleshoot', 'photo shoot'),
  patterns = jsonb_build_array('shoot up', 'shoot for + noun', 'troubleshoot + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'shoot' AND cefr_receptive = 'A1';

-- shore
UPDATE lexicon_entries SET
  ipa = '/ʃɔːr/',
  definition_simple = 'the land along the edge of a sea or lake',
  definition_teacher = 'Noun meaning coastline or edge. In business, used in "offshore" (overseas) or "shore up" (strengthen).',
  usage_notes = 'Can be literal (coastline) or in business phrases like "offshore operations" or "shore up".',
  examples = jsonb_build_array(
    'We need to shore up our financial position.',
    'The company has offshore operations in Asia.',
    'Onshore and offshore teams collaborate daily.',
    'Let''s shore up support before the vote.'
  ),
  collocations = jsonb_build_array('shore up', 'offshore operations', 'onshore team', 'near shore'),
  patterns = jsonb_build_array('shore up + noun', 'offshore + noun', 'onshore + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'shore' AND cefr_receptive = 'A1';

-- shoulder
UPDATE lexicon_entries SET
  ipa = '/ˈʃəʊldər/',
  definition_simple = 'the part of the body between the neck and arm',
  definition_teacher = 'Noun or verb meaning body part or to take responsibility. In business, used for shouldering responsibility.',
  usage_notes = 'Can be literal (body part) or figurative (shoulder responsibility, shoulder to shoulder).',
  examples = jsonb_build_array(
    'The team must shoulder the responsibility together.',
    'We work shoulder to shoulder with our partners.',
    'Management shoulders the burden of difficult decisions.',
    'She has broad shoulders for handling pressure.'
  ),
  collocations = jsonb_build_array('shoulder responsibility', 'shoulder to shoulder', 'shoulder the burden', 'broad shoulders'),
  patterns = jsonb_build_array('shoulder + noun', 'shoulder to shoulder', 'have + adjective + shoulders'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'shoulder' AND cefr_receptive = 'A1';

-- side
UPDATE lexicon_entries SET
  ipa = '/saɪd/',
  definition_simple = 'a position to the left or right, or one surface of something',
  definition_teacher = 'Noun meaning edge, aspect, or team. Very common in business for side effects, side by side, or taking sides.',
  usage_notes = 'Very versatile word. Multiple meanings: edge, aspect, team, or perspective.',
  examples = jsonb_build_array(
    'Let''s look at both sides of the issue.',
    'The teams work side by side on projects.',
    'There are positive and negative sides to this decision.',
    'On the flip side, costs will increase.'
  ),
  collocations = jsonb_build_array('both sides', 'side by side', 'on the side', 'flip side'),
  patterns = jsonb_build_array('both sides of + noun', 'side by side', 'on the + adjective + side'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'side' AND cefr_receptive = 'A1';

-- sight
UPDATE lexicon_entries SET
  ipa = '/saɪt/',
  definition_simple = 'the ability to see, or something you see',
  definition_teacher = 'Noun meaning vision or view. In business, used for in sight, lose sight of, or set sights on.',
  usage_notes = 'Multiple meanings: vision, view, or goal. Common in business phrases.',
  examples = jsonb_build_array(
    'The deadline is in sight now.',
    'Don''t lose sight of our main objectives.',
    'We set our sights on international expansion.',
    'Success is within sight.'
  ),
  collocations = jsonb_build_array('in sight', 'lose sight of', 'set sights on', 'within sight'),
  patterns = jsonb_build_array('in sight', 'lose sight of + noun', 'set sights on + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'sight' AND cefr_receptive = 'A1';

-- sign
UPDATE lexicon_entries SET
  ipa = '/saɪn/',
  definition_simple = 'a mark or symbol, or to write your name',
  definition_teacher = 'Noun or verb meaning symbol, indication, or to write signature. Essential in business for signing contracts.',
  usage_notes = 'Very common in business. Can be noun (a sign) or verb (to sign). Multiple meanings.',
  examples = jsonb_build_array(
    'Please sign the contract and return it.',
    'This is a good sign for the economy.',
    'We signed a major deal with a new client.',
    'There are signs of improvement in sales.'
  ),
  collocations = jsonb_build_array('sign a contract', 'good sign', 'sign up', 'signs of'),
  patterns = jsonb_build_array('sign + noun', 'sign up for + noun', 'signs of + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'sign' AND cefr_receptive = 'A1';

-- silence
UPDATE lexicon_entries SET
  ipa = '/ˈsaɪləns/',
  definition_simple = 'complete quiet with no sound',
  definition_teacher = 'Noun or verb meaning absence of sound or to make quiet. In business, used for silence in meetings or radio silence.',
  usage_notes = 'Can be noun (silence) or verb (to silence). Used literally and figuratively in business.',
  examples = jsonb_build_array(
    'The awkward silence suggested disagreement.',
    'We haven''t heard from them - complete radio silence.',
    'Silence can be interpreted as consent.',
    'The announcement was met with silence.'
  ),
  collocations = jsonb_build_array('awkward silence', 'radio silence', 'break the silence', 'in silence'),
  patterns = jsonb_build_array('in silence', 'break the silence', 'radio silence'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'silence' AND cefr_receptive = 'A1';

-- silver
UPDATE lexicon_entries SET
  ipa = '/ˈsɪlvər/',
  definition_simple = 'a shiny white precious metal',
  definition_teacher = 'Noun or adjective meaning precious metal or color. In business, used for silver lining or silver bullet.',
  usage_notes = 'Can be literal (metal) or figurative (silver lining, silver bullet). Common in business idioms.',
  examples = jsonb_build_array(
    'Every cloud has a silver lining.',
    'There''s no silver bullet solution to this problem.',
    'The silver market is volatile.',
    'We need to find the silver lining in this setback.'
  ),
  collocations = jsonb_build_array('silver lining', 'silver bullet', 'silver market', 'silver medal'),
  patterns = jsonb_build_array('silver lining', 'silver bullet', 'silver + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'silver' AND cefr_receptive = 'A1';

-- simple
UPDATE lexicon_entries SET
  ipa = '/ˈsɪmpəl/',
  definition_simple = 'easy to understand or do, not complicated',
  definition_teacher = 'Adjective meaning uncomplicated or straightforward. Very common in business for simple solutions or processes.',
  usage_notes = 'Very common in business. Emphasizes clarity and lack of complexity. Opposite of "complex".',
  examples = jsonb_build_array(
    'We need a simple solution that everyone can understand.',
    'Keep the message simple and clear.',
    'The process is quite simple to follow.',
    'Simple designs often work best.'
  ),
  collocations = jsonb_build_array('simple solution', 'keep simple', 'simple process', 'simple and clear'),
  patterns = jsonb_build_array('simple + noun', 'keep + noun + simple', 'simple to + infinitive'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'simple' AND cefr_receptive = 'A1';

-- single
UPDATE lexicon_entries SET
  ipa = '/ˈsɪŋɡəl/',
  definition_simple = 'only one, not double or multiple',
  definition_teacher = 'Adjective meaning one only or individual. Common in business for single point, single source, or emphasizing unity.',
  usage_notes = 'Very common in business. Emphasizes "only one" or "individual". Used for emphasis.',
  examples = jsonb_build_array(
    'We need a single point of contact for the project.',
    'Not a single complaint was received.',
    'The company has a single focus: customer satisfaction.',
    'Every single employee must complete the training.'
  ),
  collocations = jsonb_build_array('single point', 'not a single', 'single source', 'every single'),
  patterns = jsonb_build_array('single + noun', 'not a single + noun', 'every single + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'single' AND cefr_receptive = 'A1';

-- sir
UPDATE lexicon_entries SET
  ipa = '/sɜːr/',
  definition_simple = 'a polite way to address a man',
  definition_teacher = 'Noun meaning polite form of address. Used in formal business contexts, especially in service industries.',
  usage_notes = 'Formal term of address. More common in service contexts or very formal business situations.',
  examples = jsonb_build_array(
    'Good morning, sir. How may I help you?',
    'Yes, sir. I will handle that immediately.',
    'Dear Sir or Madam, (formal letter opening)',
    'Excuse me, sir. Do you have a moment?'
  ),
  collocations = jsonb_build_array('yes sir', 'dear sir', 'excuse me sir', 'thank you sir'),
  patterns = jsonb_build_array('yes/no + sir', 'dear sir', 'excuse me + sir'),
  register = 'formal',
  variety = 'international'
WHERE headword = 'sir' AND cefr_receptive = 'A1';

-- situation
UPDATE lexicon_entries SET
  ipa = '/ˌsɪtʃuˈeɪʃən/',
  definition_simple = 'the conditions and circumstances at a particular time',
  definition_teacher = 'Noun meaning circumstances or state of affairs. Very common in business for describing conditions or contexts.',
  usage_notes = 'Very common in business. Used to describe circumstances, conditions, or state of affairs.',
  examples = jsonb_build_array(
    'The current situation requires immediate action.',
    'We need to assess the situation before deciding.',
    'The financial situation has improved significantly.',
    'Let me explain the situation to the team.'
  ),
  collocations = jsonb_build_array('current situation', 'assess the situation', 'financial situation', 'win-win situation'),
  patterns = jsonb_build_array('the + adjective + situation', 'assess/analyze the situation'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'situation' AND cefr_receptive = 'A1';

-- size
UPDATE lexicon_entries SET
  ipa = '/saɪz/',
  definition_simple = 'how big or small something is',
  definition_teacher = 'Noun or verb meaning dimensions or to measure. Essential in business for company size, market size, or sizing up.',
  usage_notes = 'Very common in business. Can be noun (the size) or verb (to size up = evaluate).',
  examples = jsonb_build_array(
    'The market size is estimated at $10 billion.',
    'Company size affects organizational structure.',
    'We need to size up the competition.',
    'One size doesn''t fit all in business solutions.'
  ),
  collocations = jsonb_build_array('market size', 'company size', 'size up', 'one size fits all'),
  patterns = jsonb_build_array('noun + size', 'size up + noun', 'size of + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'size' AND cefr_receptive = 'A1';

-- skill
UPDATE lexicon_entries SET
  ipa = '/skɪl/',
  definition_simple = 'the ability to do something well',
  definition_teacher = 'Noun meaning ability or expertise. Essential in business for discussing competencies and capabilities.',
  usage_notes = 'Very common in business. Can be countable (skills) or uncountable (skill). Related: skilled, skillful.',
  examples = jsonb_build_array(
    'The job requires strong communication skills.',
    'We invest heavily in skill development.',
    'Technical skills are essential for this role.',
    'She has excellent leadership skills.'
  ),
  collocations = jsonb_build_array('communication skills', 'technical skills', 'skill development', 'soft skills'),
  patterns = jsonb_build_array('noun + skills', 'skill in + noun', 'develop skills'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'skill' AND cefr_receptive = 'A1';

-- sky
UPDATE lexicon_entries SET
  ipa = '/skaɪ/',
  definition_simple = 'the space above the earth where clouds and the sun appear',
  definition_teacher = 'Noun meaning the atmosphere above. In business, used in phrases like "sky-high" or "the sky''s the limit".',
  usage_notes = 'Usually singular. Common in business idioms about limits and high prices.',
  examples = jsonb_build_array(
    'The sky''s the limit for this company.',
    'Prices have gone sky-high.',
    'We need to reach for the sky with our goals.',
    'The sky-high costs are unsustainable.'
  ),
  collocations = jsonb_build_array('sky-high', 'the sky''s the limit', 'reach for the sky', 'blue-sky thinking'),
  patterns = jsonb_build_array('sky-high + noun', 'the sky''s the limit', 'reach for the sky'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'sky' AND cefr_receptive = 'A1';

-- slight
UPDATE lexicon_entries SET
  ipa = '/slaɪt/',
  definition_simple = 'small in amount or degree',
  definition_teacher = 'Adjective meaning minor or small. Common in business for slight changes, improvements, or differences.',
  usage_notes = 'Used to minimize or downplay something. Related: slightly (adverb).',
  examples = jsonb_build_array(
    'There was a slight increase in sales.',
    'We made slight modifications to the plan.',
    'The difference is only slight.',
    'There''s a slight chance of delay.'
  ),
  collocations = jsonb_build_array('slight increase', 'slight change', 'slight difference', 'slight chance'),
  patterns = jsonb_build_array('slight + noun', 'only slight'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'slight' AND cefr_receptive = 'A1';

-- slow
UPDATE lexicon_entries SET
  ipa = '/sləʊ/',
  definition_simple = 'not moving or happening quickly',
  definition_teacher = 'Adjective or verb meaning not fast or to reduce speed. Common in business for slow growth or slowing down.',
  usage_notes = 'Can be adjective (slow process) or verb (slow down). Opposite of "fast".',
  examples = jsonb_build_array(
    'Growth has been slow this quarter.',
    'We need to slow down and review the details.',
    'The slow economy affects all businesses.',
    'Progress is slow but steady.'
  ),
  collocations = jsonb_build_array('slow growth', 'slow down', 'slow progress', 'slow and steady'),
  patterns = jsonb_build_array('slow + noun', 'slow down', 'slow but steady'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'slow' AND cefr_receptive = 'A1';

-- smile
UPDATE lexicon_entries SET
  ipa = '/smaɪl/',
  definition_simple = 'to make a happy expression with your mouth',
  definition_teacher = 'Verb or noun meaning happy facial expression. In business, important for customer service and positive interactions.',
  usage_notes = 'Can be verb (to smile) or noun (a smile). Important in customer-facing roles.',
  examples = jsonb_build_array(
    'Customer service representatives should smile when greeting clients.',
    'A smile can make a positive first impression.',
    'The news brought smiles to everyone''s faces.',
    'She smiled confidently during the presentation.'
  ),
  collocations = jsonb_build_array('smile at', 'bring a smile', 'with a smile', 'smile confidently'),
  patterns = jsonb_build_array('smile at + person', 'with a smile', 'bring a smile to + face'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'smile' AND cefr_receptive = 'A1';

-- society
UPDATE lexicon_entries SET
  ipa = '/səˈsaɪəti/',
  definition_simple = 'people living together in organized communities',
  definition_teacher = 'Noun meaning community or organization. In business, used for corporate social responsibility or professional societies.',
  usage_notes = 'Can mean "community" (society in general) or "organization" (professional society).',
  examples = jsonb_build_array(
    'The company contributes positively to society.',
    'She is a member of the Marketing Society.',
    'Corporate social responsibility benefits society.',
    'Modern society relies heavily on technology.'
  ),
  collocations = jsonb_build_array('modern society', 'professional society', 'benefit society', 'society in general'),
  patterns = jsonb_build_array('adjective + society', 'benefit + society', 'member of + society'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'society' AND cefr_receptive = 'A1';

-- soft
UPDATE lexicon_entries SET
  ipa = '/sɒft/',
  definition_simple = 'not hard or firm, gentle',
  definition_teacher = 'Adjective meaning not hard, gentle, or flexible. In business, used for soft skills, soft launch, or soft market.',
  usage_notes = 'Multiple meanings in business: gentle, flexible, or non-technical (soft skills).',
  examples = jsonb_build_array(
    'Soft skills like communication are essential.',
    'We''ll do a soft launch before the full release.',
    'The soft market conditions favor buyers.',
    'Take a softer approach in negotiations.'
  ),
  collocations = jsonb_build_array('soft skills', 'soft launch', 'soft market', 'soft approach'),
  patterns = jsonb_build_array('soft + noun', 'softer + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'soft' AND cefr_receptive = 'A1';

-- soil
UPDATE lexicon_entries SET
  ipa = '/sɔɪl/',
  definition_simple = 'the top layer of earth where plants grow',
  definition_teacher = 'Noun meaning earth or ground. In business, used literally for agriculture or figuratively for fertile ground.',
  usage_notes = 'Uncountable noun. Can be literal (earth) or figurative (fertile soil for ideas).',
  examples = jsonb_build_array(
    'The region has fertile soil for agriculture.',
    'This market provides fertile soil for innovation.',
    'Soil quality affects crop production.',
    'The company is testing the soil for new ventures.'
  ),
  collocations = jsonb_build_array('fertile soil', 'soil quality', 'test the soil', 'soil conditions'),
  patterns = jsonb_build_array('adjective + soil', 'soil for + noun', 'test the soil'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'soil' AND cefr_receptive = 'A1';

-- son
UPDATE lexicon_entries SET
  ipa = '/sʌn/',
  definition_simple = 'a male child',
  definition_teacher = 'Noun meaning male offspring. In business, relevant for family businesses or succession planning.',
  usage_notes = 'Countable noun. Relevant in business contexts involving family businesses or succession.',
  examples = jsonb_build_array(
    'The founder''s son will take over the company.',
    'Many family businesses pass to sons and daughters.',
    'He joined his father''s business as a young son.',
    'The company is a father-and-son operation.'
  ),
  collocations = jsonb_build_array('son and daughter', 'founder''s son', 'father and son', 'eldest son'),
  patterns = jsonb_build_array('possessive + son', 'father and son'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'son' AND cefr_receptive = 'A1';

-- sort
UPDATE lexicon_entries SET
  ipa = '/sɔːrt/',
  definition_simple = 'a type or kind of something',
  definition_teacher = 'Noun or verb meaning type or to organize. Common in business for sorting data or discussing types.',
  usage_notes = 'Can be noun (a sort of) or verb (to sort). Very common in business contexts.',
  examples = jsonb_build_array(
    'What sort of solution are you looking for?',
    'We need to sort the data by category.',
    'This sort of problem requires immediate attention.',
    'Let''s sort out the details before proceeding.'
  ),
  collocations = jsonb_build_array('sort of', 'sort out', 'what sort', 'all sorts'),
  patterns = jsonb_build_array('sort of + noun', 'sort out + noun', 'what sort of + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'sort' AND cefr_receptive = 'A1';

-- sound
UPDATE lexicon_entries SET
  ipa = '/saʊnd/',
  definition_simple = 'something you hear, or to seem',
  definition_teacher = 'Noun, verb, or adjective with multiple meanings. In business, used for sound decision, sound advice, or how things sound.',
  usage_notes = 'Very versatile word. Can be noun (a sound), verb (to sound), or adjective (sound advice).',
  examples = jsonb_build_array(
    'That sounds like a good plan.',
    'We need sound financial advice.',
    'The proposal sounds reasonable.',
    'Make sound decisions based on data.'
  ),
  collocations = jsonb_build_array('sound like', 'sound advice', 'sound decision', 'sound good'),
  patterns = jsonb_build_array('sound like + noun', 'sound + adjective', 'sound + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'sound' AND cefr_receptive = 'A1';

-- south
UPDATE lexicon_entries SET
  ipa = '/saʊθ/',
  definition_simple = 'the direction toward the bottom of a map',
  definition_teacher = 'Noun, adjective, or adverb meaning southern direction. In business, used for geographic locations and markets.',
  usage_notes = 'Can be noun (the south), adjective (south region), or adverb (go south = decline).',
  examples = jsonb_build_array(
    'We are expanding into South America.',
    'The south region shows strong growth.',
    'Sales went south after the scandal.',
    'Our southern operations are profitable.'
  ),
  collocations = jsonb_build_array('go south', 'south region', 'South America', 'southern operations'),
  patterns = jsonb_build_array('go south', 'south + noun', 'in the south'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'south' AND cefr_receptive = 'A1';

-- space
UPDATE lexicon_entries SET
  ipa = '/speɪs/',
  definition_simple = 'an empty area or room',
  definition_teacher = 'Noun meaning area, room, or sector. Essential in business for office space, market space, or breathing space.',
  usage_notes = 'Very common in business. Can mean physical space, market sector, or time/opportunity.',
  examples = jsonb_build_array(
    'We need more office space for the growing team.',
    'The company operates in the technology space.',
    'Give me some space to think about the offer.',
    'There''s space for improvement in our processes.'
  ),
  collocations = jsonb_build_array('office space', 'market space', 'breathing space', 'space for'),
  patterns = jsonb_build_array('noun + space', 'space for + noun', 'in the + noun + space'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'space' AND cefr_receptive = 'A1';

-- special
UPDATE lexicon_entries SET
  ipa = '/ˈspeʃəl/',
  definition_simple = 'better or more important than usual',
  definition_teacher = 'Adjective meaning distinctive, exceptional, or specific. Very common in business for special offers or special attention.',
  usage_notes = 'Very common in business. Can mean "exceptional" or "specific/particular".',
  examples = jsonb_build_array(
    'We have a special offer for new customers.',
    'This project requires special attention.',
    'She has special expertise in digital marketing.',
    'Special circumstances require flexible solutions.'
  ),
  collocations = jsonb_build_array('special offer', 'special attention', 'special circumstances', 'special expertise'),
  patterns = jsonb_build_array('special + noun', 'require special + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'special' AND cefr_receptive = 'A1';

-- speed
UPDATE lexicon_entries SET
  ipa = '/spiːd/',
  definition_simple = 'how fast something moves or happens',
  definition_teacher = 'Noun or verb meaning rate or to move quickly. Essential in business for speed of delivery, speed to market.',
  usage_notes = 'Very common in business. Can be noun (the speed) or verb (to speed up).',
  examples = jsonb_build_array(
    'Speed to market is critical for success.',
    'We need to speed up the approval process.',
    'The speed of change is accelerating.',
    'Processing speed has improved significantly.'
  ),
  collocations = jsonb_build_array('speed to market', 'speed up', 'at speed', 'processing speed'),
  patterns = jsonb_build_array('speed to + noun', 'speed up + noun', 'at + adjective + speed'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'speed' AND cefr_receptive = 'A1';

-- spend
UPDATE lexicon_entries SET
  ipa = '/spend/',
  definition_simple = 'to use money to buy things, or to use time',
  definition_teacher = 'Verb meaning to use money or time. Essential in business for spending, expenditure, and time management.',
  usage_notes = 'Irregular: spend, spent, spent. Very common in business for money and time.',
  examples = jsonb_build_array(
    'The company spends $2 million annually on training.',
    'We spend too much time in meetings.',
    'How much should we spend on marketing?',
    'Don''t spend all your budget in the first quarter.'
  ),
  collocations = jsonb_build_array('spend money', 'spend time', 'spend on', 'spending budget'),
  patterns = jsonb_build_array('spend + amount + on + noun', 'spend + time + gerund'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'spend' AND cefr_receptive = 'A1';

-- spirit
UPDATE lexicon_entries SET
  ipa = '/ˈspɪrɪt/',
  definition_simple = 'the non-physical part of a person, or enthusiasm',
  definition_teacher = 'Noun meaning soul, attitude, or enthusiasm. In business, used for team spirit, spirit of cooperation, or entrepreneurial spirit.',
  usage_notes = 'Multiple meanings: soul, attitude, enthusiasm, or essence. Common in business contexts.',
  examples = jsonb_build_array(
    'The team has a strong spirit of collaboration.',
    'We need to maintain an entrepreneurial spirit.',
    'The company culture embodies a spirit of innovation.',
    'Let''s approach this in the spirit of partnership.'
  ),
  collocations = jsonb_build_array('team spirit', 'entrepreneurial spirit', 'spirit of cooperation', 'in the spirit of'),
  patterns = jsonb_build_array('spirit of + noun', 'in the spirit of + noun', 'adjective + spirit'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'spirit' AND cefr_receptive = 'A1';

-- spite
UPDATE lexicon_entries SET
  ipa = '/spaɪt/',
  definition_simple = 'a desire to hurt or annoy someone',
  definition_teacher = 'Noun meaning malice or ill will. In business, mainly used in phrase "in spite of" (despite).',
  usage_notes = 'Mainly used in phrase "in spite of" meaning "despite". Less common as standalone noun.',
  examples = jsonb_build_array(
    'In spite of challenges, we achieved our goals.',
    'The project succeeded in spite of limited resources.',
    'In spite of the setback, morale remains high.',
    'We continued in spite of opposition.'
  ),
  collocations = jsonb_build_array('in spite of', 'spite of challenges', 'spite of difficulties'),
  patterns = jsonb_build_array('in spite of + noun', 'in spite of + gerund'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'spite' AND cefr_receptive = 'A1';

-- spot
UPDATE lexicon_entries SET
  ipa = '/spɒt/',
  definition_simple = 'a particular place or small mark',
  definition_teacher = 'Noun or verb meaning location, mark, or to notice. In business, used for spot check, on the spot, or spotting trends.',
  usage_notes = 'Very versatile word. Can be noun (a spot) or verb (to spot = notice).',
  examples = jsonb_build_array(
    'We conduct spot checks on quality.',
    'She was put on the spot during the meeting.',
    'Can you spot any errors in the report?',
    'This is the perfect spot for our new office.'
  ),
  collocations = jsonb_build_array('spot check', 'on the spot', 'spot an error', 'sweet spot'),
  patterns = jsonb_build_array('spot check', 'on the spot', 'spot + noun', 'the + adjective + spot'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'spot' AND cefr_receptive = 'A1';

-- spread
UPDATE lexicon_entries SET
  ipa = '/spred/',
  definition_simple = 'to extend over an area, or to distribute',
  definition_teacher = 'Verb or noun meaning to extend or distribute. Common in business for spreading risk, spreading costs, or information spread.',
  usage_notes = 'Irregular: spread, spread, spread. Very common in business contexts.',
  examples = jsonb_build_array(
    'We need to spread the costs over three years.',
    'The news spread quickly through the organization.',
    'Diversification helps spread risk.',
    'Let''s spread the workload more evenly.'
  ),
  collocations = jsonb_build_array('spread risk', 'spread costs', 'spread out', 'spread the word'),
  patterns = jsonb_build_array('spread + noun', 'spread over + time', 'spread out + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'spread' AND cefr_receptive = 'A1';

-- spring
UPDATE lexicon_entries SET
  ipa = '/sprɪŋ/',
  definition_simple = 'the season between winter and summer, or to jump',
  definition_teacher = 'Noun or verb meaning season, coil, or to jump. In business, used for spring into action or spring up (appear suddenly).',
  usage_notes = 'Multiple meanings: season, coil, or to jump/appear. Irregular verb: spring, sprang, sprung.',
  examples = jsonb_build_array(
    'We need to spring into action immediately.',
    'New competitors are springing up everywhere.',
    'The spring quarter is our busiest season.',
    'Opportunities can spring from challenges.'
  ),
  collocations = jsonb_build_array('spring into action', 'spring up', 'spring quarter', 'spring from'),
  patterns = jsonb_build_array('spring into action', 'spring up', 'spring from + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'spring' AND cefr_receptive = 'A1';

-- square
UPDATE lexicon_entries SET
  ipa = '/skweər/',
  definition_simple = 'a shape with four equal sides, or fair and honest',
  definition_teacher = 'Noun, adjective, or verb with multiple meanings. In business, used for square deal, square footage, or square with.',
  usage_notes = 'Multiple meanings: shape, fair (square deal), or to reconcile (square with).',
  examples = jsonb_build_array(
    'The office has 5,000 square feet of space.',
    'We need a square deal for both parties.',
    'Let''s square this with the legal team.',
    'We''re back to square one on this project.'
  ),
  collocations = jsonb_build_array('square feet', 'square deal', 'square with', 'back to square one'),
  patterns = jsonb_build_array('square + noun', 'square with + person', 'back to square one'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'square' AND cefr_receptive = 'A1';

-- stage
UPDATE lexicon_entries SET
  ipa = '/steɪdʒ/',
  definition_simple = 'a period or step in a process',
  definition_teacher = 'Noun or verb meaning phase or platform. Essential in business for stages of development, staging, or setting the stage.',
  usage_notes = 'Very common in business. Can mean phase (stage of project) or platform (stage for presentation).',
  examples = jsonb_build_array(
    'The project is in the final stage.',
    'We need to stage the rollout carefully.',
    'At this stage, we need more data.',
    'Let me set the stage for today''s discussion.'
  ),
  collocations = jsonb_build_array('at this stage', 'final stage', 'set the stage', 'stage of development'),
  patterns = jsonb_build_array('at this/that stage', 'stage of + noun', 'set the stage for + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'stage' AND cefr_receptive = 'A1';

-- state
UPDATE lexicon_entries SET
  ipa = '/steɪt/',
  definition_simple = 'a condition or situation, or to say something formally',
  definition_teacher = 'Noun or verb meaning condition, government, or to declare. Essential in business for stating facts or state of affairs.',
  usage_notes = 'Very common in business. Multiple meanings: condition, government region, or to declare.',
  examples = jsonb_build_array(
    'The company is in a strong financial state.',
    'Please state your requirements clearly.',
    'The state of the market is uncertain.',
    'As stated in the contract, payment is due monthly.'
  ),
  collocations = jsonb_build_array('state of', 'as stated', 'state clearly', 'current state'),
  patterns = jsonb_build_array('state of + noun', 'as stated in + noun', 'state + that clause'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'state' AND cefr_receptive = 'A1';

-- station
UPDATE lexicon_entries SET
  ipa = '/ˈsteɪʃən/',
  definition_simple = 'a place where trains or buses stop, or a position',
  definition_teacher = 'Noun or verb meaning stop point, position, or to place. In business, used for workstation or being stationed.',
  usage_notes = 'Can mean transport stop, position, or workplace (workstation).',
  examples = jsonb_build_array(
    'Each employee has a workstation with dual monitors.',
    'The office is near the train station.',
    'He is stationed at our London office.',
    'The charging station is in the parking lot.'
  ),
  collocations = jsonb_build_array('workstation', 'train station', 'be stationed', 'charging station'),
  patterns = jsonb_build_array('noun + station', 'be stationed at + place'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'station' AND cefr_receptive = 'A1';

-- stay
UPDATE lexicon_entries SET
  ipa = '/steɪ/',
  definition_simple = 'to remain in a place or condition',
  definition_teacher = 'Verb or noun meaning to remain or a visit. Common in business for staying competitive, staying focused, or hotel stays.',
  usage_notes = 'Very common in business. Can be verb (stay focused) or noun (a stay).',
  examples = jsonb_build_array(
    'We need to stay competitive in the market.',
    'Please stay focused on our core objectives.',
    'The hotel stay is included in the package.',
    'Stay tuned for more updates.'
  ),
  collocations = jsonb_build_array('stay competitive', 'stay focused', 'stay tuned', 'hotel stay'),
  patterns = jsonb_build_array('stay + adjective', 'stay on + noun', 'stay tuned'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'stay' AND cefr_receptive = 'A1';

-- steal
UPDATE lexicon_entries SET
  ipa = '/stiːl/',
  definition_simple = 'to take something that belongs to someone else',
  definition_teacher = 'Verb meaning to take illegally or gain advantage. In business, used for stealing ideas, stealing the show, or theft.',
  usage_notes = 'Irregular: steal, stole, stolen. Can be literal (theft) or figurative (steal the show).',
  examples = jsonb_build_array(
    'Competitors may try to steal our ideas.',
    'The new product stole the show at the conference.',
    'We need to protect against data theft.',
    'Don''t let anyone steal your thunder.'
  ),
  collocations = jsonb_build_array('steal ideas', 'steal the show', 'steal thunder', 'steal market share'),
  patterns = jsonb_build_array('steal + noun', 'steal the show', 'steal from + person'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'steal' AND cefr_receptive = 'A1';

-- steel
UPDATE lexicon_entries SET
  ipa = '/stiːl/',
  definition_simple = 'a strong metal made from iron',
  definition_teacher = 'Noun or verb meaning metal or to strengthen resolve. In business, used for steel industry or steel yourself.',
  usage_notes = 'Can be noun (the metal) or verb (steel yourself = prepare mentally). Common in manufacturing.',
  examples = jsonb_build_array(
    'The steel industry is facing challenges.',
    'We need to steel ourselves for difficult negotiations.',
    'Steel prices affect construction costs.',
    'The company manufactures steel products.'
  ),
  collocations = jsonb_build_array('steel industry', 'steel yourself', 'steel prices', 'steel products'),
  patterns = jsonb_build_array('steel + noun', 'steel yourself for + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'steel' AND cefr_receptive = 'A1';

-- step
UPDATE lexicon_entries SET
  ipa = '/step/',
  definition_simple = 'a movement of the foot, or a stage in a process',
  definition_teacher = 'Noun or verb meaning footstep, stage, or to walk. Essential in business for step-by-step processes or taking steps.',
  usage_notes = 'Very common in business. Can mean physical step, stage in process, or action taken.',
  examples = jsonb_build_array(
    'Let''s take this step by step.',
    'The next step is to get approval.',
    'We need to step up our efforts.',
    'This is a step in the right direction.'
  ),
  collocations = jsonb_build_array('step by step', 'next step', 'step up', 'take steps'),
  patterns = jsonb_build_array('step by step', 'the next step', 'step up + noun', 'take steps to + infinitive'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'step' AND cefr_receptive = 'A1';

-- stick
UPDATE lexicon_entries SET
  ipa = '/stɪk/',
  definition_simple = 'a thin piece of wood, or to attach or stay with',
  definition_teacher = 'Noun or verb meaning rod or to adhere. In business, used for stick to plan, stick with, or making things stick.',
  usage_notes = 'Irregular verb: stick, stuck, stuck. Very common in business phrases.',
  examples = jsonb_build_array(
    'We need to stick to the plan.',
    'Let''s stick with the original strategy.',
    'The name didn''t stick with customers.',
    'Stick to your principles in negotiations.'
  ),
  collocations = jsonb_build_array('stick to', 'stick with', 'stick together', 'make it stick'),
  patterns = jsonb_build_array('stick to + noun', 'stick with + noun', 'stick together'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'stick' AND cefr_receptive = 'A1';

-- stock
UPDATE lexicon_entries SET
  ipa = '/stɒk/',
  definition_simple = 'goods available for sale, or shares in a company',
  definition_teacher = 'Noun or verb meaning inventory, shares, or to supply. Essential in business for stock market, inventory, or stocking.',
  usage_notes = 'Very common in business. Multiple meanings: inventory, shares, or supply.',
  examples = jsonb_build_array(
    'The product is currently out of stock.',
    'Stock prices rose after the announcement.',
    'We need to stock up on supplies.',
    'The company went public on the stock market.'
  ),
  collocations = jsonb_build_array('in stock', 'out of stock', 'stock market', 'stock price'),
  patterns = jsonb_build_array('in/out of stock', 'stock market', 'stock up on + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'stock' AND cefr_receptive = 'A1';

-- stone
UPDATE lexicon_entries SET
  ipa = '/stəʊn/',
  definition_simple = 'hard solid material from the ground, or a rock',
  definition_teacher = 'Noun meaning rock or gem. In business, used in phrases like "set in stone" or "milestone".',
  usage_notes = 'Can be countable (a stone) or uncountable (stone material). Common in business idioms.',
  examples = jsonb_build_array(
    'The plan is not set in stone - we can adjust it.',
    'This is a major milestone for the company.',
    'We need to leave no stone unturned.',
    'The building has a stone facade.'
  ),
  collocations = jsonb_build_array('set in stone', 'milestone', 'leave no stone unturned', 'stepping stone'),
  patterns = jsonb_build_array('set in stone', 'milestone', 'leave no stone unturned'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'stone' AND cefr_receptive = 'A1';

-- stop
UPDATE lexicon_entries SET
  ipa = '/stɒp/',
  definition_simple = 'to end movement or action',
  definition_teacher = 'Verb or noun meaning to cease or a halt. Essential in business for stopping processes, stop-gap measures, or full stop.',
  usage_notes = 'Very common in business. Can be verb (stop working) or noun (a stop).',
  examples = jsonb_build_array(
    'We need to stop wasting resources.',
    'The project came to a full stop.',
    'This is just a stop-gap solution.',
    'Stop and think before making decisions.'
  ),
  collocations = jsonb_build_array('stop doing', 'full stop', 'stop-gap', 'non-stop'),
  patterns = jsonb_build_array('stop + gerund', 'stop + noun', 'come to a stop'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'stop' AND cefr_receptive = 'A1';

-- store
UPDATE lexicon_entries SET
  ipa = '/stɔːr/',
  definition_simple = 'a shop, or to keep something for future use',
  definition_teacher = 'Noun or verb meaning shop or to keep. Essential in business for retail stores, storage, or storing data.',
  usage_notes = 'Very common in business. Can be noun (a store) or verb (to store).',
  examples = jsonb_build_array(
    'We operate 50 stores nationwide.',
    'Data is stored securely in the cloud.',
    'The store opens at 9 AM.',
    'We need to store inventory efficiently.'
  ),
  collocations = jsonb_build_array('retail store', 'store data', 'in store', 'store manager'),
  patterns = jsonb_build_array('noun + store', 'store + noun', 'in store for + person'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'store' AND cefr_receptive = 'A1';

-- storm
UPDATE lexicon_entries SET
  ipa = '/stɔːrm/',
  definition_simple = 'very bad weather with wind and rain',
  definition_teacher = 'Noun or verb meaning severe weather or turmoil. In business, used for weathering storms or brainstorming.',
  usage_notes = 'Can be literal (weather) or figurative (storm of criticism). Common in business metaphors.',
  examples = jsonb_build_array(
    'The company weathered the economic storm.',
    'Let''s brainstorm solutions to this problem.',
    'A storm of criticism followed the announcement.',
    'We need to prepare for the perfect storm of challenges.'
  ),
  collocations = jsonb_build_array('weather the storm', 'brainstorm', 'storm of', 'perfect storm'),
  patterns = jsonb_build_array('weather the storm', 'brainstorm + noun', 'storm of + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'storm' AND cefr_receptive = 'A1';

-- story
UPDATE lexicon_entries SET
  ipa = '/ˈstɔːri/',
  definition_simple = 'a description of events, real or imagined',
  definition_teacher = 'Noun meaning narrative or account. In business, used for brand story, success story, or telling the story.',
  usage_notes = 'Very common in business. Can mean narrative, account, or floor of building (US).',
  examples = jsonb_build_array(
    'Every brand has a story to tell.',
    'This is a success story worth sharing.',
    'The data tells a different story.',
    'Let me tell you the full story.'
  ),
  collocations = jsonb_build_array('brand story', 'success story', 'tell a story', 'the full story'),
  patterns = jsonb_build_array('tell a story', 'noun + story', 'the story of + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'story' AND cefr_receptive = 'A1';

-- straight
UPDATE lexicon_entries SET
  ipa = '/streɪt/',
  definition_simple = 'not curved or bent, or honest and direct',
  definition_teacher = 'Adjective or adverb meaning direct, honest, or uncurved. Common in business for straight talk or getting things straight.',
  usage_notes = 'Multiple meanings: not curved, honest (straight talk), or immediately (straight away).',
  examples = jsonb_build_array(
    'Let me give you the straight facts.',
    'We need straight talk about the challenges.',
    'Let''s get straight to the point.',
    'I''ll get back to you straight away.'
  ),
  collocations = jsonb_build_array('straight talk', 'straight away', 'get straight', 'straight to the point'),
  patterns = jsonb_build_array('straight + noun', 'straight away', 'get straight to + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'straight' AND cefr_receptive = 'A1';

-- strange
UPDATE lexicon_entries SET
  ipa = '/streɪndʒ/',
  definition_simple = 'unusual or surprising',
  definition_teacher = 'Adjective meaning unusual, odd, or unfamiliar. Common in business for describing unexpected situations or behaviors.',
  usage_notes = 'Can mean "unusual" or "unfamiliar". Used to describe unexpected or odd situations.',
  examples = jsonb_build_array(
    'It''s strange that we haven''t received a response.',
    'The market is behaving in strange ways.',
    'Strange as it may seem, the strategy worked.',
    'We''re seeing some strange patterns in the data.'
  ),
  collocations = jsonb_build_array('it''s strange', 'strange behavior', 'strange as it seems', 'strange patterns'),
  patterns = jsonb_build_array('it''s strange that + clause', 'strange + noun', 'strange as it seems'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'strange' AND cefr_receptive = 'A1';

-- stream
UPDATE lexicon_entries SET
  ipa = '/striːm/',
  definition_simple = 'a small river, or a continuous flow',
  definition_teacher = 'Noun or verb meaning flow or to transmit. In business, used for revenue streams, streaming data, or workflow streams.',
  usage_notes = 'Very common in modern business. Can mean water flow, data flow, or continuous transmission.',
  examples = jsonb_build_array(
    'We have multiple revenue streams.',
    'The company streams live events online.',
    'Data streams in real-time from sensors.',
    'We need to streamline our processes.'
  ),
  collocations = jsonb_build_array('revenue stream', 'data stream', 'stream online', 'streamline'),
  patterns = jsonb_build_array('noun + stream', 'stream + noun', 'streamline + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'stream' AND cefr_receptive = 'A1';

-- strength
UPDATE lexicon_entries SET
  ipa = '/streŋθ/',
  definition_simple = 'the quality of being strong or powerful',
  definition_teacher = 'Noun meaning power, force, or capability. Essential in business for strengths analysis, core strengths, or strength in numbers.',
  usage_notes = 'Very common in business. Can be physical, organizational, or market strength.',
  examples = jsonb_build_array(
    'Innovation is our core strength.',
    'The company goes from strength to strength.',
    'We need to build on our strengths.',
    'There''s strength in numbers when negotiating.'
  ),
  collocations = jsonb_build_array('core strength', 'strength to strength', 'build on strengths', 'strength in numbers'),
  patterns = jsonb_build_array('core strength', 'from strength to strength', 'strength in + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'strength' AND cefr_receptive = 'A1';

-- stretch
UPDATE lexicon_entries SET
  ipa = '/stretʃ/',
  definition_simple = 'to make or become longer or wider',
  definition_teacher = 'Verb or noun meaning to extend or period. In business, used for stretching resources, stretch goals, or final stretch.',
  usage_notes = 'Very common in business. Can mean extend physically, challenge (stretch goal), or period (stretch of time).',
  examples = jsonb_build_array(
    'We need to stretch our budget further.',
    'Set stretch goals to drive performance.',
    'The team is stretched thin with current workload.',
    'We''re in the final stretch of the project.'
  ),
  collocations = jsonb_build_array('stretch goals', 'stretched thin', 'final stretch', 'stretch resources'),
  patterns = jsonb_build_array('stretch + noun', 'stretched thin', 'stretch goal'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'stretch' AND cefr_receptive = 'A1';

-- strike
UPDATE lexicon_entries SET
  ipa = '/straɪk/',
  definition_simple = 'to hit, or when workers stop working as protest',
  definition_teacher = 'Verb or noun meaning to hit, work stoppage, or to achieve. In business, used for strikes, striking deals, or striking balance.',
  usage_notes = 'Irregular: strike, struck, struck. Multiple meanings in business contexts.',
  examples = jsonb_build_array(
    'We struck a deal with the supplier.',
    'The workers went on strike for better wages.',
    'We need to strike a balance between cost and quality.',
    'The idea struck me during the meeting.'
  ),
  collocations = jsonb_build_array('strike a deal', 'go on strike', 'strike a balance', 'strike an agreement'),
  patterns = jsonb_build_array('strike a deal/balance', 'go on strike', 'strike + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'strike' AND cefr_receptive = 'A1';

-- strong
UPDATE lexicon_entries SET
  ipa = '/strɒŋ/',
  definition_simple = 'having power or force',
  definition_teacher = 'Adjective meaning powerful, solid, or intense. Essential in business for strong performance, strong position, or strong growth.',
  usage_notes = 'Very common in business. Can describe physical strength, market position, or intensity.',
  examples = jsonb_build_array(
    'The company has a strong market position.',
    'We delivered strong results this quarter.',
    'There''s strong demand for our products.',
    'We need strong leadership during this transition.'
  ),
  collocations = jsonb_build_array('strong position', 'strong results', 'strong demand', 'strong leadership'),
  patterns = jsonb_build_array('strong + noun', 'strong in + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'strong' AND cefr_receptive = 'A1';
