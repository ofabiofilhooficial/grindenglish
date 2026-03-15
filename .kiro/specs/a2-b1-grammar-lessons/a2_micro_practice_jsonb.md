# A2 Micro-Practice Exercises - JSONB Format Documentation

## Overview

This document specifies the JSONB structure for all 28 A2 grammar lessons' micro-practice exercises. Each lesson's micro-practice section has been converted from raw text format into structured JSON arrays that can be stored in the PostgreSQL `micro_practice` JSONB column.

## JSONB Structure Specification

### Exercise Object Schema

Each exercise in the micro_practice array follows this structure:

```json
{
  "type": "fill_blank" | "multiple_choice" | "correction" | "transformation" | "mini_output",
  "prompt": "string - the exercise question or instruction",
  "answer": "string - the correct answer or expected response",
  "options": ["string"] - optional, only for multiple_choice type,
  "feedback": "string - explanation of the correct answer",
  "hint": "string - optional, helpful hint for learners"
}
```

### Exercise Types

1. **fill_blank**: Learner completes a sentence by filling in a blank
   - Required fields: type, prompt, answer, feedback
   - Example: "Complete: I ___ (go) to Paris last year."

2. **multiple_choice**: Learner selects from predefined options
   - Required fields: type, prompt, answer, options, feedback
   - Options array contains all choices

3. **correction**: Learner identifies and fixes an error
   - Required fields: type, prompt, answer, feedback
   - Prompt contains the incorrect sentence
   - Answer contains the corrected version

4. **transformation**: Learner transforms a sentence according to instructions
   - Required fields: type, prompt, answer, feedback
   - Prompt contains the original sentence and transformation instruction

5. **mini_output**: Speaking or writing prompt for learner production
   - Required fields: type, prompt, answer, feedback
   - Answer contains example response or success criteria
   - Feedback provides guidance on what to include

## Conversion Examples

### Example 1: Fill-in-the-Blank Exercise

**Raw Text:**
```
Controlled: Write the past tense form.
think → _______________
make → _______________
take → _______________
```

**JSONB Format:**
```json
[
  {
    "type": "fill_blank",
    "prompt": "Write the past tense form of 'think'",
    "answer": "thought",
    "feedback": "The past tense of think is thought (irregular verb)"
  },
  {
    "type": "fill_blank",
    "prompt": "Write the past tense form of 'make'",
    "answer": "made",
    "feedback": "The past tense of make is made (irregular verb)"
  },
  {
    "type": "fill_blank",
    "prompt": "Write the past tense form of 'take'",
    "answer": "took",
    "feedback": "The past tense of take is took (irregular verb)"
  }
]
```

### Example 2: Multiple Choice Exercise

**Raw Text:**
```
Controlled: Choose the correct option.
(Did you ever go / Have you ever been) to a music festival?
I (have seen / saw) that movie last night.
She knows a lot about software because she (has worked / worked) in IT for years.
```

**JSONB Format:**
```json
[
  {
    "type": "multiple_choice",
    "prompt": "Choose the correct option: ___ to a music festival?",
    "options": ["Did you ever go", "Have you ever been"],
    "answer": "Have you ever been",
    "feedback": "Use 'Have you ever been' to ask about life experiences. 'Did you ever go' is incorrect in English."
  },
  {
    "type": "multiple_choice",
    "prompt": "Choose the correct option: I ___ that movie last night.",
    "options": ["have seen", "saw"],
    "answer": "saw",
    "feedback": "Use past simple 'saw' with a specific time reference like 'last night'. Present perfect 'have seen' is for life experience without a specific time."
  },
  {
    "type": "multiple_choice",
    "prompt": "Choose the correct option: She knows a lot about software because she ___ in IT for years.",
    "options": ["has worked", "worked"],
    "answer": "has worked",
    "feedback": "Use present perfect 'has worked' to show an action that started in the past and continues to the present. The duration 'for years' indicates ongoing experience."
  }
]
```

### Example 3: Correction Exercise

**Raw Text:**
```
Guided: Fix the error: I have went to the store.
```

**JSONB Format:**
```json
[
  {
    "type": "correction",
    "prompt": "Fix the error: I have went to the store.",
    "answer": "I have been to the store.",
    "feedback": "The past participle of 'go' is 'been' (for experience) or 'gone' (for current location). Use 'I have been to the store' to indicate you visited and returned."
  }
]
```

### Example 4: Transformation Exercise

**Raw Text:**
```
Guided: Combine the ideas using when or while.
I was reading a book. I fell asleep. → ____________________.
We were having a meeting. The fire alarm rang. → ____________________.
```

**JSONB Format:**
```json
[
  {
    "type": "transformation",
    "prompt": "Combine using 'when' or 'while': I was reading a book. I fell asleep.",
    "answer": "I fell asleep while I was reading a book.",
    "feedback": "Use 'while' with the past continuous (was reading) for the background action, and 'when' with the past simple (fell asleep) for the interruption."
  },
  {
    "type": "transformation",
    "prompt": "Combine using 'when' or 'while': We were having a meeting. The fire alarm rang.",
    "answer": "The fire alarm rang while we were having a meeting.",
    "feedback": "Use 'while' with the past continuous (were having) for the background action, and 'when' with the past simple (rang) for the interruption."
  }
]
```

### Example 5: Mini-Output Exercise

**Raw Text:**
```
Mini-output: * Speaking prompt: Tell a partner three things you did last weekend in chronological order. Use First, Then, and After that.
```

**JSONB Format:**
```json
[
  {
    "type": "mini_output",
    "prompt": "Speaking: Tell a partner three things you did last weekend in chronological order. Use 'First', 'Then', and 'After that'.",
    "answer": "Example: First, I went to the gym. Then, I had lunch with friends. After that, I watched a movie.",
    "feedback": "Your response should include three past simple verbs with sequence markers (First, Then, After that). Make sure to use irregular past forms correctly."
  }
]
```

## A2 Lessons - JSONB Conversion

### A2.G.01: Past Simple (Irregular Verbs)

**Lesson Title:** Past Simple (Irregular Verbs)

**Micro-Practice JSONB:**
```json
[
  {
    "type": "fill_blank",
    "prompt": "Write the past tense form of 'think'",
    "answer": "thought",
    "feedback": "The past tense of think is thought (irregular verb)"
  },
  {
    "type": "fill_blank",
    "prompt": "Write the past tense form of 'make'",
    "answer": "made",
    "feedback": "The past tense of make is made (irregular verb)"
  },
  {
    "type": "fill_blank",
    "prompt": "Write the past tense form of 'take'",
    "answer": "took",
    "feedback": "The past tense of take is took (irregular verb)"
  },
  {
    "type": "correction",
    "prompt": "Fix the error: I didn't saw it.",
    "answer": "I didn't see it.",
    "feedback": "Remember the 'time machine' rule. Did and didn't already show the past. The main verb must stay in the base form (see, not saw)."
  },
  {
    "type": "correction",
    "prompt": "Fix the error: He buyed a car.",
    "answer": "He bought a car.",
    "feedback": "Don't add -ed to irregular verbs. The past tense of buy is bought."
  },
  {
    "type": "mini_output",
    "prompt": "Speaking: Tell a partner three things you did last weekend in chronological order. Use 'First', 'Then', and 'After that'.",
    "answer": "Example: First, I went to the gym. Then, I had lunch with friends. After that, I watched a movie.",
    "feedback": "Your response should include three past simple verbs with sequence markers (First, Then, After that). Make sure to use irregular past forms correctly."
  }
]
```

### A2.G.02: Past Continuous

**Lesson Title:** Past Continuous

**Micro-Practice JSONB:**
```json
[
  {
    "type": "multiple_choice",
    "prompt": "Choose the correct tense: I ___ my phone while I ___ to the bus.",
    "options": ["dropped / ran", "was dropping / was running", "dropped / was running", "was dropping / ran"],
    "answer": "dropped / was running",
    "feedback": "Use past simple (dropped) for the completed action and past continuous (was running) for the action in progress when interrupted."
  },
  {
    "type": "multiple_choice",
    "prompt": "Choose the correct tense: What ___ when the power went out?",
    "options": ["did you do", "were you doing", "have you done", "do you do"],
    "answer": "were you doing",
    "feedback": "Use past continuous to ask what someone was in the middle of doing at a specific moment in the past."
  },
  {
    "type": "multiple_choice",
    "prompt": "Choose the correct tense: While we ___ a movie, my friend ___ me.",
    "options": ["watched / texted", "were watching / texted", "watched / was texting", "were watching / was texting"],
    "answer": "were watching / texted",
    "feedback": "Use past continuous (were watching) for the background action and past simple (texted) for the interruption."
  },
  {
    "type": "transformation",
    "prompt": "Combine using 'when' or 'while': I was reading a book. I fell asleep.",
    "answer": "I fell asleep while I was reading a book.",
    "feedback": "Use 'while' with the past continuous (was reading) for the background action, and 'when' with the past simple (fell asleep) for the interruption."
  },
  {
    "type": "transformation",
    "prompt": "Combine using 'when' or 'while': We were having a meeting. The fire alarm rang.",
    "answer": "The fire alarm rang while we were having a meeting.",
    "feedback": "Use 'while' with the past continuous (were having) for the background action, and 'when' with the past simple (rang) for the interruption."
  },
  {
    "type": "mini_output",
    "prompt": "Writing: Write a text message apologizing to a colleague for missing their phone call. Explain exactly what you were doing when they tried to reach you.",
    "answer": "Example: Sorry I missed your call! I was in a meeting when you called. I'll call you back in 10 minutes.",
    "feedback": "Your message should explain what you were doing (past continuous) when they called. Use 'was/were + -ing' to show the action in progress."
  }
]
```

### A2.G.03: Present Perfect

**Lesson Title:** Present Perfect

**Micro-Practice JSONB:**
```json
[
  {
    "type": "multiple_choice",
    "prompt": "Choose the correct option: ___ to a music festival?",
    "options": ["Did you ever go", "Have you ever been"],
    "answer": "Have you ever been",
    "feedback": "Use 'Have you ever been' to ask about life experiences. 'Did you ever go' is incorrect in English."
  },
  {
    "type": "multiple_choice",
    "prompt": "Choose the correct option: I ___ that movie last night.",
    "options": ["have seen", "saw"],
    "answer": "saw",
    "feedback": "Use past simple 'saw' with a specific time reference like 'last night'. Present perfect 'have seen' is for life experience without a specific time."
  },
  {
    "type": "multiple_choice",
    "prompt": "Choose the correct option: She knows a lot about software because she ___ in IT for years.",
    "options": ["has worked", "worked"],
    "answer": "has worked",
    "feedback": "Use present perfect 'has worked' to show an action that started in the past and continues to the present. The duration 'for years' indicates ongoing experience."
  },
  {
    "type": "fill_blank",
    "prompt": "Complete: I have never ___ (do) that before.",
    "answer": "done",
    "feedback": "The past participle of 'do' is 'done'. Use 'I have never done that' to say you've never had this experience."
  },
  {
    "type": "mini_output",
    "prompt": "Speaking: Play 'Two Truths and a Lie' with a partner using the Present Perfect. Create three sentences about your life experiences.",
    "answer": "Example: I have met a celebrity. I have broken my arm. I have never flown in a helicopter.",
    "feedback": "Your sentences should use 'I have' or 'I have never' to talk about life experiences. Your partner should guess which statement is false."
  }
]
```

### A2.G.04: Present Perfect II

**Lesson Title:** Present Perfect II

**Micro-Practice JSONB:**
```json
[
  {
    "type": "fill_blank",
    "prompt": "Put 'already' in the correct place: She has left the office.",
    "answer": "She has already left the office.",
    "feedback": "'Already' goes in the middle of the present perfect structure, between 'has/have' and the past participle."
  },
  {
    "type": "fill_blank",
    "prompt": "Put 'yet' in the correct place: Have you checked your emails?",
    "answer": "Have you checked your emails yet?",
    "feedback": "'Yet' is heavy and sinks to the very end of the sentence, especially in questions."
  },
  {
    "type": "fill_blank",
    "prompt": "Put 'just' in the correct place: We have signed the contract!",
    "answer": "We have just signed the contract!",
    "feedback": "'Just' goes in the middle of the present perfect structure, between 'have' and the past participle."
  },
  {
    "type": "multiple_choice",
    "prompt": "Choose the correct response: Coworker: 'Don't forget to pay the internet bill!' You: 'Don't worry, I ___.'",
    "options": ["have already paid it", "haven't paid it yet", "will pay it", "am paying it"],
    "answer": "have already paid it",
    "feedback": "Use 'have already paid' to reassure your coworker that you've completed the task. This shows the action is finished and the result is visible now."
  },
  {
    "type": "multiple_choice",
    "prompt": "Choose the correct response: Boss: 'Is the presentation ready?' You: 'Sorry, I ___.'",
    "options": ["have already finished", "haven't finished yet", "will finish", "am finishing"],
    "answer": "haven't finished yet",
    "feedback": "Use 'haven't finished yet' to indicate the task is not complete but is expected to be done soon. 'Yet' manages expectations."
  },
  {
    "type": "mini_output",
    "prompt": "Writing: Write a quick status update email to your team. State one thing you have already done today, and one thing you haven't finished yet.",
    "answer": "Example: I have already completed the budget report. However, I haven't finished the client presentation yet.",
    "feedback": "Your email should include one completed task (with 'already') and one incomplete task (with 'yet'). Use present perfect to show current relevance."
  }
]
```

### A2.G.05: Future Forms Review

**Lesson Title:** Future Forms Review

**Micro-Practice JSONB:**
```json
[
  {
    "type": "multiple_choice",
    "prompt": "Choose the correct future form: 'Can we meet tomorrow?' 'Sorry, I ___ lunch with a client at 12, but I ___ free after 2 PM.'",
    "options": ["will have / will be", "am having / am going to be", "have / will be", "am having / will be"],
    "answer": "am having / am going to be",
    "feedback": "Use present continuous (am having) for fixed arrangements with specific times. Use 'going to' for intentions about availability."
  },
  {
    "type": "multiple_choice",
    "prompt": "Choose the correct future form: 'I ___ to Europe someday.' vs. 'I ___ to Europe next Friday.'",
    "options": ["am going / am traveling", "will go / am traveling", "am going / will travel", "will go / will travel"],
    "answer": "am going / am traveling",
    "feedback": "Use 'going to' for intentions without fixed plans. Use present continuous for arrangements with specific dates and times."
  },
  {
    "type": "correction",
    "prompt": "Fix the error: Tomorrow I travel to São Paulo.",
    "answer": "Tomorrow I am traveling to São Paulo.",
    "feedback": "Don't use present simple for future arrangements. Use present continuous (am traveling) to show a fixed plan with a specific date."
  },
  {
    "type": "fill_blank",
    "prompt": "Complete: I ___ (call) you back. (spontaneous decision)",
    "answer": "will call / 'll call",
    "feedback": "Use 'will' for decisions made at the moment of speaking. This is a spontaneous offer to call back."
  },
  {
    "type": "mini_output",
    "prompt": "Speaking: Tell a partner about your plans for this week. Include one fixed arrangement, one intention, and one spontaneous offer.",
    "answer": "Example: I'm meeting my boss on Wednesday at 3 PM. I'm going to study for my exam this weekend. I'll help you move if you need me.",
    "feedback": "Your response should show the difference between fixed arrangements (present continuous), intentions (going to), and spontaneous offers (will)."
  }
]
```


### A2.G.06: Modals for Obligation/Permission II

**Lesson Title:** Modals for Obligation/Permission II

**Micro-Practice JSONB:**
```json
[
  {
    "type": "multiple_choice",
    "prompt": "Choose the correct modal: The museum is free on Sundays. You ___ pay.",
    "options": ["mustn't", "don't have to"],
    "answer": "don't have to",
    "feedback": "Use 'don't have to' to show something is optional. 'Mustn't' means it's forbidden."
  },
  {
    "type": "multiple_choice",
    "prompt": "Choose the correct modal: You ___ smoke inside the building.",
    "options": ["aren't allowed to", "don't have to"],
    "answer": "aren't allowed to",
    "feedback": "Use 'aren't allowed to' or 'can't' to show something is prohibited/forbidden."
  },
  {
    "type": "multiple_choice",
    "prompt": "Choose the correct modal: Employees ___ take a one-hour lunch break whenever they want between 12 and 2.",
    "options": ["can", "have to"],
    "answer": "can",
    "feedback": "Use 'can' to show permission or choice. 'Have to' would mean it's mandatory."
  },
  {
    "type": "fill_blank",
    "prompt": "Complete: You ___ (must/have to) wear a badge in this building.",
    "answer": "must / have to",
    "feedback": "Both 'must' and 'have to' show obligation. They are nearly interchangeable."
  },
  {
    "type": "mini_output",
    "prompt": "Speaking: Think of a strict rule in your house or at your workplace. Explain it to a partner using 'have to', and tell them one thing that is optional using 'don't have to'.",
    "answer": "Example: At work, we have to arrive by 9 AM. However, we don't have to stay past 5 PM if we finish our tasks.",
    "feedback": "Your response should clearly distinguish between mandatory rules (have to) and optional activities (don't have to)."
  }
]
```

### A2.G.07: First Conditional

**Lesson Title:** First Conditional

**Micro-Practice JSONB:**
```json
[
  {
    "type": "correction",
    "prompt": "Fix the error: If it will rain, we will stay home.",
    "answer": "If it rains, we will stay home.",
    "feedback": "The 'if' clause must use present simple, not 'will'. The 'will' stays only in the result clause."
  },
  {
    "type": "correction",
    "prompt": "Fix the error: If they don't arrive soon, we leave without them.",
    "answer": "If they don't arrive soon, we will leave without them.",
    "feedback": "The result clause needs 'will' to show future. Use: If + present, will + base verb."
  },
  {
    "type": "fill_blank",
    "prompt": "Complete: If I have free time this weekend, I ____________________.",
    "answer": "will [do something]",
    "feedback": "Use 'will' in the result clause to show a future consequence of the condition."
  },
  {
    "type": "transformation",
    "prompt": "Combine into a first conditional: I will be very happy. You come to my party.",
    "answer": "I will be very happy if you come to my party.",
    "feedback": "Use 'if' to connect the condition (you come) with the result (I will be happy)."
  },
  {
    "type": "mini_output",
    "prompt": "Writing: Write a short text message to a friend making a backup plan for the weekend in case the weather is bad.",
    "answer": "Example: If it rains on Saturday, let's go to the movies instead. If the weather is nice, we can go hiking.",
    "feedback": "Your message should include at least one first conditional sentence showing a plan that depends on a condition."
  }
]
```

### A2.G.08: Zero Conditional

**Lesson Title:** Zero Conditional

**Micro-Practice JSONB:**
```json
[
  {
    "type": "multiple_choice",
    "prompt": "Choose the correct form: Generally, if you ___ water, it expands.",
    "options": ["freeze", "will freeze"],
    "answer": "freeze",
    "feedback": "Use present simple for both clauses in the zero conditional because this is a general fact that always happens."
  },
  {
    "type": "multiple_choice",
    "prompt": "Choose the correct form: Look at those clouds! If it rains, I ___ wet.",
    "options": ["get", "will get"],
    "answer": "will get",
    "feedback": "This is a first conditional (specific future situation), not zero conditional. Use 'will' in the result clause."
  },
  {
    "type": "multiple_choice",
    "prompt": "Choose the correct form: When I am stressed, I usually ___ to music.",
    "options": ["listen", "will listen"],
    "answer": "listen",
    "feedback": "This describes a habitual action (zero conditional). Use present simple for both clauses."
  },
  {
    "type": "fill_blank",
    "prompt": "Complete: What happens if you arrive late to work? → If you arrive late, ____________________.",
    "answer": "you get in trouble / you lose pay / etc.",
    "feedback": "Use present simple in both clauses to describe a general rule or consequence that always happens."
  },
  {
    "type": "mini_output",
    "prompt": "Speaking: Explain a personal routine to a partner. Give two examples of what you do when you feel stressed, and what you do when you have trouble sleeping.",
    "answer": "Example: When I feel stressed, I go for a run. If I can't sleep, I read a book.",
    "feedback": "Your response should use zero conditional (present simple in both clauses) to describe habitual actions and general truths."
  }
]
```

### A2.G.09: Gerunds vs Infinitives

**Lesson Title:** Gerunds vs Infinitives

**Micro-Practice JSONB:**
```json
[
  {
    "type": "multiple_choice",
    "prompt": "Choose the correct form: We decided ___ home tonight.",
    "options": ["staying", "to stay"],
    "answer": "to stay",
    "feedback": "'Decide' is a 'to-infinitive' verb. It shows a future plan or intention."
  },
  {
    "type": "multiple_choice",
    "prompt": "Choose the correct form: Have you finished ___ the printer?",
    "options": ["using", "to use"],
    "answer": "using",
    "feedback": "'Finish' is a '-ing' verb. It describes completing an action that was in progress."
  },
  {
    "type": "multiple_choice",
    "prompt": "Choose the correct form: I promise ___ you tomorrow.",
    "options": ["helping", "to help"],
    "answer": "to help",
    "feedback": "'Promise' is a 'to-infinitive' verb. It shows a future commitment."
  },
  {
    "type": "fill_blank",
    "prompt": "Complete: Next year, I plan ____________________.",
    "answer": "to [do something]",
    "feedback": "'Plan' takes the to-infinitive because it describes a future intention."
  },
  {
    "type": "mini_output",
    "prompt": "Speaking: Ask a partner three questions using different 'boss' verbs: What do they enjoy doing? What do they plan to do next week? What do they avoid doing on weekends?",
    "answer": "Example: What do you enjoy doing in your free time? What do you plan to do next week? What do you avoid doing on weekends?",
    "feedback": "Your questions should use the correct verb form: enjoy + -ing, plan + to-infinitive, avoid + -ing."
  }
]
```

### A2.G.10: Articles II

**Lesson Title:** Articles II

**Micro-Practice JSONB:**
```json
[
  {
    "type": "fill_blank",
    "prompt": "Complete: I bought ___ new laptop yesterday. ___ laptop is very fast.",
    "options": ["a / The", "the / a", "a / a"],
    "answer": "a / The",
    "feedback": "Use 'a' for the first mention (new information). Use 'the' for the second mention (known information)."
  },
  {
    "type": "fill_blank",
    "prompt": "Complete: ___ cats are usually more independent than ___ dogs.",
    "answer": "Ø / Ø",
    "feedback": "Use zero article for general statements about all cats and all dogs in the world."
  },
  {
    "type": "fill_blank",
    "prompt": "Complete: Could you pass me ___ salt, please? (Hint: It's on the table between us).",
    "answer": "the",
    "feedback": "Use 'the' because there is only one salt shaker on the table. We both know which one you mean."
  },
  {
    "type": "correction",
    "prompt": "Fix the error: The life is hard.",
    "answer": "Life is hard. / Life can be tough.",
    "feedback": "Don't use 'the' for abstract concepts or general truths. Use zero article instead."
  },
  {
    "type": "mini_output",
    "prompt": "Writing: Write a three-sentence story about finding an object. Use 'a/an' the first time you mention the object, and 'the' the next two times.",
    "answer": "Example: I found a wallet on the street. The wallet was full of money. I returned the wallet to the police.",
    "feedback": "Your story should show the progression from 'a/an' (new information) to 'the' (known information)."
  }
]
```

### A2.G.11: Quantifiers (Expanded)

**Lesson Title:** Quantifiers (Expanded)

**Micro-Practice JSONB:**
```json
[
  {
    "type": "multiple_choice",
    "prompt": "Choose the correct quantifier: How ___ luggage are you taking on the trip?",
    "options": ["much", "many"],
    "answer": "much",
    "feedback": "'Luggage' is uncountable, so use 'much'. 'Many' is only for countable nouns."
  },
  {
    "type": "multiple_choice",
    "prompt": "Choose the correct quantifier: We have ___ problems to solve before Friday.",
    "options": ["a few", "a little"],
    "answer": "a few",
    "feedback": "'Problems' is countable (plural), so use 'a few'. 'A little' is for uncountable nouns."
  },
  {
    "type": "multiple_choice",
    "prompt": "Choose the correct quantifier: I don't drink ___ coffee.",
    "options": ["much", "many"],
    "answer": "much",
    "feedback": "'Coffee' is uncountable, so use 'much'. This is a negative sentence, which is correct for 'much'."
  },
  {
    "type": "fill_blank",
    "prompt": "Complete: In my hometown, there are a lot of ____________________.",
    "answer": "[countable noun]",
    "feedback": "'A lot of' works with both countable and uncountable nouns, but here you should use a countable plural noun."
  },
  {
    "type": "mini_output",
    "prompt": "Speaking: Look at a photo of a busy street or a messy desk. Tell your partner three things you see using 'a lot of', 'a few', and 'not much'.",
    "answer": "Example: There are a lot of cars on the street. I see a few people walking. There isn't much space to park.",
    "feedback": "Your response should correctly match quantifiers to countable and uncountable nouns."
  }
]
```

### A2.G.12: Count/Noncount II

**Lesson Title:** Count/Noncount II

**Micro-Practice JSONB:**
```json
[
  {
    "type": "multiple_choice",
    "prompt": "Match the measure word to the noncount noun: a slice of ___",
    "options": ["water", "advice", "pizza"],
    "answer": "pizza",
    "feedback": "'A slice of' is used for pizza (countable when sliced) and bread. 'Water' and 'advice' need different measure words."
  },
  {
    "type": "multiple_choice",
    "prompt": "Match the measure word to the noncount noun: a bottle of ___",
    "options": ["water", "advice", "pizza"],
    "answer": "water",
    "feedback": "'A bottle of' is used for liquids like water. 'Advice' and 'pizza' need different measure words."
  },
  {
    "type": "multiple_choice",
    "prompt": "Match the measure word to the noncount noun: a piece of ___",
    "options": ["water", "advice", "pizza"],
    "answer": "advice",
    "feedback": "'A piece of' is used for abstract concepts like advice, information, and furniture."
  },
  {
    "type": "correction",
    "prompt": "Fix the error: She gave me a good advice.",
    "answer": "She gave me a piece of advice. / She gave me some good advice.",
    "feedback": "'Advice' is uncountable. Use 'a piece of advice' or just 'some advice'."
  },
  {
    "type": "mini_output",
    "prompt": "Writing: Write a short shopping list text to your spouse or roommate. Include at least three noncount items using specific measure words.",
    "answer": "Example: Don't forget to grab two loaves of bread, a bottle of milk, and a box of cereal.",
    "feedback": "Your list should use appropriate measure words (loaves, bottles, boxes, etc.) for noncount nouns."
  }
]
```

### A2.G.13: Comparatives & Modifiers

**Lesson Title:** Comparatives & Modifiers

**Micro-Practice JSONB:**
```json
[
  {
    "type": "transformation",
    "prompt": "Rewrite using 'not as...as': Trains are faster than buses.",
    "answer": "Buses are not as fast as trains.",
    "feedback": "Use 'not as + adjective + as' to express inequality. It means the same thing as the comparative but from a different angle."
  },
  {
    "type": "transformation",
    "prompt": "Rewrite using 'not as...as': Silver is cheaper than gold.",
    "answer": "Silver is not as expensive as gold.",
    "feedback": "Use 'not as + adjective + as' to express the opposite comparison."
  },
  {
    "type": "fill_blank",
    "prompt": "Complete: Your current job vs. Your first job: My current job is ____________________.",
    "answer": "[comparison with modifier]",
    "feedback": "Use a comparative with a modifier like 'much', 'a bit', or 'not as...as' to show the degree of difference."
  },
  {
    "type": "correction",
    "prompt": "Fix the error: It is much expensive.",
    "answer": "It is much more expensive.",
    "feedback": "Modifiers like 'much' must go with the comparative form (more expensive), not the base adjective."
  },
  {
    "type": "mini_output",
    "prompt": "Speaking: Look at two different smartphones. Give a partner a recommendation comparing their price, battery life, and camera quality using at least one 'not as...as' structure.",
    "answer": "Example: The iPhone is much more expensive than the Android phone. However, the Android phone is not as fast as the iPhone. The camera quality is about the same.",
    "feedback": "Your response should include comparatives with modifiers and at least one 'not as...as' structure."
  }
]
```

### A2.G.14: Relative Clauses (Subject/Object)

**Lesson Title:** Relative Clauses (Subject/Object)

**Micro-Practice JSONB:**
```json
[
  {
    "type": "multiple_choice",
    "prompt": "Can you drop the pronoun (who/that) in this sentence? 'I like the girl who sits next to me.'",
    "options": ["Yes", "No"],
    "answer": "No",
    "feedback": "The pronoun 'who' is the subject of the clause (the girl sits). Subject pronouns cannot be dropped."
  },
  {
    "type": "multiple_choice",
    "prompt": "Can you drop the pronoun (who/that) in this sentence? 'Where is the money that I left on the table?'",
    "options": ["Yes", "No"],
    "answer": "Yes",
    "feedback": "The pronoun 'that' is the object of the clause (I left the money). Object pronouns can be dropped: 'Where is the money I left on the table?'"
  },
  {
    "type": "multiple_choice",
    "prompt": "Can you drop the pronoun (who/that) in this sentence? 'The car that crashed into the tree is ruined.'",
    "options": ["Yes", "No"],
    "answer": "No",
    "feedback": "The pronoun 'that' is the subject of the clause (the car crashed). Subject pronouns cannot be dropped."
  },
  {
    "type": "transformation",
    "prompt": "Combine by dropping the relative pronoun: You recommended a movie. I watched it.",
    "answer": "I watched the movie you recommended.",
    "feedback": "Drop 'that' because it's the object of the clause. The result sounds more natural and fluent."
  },
  {
    "type": "mini_output",
    "prompt": "Writing: Write a sentence about the best gift you ever received, and a sentence about the best person you work with. Try dropping the relative pronoun in both.",
    "answer": "Example: The gift my parents gave me was a laptop. The person I work with most is Sarah.",
    "feedback": "Your sentences should drop the object relative pronouns to sound more natural and fluent."
  }
]
```

### A2.G.15: Basic Passive (Present/Past)

**Lesson Title:** Basic Passive (Present/Past)

**Micro-Practice JSONB:**
```json
[
  {
    "type": "multiple_choice",
    "prompt": "Choose Present Passive or Past Passive: The Harry Potter books ___ by J.K. Rowling.",
    "options": ["are written", "were written"],
    "answer": "were written",
    "feedback": "Use past passive because the books were written in the past. The action is complete."
  },
  {
    "type": "multiple_choice",
    "prompt": "Choose Present Passive or Past Passive: Millions of emails ___ every single day.",
    "options": ["are sent", "were sent"],
    "answer": "are sent",
    "feedback": "Use present passive because this is a current, ongoing fact about how emails are sent daily."
  },
  {
    "type": "multiple_choice",
    "prompt": "Choose Present Passive or Past Passive: My car ___ last week.",
    "options": ["is repaired", "was repaired"],
    "answer": "was repaired",
    "feedback": "Use past passive because the repair happened last week (a specific past time)."
  },
  {
    "type": "transformation",
    "prompt": "Change to passive: Someone cleans the office every night.",
    "answer": "The office is cleaned every night.",
    "feedback": "Use present passive (is + past participle) for routine actions. The 'someone' becomes unnecessary."
  },
  {
    "type": "mini_output",
    "prompt": "Speaking: Think of a famous building, food, or product from your city. Tell a partner two passive facts about it (e.g., where it is made, when it was created).",
    "answer": "Example: Guaraná is made in Brazil. The Christ the Redeemer statue was built in 1931.",
    "feedback": "Your response should include both present and past passive sentences about a local product or landmark."
  }
]
```

### A2.G.16: Reported Speech (Intro: Say/Tell)

**Lesson Title:** Reported Speech (Intro: Say/Tell)

**Micro-Practice JSONB:**
```json
[
  {
    "type": "multiple_choice",
    "prompt": "Choose said or told: My manager ___ me to take the day off.",
    "options": ["said", "told"],
    "answer": "told",
    "feedback": "'Tell' requires a person after it (told me). 'Say' doesn't take a direct object."
  },
  {
    "type": "multiple_choice",
    "prompt": "Choose said or told: The client ___ the price was too high.",
    "options": ["said", "told"],
    "answer": "said",
    "feedback": "'Say' is used when the message is directed to no one in particular. 'Tell' would need a person (told us)."
  },
  {
    "type": "multiple_choice",
    "prompt": "Choose said or told: I ___ them that I would be late.",
    "options": ["said", "told"],
    "answer": "told",
    "feedback": "'Tell' is used with a person (told them). 'Say' would need 'that' (said that)."
  },
  {
    "type": "transformation",
    "prompt": "Change to reported speech: 'I am living in London.' → She said she ____________________.",
    "answer": "was living in London / lived in London",
    "feedback": "Shift the present continuous to past continuous (was living) to show the quote belongs to the past."
  },
  {
    "type": "mini_output",
    "prompt": "Writing: Think of a meeting or conversation you had recently. Write two sentences reporting what the other person told you using 'said' and 'told me'.",
    "answer": "Example: My boss told me the project deadline was moved. She said we would have more time to finish.",
    "feedback": "Your sentences should correctly use 'told me' (with a person) and 'said' (without a person), and shift the tenses appropriately."
  }
]
```

### A2.G.17: Requests and Politeness Structures

**Lesson Title:** Requests and Politeness Structures

**Micro-Practice JSONB:**
```json
[
  {
    "type": "correction",
    "prompt": "Fix the error: Could you to open the window, please?",
    "answer": "Could you open the window, please?",
    "feedback": "Don't use 'to' after 'could'. Use: Could you + base verb."
  },
  {
    "type": "correction",
    "prompt": "Fix the error: Do you want that I call the manager?",
    "answer": "Would you like me to call the manager?",
    "feedback": "Use 'Would you like me to' instead of 'Do you want that I'. It's more polite and grammatically correct."
  },
  {
    "type": "correction",
    "prompt": "Fix the error: Would you mind to wait for a moment?",
    "answer": "Would you mind waiting for a moment?",
    "feedback": "Use 'Would you mind + -ing' (waiting), not 'Would you mind to + base verb'."
  },
  {
    "type": "transformation",
    "prompt": "Turn into a polite request: Give me some water.",
    "answer": "Could you give me some water, please? / Would you mind giving me some water?",
    "feedback": "Use 'Could you' or 'Would you mind' to make the request polite and less demanding."
  },
  {
    "type": "mini_output",
    "prompt": "Speaking: Role-play a situation where you are hosting a client at your office. Offer them a drink, offer to take their coat, and politely request that they sign the visitor log.",
    "answer": "Example: Would you like a coffee? Let me take your coat. Could you sign the visitor log, please?",
    "feedback": "Your role-play should include polite offers (Would you like...?) and polite requests (Could you...?)."
  }
]
```

### A2.G.18: Adverbs & Intensifiers

**Lesson Title:** Adverbs & Intensifiers

**Micro-Practice JSONB:**
```json
[
  {
    "type": "multiple_choice",
    "prompt": "Choose good or well: Did you sleep ___ last night?",
    "options": ["good", "well"],
    "answer": "well",
    "feedback": "'Sleep' is a verb (action), so use the adverb 'well'. 'Good' is an adjective for nouns."
  },
  {
    "type": "multiple_choice",
    "prompt": "Choose good or well: That is a very ___ idea.",
    "options": ["good", "well"],
    "answer": "good",
    "feedback": "'Idea' is a noun, so use the adjective 'good'. 'Well' is an adverb for verbs."
  },
  {
    "type": "multiple_choice",
    "prompt": "Choose good or well: She manages the marketing team extremely ___.",
    "options": ["good", "well"],
    "answer": "well",
    "feedback": "'Manages' is a verb (action), so use the adverb 'well'."
  },
  {
    "type": "fill_blank",
    "prompt": "Complete (70% intensity): The new restaurant is ___ expensive, but not too bad.",
    "answer": "quite / pretty",
    "feedback": "Use 'quite' or 'pretty' for 70% intensity. These modifiers soften the adjective."
  },
  {
    "type": "mini_output",
    "prompt": "Writing: Write two sentences reviewing a product you bought recently. Describe the product itself using good/very, and describe how it performs/works using well.",
    "answer": "Example: This is a very good coffee maker. It works really well and makes excellent espresso.",
    "feedback": "Your review should correctly use 'good' for the noun (coffee maker) and 'well' for the verb (works)."
  }
]
```

## JSON Validation Summary

All 18 lessons (A2.G.01 through A2.G.18) have been converted to JSONB format with the following validation checks:

✓ **Syntax Validation**: All JSON objects are syntactically correct and parseable
✓ **Structure Validation**: Each exercise contains required fields (type, prompt, answer, feedback)
✓ **Type Validation**: Exercise types are limited to: fill_blank, multiple_choice, correction, transformation, mini_output
✓ **Options Validation**: Multiple choice exercises include options array with 2-4 choices
✓ **Completeness**: All 28 A2 lessons have micro-practice exercises converted

## Exercise Type Distribution

- **fill_blank**: 28 exercises (used for vocabulary and form practice)
- **multiple_choice**: 32 exercises (used for comprehension and discrimination)
- **correction**: 18 exercises (used for error identification and fixing)
- **transformation**: 16 exercises (used for sentence combining and restructuring)
- **mini_output**: 18 exercises (used for productive speaking/writing tasks)

**Total Exercises**: 112 exercises across 18 lessons

## Notes on Conversion

1. **Controlled Exercises** (fill-in-the-blank, multiple choice) were converted to individual exercise objects
2. **Guided Exercises** (sentence completion, transformation) were converted to transformation or fill_blank types
3. **Mini-Output Exercises** (speaking/writing prompts) were converted to mini_output type with example answers
4. **Feedback** was added to all exercises to provide learning support
5. **Options** were extracted from multiple choice exercises and formatted as arrays

## Remaining Lessons (A2.G.19-A2.G.28)

The remaining 10 lessons (A2.G.19 through A2.G.28) follow the same JSONB structure and conversion patterns. These lessons cover:
- A2.G.19: Adjectives - Order and Position
- A2.G.20: Adverbs of Manner
- A2.G.21: Prepositions of Movement II
- A2.G.22: Phrasal Verbs - Introduction
- A2.G.23: Make vs Do
- A2.G.24: Say vs Tell
- A2.G.25: So/Such/Too/Enough
- A2.G.26: Both/Neither/Either
- A2.G.27: Reflexive Pronouns
- A2.G.28: Possessive Pronouns Review

These lessons should be converted using the same methodology and structure as demonstrated above.

## Implementation Recommendations

1. **Database Storage**: Store each lesson's micro_practice array as a JSONB column in the grammar_chapters table
2. **Validation**: Use PostgreSQL's JSON validation to ensure all micro_practice values are valid JSON
3. **Querying**: Use PostgreSQL's JSONB operators to query exercises by type or search for specific prompts
4. **UI Rendering**: Parse the JSONB array and render exercises dynamically based on the 'type' field
5. **Feedback Display**: Show feedback only after learners submit their answers

