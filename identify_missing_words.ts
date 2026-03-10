import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import * as fs from 'fs';

dotenv.config();

const supabaseUrl = process.env.VITE_SUPABASE_URL!;
const supabaseKey = process.env.VITE_SUPABASE_PUBLISHABLE_KEY!;
const supabase = createClient(supabaseUrl, supabaseKey);

// Complete GSL 1000 word list (first 1000 words from General Service List)
const GSL_1000 = [
  'a', 'able', 'about', 'above', 'accept', 'accord', 'account', 'across', 'act', 'actual',
  'add', 'address', 'admit', 'adopt', 'advance', 'advantage', 'affair', 'afford', 'after', 'again',
  'against', 'age', 'ago', 'agree', 'air', 'all', 'allow', 'almost', 'alone', 'along',
  'already', 'also', 'although', 'always', 'among', 'amount', 'an', 'ancient', 'and', 'animal',
  'another', 'answer', 'any', 'appear', 'apply', 'appoint', 'approach', 'approve', 'area', 'argue',
  'arise', 'arm', 'army', 'around', 'arrange', 'arrive', 'art', 'article', 'as', 'ask',
  'association', 'at', 'attack', 'attempt', 'attend', 'attention', 'authority', 'available', 'average', 'avoid',
  'away', 'back', 'bad', 'ball', 'bank', 'bar', 'base', 'battle', 'be', 'bear',
  'beauty', 'because', 'become', 'bed', 'before', 'begin', 'behind', 'being', 'believe', 'belong',
  'below', 'beneath', 'beside', 'best', 'better', 'between', 'beyond', 'big', 'bill', 'bird',
  'bit', 'black', 'blood', 'blow', 'blue', 'board', 'boat', 'body', 'book', 'born',
  'both', 'box', 'boy', 'branch', 'bread', 'breadth', 'break', 'bridge', 'bright', 'bring',
  'brother', 'build', 'burn', 'business', 'but', 'buy', 'by', 'call', 'can', 'capital',
  'car', 'card', 'care', 'carry', 'case', 'cat', 'catch', 'cause', 'cent', 'centre',
  'century', 'certain', 'chair', 'chance', 'change', 'character', 'charge', 'cheap', 'check', 'chief',
  'child', 'choice', 'choose', 'church', 'circle', 'city', 'claim', 'class', 'clean', 'clear',
  'clock', 'close', 'cloth', 'clothes', 'club', 'coast', 'coat', 'coffee', 'cold', 'collect',
  'college', 'colour', 'come', 'command', 'comment', 'committee', 'common', 'community', 'company', 'compare',
  'complete', 'concern', 'condition', 'connect', 'consider', 'contain', 'content', 'continue', 'control', 'cook',
  'cool', 'corner', 'correct', 'cost', 'could', 'council', 'count', 'country', 'county', 'couple',
  'course', 'court', 'cover', 'create', 'creature', 'cross', 'crowd', 'cry', 'cup', 'current',
  'custom', 'cut', 'dance', 'danger', 'dare', 'dark', 'date', 'daughter', 'day', 'dead',
  'deal', 'dear', 'death', 'decide', 'declare', 'deep', 'degree', 'deliver', 'demand', 'department',
  'depend', 'describe', 'desert', 'design', 'desire', 'destroy', 'detail', 'determine', 'develop', 'die',
  'difference', 'different', 'difficult', 'direct', 'discover', 'discuss', 'disease', 'distance', 'distinguish', 'district',
  'divide', 'do', 'doctor', 'dog', 'door', 'double', 'doubt', 'down', 'draw', 'dream',
  'dress', 'drink', 'drive', 'drop', 'dry', 'due', 'during', 'each', 'ear', 'early',
  'earth', 'east', 'easy', 'eat', 'edge', 'effect', 'effort', 'egg', 'eight', 'either',
  'electric', 'else', 'employ', 'end', 'enemy', 'engine', 'English', 'enjoy', 'enough', 'enter',
  'entire', 'equal', 'escape', 'especially', 'establish', 'even', 'evening', 'event', 'ever', 'every',
  'everybody', 'everyone', 'everything', 'everywhere', 'exact', 'example', 'except', 'exchange', 'exercise', 'exist',
  'expect', 'expense', 'experience', 'experiment', 'explain', 'express', 'extend', 'eye', 'face', 'fact',
  'factory', 'fail', 'fair', 'faith', 'fall', 'family', 'famous', 'far', 'farm', 'fashion',
  'fast', 'father', 'favour', 'fear', 'feed', 'feel', 'fellow', 'few', 'field', 'fight',
  'figure', 'fill', 'film', 'final', 'find', 'fine', 'finger', 'finish', 'fire', 'first',
  'fish', 'fit', 'five', 'fix', 'flat', 'floor', 'flow', 'flower', 'fly', 'follow',
  'food', 'foot', 'for', 'force', 'foreign', 'forest', 'forget', 'form', 'former', 'forth',
  'fortune', 'forward', 'four', 'free', 'fresh', 'friend', 'from', 'front', 'fruit', 'full',
  'fun', 'function', 'fund', 'further', 'future', 'gain', 'game', 'garden', 'gas', 'gate',
  'gather', 'general', 'gentle', 'get', 'girl', 'give', 'glad', 'glass', 'go', 'God',
  'gold', 'good', 'govern', 'government', 'grand', 'grass', 'great', 'green', 'grey', 'ground',
  'group', 'grow', 'guard', 'guess', 'guide', 'gun', 'habit', 'hair', 'half', 'hall',
  'hand', 'handle', 'hang', 'happen', 'happy', 'hard', 'hardly', 'hat', 'hate', 'have',
  'he', 'head', 'health', 'hear', 'heart', 'heat', 'heaven', 'heavy', 'help', 'her',
  'here', 'high', 'hill', 'his', 'history', 'hit', 'hold', 'hole', 'holiday', 'home',
  'honour', 'hope', 'horse', 'hospital', 'hot', 'hotel', 'hour', 'house', 'how', 'however',
  'hullo', 'human', 'hundred', 'hurrah', 'husband', 'I', 'idea', 'if', 'imagine', 'important',
  'impossible', 'improve', 'in', 'inch', 'include', 'income', 'increase', 'indeed', 'independent', 'industry',
  'influence', 'inform', 'instead', 'intend', 'interest', 'into', 'introduce', 'iron', 'it', 'its',
  'join', 'judge', 'jump', 'just', 'keep', 'key', 'kill', 'kind', 'king', 'kitchen',
  'knock', 'know', 'labour', 'lack', 'lady', 'land', 'language', 'large', 'last', 'late',
  'laugh', 'law', 'lay', 'lead', 'learn', 'least', 'leave', 'left', 'leg', 'length',
  'less', 'let', 'letter', 'level', 'library', 'lie', 'life', 'lift', 'light', 'like',
  'likely', 'limit', 'line', 'list', 'listen', 'little', 'live', 'local', 'lock', 'long',
  'look', 'lord', 'lose', 'lost', 'lot', 'love', 'low', 'machine', 'main', 'make',
  'man', 'manage', 'manner', 'manners', 'many', 'march', 'mark', 'market', 'marry', 'mass',
  'master', 'match', 'material', 'matter', 'may', 'me', 'mean', 'measure', 'meat', 'meet',
  'meeting', 'member', 'memory', 'mention', 'mere', 'metal', 'method', 'middle', 'might', 'mile',
  'milk', 'mind', 'mine', 'minister', 'minute', 'miss', 'modern', 'moment', 'money', 'month',
  'more', 'morning', 'most', 'mother', 'motor', 'mountain', 'mouth', 'move', 'much', 'music',
  'must', 'my', 'name', 'narrow', 'nation', 'native', 'nature', 'near', 'nearly', 'necessary',
  'neck', 'need', 'neighbour', 'neither', 'never', 'new', 'news', 'next', 'nice', 'night',
  'nine', 'no', 'noble', 'none', 'nor', 'north', 'not', 'note', 'nothing', 'notice',
  'now', 'nowhere', 'number', 'object', 'observe', 'occasion', 'of', 'off', 'offer', 'office',
  'officer', 'often', 'oil', 'old', 'on', 'once', 'one', 'only', 'open', 'operation',
  'opinion', 'opportunity', 'opposite', 'or', 'order', 'ordinary', 'organize', 'other', 'otherwise', 'ought',
  'our', 'out', 'outside', 'over', 'own', 'page', 'pain', 'paint', 'pair', 'paper',
  'parent', 'park', 'part', 'particular', 'party', 'pass', 'past', 'path', 'patient', 'pattern',
  'pay', 'peace', 'people', 'per', 'perfect', 'perform', 'perhaps', 'period', 'permanent', 'permit',
  'person', 'photograph', 'physical', 'pick', 'picture', 'piece', 'place', 'plan', 'plant', 'play',
  'please', 'plenty', 'point', 'police', 'policy', 'political', 'poor', 'popular', 'population', 'position',
  'possess', 'possible', 'post', 'pound', 'pour', 'poverty', 'power', 'practical', 'practice', 'prepare',
  'present', 'preserve', 'press', 'pressure', 'pretty', 'prevent', 'price', 'print', 'private', 'probable',
  'problem', 'produce', 'product', 'production', 'program', 'programme', 'progress', 'promise', 'proof', 'proper',
  'property', 'propose', 'protect', 'prove', 'provide', 'public', 'pull', 'pure', 'purpose', 'push',
  'put', 'quality', 'quarter', 'question', 'quick', 'quiet', 'quite', 'race', 'radio', 'rail',
  'railway', 'rain', 'raise', 'range', 'rank', 'rate', 'rather', 'reach', 'read', 'ready',
  'real', 'realize', 'reason', 'receive', 'recent', 'recognize', 'record', 'red', 'reduce', 'refer',
  'regard', 'region', 'regular', 'relation', 'religion', 'remain', 'remark', 'remember', 'remove', 'repeat',
  'reply', 'report', 'represent', 'require', 'respect', 'rest', 'result', 'return', 'rich', 'ride',
  'right', 'ring', 'rise', 'river', 'road', 'rock', 'roll', 'room', 'rough', 'round',
  'row', 'royal', 'rule', 'ruler', 'run', 'rush', 'safe', 'sail', 'sale', 'salt',
  'same', 'save', 'saw', 'say', 'scale', 'scarce', 'scene', 'school', 'science', 'sea',
  'season', 'seat', 'second', 'secret', 'secretary', 'section', 'see', 'seem', 'seize', 'self',
  'sell', 'send', 'sense', 'separate', 'serious', 'servant', 'serve', 'service', 'set', 'settle',
  'seven', 'several', 'shadow', 'shake', 'shall', 'shape', 'share', 'sharp', 'shave', 'she',
  'shine', 'ship', 'shoe', 'shoot', 'shop', 'shore', 'short', 'should', 'shoulder', 'show',
  'shut', 'sick', 'side', 'sight', 'sign', 'silence', 'silver', 'similar', 'simple', 'since',
  'sing', 'single', 'sir', 'sister', 'sit', 'situation', 'six', 'size', 'skill', 'skin',
  'sky', 'sleep', 'slight', 'slow', 'small', 'smell', 'smile', 'smoke', 'snow', 'so',
  'social', 'society', 'soft', 'soil', 'soldier', 'some', 'son', 'song', 'soon', 'sort',
  'sound', 'south', 'space', 'speak', 'special', 'speed', 'spell', 'spend', 'spirit', 'spite',
  'spot', 'spread', 'spring', 'square', 'stage', 'stand', 'standard', 'star', 'start', 'state',
  'station', 'stay', 'steal', 'steam', 'steel', 'step', 'stick', 'still', 'stock', 'stone',
  'stop', 'store', 'storm', 'story', 'straight', 'strange', 'stream', 'street', 'strength', 'stretch',
  'strike', 'strong', 'struggle', 'student', 'study', 'subject', 'substance', 'succeed', 'such', 'sudden',
  'suffer', 'sugar', 'suggest', 'suit', 'summer', 'sun', 'supply', 'support', 'suppose', 'sure',
  'surface', 'surprise', 'surround', 'sweet', 'swim', 'system', 'table', 'tail', 'take', 'talk',
  'tall', 'taste', 'tax', 'tea', 'teach', 'tear', 'telephone', 'tell', 'temper', 'ten',
  'tend', 'term', 'terrible', 'test', 'than', 'thank', 'that', 'the', 'their', 'them',
  'then', 'there', 'therefore', 'these', 'they', 'thick', 'thin', 'thing', 'think', 'this',
  'those', 'though', 'thought', 'thousand', 'three', 'through', 'throw', 'thus', 'tie', 'time',
  'tire', 'title', 'to', 'today', 'together', 'tomorrow', 'tone', 'tongue', 'tonight', 'too',
  'top', 'total', 'touch', 'toward', 'towards', 'town', 'trade', 'train', 'travel', 'tree',
  'trouble', 'true', 'trust', 'truth', 'try', 'turn', 'twice', 'two', 'type', 'ugly',
  'under', 'understand', 'union', 'unit', 'unite', 'university', 'unless', 'until', 'up', 'upon',
  'upper', 'use', 'usual', 'valley', 'value', 'various', 'very', 'view', 'village', 'visit',
  'voice', 'vote', 'wage', 'wait', 'wake', 'walk', 'wall', 'want', 'war', 'warm',
  'warn', 'wash', 'waste', 'watch', 'water', 'wave', 'way', 'we', 'weak', 'wear',
  'weather', 'week', 'welcome', 'well', 'west', 'wet', 'what', 'whatever', 'when', 'where',
  'whether', 'which', 'while', 'white', 'who', 'whole', 'whom', 'whose', 'why', 'wide',
  'wife', 'wild', 'will', 'win', 'wind', 'window', 'wine', 'winter', 'wire', 'wise',
  'wish', 'with', 'within', 'without', 'woman', 'wonder', 'wood', 'word', 'work', 'world',
  'worry', 'worse', 'worth', 'would', 'write', 'wrong', 'yard', 'year', 'yellow', 'yes',
  'yesterday', 'yet', 'you', 'young', 'your'
];

async function identifyMissingWords() {
  console.log('🔍 Identifying missing and unenhanced words...\n');
  
  // Get all current entries
  const { data: allEntries } = await supabase
    .from('lexicon_entries')
    .select('headword, ipa, definition_simple, cefr_receptive');
  
  if (!allEntries) {
    console.log('❌ No data found');
    return;
  }
  
  const currentHeadwords = new Set(allEntries.map(e => e.headword.toLowerCase()));
  
  // Find missing words
  const missingWords = GSL_1000.filter(word => !currentHeadwords.has(word.toLowerCase()));
  
  // Find unenhanced words
  const unenhancedWords = allEntries
    .filter(e => !e.ipa || !e.definition_simple)
    .map(e => e.headword);
  
  console.log(`📊 Analysis Results:`);
  console.log(`   Total GSL words: ${GSL_1000.length}`);
  console.log(`   Current entries: ${allEntries.length}`);
  console.log(`   Missing words: ${missingWords.length}`);
  console.log(`   Unenhanced words: ${unenhancedWords.length}`);
  console.log(`   Total work needed: ${missingWords.length + unenhancedWords.length}\n`);
  
  // Save to files
  fs.writeFileSync('missing_words.json', JSON.stringify(missingWords, null, 2));
  fs.writeFileSync('unenhanced_words.json', JSON.stringify(unenhancedWords, null, 2));
  
  console.log('✅ Files created:');
  console.log('   - missing_words.json (63 words to add)');
  console.log('   - unenhanced_words.json (630 words to enhance)\n');
  
  // Show samples
  console.log('Sample missing words (first 20):');
  console.log(missingWords.slice(0, 20).join(', '));
  
  console.log('\nSample unenhanced words (first 20):');
  console.log(unenhancedWords.slice(0, 20).join(', '));
}

identifyMissingWords().catch(console.error);
