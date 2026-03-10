#!/usr/bin/env node
/**
 * Vocabulary Data Management CLI
 * 
 * Command-line interface for vocabulary validation and migration tracking.
 * 
 * Usage:
 *   npm run vocab:validate     - Generate validation report
 *   npm run vocab:progress     - Track migration progress
 *   npm run vocab:report       - Generate both reports
 */

// Load environment variables from .env file
import dotenv from 'dotenv';
dotenv.config();

import { 
  generateValidationReport, 
  formatReportAsText as formatValidationText,
  formatReportAsJSON as formatValidationJSON 
} from './validationReport';

import { 
  trackMigrationProgress, 
  formatProgressAsText,
  formatProgressAsJSON 
} from './migrationProgress';

import * as fs from 'fs';
import * as path from 'path';

const REPORTS_DIR = path.join(process.cwd(), 'reports');

// Ensure reports directory exists
if (!fs.existsSync(REPORTS_DIR)) {
  fs.mkdirSync(REPORTS_DIR, { recursive: true });
}

/**
 * Generate validation report
 */
async function runValidation() {
  console.log('Generating vocabulary validation report...\n');
  
  try {
    const report = await generateValidationReport();
    const textReport = formatValidationText(report);
    const jsonReport = formatValidationJSON(report);
    
    // Print to console
    console.log(textReport);
    
    // Save to files
    const timestamp = new Date().toISOString().replace(/[:.]/g, '-').split('T')[0];
    const textPath = path.join(REPORTS_DIR, `validation-report-${timestamp}.txt`);
    const jsonPath = path.join(REPORTS_DIR, `validation-report-${timestamp}.json`);
    
    fs.writeFileSync(textPath, textReport);
    fs.writeFileSync(jsonPath, jsonReport);
    
    console.log(`\nReports saved to:`);
    console.log(`  - ${textPath}`);
    console.log(`  - ${jsonPath}`);
    
    // Exit with error code if issues found
    const hasIssues = Object.values(report.issues).some(arr => arr.length > 0);
    if (hasIssues) {
      console.log('\n⚠ Validation issues found. Please review the report.');
      process.exit(1);
    } else {
      console.log('\n✓ All validation checks passed!');
      process.exit(0);
    }
  } catch (error) {
    console.error('Error generating validation report:', error);
    process.exit(1);
  }
}

/**
 * Track migration progress
 */
async function runProgress() {
  console.log('Tracking vocabulary migration progress...\n');
  
  try {
    const report = await trackMigrationProgress();
    const textReport = formatProgressAsText(report);
    const jsonReport = formatProgressAsJSON(report);
    
    // Print to console
    console.log(textReport);
    
    // Save to files
    const timestamp = new Date().toISOString().replace(/[:.]/g, '-').split('T')[0];
    const textPath = path.join(REPORTS_DIR, `progress-report-${timestamp}.txt`);
    const jsonPath = path.join(REPORTS_DIR, `progress-report-${timestamp}.json`);
    
    fs.writeFileSync(textPath, textReport);
    fs.writeFileSync(jsonPath, jsonReport);
    
    console.log(`\nReports saved to:`);
    console.log(`  - ${textPath}`);
    console.log(`  - ${jsonPath}`);
    
    // Exit with appropriate code
    if (report.overallCompletionPercentage === 100) {
      console.log('\n✓ All migrations complete!');
      process.exit(0);
    } else {
      console.log(`\n⚠ Migrations ${report.overallCompletionPercentage}% complete.`);
      process.exit(0);
    }
  } catch (error) {
    console.error('Error tracking migration progress:', error);
    process.exit(1);
  }
}

/**
 * Generate both reports
 */
async function runBoth() {
  console.log('Generating comprehensive vocabulary reports...\n');
  console.log('='.repeat(80));
  console.log('PART 1: MIGRATION PROGRESS');
  console.log('='.repeat(80));
  console.log('');
  
  await runProgress();
  
  console.log('\n');
  console.log('='.repeat(80));
  console.log('PART 2: DATA VALIDATION');
  console.log('='.repeat(80));
  console.log('');
  
  await runValidation();
}

/**
 * Main CLI entry point
 */
async function main() {
  const command = process.argv[2] || 'help';
  
  switch (command) {
    case 'validate':
      await runValidation();
      break;
    
    case 'progress':
      await runProgress();
      break;
    
    case 'report':
    case 'all':
      await runBoth();
      break;
    
    case 'help':
    case '--help':
    case '-h':
      console.log('Vocabulary Data Management CLI');
      console.log('');
      console.log('Usage:');
      console.log('  npm run vocab:validate     Generate validation report');
      console.log('  npm run vocab:progress     Track migration progress');
      console.log('  npm run vocab:report       Generate both reports');
      console.log('');
      console.log('Options:');
      console.log('  help, --help, -h           Show this help message');
      console.log('');
      console.log('Environment Variables:');
      console.log('  VITE_SUPABASE_URL          Supabase project URL');
      console.log('  VITE_SUPABASE_PUBLISHABLE_KEY  Supabase anonymous key');
      console.log('');
      process.exit(0);
      break;
    
    default:
      console.error(`Unknown command: ${command}`);
      console.error('Run "npm run vocab:help" for usage information.');
      process.exit(1);
  }
}

// Run CLI
main().catch(error => {
  console.error('Fatal error:', error);
  process.exit(1);
});
