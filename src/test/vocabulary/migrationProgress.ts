/**
 * Migration Progress Tracking Script
 * 
 * This module tracks the progress of vocabulary enhancement migrations,
 * showing which batches have been applied and completion status.
 * 
 * Usage:
 *   import { trackMigrationProgress } from './migrationProgress';
 *   const progress = await trackMigrationProgress();
 *   console.log(progress.summary);
 */

import { createClient } from '@supabase/supabase-js';

// Migration batch definitions
interface MigrationBatch {
  batchNumber: number;
  name: string;
  description: string;
  targetWords: number;
  cefrLevel: string;
  migrationFile: string;
}

const MIGRATION_BATCHES: MigrationBatch[] = [
  {
    batchNumber: 1,
    name: 'A0 Pronouns and Basic Verbs',
    description: 'Pronouns, basic verbs (be, have, do, go, come, get, make, take, etc.)',
    targetWords: 150,
    cefrLevel: 'A0',
    migrationFile: '20260310000002_enhance_gsl_vocabulary_batch_1.sql',
  },
  {
    batchNumber: 2,
    name: 'A0 Common Nouns and Adjectives',
    description: 'Common nouns (time, person, year, way, day, etc.) and basic adjectives',
    targetWords: 150,
    cefrLevel: 'A0',
    migrationFile: '20260310000003_enhance_gsl_vocabulary_batch_2.sql',
  },
  {
    batchNumber: 3,
    name: 'A0 Prepositions, Determiners, Conjunctions',
    description: 'Prepositions, determiners, conjunctions, and function words',
    targetWords: 100,
    cefrLevel: 'A0',
    migrationFile: '20260310000004_enhance_gsl_vocabulary_batch_3.sql',
  },
  {
    batchNumber: 4,
    name: 'A1 Work and Business Vocabulary',
    description: 'Work-related nouns, professional verbs, business concepts',
    targetWords: 150,
    cefrLevel: 'A1',
    migrationFile: '20260310000005_enhance_gsl_vocabulary_batch_4_a1_work.sql',
  },
  {
    batchNumber: 5,
    name: 'A1 Communication and Technology',
    description: 'Communication verbs, technology nouns, communication concepts',
    targetWords: 150,
    cefrLevel: 'A1',
    migrationFile: '20260310000006_enhance_gsl_vocabulary_batch_5_a1_communication.sql',
  },
  {
    batchNumber: 6,
    name: 'A1 Time and Quantity',
    description: 'Time expressions, quantity words, temporal concepts',
    targetWords: 150,
    cefrLevel: 'A1',
    migrationFile: '20260310000007_enhance_gsl_vocabulary_batch_6_a1_time_quantity.sql',
  },
  {
    batchNumber: 7,
    name: 'A1 Remaining High-Frequency Words',
    description: 'Modal verbs, common verbs, common adjectives',
    targetWords: 150,
    cefrLevel: 'A1',
    migrationFile: '20260310000008_enhance_gsl_vocabulary_batch_7_a1_remaining.sql',
  },
];

interface BatchProgress {
  batch: MigrationBatch;
  applied: boolean;
  completedWords: number;
  completionPercentage: number;
  missingWords: string[];
}

interface MigrationProgressReport {
  timestamp: string;
  totalBatches: number;
  appliedBatches: number;
  totalTargetWords: number;
  completedWords: number;
  overallCompletionPercentage: number;
  batches: BatchProgress[];
  summary: {
    a0Complete: boolean;
    a1Complete: boolean;
    a0Percentage: number;
    a1Percentage: number;
  };
}

/**
 * Track migration progress across all batches
 */
export async function trackMigrationProgress(): Promise<MigrationProgressReport> {
  const supabaseUrl = process.env.VITE_SUPABASE_URL || process.env.SUPABASE_URL;
  const supabaseKey = process.env.VITE_SUPABASE_PUBLISHABLE_KEY || process.env.VITE_SUPABASE_ANON_KEY || process.env.SUPABASE_ANON_KEY;

  if (!supabaseUrl || !supabaseKey) {
    throw new Error('Supabase credentials not found in environment variables');
  }

  const supabase = createClient(supabaseUrl, supabaseKey);

  // Fetch all published vocabulary entries
  const { data: entries, error } = await supabase
    .from('lexicon_entries')
    .select('headword, cefr_receptive, ipa, definition_simple, examples')
    .eq('is_published', true)
    .in('cefr_receptive', ['A0', 'A1']);

  if (error) {
    throw new Error(`Failed to fetch vocabulary entries: ${error.message}`);
  }

  if (!entries || entries.length === 0) {
    throw new Error('No vocabulary entries found');
  }

  // Initialize report
  const report: MigrationProgressReport = {
    timestamp: new Date().toISOString(),
    totalBatches: MIGRATION_BATCHES.length,
    appliedBatches: 0,
    totalTargetWords: MIGRATION_BATCHES.reduce((sum, batch) => sum + batch.targetWords, 0),
    completedWords: 0,
    overallCompletionPercentage: 0,
    batches: [],
    summary: {
      a0Complete: false,
      a1Complete: false,
      a0Percentage: 0,
      a1Percentage: 0,
    },
  };

  // Count completed words (entries with all required fields)
  const completedEntries = entries.filter(entry => 
    entry.ipa && 
    entry.definition_simple && 
    entry.examples && 
    Array.isArray(entry.examples) && 
    entry.examples.length >= 2
  );

  report.completedWords = completedEntries.length;

  // Analyze each batch
  for (const batch of MIGRATION_BATCHES) {
    const batchEntries = entries.filter(e => e.cefr_receptive === batch.cefrLevel);
    const batchCompleted = batchEntries.filter(e => 
      e.ipa && 
      e.definition_simple && 
      e.examples && 
      Array.isArray(e.examples) && 
      e.examples.length >= 2
    );

    const batchProgress: BatchProgress = {
      batch,
      applied: batchCompleted.length > 0,
      completedWords: batchCompleted.length,
      completionPercentage: Math.round((batchCompleted.length / batch.targetWords) * 100),
      missingWords: [],
    };

    if (batchProgress.applied) {
      report.appliedBatches++;
    }

    // Identify missing words (entries without complete data)
    const incompleteEntries = batchEntries.filter(e => 
      !e.ipa || 
      !e.definition_simple || 
      !e.examples || 
      !Array.isArray(e.examples) || 
      e.examples.length < 2
    );

    batchProgress.missingWords = incompleteEntries
      .map(e => e.headword)
      .slice(0, 20); // Limit to first 20

    report.batches.push(batchProgress);
  }

  // Calculate overall completion percentage
  report.overallCompletionPercentage = Math.round(
    (report.completedWords / report.totalTargetWords) * 100
  );

  // Calculate A0 and A1 completion
  const a0Batches = report.batches.filter(b => b.batch.cefrLevel === 'A0');
  const a1Batches = report.batches.filter(b => b.batch.cefrLevel === 'A1');

  const a0TargetWords = a0Batches.reduce((sum, b) => sum + b.batch.targetWords, 0);
  const a0CompletedWords = a0Batches.reduce((sum, b) => sum + b.completedWords, 0);
  report.summary.a0Percentage = Math.round((a0CompletedWords / a0TargetWords) * 100);
  report.summary.a0Complete = report.summary.a0Percentage === 100;

  const a1TargetWords = a1Batches.reduce((sum, b) => sum + b.batch.targetWords, 0);
  const a1CompletedWords = a1Batches.reduce((sum, b) => sum + b.completedWords, 0);
  report.summary.a1Percentage = Math.round((a1CompletedWords / a1TargetWords) * 100);
  report.summary.a1Complete = report.summary.a1Percentage === 100;

  return report;
}

/**
 * Format migration progress report as human-readable text
 */
export function formatProgressAsText(report: MigrationProgressReport): string {
  const lines: string[] = [];

  lines.push('='.repeat(80));
  lines.push('VOCABULARY MIGRATION PROGRESS REPORT');
  lines.push('='.repeat(80));
  lines.push(`Generated: ${new Date(report.timestamp).toLocaleString()}`);
  lines.push('');

  // Overall Summary
  lines.push('OVERALL PROGRESS');
  lines.push('-'.repeat(80));
  lines.push(`Total Batches: ${report.totalBatches}`);
  lines.push(`Applied Batches: ${report.appliedBatches}/${report.totalBatches}`);
  lines.push(`Completed Words: ${report.completedWords}/${report.totalTargetWords}`);
  lines.push(`Overall Completion: ${report.overallCompletionPercentage}%`);
  lines.push('');

  // CEFR Level Summary
  lines.push('COMPLETION BY CEFR LEVEL');
  lines.push('-'.repeat(80));
  lines.push(`A0: ${report.summary.a0Percentage}% ${report.summary.a0Complete ? '✓ COMPLETE' : '⚠ IN PROGRESS'}`);
  lines.push(`A1: ${report.summary.a1Percentage}% ${report.summary.a1Complete ? '✓ COMPLETE' : '⚠ IN PROGRESS'}`);
  lines.push('');

  // Batch Details
  lines.push('BATCH DETAILS');
  lines.push('-'.repeat(80));

  for (const batchProgress of report.batches) {
    const status = batchProgress.applied ? '✓' : '✗';
    const progressBar = createProgressBar(batchProgress.completionPercentage, 30);
    
    lines.push(`[${status}] Batch ${batchProgress.batch.batchNumber}: ${batchProgress.batch.name}`);
    lines.push(`    ${batchProgress.batch.description}`);
    lines.push(`    Progress: ${progressBar} ${batchProgress.completionPercentage}%`);
    lines.push(`    Completed: ${batchProgress.completedWords}/${batchProgress.batch.targetWords} words`);
    lines.push(`    Migration: ${batchProgress.batch.migrationFile}`);
    
    if (batchProgress.missingWords.length > 0) {
      lines.push(`    Missing: ${batchProgress.missingWords.slice(0, 10).join(', ')}${batchProgress.missingWords.length > 10 ? '...' : ''}`);
    }
    
    lines.push('');
  }

  // Next Steps
  lines.push('NEXT STEPS');
  lines.push('-'.repeat(80));
  
  const incompleteBatches = report.batches.filter(b => !b.applied || b.completionPercentage < 100);
  
  if (incompleteBatches.length === 0) {
    lines.push('✓ All migration batches are complete!');
    lines.push('  Run validation report to check data quality.');
  } else {
    lines.push('The following batches need attention:');
    for (const batch of incompleteBatches) {
      if (!batch.applied) {
        lines.push(`  - Apply migration: ${batch.batch.migrationFile}`);
      } else if (batch.completionPercentage < 100) {
        lines.push(`  - Complete batch ${batch.batch.batchNumber}: ${batch.batch.name} (${batch.completionPercentage}%)`);
      }
    }
  }
  
  lines.push('');
  lines.push('='.repeat(80));

  return lines.join('\n');
}

/**
 * Create a visual progress bar
 */
function createProgressBar(percentage: number, width: number): string {
  const filled = Math.round((percentage / 100) * width);
  const empty = width - filled;
  return '[' + '█'.repeat(filled) + '░'.repeat(empty) + ']';
}

/**
 * Export migration progress as JSON
 */
export function formatProgressAsJSON(report: MigrationProgressReport): string {
  return JSON.stringify(report, null, 2);
}

/**
 * Get list of unapplied migrations
 */
export function getUnappliedMigrations(report: MigrationProgressReport): string[] {
  return report.batches
    .filter(b => !b.applied)
    .map(b => b.batch.migrationFile);
}

/**
 * Get list of incomplete batches
 */
export function getIncompleteBatches(report: MigrationProgressReport): MigrationBatch[] {
  return report.batches
    .filter(b => b.completionPercentage < 100)
    .map(b => b.batch);
}
