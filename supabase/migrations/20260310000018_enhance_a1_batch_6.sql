-- Enhancement of A1 Vocabulary - Batch 6 (82 words: struggle → worth) - FINAL BATCH
-- Professional English context for Brazilian learners
-- Migration: 20260310000018

-- struggle
UPDATE lexicon_entries SET
  ipa = '/ˈstrʌɡəl/',
  definition_simple = 'to try very hard to do something difficult',
  definition_teacher = 'Verb or noun meaning to strive with difficulty or a difficult effort. Common in business for discussing challenges.',
  usage_notes = 'Can be verb (struggle to do) or noun (a struggle). Very common in business contexts.',
  examples = jsonb_build_array(
    'Small businesses struggle to compete with large corporations.',
    'The team struggled to meet the tight deadline.',
    'It''s a struggle to balance work and personal life.',
    'We struggled through the economic downturn.'
  ),
  collocations = jsonb_build_array('struggle to', 'struggle with', 'uphill struggle', 'power struggle'),
  patterns = jsonb_build_array('struggle + to infinitive', 'struggle with + noun', 'a struggle to + infinitive'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'struggle' AND cefr_receptive = 'A1';

-- study
UPDATE lexicon_entries SET
  ipa = '/ˈstʌdi/',
  definition_simple = 'to learn about something by reading or research',
  definition_teacher = 'Verb or noun meaning to examine or research. Essential in business for market studies, case studies, or studying data.',
  usage_notes = 'Very common in business. Can be verb (study the market) or noun (a study).',
  examples = jsonb_build_array(
    'We need to study the market before launching.',
    'The feasibility study shows positive results.',
    'Let''s study the competition carefully.',
    'Case studies provide valuable insights.'
  ),
  collocations = jsonb_build_array('case study', 'market study', 'study shows', 'feasibility study'),
  patterns = jsonb_build_array('study + noun', 'study shows that + clause', 'case study'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'study' AND cefr_receptive = 'A1';

-- subject
UPDATE lexicon_entries SET
  ipa = '/ˈsʌbdʒɪkt/',
  definition_simple = 'a topic or area of knowledge',
  definition_teacher = 'Noun meaning topic, person under authority, or area of study. Common in business for subject matter or being subject to.',
  usage_notes = 'Multiple meanings: topic (subject of discussion), person (subject to rules), or area of study.',
  examples = jsonb_build_array(
    'The subject of today''s meeting is budget planning.',
    'All employees are subject to company policies.',
    'She is a subject matter expert in finance.',
    'This is subject to approval by management.'
  ),
  collocations = jsonb_build_array('subject matter', 'subject to', 'subject of', 'subject expert'),
  patterns = jsonb_build_array('subject of + noun', 'subject to + noun', 'subject matter expert'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'subject' AND cefr_receptive = 'A1';

-- substance
UPDATE lexicon_entries SET
  ipa = '/ˈsʌbstəns/',
  definition_simple = 'a material or the most important part of something',
  definition_teacher = 'Noun meaning material, essence, or importance. In business, used for substance over style or substantial matters.',
  usage_notes = 'Can mean physical material or essence/importance. Related: substantial, substantive.',
  examples = jsonb_build_array(
    'We need substance, not just style, in our proposals.',
    'The report lacks substance and detail.',
    'There''s no substance to those rumors.',
    'The discussion had real substance.'
  ),
  collocations = jsonb_build_array('substance over style', 'lack substance', 'substance of', 'in substance'),
  patterns = jsonb_build_array('substance over style', 'lack substance', 'substance of + noun'),
  register = 'formal',
  variety = 'international'
WHERE headword = 'substance' AND cefr_receptive = 'A1';

-- succeed
UPDATE lexicon_entries SET
  ipa = '/səkˈsiːd/',
  definition_simple = 'to achieve what you want or to come after',
  definition_teacher = 'Verb meaning to achieve goals or follow in position. Essential in business for success and succession.',
  usage_notes = 'Can mean "achieve success" or "follow/replace". Related: success, successful, succession.',
  examples = jsonb_build_array(
    'The company succeeded in entering new markets.',
    'She will succeed the current CEO next year.',
    'To succeed, you need dedication and strategy.',
    'The project succeeded beyond expectations.'
  ),
  collocations = jsonb_build_array('succeed in', 'succeed at', 'succeed as', 'succeed someone'),
  patterns = jsonb_build_array('succeed in + gerund', 'succeed + person', 'succeed as + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'succeed' AND cefr_receptive = 'A1';

-- sudden
UPDATE lexicon_entries SET
  ipa = '/ˈsʌdən/',
  definition_simple = 'happening quickly and unexpectedly',
  definition_teacher = 'Adjective meaning unexpected or abrupt. Common in business for sudden changes or sudden events.',
  usage_notes = 'Used to describe unexpected events. Related: suddenly (adverb). Often with "all of a sudden".',
  examples = jsonb_build_array(
    'The sudden market crash surprised investors.',
    'We need to respond to sudden changes quickly.',
    'All of a sudden, demand increased dramatically.',
    'The sudden resignation created uncertainty.'
  ),
  collocations = jsonb_build_array('sudden change', 'all of a sudden', 'sudden increase', 'sudden drop'),
  patterns = jsonb_build_array('sudden + noun', 'all of a sudden'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'sudden' AND cefr_receptive = 'A1';

-- suffer
UPDATE lexicon_entries SET
  ipa = '/ˈsʌfər/',
  definition_simple = 'to experience something bad or painful',
  definition_teacher = 'Verb meaning to experience pain or loss. Common in business for suffering losses, setbacks, or consequences.',
  usage_notes = 'Can be followed by noun (suffer losses) or from (suffer from problems).',
  examples = jsonb_build_array(
    'The company suffered significant losses last year.',
    'Sales suffered from poor marketing.',
    'We cannot afford to suffer another setback.',
    'The brand suffered damage from the scandal.'
  ),
  collocations = jsonb_build_array('suffer losses', 'suffer from', 'suffer damage', 'suffer consequences'),
  patterns = jsonb_build_array('suffer + noun', 'suffer from + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'suffer' AND cefr_receptive = 'A1';

-- suggest
UPDATE lexicon_entries SET
  ipa = '/səˈdʒest/',
  definition_simple = 'to mention an idea or plan for others to consider',
  definition_teacher = 'Verb meaning to propose or indicate. Essential in business for making suggestions and recommendations.',
  usage_notes = 'Very common in business. Can be followed by noun, gerund, or that-clause. Related: suggestion.',
  examples = jsonb_build_array(
    'I suggest we review the proposal carefully.',
    'The data suggests a positive trend.',
    'May I suggest an alternative approach?',
    'She suggested postponing the meeting.'
  ),
  collocations = jsonb_build_array('suggest that', 'suggest doing', 'data suggests', 'may I suggest'),
  patterns = jsonb_build_array('suggest + that clause', 'suggest + gerund', 'suggest + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'suggest' AND cefr_receptive = 'A1';

-- summer
UPDATE lexicon_entries SET
  ipa = '/ˈsʌmər/',
  definition_simple = 'the warmest season of the year',
  definition_teacher = 'Noun meaning the season between spring and autumn. In business, relevant for seasonal patterns and planning.',
  usage_notes = 'Countable or uncountable. Important for seasonal business planning and vacation schedules.',
  examples = jsonb_build_array(
    'Summer is our slowest season for sales.',
    'Many employees take vacation during summer.',
    'We launch the summer campaign in June.',
    'Summer hours begin next week.'
  ),
  collocations = jsonb_build_array('summer season', 'summer vacation', 'summer hours', 'this summer'),
  patterns = jsonb_build_array('in/during summer', 'summer + noun', 'this/next/last summer'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'summer' AND cefr_receptive = 'A1';

-- sun
UPDATE lexicon_entries SET
  ipa = '/sʌn/',
  definition_simple = 'the star that gives Earth light and heat',
  definition_teacher = 'Noun meaning the star or sunshine. In business, used in phrases or for solar energy discussions.',
  usage_notes = 'Usually singular with "the". Used in business idioms and solar energy contexts.',
  examples = jsonb_build_array(
    'The company invests in solar energy from the sun.',
    'Everything under the sun has been tried.',
    'Our office has excellent sun exposure.',
    'The sun is setting on that business model.'
  ),
  collocations = jsonb_build_array('under the sun', 'solar energy', 'sun exposure', 'sunrise industry'),
  patterns = jsonb_build_array('under the sun', 'the sun + verb'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'sun' AND cefr_receptive = 'A1';

-- supply
UPDATE lexicon_entries SET
  ipa = '/səˈplaɪ/',
  definition_simple = 'to provide something needed, or an amount available',
  definition_teacher = 'Verb or noun meaning to provide or stock. Essential in business for supply chain, supply and demand.',
  usage_notes = 'Very common in business. Can be verb (supply goods) or noun (supply of goods).',
  examples = jsonb_build_array(
    'We supply products to retailers nationwide.',
    'Supply chain disruptions affect delivery times.',
    'The law of supply and demand determines prices.',
    'We have a limited supply of this item.'
  ),
  collocations = jsonb_build_array('supply chain', 'supply and demand', 'supply goods', 'in short supply'),
  patterns = jsonb_build_array('supply + noun + to + person', 'supply of + noun', 'supply chain'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'supply' AND cefr_receptive = 'A1';

-- support
UPDATE lexicon_entries SET
  ipa = '/səˈpɔːrt/',
  definition_simple = 'to help or encourage, or help given',
  definition_teacher = 'Verb or noun meaning to assist or assistance. Essential in business for customer support, support services.',
  usage_notes = 'Very common in business. Can be verb (support customers) or noun (customer support).',
  examples = jsonb_build_array(
    'We provide 24/7 customer support.',
    'The data supports our hypothesis.',
    'Management supports the new initiative.',
    'Technical support is available by phone.'
  ),
  collocations = jsonb_build_array('customer support', 'technical support', 'support services', 'in support of'),
  patterns = jsonb_build_array('support + noun', 'provide support', 'in support of + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'support' AND cefr_receptive = 'A1';

-- suppose
UPDATE lexicon_entries SET
  ipa = '/səˈpəʊz/',
  definition_simple = 'to think something is likely or to assume',
  definition_teacher = 'Verb meaning to assume or believe. Common in business for supposing scenarios or expressing tentative opinions.',
  usage_notes = 'Often used in passive (be supposed to). Can express assumption or obligation.',
  examples = jsonb_build_array(
    'I suppose we could try that approach.',
    'You''re supposed to submit reports by Friday.',
    'Suppose the market changes - what''s our plan?',
    'The meeting is supposed to start at 2 PM.'
  ),
  collocations = jsonb_build_array('I suppose', 'be supposed to', 'suppose that', 'supposed to be'),
  patterns = jsonb_build_array('I suppose + clause', 'be supposed to + infinitive', 'suppose + that clause'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'suppose' AND cefr_receptive = 'A1';

-- sure
UPDATE lexicon_entries SET
  ipa = '/ʃʊr/',
  definition_simple = 'certain or confident about something',
  definition_teacher = 'Adjective meaning certain or confident. Very common in business for expressing certainty or making sure.',
  usage_notes = 'Very common in business. Used to express certainty or in phrase "make sure".',
  examples = jsonb_build_array(
    'Are you sure about these numbers?',
    'Make sure to review the contract carefully.',
    'I''m not sure if that''s the best approach.',
    'We need to be sure before committing.'
  ),
  collocations = jsonb_build_array('make sure', 'be sure', 'for sure', 'sure about'),
  patterns = jsonb_build_array('make sure + that clause', 'be sure + about/of + noun', 'sure to + infinitive'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'sure' AND cefr_receptive = 'A1';

-- surface
UPDATE lexicon_entries SET
  ipa = '/ˈsɜːrfɪs/',
  definition_simple = 'the outside or top layer of something',
  definition_teacher = 'Noun or verb meaning outer layer or to emerge. In business, used for surface level, scratch the surface, or issues surfacing.',
  usage_notes = 'Can be noun (the surface) or verb (to surface = emerge). Common in business contexts.',
  examples = jsonb_build_array(
    'On the surface, everything looks fine.',
    'We''ve only scratched the surface of the market.',
    'New problems are surfacing daily.',
    'Let''s look beneath the surface of the data.'
  ),
  collocations = jsonb_build_array('on the surface', 'scratch the surface', 'surface level', 'beneath the surface'),
  patterns = jsonb_build_array('on the surface', 'scratch the surface', 'surface + verb'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'surface' AND cefr_receptive = 'A1';

-- surprise
UPDATE lexicon_entries SET
  ipa = '/sərˈpraɪz/',
  definition_simple = 'an unexpected event, or to cause someone to feel surprised',
  definition_teacher = 'Noun or verb meaning unexpected event or to astonish. Common in business for surprising results or surprise announcements.',
  usage_notes = 'Can be noun (a surprise) or verb (to surprise). Very common in business contexts.',
  examples = jsonb_build_array(
    'The results came as a pleasant surprise.',
    'The announcement surprised investors.',
    'It''s no surprise that sales increased.',
    'We have a surprise for our customers.'
  ),
  collocations = jsonb_build_array('pleasant surprise', 'no surprise', 'surprise announcement', 'come as a surprise'),
  patterns = jsonb_build_array('come as a surprise', 'it''s no surprise that + clause', 'surprise + person'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'surprise' AND cefr_receptive = 'A1';

-- surround
UPDATE lexicon_entries SET
  ipa = '/səˈraʊnd/',
  definition_simple = 'to be all around something',
  definition_teacher = 'Verb meaning to encircle or be around. In business, used for surrounding circumstances or being surrounded by.',
  usage_notes = 'Often used in passive (be surrounded by). Can be literal or figurative.',
  examples = jsonb_build_array(
    'The office is surrounded by restaurants and shops.',
    'We need to understand the circumstances surrounding the issue.',
    'The company is surrounded by competitors.',
    'Uncertainty surrounds the merger.'
  ),
  collocations = jsonb_build_array('surrounded by', 'surrounding area', 'circumstances surrounding', 'surround yourself with'),
  patterns = jsonb_build_array('be surrounded by + noun', 'surrounding + noun', 'surround + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'surround' AND cefr_receptive = 'A1';

-- sweet
UPDATE lexicon_entries SET
  ipa = '/swiːt/',
  definition_simple = 'having a taste like sugar, or pleasant',
  definition_teacher = 'Adjective meaning sugary or pleasant. In business, used in phrases like "sweet spot" or "sweet deal".',
  usage_notes = 'Can be literal (sweet taste) or figurative (sweet deal). Common in business idioms.',
  examples = jsonb_build_array(
    'We found the sweet spot for pricing.',
    'That''s a sweet deal for both parties.',
    'The sweet spot is between quality and cost.',
    'Success tastes sweet after hard work.'
  ),
  collocations = jsonb_build_array('sweet spot', 'sweet deal', 'short and sweet', 'sweet success'),
  patterns = jsonb_build_array('sweet spot', 'sweet deal', 'sweet + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'sweet' AND cefr_receptive = 'A1';

-- system
UPDATE lexicon_entries SET
  ipa = '/ˈsɪstəm/',
  definition_simple = 'a set of connected things or parts working together',
  definition_teacher = 'Noun meaning organized structure or method. Essential in business for systems, processes, and IT systems.',
  usage_notes = 'Very common in business. Can refer to IT systems, business systems, or organizational systems.',
  examples = jsonb_build_array(
    'We need to upgrade our IT systems.',
    'The system is down for maintenance.',
    'Our quality management system ensures consistency.',
    'The new system improves efficiency.'
  ),
  collocations = jsonb_build_array('IT system', 'management system', 'system down', 'operating system'),
  patterns = jsonb_build_array('noun + system', 'system + verb', 'system for + gerund'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'system' AND cefr_receptive = 'A1';

-- taste
UPDATE lexicon_entries SET
  ipa = '/teɪst/',
  definition_simple = 'the flavor of food, or to experience flavor',
  definition_teacher = 'Noun or verb meaning flavor or preference. In business, used for taste of success or consumer taste.',
  usage_notes = 'Can be literal (food taste) or figurative (taste of success, good taste in design).',
  examples = jsonb_build_array(
    'Consumer tastes are changing rapidly.',
    'The team got a taste of success.',
    'The design shows good taste.',
    'We need to taste test the new product.'
  ),
  collocations = jsonb_build_array('consumer taste', 'taste of success', 'good taste', 'taste test'),
  patterns = jsonb_build_array('taste of + noun', 'good/bad taste', 'taste + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'taste' AND cefr_receptive = 'A1';

-- teach
UPDATE lexicon_entries SET
  ipa = '/tiːtʃ/',
  definition_simple = 'to give lessons or instruction',
  definition_teacher = 'Verb meaning to instruct or educate. Common in business for teaching skills, training, or lessons learned.',
  usage_notes = 'Irregular: teach, taught, taught. Very common in business training contexts.',
  examples = jsonb_build_array(
    'We teach employees new skills through training.',
    'Experience teaches valuable lessons.',
    'The program teaches leadership skills.',
    'This situation taught us to be more careful.'
  ),
  collocations = jsonb_build_array('teach skills', 'teach lessons', 'teach someone to', 'teach about'),
  patterns = jsonb_build_array('teach + person + noun', 'teach + person + to infinitive', 'teach about + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'teach' AND cefr_receptive = 'A1';

-- tear
UPDATE lexicon_entries SET
  ipa = '/teər/',
  definition_simple = 'to pull apart or rip, or a drop of liquid from the eye',
  definition_teacher = 'Verb or noun with two meanings. In business, mainly used in phrases like "wear and tear" or "tear down".',
  usage_notes = 'Two words: /teər/ (rip) irregular: tear, tore, torn; /tɪər/ (from eye). Different pronunciations.',
  examples = jsonb_build_array(
    'Normal wear and tear is expected.',
    'We need to tear down old processes.',
    'The contract was torn up.',
    'Don''t tear yourself apart over mistakes.'
  ),
  collocations = jsonb_build_array('wear and tear', 'tear down', 'tear up', 'tear apart'),
  patterns = jsonb_build_array('wear and tear', 'tear down + noun', 'tear up + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'tear' AND cefr_receptive = 'A1';

-- term
UPDATE lexicon_entries SET
  ipa = '/tɜːrm/',
  definition_simple = 'a word or phrase, or a fixed period of time',
  definition_teacher = 'Noun meaning word, period, or condition. Essential in business for terms and conditions, contract terms, or terminology.',
  usage_notes = 'Very common in business. Multiple meanings: word/phrase, time period, or conditions.',
  examples = jsonb_build_array(
    'Please review the terms and conditions.',
    'The contract term is three years.',
    'In business terms, this is a good deal.',
    'We need to agree on payment terms.'
  ),
  collocations = jsonb_build_array('terms and conditions', 'contract term', 'in terms of', 'payment terms'),
  patterns = jsonb_build_array('terms and conditions', 'in terms of + noun', 'term of + time'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'term' AND cefr_receptive = 'A1';

-- terrible
UPDATE lexicon_entries SET
  ipa = '/ˈterəbəl/',
  definition_simple = 'very bad or unpleasant',
  definition_teacher = 'Adjective meaning very bad or severe. Common in business for describing poor performance or bad situations.',
  usage_notes = 'Strong negative adjective. Used to emphasize how bad something is.',
  examples = jsonb_build_array(
    'The company had a terrible quarter.',
    'That would be a terrible mistake.',
    'Customer service was terrible.',
    'The timing is terrible for this announcement.'
  ),
  collocations = jsonb_build_array('terrible mistake', 'terrible timing', 'terrible news', 'feel terrible'),
  patterns = jsonb_build_array('terrible + noun', 'it would be terrible to + infinitive'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'terrible' AND cefr_receptive = 'A1';

-- test
UPDATE lexicon_entries SET
  ipa = '/test/',
  definition_simple = 'an examination or trial, or to examine',
  definition_teacher = 'Noun or verb meaning examination or to examine. Essential in business for testing products, A/B testing, or test markets.',
  usage_notes = 'Very common in business. Can be noun (a test) or verb (to test).',
  examples = jsonb_build_array(
    'We need to test the new system thoroughly.',
    'The product passed all quality tests.',
    'Let''s run an A/B test on the website.',
    'The test market showed positive results.'
  ),
  collocations = jsonb_build_array('test market', 'A/B test', 'quality test', 'test results'),
  patterns = jsonb_build_array('test + noun', 'run a test', 'test + verb'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'test' AND cefr_receptive = 'A1';

-- thought
UPDATE lexicon_entries SET
  ipa = '/θɔːt/',
  definition_simple = 'an idea or opinion, or past tense of think',
  definition_teacher = 'Noun meaning idea or consideration. Essential in business for thought leadership, food for thought, or giving thought.',
  usage_notes = 'Can be noun (a thought) or past tense of "think". Very common in business contexts.',
  examples = jsonb_build_array(
    'That''s an interesting thought.',
    'We need to give this more thought.',
    'The report provides food for thought.',
    'She''s a thought leader in the industry.'
  ),
  collocations = jsonb_build_array('food for thought', 'thought leader', 'give thought to', 'second thoughts'),
  patterns = jsonb_build_array('give thought to + noun', 'food for thought', 'thought leader'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'thought' AND cefr_receptive = 'A1';

-- throw
UPDATE lexicon_entries SET
  ipa = '/θrəʊ/',
  definition_simple = 'to send something through the air with force',
  definition_teacher = 'Verb meaning to propel or discard. In business, used in phrases like "throw away" or "throw in the towel".',
  usage_notes = 'Irregular: throw, threw, thrown. Common in business idioms and phrasal verbs.',
  examples = jsonb_build_array(
    'Don''t throw away this opportunity.',
    'Let''s throw some ideas around.',
    'We won''t throw in the towel yet.',
    'The error threw off our calculations.'
  ),
  collocations = jsonb_build_array('throw away', 'throw in the towel', 'throw around', 'throw off'),
  patterns = jsonb_build_array('throw away + noun', 'throw in the towel', 'throw + noun + around'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'throw' AND cefr_receptive = 'A1';

-- thus
UPDATE lexicon_entries SET
  ipa = '/ðʌs/',
  definition_simple = 'therefore or in this way',
  definition_teacher = 'Adverb meaning therefore or in this manner. Formal word common in business writing for showing results.',
  usage_notes = 'Formal adverb. More common in writing than speech. Similar to "therefore".',
  examples = jsonb_build_array(
    'Costs increased, thus reducing profit margins.',
    'The market changed, and thus we adapted our strategy.',
    'Thus far, results have been positive.',
    'We must thus conclude that the approach works.'
  ),
  collocations = jsonb_build_array('thus far', 'and thus', 'thus reducing', 'thus increasing'),
  patterns = jsonb_build_array('and thus + clause', 'thus far', 'thus + gerund'),
  register = 'formal',
  variety = 'international'
WHERE headword = 'thus' AND cefr_receptive = 'A1';

-- together
UPDATE lexicon_entries SET
  ipa = '/təˈɡeðər/',
  definition_simple = 'with each other or in one place',
  definition_teacher = 'Adverb meaning jointly or in combination. Very common in business for collaboration and teamwork.',
  usage_notes = 'Very common in business. Emphasizes collaboration, unity, or combination.',
  examples = jsonb_build_array(
    'Let''s work together to solve this problem.',
    'The team pulled together during the crisis.',
    'Together, we can achieve great results.',
    'We need to get our act together.'
  ),
  collocations = jsonb_build_array('work together', 'pull together', 'bring together', 'get together'),
  patterns = jsonb_build_array('work together', 'together with + noun', 'pull together'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'together' AND cefr_receptive = 'A1';

-- top
UPDATE lexicon_entries SET
  ipa = '/tɒp/',
  definition_simple = 'the highest point or best',
  definition_teacher = 'Noun or adjective meaning highest or best. Essential in business for top priority, top performance, or top management.',
  usage_notes = 'Very common in business. Can be noun (the top), adjective (top priority), or verb (to top).',
  examples = jsonb_build_array(
    'Quality is our top priority.',
    'She''s at the top of her field.',
    'Top management approved the budget.',
    'We need to stay on top of market trends.'
  ),
  collocations = jsonb_build_array('top priority', 'top management', 'on top of', 'at the top'),
  patterns = jsonb_build_array('top + noun', 'at the top of + noun', 'on top of + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'top' AND cefr_receptive = 'A1';

-- total
UPDATE lexicon_entries SET
  ipa = '/ˈtəʊtəl/',
  definition_simple = 'complete or the whole amount',
  definition_teacher = 'Adjective, noun, or verb meaning complete or sum. Essential in business for totals, total cost, or totaling amounts.',
  usage_notes = 'Very common in business. Can be adjective (total cost), noun (the total), or verb (to total).',
  examples = jsonb_build_array(
    'The total cost is $50,000.',
    'We achieved total customer satisfaction.',
    'The expenses total $10,000 this month.',
    'In total, we have 500 employees.'
  ),
  collocations = jsonb_build_array('total cost', 'in total', 'total amount', 'grand total'),
  patterns = jsonb_build_array('total + noun', 'in total', 'total + amount'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'total' AND cefr_receptive = 'A1';

-- touch
UPDATE lexicon_entries SET
  ipa = '/tʌtʃ/',
  definition_simple = 'to put your hand on something, or contact',
  definition_teacher = 'Verb or noun meaning to make contact or communication. In business, used for staying in touch or touching base.',
  usage_notes = 'Very common in business. Can be literal (physical touch) or figurative (stay in touch).',
  examples = jsonb_build_array(
    'Let''s stay in touch after the meeting.',
    'I''ll touch base with you next week.',
    'The presentation touched on key issues.',
    'We need to keep in touch with customers.'
  ),
  collocations = jsonb_build_array('stay in touch', 'touch base', 'get in touch', 'touch on'),
  patterns = jsonb_build_array('stay/keep in touch', 'touch base with + person', 'touch on + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'touch' AND cefr_receptive = 'A1';

-- toward/s
UPDATE lexicon_entries SET
  ipa = '/təˈwɔːrd/',
  definition_simple = 'in the direction of something',
  definition_teacher = 'Preposition meaning in the direction of or regarding. Common in business for moving toward goals or attitudes toward.',
  usage_notes = '"Toward" (US) and "towards" (UK) are both correct. Very common in business contexts.',
  examples = jsonb_build_array(
    'We''re moving toward our quarterly goals.',
    'What''s your attitude toward remote work?',
    'The company is working toward sustainability.',
    'Progress toward completion is steady.'
  ),
  collocations = jsonb_build_array('toward goals', 'attitude toward', 'move toward', 'work toward'),
  patterns = jsonb_build_array('toward + noun', 'move/work toward + noun', 'attitude toward + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'toward/s' AND cefr_receptive = 'A1';

-- town
UPDATE lexicon_entries SET
  ipa = '/taʊn/',
  definition_simple = 'a place with houses and buildings, smaller than a city',
  definition_teacher = 'Noun meaning small urban area. In business, used for town hall meetings or going to town (doing thoroughly).',
  usage_notes = 'Can be literal (a town) or in business phrases like "town hall meeting".',
  examples = jsonb_build_array(
    'We''re holding a town hall meeting next week.',
    'The team really went to town on the presentation.',
    'Our stores are in small towns nationwide.',
    'The new office is out of town.'
  ),
  collocations = jsonb_build_array('town hall', 'go to town', 'out of town', 'small town'),
  patterns = jsonb_build_array('town hall meeting', 'go to town on + noun', 'in/out of town'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'town' AND cefr_receptive = 'A1';

-- trade
UPDATE lexicon_entries SET
  ipa = '/treɪd/',
  definition_simple = 'the buying and selling of goods, or to exchange',
  definition_teacher = 'Noun or verb meaning commerce or to exchange. Essential in business for trade, trading, and international trade.',
  usage_notes = 'Very common in business. Can be noun (international trade) or verb (trade goods).',
  examples = jsonb_build_array(
    'International trade drives our growth.',
    'We trade with partners in 50 countries.',
    'The trade agreement benefits both sides.',
    'Let''s trade ideas on this topic.'
  ),
  collocations = jsonb_build_array('international trade', 'trade agreement', 'trade with', 'trade show'),
  patterns = jsonb_build_array('trade with + person/country', 'trade + noun', 'trade agreement'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'trade' AND cefr_receptive = 'A1';

-- train
UPDATE lexicon_entries SET
  ipa = '/treɪn/',
  definition_simple = 'a railway vehicle, or to teach skills',
  definition_teacher = 'Noun or verb meaning railway transport or to educate. Essential in business for training employees and development.',
  usage_notes = 'Very common in business. Can be noun (a train) or verb (to train employees).',
  examples = jsonb_build_array(
    'We train all new employees for two weeks.',
    'The training program covers essential skills.',
    'She''s training to become a manager.',
    'Employee training is a priority.'
  ),
  collocations = jsonb_build_array('train employees', 'training program', 'train for', 'on-the-job training'),
  patterns = jsonb_build_array('train + person', 'train for + noun', 'training + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'train' AND cefr_receptive = 'A1';

-- travel
UPDATE lexicon_entries SET
  ipa = '/ˈtrævəl/',
  definition_simple = 'to go from one place to another',
  definition_teacher = 'Verb or noun meaning to journey or journeys. Common in business for business travel, travel expenses.',
  usage_notes = 'Very common in business. Can be verb (travel to meetings) or noun (business travel).',
  examples = jsonb_build_array(
    'Employees travel frequently for client meetings.',
    'Business travel expenses are reimbursed.',
    'The job requires 50% travel.',
    'We use a corporate travel agency.'
  ),
  collocations = jsonb_build_array('business travel', 'travel expenses', 'travel for work', 'travel policy'),
  patterns = jsonb_build_array('travel to + place', 'travel for + purpose', 'business travel'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'travel' AND cefr_receptive = 'A1';

-- tree
UPDATE lexicon_entries SET
  ipa = '/triː/',
  definition_simple = 'a tall plant with a wooden trunk and branches',
  definition_teacher = 'Noun meaning woody plant. In business, used for decision trees, family trees, or organizational trees.',
  usage_notes = 'Can be literal (plant) or figurative (decision tree, organizational tree).',
  examples = jsonb_build_array(
    'Use a decision tree to analyze options.',
    'The organizational tree shows reporting structure.',
    'We can''t see the forest for the trees.',
    'The family tree shows company ownership.'
  ),
  collocations = jsonb_build_array('decision tree', 'organizational tree', 'family tree', 'tree structure'),
  patterns = jsonb_build_array('decision tree', 'noun + tree', 'tree structure'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'tree' AND cefr_receptive = 'A1';

-- trouble
UPDATE lexicon_entries SET
  ipa = '/ˈtrʌbəl/',
  definition_simple = 'problems or difficulty',
  definition_teacher = 'Noun or verb meaning problems or to cause problems. Common in business for troubleshooting or being in trouble.',
  usage_notes = 'Very common in business. Can be noun (in trouble) or verb (trouble someone).',
  examples = jsonb_build_array(
    'The company is in financial trouble.',
    'We need to troubleshoot the system issues.',
    'Sorry to trouble you with this question.',
    'The trouble is we lack resources.'
  ),
  collocations = jsonb_build_array('in trouble', 'troubleshoot', 'trouble with', 'the trouble is'),
  patterns = jsonb_build_array('in trouble', 'troubleshoot + noun', 'trouble with + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'trouble' AND cefr_receptive = 'A1';

-- trust
UPDATE lexicon_entries SET
  ipa = '/trʌst/',
  definition_simple = 'to believe someone is honest and reliable',
  definition_teacher = 'Verb or noun meaning to have confidence or confidence itself. Essential in business for trust, trustworthiness.',
  usage_notes = 'Very important in business. Can be verb (trust someone) or noun (build trust).',
  examples = jsonb_build_array(
    'We trust our employees to work independently.',
    'Building trust with clients takes time.',
    'Trust is essential for teamwork.',
    'I trust your judgment on this matter.'
  ),
  collocations = jsonb_build_array('build trust', 'trust someone', 'breach of trust', 'trust in'),
  patterns = jsonb_build_array('trust + person', 'build trust', 'trust in + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'trust' AND cefr_receptive = 'A1';

-- truth
UPDATE lexicon_entries SET
  ipa = '/truːθ/',
  definition_simple = 'facts or what is really true',
  definition_teacher = 'Noun meaning reality or facts. Common in business for truth in advertising or telling the truth.',
  usage_notes = 'Uncountable noun. Important in business ethics and communication.',
  examples = jsonb_build_array(
    'The truth is we need to cut costs.',
    'Tell the truth in all business dealings.',
    'There''s some truth to that criticism.',
    'The data reveals the truth about performance.'
  ),
  collocations = jsonb_build_array('tell the truth', 'the truth is', 'truth about', 'moment of truth'),
  patterns = jsonb_build_array('tell the truth', 'the truth is + clause', 'truth about + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'truth' AND cefr_receptive = 'A1';

-- try
UPDATE lexicon_entries SET
  ipa = '/traɪ/',
  definition_simple = 'to attempt to do something',
  definition_teacher = 'Verb or noun meaning to attempt or an attempt. Essential in business for trying new approaches or making attempts.',
  usage_notes = 'Very common in business. Can be followed by "to" + infinitive or gerund (different meanings).',
  examples = jsonb_build_array(
    'Let''s try a different approach.',
    'We tried to contact you yesterday.',
    'It''s worth a try.',
    'Try implementing these suggestions.'
  ),
  collocations = jsonb_build_array('try to', 'worth a try', 'try out', 'give it a try'),
  patterns = jsonb_build_array('try + to infinitive', 'try + gerund', 'worth a try', 'give it a try'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'try' AND cefr_receptive = 'A1';

-- turn
UPDATE lexicon_entries SET
  ipa = '/tɜːrn/',
  definition_simple = 'to move around or change direction',
  definition_teacher = 'Verb or noun meaning to rotate, change, or opportunity. Very common in business for turnaround, turning point, or taking turns.',
  usage_notes = 'Very versatile word. Many meanings and phrasal verbs in business contexts.',
  examples = jsonb_build_array(
    'The company turned a profit this year.',
    'Let''s turn our attention to the next item.',
    'This could be a turning point for the business.',
    'We need to turn things around quickly.'
  ),
  collocations = jsonb_build_array('turn a profit', 'turning point', 'turn around', 'turn attention to'),
  patterns = jsonb_build_array('turn + noun', 'turn around + noun', 'turning point'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'turn' AND cefr_receptive = 'A1';

-- type
UPDATE lexicon_entries SET
  ipa = '/taɪp/',
  definition_simple = 'a kind or category, or to write using a keyboard',
  definition_teacher = 'Noun or verb meaning category or to keyboard. Essential in business for types of products, typing documents.',
  usage_notes = 'Very common in business. Can be noun (type of product) or verb (type a document).',
  examples = jsonb_build_array(
    'What type of solution are you looking for?',
    'Please type your response in the form.',
    'We offer several types of services.',
    'This type of problem requires expert help.'
  ),
  collocations = jsonb_build_array('type of', 'this type', 'different types', 'type in'),
  patterns = jsonb_build_array('type of + noun', 'this/that type', 'type + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'type' AND cefr_receptive = 'A1';

-- union
UPDATE lexicon_entries SET
  ipa = '/ˈjuːniən/',
  definition_simple = 'joining together, or a workers'' organization',
  definition_teacher = 'Noun meaning joining or labor organization. In business, refers to labor unions or union of entities.',
  usage_notes = 'Can mean joining together or labor union. Important in labor relations and mergers.',
  examples = jsonb_build_array(
    'The labor union negotiates with management.',
    'Union membership has declined.',
    'The merger creates a union of two companies.',
    'Union representatives attend the meeting.'
  ),
  collocations = jsonb_build_array('labor union', 'trade union', 'union member', 'union representative'),
  patterns = jsonb_build_array('labor/trade union', 'union of + noun', 'union + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'union' AND cefr_receptive = 'A1';

-- unite
UPDATE lexicon_entries SET
  ipa = '/juːˈnaɪt/',
  definition_simple = 'to join together or combine',
  definition_teacher = 'Verb meaning to join or combine. Common in business for uniting teams, efforts, or organizations.',
  usage_notes = 'Formal verb. Related: united, unity, union. Common in business contexts.',
  examples = jsonb_build_array(
    'We need to unite our efforts to succeed.',
    'The crisis united the team.',
    'Let''s unite behind this common goal.',
    'The merger will unite two industry leaders.'
  ),
  collocations = jsonb_build_array('unite efforts', 'unite behind', 'unite teams', 'united front'),
  patterns = jsonb_build_array('unite + noun', 'unite behind + noun', 'unite to + infinitive'),
  register = 'formal',
  variety = 'international'
WHERE headword = 'unite' AND cefr_receptive = 'A1';

-- university
UPDATE lexicon_entries SET
  ipa = '/ˌjuːnɪˈvɜːrsəti/',
  definition_simple = 'an institution of higher education',
  definition_teacher = 'Noun meaning higher education institution. In business, relevant for recruitment, research partnerships, or education.',
  usage_notes = 'Countable noun. Important in business for university partnerships and graduate recruitment.',
  examples = jsonb_build_array(
    'We recruit graduates from top universities.',
    'The company partners with universities for research.',
    'She has a university degree in business.',
    'University education is valued in our industry.'
  ),
  collocations = jsonb_build_array('university degree', 'top university', 'university graduate', 'university partnership'),
  patterns = jsonb_build_array('university + noun', 'at/from university', 'university graduate'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'university' AND cefr_receptive = 'A1';

-- upon
UPDATE lexicon_entries SET
  ipa = '/əˈpɒn/',
  definition_simple = 'on or on top of (formal)',
  definition_teacher = 'Preposition meaning on. More formal than "on". Common in business phrases and formal writing.',
  usage_notes = 'Formal alternative to "on". Common in business phrases like "upon request" or "depend upon".',
  examples = jsonb_build_array(
    'The decision depends upon market conditions.',
    'Documents are available upon request.',
    'Upon reflection, we should reconsider.',
    'We agreed upon the terms yesterday.'
  ),
  collocations = jsonb_build_array('upon request', 'depend upon', 'upon reflection', 'agree upon'),
  patterns = jsonb_build_array('upon + noun', 'depend upon + noun', 'upon request'),
  register = 'formal',
  variety = 'international'
WHERE headword = 'upon' AND cefr_receptive = 'A1';

-- usual
UPDATE lexicon_entries SET
  ipa = '/ˈjuːʒuəl/',
  definition_simple = 'normal or happening most of the time',
  definition_teacher = 'Adjective meaning normal or customary. Common in business for usual practice, as usual, or business as usual.',
  usage_notes = 'Very common in business. Related: usually (adverb). Used to describe normal patterns.',
  examples = jsonb_build_array(
    'We follow the usual procedures.',
    'Business as usual despite the changes.',
    'The usual meeting time is 10 AM.',
    'As usual, quality is our priority.'
  ),
  collocations = jsonb_build_array('as usual', 'business as usual', 'usual practice', 'the usual'),
  patterns = jsonb_build_array('as usual', 'the usual + noun', 'business as usual'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'usual' AND cefr_receptive = 'A1';

-- valley
UPDATE lexicon_entries SET
  ipa = '/ˈvæli/',
  definition_simple = 'low land between hills or mountains',
  definition_teacher = 'Noun meaning low area between elevations. In business, used for Silicon Valley or valley in graphs.',
  usage_notes = 'Can be literal (geographic valley) or figurative (valley in performance graph).',
  examples = jsonb_build_array(
    'Silicon Valley is the tech industry hub.',
    'The company is in a valley between growth periods.',
    'Sales show peaks and valleys throughout the year.',
    'We need to navigate through this valley.'
  ),
  collocations = jsonb_build_array('Silicon Valley', 'peaks and valleys', 'valley period', 'through the valley'),
  patterns = jsonb_build_array('Silicon Valley', 'peaks and valleys', 'in a valley'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'valley' AND cefr_receptive = 'A1';

-- value
UPDATE lexicon_entries SET
  ipa = '/ˈvæljuː/',
  definition_simple = 'the worth or importance of something',
  definition_teacher = 'Noun or verb meaning worth or to appreciate. Essential in business for value proposition, values, or valuation.',
  usage_notes = 'Very common in business. Can be noun (the value) or verb (to value something).',
  examples = jsonb_build_array(
    'We provide excellent value for money.',
    'Company values guide our decisions.',
    'The property is valued at $2 million.',
    'What''s the value proposition for customers?'
  ),
  collocations = jsonb_build_array('value for money', 'company values', 'value proposition', 'add value'),
  patterns = jsonb_build_array('value for money', 'value + noun', 'add value to + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'value' AND cefr_receptive = 'A1';

-- various
UPDATE lexicon_entries SET
  ipa = '/ˈveəriəs/',
  definition_simple = 'several different',
  definition_teacher = 'Adjective meaning several or diverse. Very common in business for indicating multiple different items.',
  usage_notes = 'Very common in business. Always used with plural nouns. Emphasizes diversity.',
  examples = jsonb_build_array(
    'We offer various payment options.',
    'The team has various skills and backgrounds.',
    'Various factors contributed to the success.',
    'We serve various industries worldwide.'
  ),
  collocations = jsonb_build_array('various options', 'various factors', 'various ways', 'various industries'),
  patterns = jsonb_build_array('various + plural noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'various' AND cefr_receptive = 'A1';

-- view
UPDATE lexicon_entries SET
  ipa = '/vjuː/',
  definition_simple = 'what you can see, or an opinion',
  definition_teacher = 'Noun or verb meaning sight, opinion, or to look at. Essential in business for views, viewpoints, or reviewing.',
  usage_notes = 'Very common in business. Can mean sight, opinion, or to look at/consider.',
  examples = jsonb_build_array(
    'In my view, this is the best approach.',
    'Let''s view the presentation together.',
    'We need to consider different points of view.',
    'The office has a great view.'
  ),
  collocations = jsonb_build_array('in my view', 'point of view', 'with a view to', 'overview'),
  patterns = jsonb_build_array('in + possessive + view', 'point of view', 'view + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'view' AND cefr_receptive = 'A1';

-- village
UPDATE lexicon_entries SET
  ipa = '/ˈvɪlɪdʒ/',
  definition_simple = 'a small community in the countryside',
  definition_teacher = 'Noun meaning small rural community. In business, used for global village or village mentality.',
  usage_notes = 'Countable noun. Can be literal (rural village) or figurative (global village).',
  examples = jsonb_build_array(
    'We operate in the global village of business.',
    'The factory employs people from nearby villages.',
    'It takes a village to build a successful company.',
    'Rural villages represent untapped markets.'
  ),
  collocations = jsonb_build_array('global village', 'it takes a village', 'rural village', 'village community'),
  patterns = jsonb_build_array('global village', 'it takes a village', 'in a village'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'village' AND cefr_receptive = 'A1';

-- visit
UPDATE lexicon_entries SET
  ipa = '/ˈvɪzɪt/',
  definition_simple = 'to go to see a person or place',
  definition_teacher = 'Verb or noun meaning to go see or a trip. Common in business for client visits, site visits, or visiting offices.',
  usage_notes = 'Very common in business. Can be verb (visit clients) or noun (a visit).',
  examples = jsonb_build_array(
    'We visit clients regularly to maintain relationships.',
    'The CEO''s visit boosted team morale.',
    'Please visit our website for more information.',
    'Site visits help assess operations.'
  ),
  collocations = jsonb_build_array('visit clients', 'site visit', 'visit website', 'pay a visit'),
  patterns = jsonb_build_array('visit + person/place', 'pay a visit to + place', 'site visit'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'visit' AND cefr_receptive = 'A1';

-- voice
UPDATE lexicon_entries SET
  ipa = '/vɔɪs/',
  definition_simple = 'the sound you make when speaking',
  definition_teacher = 'Noun or verb meaning sound of speech or to express. In business, used for voice of customer or voicing opinions.',
  usage_notes = 'Can be literal (speaking voice) or figurative (voice of customer, have a voice).',
  examples = jsonb_build_array(
    'We listen to the voice of the customer.',
    'Employees should have a voice in decisions.',
    'Please voice your concerns openly.',
    'The brand needs a consistent voice.'
  ),
  collocations = jsonb_build_array('voice of customer', 'have a voice', 'voice concerns', 'brand voice'),
  patterns = jsonb_build_array('voice of + noun', 'have a voice in + noun', 'voice + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'voice' AND cefr_receptive = 'A1';

-- vote
UPDATE lexicon_entries SET
  ipa = '/vəʊt/',
  definition_simple = 'to make a choice in an election, or the choice made',
  definition_teacher = 'Verb or noun meaning to choose or a choice. Common in business for voting on decisions or shareholder votes.',
  usage_notes = 'Very common in business governance. Can be verb (vote on) or noun (a vote).',
  examples = jsonb_build_array(
    'The board will vote on the proposal tomorrow.',
    'Shareholders vote at the annual meeting.',
    'The vote was unanimous in favor.',
    'Let''s take a vote on this decision.'
  ),
  collocations = jsonb_build_array('vote on', 'take a vote', 'cast a vote', 'shareholder vote'),
  patterns = jsonb_build_array('vote on + noun', 'take/cast a vote', 'vote for/against + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'vote' AND cefr_receptive = 'A1';

-- wall
UPDATE lexicon_entries SET
  ipa = '/wɔːl/',
  definition_simple = 'a vertical structure that divides or surrounds',
  definition_teacher = 'Noun meaning barrier or partition. In business, used for walls between departments or hitting a wall.',
  usage_notes = 'Can be literal (physical wall) or figurative (wall between departments, hit a wall).',
  examples = jsonb_build_array(
    'We need to break down walls between departments.',
    'The project hit a wall due to funding issues.',
    'Open offices have fewer walls.',
    'Don''t put up walls to collaboration.'
  ),
  collocations = jsonb_build_array('break down walls', 'hit a wall', 'wall between', 'put up walls'),
  patterns = jsonb_build_array('break down walls', 'hit a wall', 'wall between + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'wall' AND cefr_receptive = 'A1';

-- war
UPDATE lexicon_entries SET
  ipa = '/wɔːr/',
  definition_simple = 'armed conflict between countries or groups',
  definition_teacher = 'Noun meaning conflict or competition. In business, used for price wars, trade wars, or war for talent.',
  usage_notes = 'Can be literal (military war) or figurative (price war, war for talent).',
  examples = jsonb_build_array(
    'The price war hurt profit margins.',
    'We''re in a war for top talent.',
    'Trade wars affect international business.',
    'The marketing war with competitors intensifies.'
  ),
  collocations = jsonb_build_array('price war', 'trade war', 'war for talent', 'war room'),
  patterns = jsonb_build_array('price/trade war', 'war for + noun', 'war room'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'war' AND cefr_receptive = 'A1';

-- warn
UPDATE lexicon_entries SET
  ipa = '/wɔːrn/',
  definition_simple = 'to tell someone about possible danger or problems',
  definition_teacher = 'Verb meaning to alert or caution. Common in business for warnings, risk warnings, or cautioning stakeholders.',
  usage_notes = 'Can be followed by "about", "of", or "that". Related: warning (noun).',
  examples = jsonb_build_array(
    'We warned investors about the risks.',
    'The report warns of potential challenges.',
    'I must warn you that costs may increase.',
    'Early warning systems prevent problems.'
  ),
  collocations = jsonb_build_array('warn about', 'warn of', 'early warning', 'warning sign'),
  patterns = jsonb_build_array('warn + person + about/of + noun', 'warn that + clause', 'early warning'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'warn' AND cefr_receptive = 'A1';

-- wash
UPDATE lexicon_entries SET
  ipa = '/wɒʃ/',
  definition_simple = 'to clean with water',
  definition_teacher = 'Verb or noun meaning to clean. In business, used in phrases like "wash out" or "money laundering" (illegal).',
  usage_notes = 'Can be literal (wash hands) or figurative (wash out = fail, whitewash = cover up).',
  examples = jsonb_build_array(
    'The investment washed out completely.',
    'Don''t try to whitewash the problems.',
    'The deal was a wash - no gain or loss.',
    'The scandal won''t just wash away.'
  ),
  collocations = jsonb_build_array('wash out', 'whitewash', 'come out in the wash', 'wash away'),
  patterns = jsonb_build_array('wash out', 'whitewash + noun', 'come out in the wash'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'wash' AND cefr_receptive = 'A1';

-- waste
UPDATE lexicon_entries SET
  ipa = '/weɪst/',
  definition_simple = 'to use something carelessly or inefficiently',
  definition_teacher = 'Verb or noun meaning to squander or unwanted material. Essential in business for waste reduction and efficiency.',
  usage_notes = 'Very common in business. Can be verb (waste time) or noun (waste material).',
  examples = jsonb_build_array(
    'Don''t waste time on unimportant tasks.',
    'We need to reduce waste in production.',
    'Wasting resources hurts profitability.',
    'The meeting was a waste of time.'
  ),
  collocations = jsonb_build_array('waste time', 'waste resources', 'reduce waste', 'waste of time'),
  patterns = jsonb_build_array('waste + noun', 'a waste of + noun', 'reduce waste'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'waste' AND cefr_receptive = 'A1';

-- watch
UPDATE lexicon_entries SET
  ipa = '/wɒtʃ/',
  definition_simple = 'to look at something carefully, or a timepiece',
  definition_teacher = 'Verb or noun meaning to observe or timepiece. In business, used for watching trends, watch out, or being on watch.',
  usage_notes = 'Very common in business. Can be verb (watch trends) or noun (a watch, on watch).',
  examples = jsonb_build_array(
    'We watch market trends closely.',
    'Watch out for potential risks.',
    'Keep watch on competitor activities.',
    'The team is watching costs carefully.'
  ),
  collocations = jsonb_build_array('watch out', 'keep watch', 'watch trends', 'watch closely'),
  patterns = jsonb_build_array('watch + noun', 'watch out for + noun', 'keep watch on + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'watch' AND cefr_receptive = 'A1';

-- wave
UPDATE lexicon_entries SET
  ipa = '/weɪv/',
  definition_simple = 'a moving ridge of water, or to move your hand',
  definition_teacher = 'Noun or verb meaning water movement, trend, or hand gesture. In business, used for waves of change or riding waves.',
  usage_notes = 'Can be literal (ocean wave) or figurative (wave of change, new wave).',
  examples = jsonb_build_array(
    'We''re riding the wave of digital transformation.',
    'A new wave of innovation is coming.',
    'The company caught the wave early.',
    'Waves of change affect all industries.'
  ),
  collocations = jsonb_build_array('wave of change', 'ride the wave', 'new wave', 'catch the wave'),
  patterns = jsonb_build_array('wave of + noun', 'ride the wave', 'catch the wave'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'wave' AND cefr_receptive = 'A1';

-- weak
UPDATE lexicon_entries SET
  ipa = '/wiːk/',
  definition_simple = 'not strong or powerful',
  definition_teacher = 'Adjective meaning lacking strength or force. Common in business for weak performance, weak market, or weaknesses.',
  usage_notes = 'Opposite of "strong". Very common in business contexts. Related: weakness (noun).',
  examples = jsonb_build_array(
    'The weak economy affects consumer spending.',
    'Sales were weak this quarter.',
    'We need to address our weak points.',
    'The weak dollar benefits exporters.'
  ),
  collocations = jsonb_build_array('weak performance', 'weak market', 'weak point', 'weak economy'),
  patterns = jsonb_build_array('weak + noun', 'weak in + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'weak' AND cefr_receptive = 'A1';

-- wear
UPDATE lexicon_entries SET
  ipa = '/weər/',
  definition_simple = 'to have clothes or accessories on your body',
  definition_teacher = 'Verb or noun meaning to have on or deterioration. In business, used for wear and tear or wearing multiple hats.',
  usage_notes = 'Irregular: wear, wore, worn. Can mean "have on" or "deteriorate" (wear out).',
  examples = jsonb_build_array(
    'Employees wear business casual attire.',
    'The equipment shows normal wear and tear.',
    'She wears many hats in the organization.',
    'The constant pressure wears people down.'
  ),
  collocations = jsonb_build_array('wear and tear', 'wear many hats', 'wear out', 'wear down'),
  patterns = jsonb_build_array('wear + clothing', 'wear and tear', 'wear many hats'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'wear' AND cefr_receptive = 'A1';

-- weather
UPDATE lexicon_entries SET
  ipa = '/ˈweðər/',
  definition_simple = 'the conditions outside (rain, sun, wind, etc.)',
  definition_teacher = 'Noun or verb meaning atmospheric conditions or to endure. In business, used for weathering storms or weather conditions.',
  usage_notes = 'Can be noun (the weather) or verb (weather the storm = endure difficulties).',
  examples = jsonb_build_array(
    'The company weathered the economic storm.',
    'Weather conditions affect shipping schedules.',
    'We need to weather this difficult period.',
    'Bad weather disrupted operations.'
  ),
  collocations = jsonb_build_array('weather the storm', 'weather conditions', 'bad weather', 'weather forecast'),
  patterns = jsonb_build_array('weather the storm', 'weather + noun', 'weather conditions'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'weather' AND cefr_receptive = 'A1';

-- west
UPDATE lexicon_entries SET
  ipa = '/west/',
  definition_simple = 'the direction where the sun sets',
  definition_teacher = 'Noun, adjective, or adverb meaning western direction. In business, used for geographic regions and markets.',
  usage_notes = 'Can be noun (the west), adjective (west coast), or adverb (go west).',
  examples = jsonb_build_array(
    'We''re expanding into the western market.',
    'The west coast office handles Pacific clients.',
    'Western Europe is a key market.',
    'Our western operations are growing.'
  ),
  collocations = jsonb_build_array('west coast', 'western market', 'Western Europe', 'western operations'),
  patterns = jsonb_build_array('west + noun', 'western + noun', 'in the west'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'west' AND cefr_receptive = 'A1';

-- wide
UPDATE lexicon_entries SET
  ipa = '/waɪd/',
  definition_simple = 'measuring a large distance from side to side',
  definition_teacher = 'Adjective meaning broad or extensive. Common in business for wide range, wide variety, or worldwide.',
  usage_notes = 'Can mean physically broad or extensive in scope. Related: widely (adverb), width (noun).',
  examples = jsonb_build_array(
    'We offer a wide range of products.',
    'The company has a wide customer base.',
    'There''s a wide gap between expectations and reality.',
    'The impact is wide-reaching.'
  ),
  collocations = jsonb_build_array('wide range', 'wide variety', 'wide gap', 'wide-reaching'),
  patterns = jsonb_build_array('wide + noun', 'wide range of + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'wide' AND cefr_receptive = 'A1';

-- wife
UPDATE lexicon_entries SET
  ipa = '/waɪf/',
  definition_simple = 'a married woman',
  definition_teacher = 'Noun meaning married female partner. In business, relevant for family businesses or work-life balance discussions.',
  usage_notes = 'Countable noun. Plural: wives. Relevant in business contexts involving family or personal life.',
  examples = jsonb_build_array(
    'Work-life balance allows time with wife and family.',
    'The founder''s wife co-manages the business.',
    'Many executives bring their wives to company events.',
    'Family businesses often involve husbands and wives.'
  ),
  collocations = jsonb_build_array('husband and wife', 'wife and family', 'work-life balance'),
  patterns = jsonb_build_array('husband and wife', 'possessive + wife'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'wife' AND cefr_receptive = 'A1';

-- wild
UPDATE lexicon_entries SET
  ipa = '/waɪld/',
  definition_simple = 'living in nature, not controlled',
  definition_teacher = 'Adjective meaning untamed or extreme. In business, used for wild ideas, wild swings, or wild card.',
  usage_notes = 'Can be literal (wild animals) or figurative (wild idea, wild market swings).',
  examples = jsonb_build_array(
    'The market experienced wild swings.',
    'That''s a wild idea, but it might work.',
    'Wild speculation drove prices up.',
    'He''s the wild card in negotiations.'
  ),
  collocations = jsonb_build_array('wild swings', 'wild idea', 'wild card', 'wild speculation'),
  patterns = jsonb_build_array('wild + noun', 'wild card'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'wild' AND cefr_receptive = 'A1';

-- win
UPDATE lexicon_entries SET
  ipa = '/wɪn/',
  definition_simple = 'to be successful or victorious',
  definition_teacher = 'Verb or noun meaning to succeed or victory. Essential in business for winning contracts, win-win situations.',
  usage_notes = 'Irregular: win, won, won. Very common in business contexts. Can be verb or noun.',
  examples = jsonb_build_array(
    'We won the contract after tough negotiations.',
    'This is a win-win situation for both parties.',
    'The team won industry recognition.',
    'Winning customer trust takes time.'
  ),
  collocations = jsonb_build_array('win-win', 'win a contract', 'win trust', 'win recognition'),
  patterns = jsonb_build_array('win + noun', 'win-win situation', 'win over + person'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'win' AND cefr_receptive = 'A1';

-- wind
UPDATE lexicon_entries SET
  ipa = '/wɪnd/',
  definition_simple = 'moving air, or to turn or twist',
  definition_teacher = 'Noun or verb with two meanings. In business, used for wind down, wind up, or getting wind of something.',
  usage_notes = 'Two words: /wɪnd/ (air) and /waɪnd/ (turn). Different pronunciations and meanings.',
  examples = jsonb_build_array(
    'We need to wind down operations gradually.',
    'The company is winding up its affairs.',
    'I got wind of the merger plans.',
    'Wind power is a growing industry.'
  ),
  collocations = jsonb_build_array('wind down', 'wind up', 'get wind of', 'wind power'),
  patterns = jsonb_build_array('wind down + noun', 'wind up + noun', 'get wind of + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'wind' AND cefr_receptive = 'A1';

-- wing
UPDATE lexicon_entries SET
  ipa = '/wɪŋ/',
  definition_simple = 'the part of a bird or plane that enables flight',
  definition_teacher = 'Noun meaning flight appendage or section. In business, used for wings of organization or taking under wing.',
  usage_notes = 'Can be literal (bird wing) or figurative (wing of building, take under wing).',
  examples = jsonb_build_array(
    'The new wing of the office opens next month.',
    'She took the intern under her wing.',
    'The marketing wing handles all campaigns.',
    'We''re winging it without a detailed plan.'
  ),
  collocations = jsonb_build_array('take under wing', 'wing it', 'left/right wing', 'wing of building'),
  patterns = jsonb_build_array('take + person + under wing', 'wing it', 'wing of + noun'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'wing' AND cefr_receptive = 'A1';

-- winter
UPDATE lexicon_entries SET
  ipa = '/ˈwɪntər/',
  definition_simple = 'the coldest season of the year',
  definition_teacher = 'Noun meaning cold season. In business, relevant for seasonal patterns, winter sales, or economic winters.',
  usage_notes = 'Countable or uncountable. Important for seasonal business planning.',
  examples = jsonb_build_array(
    'Winter is our busiest retail season.',
    'The company survived the economic winter.',
    'Winter sales traditionally peak in December.',
    'We prepare for winter demand increases.'
  ),
  collocations = jsonb_build_array('winter season', 'winter sales', 'economic winter', 'this winter'),
  patterns = jsonb_build_array('in/during winter', 'winter + noun', 'this/next/last winter'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'winter' AND cefr_receptive = 'A1';

-- wise
UPDATE lexicon_entries SET
  ipa = '/waɪz/',
  definition_simple = 'having good judgment and experience',
  definition_teacher = 'Adjective meaning intelligent or prudent. In business, used for wise decisions, wise investment, or otherwise suffix.',
  usage_notes = 'Can mean "intelligent" or used as suffix (-wise = regarding). Related: wisdom, wisely.',
  examples = jsonb_build_array(
    'That was a wise investment decision.',
    'It would be wise to diversify.',
    'Cost-wise, this option is better.',
    'The wise choice is to wait.'
  ),
  collocations = jsonb_build_array('wise decision', 'wise investment', 'wise choice', 'cost-wise'),
  patterns = jsonb_build_array('wise + noun', 'it would be wise to + infinitive', 'noun-wise'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'wise' AND cefr_receptive = 'A1';

-- wish
UPDATE lexicon_entries SET
  ipa = '/wɪʃ/',
  definition_simple = 'to want something to happen or be true',
  definition_teacher = 'Verb or noun meaning to desire or a desire. Common in business for expressing hopes or polite requests.',
  usage_notes = 'Can be verb (wish for) or noun (a wish). Often used for polite expressions.',
  examples = jsonb_build_array(
    'We wish you success in your new role.',
    'I wish we had more time for planning.',
    'If you wish, we can reschedule the meeting.',
    'Best wishes for the project launch.'
  ),
  collocations = jsonb_build_array('wish for', 'best wishes', 'if you wish', 'wish list'),
  patterns = jsonb_build_array('wish + person + noun', 'wish for + noun', 'if you wish'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'wish' AND cefr_receptive = 'A1';

-- wonder
UPDATE lexicon_entries SET
  ipa = '/ˈwʌndər/',
  definition_simple = 'to think about something with curiosity',
  definition_teacher = 'Verb or noun meaning to question or amazement. Common in business for wondering about outcomes or expressing curiosity.',
  usage_notes = 'Can be verb (wonder about) or noun (a wonder). Often used to express polite questions.',
  examples = jsonb_build_array(
    'I wonder if we should reconsider the approach.',
    'We''re wondering about the timeline.',
    'It''s no wonder sales increased.',
    'The turnaround was a wonder to behold.'
  ),
  collocations = jsonb_build_array('wonder if', 'wonder about', 'no wonder', 'wonder whether'),
  patterns = jsonb_build_array('wonder if/whether + clause', 'wonder about + noun', 'no wonder + clause'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'wonder' AND cefr_receptive = 'A1';

-- wood
UPDATE lexicon_entries SET
  ipa = '/wʊd/',
  definition_simple = 'the hard material from trees',
  definition_teacher = 'Noun meaning timber or forest. In business, used for wood industry or idiom "out of the woods".',
  usage_notes = 'Can be uncountable (wood material) or plural (woods = forest). Common in business idioms.',
  examples = jsonb_build_array(
    'We''re not out of the woods yet financially.',
    'The furniture is made from sustainable wood.',
    'The wood industry faces environmental challenges.',
    'Touch wood, the project will succeed.'
  ),
  collocations = jsonb_build_array('out of the woods', 'wood industry', 'touch wood', 'wood products'),
  patterns = jsonb_build_array('out of the woods', 'wood + noun', 'made of wood'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'wood' AND cefr_receptive = 'A1';

-- world
UPDATE lexicon_entries SET
  ipa = '/wɜːrld/',
  definition_simple = 'the earth and all people and things on it',
  definition_teacher = 'Noun meaning earth, sphere, or domain. Essential in business for world market, world-class, or business world.',
  usage_notes = 'Very common in business. Can mean earth, sphere of activity, or domain.',
  examples = jsonb_build_array(
    'We operate in the global business world.',
    'The company is a world leader in technology.',
    'World-class service is our standard.',
    'The world of finance is complex.'
  ),
  collocations = jsonb_build_array('business world', 'world-class', 'world leader', 'around the world'),
  patterns = jsonb_build_array('world of + noun', 'world-class + noun', 'around the world'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'world' AND cefr_receptive = 'A1';

-- worse
UPDATE lexicon_entries SET
  ipa = '/wɜːrs/',
  definition_simple = 'more bad or of lower quality',
  definition_teacher = 'Adjective or adverb meaning more bad. Comparative form of "bad". Common in business for worse performance or making worse.',
  usage_notes = 'Comparative of "bad". Very common in business for comparisons. Related: worst (superlative).',
  examples = jsonb_build_array(
    'The situation is worse than we thought.',
    'Performance was worse this quarter.',
    'Things could be worse - we''re still profitable.',
    'Don''t make matters worse by rushing.'
  ),
  collocations = jsonb_build_array('worse than', 'make worse', 'for better or worse', 'could be worse'),
  patterns = jsonb_build_array('worse than + noun', 'make + noun + worse', 'could be worse'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'worse' AND cefr_receptive = 'A1';

-- worth
UPDATE lexicon_entries SET
  ipa = '/wɜːrθ/',
  definition_simple = 'having a particular value or deserving',
  definition_teacher = 'Adjective or noun meaning value or deserving. Essential in business for worth, worthwhile, or net worth.',
  usage_notes = 'Very common in business. Can be adjective (worth doing) or noun (net worth).',
  examples = jsonb_build_array(
    'The investment is worth $10 million.',
    'It''s worth considering this option.',
    'The company''s net worth increased.',
    'Is it worth the effort and cost?'
  ),
  collocations = jsonb_build_array('worth doing', 'net worth', 'worth it', 'worth considering'),
  patterns = jsonb_build_array('worth + gerund', 'worth + amount', 'net worth', 'worth it'),
  register = 'neutral',
  variety = 'international'
WHERE headword = 'worth' AND cefr_receptive = 'A1';
