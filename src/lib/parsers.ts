/**
 * Parser and Serializer Implementations
 * Handles cloze sentence and L1 notes parsing/serialization
 */

/**
 * Parse example sentence to generate cloze flashcard
 * Replaces target word with blank (_____)
 */
export function parseCloze(exampleSentence: string, targetWord: string): string {
  // Normalize for case-insensitive matching
  const sentenceLower = exampleSentence.toLowerCase();
  const targetLower = targetWord.toLowerCase();

  // Find first occurrence of target word
  const index = sentenceLower.indexOf(targetLower);

  if (index === -1) {
    throw new Error('Target word not found in example sentence');
  }

  // Extract word boundaries
  const startIndex = index;
  const endIndex = index + targetWord.length;

  // Replace with blank
  const cloze =
    exampleSentence.substring(0, startIndex) +
    '_____' +
    exampleSentence.substring(endIndex);

  return cloze;
}

/**
 * Restore cloze sentence to complete sentence
 */
export function serializeCloze(cloze: string, targetWord: string): string {
  // Find blank placeholder
  const blankIndex = cloze.indexOf('_____');

  if (blankIndex === -1) {
    throw new Error('Cloze blank not found');
  }

  // Replace blank with target word
  let complete =
    cloze.substring(0, blankIndex) +
    targetWord +
    cloze.substring(blankIndex + 5);

  // Clean up extra spaces
  complete = complete.replace(/\s+/g, ' ').trim();

  return complete;
}

/**
 * Parse L1 Notes to extract interference pattern
 * Format: "term1 vs. term2: explanation"
 */
export interface ParsedL1Notes {
  term1: string;
  term2: string;
  explanation: string;
}

export function parseL1Notes(l1NotesText: string): ParsedL1Notes {
  // Check for required separator
  if (!l1NotesText.includes(':')) {
    throw new Error(
      "Invalid L1_Notes format. Expected 'term1 vs. term2: explanation'"
    );
  }

  // Split on colon
  const [termsPart, explanation] = l1NotesText.split(':');
  const termsPartTrimmed = termsPart.trim();
  const explanationTrimmed = explanation.trim();

  // Parse terms
  if (!termsPartTrimmed.includes(' vs. ')) {
    throw new Error(
      "Invalid L1_Notes format. Expected 'term1 vs. term2: explanation'"
    );
  }

  const [term1, term2] = termsPartTrimmed.split(' vs. ');

  return {
    term1: term1.trim(),
    term2: term2.trim(),
    explanation: explanationTrimmed,
  };
}

/**
 * Serialize parsed L1 Notes back to text
 */
export function serializeL1Notes(parsed: ParsedL1Notes): string {
  return `${parsed.term1} vs. ${parsed.term2}: ${parsed.explanation}`;
}
