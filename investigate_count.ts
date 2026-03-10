import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';

dotenv.config();

const supabaseUrl = process.env.VITE_SUPABASE_URL!;
const supabaseKey = process.env.VITE_SUPABASE_PUBLISHABLE_KEY!;
const supabase = createClient(supabaseUrl, supabaseKey);

async function investigate() {
  console.log('🔍 Investigating count discrepancy...\n');
  
  // Method 1: Count with head
  const { count: countHead } = await supabase
    .from('lexicon_entries')
    .select('*', { count: 'exact', head: true });
  
  console.log(`Method 1 (count with head): ${countHead}`);
  
  // Method 2: Fetch all and count
  const { data: allData } = await supabase
    .from('lexicon_entries')
    .select('id, headword');
  
  console.log(`Method 2 (fetch all): ${allData?.length || 0}`);
  
  // Method 3: Count unique headwords
  const { data: allHeadwords } = await supabase
    .from('lexicon_entries')
    .select('headword');
  
  const uniqueHeadwords = new Set(allHeadwords?.map(e => e.headword.toLowerCase()));
  console.log(`Method 3 (unique headwords): ${uniqueHeadwords.size}`);
  
  // Check for any null CEFR levels
  const { count: nullCefr } = await supabase
    .from('lexicon_entries')
    .select('*', { count: 'exact', head: true })
    .is('cefr_receptive', null);
  
  console.log(`\nEntries with null CEFR: ${nullCefr}`);
  
  // Count by CEFR level
  const { count: a0Count } = await supabase
    .from('lexicon_entries')
    .select('*', { count: 'exact', head: true })
    .eq('cefr_receptive', 'A0');
  
  const { count: a1Count } = await supabase
    .from('lexicon_entries')
    .select('*', { count: 'exact', head: true })
    .eq('cefr_receptive', 'A1');
  
  console.log(`\nA0 entries: ${a0Count}`);
  console.log(`A1 entries: ${a1Count}`);
  console.log(`Total (A0 + A1): ${a0Count! + a1Count!}`);
  
  // Check if there are duplicates
  if (allHeadwords) {
    const headwordCounts = new Map<string, number>();
    allHeadwords.forEach(e => {
      const key = e.headword.toLowerCase();
      headwordCounts.set(key, (headwordCounts.get(key) || 0) + 1);
    });
    
    const duplicates = Array.from(headwordCounts.entries())
      .filter(([_, count]) => count > 1);
    
    if (duplicates.length > 0) {
      console.log(`\n⚠️  Found ${duplicates.length} duplicate headwords:`);
      duplicates.slice(0, 10).forEach(([word, count]) => {
        console.log(`  - ${word}: ${count} copies`);
      });
    } else {
      console.log('\n✅ No duplicate headwords found');
    }
  }
}

investigate().catch(console.error);
