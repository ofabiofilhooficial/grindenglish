# A2 Cross-Links - JSONB Format Documentation

## Overview

This document specifies the JSONB structure for all 28 A2 grammar lessons' cross-links. Each lesson's cross-links section has been converted from raw text format into structured JSON arrays that can be stored in the PostgreSQL `cross_links` JSONB column.

## JSONB Structure Specification

### Cross-Link Object Schema

Each cross-link in the cross_links array follows this structure:

```json
{
  "type": "prerequisite",
  "chapter_code": "A1.G.11",
  "note": null
}
```

**Valid type values:** "prerequisite", "related", "advanced"

### Link Types

1. **prerequisite**: A lesson that should be studied before this one
   - Typically references A0, A1, or earlier A2 chapters
   - Indicates foundational knowledge needed

2. **related**: A lesson that covers related or complementary content
   - Can reference chapters at the same level or adjacent levels
   - Indicates topics that work well together

3. **advanced**: A lesson that builds on this one (next steps)
   - Typically references later A2, B1, B2, or C1 chapters
   - Indicates progression path for learners

## Conversion Rules

1. "Prerequisites:" section → type: "prerequisite"
2. "Next steps:" section → type: "advanced"
3. Multiple chapters in same section → separate objects in array
4. Optional notes from source → included in "note" field
5. Chapter codes extracted from parenthetical references

## A2 Cross-Links JSONB Conversions

### A2.G.01: Past Simple (Irregular Verbs)

**Source:**
```
Prerequisites: A1.G.11, A1.G.12
Next steps: A2.G.02, B1.G.03 (Narrative tenses)
```

**JSONB:**
```json
[
  {
    "type": "prerequisite",
    "chapter_code": "A1.G.11",
    "note": null
  },
  {
    "type": "prerequisite",
    "chapter_code": "A1.G.12",
    "note": null
  },
  {
    "type": "advanced",
    "chapter_code": "A2.G.02",
    "note": null
  },
  {
    "type": "advanced",
    "chapter_code": "B1.G.03",
    "note": "Narrative tenses"
  }
]
```

---

### A2.G.02: Past Continuous

**Source:**
```
Prerequisites: A1.G.08, A1.G.10
Next steps: B1.G.03 (Narrative tenses)
```

**JSONB:**
```json
[
  {
    "type": "prerequisite",
    "chapter_code": "A1.G.08",
    "note": null
  },
  {
    "type": "prerequisite",
    "chapter_code": "A1.G.10",
    "note": null
  },
  {
    "type": "advanced",
    "chapter_code": "B1.G.03",
    "note": "Narrative tenses"
  }
]
```

---

### A2.G.03: Present Perfect

**Source:**
```
Prerequisites: A2.G.01
Next steps: A2.G.04, B1.G.01
```

**JSONB:**
```json
[
  {
    "type": "prerequisite",
    "chapter_code": "A2.G.01",
    "note": null
  },
  {
    "type": "advanced",
    "chapter_code": "A2.G.04",
    "note": null
  },
  {
    "type": "advanced",
    "chapter_code": "B1.G.01",
    "note": null
  }
]
```

---

### A2.G.04: Present Perfect II

**Source:**
```
Prerequisites: A2.G.03
Next steps: B1.G.01
```

**JSONB:**
```json
[
  {
    "type": "prerequisite",
    "chapter_code": "A2.G.03",
    "note": null
  },
  {
    "type": "advanced",
    "chapter_code": "B1.G.01",
    "note": null
  }
]
```

---

### A2.G.05: Future Forms Review

**Source:**
```
Prerequisites: A1.G.08, A1.G.13, A1.G.14
Next steps: B1.G.05 (Future continuous)
```

**JSONB:**
```json
[
  {
    "type": "prerequisite",
    "chapter_code": "A1.G.08",
    "note": null
  },
  {
    "type": "prerequisite",
    "chapter_code": "A1.G.13",
    "note": null
  },
  {
    "type": "prerequisite",
    "chapter_code": "A1.G.14",
    "note": null
  },
  {
    "type": "advanced",
    "chapter_code": "B1.G.05",
    "note": "Future continuous"
  }
]
```

---

### A2.G.06: Modals for Obligation/Permission II

**Source:**
```
Prerequisites: A1.G.07, A1.G.17
Next steps: B1.G.09 (Modals of advice)
```

**JSONB:**
```json
[
  {
    "type": "prerequisite",
    "chapter_code": "A1.G.07",
    "note": null
  },
  {
    "type": "prerequisite",
    "chapter_code": "A1.G.17",
    "note": null
  },
  {
    "type": "advanced",
    "chapter_code": "B1.G.09",
    "note": "Modals of advice"
  }
]
```

---

### A2.G.07: First Conditional

**Source:**
```
Prerequisites: A1.G.01, A1.G.14
Next steps: B1.G.10 (Conditionals 1 & 2 productive control)
```

**JSONB:**
```json
[
  {
    "type": "prerequisite",
    "chapter_code": "A1.G.01",
    "note": null
  },
  {
    "type": "prerequisite",
    "chapter_code": "A1.G.14",
    "note": null
  },
  {
    "type": "advanced",
    "chapter_code": "B1.G.10",
    "note": "Conditionals 1 & 2 productive control"
  }
]
```

---

### A2.G.08: Zero Conditional

**Source:**
```
Prerequisites: A2.G.07
Next steps: A2.G.25 (Second conditional intro)
```

**JSONB:**
```json
[
  {
    "type": "prerequisite",
    "chapter_code": "A2.G.07",
    "note": null
  },
  {
    "type": "advanced",
    "chapter_code": "A2.G.25",
    "note": "Second conditional intro"
  }
]
```

---

### A2.G.09: Gerunds vs Infinitives

**Source:**
```
Prerequisites: A1.G.09 (Like/love/hate)
Next steps: B1.G.12 (Gerunds/infinitives meaning changes)
```

**JSONB:**
```json
[
  {
    "type": "prerequisite",
    "chapter_code": "A1.G.09",
    "note": "Like/love/hate"
  },
  {
    "type": "advanced",
    "chapter_code": "B1.G.12",
    "note": "Gerunds/infinitives meaning changes"
  }
]
```

---

### A2.G.10: Articles II

**Source:**
```
Prerequisites: A0.G.04
Next steps: B1.G.21, B2.G.20
```

**JSONB:**
```json
[
  {
    "type": "prerequisite",
    "chapter_code": "A0.G.04",
    "note": null
  },
  {
    "type": "advanced",
    "chapter_code": "B1.G.21",
    "note": null
  },
  {
    "type": "advanced",
    "chapter_code": "B2.G.20",
    "note": null
  }
]
```

---

### A2.G.11: Quantifiers (Expanded)

**Source:**
```
Prerequisites: A1.G.05, A1.G.19
Next steps: B1.G.19 (Determiners: all/most/both)
```

**JSONB:**
```json
[
  {
    "type": "prerequisite",
    "chapter_code": "A1.G.05",
    "note": null
  },
  {
    "type": "prerequisite",
    "chapter_code": "A1.G.19",
    "note": null
  },
  {
    "type": "advanced",
    "chapter_code": "B1.G.19",
    "note": "Determiners: all/most/both"
  }
]
```

---

### A2.G.12: Count/Noncount II

**Source:**
```
Prerequisites: A1.G.05
Next steps: B1.G.21
```

**JSONB:**
```json
[
  {
    "type": "prerequisite",
    "chapter_code": "A1.G.05",
    "note": null
  },
  {
    "type": "advanced",
    "chapter_code": "B1.G.21",
    "note": null
  }
]
```

---

### A2.G.13: Comparatives & Modifiers

**Source:**
```
Prerequisites: A1.G.15, A1.G.16
Next steps: B1.G.18 (Comparatives for persuasion)
```

**JSONB:**
```json
[
  {
    "type": "prerequisite",
    "chapter_code": "A1.G.15",
    "note": null
  },
  {
    "type": "prerequisite",
    "chapter_code": "A1.G.16",
    "note": null
  },
  {
    "type": "advanced",
    "chapter_code": "B1.G.18",
    "note": "Comparatives for persuasion"
  }
]
```

---

### A2.G.14: Relative Clauses (Subject/Object)

**Source:**
```
Prerequisites: A1.G.24
Next steps: B1.G.13 (Defining vs. non-defining)
```

**JSONB:**
```json
[
  {
    "type": "prerequisite",
    "chapter_code": "A1.G.24",
    "note": null
  },
  {
    "type": "advanced",
    "chapter_code": "B1.G.13",
    "note": "Defining vs. non-defining"
  }
]
```

---

### A2.G.15: Basic Passive (present/past)

**Source:**
```
Prerequisites: A1.G.10 (Past of be), A2.G.01 (Irregular V3 forms)
Next steps: B1.G.07 (Passive expanded)
```

**JSONB:**
```json
[
  {
    "type": "prerequisite",
    "chapter_code": "A1.G.10",
    "note": "Past of be"
  },
  {
    "type": "prerequisite",
    "chapter_code": "A2.G.01",
    "note": "Irregular V3 forms"
  },
  {
    "type": "advanced",
    "chapter_code": "B1.G.07",
    "note": "Passive expanded"
  }
]
```

---

### A2.G.16: Reported Speech (intro: say/tell)

**Source:**
```
Prerequisites: A1.G.10, A1.G.11
Next steps: B1.G.06 (Reported questions)
```

**JSONB:**
```json
[
  {
    "type": "prerequisite",
    "chapter_code": "A1.G.10",
    "note": null
  },
  {
    "type": "prerequisite",
    "chapter_code": "A1.G.11",
    "note": null
  },
  {
    "type": "advanced",
    "chapter_code": "B1.G.06",
    "note": "Reported questions"
  }
]
```

---

### A2.G.17: Question Tags

**Source:**
```
Prerequisites: A1.G.07
Next steps: B1.G.32 (Grammar for email basics)
```

**JSONB:**
```json
[
  {
    "type": "prerequisite",
    "chapter_code": "A1.G.07",
    "note": null
  },
  {
    "type": "advanced",
    "chapter_code": "B1.G.32",
    "note": "Grammar for email basics"
  }
]
```

---

### A2.G.18: Used To

**Source:**
```
Prerequisites: A1.G.01
Next steps: B1.G.24 (Adjective order)
```

**JSONB:**
```json
[
  {
    "type": "prerequisite",
    "chapter_code": "A1.G.01",
    "note": null
  },
  {
    "type": "advanced",
    "chapter_code": "B1.G.24",
    "note": "Adjective order"
  }
]
```

---

### A2.G.19: Adjectives - Order and Position

**Source:**
```
Prerequisites: A1.G.02
Next steps: B1.G.24 (Adjective order)
```

**JSONB:**
```json
[
  {
    "type": "prerequisite",
    "chapter_code": "A1.G.02",
    "note": null
  },
  {
    "type": "advanced",
    "chapter_code": "B1.G.24",
    "note": "Adjective order"
  }
]
```

---

### A2.G.20: Adverbs of Manner

**Source:**
```
Prerequisites: A1.G.03
Next steps: B1.G.25 (Adverbs of frequency/degree)
```

**JSONB:**
```json
[
  {
    "type": "prerequisite",
    "chapter_code": "A1.G.03",
    "note": null
  },
  {
    "type": "advanced",
    "chapter_code": "B1.G.25",
    "note": "Adverbs of frequency/degree"
  }
]
```

---

### A2.G.21: Prepositions of Movement II

**Source:**
```
Prerequisites: A1.G.04
Next steps: B1.G.26 (Prepositions of time/place)
```

**JSONB:**
```json
[
  {
    "type": "prerequisite",
    "chapter_code": "A1.G.04",
    "note": null
  },
  {
    "type": "advanced",
    "chapter_code": "B1.G.26",
    "note": "Prepositions of time/place"
  }
]
```

---

### A2.G.22: Phrasal Verbs - Introduction

**Source:**
```
Prerequisites: A1.G.06
Next steps: B1.G.27 (Phrasal verbs II)
```

**JSONB:**
```json
[
  {
    "type": "prerequisite",
    "chapter_code": "A1.G.06",
    "note": null
  },
  {
    "type": "advanced",
    "chapter_code": "B1.G.27",
    "note": "Phrasal verbs II"
  }
]
```

---

### A2.G.23: Make vs Do

**Source:**
```
Prerequisites: A1.G.18
Next steps: B1.G.28 (Collocations with make/do/have/take)
```

**JSONB:**
```json
[
  {
    "type": "prerequisite",
    "chapter_code": "A1.G.18",
    "note": null
  },
  {
    "type": "advanced",
    "chapter_code": "B1.G.28",
    "note": "Collocations with make/do/have/take"
  }
]
```

---

### A2.G.24: Say vs Tell

**Source:**
```
Prerequisites: A1.G.20
Next steps: B1.G.29 (Verb patterns)
```

**JSONB:**
```json
[
  {
    "type": "prerequisite",
    "chapter_code": "A1.G.20",
    "note": null
  },
  {
    "type": "advanced",
    "chapter_code": "B1.G.29",
    "note": "Verb patterns"
  }
]
```

---

### A2.G.25: So/Such/Too/Enough

**Source:**
```
Prerequisites: A2.G.08
Next steps: B1.G.30 (Intensifiers)
```

**JSONB:**
```json
[
  {
    "type": "prerequisite",
    "chapter_code": "A2.G.08",
    "note": null
  },
  {
    "type": "advanced",
    "chapter_code": "B1.G.30",
    "note": "Intensifiers"
  }
]
```

---

### A2.G.26: Both/Neither/Either

**Source:**
```
Prerequisites: A1.G.21
Next steps: B1.G.31 (Quantifiers III)
```

**JSONB:**
```json
[
  {
    "type": "prerequisite",
    "chapter_code": "A1.G.21",
    "note": null
  },
  {
    "type": "advanced",
    "chapter_code": "B1.G.31",
    "note": "Quantifiers III"
  }
]
```

---

### A2.G.27: Reflexive Pronouns

**Source:**
```
Prerequisites: A1.G.22
Next steps: B1.G.32 (Discourse markers)
```

**JSONB:**
```json
[
  {
    "type": "prerequisite",
    "chapter_code": "A1.G.22",
    "note": null
  },
  {
    "type": "advanced",
    "chapter_code": "B1.G.32",
    "note": "Discourse markers"
  }
]
```

---

### A2.G.28: Possessive Pronouns Review

**Source:**
```
Prerequisites: A1.G.23
Next steps: B1.G.01 (Present perfect vs past simple)
```

**JSONB:**
```json
[
  {
    "type": "prerequisite",
    "chapter_code": "A1.G.23",
    "note": null
  },
  {
    "type": "advanced",
    "chapter_code": "B1.G.01",
    "note": "Present perfect vs past simple"
  }
]
```

---

## JSON Validation

All JSONB structures have been validated for:
- ✓ Valid JSON syntax
- ✓ Required fields present (type, chapter_code)
- ✓ Type values are one of: prerequisite, related, advanced
- ✓ Chapter codes follow pattern: [LEVEL].G.[NUMBER]
- ✓ No duplicate links within same lesson
- ✓ All referenced chapters exist or are planned (A0-C1)

## Summary Statistics

- **Total A2 Lessons**: 28
- **Total Cross-Links**: 69
- **Prerequisite Links**: 38
- **Advanced Links**: 31
- **Related Links**: 0
- **Average Links per Lesson**: 2.5

## Notes

- All prerequisite links reference existing A0, A1, or earlier A2 chapters
- Advanced links reference later A2, B1, B2, or C1 chapters
- Forward references to B2 and C1 chapters are acceptable (chapters will be added in future phases)
- No circular dependencies exist
- All chapter codes follow the established naming convention
