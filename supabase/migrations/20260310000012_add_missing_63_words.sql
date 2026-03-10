-- Add 63 Missing Essential GSL Words
-- Adds high-priority missing words with full linguistic data
-- Focus: Time, frequency, essential verbs/nouns, business vocabulary

-- Essential Time & Frequency Words
INSERT INTO lexicon_entries (headword, cefr_receptive, cefr_productive, pos, entry_type, is_published, ipa, definition_simple, definition_teacher, usage_notes, examples, collocations, patterns, register, variety)
VALUES
('tomorrow', 'A1', 'A1', 'adv', 'lemma', true, 'təˈmɒrəʊ', 'the day after today', 'Next day. Essential time vocabulary for scheduling.', 'Critical for business scheduling and planning. Used constantly in professional contexts.', '["See you tomorrow.", "Tomorrow''s meeting.", "Due tomorrow.", "Tomorrow morning."]'::jsonb, '["see you tomorrow", "tomorrow morning", "due tomorrow", "tomorrow''s meeting"]'::jsonb, '["See you tomorrow", "Tomorrow at..."]'::jsonb, 'neutral', 'international'),

('tonight', 'A1', 'A1', 'adv', 'lemma', true, 'təˈnaɪt', 'the night of today', 'This evening/night. Important for social and business scheduling.', 'Used for evening plans and events. Common in professional and social contexts.', '["Dinner tonight.", "Tonight''s presentation.", "See you tonight.", "Working late tonight."]'::jsonb, '["dinner tonight", "see you tonight", "tonight''s meeting", "working tonight"]'::jsonb, '["See you tonight", "Tonight at..."]'::jsonb, 'neutral', 'international'),

('again', 'A1', 'A1', 'adv', 'lemma', true, 'əˈɡen', 'one more time', 'Repetition adverb. Essential for instructions and requests.', 'Very common in professional contexts (try again, meet again, do again).', '["Try again.", "Meet again.", "Say that again.", "Again and again."]'::jsonb, '["try again", "meet again", "say again", "once again"]'::jsonb, '["Try again", "Once again"]'::jsonb, 'neutral', 'international'),

('however', 'A1', 'A1', 'adv', 'lemma', true, 'haʊˈevər', 'despite this', 'Contrast connector. Essential for professional writing and speaking.', 'Critical for business communication. Shows contrast or exception.', '["However, we need more time.", "The plan, however, changed.", "However difficult.", "However you want."]'::jsonb, '["however we", "however difficult", "however you", "however important"]'::jsonb, '["However, ...", "..., however, ..."]'::jsonb, 'formal', 'international'),

('while', 'A1', 'A1', 'conj', 'lemma', true, 'waɪl', 'during the time that', 'Temporal conjunction. Important for describing simultaneous actions.', 'Used in professional contexts to describe concurrent activities or contrast.', '["While working.", "While you wait.", "While I understand.", "A while ago."]'::jsonb, '["while working", "while you", "for a while", "a while ago"]'::jsonb, '["While...", "For a while"]'::jsonb, 'neutral', 'international'),

-- Essential Verbs
('understand', 'A1', 'A1', 'verb', 'lemma', true, 'ˌʌndərˈstænd', 'to know the meaning of something', 'Comprehension verb. Critical for communication and learning.', 'Essential in professional contexts. Used to confirm comprehension and agreement.', '["I understand.", "Do you understand?", "Easy to understand.", "Understand the problem."]'::jsonb, '["I understand", "do you understand", "easy to understand", "understand problem"]'::jsonb, '["I understand", "Do you understand?"]'::jsonb, 'neutral', 'international'),

('manage', 'A1', 'A1', 'verb', 'lemma', true, 'ˈmænɪdʒ', 'to be in charge of', 'Leadership verb. Essential business vocabulary.', 'Critical for business contexts. Used for leadership, control, and coping.', '["Manage a team.", "Manage the project.", "Can you manage?", "Manage expectations."]'::jsonb, '["manage team", "manage project", "can manage", "manage expectations"]'::jsonb, '["Manage a...", "Can you manage?"]'::jsonb, 'neutral', 'international'),

('create', 'A1', 'A1', 'verb', 'lemma', true, 'kriˈeɪt', 'to make something new', 'Production verb. Important for innovation and projects.', 'Common in business contexts (create value, create opportunities).', '["Create a document.", "Create value.", "Create opportunities.", "Create an account."]'::jsonb, '["create document", "create value", "create opportunities", "create account"]'::jsonb, '["Create a...", "Create new..."]'::jsonb, 'neutral', 'international'),

('discuss', 'A1', 'A1', 'verb', 'lemma', true, 'dɪˈskʌs', 'to talk about something', 'Communication verb. Essential for meetings and collaboration.', 'Very common in professional contexts. Used for meetings and conversations.', '["Discuss the plan.", "Let''s discuss.", "Discuss options.", "Discuss in detail."]'::jsonb, '["discuss plan", "let''s discuss", "discuss options", "discuss details"]'::jsonb, '["Let''s discuss...", "Discuss the..."]'::jsonb, 'neutral', 'international'),

('improve', 'A1', 'A1', 'verb', 'lemma', true, 'ɪmˈpruːv', 'to make better', 'Enhancement verb. Important for development and progress.', 'Common in business contexts (improve performance, improve quality).', '["Improve performance.", "Improve quality.", "Improve skills.", "Room to improve."]'::jsonb, '["improve performance", "improve quality", "improve skills", "room to improve"]'::jsonb, '["Improve...", "Room to improve"]'::jsonb, 'neutral', 'international'),

('check', 'A1', 'A1', 'verb', 'lemma', true, 'tʃek', 'to look at something to verify', 'Verification verb. Essential for quality control and confirmation.', 'Very common in professional contexts (check email, check status).', '["Check email.", "Check the status.", "Double check.", "Check in."]'::jsonb, '["check email", "check status", "double check", "check in"]'::jsonb, '["Check...", "Double check"]'::jsonb, 'neutral', 'international'),


('design', 'A1', 'A1', 'verb', 'lemma', true, 'dɪˈzaɪn', 'to plan how something will look or work', 'Planning/creation verb. Important for projects and products.', 'Common in business contexts (design thinking, design process).', '["Design a solution.", "Design thinking.", "By design.", "Design process."]'::jsonb, '["design solution", "design thinking", "by design", "design process"]'::jsonb, '["Design a...", "By design"]'::jsonb, 'neutral', 'international'),

('perform', 'A1', 'A1', 'verb', 'lemma', true, 'pərˈfɔːrm', 'to do an action or task', 'Execution verb. Essential for describing work and results.', 'Common in business contexts (perform well, perform tasks).', '["Perform well.", "Perform tasks.", "Perform analysis.", "High performing."]'::jsonb, '["perform well", "perform tasks", "perform analysis", "high performing"]'::jsonb, '["Perform...", "High performing"]'::jsonb, 'formal', 'international'),

('require', 'A1', 'A1', 'verb', 'lemma', true, 'rɪˈkwaɪər', 'to need something', 'Necessity verb. Important for requirements and specifications.', 'Common in formal business contexts (require approval, require attention).', '["Require approval.", "Require attention.", "As required.", "Required skills."]'::jsonb, '["require approval", "require attention", "as required", "required skills"]'::jsonb, '["Require...", "As required"]'::jsonb, 'formal', 'international'),

-- Essential Nouns
('meeting', 'A1', 'A1', 'noun', 'lemma', true, 'ˈmiːtɪŋ', 'a gathering of people for discussion', 'Business gathering. Essential professional vocabulary.', 'Critical for business contexts. Used constantly in professional settings.', '["Team meeting.", "Meeting room.", "Schedule a meeting.", "In a meeting."]'::jsonb, '["team meeting", "meeting room", "schedule meeting", "in meeting"]'::jsonb, '["Schedule a meeting", "In a meeting"]'::jsonb, 'neutral', 'international'),

('service', 'A1', 'A1', 'noun', 'lemma', true, 'ˈsɜːrvɪs', 'help or work provided', 'Assistance/provision. Essential business vocabulary.', 'Very common in business contexts (customer service, service industry).', '["Customer service.", "Service industry.", "Service quality.", "After-sales service."]'::jsonb, '["customer service", "service industry", "service quality", "after-sales service"]'::jsonb, '["Customer service", "Service quality"]'::jsonb, 'neutral', 'international'),

('department', 'A1', 'A1', 'noun', 'lemma', true, 'dɪˈpɑːrtmənt', 'a division of an organization', 'Organizational unit. Essential for company structure.', 'Common in business contexts (HR department, sales department).', '["HR department.", "Sales department.", "Department head.", "Department meeting."]'::jsonb, '["HR department", "sales department", "department head", "department meeting"]'::jsonb, '["... department", "Department head"]'::jsonb, 'neutral', 'international'),

('government', 'A1', 'A1', 'noun', 'lemma', true, 'ˈɡʌvərnmənt', 'the group that controls a country', 'National authority. Important for policy and regulations.', 'Used in business contexts (government regulations, government contracts).', '["Government regulations.", "Government contract.", "Government policy.", "Local government."]'::jsonb, '["government regulations", "government contract", "government policy", "local government"]'::jsonb, '["Government...", "Local government"]'::jsonb, 'formal', 'international'),

('industry', 'A1', 'A1', 'noun', 'lemma', true, 'ˈɪndəstri', 'economic activity or sector', 'Business sector. Essential for discussing markets and careers.', 'Common in business contexts (tech industry, service industry).', '["Tech industry.", "Service industry.", "Industry leader.", "Industry standards."]'::jsonb, '["tech industry", "service industry", "industry leader", "industry standards"]'::jsonb, '["... industry", "Industry leader"]'::jsonb, 'neutral', 'international'),

('attention', 'A1', 'A1', 'noun', 'lemma', true, 'əˈtenʃən', 'focus or notice', 'Mental focus. Important for communication and priorities.', 'Common in professional contexts (pay attention, attention to detail).', '["Pay attention.", "Attention to detail.", "Your attention please.", "Needs attention."]'::jsonb, '["pay attention", "attention to detail", "your attention", "needs attention"]'::jsonb, '["Pay attention", "Attention to..."]'::jsonb, 'neutral', 'international'),

('area', 'A1', 'A1', 'noun', 'lemma', true, 'ˈeəriə', 'a region or space', 'Space/region. Essential for locations and specializations.', 'Common in business contexts (work area, area of expertise).', '["Work area.", "Area of expertise.", "Local area.", "Problem area."]'::jsonb, '["work area", "area of expertise", "local area", "problem area"]'::jsonb, '["Work area", "Area of..."]'::jsonb, 'neutral', 'international'),

('period', 'A1', 'A1', 'noun', 'lemma', true, 'ˈpɪəriəd', 'a length of time', 'Time span. Important for schedules and planning.', 'Common in business contexts (trial period, time period).', '["Trial period.", "Time period.", "Period of time.", "Reporting period."]'::jsonb, '["trial period", "time period", "period of time", "reporting period"]'::jsonb, '["Trial period", "Period of..."]'::jsonb, 'neutral', 'international'),

('method', 'A1', 'A1', 'noun', 'lemma', true, 'ˈmeθəd', 'a way of doing something', 'Procedure/approach. Important for processes and systems.', 'Common in business contexts (payment method, method of working).', '["Payment method.", "Method of working.", "Best method.", "Teaching method."]'::jsonb, '["payment method", "method of working", "best method", "teaching method"]'::jsonb, '["Payment method", "Method of..."]'::jsonb, 'neutral', 'international'),

('policy', 'A1', 'A1', 'noun', 'lemma', true, 'ˈpɒləsi', 'a plan or rule', 'Organizational rule. Essential for compliance and procedures.', 'Common in business contexts (company policy, privacy policy).', '["Company policy.", "Privacy policy.", "Policy change.", "Return policy."]'::jsonb, '["company policy", "privacy policy", "policy change", "return policy"]'::jsonb, '["Company policy", "Policy on..."]'::jsonb, 'formal', 'international'),

('practice', 'A1', 'A1', 'noun', 'lemma', true, 'ˈpræktɪs', 'repeated exercise or custom', 'Exercise/custom. Important for learning and standards.', 'Common in business contexts (best practice, common practice).', '["Best practice.", "Common practice.", "Practice makes perfect.", "In practice."]'::jsonb, '["best practice", "common practice", "practice makes perfect", "in practice"]'::jsonb, '["Best practice", "In practice"]'::jsonb, 'neutral', 'international'),


-- Essential Adjectives & Descriptors
('important', 'A1', 'A1', 'adj', 'lemma', true, 'ɪmˈpɔːrtənt', 'having great value or significance', 'Significance adjective. Essential for priorities and emphasis.', 'Very common in professional contexts. Used to emphasize priority.', '["Very important.", "Important meeting.", "Important information.", "Most important."]'::jsonb, '["very important", "important meeting", "important information", "most important"]'::jsonb, '["Very important", "Most important"]'::jsonb, 'neutral', 'international'),

('different', 'A1', 'A1', 'adj', 'lemma', true, 'ˈdɪfrənt', 'not the same', 'Distinction adjective. Essential for comparisons.', 'Common in all contexts. Used for comparisons and variety.', '["Different approach.", "Different options.", "Something different.", "Different from."]'::jsonb, '["different approach", "different options", "something different", "different from"]'::jsonb, '["Different from...", "Something different"]'::jsonb, 'neutral', 'international'),

('available', 'A1', 'A1', 'adj', 'lemma', true, 'əˈveɪləbəl', 'able to be used or obtained', 'Accessibility adjective. Essential for resources and scheduling.', 'Very common in business contexts (available time, available resources).', '["Available time.", "Available resources.", "Not available.", "Available for."]'::jsonb, '["available time", "available resources", "not available", "available for"]'::jsonb, '["Available for...", "Not available"]'::jsonb, 'neutral', 'international'),

('quick', 'A1', 'A1', 'adj', 'lemma', true, 'kwɪk', 'fast', 'Speed adjective. Important for efficiency and urgency.', 'Common in business contexts (quick question, quick meeting).', '["Quick question.", "Quick meeting.", "Quick response.", "Quick and easy."]'::jsonb, '["quick question", "quick meeting", "quick response", "quick and easy"]'::jsonb, '["Quick question", "Quick and..."]'::jsonb, 'neutral', 'international'),

('final', 'A1', 'A1', 'adj', 'lemma', true, 'ˈfaɪnəl', 'last', 'Conclusive adjective. Important for deadlines and decisions.', 'Common in business contexts (final decision, final version).', '["Final decision.", "Final version.", "Final result.", "Final deadline."]'::jsonb, '["final decision", "final version", "final result", "final deadline"]'::jsonb, '["Final...", "Final decision"]'::jsonb, 'neutral', 'international'),

('social', 'A1', 'A1', 'adj', 'lemma', true, 'ˈsəʊʃəl', 'relating to society or interaction', 'Society-related adjective. Important for networking and culture.', 'Common in business contexts (social media, social skills).', '["Social media.", "Social skills.", "Social event.", "Social responsibility."]'::jsonb, '["social media", "social skills", "social event", "social responsibility"]'::jsonb, '["Social...", "Social media"]'::jsonb, 'neutral', 'international'),

('physical', 'A1', 'A1', 'adj', 'lemma', true, 'ˈfɪzɪkəl', 'relating to the body or material world', 'Material/bodily adjective. Important for health and tangible things.', 'Used in various contexts (physical office, physical health).', '["Physical office.", "Physical health.", "Physical presence.", "Physical product."]'::jsonb, '["physical office", "physical health", "physical presence", "physical product"]'::jsonb, '["Physical...", "Physical presence"]'::jsonb, 'neutral', 'international'),

('particular', 'A1', 'A1', 'adj', 'lemma', true, 'pərˈtɪkjələr', 'specific', 'Specificity adjective. Important for precision.', 'Common in formal contexts (in particular, particular attention).', '["In particular.", "Particular attention.", "Particular case.", "Nothing particular."]'::jsonb, '["in particular", "particular attention", "particular case", "nothing particular"]'::jsonb, '["In particular", "Particular attention"]'::jsonb, 'formal', 'international'),

-- Common Objects & Concepts
('coffee', 'A1', 'A1', 'noun', 'lemma', true, 'ˈkɒfi', 'a hot drink made from roasted beans', 'Beverage. Essential for social and business contexts.', 'Very common in professional contexts (coffee break, coffee meeting).', '["Coffee break.", "Coffee meeting.", "Cup of coffee.", "Coffee shop."]'::jsonb, '["coffee break", "coffee meeting", "cup of coffee", "coffee shop"]'::jsonb, '["Coffee break", "Cup of coffee"]'::jsonb, 'neutral', 'international'),

('tea', 'A1', 'A1', 'noun', 'lemma', true, 'tiː', 'a hot drink made from leaves', 'Beverage. Common in social and business contexts.', 'Used in professional contexts (tea break, afternoon tea).', '["Tea break.", "Cup of tea.", "Afternoon tea.", "Tea or coffee?"]'::jsonb, '["tea break", "cup of tea", "afternoon tea", "tea or coffee"]'::jsonb, '["Cup of tea", "Tea break"]'::jsonb, 'neutral', 'international'),

('hotel', 'A1', 'A1', 'noun', 'lemma', true, 'həʊˈtel', 'a place providing accommodation', 'Lodging establishment. Essential for business travel.', 'Common in business travel contexts (hotel booking, hotel room).', '["Hotel booking.", "Hotel room.", "Stay at hotel.", "Hotel reservation."]'::jsonb, '["hotel booking", "hotel room", "stay at hotel", "hotel reservation"]'::jsonb, '["Hotel booking", "Stay at hotel"]'::jsonb, 'neutral', 'international'),

('hospital', 'A1', 'A1', 'noun', 'lemma', true, 'ˈhɒspɪtəl', 'a place for medical treatment', 'Medical facility. Important for health and emergencies.', 'Used in health and emergency contexts.', '["Go to hospital.", "Hospital visit.", "Hospital appointment.", "In hospital."]'::jsonb, '["go to hospital", "hospital visit", "hospital appointment", "in hospital"]'::jsonb, '["Go to hospital", "In hospital"]'::jsonb, 'neutral', 'international'),

('park', 'A1', 'A1', 'noun', 'lemma', true, 'pɑːrk', 'a public green space', 'Outdoor space. Common for locations and recreation.', 'Used for locations and parking (car park, business park).', '["Car park.", "Business park.", "Park the car.", "In the park."]'::jsonb, '["car park", "business park", "park car", "in park"]'::jsonb, '["Car park", "Park the car"]'::jsonb, 'neutral', 'international'),

('key', 'A1', 'A1', 'noun', 'lemma', true, 'kiː', 'a device for opening locks', 'Opening device or important element. Essential vocabulary.', 'Used literally and figuratively (key point, key person).', '["Key point.", "Key person.", "Key to success.", "Key information."]'::jsonb, '["key point", "key person", "key to", "key information"]'::jsonb, '["Key point", "Key to..."]'::jsonb, 'neutral', 'international'),

('list', 'A1', 'A1', 'noun', 'lemma', true, 'lɪst', 'a series of items written down', 'Itemized record. Essential for organization.', 'Very common in business contexts (to-do list, price list).', '["To-do list.", "Price list.", "Make a list.", "On the list."]'::jsonb, '["to-do list", "price list", "make list", "on list"]'::jsonb, '["Make a list", "On the list"]'::jsonb, 'neutral', 'international'),

('card', 'A1', 'A1', 'noun', 'lemma', true, 'kɑːrd', 'a piece of stiff paper', 'Paper item or payment method. Essential for business.', 'Common in business contexts (business card, credit card).', '["Business card.", "Credit card.", "ID card.", "Card payment."]'::jsonb, '["business card", "credit card", "ID card", "card payment"]'::jsonb, '["Business card", "Credit card"]'::jsonb, 'neutral', 'international'),


-- More Essential Words
('question', 'A1', 'A1', 'noun', 'lemma', true, 'ˈkwestʃən', 'a sentence asking for information', 'Inquiry. Essential for communication and meetings.', 'Very common in professional contexts (ask a question, good question).', '["Ask a question.", "Good question.", "Question and answer.", "Any questions?"]'::jsonb, '["ask question", "good question", "question and answer", "any questions"]'::jsonb, '["Ask a question", "Any questions?"]'::jsonb, 'neutral', 'international'),

('choice', 'A1', 'A1', 'noun', 'lemma', true, 'tʃɔɪs', 'an act of selecting', 'Selection. Important for decisions and options.', 'Common in business contexts (good choice, choice of).', '["Good choice.", "Choice of options.", "Make a choice.", "No choice."]'::jsonb, '["good choice", "choice of", "make choice", "no choice"]'::jsonb, '["Make a choice", "Good choice"]'::jsonb, 'neutral', 'international'),

('couple', 'A1', 'A1', 'noun', 'lemma', true, 'ˈkʌpəl', 'two people or things', 'Pair or small number. Common in informal business contexts.', 'Used for approximate small numbers (a couple of days, a couple of minutes).', '["A couple of days.", "A couple of minutes.", "A couple of things.", "Couple of questions."]'::jsonb, '["couple of days", "couple of minutes", "couple of things", "couple of questions"]'::jsonb, '["A couple of...", "Couple of..."]'::jsonb, 'informal', 'international'),

('community', 'A1', 'A1', 'noun', 'lemma', true, 'kəˈmjuːnəti', 'a group of people living together', 'Social group. Important for social responsibility and networking.', 'Common in business contexts (community engagement, business community).', '["Business community.", "Community engagement.", "Local community.", "Community support."]'::jsonb, '["business community", "community engagement", "local community", "community support"]'::jsonb, '["Business community", "Local community"]'::jsonb, 'neutral', 'international'),

('standard', 'A1', 'A1', 'noun', 'lemma', true, 'ˈstændərd', 'a level of quality', 'Quality benchmark. Essential for quality control.', 'Very common in business contexts (industry standard, high standard).', '["Industry standard.", "High standard.", "Standard practice.", "Quality standards."]'::jsonb, '["industry standard", "high standard", "standard practice", "quality standards"]'::jsonb, '["Industry standard", "High standard"]'::jsonb, 'neutral', 'international'),

('pattern', 'A1', 'A1', 'noun', 'lemma', true, 'ˈpætərn', 'a repeated design or sequence', 'Repeated form. Important for analysis and design.', 'Common in business contexts (behavior pattern, pattern of).', '["Behavior pattern.", "Pattern of growth.", "Design pattern.", "Pattern recognition."]'::jsonb, '["behavior pattern", "pattern of", "design pattern", "pattern recognition"]'::jsonb, '["Pattern of...", "Behavior pattern"]'::jsonb, 'neutral', 'international'),

('section', 'A1', 'A1', 'noun', 'lemma', true, 'ˈsekʃən', 'a part of something', 'Division/part. Essential for organization and structure.', 'Common in business contexts (section of report, section manager).', '["Section of report.", "Section manager.", "This section.", "Section by section."]'::jsonb, '["section of", "section manager", "this section", "section by section"]'::jsonb, '["Section of...", "This section"]'::jsonb, 'neutral', 'international'),

('unit', 'A1', 'A1', 'noun', 'lemma', true, 'ˈjuːnɪt', 'a single thing or group', 'Individual element or team. Important for organization.', 'Common in business contexts (business unit, unit cost).', '["Business unit.", "Unit cost.", "Unit price.", "Per unit."]'::jsonb, '["business unit", "unit cost", "unit price", "per unit"]'::jsonb, '["Business unit", "Per unit"]'::jsonb, 'neutral', 'international'),

-- Prepositions & Connectors
('above', 'A1', 'A1', 'prep', 'lemma', true, 'əˈbʌv', 'higher than', 'Position preposition. Important for comparisons and hierarchy.', 'Used for physical position and comparisons (above average, above all).', '["Above average.", "Above all.", "Above expectations.", "As mentioned above."]'::jsonb, '["above average", "above all", "above expectations", "mentioned above"]'::jsonb, '["Above average", "Above all"]'::jsonb, 'neutral', 'international'),

('against', 'A1', 'A1', 'prep', 'lemma', true, 'əˈɡenst', 'in opposition to', 'Opposition preposition. Important for conflicts and comparisons.', 'Used for opposition and comparison (against the rules, against expectations).', '["Against the rules.", "Against expectations.", "Against the law.", "Against time."]'::jsonb, '["against rules", "against expectations", "against law", "against time"]'::jsonb, '["Against the...", "Against expectations"]'::jsonb, 'neutral', 'international'),

-- More Essential Nouns
('age', 'A1', 'A1', 'noun', 'lemma', true, 'eɪdʒ', 'the number of years someone has lived', 'Years lived. Essential for demographics and descriptions.', 'Used in various contexts (age group, age limit, at the age of).', '["Age group.", "Age limit.", "At the age of.", "What age?"]'::jsonb, '["age group", "age limit", "at age of", "what age"]'::jsonb, '["Age group", "At the age of"]'::jsonb, 'neutral', 'international'),

('news', 'A1', 'A1', 'noun', 'lemma', true, 'njuːz', 'information about recent events', 'Current information. Important for updates and communication.', 'Common in business contexts (good news, latest news).', '["Good news.", "Latest news.", "News update.", "In the news."]'::jsonb, '["good news", "latest news", "news update", "in news"]'::jsonb, '["Good news", "Latest news"]'::jsonb, 'neutral', 'international'),

('parent', 'A1', 'A1', 'noun', 'lemma', true, 'ˈpeərənt', 'a mother or father', 'Mother/father. Important for family discussions.', 'Used in personal and HR contexts (parent company, parental leave).', '["Parent company.", "Parental leave.", "My parents.", "Single parent."]'::jsonb, '["parent company", "parental leave", "my parents", "single parent"]'::jsonb, '["Parent company", "My parents"]'::jsonb, 'neutral', 'international'),

('pair', 'A1', 'A1', 'noun', 'lemma', true, 'peər', 'two things used together', 'Two items. Common for objects and partnerships.', 'Used for matched items (pair of shoes, pair of glasses).', '["Pair of shoes.", "Pair of glasses.", "Work in pairs.", "A pair of."]'::jsonb, '["pair of shoes", "pair of glasses", "work in pairs", "a pair of"]'::jsonb, '["A pair of...", "Work in pairs"]'::jsonb, 'neutral', 'international'),

('path', 'A1', 'A1', 'noun', 'lemma', true, 'pɑːθ', 'a way or track', 'Route or course. Important for directions and career.', 'Used literally and figuratively (career path, path forward).', '["Career path.", "Path forward.", "On the right path.", "Path to success."]'::jsonb, '["career path", "path forward", "right path", "path to"]'::jsonb, '["Career path", "Path to..."]'::jsonb, 'neutral', 'international'),

('range', 'A1', 'A1', 'noun', 'lemma', true, 'reɪndʒ', 'a variety or extent', 'Variety/scope. Important for options and capabilities.', 'Common in business contexts (wide range, price range).', '["Wide range.", "Price range.", "Range of options.", "In range."]'::jsonb, '["wide range", "price range", "range of", "in range"]'::jsonb, '["Wide range", "Range of..."]'::jsonb, 'neutral', 'international'),

('region', 'A1', 'A1', 'noun', 'lemma', true, 'ˈriːdʒən', 'an area of a country or world', 'Geographic area. Important for business territories.', 'Common in business contexts (regional manager, region office).', '["Regional manager.", "Region office.", "In the region.", "Region-specific."]'::jsonb, '["regional manager", "region office", "in region", "region-specific"]'::jsonb, '["Regional...", "In the region"]'::jsonb, 'neutral', 'international'),


-- Final Essential Words
('pressure', 'A1', 'A1', 'noun', 'lemma', true, 'ˈpreʃər', 'force or stress', 'Force/stress. Important for work conditions and urgency.', 'Common in business contexts (under pressure, time pressure).', '["Under pressure.", "Time pressure.", "Pressure to perform.", "High pressure."]'::jsonb, '["under pressure", "time pressure", "pressure to", "high pressure"]'::jsonb, '["Under pressure", "Time pressure"]'::jsonb, 'neutral', 'international'),

('property', 'A1', 'A1', 'noun', 'lemma', true, 'ˈprɒpərti', 'a building or land', 'Real estate or characteristic. Important for business and assets.', 'Used in business contexts (property management, intellectual property).', '["Property management.", "Intellectual property.", "Property rights.", "Commercial property."]'::jsonb, '["property management", "intellectual property", "property rights", "commercial property"]'::jsonb, '["Property management", "Intellectual property"]'::jsonb, 'formal', 'international'),

('sale', 'A1', 'A1', 'noun', 'lemma', true, 'seɪl', 'the act of selling', 'Selling transaction. Essential for commerce.', 'Very common in business contexts (for sale, sales team).', '["For sale.", "Sales team.", "Sale price.", "On sale."]'::jsonb, '["for sale", "sales team", "sale price", "on sale"]'::jsonb, '["For sale", "On sale"]'::jsonb, 'neutral', 'international'),

('tax', 'A1', 'A1', 'noun', 'lemma', true, 'tæks', 'money paid to government', 'Government levy. Essential for finance.', 'Common in business contexts (income tax, tax rate).', '["Income tax.", "Tax rate.", "Before tax.", "Tax deduction."]'::jsonb, '["income tax", "tax rate", "before tax", "tax deduction"]'::jsonb, '["Income tax", "Before tax"]'::jsonb, 'neutral', 'international'),

('title', 'A1', 'A1', 'noun', 'lemma', true, 'ˈtaɪtəl', 'a name or position', 'Name/position. Important for roles and documents.', 'Common in business contexts (job title, title of document).', '["Job title.", "Title of document.", "Professional title.", "Title page."]'::jsonb, '["job title", "title of", "professional title", "title page"]'::jsonb, '["Job title", "Title of..."]'::jsonb, 'neutral', 'international'),

('wage', 'A1', 'A1', 'noun', 'lemma', true, 'weɪdʒ', 'payment for work', 'Salary/payment. Essential for employment.', 'Common in employment contexts (minimum wage, hourly wage).', '["Minimum wage.", "Hourly wage.", "Wage increase.", "Living wage."]'::jsonb, '["minimum wage", "hourly wage", "wage increase", "living wage"]'::jsonb, '["Minimum wage", "Hourly wage"]'::jsonb, 'neutral', 'international'),

-- More Adjectives
('correct', 'A1', 'A1', 'adj', 'lemma', true, 'kəˈrekt', 'right or accurate', 'Accuracy adjective. Important for verification.', 'Common in professional contexts (correct answer, correct information).', '["Correct answer.", "Correct information.", "Is that correct?", "Correct me if wrong."]'::jsonb, '["correct answer", "correct information", "is correct", "correct me"]'::jsonb, '["Is that correct?", "Correct answer"]'::jsonb, 'neutral', 'international'),

('exact', 'A1', 'A1', 'adj', 'lemma', true, 'ɪɡˈzækt', 'precise', 'Precision adjective. Important for accuracy.', 'Common in professional contexts (exact time, exact amount).', '["Exact time.", "Exact amount.", "Exact details.", "To be exact."]'::jsonb, '["exact time", "exact amount", "exact details", "to be exact"]'::jsonb, '["Exact time", "To be exact"]'::jsonb, 'neutral', 'international'),

('fresh', 'A1', 'A1', 'adj', 'lemma', true, 'freʃ', 'new or recently made', 'Newness adjective. Important for quality and ideas.', 'Used for food quality and new ideas (fresh perspective, fresh start).', '["Fresh perspective.", "Fresh start.", "Fresh ideas.", "Fresh approach."]'::jsonb, '["fresh perspective", "fresh start", "fresh ideas", "fresh approach"]'::jsonb, '["Fresh perspective", "Fresh start"]'::jsonb, 'neutral', 'international'),

('similar', 'A1', 'A1', 'adj', 'lemma', true, 'ˈsɪmələr', 'alike but not the same', 'Likeness adjective. Important for comparisons.', 'Common in professional contexts (similar to, similar situation).', '["Similar to.", "Similar situation.", "Similar experience.", "Very similar."]'::jsonb, '["similar to", "similar situation", "similar experience", "very similar"]'::jsonb, '["Similar to...", "Very similar"]'::jsonb, 'neutral', 'international'),

('true', 'A1', 'A1', 'adj', 'lemma', true, 'truː', 'accurate or genuine', 'Truthfulness adjective. Important for verification.', 'Common in professional contexts (true or false, come true).', '["True or false.", "Come true.", "True story.", "Is it true?"]'::jsonb, '["true or false", "come true", "true story", "is true"]'::jsonb, '["True or false", "Is it true?"]'::jsonb, 'neutral', 'international'),

('warm', 'A1', 'A1', 'adj', 'lemma', true, 'wɔːrm', 'moderately hot', 'Temperature adjective. Important for comfort and atmosphere.', 'Used for temperature and atmosphere (warm welcome, warm regards).', '["Warm welcome.", "Warm regards.", "Warm weather.", "Keep warm."]'::jsonb, '["warm welcome", "warm regards", "warm weather", "keep warm"]'::jsonb, '["Warm welcome", "Warm regards"]'::jsonb, 'neutral', 'international'),

('wet', 'A1', 'A1', 'adj', 'lemma', true, 'wet', 'covered with water', 'Moisture adjective. Important for weather and conditions.', 'Used for weather and conditions (wet weather, wet paint).', '["Wet weather.", "Wet paint.", "Get wet.", "Wet season."]'::jsonb, '["wet weather", "wet paint", "get wet", "wet season"]'::jsonb, '["Wet weather", "Wet paint"]'::jsonb, 'neutral', 'international'),

('wrong', 'A1', 'A1', 'adj', 'lemma', true, 'rɒŋ', 'not correct', 'Incorrectness adjective. Important for corrections.', 'Common in professional contexts (wrong answer, something wrong).', '["Wrong answer.", "Something wrong.", "Wrong number.", "Prove wrong."]'::jsonb, '["wrong answer", "something wrong", "wrong number", "prove wrong"]'::jsonb, '["Wrong answer", "Something wrong"]'::jsonb, 'neutral', 'international');

-- Verification notice
DO $$
DECLARE
  word_count INTEGER;
BEGIN
  SELECT COUNT(*) INTO word_count FROM lexicon_entries;
  RAISE NOTICE '✅ Added 63 missing essential GSL words';
  RAISE NOTICE '📊 Total vocabulary entries now: %', word_count;
  RAISE NOTICE '🎯 Target: 1000 words';
END $$;
