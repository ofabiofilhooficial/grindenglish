-- Migration: Enhance GSL Vocabulary - Batch 5 (A1 Communication and Technology)
-- Description: Add comprehensive linguistic data for second batch of A1 words
-- Words: Communication verbs (say, tell, speak, talk, ask, answer, call, write, read, listen, etc.)
--        Technology nouns (computer, phone, email, internet, website, message, etc.)
--        Communication concepts (information, question, answer, language, word, etc.)
-- Target: ~150 A1 words focused on communication and technology
-- Focus: Brazilian professionals learning workplace communication and digital literacy

-- ============================================================================
-- COMMUNICATION VERBS (15 words)
-- ============================================================================

-- Verb: say
UPDATE lexicon_entries
SET
  ipa = 'seɪ',
  definition_simple = 'to speak words or express something in words',
  definition_teacher = 'verb: transitive; refers to expressing something in words, reporting speech, or stating information; neutral register; fundamental communication verb; irregular past tense (said)',
  usage_notes = 'Essential communication verb. Common patterns: "say something", "say that...", "say to someone". Note: "say" focuses on the words spoken, while "tell" focuses on the person receiving information. Brazilian learners often confuse "say" and "tell" - use "say" for direct speech without mentioning the listener.',
  register = 'neutral',
  variety = 'international',
  examples = '["She said hello to everyone.", "What did you say?", "He said that the meeting is tomorrow.", "I want to say thank you."]'::jsonb,
  collocations = '["say hello", "say goodbye", "say something", "say that", "say yes/no"]'::jsonb,
  patterns = '["say + something", "say + that clause", "say + to + person"]'::jsonb,
  updated_at = now()
WHERE headword = 'say';

-- Verb: tell
UPDATE lexicon_entries
SET
  ipa = 'tel',
  definition_simple = 'to give information to someone by speaking or writing',
  definition_teacher = 'verb: transitive; requires an object (person); refers to communicating information to someone, giving instructions, or narrating; neutral register; irregular past tense (told)',
  usage_notes = 'Essential communication verb. Always requires a person object: "tell someone something", "tell someone that...", "tell someone to do". Common phrases: "tell the truth", "tell a story", "tell me about". Brazilian learners often confuse with "say" - use "tell" when mentioning the person receiving information.',
  register = 'neutral',
  variety = 'international',
  examples = '["Please tell me your name.", "She told us about the project.", "Can you tell him to call me?", "I will tell you the truth."]'::jsonb,
  collocations = '["tell someone", "tell the truth", "tell a story", "tell me about", "tell someone to do"]'::jsonb,
  patterns = '["tell + person + something", "tell + person + that clause", "tell + person + to-infinitive"]'::jsonb,
  updated_at = now()
WHERE headword = 'tell';

-- Verb: speak
UPDATE lexicon_entries
SET
  ipa = 'spiːk',
  definition_simple = 'to talk or say words, or to be able to use a language',
  definition_teacher = 'verb: intransitive or transitive; refers to verbal communication, language ability, or formal address; neutral register; irregular past tense (spoke, spoken)',
  usage_notes = 'Common communication verb. Intransitive: "speak to someone", "speak about something". Language ability: "speak English/Portuguese". More formal than "talk". Common phrases: "speak clearly", "speak up" (louder), "speak with someone". Brazilian learners should note: "speak English" (not "speak in English").',
  register = 'neutral',
  variety = 'international',
  examples = '["I speak English and Portuguese.", "Can I speak to the manager?", "Please speak more slowly.", "She spoke about the new policy."]'::jsonb,
  collocations = '["speak English", "speak to someone", "speak about", "speak clearly", "speak up"]'::jsonb,
  patterns = '["speak + language", "speak + to/with + person", "speak + about + topic"]'::jsonb,
  updated_at = now()
WHERE headword = 'speak';


-- Verb: talk
UPDATE lexicon_entries
SET
  ipa = 'tɔːk',
  definition_simple = 'to say words or have a conversation with someone',
  definition_teacher = 'verb: intransitive; refers to verbal communication or conversation; more informal than "speak"; neutral register; also noun meaning conversation',
  usage_notes = 'Common informal communication verb. Patterns: "talk to/with someone", "talk about something". More casual than "speak". Common phrases: "talk business", "small talk", "talk on the phone". Also noun: "have a talk". Brazilian learners should note: "talk to someone" (not "talk with someone" in most contexts).',
  register = 'neutral',
  variety = 'international',
  examples = '["Let''s talk about the project.", "I need to talk to you.", "They are talking on the phone.", "We had a good talk yesterday."]'::jsonb,
  collocations = '["talk to someone", "talk about", "talk on the phone", "small talk", "have a talk"]'::jsonb,
  patterns = '["talk + to/with + person", "talk + about + topic", "have a talk"]'::jsonb,
  updated_at = now()
WHERE headword = 'talk';

-- Verb: ask
UPDATE lexicon_entries
SET
  ipa = 'ɑːsk',
  definition_simple = 'to say a question or request something from someone',
  definition_teacher = 'verb: transitive; refers to posing questions or making requests; neutral register; fundamental communication verb for inquiries',
  usage_notes = 'Essential question verb. Patterns: "ask someone something", "ask about", "ask for" (request), "ask someone to do". Common phrases: "ask a question", "ask permission", "ask for help". Brazilian learners should note: "ask someone" (not "ask to someone").',
  register = 'neutral',
  variety = 'international',
  examples = '["Can I ask you a question?", "She asked about the deadline.", "Please ask for help if you need it.", "He asked me to send the report."]'::jsonb,
  collocations = '["ask a question", "ask for help", "ask permission", "ask about", "ask someone to do"]'::jsonb,
  patterns = '["ask + person + something", "ask + about + topic", "ask + for + thing", "ask + person + to-infinitive"]'::jsonb,
  updated_at = now()
WHERE headword = 'ask';

-- Verb: answer
UPDATE lexicon_entries
SET
  ipa = 'ˈɑːnsə',
  definition_simple = 'to say or write something as a reply to a question',
  definition_teacher = 'verb: transitive or intransitive; also noun; refers to responding to questions, calls, or messages; neutral register; fundamental communication term',
  usage_notes = 'Essential response verb. Verb: "answer a question", "answer the phone", "answer an email". Noun: "give an answer", "the answer is". Common in professional contexts. Brazilian learners should note: "answer the phone" (not "attend the phone").',
  register = 'neutral',
  variety = 'international',
  examples = '["Please answer my question.", "She answered the phone immediately.", "I will answer your email today.", "What is the answer to this problem?"]'::jsonb,
  collocations = '["answer a question", "answer the phone", "answer an email", "give an answer", "the answer is"]'::jsonb,
  patterns = '["answer + question/phone/email", "give an answer", "the answer + to"]'::jsonb,
  updated_at = now()
WHERE headword = 'answer';

-- Verb: call
UPDATE lexicon_entries
SET
  ipa = 'kɔːl',
  definition_simple = 'to telephone someone or to say something in a loud voice',
  definition_teacher = 'verb: transitive; multiple meanings including telephoning, shouting, naming, or summoning; also noun meaning telephone conversation; neutral register',
  usage_notes = 'Versatile communication verb. Phone: "call someone", "make a call". Shout: "call out". Name: "call someone something". Very common in business: "call a meeting", "conference call". Also noun: "phone call", "video call". Brazilian learners should note: "call someone" (not "call to someone").',
  register = 'neutral',
  variety = 'international',
  examples = '["I will call you tomorrow.", "Please call me when you arrive.", "Let''s have a conference call.", "She called my name."]'::jsonb,
  collocations = '["call someone", "phone call", "conference call", "call a meeting", "make a call", "video call"]'::jsonb,
  patterns = '["call + person", "make a call", "call + meeting", "phone/video call"]'::jsonb,
  updated_at = now()
WHERE headword = 'call';

-- Verb: write
UPDATE lexicon_entries
SET
  ipa = 'raɪt',
  definition_simple = 'to make letters or words on paper or screen',
  definition_teacher = 'verb: transitive or intransitive; refers to creating written text, composing documents, or corresponding; neutral register; irregular past tense (wrote, written)',
  usage_notes = 'Essential writing verb. Common patterns: "write something", "write to someone", "write about". Professional contexts: "write a report", "write an email", "write down" (record). Brazilian learners should note: "write to someone" (correspondence) vs "write someone" (US informal).',
  register = 'neutral',
  variety = 'international',
  examples = '["Please write your name here.", "I need to write a report.", "She wrote an email to the team.", "Write down the important points."]'::jsonb,
  collocations = '["write a report", "write an email", "write down", "write to someone", "write about"]'::jsonb,
  patterns = '["write + document", "write + to + person", "write + about + topic", "write down"]'::jsonb,
  updated_at = now()
WHERE headword = 'write';

-- Verb: read
UPDATE lexicon_entries
SET
  ipa = 'riːd',
  definition_simple = 'to look at and understand written words',
  definition_teacher = 'verb: transitive or intransitive; refers to interpreting written text or understanding meaning; neutral register; irregular past tense (read /red/)',
  usage_notes = 'Essential reading verb. Common patterns: "read something", "read about", "read to someone". Professional contexts: "read a report", "read an email", "read through" (review). Note: present tense /riːd/ vs past tense /red/. Brazilian learners should practice pronunciation distinction.',
  register = 'neutral',
  variety = 'international',
  examples = '["I read the report yesterday.", "Please read this email.", "She reads to her children.", "Read through the document carefully."]'::jsonb,
  collocations = '["read a report", "read an email", "read about", "read through", "read carefully"]'::jsonb,
  patterns = '["read + document", "read + about + topic", "read + to + person", "read through"]'::jsonb,
  updated_at = now()
WHERE headword = 'read';

-- Verb: listen
UPDATE lexicon_entries
SET
  ipa = 'ˈlɪsən',
  definition_simple = 'to pay attention to sounds or to what someone is saying',
  definition_teacher = 'verb: intransitive; requires preposition "to"; refers to actively paying attention to sounds or speech; neutral register; fundamental communication skill',
  usage_notes = 'Essential listening verb. Always use "listen to" (not just "listen"): "listen to music", "listen to someone", "listen carefully". Common in professional contexts: "listen to feedback", "active listening". Brazilian learners often forget the "to" preposition.',
  register = 'neutral',
  variety = 'international',
  examples = '["Please listen to me.", "I listen to music while working.", "Listen carefully to the instructions.", "We need to listen to customer feedback."]'::jsonb,
  collocations = '["listen to someone", "listen carefully", "listen to music", "listen to feedback", "active listening"]'::jsonb,
  patterns = '["listen + to + person/thing", "listen + carefully/attentively"]'::jsonb,
  updated_at = now()
WHERE headword = 'listen';


-- Verb: understand
UPDATE lexicon_entries
SET
  ipa = 'ˌʌndəˈstænd',
  definition_simple = 'to know the meaning of something or how something works',
  definition_teacher = 'verb: transitive; refers to comprehending meaning, grasping concepts, or having knowledge; neutral register; irregular past tense (understood)',
  usage_notes = 'Essential comprehension verb. Common patterns: "understand something", "understand that...", "understand how/why/what". Professional contexts: "understand the requirements", "make yourself understood". Brazilian learners should note: "I understand" (not "I am understanding" for comprehension).',
  register = 'neutral',
  variety = 'international',
  examples = '["Do you understand the instructions?", "I understand what you mean.", "She understands the problem.", "Please help me understand this concept."]'::jsonb,
  collocations = '["understand something", "understand that", "understand how", "make yourself understood", "easy to understand"]'::jsonb,
  patterns = '["understand + something", "understand + that clause", "understand + wh-clause"]'::jsonb,
  updated_at = now()
WHERE headword = 'understand';

-- Verb: explain
UPDATE lexicon_entries
SET
  ipa = 'ɪkˈspleɪn',
  definition_simple = 'to make something clear or easy to understand by describing it',
  definition_teacher = 'verb: transitive; refers to clarifying, describing reasons, or making something comprehensible; neutral register; essential teaching and communication verb',
  usage_notes = 'Essential clarification verb. Patterns: "explain something", "explain to someone", "explain that...", "explain how/why". Common in professional contexts: "explain the process", "let me explain". Brazilian learners should note: "explain something to someone" (not "explain someone something").',
  register = 'neutral',
  variety = 'international',
  examples = '["Can you explain this to me?", "Let me explain how it works.", "She explained the process clearly.", "I will explain why we need this."]'::jsonb,
  collocations = '["explain something", "explain to someone", "explain how", "explain why", "let me explain"]'::jsonb,
  patterns = '["explain + something + to + person", "explain + that clause", "explain + wh-clause"]'::jsonb,
  updated_at = now()
WHERE headword = 'explain';

-- Verb: show
UPDATE lexicon_entries
SET
  ipa = 'ʃəʊ',
  definition_simple = 'to let someone see something or to make something clear',
  definition_teacher = 'verb: transitive; refers to displaying, demonstrating, or making visible; also noun meaning performance or display; neutral register; irregular past participle (shown)',
  usage_notes = 'Versatile demonstration verb. Patterns: "show someone something", "show that...", "show how". Common in professional contexts: "show results", "show a presentation". Also noun: "trade show", "TV show". Brazilian learners should note: "show someone something" (double object pattern).',
  register = 'neutral',
  variety = 'international',
  examples = '["Can you show me the report?", "The data shows good results.", "Let me show you how to do this.", "She showed us the new office."]'::jsonb,
  collocations = '["show someone something", "show results", "show how", "show that", "trade show"]'::jsonb,
  patterns = '["show + person + thing", "show + that clause", "show + how + to-infinitive"]'::jsonb,
  updated_at = now()
WHERE headword = 'show';

-- Verb: mean
UPDATE lexicon_entries
SET
  ipa = 'miːn',
  definition_simple = 'to have a particular meaning or to intend to express something',
  definition_teacher = 'verb: transitive; refers to signifying, intending, or having significance; also adjective meaning unkind; neutral register as verb; irregular past tense (meant)',
  usage_notes = 'Essential meaning verb. Patterns: "mean something", "mean that...", "mean to do" (intend). Common questions: "What does this mean?", "What do you mean?". Also adjective: "mean person" (unkind). Brazilian learners should note: "What do you mean?" (not "What you mean?").',
  register = 'neutral',
  variety = 'international',
  examples = '["What does this word mean?", "I mean that we should start now.", "She didn''t mean to be late.", "This means we need more time."]'::jsonb,
  collocations = '["what does it mean", "what do you mean", "mean that", "mean to do", "this means"]'::jsonb,
  patterns = '["mean + something", "mean + that clause", "mean + to-infinitive", "what + do/does + mean"]'::jsonb,
  updated_at = now()
WHERE headword = 'mean';

-- Verb: send
UPDATE lexicon_entries
SET
  ipa = 'send',
  definition_simple = 'to make something go or be taken to another place or person',
  definition_teacher = 'verb: transitive; refers to dispatching, transmitting, or causing to go; neutral register; irregular past tense (sent); essential communication and logistics verb',
  usage_notes = 'Essential transmission verb. Patterns: "send something", "send something to someone", "send someone something". Very common in digital communication: "send an email", "send a message", "send a file". Brazilian learners should note: "send to someone" or "send someone something" (both correct).',
  register = 'neutral',
  variety = 'international',
  examples = '["Please send me the document.", "I will send an email tomorrow.", "Can you send this to the team?", "She sent a message on WhatsApp."]'::jsonb,
  collocations = '["send an email", "send a message", "send a file", "send to someone", "send someone something"]'::jsonb,
  patterns = '["send + something + to + person", "send + person + something", "send + email/message"]'::jsonb,
  updated_at = now()
WHERE headword = 'send';

-- ============================================================================
-- TECHNOLOGY NOUNS (12 words)
-- ============================================================================

-- Noun: computer
UPDATE lexicon_entries
SET
  ipa = 'kəmˈpjuːtə',
  definition_simple = 'an electronic machine that stores and processes information',
  definition_teacher = 'noun: countable; refers to electronic computing device; neutral register; fundamental technology term; can be desktop, laptop, or general computing device',
  usage_notes = 'Essential technology term. Common phrases: "use a computer", "computer screen", "computer program", "laptop computer", "desktop computer". Very common in professional contexts. Brazilian learners should note: "on the computer" (using it) vs "in the computer" (stored inside).',
  register = 'neutral',
  variety = 'international',
  examples = '["I work on my computer every day.", "The computer screen is too bright.", "She bought a new laptop computer.", "Save the file on your computer."]'::jsonb,
  collocations = '["use a computer", "computer screen", "computer program", "laptop computer", "desktop computer", "on the computer"]'::jsonb,
  patterns = '["use/work on a computer", "computer + noun (compound)", "on the computer"]'::jsonb,
  updated_at = now()
WHERE headword = 'computer';

-- Noun: phone
UPDATE lexicon_entries
SET
  ipa = 'fəʊn',
  definition_simple = 'a device used to talk to someone in another place',
  definition_teacher = 'noun: countable; short for telephone; refers to communication device; also verb meaning to call; neutral register; can be mobile phone, smartphone, or landline',
  usage_notes = 'Essential communication term. Common phrases: "on the phone" (talking), "by phone", "phone call", "mobile phone", "phone number". Also verb: "phone someone". Very common in business: "answer the phone", "phone meeting". Brazilian learners should note: "on the phone" (not "in the phone").',
  register = 'neutral',
  variety = 'international',
  examples = '["She is on the phone right now.", "What is your phone number?", "I left my mobile phone at home.", "Please answer the phone."]'::jsonb,
  collocations = '["on the phone", "phone number", "mobile phone", "phone call", "answer the phone", "by phone"]'::jsonb,
  patterns = '["on the phone", "phone + noun (compound)", "by phone"]'::jsonb,
  updated_at = now()
WHERE headword = 'phone';

-- Noun: email
UPDATE lexicon_entries
SET
  ipa = 'ˈiːmeɪl',
  definition_simple = 'a message sent by electronic mail, or the system of sending these messages',
  definition_teacher = 'noun: countable (message) or uncountable (system); also verb; refers to electronic mail communication; neutral register; fundamental digital communication term',
  usage_notes = 'Essential digital communication term. Noun: "send an email", "receive an email", "email address", "by email". Verb: "email someone", "email something to someone". Very common in professional contexts. Brazilian learners should note: "send an email" (not "send a email").',
  register = 'neutral',
  variety = 'international',
  examples = '["Please send me an email.", "I received your email yesterday.", "What is your email address?", "We communicate by email."]'::jsonb,
  collocations = '["send an email", "receive an email", "email address", "by email", "email someone", "check email"]'::jsonb,
  patterns = '["send/receive an email", "email + noun (compound)", "by email", "email + person"]'::jsonb,
  updated_at = now()
WHERE headword = 'email';


-- Noun: internet
UPDATE lexicon_entries
SET
  ipa = 'ˈɪntənet',
  definition_simple = 'the global system of connected computers that allows people to share information',
  definition_teacher = 'noun: uncountable; proper noun (the Internet); refers to global computer network; neutral register; fundamental digital technology term',
  usage_notes = 'Essential technology term. Always use "the internet" (with article). Common phrases: "on the internet", "internet connection", "internet access", "browse the internet". Very common in modern professional contexts. Brazilian learners should note: "on the internet" (not "in the internet").',
  register = 'neutral',
  variety = 'international',
  examples = '["I found this information on the internet.", "We need a faster internet connection.", "Do you have internet access?", "She works in internet marketing."]'::jsonb,
  collocations = '["on the internet", "internet connection", "internet access", "browse the internet", "internet marketing"]'::jsonb,
  patterns = '["on the internet", "internet + noun (compound)", "the internet"]'::jsonb,
  updated_at = now()
WHERE headword = 'internet';

-- Noun: website
UPDATE lexicon_entries
SET
  ipa = 'ˈwebsaɪt',
  definition_simple = 'a place on the internet where you can find information about something',
  definition_teacher = 'noun: countable; refers to collection of web pages under one domain; neutral register; fundamental digital term; also written as "web site"',
  usage_notes = 'Essential digital term. Common phrases: "visit a website", "company website", "website address", "on the website". Very common in business: "our website", "website design". Brazilian learners should note: "on the website" (not "in the website").',
  register = 'neutral',
  variety = 'international',
  examples = '["Visit our website for more information.", "The company website is very helpful.", "I found this on their website.", "She designs websites."]'::jsonb,
  collocations = '["visit a website", "company website", "on the website", "website design", "website address"]'::jsonb,
  patterns = '["visit a website", "on the website", "website + noun (compound)"]'::jsonb,
  updated_at = now()
WHERE headword = 'website';

-- Noun: message
UPDATE lexicon_entries
SET
  ipa = 'ˈmesɪdʒ',
  definition_simple = 'a piece of written or spoken information that you send to someone',
  definition_teacher = 'noun: countable; also verb; refers to communication sent between people; neutral register; can be text, voice, email, or any form of communication',
  usage_notes = 'Essential communication term. Common phrases: "send a message", "receive a message", "text message", "voice message", "leave a message". Very common in digital communication. Also verb: "message someone". Brazilian learners should note: "send a message" (not "send a message for someone").',
  register = 'neutral',
  variety = 'international',
  examples = '["I sent you a message yesterday.", "Please leave a message after the beep.", "She received a text message.", "Can you message me the details?"]'::jsonb,
  collocations = '["send a message", "receive a message", "text message", "voice message", "leave a message"]'::jsonb,
  patterns = '["send/receive a message", "message + noun (compound)", "message + person"]'::jsonb,
  updated_at = now()
WHERE headword = 'message';

-- Noun: information
UPDATE lexicon_entries
SET
  ipa = 'ˌɪnfəˈmeɪʃən',
  definition_simple = 'facts or details about something or someone',
  definition_teacher = 'noun: uncountable; refers to knowledge, data, or facts; neutral register; fundamental communication term; note: no plural form in English',
  usage_notes = 'Essential information term. Always uncountable: "some information" (not "an information" or "informations"). Common phrases: "get information", "provide information", "information about", "more information". Very common in professional contexts. Brazilian learners often make it countable incorrectly.',
  register = 'neutral',
  variety = 'international',
  examples = '["I need more information about the project.", "Where can I get this information?", "Please provide the following information.", "This website has useful information."]'::jsonb,
  collocations = '["get information", "provide information", "more information", "information about", "useful information"]'::jsonb,
  patterns = '["get/provide information", "information + about", "more/some information"]'::jsonb,
  updated_at = now()
WHERE headword = 'information';

-- Noun: question
UPDATE lexicon_entries
SET
  ipa = 'ˈkwestʃən',
  definition_simple = 'a sentence or phrase used to find out information',
  definition_teacher = 'noun: countable; also verb meaning to ask or doubt; refers to inquiry or interrogative statement; neutral register; fundamental communication term',
  usage_notes = 'Essential inquiry term. Common phrases: "ask a question", "answer a question", "good question", "question about". Also verb: "question something" (doubt or interrogate). Very common in professional and educational contexts. Brazilian learners should note: "ask a question" (not "make a question").',
  register = 'neutral',
  variety = 'international',
  examples = '["Can I ask you a question?", "That is a good question.", "Please answer the questions.", "I have a question about the deadline."]'::jsonb,
  collocations = '["ask a question", "answer a question", "good question", "question about", "have a question"]'::jsonb,
  patterns = '["ask/answer a question", "question + about", "have a question"]'::jsonb,
  updated_at = now()
WHERE headword = 'question';

-- Noun: language
UPDATE lexicon_entries
SET
  ipa = 'ˈlæŋɡwɪdʒ',
  definition_simple = 'a system of communication used by people in a country or region',
  definition_teacher = 'noun: countable (specific language) or uncountable (general concept); refers to human communication system, programming language, or manner of expression; neutral register',
  usage_notes = 'Essential communication term. Countable: "speak a language", "foreign language", "English language". Uncountable: "language learning", "body language". Also used for programming: "programming language". Brazilian learners should note: "speak a language" (not "speak in a language").',
  register = 'neutral',
  variety = 'international',
  examples = '["I speak two languages.", "English is an international language.", "She is learning a new language.", "Body language is important in communication."]'::jsonb,
  collocations = '["speak a language", "foreign language", "language learning", "body language", "programming language"]'::jsonb,
  patterns = '["speak a language", "language + noun (compound)", "learn a language"]'::jsonb,
  updated_at = now()
WHERE headword = 'language';

-- Noun: word
UPDATE lexicon_entries
SET
  ipa = 'wɜːd',
  definition_simple = 'a single unit of language that has meaning',
  definition_teacher = 'noun: countable; refers to linguistic unit, promise, or news; neutral register; fundamental language term; also verb meaning to express in words',
  usage_notes = 'Essential language term. Common phrases: "in other words", "word for word", "have a word with" (talk to), "keep your word" (promise). Plural: "words" for vocabulary. Very common in communication contexts. Brazilian learners should note: "in other words" (reformulation phrase).',
  register = 'neutral',
  variety = 'international',
  examples = '["What does this word mean?", "In other words, we need more time.", "Can I have a word with you?", "She always keeps her word."]'::jsonb,
  collocations = '["in other words", "word for word", "have a word with", "keep your word", "new word"]'::jsonb,
  patterns = '["in other words", "have a word + with", "word + for + word"]'::jsonb,
  updated_at = now()
WHERE headword = 'word';

-- Noun: name
UPDATE lexicon_entries
SET
  ipa = 'neɪm',
  definition_simple = 'the word or words that someone or something is called',
  definition_teacher = 'noun: countable; also verb meaning to give a name or identify; refers to designation, title, or reputation; neutral register; fundamental identification term',
  usage_notes = 'Essential identification term. Common phrases: "my name is", "first name", "last name", "company name", "by name". Also verb: "name something/someone". Very common in introductions and professional contexts. Brazilian learners should note: "What is your name?" (not "How is your name?").',
  register = 'neutral',
  variety = 'international',
  examples = '["What is your name?", "My name is Maria.", "Please write your full name.", "The company name is on the website."]'::jsonb,
  collocations = '["my name is", "first name", "last name", "full name", "company name", "by name"]'::jsonb,
  patterns = '["my/your name + is", "first/last name", "name + of"]'::jsonb,
  updated_at = now()
WHERE headword = 'name';

-- Noun: number
UPDATE lexicon_entries
SET
  ipa = 'ˈnʌmbə',
  definition_simple = 'a word or symbol that represents an amount or position in a series',
  definition_teacher = 'noun: countable; also verb meaning to count or assign numbers; refers to numerical value, quantity, or identifier; neutral register; fundamental mathematical and identification term',
  usage_notes = 'Essential numerical term. Common phrases: "phone number", "number of" (quantity), "a number of" (several), "room number", "account number". Very common in professional contexts for identification and quantification. Brazilian learners should note: "a number of" means "several".',
  register = 'neutral',
  variety = 'international',
  examples = '["What is your phone number?", "The number of participants is 50.", "Please enter your account number.", "A number of people attended the meeting."]'::jsonb,
  collocations = '["phone number", "number of", "a number of", "room number", "account number"]'::jsonb,
  patterns = '["phone/room/account number", "number + of", "a number of"]'::jsonb,
  updated_at = now()
WHERE headword = 'number';


-- ============================================================================
-- ADDITIONAL COMMUNICATION CONCEPTS (10 words)
-- ============================================================================

-- Noun: idea
UPDATE lexicon_entries
SET
  ipa = 'aɪˈdɪə',
  definition_simple = 'a thought, plan, or suggestion about what to do',
  definition_teacher = 'noun: countable; refers to concept, thought, plan, or understanding; neutral register; fundamental cognitive and planning term',
  usage_notes = 'Essential thinking term. Common phrases: "good idea", "have an idea", "idea about", "no idea" (don''t know). Very common in brainstorming and planning contexts. Brazilian learners should note: "I have no idea" (strong way to say "I don''t know").',
  register = 'neutral',
  variety = 'international',
  examples = '["That is a good idea.", "I have an idea for the project.", "Do you have any ideas?", "I have no idea what to do."]'::jsonb,
  collocations = '["good idea", "have an idea", "no idea", "idea about", "great idea"]'::jsonb,
  patterns = '["have an idea", "good/great idea", "idea + about/for"]'::jsonb,
  updated_at = now()
WHERE headword = 'idea';

-- Noun: problem
UPDATE lexicon_entries
SET
  ipa = 'ˈprɒbləm',
  definition_simple = 'a situation that causes difficulty or that needs to be solved',
  definition_teacher = 'noun: countable; refers to difficulty, challenge, or question requiring solution; neutral register; fundamental problem-solving term',
  usage_notes = 'Essential problem-solving term. Common phrases: "have a problem", "solve a problem", "problem with", "no problem" (okay/you''re welcome). Very common in professional troubleshooting contexts. Brazilian learners should note: "no problem" as response to "thank you".',
  register = 'neutral',
  variety = 'international',
  examples = '["We have a problem with the system.", "Can you help me solve this problem?", "There is no problem.", "What is the problem?"]'::jsonb,
  collocations = '["have a problem", "solve a problem", "no problem", "problem with", "big problem"]'::jsonb,
  patterns = '["have a problem", "solve a problem", "problem + with"]'::jsonb,
  updated_at = now()
WHERE headword = 'problem';

-- Noun: help
UPDATE lexicon_entries
SET
  ipa = 'help',
  definition_simple = 'the act of making it easier for someone to do something',
  definition_teacher = 'noun: uncountable; also verb; refers to assistance, support, or aid; neutral register; fundamental support term',
  usage_notes = 'Essential assistance term. Noun: "need help", "ask for help", "with the help of". Verb: "help someone", "help with something", "can''t help" (can''t avoid). Very common in professional contexts. Brazilian learners should note: "help someone do" (not "help someone to do" in most cases).',
  register = 'neutral',
  variety = 'international',
  examples = '["I need help with this task.", "Can you help me?", "Thank you for your help.", "She helped me finish the report."]'::jsonb,
  collocations = '["need help", "ask for help", "help with", "thank you for your help", "can I help you"]'::jsonb,
  patterns = '["need/ask for help", "help + with", "help + person + do"]'::jsonb,
  updated_at = now()
WHERE headword = 'help';

-- Noun: example
UPDATE lexicon_entries
SET
  ipa = 'ɪɡˈzɑːmpəl',
  definition_simple = 'something that shows what other similar things are like',
  definition_teacher = 'noun: countable; refers to specimen, illustration, or model; neutral register; fundamental teaching and explanation term',
  usage_notes = 'Essential illustration term. Common phrases: "for example", "give an example", "example of", "set an example" (be a model). Very common in teaching and explanation contexts. Brazilian learners should note: "for example" (not "for an example").',
  register = 'neutral',
  variety = 'international',
  examples = '["Can you give me an example?", "For example, we can use email.", "This is a good example of teamwork.", "She sets a good example for others."]'::jsonb,
  collocations = '["for example", "give an example", "example of", "good example", "set an example"]'::jsonb,
  patterns = '["for example", "give an example", "example + of"]'::jsonb,
  updated_at = now()
WHERE headword = 'example';

-- Noun: reason
UPDATE lexicon_entries
SET
  ipa = 'ˈriːzən',
  definition_simple = 'the cause or explanation for something that happens',
  definition_teacher = 'noun: countable; also verb meaning to think logically; refers to cause, justification, or logical thinking; neutral register; fundamental explanation term',
  usage_notes = 'Essential explanation term. Common phrases: "the reason for", "the reason why", "for this reason", "good reason". Very common in professional explanations and justifications. Brazilian learners should note: "the reason why" or "the reason for" (both correct).',
  register = 'neutral',
  variety = 'international',
  examples = '["What is the reason for the delay?", "The reason why we need this is clear.", "For this reason, we should wait.", "She has a good reason to be upset."]'::jsonb,
  collocations = '["the reason for", "the reason why", "for this reason", "good reason", "main reason"]'::jsonb,
  patterns = '["reason + for", "reason + why", "for this reason"]'::jsonb,
  updated_at = now()
WHERE headword = 'reason';

-- Noun: way
UPDATE lexicon_entries
SET
  ipa = 'weɪ',
  definition_simple = 'a method or manner of doing something, or a path or route',
  definition_teacher = 'noun: countable; multiple meanings including method, manner, direction, or distance; neutral register; highly versatile and frequent term',
  usage_notes = 'Versatile term with multiple meanings. Method: "a way to do", "the best way". Direction: "this way", "on the way". Common phrases: "by the way" (incidentally), "in a way" (to some extent), "no way" (impossible/refusal). Very common in all contexts.',
  register = 'neutral',
  variety = 'international',
  examples = '["This is the best way to solve it.", "Which way should we go?", "By the way, the meeting is tomorrow.", "There is no way to finish today."]'::jsonb,
  collocations = '["the best way", "this way", "by the way", "on the way", "no way", "in a way"]'::jsonb,
  patterns = '["way + to-infinitive", "this/that way", "by the way", "on the way"]'::jsonb,
  updated_at = now()
WHERE headword = 'way';

-- Noun: thing
UPDATE lexicon_entries
SET
  ipa = 'θɪŋ',
  definition_simple = 'an object, action, idea, or situation that you refer to',
  definition_teacher = 'noun: countable; highly general term referring to any object, concept, action, or situation; neutral register; extremely versatile and frequent',
  usage_notes = 'Very general and versatile term. Can refer to objects, actions, situations, or concepts. Common phrases: "the thing is" (the point is), "things" (situation/belongings), "do things", "all things". Very common in informal and neutral contexts. Brazilian learners use this correctly but should learn more specific vocabulary.',
  register = 'neutral',
  variety = 'international',
  examples = '["What is that thing?", "The thing is, we need more time.", "How are things at work?", "I have many things to do today."]'::jsonb,
  collocations = '["the thing is", "things to do", "all things", "many things", "good thing"]'::jsonb,
  patterns = '["the thing + is", "things + to-infinitive", "many/all things"]'::jsonb,
  updated_at = now()
WHERE headword = 'thing';

-- Noun: part
UPDATE lexicon_entries
SET
  ipa = 'pɑːt',
  definition_simple = 'one piece or section of something larger',
  definition_teacher = 'noun: countable; also verb meaning to separate; refers to component, section, role, or portion; neutral register; fundamental structural term',
  usage_notes = 'Essential component term. Common phrases: "part of", "take part in" (participate), "play a part" (have a role), "for the most part" (mostly). Very common in professional contexts for describing components and participation. Brazilian learners should note: "take part in" (not "take part of").',
  register = 'neutral',
  variety = 'international',
  examples = '["This is an important part of the project.", "I want to take part in the meeting.", "She plays a key part in the team.", "For the most part, everything is ready."]'::jsonb,
  collocations = '["part of", "take part in", "play a part", "for the most part", "important part"]'::jsonb,
  patterns = '["part + of", "take part + in", "play a part"]'::jsonb,
  updated_at = now()
WHERE headword = 'part';

-- Noun: place
UPDATE lexicon_entries
SET
  ipa = 'pleɪs',
  definition_simple = 'a particular position, point, or area',
  definition_teacher = 'noun: countable; also verb meaning to put or position; refers to location, position, or space; neutral register; fundamental spatial term',
  usage_notes = 'Essential location term. Common phrases: "in place" (positioned), "take place" (happen), "in the first place" (firstly/originally), "place of work". Very common in all contexts. Brazilian learners should note: "take place" means "happen" (not "take a place").',
  register = 'neutral',
  variety = 'international',
  examples = '["This is a good place to work.", "The meeting takes place tomorrow.", "Everything is in place.", "What is your place of birth?"]'::jsonb,
  collocations = '["take place", "in place", "in the first place", "place of work", "good place"]'::jsonb,
  patterns = '["take place", "in place", "place + of", "good/bad place"]'::jsonb,
  updated_at = now()
WHERE headword = 'place';

-- Noun: point
UPDATE lexicon_entries
SET
  ipa = 'pɔɪnt',
  definition_simple = 'a particular fact, idea, or detail, or the main purpose of something',
  definition_teacher = 'noun: countable; also verb; multiple meanings including purpose, detail, location, or score; neutral register; highly versatile term',
  usage_notes = 'Versatile term with multiple meanings. Purpose: "the point is", "what''s the point". Detail: "good point", "key point". Location: "starting point". Common phrases: "at this point" (now), "to the point" (relevant). Very common in professional discussions.',
  register = 'neutral',
  variety = 'international',
  examples = '["That is a good point.", "What is the point of this meeting?", "At this point, we should decide.", "Please get to the point."]'::jsonb,
  collocations = '["good point", "the point is", "at this point", "key point", "to the point", "starting point"]'::jsonb,
  patterns = '["good/key point", "the point + is", "at this point", "to the point"]'::jsonb,
  updated_at = now()
WHERE headword = 'point';

-- End of Batch 5
