import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import fs from 'fs';

dotenv.config();

const supabaseUrl = process.env.VITE_SUPABASE_URL!;
const supabaseKey = process.env.VITE_SUPABASE_PUBLISHABLE_KEY!;
const supabase = createClient(supabaseUrl, supabaseKey);

async function fetchAll() {
  console.log('🔍 Fetching ALL entries (bypassing pagination)...\n');
  
  let allEntries: any[] = [];
  let page = 0;
  const pageSize = 1000;
  
  while (true) {
    const { data, error } = await supabase
      .from('lexicon_entries')
      .select('id, headword, cefr_receptive, ipa, definition_simple')
      .range(page * pageSize, (page + 1) * pageSize - 1)
      .order('headword');
    
    if (error) {
      console.error('Error:', error);
      break;
    }
    
    if (!data || data.length === 0) break;
    
    allEntries = allEntries.concat(data);
    console.log(`Fetched page ${page + 1}: ${data.length} entries`);
    
    if (data.length < pageSize) break;
    page++;
  }
  
  console.log(`\n📊 Total entries fetched: ${allEntries.length}`);
  
  // Check for duplicates
  const headwordCounts = new Map<string, any[]>();
  allEntries.forEach(entry => {
    const key = entry.headword.toLowerCase();
    if (!headwordCounts.has(key)) {
      headwordCounts.set(key, []);
    }
    headwordCounts.get(key)!.push(entry);
  });
  
  const duplicates = Array.from(headwordCounts.entries())
    .filter(([_, entries]) => entries.length > 1);
  
  if (duplicates.length > 0) {
    console.log(`\n⚠️  Found ${duplicates.length} duplicate headwords:`);
    duplicates.forEach(([word, entries]) => {
      console.log(`\n${word} (${entries.length} copies):`);
      entries.forEach((e, i) => {
        const enhanced = e.ipa && e.definition_simple ? '✅' : '❌';
        console.log(`  ${i + 1}. ${enhanced} ${e.cefr_receptive} - ID: ${e.id.substring(0, 8)}...`);
      });
    });
    
    // Save duplicates for removal
    const duplicateIds = duplicates.flatMap(([_, entries]) => 
      entries.slice(1).map(e => e.id) // Keep first, remove rest
    );
    
    fs.writeFileSync('duplicate_ids_to_remove.json', JSON.stringify(duplicateIds, null, 2));
    console.log(`\n📝 Saved ${duplicateIds.length} duplicate IDs to duplicate_ids_to_remove.json`);
  } else {
    console.log('\n✅ No duplicates found!');
  }
  
  // Count by CEFR
  const a0 = allEntries.filter(e => e.cefr_receptive === 'A0');
  const a1 = allEntries.filter(e => e.cefr_receptive === 'A1');
  
  console.log(`\nA0: ${a0.length}`);
  console.log(`A1: ${a1.length}`);
  console.log(`Total: ${a0.length + a1.length}`);
}

fetchAll().catch(console.error);
