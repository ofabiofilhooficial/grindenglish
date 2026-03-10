import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import * as fs from 'fs';

dotenv.config();

const supabaseUrl = process.env.VITE_SUPABASE_URL!;
const supabaseKey = process.env.VITE_SUPABASE_PUBLISHABLE_KEY!;
const supabase = createClient(supabaseUrl, supabaseKey);

async function getA0Unenhanced() {
  const { data } = await supabase
    .from('lexicon_entries')
    .select('headword, pos, cefr_receptive')
    .eq('cefr_receptive', 'A0')
    .or('ipa.is.null,definition_simple.is.null')
    .order('headword');
  
  if (!data) {
    console.log('No unenhanced A0 words found');
    return;
  }
  
  console.log(`Found ${data.length} unenhanced A0 words:\n`);
  data.forEach((word, i) => {
    console.log(`${i + 1}. ${word.headword} (${word.pos})`);
  });
  
  fs.writeFileSync('a0_unenhanced.json', JSON.stringify(data, null, 2));
  console.log(`\n✅ Saved to a0_unenhanced.json`);
}

getA0Unenhanced().catch(console.error);
