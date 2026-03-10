/**
 * Validation Report Generator for Vocabulary Data
 * 
 * This module generates comprehensive validation reports for the vocabulary database,
 * checking data completeness, quality, and consistency across all CEFR levels.
 * 
 * Usage:
 *   import { generateValidationReport } from './validationReport';
 *   const report = await generateValidationReport();
 *   console.log(report.summary);
 */

import { createClient } from '@supabase/supabase-js';

// Types for validation results
interface ValidationIssue {
  headword: string;
  issue: string;
  field?: string;
  currentValue?: string | null;
}

interface CEFRLevelStats {
  level: string;
  totalEntries: number;
  withIPA: number;
  withDefinitionSimple: number;
  withDefinitionTeacher: number;
  withUsageNotes: number;
  withRegister: number;
  withVariety: number;
  withExamples: number;
  withCollocations: number;
  withPatterns: number;
  completionPercentage: number;
}

interface ValidationReport {
  timestamp: string;
  summary: {
    totalEntries: number;
    fullyComplete: number;
    partiallyComplete: number;
    incomplete: number;
    completionPercentage: number;
  };
  byLevel: CEFRLevelStats[];
  issues: {
    missingRequiredFields: ValidationIssue[];
    invalidRegisterValues: ValidationIssue[];
    invalidVarietyValues: ValidationIssue[];
    invalidIPAFormat: ValidationIssue[];
    invalidExamplesCount: ValidationIssue[];
    invalidCollocationsCount: ValidationIssue[];
    invalidPatternsCount: ValidationIssue[];
    invalidJSONB: ValidationIssue[];
  };
}

/**
 * Generate a comprehensive validation report for vocabulary data
 */
export async function generateValidationReport(): Promise<ValidationReport> {
  const supabaseUrl = process.env.VITE_SUPABASE_URL || process.env.SUPABASE_URL;
  const supabaseKey = process.env.VITE_SUPABASE_PUBLISHABLE_KEY || process.env.VITE_SUPABASE_ANON_KEY || process.env.SUPABASE_ANON_KEY;

  if (!supabaseUrl || !supabaseKey) {
    throw new Error('Supabase credentials not found in environment variables');
  }

  const supabase = createClient(supabaseUrl, supabaseKey);

  // Fetch all published vocabulary entries
  const { data: entries, error } = await supabase
    .from('lexicon_entries')
    .select('*')
    .eq('is_published', true)
    .in('cefr_receptive', ['A0', 'A1']);

  if (error) {
    throw new Error(`Failed to fetch vocabulary entries: ${error.message}`);
  }

  if (!entries || entries.length === 0) {
    throw new Error('No vocabulary entries found');
  }

  // Initialize report structure
  const report: ValidationReport = {
    timestamp: new Date().toISOString(),
    summary: {
      totalEntries: entries.length,
      fullyComplete: 0,
      partiallyComplete: 0,
      incomplete: 0,
      completionPercentage: 0,
    },
    byLevel: [],
    issues: {
      missingRequiredFields: [],
      invalidRegisterValues: [],
      invalidVarietyValues: [],
      invalidIPAFormat: [],
      invalidExamplesCount: [],
      invalidCollocationsCount: [],
      invalidPatternsCount: [],
      invalidJSONB: [],
    },
  };

  // Group entries by CEFR level
  const levelGroups = new Map<string, any[]>();
  for (const entry of entries) {
    const level = entry.cefr_receptive || 'Unknown';
    if (!levelGroups.has(level)) {
      levelGroups.set(level, []);
    }
    levelGroups.get(level)!.push(entry);
  }

  // Analyze each CEFR level
  for (const [level, levelEntries] of levelGroups) {
    const stats: CEFRLevelStats = {
      level,
      totalEntries: levelEntries.length,
      withIPA: 0,
      withDefinitionSimple: 0,
      withDefinitionTeacher: 0,
      withUsageNotes: 0,
      withRegister: 0,
      withVariety: 0,
      withExamples: 0,
      withCollocations: 0,
      withPatterns: 0,
      completionPercentage: 0,
    };

    for (const entry of levelEntries) {
      // Count populated fields
      if (entry.ipa) stats.withIPA++;
      if (entry.definition_simple) stats.withDefinitionSimple++;
      if (entry.definition_teacher) stats.withDefinitionTeacher++;
      if (entry.usage_notes) stats.withUsageNotes++;
      if (entry.register) stats.withRegister++;
      if (entry.variety) stats.withVariety++;
      if (entry.examples && Array.isArray(entry.examples) && entry.examples.length > 0) {
        stats.withExamples++;
      }
      if (entry.collocations && Array.isArray(entry.collocations) && entry.collocations.length > 0) {
        stats.withCollocations++;
      }
      if (entry.patterns && Array.isArray(entry.patterns) && entry.patterns.length > 0) {
        stats.withPatterns++;
      }

      // Check for issues
      validateEntry(entry, report.issues);

      // Determine completion status
      const requiredFieldsCount = 6; // ipa, definition_simple, definition_teacher, usage_notes, register, variety
      let populatedRequiredFields = 0;
      if (entry.ipa) populatedRequiredFields++;
      if (entry.definition_simple) populatedRequiredFields++;
      if (entry.definition_teacher) populatedRequiredFields++;
      if (entry.usage_notes) populatedRequiredFields++;
      if (entry.register) populatedRequiredFields++;
      if (entry.variety) populatedRequiredFields++;

      if (populatedRequiredFields === requiredFieldsCount && 
          entry.examples && Array.isArray(entry.examples) && entry.examples.length >= 2) {
        report.summary.fullyComplete++;
      } else if (populatedRequiredFields > 0) {
        report.summary.partiallyComplete++;
      } else {
        report.summary.incomplete++;
      }
    }

    // Calculate completion percentage for this level
    const totalFields = stats.totalEntries * 9; // 9 fields to populate
    const populatedFields = stats.withIPA + stats.withDefinitionSimple + stats.withDefinitionTeacher +
                           stats.withUsageNotes + stats.withRegister + stats.withVariety +
                           stats.withExamples + stats.withCollocations + stats.withPatterns;
    stats.completionPercentage = Math.round((populatedFields / totalFields) * 100);

    report.byLevel.push(stats);
  }

  // Calculate overall completion percentage
  report.summary.completionPercentage = Math.round(
    (report.summary.fullyComplete / report.summary.totalEntries) * 100
  );

  // Sort levels
  report.byLevel.sort((a, b) => a.level.localeCompare(b.level));

  return report;
}

/**
 * Validate a single vocabulary entry and record issues
 */
function validateEntry(entry: any, issues: ValidationReport['issues']): void {
  const headword = entry.headword || 'Unknown';

  // Check required fields
  if (!entry.ipa || entry.ipa.trim() === '') {
    issues.missingRequiredFields.push({
      headword,
      issue: 'Missing IPA pronunciation',
      field: 'ipa',
    });
  }

  if (!entry.definition_simple || entry.definition_simple.trim() === '') {
    issues.missingRequiredFields.push({
      headword,
      issue: 'Missing simple definition',
      field: 'definition_simple',
    });
  }

  if (!entry.definition_teacher || entry.definition_teacher.trim() === '') {
    issues.missingRequiredFields.push({
      headword,
      issue: 'Missing teacher definition',
      field: 'definition_teacher',
    });
  }

  if (!entry.usage_notes || entry.usage_notes.trim() === '') {
    issues.missingRequiredFields.push({
      headword,
      issue: 'Missing usage notes',
      field: 'usage_notes',
    });
  }

  if (!entry.register || entry.register.trim() === '') {
    issues.missingRequiredFields.push({
      headword,
      issue: 'Missing register',
      field: 'register',
    });
  }

  if (!entry.variety || entry.variety.trim() === '') {
    issues.missingRequiredFields.push({
      headword,
      issue: 'Missing variety',
      field: 'variety',
    });
  }

  // Validate register values
  const validRegisters = ['formal', 'neutral', 'informal'];
  if (entry.register && !validRegisters.includes(entry.register)) {
    issues.invalidRegisterValues.push({
      headword,
      issue: `Invalid register value: ${entry.register}`,
      field: 'register',
      currentValue: entry.register,
    });
  }

  // Validate variety values
  const validVarieties = ['US', 'UK', 'international'];
  if (entry.variety && !validVarieties.includes(entry.variety)) {
    issues.invalidVarietyValues.push({
      headword,
      issue: `Invalid variety value: ${entry.variety}`,
      field: 'variety',
      currentValue: entry.variety,
    });
  }

  // Validate IPA format (should not contain slashes or brackets)
  if (entry.ipa && /[\/\[\]]/.test(entry.ipa)) {
    issues.invalidIPAFormat.push({
      headword,
      issue: 'IPA contains invalid characters (/, [, ])',
      field: 'ipa',
      currentValue: entry.ipa,
    });
  }

  // Validate examples array
  if (!entry.examples || !Array.isArray(entry.examples)) {
    issues.invalidJSONB.push({
      headword,
      issue: 'Examples field is not a valid array',
      field: 'examples',
    });
  } else if (entry.examples.length < 2 || entry.examples.length > 4) {
    issues.invalidExamplesCount.push({
      headword,
      issue: `Examples count is ${entry.examples.length}, should be 2-4`,
      field: 'examples',
      currentValue: entry.examples.length.toString(),
    });
  }

  // Validate collocations array
  if (entry.collocations !== null && entry.collocations !== undefined) {
    if (!Array.isArray(entry.collocations)) {
      issues.invalidJSONB.push({
        headword,
        issue: 'Collocations field is not a valid array',
        field: 'collocations',
      });
    } else if (entry.collocations.length > 0 && (entry.collocations.length < 2 || entry.collocations.length > 5)) {
      issues.invalidCollocationsCount.push({
        headword,
        issue: `Collocations count is ${entry.collocations.length}, should be 0 or 2-5`,
        field: 'collocations',
        currentValue: entry.collocations.length.toString(),
      });
    }
  }

  // Validate patterns array
  if (entry.patterns !== null && entry.patterns !== undefined) {
    if (!Array.isArray(entry.patterns)) {
      issues.invalidJSONB.push({
        headword,
        issue: 'Patterns field is not a valid array',
        field: 'patterns',
      });
    } else if (entry.patterns.length > 0 && (entry.patterns.length < 1 || entry.patterns.length > 3)) {
      issues.invalidPatternsCount.push({
        headword,
        issue: `Patterns count is ${entry.patterns.length}, should be 0 or 1-3`,
        field: 'patterns',
        currentValue: entry.patterns.length.toString(),
      });
    }
  }
}

/**
 * Format validation report as human-readable text
 */
export function formatReportAsText(report: ValidationReport): string {
  const lines: string[] = [];

  lines.push('='.repeat(80));
  lines.push('VOCABULARY DATA VALIDATION REPORT');
  lines.push('='.repeat(80));
  lines.push(`Generated: ${new Date(report.timestamp).toLocaleString()}`);
  lines.push('');

  // Summary
  lines.push('SUMMARY');
  lines.push('-'.repeat(80));
  lines.push(`Total Entries: ${report.summary.totalEntries}`);
  lines.push(`Fully Complete: ${report.summary.fullyComplete} (${report.summary.completionPercentage}%)`);
  lines.push(`Partially Complete: ${report.summary.partiallyComplete}`);
  lines.push(`Incomplete: ${report.summary.incomplete}`);
  lines.push('');

  // By Level
  lines.push('COMPLETION BY CEFR LEVEL');
  lines.push('-'.repeat(80));
  for (const level of report.byLevel) {
    lines.push(`${level.level}: ${level.completionPercentage}% complete (${level.totalEntries} entries)`);
    lines.push(`  IPA: ${level.withIPA}/${level.totalEntries}`);
    lines.push(`  Simple Definition: ${level.withDefinitionSimple}/${level.totalEntries}`);
    lines.push(`  Teacher Definition: ${level.withDefinitionTeacher}/${level.totalEntries}`);
    lines.push(`  Usage Notes: ${level.withUsageNotes}/${level.totalEntries}`);
    lines.push(`  Register: ${level.withRegister}/${level.totalEntries}`);
    lines.push(`  Variety: ${level.withVariety}/${level.totalEntries}`);
    lines.push(`  Examples: ${level.withExamples}/${level.totalEntries}`);
    lines.push(`  Collocations: ${level.withCollocations}/${level.totalEntries}`);
    lines.push(`  Patterns: ${level.withPatterns}/${level.totalEntries}`);
    lines.push('');
  }

  // Issues
  lines.push('ISSUES FOUND');
  lines.push('-'.repeat(80));

  const issueCategories = [
    { name: 'Missing Required Fields', issues: report.issues.missingRequiredFields },
    { name: 'Invalid Register Values', issues: report.issues.invalidRegisterValues },
    { name: 'Invalid Variety Values', issues: report.issues.invalidVarietyValues },
    { name: 'Invalid IPA Format', issues: report.issues.invalidIPAFormat },
    { name: 'Invalid Examples Count', issues: report.issues.invalidExamplesCount },
    { name: 'Invalid Collocations Count', issues: report.issues.invalidCollocationsCount },
    { name: 'Invalid Patterns Count', issues: report.issues.invalidPatternsCount },
    { name: 'Invalid JSONB Structure', issues: report.issues.invalidJSONB },
  ];

  for (const category of issueCategories) {
    if (category.issues.length > 0) {
      lines.push(`${category.name}: ${category.issues.length} issues`);
      for (const issue of category.issues.slice(0, 10)) { // Show first 10
        lines.push(`  - ${issue.headword}: ${issue.issue}`);
      }
      if (category.issues.length > 10) {
        lines.push(`  ... and ${category.issues.length - 10} more`);
      }
      lines.push('');
    }
  }

  if (Object.values(report.issues).every(arr => arr.length === 0)) {
    lines.push('No issues found! All vocabulary data is valid.');
    lines.push('');
  }

  lines.push('='.repeat(80));

  return lines.join('\n');
}

/**
 * Export validation report as JSON
 */
export function formatReportAsJSON(report: ValidationReport): string {
  return JSON.stringify(report, null, 2);
}
