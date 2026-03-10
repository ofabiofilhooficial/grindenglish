/**
 * Test Database Connection Utilities
 * Provides utilities for connecting to and testing the Supabase database
 */

import { createClient, SupabaseClient } from '@supabase/supabase-js';

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL;
const supabaseKey = import.meta.env.VITE_SUPABASE_PUBLISHABLE_KEY;

if (!supabaseUrl || !supabaseKey) {
  throw new Error('Missing Supabase environment variables');
}

/**
 * Creates a Supabase client for testing
 */
export function createTestClient(): SupabaseClient {
  return createClient(supabaseUrl, supabaseKey);
}

/**
 * Type definition for lexicon entry
 */
export interface LexiconEntry {
  id: string;
  headword: string;
  entry_type: string;
  pos: string | null;
  cefr_receptive: string | null;
  cefr_productive: string | null;
  ipa: string | null;
  definition_simple: string | null;
  definition_teacher: string | null;
  usage_notes: string | null;
  register: string | null;
  variety: string | null;
  examples: string[];
  collocations: string[];
  patterns: string[];
  frequency_band: string | null;
  is_published: boolean;
  created_at: string;
  updated_at: string;
}

/**
 * Fetches a lexicon entry by headword
 */
export async function getLexiconEntry(
  client: SupabaseClient,
  headword: string
): Promise<LexiconEntry | null> {
  const { data, error } = await client
    .from('lexicon_entries')
    .select('*')
    .eq('headword', headword)
    .single();

  if (error) {
    if (error.code === 'PGRST116') {
      // No rows returned
      return null;
    }
    throw error;
  }

  return data as LexiconEntry;
}

/**
 * Fetches all published lexicon entries
 */
export async function getPublishedEntries(
  client: SupabaseClient
): Promise<LexiconEntry[]> {
  const { data, error } = await client
    .from('lexicon_entries')
    .select('*')
    .eq('is_published', true);

  if (error) {
    throw error;
  }

  return data as LexiconEntry[];
}

/**
 * Fetches entries by CEFR level
 */
export async function getEntriesByCEFR(
  client: SupabaseClient,
  cefrLevel: string
): Promise<LexiconEntry[]> {
  const { data, error } = await client
    .from('lexicon_entries')
    .select('*')
    .eq('cefr_receptive', cefrLevel);

  if (error) {
    throw error;
  }

  return data as LexiconEntry[];
}

/**
 * Inserts a test lexicon entry
 */
export async function insertTestEntry(
  client: SupabaseClient,
  entry: Partial<LexiconEntry>
): Promise<LexiconEntry> {
  const { data, error } = await client
    .from('lexicon_entries')
    .insert(entry)
    .select()
    .single();

  if (error) {
    throw error;
  }

  return data as LexiconEntry;
}

/**
 * Updates a lexicon entry
 */
export async function updateLexiconEntry(
  client: SupabaseClient,
  headword: string,
  updates: Partial<LexiconEntry>
): Promise<LexiconEntry> {
  const { data, error } = await client
    .from('lexicon_entries')
    .update(updates)
    .eq('headword', headword)
    .select()
    .single();

  if (error) {
    throw error;
  }

  return data as LexiconEntry;
}

/**
 * Deletes a test lexicon entry
 */
export async function deleteTestEntry(
  client: SupabaseClient,
  headword: string
): Promise<void> {
  const { error } = await client
    .from('lexicon_entries')
    .delete()
    .eq('headword', headword);

  if (error) {
    throw error;
  }
}

/**
 * Cleans up test entries (entries with headword starting with 'test_')
 */
export async function cleanupTestEntries(
  client: SupabaseClient
): Promise<void> {
  const { error } = await client
    .from('lexicon_entries')
    .delete()
    .like('headword', 'test_%');

  if (error) {
    throw error;
  }
}
