/**
 * Batch Tracking and Progress Monitoring Utilities
 * Provides functions to monitor vocabulary data completion status
 */

import { SupabaseClient } from '@supabase/supabase-js';

/**
 * Completion status by CEFR level
 */
export interface CEFRCompletionStatus {
  cefr_level: string;
  total_entries: number;
  with_ipa: number;
  with_definition_simple: number;
  with_definition_teacher: number;
  with_usage_notes: number;
  with_register: number;
  with_variety: number;
  with_examples: number;
  with_collocations: number;
  with_patterns: number;
  fully_populated: number;
  completion_percentage: number;
}

/**
 * Field population statistics
 */
export interface FieldPopulationStats {
  field_name: string;
  populated_count: number;
  unpopulated_count: number;
  total_count: number;
  population_percentage: number;
}

/**
 * Overall progress summary
 */
export interface ProgressSummary {
  total_entries: number;
  published_entries: number;
  fully_populated_entries: number;
  overall_completion_percentage: number;
  by_cefr_level: CEFRCompletionStatus[];
  by_field: FieldPopulationStats[];
}

/**
 * Shows completion status by CEFR level
 * Requirements: 12.4
 */
export async function getCompletionStatusByCEFR(
  client: SupabaseClient
): Promise<CEFRCompletionStatus[]> {
  const { data, error } = await client
    .from('lexicon_entries')
    .select('cefr_receptive, ipa, definition_simple, definition_teacher, usage_notes, register, variety, examples, collocations, patterns')
    .eq('is_published', true);

  if (error) {
    throw error;
  }

  // Group by CEFR level
  const grouped = new Map<string, any[]>();
  for (const entry of data) {
    const level = entry.cefr_receptive || 'unknown';
    if (!grouped.has(level)) {
      grouped.set(level, []);
    }
    grouped.get(level)!.push(entry);
  }

  const results: CEFRCompletionStatus[] = [];

  for (const [level, entries] of grouped.entries()) {
    const total = entries.length;
    const withIPA = entries.filter(e => e.ipa && e.ipa !== '').length;
    const withDefinitionSimple = entries.filter(e => e.definition_simple && e.definition_simple !== '').length;
    const withDefinitionTeacher = entries.filter(e => e.definition_teacher && e.definition_teacher !== '').length;
    const withUsageNotes = entries.filter(e => e.usage_notes && e.usage_notes !== '').length;
    const withRegister = entries.filter(e => e.register && e.register !== '').length;
    const withVariety = entries.filter(e => e.variety && e.variety !== '').length;
    const withExamples = entries.filter(e => Array.isArray(e.examples) && e.examples.length >= 2).length;
    const withCollocations = entries.filter(e => Array.isArray(e.collocations)).length;
    const withPatterns = entries.filter(e => Array.isArray(e.patterns)).length;

    // Count fully populated entries (all required fields present)
    const fullyPopulated = entries.filter(e =>
      e.ipa && e.ipa !== '' &&
      e.definition_simple && e.definition_simple !== '' &&
      e.definition_teacher && e.definition_teacher !== '' &&
      e.usage_notes && e.usage_notes !== '' &&
      e.register && e.register !== '' &&
      e.variety && e.variety !== '' &&
      Array.isArray(e.examples) && e.examples.length >= 2
    ).length;

    results.push({
      cefr_level: level,
      total_entries: total,
      with_ipa: withIPA,
      with_definition_simple: withDefinitionSimple,
      with_definition_teacher: withDefinitionTeacher,
      with_usage_notes: withUsageNotes,
      with_register: withRegister,
      with_variety: withVariety,
      with_examples: withExamples,
      with_collocations: withCollocations,
      with_patterns: withPatterns,
      fully_populated: fullyPopulated,
      completion_percentage: total > 0 ? Math.round((fullyPopulated / total) * 100) : 0,
    });
  }

  // Sort by CEFR level
  const cefrOrder = ['A0', 'A1', 'A2', 'B1', 'B2', 'C1', 'C2', 'unknown'];
  results.sort((a, b) => {
    const indexA = cefrOrder.indexOf(a.cefr_level);
    const indexB = cefrOrder.indexOf(b.cefr_level);
    return indexA - indexB;
  });

  return results;
}

/**
 * Counts populated vs unpopulated fields
 * Requirements: 12.4
 */
export async function getFieldPopulationStats(
  client: SupabaseClient
): Promise<FieldPopulationStats[]> {
  const { data, error } = await client
    .from('lexicon_entries')
    .select('ipa, definition_simple, definition_teacher, usage_notes, register, variety, examples, collocations, patterns')
    .eq('is_published', true);

  if (error) {
    throw error;
  }

  const total = data.length;
  const fields = [
    'ipa',
    'definition_simple',
    'definition_teacher',
    'usage_notes',
    'register',
    'variety',
    'examples',
    'collocations',
    'patterns',
  ];

  const results: FieldPopulationStats[] = [];

  for (const field of fields) {
    let populated = 0;

    for (const entry of data) {
      const value = entry[field];
      
      if (field === 'examples' || field === 'collocations' || field === 'patterns') {
        // For JSONB arrays, check if it's a non-empty array
        if (Array.isArray(value) && value.length > 0) {
          populated++;
        }
      } else {
        // For text fields, check if it's not null and not empty
        if (value && value !== '') {
          populated++;
        }
      }
    }

    const unpopulated = total - populated;

    results.push({
      field_name: field,
      populated_count: populated,
      unpopulated_count: unpopulated,
      total_count: total,
      population_percentage: total > 0 ? Math.round((populated / total) * 100) : 0,
    });
  }

  return results;
}

/**
 * Reports migration batch progress
 * Requirements: 12.4
 */
export async function getMigrationBatchProgress(
  client: SupabaseClient
): Promise<ProgressSummary> {
  const { data: allEntries, error: allError } = await client
    .from('lexicon_entries')
    .select('id')
    .eq('is_published', true);

  if (allError) {
    throw allError;
  }

  const totalEntries = allEntries.length;

  // Get fully populated entries
  const { data: fullyPopulated, error: fullyError } = await client
    .from('lexicon_entries')
    .select('id')
    .eq('is_published', true)
    .not('ipa', 'is', null)
    .not('definition_simple', 'is', null)
    .not('definition_teacher', 'is', null)
    .not('usage_notes', 'is', null)
    .not('register', 'is', null)
    .not('variety', 'is', null);

  if (fullyError) {
    throw fullyError;
  }

  const fullyPopulatedCount = fullyPopulated.length;

  // Get completion by CEFR level
  const byCEFR = await getCompletionStatusByCEFR(client);

  // Get field population stats
  const byField = await getFieldPopulationStats(client);

  return {
    total_entries: totalEntries,
    published_entries: totalEntries,
    fully_populated_entries: fullyPopulatedCount,
    overall_completion_percentage: totalEntries > 0 
      ? Math.round((fullyPopulatedCount / totalEntries) * 100) 
      : 0,
    by_cefr_level: byCEFR,
    by_field: byField,
  };
}

/**
 * Formats progress summary as a human-readable report
 */
export function formatProgressReport(summary: ProgressSummary): string {
  const lines: string[] = [];

  lines.push('=== Vocabulary Data Progress Report ===\n');
  lines.push(`Total Published Entries: ${summary.total_entries}`);
  lines.push(`Fully Populated Entries: ${summary.fully_populated_entries}`);
  lines.push(`Overall Completion: ${summary.overall_completion_percentage}%\n`);

  lines.push('--- Completion by CEFR Level ---');
  for (const level of summary.by_cefr_level) {
    lines.push(`${level.cefr_level}: ${level.fully_populated}/${level.total_entries} (${level.completion_percentage}%)`);
  }

  lines.push('\n--- Field Population Statistics ---');
  for (const field of summary.by_field) {
    lines.push(`${field.field_name}: ${field.populated_count}/${field.total_count} (${field.population_percentage}%)`);
  }

  return lines.join('\n');
}

/**
 * Exports progress summary as JSON
 */
export function exportProgressJSON(summary: ProgressSummary): string {
  return JSON.stringify(summary, null, 2);
}

/**
 * Gets a list of entries that still need enhancement
 */
export async function getUnpopulatedEntries(
  client: SupabaseClient,
  cefrLevel?: string
): Promise<Array<{ headword: string; cefr_receptive: string }>> {
  let query = client
    .from('lexicon_entries')
    .select('headword, cefr_receptive')
    .eq('is_published', true)
    .or('ipa.is.null,definition_simple.is.null,definition_teacher.is.null,usage_notes.is.null,register.is.null,variety.is.null');

  if (cefrLevel) {
    query = query.eq('cefr_receptive', cefrLevel);
  }

  const { data, error } = await query;

  if (error) {
    throw error;
  }

  return data;
}

/**
 * Checks if a specific batch of words has been populated
 */
export async function checkBatchCompletion(
  client: SupabaseClient,
  headwords: string[]
): Promise<{
  total: number;
  completed: number;
  incomplete: string[];
  completion_percentage: number;
}> {
  const { data, error } = await client
    .from('lexicon_entries')
    .select('headword, ipa, definition_simple, definition_teacher, usage_notes, register, variety, examples')
    .in('headword', headwords);

  if (error) {
    throw error;
  }

  const incomplete: string[] = [];

  for (const entry of data) {
    const isComplete =
      entry.ipa && entry.ipa !== '' &&
      entry.definition_simple && entry.definition_simple !== '' &&
      entry.definition_teacher && entry.definition_teacher !== '' &&
      entry.usage_notes && entry.usage_notes !== '' &&
      entry.register && entry.register !== '' &&
      entry.variety && entry.variety !== '' &&
      Array.isArray(entry.examples) && entry.examples.length >= 2;

    if (!isComplete) {
      incomplete.push(entry.headword);
    }
  }

  const completed = data.length - incomplete.length;

  return {
    total: headwords.length,
    completed,
    incomplete,
    completion_percentage: headwords.length > 0 
      ? Math.round((completed / headwords.length) * 100) 
      : 0,
  };
}
