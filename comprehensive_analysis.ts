import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';

dotenv.config();

const supabaseUrl = process.env.VITE_SUPABASE_URL!;
const supabaseKey = process.env.VITE_SUPABASE_PUBLISHABLE_KEY!;
const supabase = createClient(supabaseUrl, supabaseKey);

async function comprehensiveAnalysis() {
  console.log('📊 COMPREHENSIVE VOCABULARY ANALYSIS\n');
  console.log('='.repeat(70));
  
  // Get all entries
  const { data: allEntries } = await supabase
    .from('lexicon_entries')
    .select('*')
    .order('headword');
  
  if (!allEntries) {
    console.log('❌ No data found');
    return;
  }
  
  // 1. Overall Statistics
  console.log('\n1. OVERALL STATISTICS');
  console.log('-'.repeat(70));
  console.log(`Total entries: ${allEntries.length}`);
  console.log(`Target: 1000 GSL words`);
  console.log(`Gap: ${1000 - allEntries.length} words missing\n`);
  
  // 2. Enhancement Status
  const enhanced = allEntries.filter(e => e.ipa && e.definition_simple);
  const unenhanced = allEntries.filter(e => !e.ipa || !e.definition_simple);
  
  console.log('2. ENHANCEMENT STATUS');
  console.log('-'.repeat(70));
  console.log(`Enhanced: ${enhanced.length} (${Math.round(enhanced.length/allEntries.length*100)}%)`);
  console.log(`Unenhanced: ${unenhanced.length} (${Math.round(unenhanced.length/allEntries.length*100)}%)\n`);
  
  // 3. By CEFR Level
  const byCEFR = {
    A0: { total: 0, enhanced: 0, unenhanced: [] as string[] },
    A1: { total: 0, enhanced: 0, unenhanced: [] as string[] },
    Other: { total: 0, enhanced: 0, unenhanced: [] as string[] }
  };
  
  allEntries.forEach(e => {
    const level = e.cefr_receptive || 'Other';
    const key = (level === 'A0' || level === 'A1') ? level : 'Other';
    byCEFR[key].total++;
    if (e.ipa && e.definition_simple) {
      byCEFR[key].enhanced++;
    } else {
      byCEFR[key].unenhanced.push(e.headword);
    }
  });
  
  console.log('3. BY CEFR LEVEL');
  console.log('-'.repeat(70));
  Object.entries(byCEFR).forEach(([level, data]) => {
    if (data.total > 0) {
      const pct = Math.round((data.enhanced / data.total) * 100);
      console.log(`${level}: ${data.enhanced}/${data.total} enhanced (${pct}%)`);
      console.log(`   Unenhanced: ${data.unenhanced.length} words`);
      if (data.unenhanced.length <= 10) {
        console.log(`   Words: ${data.unenhanced.join(', ')}`);
      } else {
        console.log(`   First 10: ${data.unenhanced.slice(0, 10).join(', ')}...`);
      }
    }
  });
  
  // 4. Expected vs Actual (based on original plan)
  console.log('\n4. ORIGINAL PLAN vs ACTUAL');
  console.log('-'.repeat(70));
  
  const originalPlan = {
    'Batch 1 (A0 Pronouns & Basic Verbs)': {
      expected: 150,
      sample: ['I', 'you', 'he', 'she', 'it', 'we', 'they', 'be', 'have', 'do', 'go', 'come', 'get', 'make', 'take']
    },
    'Batch 2 (A0 Common Nouns & Adjectives)': {
      expected: 150,
      sample: ['time', 'person', 'year', 'way', 'day', 'thing', 'man', 'world', 'good', 'new', 'first', 'last']
    },
    'Batch 3 (A0 Prepositions, Determiners, Conjunctions)': {
      expected: 100,
      sample: ['in', 'on', 'at', 'to', 'from', 'with', 'for', 'about', 'the', 'a', 'an', 'this', 'that', 'and', 'but', 'or']
    },
    'Batch 4 (A1 Work & Business)': {
      expected: 150,
      sample: ['work', 'job', 'business', 'company', 'office', 'meeting', 'manage', 'organize', 'plan']
    },
    'Batch 5 (A1 Communication & Technology)': {
      expected: 150,
      sample: ['say', 'tell', 'speak', 'talk', 'ask', 'answer', 'call', 'computer', 'phone', 'email']
    },
    'Batch 6 (A1 Time & Quantity)': {
      expected: 150,
      sample: ['today', 'tomorrow', 'yesterday', 'week', 'month', 'hour', 'many', 'much', 'some', 'all']
    },
    'Batch 7 (A1 Remaining High-Frequency)': {
      expected: 150,
      sample: ['can', 'could', 'will', 'would', 'should', 'must', 'know', 'think', 'want', 'need']
    }
  };
  
  let totalExpected = 0;
  let totalFound = 0;
  let totalEnhanced = 0;
  
  for (const [batchName, batch] of Object.entries(originalPlan)) {
    totalExpected += batch.expected;
    let found = 0;
    let enhancedCount = 0;
    const missing: string[] = [];
    
    for (const word of batch.sample) {
      const entry = allEntries.find(e => e.headword.toLowerCase() === word.toLowerCase());
      if (entry) {
        found++;
        if (entry.ipa && entry.definition_simple) {
          enhancedCount++;
        }
      } else {
        missing.push(word);
      }
    }
    
    totalFound += found;
    totalEnhanced += enhancedCount;
    
    console.log(`\n${batchName}:`);
    console.log(`  Expected: ~${batch.expected} words`);
    console.log(`  Sample check: ${found}/${batch.sample.length} found, ${enhancedCount} enhanced`);
    if (missing.length > 0) {
      console.log(`  Missing from sample: ${missing.join(', ')}`);
    }
  }
  
  console.log(`\nTotal Expected: ${totalExpected} words`);
  
  // 5. Data Quality Check
  console.log('\n5. DATA QUALITY CHECK');
  console.log('-'.repeat(70));
  
  const qualityIssues = {
    missingIPA: 0,
    missingDefinitionSimple: 0,
    missingDefinitionTeacher: 0,
    missingUsageNotes: 0,
    missingExamples: 0,
    missingRegister: 0,
    missingVariety: 0,
    fewExamples: 0,
    noCollocations: 0
  };
  
  enhanced.forEach(e => {
    if (!e.ipa) qualityIssues.missingIPA++;
    if (!e.definition_simple) qualityIssues.missingDefinitionSimple++;
    if (!e.definition_teacher) qualityIssues.missingDefinitionTeacher++;
    if (!e.usage_notes) qualityIssues.missingUsageNotes++;
    if (!e.examples || !Array.isArray(e.examples) || e.examples.length === 0) {
      qualityIssues.missingExamples++;
    } else if (e.examples.length < 2) {
      qualityIssues.fewExamples++;
    }
    if (!e.register) qualityIssues.missingRegister++;
    if (!e.variety) qualityIssues.missingVariety++;
    if (!e.collocations || !Array.isArray(e.collocations) || e.collocations.length === 0) {
      qualityIssues.noCollocations++;
    }
  });
  
  console.log('Enhanced entries quality:');
  console.log(`  Missing IPA: ${qualityIssues.missingIPA}`);
  console.log(`  Missing simple definition: ${qualityIssues.missingDefinitionSimple}`);
  console.log(`  Missing teacher definition: ${qualityIssues.missingDefinitionTeacher}`);
  console.log(`  Missing usage notes: ${qualityIssues.missingUsageNotes}`);
  console.log(`  Missing examples: ${qualityIssues.missingExamples}`);
  console.log(`  < 2 examples: ${qualityIssues.fewExamples}`);
  console.log(`  Missing register: ${qualityIssues.missingRegister}`);
  console.log(`  Missing variety: ${qualityIssues.missingVariety}`);
  console.log(`  No collocations: ${qualityIssues.noCollocations}`);
  
  // 6. Recommendations
  console.log('\n6. RECOMMENDATIONS');
  console.log('-'.repeat(70));
  
  const missingWords = 1000 - allEntries.length;
  const unenhancedWords = unenhanced.length;
  
  if (missingWords > 0) {
    console.log(`\n⚠️  MISSING WORDS: ${missingWords} words`);
    console.log('   Action: Need to add missing GSL words to database');
    console.log('   Options:');
    console.log('   a) Re-run seed migration with complete GSL list');
    console.log('   b) Create supplemental migration to add missing words');
  }
  
  if (unenhancedWords > 0) {
    console.log(`\n⚠️  UNENHANCED WORDS: ${unenhancedWords} words`);
    console.log('   Action: Need to enhance remaining words');
    console.log('   Options:');
    console.log('   a) Re-run enhancement batches (they may have failed partially)');
    console.log('   b) Create targeted migrations for unenhanced words');
  }
  
  if (qualityIssues.missingDefinitionTeacher > 0 || qualityIssues.missingUsageNotes > 0) {
    console.log(`\n⚠️  INCOMPLETE ENHANCEMENTS: Some enhanced words missing optional fields`);
    console.log('   Action: Consider adding teacher definitions and usage notes');
  }
  
  console.log('\n' + '='.repeat(70));
  console.log('SUMMARY');
  console.log('='.repeat(70));
  console.log(`Current: ${allEntries.length}/1000 words (${Math.round(allEntries.length/1000*100)}%)`);
  console.log(`Enhanced: ${enhanced.length}/${allEntries.length} (${Math.round(enhanced.length/allEntries.length*100)}%)`);
  console.log(`\nTo complete original plan:`);
  console.log(`  1. Add ${missingWords} missing words`);
  console.log(`  2. Enhance ${unenhancedWords} existing words`);
  console.log(`  3. Total work remaining: ${missingWords + unenhancedWords} words`);
}

comprehensiveAnalysis().catch(console.error);
