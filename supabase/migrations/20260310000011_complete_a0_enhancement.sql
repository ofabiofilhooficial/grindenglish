-- Complete A0 Vocabulary Enhancement
-- Enhances remaining 48 A0 words with full linguistic data
-- Focus: Family, body parts, common objects, basic adjectives

-- Family Members
UPDATE lexicon_entries
SET
  ipa = 'ˈfɑːðər',
  definition_simple = 'a male parent',
  definition_teacher = 'Male parent. Essential family vocabulary for A0 learners.',
  usage_notes = 'Used in professional contexts when discussing family or parental leave. Common in introductions.',
  examples = '["My father works in sales.", "I need to call my father.", "Her father is a teacher.", "Our father lives in São Paulo."]'::jsonb,
  collocations = '["my father", "your father", "father and mother", "father''s name"]'::jsonb,
  patterns = '["My father is...", "I live with my father"]'::jsonb,
  register = 'neutral',
  variety = 'international'
WHERE headword = 'father';

UPDATE lexicon_entries
SET
  ipa = 'ˈmʌðər',
  definition_simple = 'a female parent',
  definition_teacher = 'Female parent. Essential family vocabulary for A0 learners.',
  usage_notes = 'Used in professional contexts when discussing family or parental leave. Common in introductions.',
  examples = '["My mother is a doctor.", "I help my mother.", "Her mother works here.", "Our mother speaks English."]'::jsonb,
  collocations = '["my mother", "your mother", "mother and father", "mother''s name"]'::jsonb,
  patterns = '["My mother is...", "I live with my mother"]'::jsonb,
  register = 'neutral',
  variety = 'international'
WHERE headword = 'mother';

UPDATE lexicon_entries
SET
  ipa = 'ˈbrʌðər',
  definition_simple = 'a male sibling',
  definition_teacher = 'Male sibling. Important family vocabulary for A0 learners.',
  usage_notes = 'Used when introducing family members or discussing family structure.',
  examples = '["I have one brother.", "My brother is 25 years old.", "Her brother works in IT.", "Do you have a brother?"]'::jsonb,
  collocations = '["my brother", "older brother", "younger brother", "brother and sister"]'::jsonb,
  patterns = '["I have a brother", "My brother is..."]'::jsonb,
  register = 'neutral',
  variety = 'international'
WHERE headword = 'brother';

UPDATE lexicon_entries
SET
  ipa = 'ˈsɪstər',
  definition_simple = 'a female sibling',
  definition_teacher = 'Female sibling. Important family vocabulary for A0 learners.',
  usage_notes = 'Used when introducing family members or discussing family structure.',
  examples = '["I have two sisters.", "My sister is a student.", "Her sister lives in Rio.", "Do you have a sister?"]'::jsonb,
  collocations = '["my sister", "older sister", "younger sister", "brother and sister"]'::jsonb,
  patterns = '["I have a sister", "My sister is..."]'::jsonb,
  register = 'neutral',
  variety = 'international'
WHERE headword = 'sister';


UPDATE lexicon_entries
SET
  ipa = 'bɔɪ',
  definition_simple = 'a male child',
  definition_teacher = 'Male child. Basic vocabulary for describing people.',
  usage_notes = 'Used to describe male children. Common in educational and family contexts.',
  examples = '["The boy is 10 years old.", "A boy from my class.", "That boy is my student.", "The boys are playing."]'::jsonb,
  collocations = '["young boy", "little boy", "school boy", "the boy"]'::jsonb,
  patterns = '["The boy is...", "A boy who..."]'::jsonb,
  register = 'neutral',
  variety = 'international'
WHERE headword = 'boy';

UPDATE lexicon_entries
SET
  ipa = 'ɡɜːrl',
  definition_simple = 'a female child',
  definition_teacher = 'Female child. Basic vocabulary for describing people.',
  usage_notes = 'Used to describe female children. Common in educational and family contexts.',
  examples = '["The girl is 8 years old.", "A girl from my class.", "That girl is my student.", "The girls are studying."]'::jsonb,
  collocations = '["young girl", "little girl", "school girl", "the girl"]'::jsonb,
  patterns = '["The girl is...", "A girl who..."]'::jsonb,
  register = 'neutral',
  variety = 'international'
WHERE headword = 'girl';

UPDATE lexicon_entries
SET
  ipa = 'tʃaɪld',
  definition_simple = 'a young person',
  definition_teacher = 'Young person, boy or girl. Essential for discussing family and education.',
  usage_notes = 'Gender-neutral term for young people. Used in professional and educational contexts.',
  examples = '["I have one child.", "The child is learning English.", "Every child needs education.", "Children learn quickly."]'::jsonb,
  collocations = '["young child", "my child", "every child", "the children"]'::jsonb,
  patterns = '["The child is...", "I have... children"]'::jsonb,
  register = 'neutral',
  variety = 'international'
WHERE headword = 'child';

UPDATE lexicon_entries
SET
  ipa = 'mæn',
  definition_simple = 'an adult male person',
  definition_teacher = 'Adult male. Basic vocabulary for describing people.',
  usage_notes = 'Used to describe adult males. Common in all contexts.',
  examples = '["The man is my manager.", "A man from the office.", "That man is a teacher.", "The men are in a meeting."]'::jsonb,
  collocations = '["young man", "old man", "business man", "the man"]'::jsonb,
  patterns = '["The man is...", "A man who..."]'::jsonb,
  register = 'neutral',
  variety = 'international'
WHERE headword = 'man';

UPDATE lexicon_entries
SET
  ipa = 'ˈwʊmən',
  definition_simple = 'an adult female person',
  definition_teacher = 'Adult female. Basic vocabulary for describing people.',
  usage_notes = 'Used to describe adult females. Common in all contexts.',
  examples = '["The woman is my colleague.", "A woman from HR.", "That woman is a director.", "The women are presenting."]'::jsonb,
  collocations = '["young woman", "business woman", "the woman", "women in business"]'::jsonb,
  patterns = '["The woman is...", "A woman who..."]'::jsonb,
  register = 'neutral',
  variety = 'international'
WHERE headword = 'woman';

UPDATE lexicon_entries
SET
  ipa = 'ˈpiːpəl',
  definition_simple = 'more than one person',
  definition_teacher = 'Plural of person. Essential for discussing groups.',
  usage_notes = 'Always plural. Used to discuss groups in professional and social contexts.',
  examples = '["Many people work here.", "People are waiting.", "Some people speak English.", "The people in my team."]'::jsonb,
  collocations = '["many people", "some people", "people are", "people who"]'::jsonb,
  patterns = '["People are...", "Many people..."]'::jsonb,
  register = 'neutral',
  variety = 'international'
WHERE headword = 'people';

UPDATE lexicon_entries
SET
  ipa = 'ˈpɜːrsən',
  definition_simple = 'one human being',
  definition_teacher = 'Individual human. Singular form, plural is people.',
  usage_notes = 'Singular form. Used in professional contexts to refer to individuals.',
  examples = '["One person is missing.", "Each person has a desk.", "The person in charge.", "A person from accounting."]'::jsonb,
  collocations = '["one person", "each person", "the person", "a person who"]'::jsonb,
  patterns = '["The person is...", "A person who..."]'::jsonb,
  register = 'neutral',
  variety = 'international'
WHERE headword = 'person';

UPDATE lexicon_entries
SET
  ipa = 'ˈfæməli',
  definition_simple = 'parents and children',
  definition_teacher = 'Group of related people. Essential vocabulary for personal introductions.',
  usage_notes = 'Used when discussing personal life, work-life balance, and benefits.',
  examples = '["My family lives in Brazil.", "I have a small family.", "Family is important.", "Our family business."]'::jsonb,
  collocations = '["my family", "family members", "family business", "family time"]'::jsonb,
  patterns = '["My family is...", "I have a... family"]'::jsonb,
  register = 'neutral',
  variety = 'international'
WHERE headword = 'family';

UPDATE lexicon_entries
SET
  ipa = 'frend',
  definition_simple = 'a person you like and know well',
  definition_teacher = 'Person you have a friendly relationship with. Important for social contexts.',
  usage_notes = 'Used in both personal and professional networking contexts.',
  examples = '["She is my friend.", "I have many friends here.", "A friend from work.", "Friends help each other."]'::jsonb,
  collocations = '["my friend", "good friend", "close friend", "friend from"]'::jsonb,
  patterns = '["My friend is...", "A friend who..."]'::jsonb,
  register = 'neutral',
  variety = 'international'
WHERE headword = 'friend';


-- Body Parts
UPDATE lexicon_entries
SET
  ipa = 'aɪ',
  definition_simple = 'the part of the body used for seeing',
  definition_teacher = 'Organ of sight. Basic body vocabulary.',
  usage_notes = 'Used in health contexts and descriptions. Plural: eyes.',
  examples = '["My eyes are brown.", "Close your eyes.", "Eye contact is important.", "I have something in my eye."]'::jsonb,
  collocations = '["my eyes", "blue eyes", "eye contact", "eyes are"]'::jsonb,
  patterns = '["My eyes are...", "I have... eyes"]'::jsonb,
  register = 'neutral',
  variety = 'international'
WHERE headword = 'eye';

UPDATE lexicon_entries
SET
  ipa = 'hænd',
  definition_simple = 'the part of the body at the end of the arm',
  definition_teacher = 'Body part used for holding and touching. Essential vocabulary.',
  usage_notes = 'Used in professional contexts (handshake, raise your hand) and descriptions.',
  examples = '["Wash your hands.", "Raise your hand.", "Shake hands.", "I write with my right hand."]'::jsonb,
  collocations = '["my hand", "right hand", "left hand", "shake hands"]'::jsonb,
  patterns = '["Raise your hand", "With my hand"]'::jsonb,
  register = 'neutral',
  variety = 'international'
WHERE headword = 'hand';

UPDATE lexicon_entries
SET
  ipa = 'hed',
  definition_simple = 'the part of the body above the neck',
  definition_teacher = 'Top part of body containing brain, eyes, nose, mouth. Basic body vocabulary.',
  usage_notes = 'Used in health contexts and physical descriptions.',
  examples = '["My head hurts.", "Nod your head.", "Head of department.", "From head to toe."]'::jsonb,
  collocations = '["my head", "head hurts", "head of", "shake head"]'::jsonb,
  patterns = '["My head...", "Head of..."]'::jsonb,
  register = 'neutral',
  variety = 'international'
WHERE headword = 'head';

-- Common Objects & Places
UPDATE lexicon_entries
SET
  ipa = 'haʊs',
  definition_simple = 'a building where people live',
  definition_teacher = 'Residential building. Essential vocabulary for discussing living situations.',
  usage_notes = 'Used when discussing housing, real estate, and living arrangements.',
  examples = '["I live in a house.", "My house has three bedrooms.", "House prices are high.", "A house near the office."]'::jsonb,
  collocations = '["my house", "new house", "house prices", "at house"]'::jsonb,
  patterns = '["I live in a house", "My house is..."]'::jsonb,
  register = 'neutral',
  variety = 'international'
WHERE headword = 'house';

UPDATE lexicon_entries
SET
  ipa = 'həʊm',
  definition_simple = 'the place where you live',
  definition_teacher = 'Place of residence. Can be house, apartment, etc. Important for work-life discussions.',
  usage_notes = 'Used in professional contexts (work from home, go home). More personal than "house".',
  examples = '["I work from home.", "Go home early.", "Home office setup.", "My home is in São Paulo."]'::jsonb,
  collocations = '["at home", "go home", "home office", "work from home"]'::jsonb,
  patterns = '["I work from home", "Go home"]'::jsonb,
  register = 'neutral',
  variety = 'international'
WHERE headword = 'home';

UPDATE lexicon_entries
SET
  ipa = 'ruːm',
  definition_simple = 'a part of a building with walls and a door',
  definition_teacher = 'Enclosed space within a building. Essential for discussing office layouts and meetings.',
  usage_notes = 'Used in professional contexts (meeting room, conference room, room number).',
  examples = '["The meeting room is ready.", "Room 305.", "A room with a view.", "Book a room for the presentation."]'::jsonb,
  collocations = '["meeting room", "conference room", "room number", "book a room"]'::jsonb,
  patterns = '["The room is...", "In room..."]'::jsonb,
  register = 'neutral',
  variety = 'international'
WHERE headword = 'room';

UPDATE lexicon_entries
SET
  ipa = 'dɔːr',
  definition_simple = 'a movable barrier used to close an entrance',
  definition_teacher = 'Entrance/exit barrier. Basic vocabulary for giving directions and describing spaces.',
  usage_notes = 'Used in directions and safety instructions.',
  examples = '["Close the door.", "The door is open.", "Next door.", "Door to door service."]'::jsonb,
  collocations = '["close door", "open door", "front door", "next door"]'::jsonb,
  patterns = '["Close the door", "The door is..."]'::jsonb,
  register = 'neutral',
  variety = 'international'
WHERE headword = 'door';

UPDATE lexicon_entries
SET
  ipa = 'ˈwɪndəʊ',
  definition_simple = 'an opening in a wall with glass',
  definition_teacher = 'Glass opening for light and air. Basic vocabulary for describing spaces.',
  usage_notes = 'Used when describing office spaces and giving directions.',
  examples = '["Open the window.", "A window seat.", "Window shopping.", "The window is broken."]'::jsonb,
  collocations = '["open window", "close window", "window seat", "by the window"]'::jsonb,
  patterns = '["Open the window", "By the window"]'::jsonb,
  register = 'neutral',
  variety = 'international'
WHERE headword = 'window';

UPDATE lexicon_entries
SET
  ipa = 'ˈteɪbəl',
  definition_simple = 'a piece of furniture with a flat top',
  definition_teacher = 'Furniture for working, eating, or placing objects. Essential office vocabulary.',
  usage_notes = 'Used in office contexts (conference table, desk) and dining.',
  examples = '["Sit at the table.", "Conference table.", "Table for six.", "On the table."]'::jsonb,
  collocations = '["conference table", "at the table", "on the table", "table for"]'::jsonb,
  patterns = '["At the table", "On the table"]'::jsonb,
  register = 'neutral',
  variety = 'international'
WHERE headword = 'table';

UPDATE lexicon_entries
SET
  ipa = 'tʃeər',
  definition_simple = 'a seat with a back for one person',
  definition_teacher = 'Seating furniture. Essential office vocabulary.',
  usage_notes = 'Used in office contexts (office chair, take a chair).',
  examples = '["Take a chair.", "Office chair.", "Chair the meeting.", "Pull up a chair."]'::jsonb,
  collocations = '["office chair", "take a chair", "empty chair", "chair the meeting"]'::jsonb,
  patterns = '["Take a chair", "Sit in the chair"]'::jsonb,
  register = 'neutral',
  variety = 'international'
WHERE headword = 'chair';

UPDATE lexicon_entries
SET
  ipa = 'bed',
  definition_simple = 'a piece of furniture for sleeping',
  definition_teacher = 'Sleeping furniture. Basic vocabulary for discussing accommodations and health.',
  usage_notes = 'Used when discussing hotel rooms, health (bed rest), and daily routines.',
  examples = '["Go to bed early.", "Make the bed.", "Bed and breakfast.", "Stay in bed."]'::jsonb,
  collocations = '["go to bed", "in bed", "make the bed", "bed rest"]'::jsonb,
  patterns = '["Go to bed", "In bed"]'::jsonb,
  register = 'neutral',
  variety = 'international'
WHERE headword = 'bed';


-- Food & Drink
UPDATE lexicon_entries
SET
  ipa = 'fuːd',
  definition_simple = 'things that people eat',
  definition_teacher = 'Edible substances. Essential vocabulary for daily life and business meals.',
  usage_notes = 'Used in professional contexts (food service, food industry) and daily conversations.',
  examples = '["The food is good.", "Food and drinks.", "Food industry.", "Order food online."]'::jsonb,
  collocations = '["good food", "food and drinks", "food service", "order food"]'::jsonb,
  patterns = '["The food is...", "Food and..."]'::jsonb,
  register = 'neutral',
  variety = 'international'
WHERE headword = 'food';

UPDATE lexicon_entries
SET
  ipa = 'ˈwɔːtər',
  definition_simple = 'the clear liquid that falls as rain',
  definition_teacher = 'H2O. Essential vocabulary for basic needs and services.',
  usage_notes = 'Used in all contexts. Important for hospitality and basic needs.',
  examples = '["Drink water.", "A glass of water.", "Water service.", "Hot and cold water."]'::jsonb,
  collocations = '["drink water", "glass of water", "hot water", "cold water"]'::jsonb,
  patterns = '["Drink water", "A glass of water"]'::jsonb,
  register = 'neutral',
  variety = 'international'
WHERE headword = 'water';

UPDATE lexicon_entries
SET
  ipa = 'bred',
  definition_simple = 'food made from flour and water',
  definition_teacher = 'Baked food staple. Basic food vocabulary.',
  usage_notes = 'Used in food service and daily meals. Common in breakfast contexts.',
  examples = '["Bread and butter.", "A piece of bread.", "Fresh bread.", "Bread basket."]'::jsonb,
  collocations = '["fresh bread", "piece of bread", "bread and butter", "bread basket"]'::jsonb,
  patterns = '["A piece of bread", "Bread and..."]'::jsonb,
  register = 'neutral',
  variety = 'international'
WHERE headword = 'bread';

-- Places
UPDATE lexicon_entries
SET
  ipa = 'skuːl',
  definition_simple = 'a place where children learn',
  definition_teacher = 'Educational institution. Essential for discussing education and background.',
  usage_notes = 'Used when discussing education, training, and professional development.',
  examples = '["I went to school in Brazil.", "Business school.", "School of thought.", "After school program."]'::jsonb,
  collocations = '["go to school", "at school", "business school", "school system"]'::jsonb,
  patterns = '["Go to school", "At school"]'::jsonb,
  register = 'neutral',
  variety = 'international'
WHERE headword = 'school';

UPDATE lexicon_entries
SET
  ipa = 'ʃɒp',
  definition_simple = 'a place where you buy things',
  definition_teacher = 'Retail establishment. Essential vocabulary for commerce and daily life.',
  usage_notes = 'Used in retail and commerce contexts. Can be verb (go shopping) or noun.',
  examples = '["Go to the shop.", "Coffee shop.", "Shop online.", "Shop assistant."]'::jsonb,
  collocations = '["go to shop", "coffee shop", "shop online", "shop assistant"]'::jsonb,
  patterns = '["Go to the shop", "Shop for..."]'::jsonb,
  register = 'neutral',
  variety = 'international'
WHERE headword = 'shop';

UPDATE lexicon_entries
SET
  ipa = 'striːt',
  definition_simple = 'a road in a city with buildings',
  definition_teacher = 'Urban road. Essential for giving addresses and directions.',
  usage_notes = 'Used in addresses, directions, and location descriptions.',
  examples = '["Main Street.", "Street address.", "Cross the street.", "Street level."]'::jsonb,
  collocations = '["main street", "street address", "cross street", "street level"]'::jsonb,
  patterns = '["On... Street", "Cross the street"]'::jsonb,
  register = 'neutral',
  variety = 'international'
WHERE headword = 'street';

UPDATE lexicon_entries
SET
  ipa = 'ˈsɪti',
  definition_simple = 'a large town',
  definition_teacher = 'Large urban area. Essential for discussing locations and business.',
  usage_notes = 'Used in business contexts (city center, city office) and geography.',
  examples = '["I live in the city.", "City center.", "New York City.", "City office."]'::jsonb,
  collocations = '["city center", "in the city", "city office", "city life"]'::jsonb,
  patterns = '["In the city", "City center"]'::jsonb,
  register = 'neutral',
  variety = 'international'
WHERE headword = 'city';

UPDATE lexicon_entries
SET
  ipa = 'ˈkʌntri',
  definition_simple = 'a nation with its own government',
  definition_teacher = 'Nation state. Essential for discussing international business and travel.',
  usage_notes = 'Used in business contexts (country manager, country office) and geography.',
  examples = '["My country is Brazil.", "Country manager.", "Country code.", "Different countries."]'::jsonb,
  collocations = '["my country", "country manager", "country code", "different countries"]'::jsonb,
  patterns = '["My country is...", "In this country"]'::jsonb,
  register = 'neutral',
  variety = 'international'
WHERE headword = 'country';

-- Objects
UPDATE lexicon_entries
SET
  ipa = 'bʊk',
  definition_simple = 'a set of printed pages fastened together',
  definition_teacher = 'Printed or digital publication. Essential for education and business.',
  usage_notes = 'Used in education and business contexts (book a meeting, textbook).',
  examples = '["Read a book.", "Book a meeting.", "Textbook.", "Book in advance."]'::jsonb,
  collocations = '["read book", "book meeting", "text book", "book in advance"]'::jsonb,
  patterns = '["Read a book", "Book a..."]'::jsonb,
  register = 'neutral',
  variety = 'international'
WHERE headword = 'book';

UPDATE lexicon_entries
SET
  ipa = 'kɑːr',
  definition_simple = 'a vehicle with four wheels',
  definition_teacher = 'Automobile. Essential vocabulary for transportation and business travel.',
  usage_notes = 'Used in business contexts (company car, car rental) and daily life.',
  examples = '["Drive a car.", "Company car.", "Car rental.", "By car."]'::jsonb,
  collocations = '["company car", "car rental", "by car", "car park"]'::jsonb,
  patterns = '["Drive a car", "By car"]'::jsonb,
  register = 'neutral',
  variety = 'international'
WHERE headword = 'car';

UPDATE lexicon_entries
SET
  ipa = 'ˈmʌni',
  definition_simple = 'coins and notes used to buy things',
  definition_teacher = 'Currency. Essential vocabulary for business and finance.',
  usage_notes = 'Used in all business contexts. Critical for discussing salary, prices, budgets.',
  examples = '["Save money.", "Money transfer.", "How much money?", "Money management."]'::jsonb,
  collocations = '["save money", "money transfer", "how much money", "money management"]'::jsonb,
  patterns = '["Save money", "How much money"]'::jsonb,
  register = 'neutral',
  variety = 'international'
WHERE headword = 'money';


-- Education
UPDATE lexicon_entries
SET
  ipa = 'ˈstuːdənt',
  definition_simple = 'a person who is learning',
  definition_teacher = 'Learner in educational institution. Essential for educational contexts.',
  usage_notes = 'Used in educational and training contexts. Common in professional development.',
  examples = '["I am a student.", "Student visa.", "Student discount.", "MBA student."]'::jsonb,
  collocations = '["I am student", "student visa", "student discount", "university student"]'::jsonb,
  patterns = '["I am a student", "Student at..."]'::jsonb,
  register = 'neutral',
  variety = 'international'
WHERE headword = 'student';

UPDATE lexicon_entries
SET
  ipa = 'ˈtiːtʃər',
  definition_simple = 'a person who teaches',
  definition_teacher = 'Education professional. Essential vocabulary for discussing education and training.',
  usage_notes = 'Used in educational contexts and professional training.',
  examples = '["My teacher is excellent.", "English teacher.", "Teacher training.", "The teacher explains well."]'::jsonb,
  collocations = '["English teacher", "my teacher", "teacher training", "good teacher"]'::jsonb,
  patterns = '["My teacher is...", "The teacher..."]'::jsonb,
  register = 'neutral',
  variety = 'international'
WHERE headword = 'teacher';

-- Basic Adjectives
UPDATE lexicon_entries
SET
  ipa = 'ˈhæpi',
  definition_simple = 'feeling pleased',
  definition_teacher = 'Positive emotion. Essential for expressing feelings and workplace culture.',
  usage_notes = 'Used to express satisfaction in professional contexts (happy to help, happy with results).',
  examples = '["I am happy here.", "Happy to help.", "Happy with the results.", "Happy customers."]'::jsonb,
  collocations = '["happy to", "happy with", "happy customers", "very happy"]'::jsonb,
  patterns = '["I am happy to...", "Happy with..."]'::jsonb,
  register = 'neutral',
  variety = 'international'
WHERE headword = 'happy';

UPDATE lexicon_entries
SET
  ipa = 'naɪs',
  definition_simple = 'pleasant or good',
  definition_teacher = 'Positive descriptor. Common in polite professional communication.',
  usage_notes = 'Used in professional contexts (nice to meet you, nice work). Very common in greetings.',
  examples = '["Nice to meet you.", "Nice work.", "Have a nice day.", "Nice office."]'::jsonb,
  collocations = '["nice to meet", "nice work", "nice day", "very nice"]'::jsonb,
  patterns = '["Nice to...", "Have a nice..."]'::jsonb,
  register = 'neutral',
  variety = 'international'
WHERE headword = 'nice';

UPDATE lexicon_entries
SET
  ipa = 'faɪn',
  definition_simple = 'good or acceptable',
  definition_teacher = 'Satisfactory quality. Common in professional responses and quality descriptions.',
  usage_notes = 'Used in professional contexts (fine with me, fine print). Common response to "How are you?"',
  examples = '["I am fine.", "That is fine.", "Fine print.", "Fine quality."]'::jsonb,
  collocations = '["I am fine", "that is fine", "fine print", "fine quality"]'::jsonb,
  patterns = '["I am fine", "That is fine"]'::jsonb,
  register = 'neutral',
  variety = 'international'
WHERE headword = 'fine';

UPDATE lexicon_entries
SET
  ipa = 'hɒt',
  definition_simple = 'having a high temperature',
  definition_teacher = 'High temperature. Essential for discussing weather, food, and comfort.',
  usage_notes = 'Used for temperature descriptions. Common in office contexts (too hot, hot desk).',
  examples = '["It is hot today.", "Hot coffee.", "Hot topic.", "Hot desk."]'::jsonb,
  collocations = '["very hot", "hot coffee", "hot topic", "hot desk"]'::jsonb,
  patterns = '["It is hot", "Hot..."]'::jsonb,
  register = 'neutral',
  variety = 'international'
WHERE headword = 'hot';

UPDATE lexicon_entries
SET
  ipa = 'kəʊld',
  definition_simple = 'having a low temperature',
  definition_teacher = 'Low temperature. Essential for discussing weather, food, and comfort.',
  usage_notes = 'Used for temperature descriptions. Common in office contexts (cold call, cold email).',
  examples = '["It is cold today.", "Cold water.", "Cold call.", "Cold email."]'::jsonb,
  collocations = '["very cold", "cold water", "cold call", "cold email"]'::jsonb,
  patterns = '["It is cold", "Cold..."]'::jsonb,
  register = 'neutral',
  variety = 'international'
WHERE headword = 'cold';

UPDATE lexicon_entries
SET
  ipa = 'lɒŋ',
  definition_simple = 'measuring a great distance',
  definition_teacher = 'Extended length or duration. Essential for descriptions and time.',
  usage_notes = 'Used for physical length and time duration. Common in business (long term, long meeting).',
  examples = '["A long meeting.", "Long term.", "How long?", "Long distance."]'::jsonb,
  collocations = '["long term", "long meeting", "how long", "long distance"]'::jsonb,
  patterns = '["How long...?", "Long term"]'::jsonb,
  register = 'neutral',
  variety = 'international'
WHERE headword = 'long';

UPDATE lexicon_entries
SET
  ipa = 'ʃɔːrt',
  definition_simple = 'measuring a small distance',
  definition_teacher = 'Brief length or duration. Essential for descriptions and time.',
  usage_notes = 'Used for physical length and time duration. Common in business (short term, short meeting).',
  examples = '["A short meeting.", "Short term.", "In short.", "Short notice."]'::jsonb,
  collocations = '["short term", "short meeting", "in short", "short notice"]'::jsonb,
  patterns = '["In short", "Short term"]'::jsonb,
  register = 'neutral',
  variety = 'international'
WHERE headword = 'short';

UPDATE lexicon_entries
SET
  ipa = 'jʌŋ',
  definition_simple = 'having lived for a short time',
  definition_teacher = 'Not old. Essential for describing people and things.',
  usage_notes = 'Used to describe age. Common in professional contexts (young professional, young company).',
  examples = '["A young professional.", "Young company.", "Young team.", "When I was young."]'::jsonb,
  collocations = '["young professional", "young company", "young team", "very young"]'::jsonb,
  patterns = '["A young...", "When I was young"]'::jsonb,
  register = 'neutral',
  variety = 'international'
WHERE headword = 'young';

-- Prepositions
UPDATE lexicon_entries
SET
  ipa = 'ɒv',
  definition_simple = 'belonging to or connected with',
  definition_teacher = 'Preposition showing possession or relationship. Most common preposition in English.',
  usage_notes = 'Essential preposition. Used constantly in professional English (head of, part of, member of).',
  examples = '["Head of department.", "Part of the team.", "Member of staff.", "End of day."]'::jsonb,
  collocations = '["head of", "part of", "member of", "end of"]'::jsonb,
  patterns = '["... of...", "Head of..."]'::jsonb,
  register = 'neutral',
  variety = 'international'
WHERE headword = 'of';

UPDATE lexicon_entries
SET
  ipa = 'nɪər',
  definition_simple = 'close to',
  definition_teacher = 'Preposition/adjective indicating proximity. Essential for giving directions and locations.',
  usage_notes = 'Used for physical proximity and time. Common in business (near future, near the office).',
  examples = '["Near the office.", "In the near future.", "Near here.", "Near completion."]'::jsonb,
  collocations = '["near office", "near future", "near here", "near completion"]'::jsonb,
  patterns = '["Near the...", "In the near future"]'::jsonb,
  register = 'neutral',
  variety = 'international'
WHERE headword = 'near';

UPDATE lexicon_entries
SET
  ipa = 'left',
  definition_simple = 'on the side opposite to right',
  definition_teacher = 'Direction/side. Essential for giving directions and spatial descriptions.',
  usage_notes = 'Used for directions and political contexts. Common in navigation (turn left, on the left).',
  examples = '["Turn left.", "On the left.", "Left side.", "Left-hand side."]'::jsonb,
  collocations = '["turn left", "on left", "left side", "left hand"]'::jsonb,
  patterns = '["Turn left", "On the left"]'::jsonb,
  register = 'neutral',
  variety = 'international'
WHERE headword = 'left';

-- Verification notice
DO $$
BEGIN
  RAISE NOTICE 'A0 Enhancement Complete: 48 words updated with full linguistic data';
  RAISE NOTICE 'All entries now include: IPA, definitions, usage notes, examples, collocations, patterns, register, variety';
END $$;
