import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';

dotenv.config();

const supabaseUrl = process.env.VITE_SUPABASE_URL!;
const supabaseKey = process.env.VITE_SUPABASE_PUBLISHABLE_KEY!;
const supabase = createClient(supabaseUrl, supabaseKey);

async function debug() {
  console.log('🔍 Debugging CEFR levels...\n');
  
  // Fetch first 20 entries to see what we have
  const { data: sample } = await supabase
    .from('lexicon_entries')
    .select('headword, cefr_receptive, ipa, definition_simple')
    .limit(20)
    .order('headword');
  
  console.log('Sample entries:');
  sample?.forEach((e, i) => {
    const enhanced = e.ipa && e.definition_simple ? '✅' : '❌';
    console.log(`${i + 1}. ${e.headword} - CEFR: "${e.cefr_receptive}" ${enhanced}`);
  });
  
  // Count by exact CEFR value
  const { data: allCefr } = await supabase
    .from('lexicon_entries')
    .select('cefr_receptive');
  
  if (allCefr) {
    const cefrCounts = new Map<string, number>();
    allCefr.forEach(e => {
      const key = e.cefr_receptive || 'null';
      cefrCounts.set(key, (cefrCounts.get(key) || 0) + 1);
    });
    
    console.log('\nCEFR distribution:');
    Array.from(cefrCounts.entries())
      .sort((a, b) => b[1] - a[1])
      .forEach(([level, count]) => {
        console.log(`  ${level}: ${count}`);
      });
  }
}

debug().catch(console.error);
