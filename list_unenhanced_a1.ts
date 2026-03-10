import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import fs from 'fs';

dotenv.config();

const supabaseUrl = process.env.VITE_SUPABASE_URL!;
const supabaseKey = process.env.VITE_SUPABASE_PUBLISHABLE_KEY!;
const supabase = createClient(supabaseUrl, supabaseKey);

async function listUnenhancedA1() {
  console.log('🔍 Finding unenhanced A1 words...\n');
  
  const { data: unenhanced } = await supabase
    .from('lexicon_entries')
    .select('headword, part_of_speech, cefr_receptive')
    .eq('cefr_receptive', 'A1')
    .or('ipa.is.null,definition_simple.is.null')
    .order('headword');
  
  if (!unenhanced || unenhanced.length === 0) {
    console.log('✅ All A1 words are enhanced!');
    return;
  }
  
  console.log(`Found ${unenhanced.length} unenhanced A1 words:\n`);
  
  // Save to file
  fs.writeFileSync('unenhanced_a1.json', JSON.stringify(unenhanced, null, 2));
  console.log('📝 Saved to unenhanced_a1.json');
  
  // Show first 20
  console.log('\nFirst 20 words:');
  unenhanced.slice(0, 20).forEach((word, i) => {
    console.log(`${i + 1}. ${word.headword} (${word.part_of_speech})`);
  });
}

listUnenhancedA1().catch(console.error);
