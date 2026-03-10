import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';

dotenv.config();

const supabaseUrl = process.env.VITE_SUPABASE_URL!;
const supabaseKey = process.env.VITE_SUPABASE_PUBLISHABLE_KEY!;

console.log('🔍 Debugging Database Connection...\n');
console.log('Supabase URL:', supabaseUrl);
console.log('Using Key:', supabaseKey.substring(0, 20) + '...\n');

const supabase = createClient(supabaseUrl, supabaseKey);

async function debugDatabase() {
  // Test 1: Check if table exists
  console.log('Test 1: Checking if lexicon_entries table exists...');
  const { data: tables, error: tableError } = await supabase
    .from('lexicon_entries')
    .select('*', { count: 'exact', head: true })
    .limit(0);
  
  if (tableError) {
    console.log('❌ Error accessing table:', tableError.message);
    console.log('   Code:', tableError.code);
    console.log('   Details:', tableError.details);
    console.log('   Hint:', tableError.hint);
    return;
  }
  console.log('✅ Table exists and is accessible\n');
  
  // Test 2: Check RLS policies
  console.log('Test 2: Checking Row Level Security (RLS) policies...');
  const { data: entries, error: selectError, count } = await supabase
    .from('lexicon_entries')
    .select('*', { count: 'exact' })
    .limit(5);
  
  if (selectError) {
    console.log('❌ Error selecting data:', selectError.message);
    console.log('   This might be an RLS policy issue\n');
  } else {
    console.log(`✅ Can query table. Found ${count} entries`);
    console.log('   Entries:', JSON.stringify(entries, null, 2));
    console.log('');
  }
  
  // Test 3: Try with service role (if available)
  console.log('Test 3: Checking with different authentication...');
  const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.VITE_SUPABASE_SERVICE_ROLE_KEY;
  
  if (serviceKey) {
    console.log('   Found service role key, testing...');
    const serviceClient = createClient(supabaseUrl, serviceKey);
    const { data: serviceData, count: serviceCount } = await serviceClient
      .from('lexicon_entries')
      .select('*', { count: 'exact' })
      .limit(5);
    
    console.log(`   Service role sees ${serviceCount} entries`);
    if (serviceCount && serviceCount > 0) {
      console.log('   ⚠️  RLS POLICY ISSUE DETECTED!');
      console.log('   The data exists but RLS policies are blocking anonymous access\n');
    }
  } else {
    console.log('   No service role key found in environment\n');
  }
  
  // Test 4: Check specific query that app uses
  console.log('Test 4: Testing query used by validation script...');
  const { data: published, error: pubError, count: pubCount } = await supabase
    .from('lexicon_entries')
    .select('*', { count: 'exact' })
    .eq('is_published', true)
    .in('cefr_receptive', ['A0', 'A1']);
  
  if (pubError) {
    console.log('❌ Error:', pubError.message);
  } else {
    console.log(`✅ Published A0/A1 entries: ${pubCount}`);
    if (pubCount === 0) {
      console.log('   ⚠️  No published entries found with A0/A1 CEFR levels\n');
    }
  }
  
  // Test 5: Check without filters
  console.log('Test 5: Checking all entries without filters...');
  const { count: allCount } = await supabase
    .from('lexicon_entries')
    .select('*', { count: 'exact', head: true });
  
  console.log(`   Total entries (no filters): ${allCount}\n`);
  
  // Test 6: Check RLS policies in database
  console.log('Test 6: Attempting to query RLS policies...');
  const { data: policies, error: policyError } = await supabase
    .rpc('get_policies_for_table', { table_name: 'lexicon_entries' })
    .limit(5);
  
  if (policyError) {
    console.log('   Cannot query policies (expected):', policyError.message);
  } else {
    console.log('   Policies:', policies);
  }
  
  console.log('\n' + '='.repeat(60));
  console.log('DIAGNOSIS:');
  console.log('='.repeat(60));
  
  if (count === 0 && !selectError) {
    console.log('❌ Table is empty OR RLS policies are blocking access');
    console.log('\nPossible causes:');
    console.log('1. Migrations ran but data was not inserted');
    console.log('2. RLS policies are blocking anonymous access');
    console.log('3. Data was inserted but then deleted');
    console.log('4. Connected to wrong database/project');
    console.log('\nNext steps:');
    console.log('1. Check Supabase Dashboard > Table Editor > lexicon_entries');
    console.log('2. Check Supabase Dashboard > Authentication > Policies');
    console.log('3. Verify you\'re connected to the correct project');
  } else if (selectError) {
    console.log('❌ Cannot access table');
    console.log('\nLikely cause: RLS policy blocking access');
    console.log('\nNext steps:');
    console.log('1. Check RLS policies in Supabase Dashboard');
    console.log('2. Ensure anonymous users can SELECT from lexicon_entries');
  } else {
    console.log('✅ Everything looks good!');
    console.log(`   Found ${count} entries in database`);
  }
  console.log('='.repeat(60));
}

debugDatabase().catch(console.error);
