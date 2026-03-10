import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';

dotenv.config();

const supabaseUrl = process.env.VITE_SUPABASE_URL!;
const supabaseKey = process.env.VITE_SUPABASE_PUBLISHABLE_KEY!;
const supabase = createClient(supabaseUrl, supabaseKey);

async function analyzeVocabulary() {
  console.log('📊 Analyzing Vocabulary Database...\n');
  
  // Get total counts by CEFR level
  const { data: allEntries } = await supabase
    .from('lexicon_entries')
    .select('headword, cefr_receptive, ipa, definition_simple, examples');
  
  if (!allEntries) {
    console.log('❌ No data found');
    return;
  }
  
  console.log(`Total entries: ${allEntries.length}\n`);
  
  // Group by CEFR level
  const byCEFR = allEntries.reduce((acc: any, entry) => {
    const level = entry.cefr_receptive || 'Unknown';
    if (!acc[level]) {
      acc[level] = { total: 0, enhanced: 0, words: [] };
    }
    acc[level].total++;
    if (entry.ipa && entry.definition_simple) {
      acc[level].enhanced++;
    } else {
      acc[level].words.push(entry.headword);
    }
    return acc;
  }, {});
  
  console.log('By CEFR Level:');
  Object.keys(byCEFR).sort().forEach(level => {
    const data = byCEFR[level];
    const pct = Math.round((data.enhanced / data.total) * 100);
    console.log(`  ${level}: ${data.enhanced}/${data.total} enhanced (${pct}%)`);
    if (data.words.length > 0 && data.words.length <= 20) {
      console.log(`    Missing enhancements: ${data.words.join(', ')}`);
    } else if (data.words.length > 20) {
      console.log(`    Missing enhancements: ${data.words.slice(0, 20).join(', ')}... (${data.words.length} total)`);
    }
  });
  
  console.log('\n' + '='.repeat(60));
  
  // Check for words from the original GSL list
  const gslSample = ['I', 'you', 'he', 'she', 'it', 'we', 'they', 'be', 'have', 'do'];
  console.log('\nChecking GSL sample words:');
  
  for (const word of gslSample) {
    const entry = allEntries.find(e => e.headword.toLowerCase() === word.toLowerCase());
    if (entry) {
      const status = entry.ipa && entry.definition_simple ? '✅ Enhanced' : '⚠️  Basic only';
      console.log(`  ${word}: ${status}`);
    } else {
      console.log(`  ${word}: ❌ Not found`);
    }
  }
  
  // Show sample of unenhanced entries
  const unenhanced = allEntries.filter(e => !e.ipa || !e.definition_simple);
  console.log(`\n\nUnenhanced entries (${unenhanced.length} total):`);
  console.log('First 20:');
  unenhanced.slice(0, 20).forEach(e => {
    console.log(`  - ${e.headword} (${e.cefr_receptive})`);
  });
}

analyzeVocabulary().catch(console.error);
