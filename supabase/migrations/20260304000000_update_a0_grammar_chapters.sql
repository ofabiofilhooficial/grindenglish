-- Remove existing A0 grammar chapters
DELETE FROM public.grammar_chapters WHERE cefr_level = 'A0';

-- Insert 12 new A0 grammar chapters
INSERT INTO public.grammar_chapters (chapter_code, title, cefr_level, form_content, meaning_content, use_content, contrast_notes, common_errors, is_published, sort_order) VALUES

-- A0.G.01. Sentence Basics
('A0.G.01', 'Sentence Basics', 'A0',
'The basic English "Formula": Subject + Verb + Object (S–V–O).

Subject | Verb | Object
I | drink | coffee.
Maria | likes | pizza.
They | speak | English.

Punctuation: Always start with a Capital letter. Always end with a Full stop (.) or Question mark (?).
Names: Always capitalize names (John, London, Friday).',
'English is a "Fixed Word Order" language. The position of the word tells us who is doing the action.',
'Use this structure for 90% of your basic communication. If you move the words (e.g., Coffee drink I), people might get confused.',
'Correct: I like apples.
Incorrect: Like I apples. (Common in languages where word order is flexible).',
'Missing Subject: "Is a teacher" → Fix: "He is a teacher."
Lowercase "I": "am happy" → Fix: "I am happy." (The word "I" is always a capital).',
true, 1),

-- A0.G.02. The Verb be
('A0.G.02', 'The Verb be', 'A0',
'Person | Affirmative | Negative | Question
I | am (''m) | am not | Am I…?
You/We/They | are (''re) | are not | Are you…?
He/She/It | is (''s) | is not (isn''t) | Is he…?',
'Verb be is used to describe identity (I am Fábio) or state (I am happy). It does not describe an action (like "go" or "play").',
'Use contractions (''m, ''s, ''re) when speaking. It sounds more natural. Save "I am" for very formal writing or emphasis.',
'I am hungry (State) vs. I eat (Action).',
'Using "have" for age: "I have 20 years." → Fix: "I am 20."
Missing ''be'': "She doctor." → Fix: "She is a doctor."',
true, 2),

-- A0.G.03. Subject Pronouns & Possessive Adjectives
('A0.G.03', 'Subject Pronouns & Possessive Adjectives', 'A0',
'Subject Pronoun | Possessive Adjective | Example
I | My | This is my phone.
You | Your | What is your name?
He | His | His car is blue.
She | Her | Her office is here.
It | Its | The dog likes its toy.
We | Our | Our class is at 2 PM.
They | Their | Their house is big.',
'Subject Pronouns: The person doing the action (comes before the verb).
Possessive Adjectives: Shows ownership (comes before a noun).',
'Use "his" only for men/boys and "her" for women/girls. Use "its" for objects or animals when the gender is unknown.',
NULL,
'Mixing gender: Using "his" for a woman.
Missing nouns: "This is my." → Fix: "This is my book."
L1 Transfer (Portuguese): Using "your" (seu/sua) when you mean "his" or "her."
Incorrect: "Maria is here. Your car is blue."
Fix: "Maria is here. Her car is blue."',
true, 3),

-- A0.G.04. Articles I
('A0.G.04', 'Articles I', 'A0',
'a + consonant sound (a book, a car, a university).
an + vowel sound (an apple, an orange, an hour).',
'"a/an" means one. We use it for non-specific things (one of many).',
'Always use a/an with jobs in English.
Example: "I am a teacher." (Not: "I am teacher").',
'a doctor (one doctor, any doctor).
the doctor (a specific doctor we already know).',
'Focusing on spelling vs. sound: "An university" → Fix: "A university" (starts with a ''y'' sound).
Plural use: "A books" → Fix: "Books" (no ''a'' with plurals).',
true, 4),

-- A0.G.05. Plurals & This/That/These/Those
('A0.G.05', 'Plurals & This/That/These/Those', 'A0',
'Regular Plurals: Just add -s (Book → Books).

Demonstratives:
 | Near | Far
Singular | This | That
Plural | These | Those',
'This/These: Things I can touch or are very close.
That/Those: Things across the room or outside.',
'Use "this/that" for singular items and "these/those" for plural.
Example: "I like this phone, but I don''t like those tablets over there."',
NULL,
'Mixing Singular/Plural: "These book are good." → Fix: "These books are good" or "This book is good."',
true, 5),

-- A0.G.06. Imperatives
('A0.G.06', 'Imperatives', 'A0',
'Affirmative: Verb (base form) + object. (Open the door.)
Negative: Don''t + verb + object. (Don''t open the window.)',
'The subject "You" is understood but not spoken. It is a direct command.',
'"Please" to make imperatives polite.
Example: "Sit down, please."',
NULL,
'Starter: "Give me the pen."
Upgrade: "Can you give me the pen, please?"',
true, 6),

-- A0.G.07. There is/are
('A0.G.07', 'There is/are', 'A0',
'Number | Affirmative | Negative | Question
Singular | There is (There''s) | There isn''t | Is there…?
Plural | There are | There aren''t | Are there…?',
'It signals existence. We use it to "point" to things with words.',
NULL,
NULL,
'L1 Transfer (Portuguese): Using "Have" (Ter) instead of "There is."
Incorrect: "Have a book on the table."
Fix: "There is a book on the table."',
true, 7),

-- A0.G.08. Basic Prepositions of Place
('A0.G.08', 'Basic Prepositions of Place', 'A0',
'Pattern: [Object] + [Verb be] + [Preposition] + [the/my] + [Location].
Example: The cat is under the table.',
'In: Inside a container or space (in the box).
On: On a surface (on the desk).
Under: Below something.
Next to: Beside something.',
'Choose the preposition based on the 3D relationship between objects.
Tip: We say "at home" or "at school" for general locations.',
NULL,
'In vs. On: "The phone is in the table." → Fix: "The phone is on the table."',
true, 8),

-- A0.G.09. Basic Questions
('A0.G.09', 'Basic Questions', 'A0',
'Yes/No: [Be] + Subject + ...? (Are you Brazilian?)
Wh- Word: [Wh-] + [Be] + Subject + ...? (Where is the keys?)

Common Wh- Words:
• Who (people)
• What (things/info)
• Where (places)
• When (time)',
'Yes/No questions check if something is true.
Wh- questions ask for new information.',
NULL,
NULL,
'Missing the verb ''be'': "Where the bathroom?" → Fix: "Where is the bathroom?"
Word order: "What your name is?" → Fix: "What is your name?"',
true, 9),

-- A0.G.10. Can
('A0.G.10', 'Can', 'A0',
'Affirmative: Subject + can + Verb (base form).
Negative: Subject + cannot (can''t) + Verb.
Question: Can + Subject + Verb?

Note: The verb never changes. No "-s" for he/she/it!
Correct: She can swim.
Incorrect: She cans swim.',
'It shows you have the physical or mental power to do something.',
'In spoken English, "can''t" is much more common than "cannot."
Pronunciation Note: In "I can swim," the ''can'' is very short. In "I can''t swim," the ''can''t'' is longer and clearer.',
NULL,
'Adding "to": "I can to dance." → Fix: "I can dance." (Never use "to" after can).',
true, 10),

-- A0.G.11. Have
('A0.G.11', 'Have', 'A0',
'Standard English (US/Global): Subject + have/has + object.
British English: Subject + have got + object.

Subject | Affirmative | Negative
I/You/We/They | have | don''t have
He/She/It | has | doesn''t have',
'Shows ownership or a permanent characteristic.',
'"Has" is only for He, She, and It. In many tasks, "have" is more versatile for global communication.',
NULL,
'Using "has" for I: "I has a car." → Fix: "I have a car."
Negative errors: "I no have money." → Fix: "I don''t have money."',
true, 11),

-- A0.G.12. Simple Connectors
('A0.G.12', 'Simple Connectors', 'A0',
'Idea 1 + and + Idea 2.
Idea 1 + but + Idea 2 (different/opposite).',
'And: Addition (+).
But: Contrast/Difference (x).',
'Use a comma before "but" when connecting two full sentences.',
'"I like coffee and tea." (Both)
"I like coffee, but I don''t like tea." (One yes, one no)',
NULL,
true, 12);
