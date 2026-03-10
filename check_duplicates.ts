import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';

dotenv.config();

const supabaseUrl = process.env.VITE_SUPABASE_URL!;
const supabaseKey = process.env.VITE_SUPABASE_PUBLISHABLE_KEY!;
const supabase = createClient(supabaseUrl, supabaseKey);

async function checkDuplicates() {
  console.log('🔍 Checking for duplicate entries...\n');
  
  // Get all entries
  const { data: allEntries } = await supabase
    .from('lexicon_entries')
    .select('id, headword, cefr_receptive, ipa, definition_simple')
    .order('headword');
  
  if (!allEntries) {
    console.log('❌ No data found');
    return;
  }
  
  console.log(`Total entries: ${allEntries.length}\n`);
  
  // Find duplicates
  const headwordCounts = new Map<string, any[]>();
  
  allEntries.forEach(entry => {
    const key = entry.headword.toLowerCase();
    if (!headwordCounts.has(key)) {
      headwordCounts.set(key, []);
    }
    headwordCounts.get(key)!.push(entry);
  });
  
  // Filter to only duplicates
  const duplicates = Array.from(headwordCounts.entries())
    .filter(([_, entries]) => entries.length > 1)
    .sort((a, b) => b[1].length - a[1].length);
  
  if (duplicates.length === 0) {
    console.log('✅ No duplicates found! All entries are unique.');
    return;
  }
  
  console.log(`⚠️  Found ${duplicates.length} words with duplicates:\n`);
  
  duplicates.forEach(([headword, entries]) => {
    console.log(`${headword} (${entries.length} copies):`);
    entries.forEach((entry, i) => {
      const enhanced = entry.ipa && entry.definition_simple ? '✅' : '❌';
      console.log(`  ${i + 1}. ID: ${entry.id.substring(0, 8)}... ${enhanced} ${entry.cefr_receptive || 'no CEFR'}`);
    });
    console.log('');
  });
  
  console.log(`\nTotal duplicate entries to remove: ${duplicates.reduce((sum, [_, entries]) => sum + entries.length - 1, 0)}`);
  
  // Suggest which to keep
  console.log('\n📋 Recommendation: Keep enhanced entries, remove unenhanced duplicates');
}

checkDuplicates().catch(console.error);
