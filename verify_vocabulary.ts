import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';

dotenv.config();

const supabaseUrl = process.env.VITE_SUPABASE_URL!;
const supabaseKey = process.env.VITE_SUPABASE_PUBLISHABLE_KEY!;

const supabase = createClient(supabaseUrl, supabaseKey);

async function verifyVocabulary() {
  console.log('🔍 Verifying Vocabulary Database...\n');
  
  // Check total entries
  const { count: totalCount } = await supabase
    .from('lexicon_entries')
    .select('*', { count: 'exact', head: true });
  
  console.log(`📊 Total vocabulary entries: ${totalCount}`);
  
  if (totalCount === 0) {
    console.log('\n❌ No entries found!');
    console.log('👉 You need to apply the migrations. See QUICK_FIX_VOCABULARY.md\n');
    return;
  }
  
  // Check enhanced entries
  const { count: enhancedCount } = await supabase
    .from('lexicon_entries')
    .select('*', { count: 'exact', head: true })
    .not('ipa', 'is', null)
    .not('definition_simple', 'is', null);
  
  console.log(`✨ Enhanced entries (with IPA + definition): ${enhancedCount}`);
  
  // Calculate completion percentage
  const completionPercentage = totalCount ? Math.round((enhancedCount! / totalCount) * 100) : 0;
  console.log(`📈 Completion: ${completionPercentage}%\n`);
  
  // Check by CEFR level
  const { data: a0Data, count: a0Count } = await supabase
    .from('lexicon_entries')
    .select('*', { count: 'exact', head: true })
    .eq('cefr_receptive', 'A0');
  
  const { count: a0Enhanced } = await supabase
    .from('lexicon_entries')
    .select('*', { count: 'exact', head: true })
    .eq('cefr_receptive', 'A0')
    .not('ipa', 'is', null);
  
  const { data: a1Data, count: a1Count } = await supabase
    .from('lexicon_entries')
    .select('*', { count: 'exact', head: true })
    .eq('cefr_receptive', 'A1');
  
  const { count: a1Enhanced } = await supabase
    .from('lexicon_entries')
    .select('*', { count: 'exact', head: true })
    .eq('cefr_receptive', 'A1')
    .not('ipa', 'is', null);
  
  console.log('📚 By CEFR Level:');
  console.log(`   A0: ${a0Enhanced}/${a0Count} enhanced (${Math.round((a0Enhanced! / a0Count!) * 100)}%)`);
  console.log(`   A1: ${a1Enhanced}/${a1Count} enhanced (${Math.round((a1Enhanced! / a1Count!) * 100)}%)\n`);
  
  // Show sample enhanced entries
  const { data: samples } = await supabase
    .from('lexicon_entries')
    .select('headword, ipa, definition_simple, examples')
    .not('ipa', 'is', null)
    .limit(3);
  
  if (samples && samples.length > 0) {
    console.log('📖 Sample Enhanced Entries:\n');
    samples.forEach((entry, index) => {
      console.log(`${index + 1}. ${entry.headword} /${entry.ipa}/`);
      console.log(`   Definition: ${entry.definition_simple}`);
      if (entry.examples && Array.isArray(entry.examples)) {
        console.log(`   Examples: ${entry.examples.length} provided`);
      }
      console.log('');
    });
  }
  
  // Status summary
  console.log('━'.repeat(60));
  if (completionPercentage === 100) {
    console.log('✅ SUCCESS! All vocabulary entries are fully enhanced!');
    console.log('👉 Your vocabulary section should now show complete information.');
  } else if (completionPercentage > 0) {
    console.log(`⚠️  PARTIAL: ${completionPercentage}% of entries are enhanced.`);
    console.log('👉 Apply remaining migration batches to complete.');
  } else {
    console.log('❌ NOT STARTED: Entries exist but none are enhanced.');
    console.log('👉 Apply enhancement migrations (batches 2-8).');
  }
  console.log('━'.repeat(60));
  console.log('\nFor detailed validation, run: npm run vocab:validate\n');
}

verifyVocabulary().catch(console.error);
