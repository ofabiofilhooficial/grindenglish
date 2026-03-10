/**
 * Test Configuration for Vocabulary Testing
 * Configures fast-check and test parameters
 */

import * as fc from 'fast-check';

/**
 * Property-based test configuration
 * Minimum 100 iterations as per design document
 */
export const PBT_CONFIG: fc.Parameters<unknown> = {
  numRuns: 100,
  verbose: false,
  seed: undefined, // Random seed for each run
};

/**
 * Extended property-based test configuration for thorough testing
 */
export const PBT_CONFIG_EXTENDED: fc.Parameters<unknown> = {
  numRuns: 1000,
  verbose: false,
  seed: undefined,
};

/**
 * Test timeout for database operations (in milliseconds)
 */
export const TEST_TIMEOUT = 30000; // 30 seconds

/**
 * Test entry prefix for cleanup
 */
export const TEST_ENTRY_PREFIX = 'test_';

/**
 * Generates a unique test headword
 */
export function generateTestHeadword(suffix?: string): string {
  const timestamp = Date.now();
  const random = Math.random().toString(36).substring(7);
  return `${TEST_ENTRY_PREFIX}${timestamp}_${random}${suffix ? '_' + suffix : ''}`;
}

/**
 * Property test annotation format
 * Example: "Feature: comprehensive-vocabulary-data, Property 1: Required Field Completeness"
 */
export function propertyTestTag(propertyNumber: number, propertyName: string): string {
  return `Feature: comprehensive-vocabulary-data, Property ${propertyNumber}: ${propertyName}`;
}
