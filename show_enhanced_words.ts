import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';

dotenv.config();

const supabaseUrl = process.env.VITE_SUPABASE_URL!;
const supabaseKey = process.env.VITE_SUPABASE_PUBLISHABLE_KEY!;
const supabase = createClient(supabaseUrl, supabaseKey);

async function showEnhancedWords() {
  const { data: enhanced } = await supabase
    .from('lexicon_entries')
    .select('headword, cefr_receptive, ipa, definition_simple')
    .not('ipa', 'is', null)
    .not('definition_simple', 'is', null)
    .order('headword');
  
  if (!enhanced) {
    console.log('No enhanced words found');
    return;
  }
  
  console.log(`\n✅ Enhanced words (${enhanced.length} total):\n`);
  enhanced.forEach((word, i) => {
    console.log(`${i + 1}. ${word.headword} (${word.cefr_receptive}) - /${word.ipa}/`);
  });
}

showEnhancedWords().catch(console.error);
