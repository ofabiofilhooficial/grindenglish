import fs from 'fs';

// Read the unenhanced A1 words
const unenhancedWords = JSON.parse(fs.readFileSync('unenhanced_a1_words.json', 'utf-8'));

console.log(`Total unenhanced A1 words: ${unenhancedWords.length}`);

// Split into 6 batches
const batchSize = 100;
const batches: any[][] = [];

for (let i = 0; i < unenhancedWords.length; i += batchSize) {
  batches.push(unenhancedWords.slice(i, i + batchSize));
}

console.log(`\nCreating ${batches.length} migration batches:`);
batches.forEach((batch, i) => {
  console.log(`  Batch ${i + 1}: ${batch.length} words`);
});

// For now, just output the word lists for each batch
batches.forEach((batch, batchIndex) => {
  const batchNum = batchIndex + 1;
  const filename = `a1_batch_${batchNum}_words.txt`;
  
  const wordList = batch.map(w => `${w.headword} (${w.pos})`).join('\n');
  fs.writeFileSync(filename, wordList);
  
  console.log(`\n📝 Saved batch ${batchNum} to ${filename}`);
});

console.log('\n✅ Word lists created. Ready to generate migrations.');
