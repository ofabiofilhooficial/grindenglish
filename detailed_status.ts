import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import fs from 'fs';

dotenv.config();

const supabaseUrl = process.env.VITE_SUPABASE_URL!;
const supabaseKey = process.env.VITE_SUPABASE_PUBLISHABLE_KEY!;
const supabase = createClient(supabaseUrl, supabaseKey);

async function detailedStatus() {
  console.log('🔍 Detailed Vocabulary Status\n');
  
  // Total count
  const { count: total } = await supabase
    .from('lexicon_entries')
    .select('*', { count: 'exact', head: true });
  
  console.log(`📊 Total entries: ${total}\n`);
  
  // A0 stats
  const { count: a0Total } = await supabase
    .from('lexicon_entries')
    .select('*', { count: 'exact', head: true })
    .eq('cefr_receptive', 'A0');
  
  const { count: a0Enhanced } = await supabase
    .from('lexicon_entries')
    .select('*', { count: 'exact', head: true })
    .eq('cefr_receptive', 'A0')
    .not('ipa', 'is', null)
    .not('definition_simple', 'is', null);
  
  console.log(`A0: ${a0Enhanced}/${a0Total} enhanced (${Math.round(a0Enhanced! / a0Total! * 100)}%)`);
  
  // A1 stats
  const { count: a1Total } = await supabase
    .from('lexicon_entries')
    .select('*', { count: 'exact', head: true })
    .eq('cefr_receptive', 'A1');
  
  const { count: a1Enhanced } = await supabase
    .from('lexicon_entries')
    .select('*', { count: 'exact', head: true })
    .eq('cefr_receptive', 'A1')
    .not('ipa', 'is', null)
    .not('definition_simple', 'is', null);
  
  console.log(`A1: ${a1Enhanced}/${a1Total} enhanced (${Math.round(a1Enhanced! / a1Total! * 100)}%)`);
  
  // Get unenhanced A1 words
  const { data: unenhancedA1 } = await supabase
    .from('lexicon_entries')
    .select('headword, part_of_speech')
    .eq('cefr_receptive', 'A1')
    .or('ipa.is.null,definition_simple.is.null')
    .order('headword');
  
  if (unenhancedA1 && unenhancedA1.length > 0) {
    console.log(`\n⚠️  ${unenhancedA1.length} A1 words need enhancement\n`);
    fs.writeFileSync('unenhanced_a1_words.json', JSON.stringify(unenhancedA1, null, 2));
    console.log('📝 Saved to unenhanced_a1_words.json');
    
    console.log('\nFirst 30 words:');
    unenhancedA1.slice(0, 30).forEach((word, i) => {
      console.log(`${i + 1}. ${word.headword} (${word.part_of_speech})`);
    });
  } else {
    console.log('\n✅ All A1 words are fully enhanced!');
  }
  
  // Overall completion
  const { count: totalEnhanced } = await supabase
    .from('lexicon_entries')
    .select('*', { count: 'exact', head: true })
    .not('ipa', 'is', null)
    .not('definition_simple', 'is', null);
  
  console.log(`\n📈 Overall: ${totalEnhanced}/${total} enhanced (${Math.round(totalEnhanced! / total! * 100)}%)`);
}

detailedStatus().catch(console.error);
