import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import fs from 'fs';

dotenv.config();

const supabaseUrl = process.env.VITE_SUPABASE_URL!;
const supabaseKey = process.env.VITE_SUPABASE_PUBLISHABLE_KEY!;
const supabase = createClient(supabaseUrl, supabaseKey);

async function getUnenhanced() {
  console.log('🔍 Getting unenhanced A1 words...\n');
  
  // Fetch ALL entries with pagination
  let allEntries: any[] = [];
  let page = 0;
  const pageSize = 1000;
  
  while (true) {
    const from = page * pageSize;
    const to = from + pageSize - 1;
    
    const { data, error } = await supabase
      .from('lexicon_entries')
      .select('headword, pos, cefr_receptive, ipa, definition_simple')
      .range(from, to)
      .order('headword');
    
    if (error) {
      console.error('Error fetching:', error);
      break;
    }
    
    if (!data || data.length === 0) break;
    
    console.log(`  Fetched page ${page + 1}: ${data.length} entries`);
    allEntries = allEntries.concat(data);
    
    if (data.length < pageSize) break;
    page++;
  }
  
  console.log(`📊 Total entries: ${allEntries.length}`);
  
  // Filter A1 entries
  const a1Entries = allEntries.filter(e => e.cefr_receptive === 'A1');
  console.log(`📚 A1 entries: ${a1Entries.length}`);
  
  // Filter unenhanced A1
  const unenhancedA1 = a1Entries.filter(e => !e.ipa || !e.definition_simple);
  const enhancedA1 = a1Entries.filter(e => e.ipa && e.definition_simple);
  
  console.log(`✨ Enhanced A1: ${enhancedA1.length}`);
  console.log(`⚠️  Unenhanced A1: ${unenhancedA1.length}\n`);
  
  if (unenhancedA1.length > 0) {
    console.log(`First 50 unenhanced A1 words:`);
    unenhancedA1.slice(0, 50).forEach((word, i) => {
      console.log(`${i + 1}. ${word.headword} (${word.pos})`);
    });
    
    fs.writeFileSync('unenhanced_a1_words.json', JSON.stringify(unenhancedA1, null, 2));
    console.log(`\n📝 Saved all ${unenhancedA1.length} words to unenhanced_a1_words.json`);
    
    // Also check A0
    const a0Entries = allEntries.filter(e => e.cefr_receptive === 'A0');
    const unenhancedA0 = a0Entries.filter(e => !e.ipa || !e.definition_simple);
    
    console.log(`\n📊 A0 status:`);
    console.log(`   Total: ${a0Entries.length}`);
    console.log(`   Enhanced: ${a0Entries.length - unenhancedA0.length}`);
    console.log(`   Unenhanced: ${unenhancedA0.length}`);
  } else {
    console.log('✅ All A1 words are enhanced!');
  }
}

getUnenhanced().catch(console.error);
