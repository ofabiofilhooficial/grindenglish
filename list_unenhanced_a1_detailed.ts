import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import fs from 'fs';

dotenv.config();

const supabaseUrl = process.env.VITE_SUPABASE_URL!;
const supabaseKey = process.env.VITE_SUPABASE_PUBLISHABLE_KEY!;
const supabase = createClient(supabaseUrl, supabaseKey);

async function listUnenhanced() {
  console.log('🔍 Finding unenhanced A1 words...\n');
  
  // Fetch ALL A1 entries with pagination
  let allA1: any[] = [];
  let page = 0;
  const pageSize = 1000;
  
  while (true) {
    const { data } = await supabase
      .from('lexicon_entries')
      .select('headword, part_of_speech, ipa, definition_simple')
      .eq('cefr_receptive', 'A1')
      .range(page * pageSize, (page + 1) * pageSize - 1)
      .order('headword');
    
    if (!data || data.length === 0) break;
    allA1 = allA1.concat(data);
    if (data.length < pageSize) break;
    page++;
  }
  
  console.log(`📊 Total A1 entries: ${allA1.length}`);
  
  // Filter unenhanced
  const unenhanced = allA1.filter(e => !e.ipa || !e.definition_simple);
  
  console.log(`✨ Enhanced: ${allA1.length - unenhanced.length}`);
  console.log(`⚠️  Unenhanced: ${unenhanced.length}\n`);
  
  if (unenhanced.length > 0) {
    console.log('Unenhanced A1 words:');
    unenhanced.forEach((word, i) => {
      console.log(`${i + 1}. ${word.headword} (${word.part_of_speech})`);
    });
    
    fs.writeFileSync('unenhanced_a1_list.json', JSON.stringify(unenhanced, null, 2));
    console.log(`\n📝 Saved to unenhanced_a1_list.json`);
  } else {
    console.log('✅ All A1 words are enhanced!');
  }
}

listUnenhanced().catch(console.error);
