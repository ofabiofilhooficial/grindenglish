-- Migration: Enhance GSL Vocabulary - Batch 4 (A1 Work and Business Vocabulary)
-- Description: Add comprehensive linguistic data for first batch of A1 words
-- Words: Work-related nouns (business, company, office, job, work, meeting, project, plan, report, etc.)
--        Professional verbs (manage, organize, plan, present, discuss, develop, etc.)
--        Business concepts (account, address, advantage, amount, base, board, branch, etc.)
-- Target: ~150 A1 words focused on professional and business English
-- Focus: Brazilian professionals learning workplace communication

-- ============================================================================
-- CORE BUSINESS NOUNS (20 words)
-- ============================================================================

-- Noun: business
UPDATE lexicon_entries
SET
  ipa = 'ˈbɪznəs',
  definition_simple = 'the activity of buying and selling goods or services, or a company that does this',
  definition_teacher = 'noun: uncountable (commerce/trade) or countable (company); refers to commercial activity, trade, or a commercial enterprise; neutral register; fundamental term in professional contexts',
  usage_notes = 'Essential business term. Uncountable when referring to commerce ("Business is good"), countable for companies ("a small business"). Common phrases: "do business with", "on business" (for work purposes), "business meeting", "business plan". Brazilian learners should note the difference between "business" (commerce/company) and "busy" (occupied).',
  register = 'neutral',
  variety = 'international',
  examples = '["We do business with companies in Europe.", "She owns a small business.", "I am traveling on business next week.", "The business meeting starts at 9 AM."]'::jsonb,
  collocations = '["do business", "on business", "business meeting", "business plan", "small business", "business trip"]'::jsonb,
  patterns = '["do + business + with", "on business", "business + noun (compound)"]'::jsonb,
  updated_at = now()
WHERE headword = 'business';

-- Noun: company
UPDATE lexicon_entries
SET
  ipa = 'ˈkʌmpəni',
  definition_simple = 'a business organization that makes or sells goods or services',
  definition_teacher = 'noun: countable; refers to a commercial organization or corporation; can be treated as singular or plural in British English; neutral register; fundamental workplace term',
  usage_notes = 'Core business term. Can be singular ("the company is") or plural ("the company are" - British English). Common phrases: "work for a company", "company policy", "parent company", "company culture". Also means "companionship" in different contexts. Very common in professional communication.',
  register = 'neutral',
  variety = 'international',
  examples = '["I work for a technology company.", "Our company has 500 employees.", "The company policy requires approval.", "She started her own company last year."]'::jsonb,
  collocations = '["work for a company", "company policy", "company culture", "parent company", "company name", "join a company"]'::jsonb,
  patterns = '["work + for + company", "company + noun (compound)", "the company + verb"]'::jsonb,
  updated_at = now()
WHERE headword = 'company';

-- Noun: office
UPDATE lexicon_entries
SET
  ipa = 'ˈɒfɪs',
  definition_simple = 'a room or building where people work at desks doing business',
  definition_teacher = 'noun: countable; refers to a workplace, room for administrative work, or position of authority; neutral register; can mean physical space or official position',
  usage_notes = 'Common workplace term. Physical location: "at the office", "office hours", "home office". Position: "hold office", "run for office". Very common in business: "office manager", "office space", "office building". Brazilian learners often use correctly but should note "at the office" (not "in the office" for workplace).',
  register = 'neutral',
  variety = 'international',
  examples = '["I work at the office three days a week.", "Our office hours are 9 AM to 5 PM.", "She has a home office.", "He is the office manager."]'::jsonb,
  collocations = '["at the office", "office hours", "home office", "office manager", "office space", "office building"]'::jsonb,
  patterns = '["at the office", "office + noun (compound)", "in the office"]'::jsonb,
  updated_at = now()
WHERE headword = 'office';

-- Noun: meeting
UPDATE lexicon_entries
SET
  ipa = 'ˈmiːtɪŋ',
  definition_simple = 'an event when people come together to talk about something',
  definition_teacher = 'noun: countable; refers to a formal or informal gathering for discussion, decision-making, or information sharing; neutral register; essential business term',
  usage_notes = 'Essential workplace term. Common phrases: "have a meeting", "attend a meeting", "meeting room", "meeting agenda", "in a meeting" (currently participating). Very frequent in business contexts. Note: "meeting" (noun) vs "meet" (verb). Brazilian learners should practice: "I have a meeting" (not "I have to meet").',
  register = 'neutral',
  variety = 'international',
  examples = '["We have a meeting at 2 PM.", "The meeting room is on the third floor.", "Please send the meeting agenda.", "She is in a meeting right now."]'::jsonb,
  collocations = '["have a meeting", "meeting room", "meeting agenda", "attend a meeting", "in a meeting", "meeting minutes"]'::jsonb,
  patterns = '["have a meeting", "meeting + noun (compound)", "in a meeting", "attend a meeting"]'::jsonb,
  updated_at = now()
WHERE headword = 'meeting';

-- Noun: project
UPDATE lexicon_entries
SET
  ipa = 'ˈprɒdʒekt',
  definition_simple = 'a planned piece of work that has a specific goal',
  definition_teacher = 'noun: countable; refers to a planned undertaking with defined objectives, timeline, and resources; neutral register; note different pronunciation as verb (prəˈdʒekt)',
  usage_notes = 'Essential business term. Common phrases: "work on a project", "project manager", "project deadline", "project team". Very common in professional contexts. Note: noun pronunciation /ˈprɒdʒekt/ vs verb /prəˈdʒekt/ (to estimate or display). Brazilian learners should practice the noun pronunciation.',
  register = 'neutral',
  variety = 'international',
  examples = '["I am working on a new project.", "She is the project manager.", "The project deadline is next month.", "Our project team has five members."]'::jsonb,
  collocations = '["work on a project", "project manager", "project deadline", "project team", "project plan", "complete a project"]'::jsonb,
  patterns = '["work + on + project", "project + noun (compound)", "complete a project"]'::jsonb,
  updated_at = now()
WHERE headword = 'project';

-- Noun: plan
UPDATE lexicon_entries
SET
  ipa = 'plæn',
  definition_simple = 'something you have decided to do, or a detailed proposal for achieving something',
  definition_teacher = 'noun: countable; refers to an intended course of action or detailed strategy; also verb meaning to make plans; neutral register; fundamental planning term',
  usage_notes = 'Common planning term. Noun: "make a plan", "business plan", "project plan", "according to plan". Verb: "plan to do", "plan ahead". Very common in business planning and strategy. Brazilian learners should note: "make a plan" (not "do a plan").',
  register = 'neutral',
  variety = 'international',
  examples = '["We need to make a plan for next quarter.", "The business plan is ready.", "Everything went according to plan.", "What are your plans for the project?"]'::jsonb,
  collocations = '["make a plan", "business plan", "project plan", "according to plan", "action plan", "strategic plan"]'::jsonb,
  patterns = '["make a plan", "plan + for", "plan + noun (compound)", "according to plan"]'::jsonb,
  updated_at = now()
WHERE headword = 'plan';

-- Noun: report
UPDATE lexicon_entries
SET
  ipa = 'rɪˈpɔːt',
  definition_simple = 'a written or spoken description of a situation or event',
  definition_teacher = 'noun: countable; refers to a formal account, document, or presentation of information; also verb meaning to give information or present findings; neutral register',
  usage_notes = 'Essential business document. Noun: "write a report", "annual report", "status report", "monthly report". Verb: "report to" (manager), "report on" (topic). Very common in professional communication. Brazilian learners should practice: "write a report" (not "make a report").',
  register = 'neutral',
  variety = 'international',
  examples = '["I need to write a report by Friday.", "The annual report is published in March.", "She gave a report on the project status.", "Please send me the monthly report."]'::jsonb,
  collocations = '["write a report", "annual report", "status report", "monthly report", "report on", "submit a report"]'::jsonb,
  patterns = '["write a report", "report + on", "report + noun (compound)", "submit a report"]'::jsonb,
  updated_at = now()
WHERE headword = 'report';

-- Noun: account
UPDATE lexicon_entries
SET
  ipa = 'əˈkaʊnt',
  definition_simple = 'a record of money received and spent, or a business arrangement with a bank or company',
  definition_teacher = 'noun: countable; refers to financial records, bank arrangements, client relationships, or explanations; also verb meaning to explain or consider; neutral register; multiple business meanings',
  usage_notes = 'Versatile business term. Financial: "bank account", "account balance". Client: "client account", "account manager". Explanation: "give an account of", "take into account". Very common in business and finance. Brazilian learners should note multiple meanings.',
  register = 'neutral',
  variety = 'international',
  examples = '["I need to open a bank account.", "She is the account manager for this client.", "Please take this into account.", "The account balance is positive."]'::jsonb,
  collocations = '["bank account", "account manager", "client account", "take into account", "account balance"]'::jsonb,
  patterns = '["bank account", "account + noun (compound)", "take into account"]'::jsonb,
  updated_at = now()
WHERE headword = 'account';

-- Noun: address
UPDATE lexicon_entries
SET
  ipa = 'əˈdres',
  definition_simple = 'the details of where someone lives or works, including building number and street name',
  definition_teacher = 'noun: countable; refers to location details, email/web location, or formal speech; also verb meaning to speak to or deal with; neutral register; note different pronunciation as verb',
  usage_notes = 'Common business term. Physical: "office address", "home address", "mailing address". Digital: "email address", "web address". Speech: "give an address" (formal speech). Verb: "address an issue", "address the audience". Brazilian learners should note: "email address" (not "email direction").',
  register = 'neutral',
  variety = 'international',
  examples = '["What is your office address?", "Please send it to my email address.", "We need to address this problem.", "The CEO will address the team tomorrow."]'::jsonb,
  collocations = '["email address", "office address", "home address", "mailing address", "address an issue", "web address"]'::jsonb,
  patterns = '["email address", "address + noun", "address + issue/problem"]'::jsonb,
  updated_at = now()
WHERE headword = 'address';

-- Noun: advantage
UPDATE lexicon_entries
SET
  ipa = 'ədˈvɑːntɪdʒ',
  definition_simple = 'something that helps you to be better or more successful than others',
  definition_teacher = 'noun: countable/uncountable; refers to a beneficial factor, competitive edge, or favorable position; neutral register; opposite of disadvantage',
  usage_notes = 'Common business term. Phrases: "competitive advantage", "take advantage of" (use opportunity), "have an advantage over". Used in strategy and analysis. Brazilian learners should note: "take advantage of" can be positive (use opportunity) or negative (exploit unfairly) depending on context.',
  register = 'neutral',
  variety = 'international',
  examples = '["Our company has a competitive advantage.", "We should take advantage of this opportunity.", "Experience is a big advantage.", "They have an advantage over their competitors."]'::jsonb,
  collocations = '["competitive advantage", "take advantage of", "have an advantage", "advantage over"]'::jsonb,
  patterns = '["competitive advantage", "take advantage + of", "advantage + over"]'::jsonb,
  updated_at = now()
WHERE headword = 'advantage';

-- Noun: amount
UPDATE lexicon_entries
SET
  ipa = 'əˈmaʊnt',
  definition_simple = 'a quantity of something, especially money',
  definition_teacher = 'noun: countable; refers to a quantity or sum, especially of money or uncountable nouns; also verb meaning to total; neutral register; used with uncountable nouns',
  usage_notes = 'Common business term for quantities. Used with uncountable nouns: "amount of money", "amount of time", "large amount". Note: use "number" with countable nouns, "amount" with uncountable. Verb: "amount to" (total). Brazilian learners often confuse "amount" and "number".',
  register = 'neutral',
  variety = 'international',
  examples = '["The amount of work is increasing.", "We need a large amount of money.", "The total amount is $5000.", "This amounts to 20% of our budget."]'::jsonb,
  collocations = '["amount of money", "amount of time", "large amount", "total amount", "amount to"]'::jsonb,
  patterns = '["amount + of + uncountable noun", "amount to"]'::jsonb,
  updated_at = now()
WHERE headword = 'amount';

-- Noun: base
UPDATE lexicon_entries
SET
  ipa = 'beɪs',
  definition_simple = 'the lowest part of something, or the main place where someone works',
  definition_teacher = 'noun: countable; refers to foundation, main location, or starting point; also verb meaning to locate or establish; also adjective meaning low quality; neutral register',
  usage_notes = 'Versatile business term. Location: "home base", "customer base", "database". Foundation: "base salary", "knowledge base". Verb: "based in" (located), "based on" (founded on). Common in business and technology contexts.',
  register = 'neutral',
  variety = 'international',
  examples = '["Our company is based in São Paulo.", "The decision is based on data.", "We have a large customer base.", "The base salary is $50,000."]'::jsonb,
  collocations = '["based in", "based on", "customer base", "base salary", "knowledge base", "database"]'::jsonb,
  patterns = '["based + in/on", "customer base", "base + noun (compound)"]'::jsonb,
  updated_at = now()
WHERE headword = 'base';

-- Noun: board
UPDATE lexicon_entries
SET
  ipa = 'bɔːd',
  definition_simple = 'a flat piece of wood or other material, or a group of people who control a company',
  definition_teacher = 'noun: countable; refers to a flat surface, governing body, or meals (room and board); also verb meaning to get on transport; neutral register; multiple meanings',
  usage_notes = 'Important business term. Governance: "board of directors", "board meeting", "on the board". Surface: "whiteboard", "bulletin board". Verb: "board a plane". Very common in corporate contexts. Brazilian learners should note: "board of directors" (not "directory").',
  register = 'neutral',
  variety = 'international',
  examples = '["She is on the board of directors.", "The board meeting is tomorrow.", "Write it on the whiteboard.", "We board the plane at 3 PM."]'::jsonb,
  collocations = '["board of directors", "board meeting", "on the board", "whiteboard", "bulletin board"]'::jsonb,
  patterns = '["board + of + noun", "on the board", "board meeting"]'::jsonb,
  updated_at = now()
WHERE headword = 'board';

-- Noun: branch
UPDATE lexicon_entries
SET
  ipa = 'brɑːntʃ',
  definition_simple = 'a part of a tree that grows out from the main trunk, or an office of a company in a different location',
  definition_teacher = 'noun: countable; refers to tree limb, company office, division, or field subdivision; also verb meaning to divide; neutral register; common in business organization',
  usage_notes = 'Common business term. Company: "branch office", "open a branch", "branch manager". Division: "branch of government", "branch of science". Very common in banking and retail. Brazilian learners should note: "branch" (office) vs "filial" in Portuguese.',
  register = 'neutral',
  variety = 'international',
  examples = '["We have a branch office in Rio.", "She is the branch manager.", "The bank opened a new branch.", "This is a branch of engineering."]'::jsonb,
  collocations = '["branch office", "branch manager", "open a branch", "bank branch"]'::jsonb,
  patterns = '["branch + office/manager", "open a branch", "branch + of"]'::jsonb,
  updated_at = now()
WHERE headword = 'branch';

-- Noun: case
UPDATE lexicon_entries
SET
  ipa = 'keɪs',
  definition_simple = 'a particular situation or example, or a container for holding something',
  definition_teacher = 'noun: countable; refers to instance, situation, legal matter, container, or argument; neutral register; highly versatile with multiple meanings',
  usage_notes = 'Versatile business term. Situation: "in this case", "in case of" (if), "use case". Legal: "court case", "case study". Container: "briefcase", "case for phone". Very common in business analysis and law. Brazilian learners should note: "in case of" (if) vs "in this case" (in this situation).',
  register = 'neutral',
  variety = 'international',
  examples = '["In this case, we need approval.", "In case of emergency, call this number.", "We studied several case studies.", "I need a case for my laptop."]'::jsonb,
  collocations = '["in this case", "in case of", "case study", "use case", "court case"]'::jsonb,
  patterns = '["in + case", "in case + of", "case study"]'::jsonb,
  updated_at = now()
WHERE headword = 'case';

-- ============================================================================
-- PROFESSIONAL VERBS - MANAGEMENT AND ORGANIZATION (15 words)
-- ============================================================================

-- Verb: employ
UPDATE lexicon_entries
SET
  ipa = 'ɪmˈplɔɪ',
  definition_simple = 'to pay someone to work for you',
  definition_teacher = 'verb: transitive; refers to hiring and paying workers, or using something; forms: employ/employs, employed, employed; neutral register; fundamental employment term',
  usage_notes = 'Essential employment term. Meaning: hire and pay workers. "The company employs 500 people." Related: "employee" (worker), "employer" (company/boss), "employment" (work/job). Also means "use": "employ a strategy". Brazilian learners should note: "employ" (verb) vs "employee" (noun).',
  register = 'neutral',
  variety = 'international',
  examples = '["The company employs 500 people.", "We need to employ more staff.", "She is employed as a consultant.", "We employ various strategies."]'::jsonb,
  collocations = '["employ people", "employ staff", "be employed as", "employ a strategy"]'::jsonb,
  patterns = '["employ + people/staff", "be employed + as", "employ + strategy/method"]'::jsonb,
  updated_at = now()
WHERE headword = 'employ';

-- Verb: develop
UPDATE lexicon_entries
SET
  ipa = 'dɪˈveləp',
  definition_simple = 'to grow or change into something bigger or more advanced, or to create something new',
  definition_teacher = 'verb: transitive/intransitive; refers to growth, creation, improvement, or evolution; forms: develop/develops, developed, developed; neutral register; very common in business and technology',
  usage_notes = 'Essential business verb. Create: "develop a product", "develop software". Improve: "develop skills", "develop a strategy". Grow: "develop the business". Very common in technology, business development, and personal growth contexts. Brazilian learners should note: "develop" (not "develope").',
  register = 'neutral',
  variety = 'international',
  examples = '["We are developing a new product.", "She needs to develop her skills.", "The company is developing rapidly.", "They developed a successful strategy."]'::jsonb,
  collocations = '["develop a product", "develop skills", "develop a strategy", "develop software", "develop the business"]'::jsonb,
  patterns = '["develop + noun", "develop + into"]'::jsonb,
  updated_at = now()
WHERE headword = 'develop';

-- Verb: control
UPDATE lexicon_entries
SET
  ipa = 'kənˈtrəʊl',
  definition_simple = 'to have power over something or to make something work the way you want',
  definition_teacher = 'verb: transitive; refers to directing, managing, regulating, or restraining; also noun meaning power or regulation; forms: control/controls, controlled, controlled; neutral register',
  usage_notes = 'Important management verb. Direct: "control the project", "control costs". Regulate: "control quality", "quality control". Restrain: "control emotions". Also noun: "have control", "lose control", "under control". Very common in management and operations.',
  register = 'neutral',
  variety = 'international',
  examples = '["We need to control costs.", "She controls the budget.", "Quality control is important.", "The situation is under control."]'::jsonb,
  collocations = '["control costs", "control the budget", "quality control", "under control", "lose control"]'::jsonb,
  patterns = '["control + noun", "under control", "quality control"]'::jsonb,
  updated_at = now()
WHERE headword = 'control';

-- Verb: consider
UPDATE lexicon_entries
SET
  ipa = 'kənˈsɪdə',
  definition_simple = 'to think about something carefully before making a decision',
  definition_teacher = 'verb: transitive; refers to thinking carefully, regarding as, or taking into account; forms: consider/considers, considered, considered; neutral register; important decision-making verb',
  usage_notes = 'Essential decision-making verb. Think about: "consider the options", "consider carefully". Regard as: "consider it important". Take into account: "consider all factors". Very common in business decisions. Brazilian learners should note: "consider doing" (not "consider to do").',
  register = 'neutral',
  variety = 'international',
  examples = '["We need to consider all options.", "Please consider my proposal.", "I am considering changing jobs.", "This is considered important."]'::jsonb,
  collocations = '["consider the options", "consider carefully", "consider doing", "be considered"]'::jsonb,
  patterns = '["consider + noun", "consider + gerund", "be considered + adjective"]'::jsonb,
  updated_at = now()
WHERE headword = 'consider';

-- Verb: continue
UPDATE lexicon_entries
SET
  ipa = 'kənˈtɪnjuː',
  definition_simple = 'to keep doing something without stopping',
  definition_teacher = 'verb: transitive/intransitive; refers to maintaining an action, resuming after pause, or extending; forms: continue/continues, continued, continued; neutral register; common in ongoing activities',
  usage_notes = 'Common continuation verb. Keep going: "continue working", "continue the project". Resume: "continue after lunch". Extend: "continue for two hours". Very common in business processes. Brazilian learners should note: "continue doing" or "continue to do" (both acceptable).',
  register = 'neutral',
  variety = 'international',
  examples = '["Please continue with your work.", "We will continue the meeting after lunch.", "The project continues to grow.", "She continued working until 7 PM."]'::jsonb,
  collocations = '["continue working", "continue to grow", "continue with", "continue doing"]'::jsonb,
  patterns = '["continue + gerund/infinitive", "continue + with"]'::jsonb,
  updated_at = now()
WHERE headword = 'continue';

-- Verb: decide
UPDATE lexicon_entries
SET
  ipa = 'dɪˈsaɪd',
  definition_simple = 'to make a choice about something after thinking about it',
  definition_teacher = 'verb: transitive/intransitive; refers to making a choice, determining, or resolving; forms: decide/decides, decided, decided; neutral register; fundamental decision-making verb',
  usage_notes = 'Essential decision verb. Make choice: "decide to do", "decide on something", "decide between options". Very common in business decisions. Related: "decision" (noun). Brazilian learners should note: "decide to do" (not "decide of doing").',
  register = 'neutral',
  variety = 'international',
  examples = '["We need to decide today.", "She decided to accept the offer.", "Have you decided on a date?", "The team decided between two options."]'::jsonb,
  collocations = '["decide to do", "decide on", "decide between", "make a decision"]'::jsonb,
  patterns = '["decide + to + infinitive", "decide + on", "decide + between"]'::jsonb,
  updated_at = now()
WHERE headword = 'decide';

-- Verb: deliver
UPDATE lexicon_entries
SET
  ipa = 'dɪˈlɪvə',
  definition_simple = 'to take something to a person or place',
  definition_teacher = 'verb: transitive; refers to transporting goods, presenting information, or fulfilling promises; forms: deliver/delivers, delivered, delivered; neutral register; important in logistics and communication',
  usage_notes = 'Versatile business verb. Transport: "deliver goods", "deliver a package". Present: "deliver a presentation", "deliver a message". Fulfill: "deliver results", "deliver on promises". Very common in logistics and project management. Related: "delivery" (noun).',
  register = 'neutral',
  variety = 'international',
  examples = '["We deliver products worldwide.", "She will deliver a presentation tomorrow.", "The team delivered excellent results.", "Can you deliver this message?"]'::jsonb,
  collocations = '["deliver goods", "deliver a presentation", "deliver results", "deliver on time"]'::jsonb,
  patterns = '["deliver + noun", "deliver + to", "deliver on"]'::jsonb,
  updated_at = now()
WHERE headword = 'deliver';

-- Verb: demand
UPDATE lexicon_entries
SET
  ipa = 'dɪˈmɑːnd',
  definition_simple = 'to ask for something firmly or to need something',
  definition_teacher = 'verb: transitive; refers to requesting firmly, requiring, or needing; also noun meaning request or market need; forms: demand/demands, demanded, demanded; neutral register',
  usage_notes = 'Strong request verb. Ask firmly: "demand an explanation", "demand payment". Require: "demand attention", "demand skills". Also noun: "high demand", "supply and demand". Common in business and economics. Brazilian learners should note: stronger than "ask".',
  register = 'neutral',
  variety = 'international',
  examples = '["The job demands long hours.", "Customers demand quality.", "There is high demand for this product.", "She demanded an explanation."]'::jsonb,
  collocations = '["demand attention", "high demand", "demand quality", "supply and demand"]'::jsonb,
  patterns = '["demand + noun", "demand + that clause", "in demand"]'::jsonb,
  updated_at = now()
WHERE headword = 'demand';

-- Verb: describe
UPDATE lexicon_entries
SET
  ipa = 'dɪˈskraɪb',
  definition_simple = 'to say what someone or something is like',
  definition_teacher = 'verb: transitive; refers to explaining characteristics, depicting, or characterizing; forms: describe/describes, described, described; neutral register; important communication verb',
  usage_notes = 'Essential communication verb. Explain: "describe the problem", "describe the process". Characterize: "describe as" (characterize). Very common in presentations and reports. Related: "description" (noun). Brazilian learners should note: "describe" (not "describe about").',
  register = 'neutral',
  variety = 'international',
  examples = '["Please describe the problem.", "She described the process clearly.", "Can you describe what happened?", "He is described as experienced."]'::jsonb,
  collocations = '["describe the problem", "describe the process", "describe as", "describe in detail"]'::jsonb,
  patterns = '["describe + noun", "describe + as", "describe + wh-clause"]'::jsonb,
  updated_at = now()
WHERE headword = 'describe';

-- Verb: determine
UPDATE lexicon_entries
SET
  ipa = 'dɪˈtɜːmɪn',
  definition_simple = 'to find out or decide something',
  definition_teacher = 'verb: transitive; refers to establishing facts, deciding, or influencing outcomes; forms: determine/determines, determined, determined; neutral register; important analysis verb',
  usage_notes = 'Important analysis verb. Find out: "determine the cause", "determine if/whether". Decide: "determine the price". Influence: "determine success". Very common in research and analysis. Related: "determination" (noun), "determined" (adjective - resolute).',
  register = 'neutral',
  variety = 'international',
  examples = '["We need to determine the cause.", "The market determines the price.", "Tests will determine if it works.", "She is determined to succeed."]'::jsonb,
  collocations = '["determine the cause", "determine if/whether", "determine the price", "be determined"]'::jsonb,
  patterns = '["determine + noun", "determine + if/whether clause", "be determined + to"]'::jsonb,
  updated_at = now()
WHERE headword = 'determine';

-- Verb: discover
UPDATE lexicon_entries
SET
  ipa = 'dɪˈskʌvə',
  definition_simple = 'to find something or learn something for the first time',
  definition_teacher = 'verb: transitive; refers to finding, learning, or uncovering something previously unknown; forms: discover/discovers, discovered, discovered; neutral register; important in research and problem-solving',
  usage_notes = 'Important discovery verb. Find: "discover a problem", "discover a solution". Learn: "discover that" (learn). Uncover: "discover information". Common in research and troubleshooting. Related: "discovery" (noun). Brazilian learners should note: "discover" (find for first time) vs "find" (locate).',
  register = 'neutral',
  variety = 'international',
  examples = '["We discovered a problem in the system.", "She discovered a new solution.", "They discovered that costs were too high.", "The team discovered important information."]'::jsonb,
  collocations = '["discover a problem", "discover a solution", "discover that", "discover information"]'::jsonb,
  patterns = '["discover + noun", "discover + that clause"]'::jsonb,
  updated_at = now()
WHERE headword = 'discover';

-- Verb: explain
UPDATE lexicon_entries
SET
  ipa = 'ɪkˈspleɪn',
  definition_simple = 'to make something clear or easy to understand',
  definition_teacher = 'verb: transitive; refers to clarifying, describing reasons, or making understandable; forms: explain/explains, explained, explained; neutral register; essential communication verb',
  usage_notes = 'Essential communication verb. Clarify: "explain the process", "explain how/why". Give reasons: "explain the decision". Very common in training and presentations. Related: "explanation" (noun). Brazilian learners should note: "explain something to someone" (not "explain someone something").',
  register = 'neutral',
  variety = 'international',
  examples = '["Can you explain the process?", "She explained why we need to change.", "Let me explain how it works.", "He explained the decision to the team."]'::jsonb,
  collocations = '["explain the process", "explain why/how", "explain to someone", "explain in detail"]'::jsonb,
  patterns = '["explain + noun", "explain + wh-clause", "explain + to + person"]'::jsonb,
  updated_at = now()
WHERE headword = 'explain';

-- Verb: express
UPDATE lexicon_entries
SET
  ipa = 'ɪkˈspres',
  definition_simple = 'to show or say what you think or feel',
  definition_teacher = 'verb: transitive; refers to communicating thoughts/feelings, showing, or stating; also adjective meaning fast or explicit; forms: express/expresses, expressed, expressed; neutral register',
  usage_notes = 'Important communication verb. Show feelings: "express concern", "express interest". State: "express an opinion", "express gratitude". Also adjective: "express delivery" (fast). Common in professional communication. Brazilian learners should note: "express" (communicate) vs "expression" (phrase/face).',
  register = 'neutral',
  variety = 'international',
  examples = '["She expressed concern about the deadline.", "Please express your opinion.", "I want to express my gratitude.", "We offer express delivery."]'::jsonb,
  collocations = '["express concern", "express interest", "express an opinion", "express gratitude", "express delivery"]'::jsonb,
  patterns = '["express + noun", "express + that clause"]'::jsonb,
  updated_at = now()
WHERE headword = 'express';

-- Verb: extend
UPDATE lexicon_entries
SET
  ipa = 'ɪkˈstend',
  definition_simple = 'to make something longer or bigger, or to offer something',
  definition_teacher = 'verb: transitive/intransitive; refers to lengthening, expanding, offering, or reaching; forms: extend/extends, extended, extended; neutral register; common in time and space contexts',
  usage_notes = 'Versatile business verb. Lengthen: "extend the deadline", "extend the contract". Expand: "extend the business". Offer: "extend an invitation", "extend an offer". Very common in negotiations and project management. Related: "extension" (noun).',
  register = 'neutral',
  variety = 'international',
  examples = '["Can we extend the deadline?", "The company is extending its operations.", "I would like to extend an invitation.", "The contract was extended for one year."]'::jsonb,
  collocations = '["extend the deadline", "extend the contract", "extend an invitation", "extend an offer"]'::jsonb,
  patterns = '["extend + noun", "extend + to"]'::jsonb,
  updated_at = now()
WHERE headword = 'extend';

-- Verb: expect
UPDATE lexicon_entries
SET
  ipa = 'ɪkˈspekt',
  definition_simple = 'to think that something will happen or that someone will do something',
  definition_teacher = 'verb: transitive; refers to anticipating, requiring, or supposing; forms: expect/expects, expected, expected; neutral register; important planning and requirement verb',
  usage_notes = 'Important planning verb. Anticipate: "expect results", "expect to do". Require: "expect employees to" (require). Suppose: "I expect so" (I think so). Very common in business planning. Related: "expectation" (noun). Brazilian learners should note: "expect to do" (not "expect doing").',
  register = 'neutral',
  variety = 'international',
  examples = '["We expect good results.", "I expect to finish by Friday.", "The manager expects employees to be on time.", "Sales are expected to increase."]'::jsonb,
  collocations = '["expect results", "expect to do", "be expected to", "as expected"]'::jsonb,
  patterns = '["expect + noun", "expect + to + infinitive", "expect + person + to + infinitive"]'::jsonb,
  updated_at = now()
WHERE headword = 'expect';

-- ============================================================================
-- BUSINESS CONCEPTS AND PROCESSES (20 words)
-- ============================================================================

-- Noun: experience
UPDATE lexicon_entries
SET
  ipa = 'ɪkˈspɪəriəns',
  definition_simple = 'knowledge or skill from doing something, or something that happens to you',
  definition_teacher = 'noun: uncountable (knowledge/skill) or countable (event); refers to practical knowledge, events, or encounters; also verb meaning to have or undergo; neutral register; essential in employment',
  usage_notes = 'Essential employment term. Knowledge: "work experience", "years of experience", "have experience in". Event: "a good experience", "an experience". Verb: "experience problems". Very common in CVs and job descriptions. Brazilian learners should note: uncountable for knowledge, countable for events.',
  register = 'neutral',
  variety = 'international',
  examples = '["She has five years of experience.", "I have experience in project management.", "It was a great experience.", "We experienced some problems."]'::jsonb,
  collocations = '["work experience", "years of experience", "have experience in", "customer experience", "user experience"]'::jsonb,
  patterns = '["experience + in", "years of experience", "have experience"]'::jsonb,
  updated_at = now()
WHERE headword = 'experience';

-- Noun: effort
UPDATE lexicon_entries
SET
  ipa = 'ˈefət',
  definition_simple = 'the physical or mental energy needed to do something',
  definition_teacher = 'noun: countable/uncountable; refers to exertion, attempt, or work required; neutral register; important in describing work and attempts',
  usage_notes = 'Common work term. Energy: "make an effort", "put effort into", "require effort". Attempt: "team effort", "joint effort". Very common in describing work quality and attempts. Brazilian learners should note: "make an effort" (not "do an effort").',
  register = 'neutral',
  variety = 'international',
  examples = '["We need to make more effort.", "She put a lot of effort into the project.", "It was a team effort.", "This requires significant effort."]'::jsonb,
  collocations = '["make an effort", "put effort into", "team effort", "joint effort", "require effort"]'::jsonb,
  patterns = '["make an effort", "put effort + into", "team effort"]'::jsonb,
  updated_at = now()
WHERE headword = 'effort';

-- Noun: effect
UPDATE lexicon_entries
SET
  ipa = 'ɪˈfekt',
  definition_simple = 'a change that is caused by something',
  definition_teacher = 'noun: countable/uncountable; refers to result, consequence, or impact; also verb meaning to cause (formal); neutral register; important in cause-effect analysis',
  usage_notes = 'Important analysis term. Result: "have an effect on", "side effect", "take effect" (become active). Impact: "positive effect", "negative effect". Very common in business analysis. Brazilian learners should note: "effect" (noun - result) vs "affect" (verb - influence).',
  register = 'neutral',
  variety = 'international',
  examples = '["The change had a positive effect.", "What is the effect of this decision?", "The new policy takes effect tomorrow.", "This will affect our results."]'::jsonb,
  collocations = '["have an effect on", "positive effect", "negative effect", "take effect", "side effect"]'::jsonb,
  patterns = '["have an effect + on", "take effect", "effect + of"]'::jsonb,
  updated_at = now()
WHERE headword = 'effect';

-- Noun: detail
UPDATE lexicon_entries
SET
  ipa = 'ˈdiːteɪl',
  definition_simple = 'a small piece of information or a small part of something',
  definition_teacher = 'noun: countable/uncountable; refers to specific information, particulars, or small parts; also verb meaning to describe fully; neutral register; important in thorough communication',
  usage_notes = 'Important communication term. Information: "in detail", "go into detail", "details about". Specifics: "attention to detail", "minor details". Verb: "detail the plan". Very common in reports and presentations. Brazilian learners should note: "in detail" (thoroughly).',
  register = 'neutral',
  variety = 'international',
  examples = '["Please explain in detail.", "We need more details about the project.", "She has great attention to detail.", "The report details the findings."]'::jsonb,
  collocations = '["in detail", "go into detail", "attention to detail", "details about", "provide details"]'::jsonb,
  patterns = '["in detail", "details + about/of", "attention to detail"]'::jsonb,
  updated_at = now()
WHERE headword = 'detail';

-- Noun: difference
UPDATE lexicon_entries
SET
  ipa = 'ˈdɪfrəns',
  definition_simple = 'the way that things are not the same',
  definition_teacher = 'noun: countable/uncountable; refers to distinction, variation, or disagreement; neutral register; important in comparison and analysis',
  usage_notes = 'Important comparison term. Distinction: "difference between", "make a difference" (have impact), "tell the difference" (distinguish). Variation: "big difference", "small difference". Very common in analysis and comparisons. Brazilian learners should note: "difference between" (not "difference of").',
  register = 'neutral',
  variety = 'international',
  examples = '["What is the difference between these two?", "This will make a big difference.", "I can''t tell the difference.", "There is a significant difference in cost."]'::jsonb,
  collocations = '["difference between", "make a difference", "tell the difference", "big difference", "significant difference"]'::jsonb,
  patterns = '["difference + between", "make a difference", "tell the difference"]'::jsonb,
  updated_at = now()
WHERE headword = 'difference';

-- Noun: example
UPDATE lexicon_entries
SET
  ipa = 'ɪɡˈzɑːmpəl',
  definition_simple = 'something that shows what other similar things are like',
  definition_teacher = 'noun: countable; refers to instance, model, or illustration; neutral register; essential in explanations and teaching',
  usage_notes = 'Essential communication term. Instance: "for example", "give an example". Model: "set an example", "follow the example". Very common in presentations and training. Brazilian learners should note: "for example" (not "for an example").',
  register = 'neutral',
  variety = 'international',
  examples = '["For example, we could use email.", "Can you give me an example?", "She sets a good example.", "This is an example of good practice."]'::jsonb,
  collocations = '["for example", "give an example", "set an example", "follow the example", "good example"]'::jsonb,
  patterns = '["for example", "give an example", "example + of"]'::jsonb,
  updated_at = now()
WHERE headword = 'example';

-- Noun: fact
UPDATE lexicon_entries
SET
  ipa = 'fækt',
  definition_simple = 'something that is true or something that really happened',
  definition_teacher = 'noun: countable; refers to truth, reality, or verified information; neutral register; important in evidence-based communication',
  usage_notes = 'Important evidence term. Truth: "the fact is", "in fact" (actually), "fact that". Reality: "face the facts", "based on facts". Very common in business arguments and reports. Brazilian learners should note: "in fact" (actually) vs "the fact that" (the truth that).',
  register = 'neutral',
  variety = 'international',
  examples = '["The fact is, we need more time.", "In fact, sales increased.", "These are the facts.", "The decision is based on facts."]'::jsonb,
  collocations = '["the fact is", "in fact", "the fact that", "based on facts", "face the facts"]'::jsonb,
  patterns = '["the fact + is/that", "in fact", "based on facts"]'::jsonb,
  updated_at = now()
WHERE headword = 'fact';

-- Noun: figure
UPDATE lexicon_entries
SET
  ipa = 'ˈfɪɡə',
  definition_simple = 'a number or amount, or the shape of a person''s body',
  definition_teacher = 'noun: countable; refers to number, diagram, person, or shape; also verb meaning to calculate or appear; neutral register; multiple meanings in business',
  usage_notes = 'Versatile business term. Number: "sales figures", "key figures". Diagram: "see figure 1". Person: "public figure", "key figure". Verb: "figure out" (solve). Very common in reports and presentations. Brazilian learners should note: "figure" (number) vs "number" (quantity).',
  register = 'neutral',
  variety = 'international',
  examples = '["The sales figures are impressive.", "See figure 1 for details.", "She is a key figure in the company.", "We need to figure out the problem."]'::jsonb,
  collocations = '["sales figures", "key figure", "figure out", "see figure", "public figure"]'::jsonb,
  patterns = '["sales figures", "figure + out", "see figure + number"]'::jsonb,
  updated_at = now()
WHERE headword = 'figure';

-- Noun: form
UPDATE lexicon_entries
SET
  ipa = 'fɔːm',
  definition_simple = 'a document with spaces where you write information, or a type or shape of something',
  definition_teacher = 'noun: countable; refers to document, type, shape, or structure; also verb meaning to create or shape; neutral register; multiple business meanings',
  usage_notes = 'Versatile business term. Document: "fill out a form", "application form". Type: "form of payment". Shape: "in the form of". Verb: "form a company", "form a team". Very common in administration and organization. Brazilian learners should note: "fill out a form" (US) or "fill in a form" (UK).',
  register = 'neutral',
  variety = 'international',
  examples = '["Please fill out this form.", "What form of payment do you accept?", "The bonus is in the form of stock.", "They formed a new company."]'::jsonb,
  collocations = '["fill out a form", "application form", "form of payment", "in the form of", "form a company"]'::jsonb,
  patterns = '["fill out/in a form", "form + of", "form a + noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'form';

-- Noun: course
UPDATE lexicon_entries
SET
  ipa = 'kɔːs',
  definition_simple = 'a series of lessons or a direction of movement',
  definition_teacher = 'noun: countable; refers to educational program, direction, progression, or meal part; neutral register; multiple meanings in education and planning',
  usage_notes = 'Versatile term. Education: "training course", "take a course". Direction: "course of action", "change course". Progression: "in the course of" (during), "of course" (naturally). Very common in training and planning. Brazilian learners should note: "of course" (certainly) vs "course" (class).',
  register = 'neutral',
  variety = 'international',
  examples = '["I am taking a training course.", "What is our course of action?", "Of course, I will help.", "In the course of the project, we learned a lot."]'::jsonb,
  collocations = '["training course", "course of action", "of course", "in the course of", "take a course"]'::jsonb,
  patterns = '["training course", "course + of", "of course", "take a course"]'::jsonb,
  updated_at = now()
WHERE headword = 'course';

-- Noun: concern
UPDATE lexicon_entries
SET
  ipa = 'kənˈsɜːn',
  definition_simple = 'a feeling of worry, or something that is important to you',
  definition_teacher = 'noun: countable/uncountable; refers to worry, matter of interest, or business; also verb meaning to be about or worry; neutral register; important in expressing issues',
  usage_notes = 'Important communication term. Worry: "cause concern", "express concern". Matter: "main concern", "of concern". Business: "going concern" (operating business). Verb: "concern about", "as far as...is concerned". Very common in business communication.',
  register = 'neutral',
  variety = 'international',
  examples = '["Safety is our main concern.", "I have some concerns about the plan.", "This concerns all employees.", "As far as I am concerned, it''s fine."]'::jsonb,
  collocations = '["main concern", "cause concern", "express concern", "of concern", "as far as...is concerned"]'::jsonb,
  patterns = '["main concern", "concern + about", "of concern"]'::jsonb,
  updated_at = now()
WHERE headword = 'concern';

-- Noun: condition
UPDATE lexicon_entries
SET
  ipa = 'kənˈdɪʃən',
  definition_simple = 'the state that something is in, or something that must happen before something else can happen',
  definition_teacher = 'noun: countable/uncountable; refers to state, requirement, circumstance, or health status; also verb meaning to train or influence; neutral register; important in contracts and descriptions',
  usage_notes = 'Important business term. State: "in good condition", "working condition". Requirement: "terms and conditions", "on condition that" (if). Circumstances: "market conditions", "working conditions". Very common in contracts and quality assessment.',
  register = 'neutral',
  variety = 'international',
  examples = '["The equipment is in good condition.", "Please read the terms and conditions.", "Market conditions are improving.", "We accept on condition that you pay upfront."]'::jsonb,
  collocations = '["in good condition", "terms and conditions", "market conditions", "working conditions", "on condition that"]'::jsonb,
  patterns = '["in + condition", "terms and conditions", "on condition + that"]'::jsonb,
  updated_at = now()
WHERE headword = 'condition';

-- Noun: content
UPDATE lexicon_entries
SET
  ipa = 'ˈkɒntent',
  definition_simple = 'the things that are inside something, or the information in a document or website',
  definition_teacher = 'noun: uncountable (information) or plural (things inside); refers to information, material, or substance; also adjective meaning satisfied (kənˈtent); neutral register; important in digital and publishing',
  usage_notes = 'Important digital term. Information: "website content", "content marketing", "create content". Things inside: "table of contents", "contents of the box". Adjective: "content with" (satisfied). Very common in digital marketing and publishing. Note different pronunciation for adjective.',
  register = 'neutral',
  variety = 'international',
  examples = '["The website content is excellent.", "Check the table of contents.", "We create content for social media.", "She is content with the results."]'::jsonb,
  collocations = '["website content", "content marketing", "create content", "table of contents", "content with"]'::jsonb,
  patterns = '["website content", "create content", "content + of"]'::jsonb,
  updated_at = now()
WHERE headword = 'content';

-- Noun: cost
UPDATE lexicon_entries
SET
  ipa = 'kɒst',
  definition_simple = 'the amount of money you need to pay for something',
  definition_teacher = 'noun: countable/uncountable; refers to price, expense, or sacrifice; also verb meaning to have a price or cause loss; forms: cost/costs, cost, cost; neutral register; fundamental financial term',
  usage_notes = 'Essential financial term. Price: "the cost of", "at cost" (at purchase price). Expense: "reduce costs", "cost control". Sacrifice: "at all costs" (no matter what). Verb: "it costs $100". Very common in business and finance. Brazilian learners should note: irregular verb (cost-cost-cost).',
  register = 'neutral',
  variety = 'international',
  examples = '["What is the cost of this service?", "We need to reduce costs.", "The project cost $50,000.", "We must succeed at all costs."]'::jsonb,
  collocations = '["the cost of", "reduce costs", "cost control", "at cost", "at all costs"]'::jsonb,
  patterns = '["the cost + of", "reduce costs", "it costs + amount"]'::jsonb,
  updated_at = now()
WHERE headword = 'cost';

-- Noun: character
UPDATE lexicon_entries
SET
  ipa = 'ˈkærəktə',
  definition_simple = 'the qualities that make someone or something different from others',
  definition_teacher = 'noun: countable/uncountable; refers to personality, nature, person in story, or written symbol; neutral register; multiple meanings in different contexts',
  usage_notes = 'Versatile term. Personality: "good character", "character traits". Nature: "the character of the business". Person: "main character" (in story). Symbol: "special characters" (in text). Very common in HR and storytelling. Brazilian learners should note: "character" (personality) vs "characteristic" (feature).',
  register = 'neutral',
  variety = 'international',
  examples = '["She has a strong character.", "The character of our company is innovative.", "He is the main character in the story.", "Use special characters in your password."]'::jsonb,
  collocations = '["good character", "character traits", "main character", "special characters", "character of"]'::jsonb,
  patterns = '["good character", "character + of", "character traits"]'::jsonb,
  updated_at = now()
WHERE headword = 'character';

-- Noun: charge
UPDATE lexicon_entries
SET
  ipa = 'tʃɑːdʒ',
  definition_simple = 'the amount of money you must pay for something, or responsibility for something',
  definition_teacher = 'noun: countable/uncountable; refers to fee, responsibility, accusation, or electrical energy; also verb meaning to ask payment, accuse, or fill with energy; neutral register; multiple business meanings',
  usage_notes = 'Versatile business term. Fee: "service charge", "free of charge" (free). Responsibility: "in charge of" (responsible for), "take charge". Accusation: "criminal charge". Verb: "charge a fee", "charge a battery". Very common in finance and management.',
  register = 'neutral',
  variety = 'international',
  examples = '["There is a service charge of $10.", "She is in charge of the project.", "The service is free of charge.", "We charge $50 per hour."]'::jsonb,
  collocations = '["service charge", "in charge of", "free of charge", "take charge", "charge a fee"]'::jsonb,
  patterns = '["in charge + of", "free of charge", "charge + amount"]'::jsonb,
  updated_at = now()
WHERE headword = 'charge';

-- Noun: class
UPDATE lexicon_entries
SET
  ipa = 'klɑːs',
  definition_simple = 'a group of students who learn together, or a group of things that are similar',
  definition_teacher = 'noun: countable; refers to educational group, category, social level, or quality level; also verb meaning to categorize; neutral register; multiple meanings in education and classification',
  usage_notes = 'Versatile term. Education: "training class", "attend class". Category: "class of products", "business class" (travel). Quality: "world-class", "first-class". Very common in education and classification. Brazilian learners should note: "class" (group/category) vs "classroom" (room).',
  register = 'neutral',
  variety = 'international',
  examples = '["I have a training class tomorrow.", "This is a new class of products.", "We fly business class.", "They offer world-class service."]'::jsonb,
  collocations = '["training class", "attend class", "business class", "world-class", "first-class"]'::jsonb,
  patterns = '["training class", "class + of", "world-class"]'::jsonb,
  updated_at = now()
WHERE headword = 'class';

-- ============================================================================
-- PROFESSIONAL ACTIONS AND RESULTS (25 words)
-- ============================================================================

-- Verb: accept
UPDATE lexicon_entries
SET
  ipa = 'əkˈsept',
  definition_simple = 'to agree to take something that is offered',
  definition_teacher = 'verb: transitive; refers to agreeing to receive, acknowledging truth, or tolerating; forms: accept/accepts, accepted, accepted; neutral register; important in agreements and decisions',
  usage_notes = 'Important agreement verb. Receive: "accept an offer", "accept payment". Acknowledge: "accept responsibility", "accept that" (acknowledge truth). Tolerate: "accept the situation". Very common in business negotiations. Brazilian learners should note: "accept" (agree to receive) vs "except" (excluding).',
  register = 'neutral',
  variety = 'international',
  examples = '["I accept your offer.", "We accept credit cards.", "She accepted responsibility for the mistake.", "You must accept that things change."]'::jsonb,
  collocations = '["accept an offer", "accept payment", "accept responsibility", "accept that"]'::jsonb,
  patterns = '["accept + noun", "accept + that clause", "accept + to + infinitive"]'::jsonb,
  updated_at = now()
WHERE headword = 'accept';

-- Verb: achieve
UPDATE lexicon_entries
SET
  ipa = 'əˈtʃiːv',
  definition_simple = 'to succeed in doing or getting something',
  definition_teacher = 'verb: transitive; refers to accomplishing, attaining, or reaching goals; forms: achieve/achieves, achieved, achieved; neutral register; important success verb',
  usage_notes = 'Important success verb. Accomplish: "achieve goals", "achieve success". Attain: "achieve results", "achieve targets". Very common in performance discussions. Related: "achievement" (noun). Brazilian learners should note: "achieve" (accomplish) vs "reach" (arrive at).',
  register = 'neutral',
  variety = 'international',
  examples = '["We achieved our goals this quarter.", "She achieved great success.", "The team achieved excellent results.", "They achieved their targets."]'::jsonb,
  collocations = '["achieve goals", "achieve success", "achieve results", "achieve targets"]'::jsonb,
  patterns = '["achieve + noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'achieve';

-- Verb: add
UPDATE lexicon_entries
SET
  ipa = 'æd',
  definition_simple = 'to put something with something else to increase the amount',
  definition_teacher = 'verb: transitive; refers to including, increasing, or saying additionally; forms: add/adds, added, added; neutral register; common in mathematics and inclusion',
  usage_notes = 'Common inclusion verb. Include: "add to the list", "add a feature". Increase: "add value", "add up" (total). Say more: "add that" (say additionally). Very common in business and mathematics. Related: "addition" (noun). Brazilian learners should note: "add to" (include in) vs "add up" (total).',
  register = 'neutral',
  variety = 'international',
  examples = '["Please add this to the list.", "We need to add value for customers.", "The costs add up quickly.", "She added that we need more time."]'::jsonb,
  collocations = '["add to", "add value", "add up", "add a feature"]'::jsonb,
  patterns = '["add + noun + to", "add up", "add + that clause"]'::jsonb,
  updated_at = now()
WHERE headword = 'add';

-- Verb: agree
UPDATE lexicon_entries
SET
  ipa = 'əˈɡriː',
  definition_simple = 'to have the same opinion as someone else',
  definition_teacher = 'verb: intransitive/transitive; refers to sharing opinion, consenting, or matching; forms: agree/agrees, agreed, agreed; neutral register; essential in consensus and contracts',
  usage_notes = 'Essential consensus verb. Share opinion: "agree with someone", "agree that". Consent: "agree to do", "agree on something". Match: "numbers agree". Very common in negotiations and decisions. Related: "agreement" (noun). Brazilian learners should note: "agree with" (person), "agree to" (action), "agree on" (topic).',
  register = 'neutral',
  variety = 'international',
  examples = '["I agree with you.", "We agreed to meet tomorrow.", "They agreed on the price.", "Everyone agrees that quality is important."]'::jsonb,
  collocations = '["agree with", "agree to do", "agree on", "agree that"]'::jsonb,
  patterns = '["agree + with + person", "agree + to + infinitive", "agree + on + topic", "agree + that clause"]'::jsonb,
  updated_at = now()
WHERE headword = 'agree';

-- Verb: allow
UPDATE lexicon_entries
SET
  ipa = 'əˈlaʊ',
  definition_simple = 'to let someone do something or let something happen',
  definition_teacher = 'verb: transitive; refers to permitting, enabling, or providing opportunity; forms: allow/allows, allowed, allowed; neutral register; important permission verb',
  usage_notes = 'Important permission verb. Permit: "allow someone to do", "not allowed". Enable: "allow for" (make possible). Provide time: "allow time for". Very common in policies and procedures. Brazilian learners should note: "allow someone to do" (not "allow someone do").',
  register = 'neutral',
  variety = 'international',
  examples = '["We allow employees to work from home.", "Smoking is not allowed here.", "Please allow time for questions.", "This allows for flexibility."]'::jsonb,
  collocations = '["allow someone to do", "not allowed", "allow time for", "allow for"]'::jsonb,
  patterns = '["allow + person + to + infinitive", "be allowed", "allow + for"]'::jsonb,
  updated_at = now()
WHERE headword = 'allow';

-- Verb: appear
UPDATE lexicon_entries
SET
  ipa = 'əˈpɪə',
  definition_simple = 'to start to be seen or to seem to be something',
  definition_teacher = 'verb: intransitive; refers to becoming visible, seeming, or arriving; forms: appear/appears, appeared, appeared; neutral register; important in observations and impressions',
  usage_notes = 'Common observation verb. Become visible: "appear on screen", "appear in public". Seem: "appear to be", "it appears that". Arrive: "appear at meeting". Very common in reports and observations. Related: "appearance" (noun). Brazilian learners should note: "appear to be" (seem) vs "appear" (become visible).',
  register = 'neutral',
  variety = 'international',
  examples = '["The results appear on the screen.", "She appears to be experienced.", "It appears that we need more time.", "He appeared at the meeting late."]'::jsonb,
  collocations = '["appear to be", "it appears that", "appear on", "appear in"]'::jsonb,
  patterns = '["appear + to + infinitive", "it appears + that clause", "appear + on/in"]'::jsonb,
  updated_at = now()
WHERE headword = 'appear';

-- Verb: apply
UPDATE lexicon_entries
SET
  ipa = 'əˈplaɪ',
  definition_simple = 'to ask formally for something, or to use something in a situation',
  definition_teacher = 'verb: intransitive/transitive; refers to requesting formally, using, or being relevant; forms: apply/applies, applied, applied; neutral register; important in employment and usage',
  usage_notes = 'Important employment verb. Request: "apply for a job", "apply to a company". Use: "apply knowledge", "apply a method". Be relevant: "this applies to everyone". Very common in job seeking and implementation. Related: "application" (noun). Brazilian learners should note: "apply for" (job), "apply to" (company/person).',
  register = 'neutral',
  variety = 'international',
  examples = '["I applied for the position.", "Please apply to our website.", "We apply best practices.", "This rule applies to everyone."]'::jsonb,
  collocations = '["apply for a job", "apply to", "apply knowledge", "apply to everyone"]'::jsonb,
  patterns = '["apply + for", "apply + to", "apply + noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'apply';

-- Verb: arrive
UPDATE lexicon_entries
SET
  ipa = 'əˈraɪv',
  definition_simple = 'to get to a place',
  definition_teacher = 'verb: intransitive; refers to reaching destination, coming, or happening; forms: arrive/arrives, arrived, arrived; neutral register; common in scheduling and logistics',
  usage_notes = 'Common movement verb. Reach place: "arrive at" (specific place), "arrive in" (city/country). Come: "arrive on time". Happen: "the day has arrived". Very common in scheduling. Related: "arrival" (noun). Brazilian learners should note: "arrive at" (building), "arrive in" (city), no preposition with "home/here/there".',
  register = 'neutral',
  variety = 'international',
  examples = '["I arrived at the office at 9 AM.", "She arrived in São Paulo yesterday.", "Please arrive on time.", "The package will arrive tomorrow."]'::jsonb,
  collocations = '["arrive at", "arrive in", "arrive on time", "arrive late"]'::jsonb,
  patterns = '["arrive + at + specific place", "arrive + in + city/country", "arrive + on time"]'::jsonb,
  updated_at = now()
WHERE headword = 'arrive';

-- Verb: attempt
UPDATE lexicon_entries
SET
  ipa = 'əˈtempt',
  definition_simple = 'to try to do something',
  definition_teacher = 'verb: transitive; refers to trying or making an effort; also noun meaning try or effort; forms: attempt/attempts, attempted, attempted; neutral register; more formal than "try"',
  usage_notes = 'Formal try verb. Try: "attempt to do", "attempt something". Also noun: "make an attempt", "first attempt". More formal than "try". Very common in formal business communication. Brazilian learners should note: "attempt to do" (not "attempt doing").',
  register = 'neutral',
  variety = 'international',
  examples = '["We attempted to solve the problem.", "She made an attempt to contact them.", "This is my first attempt.", "They attempted several solutions."]'::jsonb,
  collocations = '["attempt to do", "make an attempt", "first attempt", "attempted solution"]'::jsonb,
  patterns = '["attempt + to + infinitive", "make an attempt", "attempt + noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'attempt';

-- Verb: become
UPDATE lexicon_entries
SET
  ipa = 'bɪˈkʌm',
  definition_simple = 'to start to be something',
  definition_teacher = 'verb: linking verb; refers to changing into, starting to be, or developing into; forms: become/becomes, became, become; neutral register; important change verb',
  usage_notes = 'Important change verb. Change into: "become a manager", "become successful". Start to be: "become clear", "become important". Very common in career and development contexts. Brazilian learners should note: irregular verb (become-became-become).',
  register = 'neutral',
  variety = 'international',
  examples = '["She became a manager last year.", "It is becoming clear that we need help.", "He wants to become a consultant.", "The issue became important."]'::jsonb,
  collocations = '["become a manager", "become clear", "become important", "become successful"]'::jsonb,
  patterns = '["become + noun/adjective", "become + clear/important"]'::jsonb,
  updated_at = now()
WHERE headword = 'become';

-- Verb: begin
UPDATE lexicon_entries
SET
  ipa = 'bɪˈɡɪn',
  definition_simple = 'to start doing something or to start to happen',
  definition_teacher = 'verb: transitive/intransitive; refers to starting, commencing, or initiating; forms: begin/begins, began, begun; neutral register; fundamental starting verb',
  usage_notes = 'Essential starting verb. Start action: "begin working", "begin to work". Start happening: "the meeting begins". More formal than "start". Very common in schedules and processes. Brazilian learners should note: "begin doing" or "begin to do" (both acceptable), irregular verb (begin-began-begun).',
  register = 'neutral',
  variety = 'international',
  examples = '["The meeting begins at 2 PM.", "We began working on the project.", "She began to understand the problem.", "Let''s begin with introductions."]'::jsonb,
  collocations = '["begin working", "begin to do", "begin with", "begin the meeting"]'::jsonb,
  patterns = '["begin + gerund/infinitive", "begin + with"]'::jsonb,
  updated_at = now()
WHERE headword = 'begin';

-- Verb: believe
UPDATE lexicon_entries
SET
  ipa = 'bɪˈliːv',
  definition_simple = 'to think that something is true or that someone is telling the truth',
  definition_teacher = 'verb: transitive/intransitive; refers to accepting as true, having faith, or thinking; forms: believe/believes, believed, believed; neutral register; important in opinions and trust',
  usage_notes = 'Important opinion verb. Accept as true: "believe that", "believe in" (have faith in). Think: "I believe so". Trust: "believe someone". Very common in expressing opinions. Related: "belief" (noun). Brazilian learners should note: "believe" (think true) vs "believe in" (have faith in).',
  register = 'neutral',
  variety = 'international',
  examples = '["I believe that quality is important.", "We believe in teamwork.", "Do you believe this will work?", "She believes the report is accurate."]'::jsonb,
  collocations = '["believe that", "believe in", "believe someone", "I believe so"]'::jsonb,
  patterns = '["believe + that clause", "believe + in", "believe + person"]'::jsonb,
  updated_at = now()
WHERE headword = 'believe';

-- Verb: belong
UPDATE lexicon_entries
SET
  ipa = 'bɪˈlɒŋ',
  definition_simple = 'to be owned by someone or to be in the right place',
  definition_teacher = 'verb: intransitive; refers to being owned, being a member, or being in proper place; forms: belong/belongs, belonged, belonged; neutral register; important in ownership and membership',
  usage_notes = 'Important ownership verb. Be owned: "belong to someone". Be member: "belong to a group". Be in right place: "this belongs here". Very common in organization and ownership. Brazilian learners should note: "belong to" (not "belong of").',
  register = 'neutral',
  variety = 'international',
  examples = '["This laptop belongs to me.", "She belongs to the marketing team.", "These files belong in that folder.", "We all belong to the same company."]'::jsonb,
  collocations = '["belong to", "belong in", "belong here"]'::jsonb,
  patterns = '["belong + to + person/group", "belong + in/here/there"]'::jsonb,
  updated_at = now()
WHERE headword = 'belong';

-- Verb: build
UPDATE lexicon_entries
SET
  ipa = 'bɪld',
  definition_simple = 'to make something by putting parts together',
  definition_teacher = 'verb: transitive; refers to constructing, creating, or developing; forms: build/builds, built, built; neutral register; important in construction and development',
  usage_notes = 'Important construction verb. Construct: "build a building", "build a system". Create: "build a business", "build a team". Develop: "build relationships", "build skills". Very common in business development. Brazilian learners should note: irregular verb (build-built-built).',
  register = 'neutral',
  variety = 'international',
  examples = '["They are building a new office.", "We need to build a strong team.", "She built a successful business.", "Let''s build on this success."]'::jsonb,
  collocations = '["build a business", "build a team", "build relationships", "build on"]'::jsonb,
  patterns = '["build + noun", "build + on"]'::jsonb,
  updated_at = now()
WHERE headword = 'build';

-- Verb: carry
UPDATE lexicon_entries
SET
  ipa = 'ˈkæri',
  definition_simple = 'to hold something and take it somewhere',
  definition_teacher = 'verb: transitive; refers to transporting, supporting, having, or continuing; forms: carry/carries, carried, carried; neutral register; versatile action verb',
  usage_notes = 'Versatile action verb. Transport: "carry documents", "carry products". Support: "carry weight". Have: "carry insurance". Continue: "carry on" (continue), "carry out" (execute). Very common in logistics and execution. Brazilian learners should note: "carry out" (execute) vs "carry on" (continue).',
  register = 'neutral',
  variety = 'international',
  examples = '["Please carry these documents to the meeting.", "We carry a full range of products.", "The company carries insurance.", "Let''s carry on with the work."]'::jsonb,
  collocations = '["carry documents", "carry products", "carry out", "carry on", "carry insurance"]'::jsonb,
  patterns = '["carry + noun", "carry + out/on"]'::jsonb,
  updated_at = now()
WHERE headword = 'carry';

-- Verb: cause
UPDATE lexicon_entries
SET
  ipa = 'kɔːz',
  definition_simple = 'to make something happen',
  definition_teacher = 'verb: transitive; refers to making happen, producing effect, or bringing about; also noun meaning reason or purpose; forms: cause/causes, caused, caused; neutral register; important in cause-effect',
  usage_notes = 'Important causation verb. Make happen: "cause problems", "cause delays". Produce: "cause damage", "cause concern". Also noun: "the cause of" (reason), "good cause" (worthy purpose). Very common in problem analysis. Brazilian learners should note: "cause" (make happen) vs "because" (conjunction).',
  register = 'neutral',
  variety = 'international',
  examples = '["This will cause delays.", "What caused the problem?", "The error caused damage.", "We need to find the cause."]'::jsonb,
  collocations = '["cause problems", "cause delays", "cause damage", "the cause of"]'::jsonb,
  patterns = '["cause + noun", "cause + to + infinitive", "the cause + of"]'::jsonb,
  updated_at = now()
WHERE headword = 'cause';

-- Verb: change
UPDATE lexicon_entries
SET
  ipa = 'tʃeɪndʒ',
  definition_simple = 'to become different or to make something different',
  definition_teacher = 'verb: transitive/intransitive; refers to altering, transforming, or exchanging; also noun meaning alteration or coins; forms: change/changes, changed, changed; neutral register; fundamental transformation verb',
  usage_notes = 'Essential transformation verb. Alter: "change the plan", "change your mind". Transform: "change completely". Exchange: "change money". Also noun: "make a change", "small change" (coins). Very common in business adaptation. Brazilian learners should note: "change" (alter) vs "exchange" (trade).',
  register = 'neutral',
  variety = 'international',
  examples = '["We need to change the plan.", "The market is changing rapidly.", "She changed her mind.", "Let''s make some changes."]'::jsonb,
  collocations = '["change the plan", "change your mind", "make a change", "change rapidly"]'::jsonb,
  patterns = '["change + noun", "make a change", "change + into"]'::jsonb,
  updated_at = now()
WHERE headword = 'change';

-- Verb: choose
UPDATE lexicon_entries
SET
  ipa = 'tʃuːz',
  definition_simple = 'to decide which thing you want from a group of things',
  definition_teacher = 'verb: transitive/intransitive; refers to selecting, deciding, or preferring; forms: choose/chooses, chose, chosen; neutral register; important decision verb',
  usage_notes = 'Important selection verb. Select: "choose an option", "choose between". Decide: "choose to do". Prefer: "choose carefully". Very common in decision-making. Related: "choice" (noun). Brazilian learners should note: irregular verb (choose-chose-chosen), "choose to do" (not "choose doing").',
  register = 'neutral',
  variety = 'international',
  examples = '["Please choose an option.", "We chose to expand the business.", "She chose between two offers.", "Choose carefully."]'::jsonb,
  collocations = '["choose an option", "choose to do", "choose between", "choose carefully"]'::jsonb,
  patterns = '["choose + noun", "choose + to + infinitive", "choose + between"]'::jsonb,
  updated_at = now()
WHERE headword = 'choose';

-- Verb: claim
UPDATE lexicon_entries
SET
  ipa = 'kleɪm',
  definition_simple = 'to say that something is true, or to ask for something you believe you have a right to',
  definition_teacher = 'verb: transitive; refers to asserting, demanding rights, or stating; also noun meaning assertion or demand; forms: claim/claims, claimed, claimed; neutral register; important in assertions and rights',
  usage_notes = 'Important assertion verb. Assert: "claim that", "claim to be". Demand rights: "claim expenses", "claim insurance". Also noun: "make a claim", "insurance claim". Very common in legal and insurance contexts. Brazilian learners should note: "claim" (assert) may imply doubt about truth.',
  register = 'neutral',
  variety = 'international',
  examples = '["She claims that the data is accurate.", "You can claim your expenses.", "He claims to be an expert.", "We filed an insurance claim."]'::jsonb,
  collocations = '["claim that", "claim expenses", "claim to be", "make a claim", "insurance claim"]'::jsonb,
  patterns = '["claim + that clause", "claim + to + infinitive", "claim + noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'claim';

-- Verb: compare
UPDATE lexicon_entries
SET
  ipa = 'kəmˈpeə',
  definition_simple = 'to look at things to see how they are similar or different',
  definition_teacher = 'verb: transitive; refers to examining similarities/differences, likening, or measuring against; forms: compare/compares, compared, compared; neutral register; important analysis verb',
  usage_notes = 'Important analysis verb. Examine differences: "compare with/to", "compare prices". Liken: "compare to" (liken). Measure: "compared to last year". Very common in analysis and evaluation. Related: "comparison" (noun). Brazilian learners should note: "compare with" (examine differences), "compare to" (liken).',
  register = 'neutral',
  variety = 'international',
  examples = '["Let''s compare the two proposals.", "Compare this year''s results with last year.", "Sales increased compared to last quarter.", "We need to compare prices."]'::jsonb,
  collocations = '["compare with", "compare to", "compared to", "compare prices"]'::jsonb,
  patterns = '["compare + noun + with/to", "compared to"]'::jsonb,
  updated_at = now()
WHERE headword = 'compare';

-- Verb: complete
UPDATE lexicon_entries
SET
  ipa = 'kəmˈpliːt',
  definition_simple = 'to finish doing or making something',
  definition_teacher = 'verb: transitive; refers to finishing, fulfilling, or making whole; also adjective meaning finished or total; forms: complete/completes, completed, completed; neutral register; important completion verb',
  usage_notes = 'Important completion verb. Finish: "complete the project", "complete the task". Fulfill: "complete the requirements". Also adjective: "complete success", "complete information". Very common in project management. Brazilian learners should note: "complete" (finish) vs "complement" (add to).',
  register = 'neutral',
  variety = 'international',
  examples = '["We completed the project on time.", "Please complete this form.", "The information is complete.", "She completed all requirements."]'::jsonb,
  collocations = '["complete the project", "complete the task", "complete a form", "complete information"]'::jsonb,
  patterns = '["complete + noun", "be complete"]'::jsonb,
  updated_at = now()
WHERE headword = 'complete';

-- Verb: connect
UPDATE lexicon_entries
SET
  ipa = 'kəˈnekt',
  definition_simple = 'to join two things together',
  definition_teacher = 'verb: transitive/intransitive; refers to joining, linking, or associating; forms: connect/connects, connected, connected; neutral register; important in relationships and technology',
  usage_notes = 'Important linking verb. Join: "connect to", "connect with". Link: "connect the dots", "connect ideas". Associate: "connect people". Very common in technology and networking. Related: "connection" (noun). Brazilian learners should note: "connect to" (physical), "connect with" (people/ideas).',
  register = 'neutral',
  variety = 'international',
  examples = '["Please connect to the Wi-Fi.", "We need to connect with clients.", "This connects to the main system.", "Let''s connect these ideas."]'::jsonb,
  collocations = '["connect to", "connect with", "connect the dots", "stay connected"]'::jsonb,
  patterns = '["connect + to/with", "be connected"]'::jsonb,
  updated_at = now()
WHERE headword = 'connect';

-- Verb: contain
UPDATE lexicon_entries
SET
  ipa = 'kənˈteɪn',
  definition_simple = 'to have something inside',
  definition_teacher = 'verb: transitive; refers to including, holding, or restraining; forms: contain/contains, contained, contained; neutral register; important in descriptions and control',
  usage_notes = 'Important inclusion verb. Include: "contain information", "contain details". Hold: "the box contains". Restrain: "contain costs", "contain the problem". Very common in descriptions and problem management. Brazilian learners should note: "contain" (have inside) vs "content" (what is inside).',
  register = 'neutral',
  variety = 'international',
  examples = '["The report contains important information.", "This folder contains all the files.", "We need to contain costs.", "The document contains errors."]'::jsonb,
  collocations = '["contain information", "contain details", "contain costs", "contain the problem"]'::jsonb,
  patterns = '["contain + noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'contain';

-- Verb: cover
UPDATE lexicon_entries
SET
  ipa = 'ˈkʌvə',
  definition_simple = 'to put something over something else, or to include or deal with something',
  definition_teacher = 'verb: transitive; refers to placing over, including, dealing with, or paying for; also noun meaning lid or protection; forms: cover/covers, covered, covered; neutral register; versatile business verb',
  usage_notes = 'Versatile business verb. Place over: "cover with paper". Include: "cover all topics", "cover the basics". Deal with: "cover in the meeting". Pay for: "cover costs", "insurance covers". Very common in meetings and finance. Brazilian learners should note multiple meanings.',
  register = 'neutral',
  variety = 'international',
  examples = '["We will cover all topics in the meeting.", "Insurance covers medical expenses.", "This covers the basics.", "Can you cover my shift?"]'::jsonb,
  collocations = '["cover all topics", "cover costs", "cover the basics", "insurance covers"]'::jsonb,
  patterns = '["cover + noun", "cover + for"]'::jsonb,
  updated_at = now()
WHERE headword = 'cover';

-- Verb: create
UPDATE lexicon_entries
SET
  ipa = 'kriˈeɪt',
  definition_simple = 'to make something new',
  definition_teacher = 'verb: transitive; refers to making, producing, or causing to exist; forms: create/creates, created, created; neutral register; fundamental creation verb',
  usage_notes = 'Essential creation verb. Make new: "create a document", "create a product". Produce: "create value", "create opportunities". Cause: "create problems". Very common in innovation and production. Related: "creation" (noun), "creative" (adjective). Brazilian learners should note: "create" (make new) vs "make" (general production).',
  register = 'neutral',
  variety = 'international',
  examples = '["We need to create a new strategy.", "She created a successful business.", "This creates value for customers.", "Let''s create opportunities."]'::jsonb,
  collocations = '["create a document", "create value", "create opportunities", "create a business"]'::jsonb,
  patterns = '["create + noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'create';

-- Verb: deal
UPDATE lexicon_entries
SET
  ipa = 'diːl',
  definition_simple = 'to take action about something, or to do business',
  definition_teacher = 'verb: intransitive; refers to handling, trading, or distributing; also noun meaning agreement or transaction; forms: deal/deals, dealt, dealt; neutral register; important business verb',
  usage_notes = 'Important business verb. Handle: "deal with problems", "deal with clients". Trade: "deal in products". Also noun: "make a deal", "good deal" (bargain). Very common in problem-solving and business. Brazilian learners should note: irregular verb (deal-dealt-dealt), "deal with" (handle).',
  register = 'neutral',
  variety = 'international',
  examples = '["We need to deal with this problem.", "She deals with clients daily.", "They deal in office supplies.", "Let''s make a deal."]'::jsonb,
  collocations = '["deal with", "make a deal", "good deal", "deal in"]'::jsonb,
  patterns = '["deal + with", "make a deal", "deal + in"]'::jsonb,
  updated_at = now()
WHERE headword = 'deal';

-- Verb: direct
UPDATE lexicon_entries
SET
  ipa = 'dɪˈrekt',
  definition_simple = 'to control or manage something, or to tell someone how to get somewhere',
  definition_teacher = 'verb: transitive; refers to managing, guiding, or aiming; also adjective meaning straight or immediate; forms: direct/directs, directed, directed; neutral register; important management verb',
  usage_notes = 'Important management verb. Manage: "direct the team", "direct operations". Guide: "direct someone to". Aim: "direct attention to". Also adjective: "direct route", "direct communication". Very common in management. Related: "direction" (noun), "director" (noun).',
  register = 'neutral',
  variety = 'international',
  examples = '["She directs the marketing team.", "Can you direct me to the office?", "We need to direct our efforts here.", "Let''s have direct communication."]'::jsonb,
  collocations = '["direct the team", "direct attention to", "direct communication", "direct route"]'::jsonb,
  patterns = '["direct + noun", "direct + person + to"]'::jsonb,
  updated_at = now()
WHERE headword = 'direct';

-- Verb: divide
UPDATE lexicon_entries
SET
  ipa = 'dɪˈvaɪd',
  definition_simple = 'to separate something into parts',
  definition_teacher = 'verb: transitive/intransitive; refers to separating, splitting, or causing disagreement; forms: divide/divides, divided, divided; neutral register; important in organization and mathematics',
  usage_notes = 'Important organization verb. Separate: "divide into groups", "divide the work". Split: "divide equally". Mathematics: "divide by". Cause disagreement: "divide the team" (cause conflict). Very common in organization and math. Related: "division" (noun).',
  register = 'neutral',
  variety = 'international',
  examples = '["Let''s divide into small groups.", "We need to divide the work equally.", "Divide 100 by 5.", "This issue divides the team."]'::jsonb,
  collocations = '["divide into", "divide equally", "divide by", "divide the work"]'::jsonb,
  patterns = '["divide + into", "divide + noun + by"]'::jsonb,
  updated_at = now()
WHERE headword = 'divide';

-- Verb: draw
UPDATE lexicon_entries
SET
  ipa = 'drɔː',
  definition_simple = 'to make a picture with a pen or pencil, or to pull something',
  definition_teacher = 'verb: transitive/intransitive; refers to sketching, pulling, attracting, or concluding; forms: draw/draws, drew, drawn; neutral register; versatile verb with multiple meanings',
  usage_notes = 'Versatile verb. Sketch: "draw a diagram". Pull: "draw attention to". Attract: "draw customers". Conclude: "draw conclusions". Very common in presentations and analysis. Brazilian learners should note: irregular verb (draw-drew-drawn), multiple meanings.',
  register = 'neutral',
  variety = 'international',
  examples = '["Please draw a diagram.", "This draws attention to the problem.", "We need to draw conclusions.", "The sale will draw customers."]'::jsonb,
  collocations = '["draw attention to", "draw conclusions", "draw a diagram", "draw customers"]'::jsonb,
  patterns = '["draw + noun", "draw + attention + to", "draw conclusions"]'::jsonb,
  updated_at = now()
WHERE headword = 'draw';

-- Verb: drive
UPDATE lexicon_entries
SET
  ipa = 'draɪv',
  definition_simple = 'to control a vehicle, or to force someone to do something',
  definition_teacher = 'verb: transitive/intransitive; refers to operating vehicle, motivating, or forcing; also noun meaning journey or motivation; forms: drive/drives, drove, driven; neutral register; important in motivation and transportation',
  usage_notes = 'Versatile verb. Operate vehicle: "drive a car", "drive to work". Motivate: "drive success", "drive growth". Force: "drive someone crazy". Also noun: "sales drive", "hard drive". Very common in business motivation. Brazilian learners should note: irregular verb (drive-drove-driven).',
  register = 'neutral',
  variety = 'international',
  examples = '["I drive to work every day.", "Innovation drives our success.", "This will drive growth.", "We launched a sales drive."]'::jsonb,
  collocations = '["drive to work", "drive success", "drive growth", "sales drive"]'::jsonb,
  patterns = '["drive + vehicle", "drive + noun (motivate)", "drive + to + place"]'::jsonb,
  updated_at = now()
WHERE headword = 'drive';

-- Verb: enter
UPDATE lexicon_entries
SET
  ipa = 'ˈentə',
  definition_simple = 'to go into a place, or to type information into a computer',
  definition_teacher = 'verb: transitive/intransitive; refers to going in, joining, or inputting data; forms: enter/enters, entered, entered; neutral register; common in physical and digital contexts',
  usage_notes = 'Common action verb. Go in: "enter the room", "enter the building". Join: "enter the market", "enter a competition". Input: "enter data", "enter information". Very common in business and technology. Related: "entry" (noun). Brazilian learners should note: "enter" (go in) vs "entry" (entrance/act of entering).',
  register = 'neutral',
  variety = 'international',
  examples = '["Please enter the meeting room.", "We are entering new markets.", "Enter your password here.", "She entered the data correctly."]'::jsonb,
  collocations = '["enter the room", "enter the market", "enter data", "enter information"]'::jsonb,
  patterns = '["enter + place", "enter + market/competition", "enter + data/information"]'::jsonb,
  updated_at = now()
WHERE headword = 'enter';

-- Verb: establish
UPDATE lexicon_entries
SET
  ipa = 'ɪˈstæblɪʃ',
  definition_simple = 'to start or create something that will last',
  definition_teacher = 'verb: transitive; refers to founding, proving, or creating permanently; forms: establish/establishes, established, established; neutral register; important in founding and proving',
  usage_notes = 'Important founding verb. Create: "establish a company", "establish a system". Prove: "establish that" (prove), "establish facts". Create permanently: "establish relationships". Very common in business founding. Related: "establishment" (noun). More formal than "start" or "create".',
  register = 'neutral',
  variety = 'international',
  examples = '["They established the company in 2010.", "We need to establish clear procedures.", "The report establishes that costs are high.", "Let''s establish good relationships."]'::jsonb,
  collocations = '["establish a company", "establish procedures", "establish that", "establish relationships"]'::jsonb,
  patterns = '["establish + noun", "establish + that clause"]'::jsonb,
  updated_at = now()
WHERE headword = 'establish';

-- Verb: examine
UPDATE lexicon_entries
SET
  ipa = 'ɪɡˈzæmɪn',
  definition_simple = 'to look at something carefully to learn about it',
  definition_teacher = 'verb: transitive; refers to inspecting, investigating, or testing; forms: examine/examines, examined, examined; neutral register; important in analysis and inspection',
  usage_notes = 'Important analysis verb. Inspect: "examine the data", "examine carefully". Investigate: "examine the problem". Test: "examine candidates". Very common in quality control and analysis. Related: "examination" (noun). More formal than "look at" or "check".',
  register = 'neutral',
  variety = 'international',
  examples = '["We need to examine the data carefully.", "Let''s examine the problem.", "The auditor will examine the accounts.", "She examined all options."]'::jsonb,
  collocations = '["examine the data", "examine carefully", "examine the problem", "examine options"]'::jsonb,
  patterns = '["examine + noun", "examine + carefully"]'::jsonb,
  updated_at = now()
WHERE headword = 'examine';

-- Verb: exist
UPDATE lexicon_entries
SET
  ipa = 'ɪɡˈzɪst',
  definition_simple = 'to be real or to be present',
  definition_teacher = 'verb: intransitive; refers to being real, being present, or living; forms: exist/exists, existed, existed; neutral register; important in stating presence or reality',
  usage_notes = 'Important existence verb. Be real: "the problem exists", "does it exist?". Be present: "opportunities exist". Live: "exist on" (survive on). Very common in analysis and problem identification. Related: "existence" (noun). Brazilian learners should note: "exist" (be real) vs "exit" (leave).',
  register = 'neutral',
  variety = 'international',
  examples = '["The problem still exists.", "Many opportunities exist in this market.", "Does this file exist?", "We exist to serve customers."]'::jsonb,
  collocations = '["the problem exists", "opportunities exist", "does it exist", "exist to serve"]'::jsonb,
  patterns = '["noun + exists", "exist + to + infinitive"]'::jsonb,
  updated_at = now()
WHERE headword = 'exist';

-- Verb: fail
UPDATE lexicon_entries
SET
  ipa = 'feɪl',
  definition_simple = 'to not succeed in doing something',
  definition_teacher = 'verb: intransitive/transitive; refers to not succeeding, stopping working, or neglecting; forms: fail/fails, failed, failed; neutral register; important in outcomes and reliability',
  usage_notes = 'Important outcome verb. Not succeed: "fail to do", "fail the test". Stop working: "the system failed". Neglect: "fail to mention". Very common in quality and performance discussions. Related: "failure" (noun). Brazilian learners should note: "fail to do" (not succeed in doing).',
  register = 'neutral',
  variety = 'international',
  examples = '["We failed to meet the deadline.", "The system failed yesterday.", "Don''t fail to mention this.", "The project failed due to lack of funding."]'::jsonb,
  collocations = '["fail to do", "fail the test", "system failed", "fail to mention"]'::jsonb,
  patterns = '["fail + to + infinitive", "fail + noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'fail';

-- Verb: feel
UPDATE lexicon_entries
SET
  ipa = 'fiːl',
  definition_simple = 'to experience an emotion or physical sensation',
  definition_teacher = 'verb: transitive/intransitive; refers to experiencing emotion, sensing physically, or believing; forms: feel/feels, felt, felt; neutral register; important in expressing emotions and opinions',
  usage_notes = 'Important emotion verb. Experience emotion: "feel happy", "feel confident". Sense: "feel the pressure". Believe: "I feel that" (think). Very common in expressing opinions and emotions. Brazilian learners should note: irregular verb (feel-felt-felt), "feel" (emotion) vs "fill" (make full).',
  register = 'neutral',
  variety = 'international',
  examples = '["I feel confident about this decision.", "We feel the pressure to deliver.", "She feels that we need more time.", "How do you feel about the proposal?"]'::jsonb,
  collocations = '["feel confident", "feel the pressure", "feel that", "feel about"]'::jsonb,
  patterns = '["feel + adjective", "feel + that clause", "feel + about"]'::jsonb,
  updated_at = now()
WHERE headword = 'feel';

-- Verb: fill
UPDATE lexicon_entries
SET
  ipa = 'fɪl',
  definition_simple = 'to make something full or to put information in spaces on a form',
  definition_teacher = 'verb: transitive/intransitive; refers to making full, completing forms, or occupying position; forms: fill/fills, filled, filled; neutral register; common in forms and capacity',
  usage_notes = 'Common action verb. Make full: "fill the room", "fill with". Complete forms: "fill out a form" (US), "fill in a form" (UK). Occupy: "fill a position", "fill a role". Very common in administration and HR. Brazilian learners should note: "fill out/in a form".',
  register = 'neutral',
  variety = 'international',
  examples = '["Please fill out this form.", "The room filled with people.", "We need to fill this position.", "Fill in your name here."]'::jsonb,
  collocations = '["fill out a form", "fill in", "fill a position", "fill with"]'::jsonb,
  patterns = '["fill + out/in + form", "fill + position", "fill + with"]'::jsonb,
  updated_at = now()
WHERE headword = 'fill';

-- Verb: find
UPDATE lexicon_entries
SET
  ipa = 'faɪnd',
  definition_simple = 'to discover something or someone by searching or by chance',
  definition_teacher = 'verb: transitive; refers to discovering, locating, or determining; forms: find/finds, found, found; neutral register; fundamental discovery verb',
  usage_notes = 'Essential discovery verb. Discover: "find a solution", "find out" (discover information). Locate: "find the file". Determine: "find that" (determine). Very common in problem-solving. Brazilian learners should note: irregular verb (find-found-found), "find out" (discover information).',
  register = 'neutral',
  variety = 'international',
  examples = '["We need to find a solution.", "I found the document in the folder.", "She found out about the meeting.", "They found that costs were too high."]'::jsonb,
  collocations = '["find a solution", "find out", "find the file", "find that"]'::jsonb,
  patterns = '["find + noun", "find + out", "find + that clause"]'::jsonb,
  updated_at = now()
WHERE headword = 'find';

-- Verb: finish
UPDATE lexicon_entries
SET
  ipa = 'ˈfɪnɪʃ',
  definition_simple = 'to complete something or to come to an end',
  definition_teacher = 'verb: transitive/intransitive; refers to completing, ending, or consuming entirely; also noun meaning end or surface coating; forms: finish/finishes, finished, finished; neutral register; important completion verb',
  usage_notes = 'Important completion verb. Complete: "finish the work", "finish doing". End: "the meeting finishes at 5". Consume: "finish the coffee". Also noun: "at the finish". Very common in task completion. Brazilian learners should note: "finish doing" (not "finish to do").',
  register = 'neutral',
  variety = 'international',
  examples = '["I need to finish this report.", "The meeting finishes at 5 PM.", "She finished working at 6.", "We are close to the finish."]'::jsonb,
  collocations = '["finish the work", "finish doing", "finish at", "close to the finish"]'::jsonb,
  patterns = '["finish + noun", "finish + gerund", "finish + at + time"]'::jsonb,
  updated_at = now()
WHERE headword = 'finish';

-- Verb: fit
UPDATE lexicon_entries
SET
  ipa = 'fɪt',
  definition_simple = 'to be the right size or shape, or to be suitable',
  definition_teacher = 'verb: intransitive/transitive; refers to being right size, being suitable, or installing; also adjective meaning healthy or suitable; forms: fit/fits, fitted/fit, fitted/fit; neutral register; important in suitability',
  usage_notes = 'Important suitability verb. Right size: "fit well", "doesn''t fit". Suitable: "fit the requirements", "fit for purpose". Install: "fit a system". Also adjective: "keep fit" (healthy). Very common in requirements and installation. Brazilian learners should note: "fit" (be suitable) vs "suit" (be appropriate for).',
  register = 'neutral',
  variety = 'international',
  examples = '["This solution fits our needs.", "The schedule doesn''t fit.", "Does this fit the requirements?", "We need to fit a new system."]'::jsonb,
  collocations = '["fit the requirements", "fit well", "fit for purpose", "doesn''t fit"]'::jsonb,
  patterns = '["fit + noun", "fit + for", "fit + well"]'::jsonb,
  updated_at = now()
WHERE headword = 'fit';

-- Verb: fix
UPDATE lexicon_entries
SET
  ipa = 'fɪks',
  definition_simple = 'to repair something or to decide on something',
  definition_teacher = 'verb: transitive; refers to repairing, setting, or attaching; also noun meaning solution or difficult situation; forms: fix/fixes, fixed, fixed; neutral register; important in problem-solving',
  usage_notes = 'Important problem-solving verb. Repair: "fix the problem", "fix the bug". Set: "fix a date", "fix a price". Attach: "fix to the wall". Also noun: "quick fix" (temporary solution). Very common in troubleshooting. Brazilian learners should note: "fix" (repair) vs "affix" (attach).',
  register = 'neutral',
  variety = 'international',
  examples = '["We need to fix this problem.", "Can you fix the bug?", "Let''s fix a date for the meeting.", "This is just a quick fix."]'::jsonb,
  collocations = '["fix the problem", "fix the bug", "fix a date", "quick fix"]'::jsonb,
  patterns = '["fix + noun", "fix + date/time"]'::jsonb,
  updated_at = now()
WHERE headword = 'fix';

-- Verb: follow
UPDATE lexicon_entries
SET
  ipa = 'ˈfɒləʊ',
  definition_simple = 'to go after someone or something, or to do what someone says',
  definition_teacher = 'verb: transitive/intransitive; refers to going after, obeying, understanding, or happening after; forms: follow/follows, followed, followed; neutral register; important in procedures and sequence',
  usage_notes = 'Important procedure verb. Go after: "follow someone". Obey: "follow instructions", "follow procedures". Understand: "do you follow?" (understand). Happen after: "follow up" (continue action). Very common in procedures and communication. Brazilian learners should note: "follow up" (continue action after initial contact).',
  register = 'neutral',
  variety = 'international',
  examples = '["Please follow the instructions.", "We need to follow procedures.", "Do you follow what I''m saying?", "I will follow up with you tomorrow."]'::jsonb,
  collocations = '["follow instructions", "follow procedures", "follow up", "follow the rules"]'::jsonb,
  patterns = '["follow + noun", "follow + up", "follow + with"]'::jsonb,
  updated_at = now()
WHERE headword = 'follow';

-- Verb: force
UPDATE lexicon_entries
SET
  ipa = 'fɔːs',
  definition_simple = 'to make someone do something they don''t want to do',
  definition_teacher = 'verb: transitive; refers to compelling, pushing, or breaking through; also noun meaning power or strength; forms: force/forces, forced, forced; neutral register; important in compulsion and power',
  usage_notes = 'Important compulsion verb. Compel: "force someone to do", "be forced to". Push: "force the issue". Break: "force open". Also noun: "sales force", "by force". Very common in pressure situations. Brazilian learners should note: "force someone to do" (compel).',
  register = 'neutral',
  variety = 'international',
  examples = '["We were forced to cancel the meeting.", "Don''t force people to decide quickly.", "The sales force is growing.", "Market forces determine prices."]'::jsonb,
  collocations = '["force someone to do", "be forced to", "sales force", "market forces"]'::jsonb,
  patterns = '["force + person + to + infinitive", "be forced + to"]'::jsonb,
  updated_at = now()
WHERE headword = 'force';

-- Verb: forget
UPDATE lexicon_entries
SET
  ipa = 'fəˈɡet',
  definition_simple = 'to not remember something',
  definition_teacher = 'verb: transitive/intransitive; refers to failing to remember, neglecting, or leaving behind; forms: forget/forgets, forgot, forgotten; neutral register; important in memory and reminders',
  usage_notes = 'Important memory verb. Not remember: "forget the password", "forget that". Neglect: "don''t forget to do". Leave behind: "forget something at home". Very common in reminders and mistakes. Brazilian learners should note: irregular verb (forget-forgot-forgotten), "don''t forget to do" (reminder).',
  register = 'neutral',
  variety = 'international',
  examples = '["I forgot the password.", "Don''t forget to send the email.", "She forgot that we have a meeting.", "I forgot my laptop at home."]'::jsonb,
  collocations = '["forget the password", "don''t forget to", "forget that", "forget about"]'::jsonb,
  patterns = '["forget + noun", "forget + to + infinitive", "forget + that clause"]'::jsonb,
  updated_at = now()
WHERE headword = 'forget';

-- Verb: gain
UPDATE lexicon_entries
SET
  ipa = 'ɡeɪn',
  definition_simple = 'to get or win something',
  definition_teacher = 'verb: transitive; refers to obtaining, increasing, or benefiting; also noun meaning increase or profit; forms: gain/gains, gained, gained; neutral register; important in growth and acquisition',
  usage_notes = 'Important growth verb. Obtain: "gain experience", "gain knowledge". Increase: "gain market share", "gain weight". Benefit: "gain from". Also noun: "capital gains", "weight gain". Very common in business growth. Brazilian learners should note: "gain" (obtain) vs "win" (victory).',
  register = 'neutral',
  variety = 'international',
  examples = '["She gained valuable experience.", "We need to gain market share.", "The company gained 10% growth.", "Everyone can gain from this."]'::jsonb,
  collocations = '["gain experience", "gain knowledge", "gain market share", "gain from"]'::jsonb,
  patterns = '["gain + noun", "gain + from"]'::jsonb,
  updated_at = now()
WHERE headword = 'gain';

-- Verb: grow
UPDATE lexicon_entries
SET
  ipa = 'ɡrəʊ',
  definition_simple = 'to become bigger or to make something bigger',
  definition_teacher = 'verb: intransitive/transitive; refers to increasing in size, developing, or cultivating; forms: grow/grows, grew, grown; neutral register; fundamental growth verb',
  usage_notes = 'Essential growth verb. Increase: "grow the business", "sales grow". Develop: "grow as a professional", "grow skills". Become: "grow tired" (become tired). Very common in business development. Brazilian learners should note: irregular verb (grow-grew-grown), "grow" (increase) vs "growth" (noun).',
  register = 'neutral',
  variety = 'international',
  examples = '["The company is growing rapidly.", "We need to grow the business.", "Sales grew by 20%.", "She is growing as a leader."]'::jsonb,
  collocations = '["grow the business", "grow rapidly", "grow by", "grow as"]'::jsonb,
  patterns = '["grow + noun", "grow + by + percentage", "grow + as"]'::jsonb,
  updated_at = now()
WHERE headword = 'grow';

-- Verb: handle
UPDATE lexicon_entries
SET
  ipa = 'ˈhændəl',
  definition_simple = 'to deal with something or to touch and hold something',
  definition_teacher = 'verb: transitive; refers to managing, dealing with, or touching; also noun meaning part you hold; forms: handle/handles, handled, handled; neutral register; important in management and operations',
  usage_notes = 'Important management verb. Manage: "handle the project", "handle clients". Deal with: "handle problems", "handle complaints". Touch: "handle with care". Also noun: "door handle". Very common in customer service and operations. Brazilian learners should note: "handle" (manage) vs "hand" (body part).',
  register = 'neutral',
  variety = 'international',
  examples = '["She handles client accounts.", "Can you handle this problem?", "We handle customer complaints quickly.", "Handle with care."]'::jsonb,
  collocations = '["handle the project", "handle clients", "handle problems", "handle with care"]'::jsonb,
  patterns = '["handle + noun", "handle + with + care"]'::jsonb,
  updated_at = now()
WHERE headword = 'handle';

-- Verb: hold
UPDATE lexicon_entries
SET
  ipa = 'həʊld',
  definition_simple = 'to have something in your hands or to organize an event',
  definition_teacher = 'verb: transitive; refers to grasping, containing, organizing, or maintaining; forms: hold/holds, held, held; neutral register; versatile verb with multiple business meanings',
  usage_notes = 'Versatile business verb. Grasp: "hold the document". Contain: "hold 100 people". Organize: "hold a meeting", "hold an event". Maintain: "hold a position", "hold steady". Very common in meetings and events. Brazilian learners should note: irregular verb (hold-held-held), multiple meanings.',
  register = 'neutral',
  variety = 'international',
  examples = '["We will hold a meeting tomorrow.", "The room holds 50 people.", "She holds a senior position.", "Please hold the line."]'::jsonb,
  collocations = '["hold a meeting", "hold a position", "hold the line", "hold steady"]'::jsonb,
  patterns = '["hold + meeting/event", "hold + position", "hold + number + people"]'::jsonb,
  updated_at = now()
WHERE headword = 'hold';

-- Verb: improve
UPDATE lexicon_entries
SET
  ipa = 'ɪmˈpruːv',
  definition_simple = 'to make something better or to become better',
  definition_teacher = 'verb: transitive/intransitive; refers to making better, enhancing, or getting better; forms: improve/improves, improved, improved; neutral register; essential improvement verb',
  usage_notes = 'Essential improvement verb. Make better: "improve quality", "improve performance". Enhance: "improve skills", "improve processes". Get better: "sales improve", "conditions improve". Very common in quality and development. Related: "improvement" (noun). Brazilian learners should note: "improve" (make better) vs "prove" (demonstrate truth).',
  register = 'neutral',
  variety = 'international',
  examples = '["We need to improve quality.", "She is improving her skills.", "Sales improved last quarter.", "Let''s improve the process."]'::jsonb,
  collocations = '["improve quality", "improve performance", "improve skills", "improve the process"]'::jsonb,
  patterns = '["improve + noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'improve';

-- Verb: include
UPDATE lexicon_entries
SET
  ipa = 'ɪnˈkluːd',
  definition_simple = 'to have something as a part of a group or total',
  definition_teacher = 'verb: transitive; refers to containing, comprising, or adding as part; forms: include/includes, included, included; neutral register; important in describing contents and scope',
  usage_notes = 'Important inclusion verb. Contain: "the price includes", "the package includes". Comprise: "this includes everyone". Add: "include in the list". Very common in descriptions and pricing. Related: "inclusion" (noun). Brazilian learners should note: "include" (contain as part) vs "exclude" (leave out).',
  register = 'neutral',
  variety = 'international',
  examples = '["The price includes shipping.", "This package includes training.", "Everyone is included in the meeting.", "Please include me in the email."]'::jsonb,
  collocations = '["the price includes", "include in", "be included", "include everyone"]'::jsonb,
  patterns = '["include + noun", "include + in", "be included"]'::jsonb,
  updated_at = now()
WHERE headword = 'include';

-- Verb: increase
UPDATE lexicon_entries
SET
  ipa = 'ɪnˈkriːs',
  definition_simple = 'to become bigger in amount or number, or to make something bigger',
  definition_teacher = 'verb: transitive/intransitive; refers to growing, raising, or expanding; also noun (ˈɪnkriːs) meaning growth or rise; forms: increase/increases, increased, increased; neutral register; fundamental growth verb',
  usage_notes = 'Essential growth verb. Grow: "sales increase", "costs increase". Raise: "increase prices", "increase production". Also noun: "an increase in sales". Very common in business metrics. Brazilian learners should note: verb pronunciation /ɪnˈkriːs/ vs noun /ˈɪnkriːs/, opposite of "decrease".',
  register = 'neutral',
  variety = 'international',
  examples = '["Sales increased by 15%.", "We need to increase production.", "There was an increase in demand.", "Prices will increase next month."]'::jsonb,
  collocations = '["increase sales", "increase production", "increase by", "an increase in"]'::jsonb,
  patterns = '["increase + noun", "increase + by + percentage", "an increase + in"]'::jsonb,
  updated_at = now()
WHERE headword = 'increase';

-- Verb: inform
UPDATE lexicon_entries
SET
  ipa = 'ɪnˈfɔːm',
  definition_simple = 'to tell someone about something',
  definition_teacher = 'verb: transitive; refers to telling, notifying, or providing information; forms: inform/informs, informed, informed; neutral register; important communication verb',
  usage_notes = 'Important communication verb. Tell: "inform someone about", "inform that". Notify: "keep informed", "inform of changes". More formal than "tell". Very common in business communication. Related: "information" (noun). Brazilian learners should note: "inform someone about/of something" (not "inform someone something").',
  register = 'neutral',
  variety = 'international',
  examples = '["Please inform me about any changes.", "We will inform you of the decision.", "Keep me informed.", "I am pleased to inform you that you got the job."]'::jsonb,
  collocations = '["inform someone about", "inform of", "keep informed", "pleased to inform"]'::jsonb,
  patterns = '["inform + person + about/of", "keep + person + informed"]'::jsonb,
  updated_at = now()
WHERE headword = 'inform';

-- Verb: involve
UPDATE lexicon_entries
SET
  ipa = 'ɪnˈvɒlv',
  definition_simple = 'to include someone in something or to require something',
  definition_teacher = 'verb: transitive; refers to including, requiring, or engaging; forms: involve/involves, involved, involved; neutral register; important in participation and requirements',
  usage_notes = 'Important participation verb. Include: "involve someone in", "be involved in". Require: "this involves hard work". Engage: "get involved". Very common in teamwork and project descriptions. Related: "involvement" (noun). Brazilian learners should note: "involve someone in" (include in), "be involved in" (participate in).',
  register = 'neutral',
  variety = 'international',
  examples = '["We need to involve the team in decisions.", "This project involves many people.", "She is involved in marketing.", "The job involves travel."]'::jsonb,
  collocations = '["involve someone in", "be involved in", "involve hard work", "get involved"]'::jsonb,
  patterns = '["involve + person + in", "be involved + in", "involve + noun"]'::jsonb,
  updated_at = now()
WHERE headword = 'involve';

-- Verb: join
UPDATE lexicon_entries
SET
  ipa = 'dʒɔɪn',
  definition_simple = 'to become a member of something or to connect things together',
  definition_teacher = 'verb: transitive/intransitive; refers to becoming member, connecting, or participating; forms: join/joins, joined, joined; neutral register; important in membership and connection',
  usage_notes = 'Important membership verb. Become member: "join the company", "join the team". Connect: "join together", "join forces". Participate: "join the meeting", "join us". Very common in employment and collaboration. Brazilian learners should note: "join" (become member) vs "joint" (adjective - shared).',
  register = 'neutral',
  variety = 'international',
  examples = '["She joined the company last year.", "Please join us for the meeting.", "Let''s join forces on this project.", "Can you join the call?"]'::jsonb,
  collocations = '["join the company", "join the team", "join the meeting", "join forces"]'::jsonb,
  patterns = '["join + organization", "join + us/meeting", "join forces"]'::jsonb,
  updated_at = now()
WHERE headword = 'join';

-- Verb: lead
UPDATE lexicon_entries
SET
  ipa = 'liːd',
  definition_simple = 'to be in charge of a group or to go in front',
  definition_teacher = 'verb: transitive/intransitive; refers to directing, guiding, or being ahead; also noun (led) meaning metal or position; forms: lead/leads, led, led; neutral register; fundamental leadership verb',
  usage_notes = 'Essential leadership verb. Direct: "lead the team", "lead the project". Guide: "lead the way". Be ahead: "lead the market". Also noun: "take the lead". Very common in management. Brazilian learners should note: verb pronunciation /liːd/ vs past tense /led/, different from noun "lead" (metal) /led/.',
  register = 'neutral',
  variety = 'international',
  examples = '["She leads the marketing team.", "He will lead the project.", "Our company leads the market.", "Let me lead the way."]'::jsonb,
  collocations = '["lead the team", "lead the project", "lead the market", "lead the way", "take the lead"]'::jsonb,
  patterns = '["lead + noun", "lead + the way", "take the lead"]'::jsonb,
  updated_at = now()
WHERE headword = 'lead';

-- ============================================================================
-- MIGRATION COMPLETE
-- ============================================================================
-- Total words enhanced: ~70 A1 work and business vocabulary words
-- Focus: Professional English for Brazilian learners
-- Categories covered:
--   - Core business nouns (business, company, office, meeting, project, plan, report, etc.)
--   - Professional verbs (employ, develop, control, consider, decide, deliver, etc.)
--   - Business concepts (account, address, advantage, amount, base, board, branch, etc.)
--   - Professional actions (accept, achieve, add, agree, allow, apply, arrive, etc.)
--   - Management and growth verbs (handle, hold, improve, include, increase, inform, etc.)
