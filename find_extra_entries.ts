import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import fs from 'fs';

dotenv.config();

const supabaseUrl = process.env.VITE_SUPABASE_URL!;
const supabaseKey = process.env.VITE_SUPABASE_PUBLISHABLE_KEY!;
const supabase = createClient(supabaseUrl, supabaseKey);

// First 1000 words from GSL
const gslWords = `a able about above accept accord account across act actual add address admit adopt advance advantage affair afford after again against age ago agree air all allow almost alone along already also although always among amount ancient and animal another answer any appear apply appoint arise arm army around arrive art article as ask association at attack attempt average away back bad ball bank bar base battle be bear beauty because become bed before begin behind being believe belong below beneath beside best better between beyond big bill bird bit black blood blow blue board boat body book born both box boy branch bread breadth break bridge bright bring brother build burn business but buy by call can capital car care carry case catch cause centre certain chance change character charge chief child choose church circle city claim class clean clear clock close club coast cold college colour come command common company compare complete concern condition connect consider contain content continue control corner cost could council count country course court cover creature cross crowd cry current custom cut dance danger dare dark date daughter day dead deal decide declare deep degree deliver demand describe desert desire destroy detail determine develop 2 die difference difficult direct discover disease distance distinguish district divide do doctor dog door double doubt down draw dream dress drive drop dry due during each ear early earth east easy eat edge effect effort either else employ end enemy English enjoy enough enter entire equal escape even evening event ever every everywhere evil example excellent except exchange exercise exist expect expense experience experiment explain express extend eye face fact factory fail fair faith fall familiar family famous farm fashion fast father favourite favour fear feed feel fellow few field figure fill find fine finger finish fire first fish fit fix floor flower follow food for force foreign forget form former forth fortune forward free friend from front full further future gain game garden gate gather general gentle get give glad glass go God gold good great green ground group grow guard habit half hall hand handle hang happen happy hard hardly have he head health hear heat heaven heavy help her here hide high hill his history hold home honour hope horse hot hour house how hullo human hurrah husband I idea if impossible in inch include increase indeed independent influence instead intend interest into introduce iron it its 3 join judg e just keep kill kind know lack lady land language large last late law lay lead learn least leave left length less let letter level library lie life lift light like likely limit line listen little live local long look lose lost lot love low machine main make man manner manners many march mark market marry mass material matter may me mean measure meet member memory mention mere metal middle might mile mind mine minister minute miss modern moment money month more moreover morning most mother motor mountain mouth move much music must my name narrow nation native nature near necessary neck need neighbour neither never new next night no none nor north not note nothing notice now nowhere number object observe occasion of off offer office often oil old once one onl y open operation opinion opportunity or order ordinary organize other otherwise ought ounce our out of out over owe own page pain paint paper part party pass past pay peace people perfect perhaps permanent permit person picture piece place plan plant play please point political poor popular population position possess possible post pound poverty power practical prepare present preserve press pretty prevent price print private problem produce product 4 production program programme progress promise proof proper propose protect prove provide public pull purpose put quality quarter quiet quite race raise rank rate rather reach read ready real reason receive recent recognize record red reduce refuse regard regular relation religion remain remark remember repeat reply report represent respect rest result return rich ride right ring rise river road roll room rough round rule ruler run rush safe sail same save saw say scale scarce scene school science sea season seat second secret secretary see seem seize sell send sense separate serious serve set settle several shadow shake shall shape share shave she shine shoe shoot shore short should shoulder show side sight sign silence silver simple since single sir sister sit situation size skill sky sleep slight slow small smile so society soft soil some son soon sort sound south space speak special speed spend spirit spite spot spread spring square stage stand standard start state station stay steal steel step stick still stock stone stop store storm story straight strange strea m street strength stretch strike strong struggle study subject substance succeed such sudden suffer suggest summer sun supply support suppose sure surface surprise surround sweet system table take talk 5 taste teach tear tell term terrible test than that the their them then there therefore these they thing think this though thought through throw thus time to today together too top total touch toward/ s town trade train travel tree trouble trust truth try turn type under understand union unite university unles s until up upon use usual valley value various very view village visit voice vote wait walk wall want war warn waste watch water wave way we weak wear week welcome well west what when where whether which while white who whose why wide wife wild will win wind window wing winter wise wish with within without woman wonder wood word work world worse worth would write wrong year yellow yes yesterday yet you young`.toLowerCase().split(/\s+/).filter(w => w.length > 1);

async function findExtra() {
  console.log(`📚 GSL has ${gslWords.length} words\n`);
  
  // Fetch all entries
  let allEntries: any[] = [];
  let page = 0;
  const pageSize = 1000;
  
  while (true) {
    const { data } = await supabase
      .from('lexicon_entries')
      .select('headword, cefr_receptive, ipa, definition_simple')
      .range(page * pageSize, (page + 1) * pageSize - 1)
      .order('headword');
    
    if (!data || data.length === 0) break;
    allEntries = allEntries.concat(data);
    if (data.length < pageSize) break;
    page++;
  }
  
  console.log(`📊 Database has ${allEntries.length} entries\n`);
  
  // Find entries not in GSL
  const gslSet = new Set(gslWords);
  const extraEntries = allEntries.filter(e => !gslSet.has(e.headword.toLowerCase()));
  
  if (extraEntries.length > 0) {
    console.log(`⚠️  Found ${extraEntries.length} entries NOT in original GSL:\n`);
    extraEntries.forEach((e, i) => {
      const enhanced = e.ipa && e.definition_simple ? '✅' : '❌';
      console.log(`${i + 1}. ${e.headword} ${enhanced} (${e.cefr_receptive})`);
    });
    
    fs.writeFileSync('extra_entries.json', JSON.stringify(extraEntries, null, 2));
    console.log(`\n📝 Saved to extra_entries.json`);
  } else {
    console.log('✅ All entries are from the original GSL');
  }
  
  // Find GSL words not in database
  const dbHeadwords = new Set(allEntries.map(e => e.headword.toLowerCase()));
  const missingWords = gslWords.filter(w => !dbHeadwords.has(w));
  
  if (missingWords.length > 0) {
    console.log(`\n⚠️  Found ${missingWords.length} GSL words NOT in database:\n`);
    missingWords.slice(0, 20).forEach((w, i) => {
      console.log(`${i + 1}. ${w}`);
    });
    
    fs.writeFileSync('missing_from_db.json', JSON.stringify(missingWords, null, 2));
    console.log(`\n📝 Saved all ${missingWords.length} to missing_from_db.json`);
  } else {
    console.log('\n✅ All GSL words are in the database');
  }
}

findExtra().catch(console.error);
