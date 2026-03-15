import { createClient } from "@supabase/supabase-js";
import * as dotenv from "dotenv";

dotenv.config();

const supabaseUrl = process.env.VITE_SUPABASE_URL;
const supabaseKey = process.env.VITE_SUPABASE_PUBLISHABLE_KEY;

if (!supabaseUrl || !supabaseKey) {
  console.error("Missing Supabase credentials");
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

async function verifyB1Migration() {
  console.log("=== B1 Migration Verification ===\n");

  try {
    // 1. Check B1 chapter count
    console.log("1. Checking B1 chapter count...");
    const { count: b1Count, error: countError } = await supabase
      .from("grammar_chapters")
      .select("*", { count: "exact", head: true })
      .eq("cefr_level", "B1");

    if (countError) {
      console.error("Error fetching B1 count:", countError);
      return;
    }

    console.log(`   ✓ B1 chapters found: ${b1Count}`);
    if (b1Count !== 32) {
      console.error(`   ✗ Expected 32 B1 chapters, got ${b1Count}`);
    } else {
      console.log("   ✓ Correct count: 32 B1 chapters");
    }

    // 2. Check B1 chapter codes
    console.log("\n2. Checking B1 chapter codes (B1.G.01 through B1.G.32)...");
    const { data: b1Chapters, error: codesError } = await supabase
      .from("grammar_chapters")
      .select("chapter_code, sort_order")
      .eq("cefr_level", "B1")
      .order("sort_order");

    if (codesError) {
      console.error("Error fetching B1 chapters:", codesError);
      return;
    }

    const expectedCodes = Array.from({ length: 32 }, (_, i) =>
      `B1.G.${String(i + 1).padStart(2, "0")}`
    );

    const actualCodes = b1Chapters.map((ch) => ch.chapter_code);
    const codesMatch = JSON.stringify(actualCodes) === JSON.stringify(expectedCodes);

    if (codesMatch) {
      console.log("   ✓ All chapter codes correct (B1.G.01 through B1.G.32)");
    } else {
      console.error("   ✗ Chapter codes mismatch");
      console.error("   Expected:", expectedCodes);
      console.error("   Actual:", actualCodes);
    }

    // 3. Check for SQL syntax errors (by verifying data integrity)
    console.log("\n3. Checking for SQL syntax errors and constraint violations...");
    const { data: allChapters, error: syntaxError } = await supabase
      .from("grammar_chapters")
      .select("*")
      .in("cefr_level", ["A0", "A1", "A2", "B1"]);

    if (syntaxError) {
      console.error("   ✗ SQL error detected:", syntaxError);
      return;
    }

    console.log("   ✓ No SQL syntax errors detected");

    // 4. Check JSONB fields parse correctly
    console.log("\n4. Checking JSONB fields parse correctly...");
    let jsonbErrors = 0;

    for (const chapter of b1Chapters) {
      try {
        // Try to access JSONB fields
        const { data: fullChapter, error } = await supabase
          .from("grammar_chapters")
          .select("micro_practice, cross_links")
          .eq("chapter_code", chapter.chapter_code)
          .single();

        if (error) {
          console.error(`   ✗ Error fetching ${chapter.chapter_code}:`, error);
          jsonbErrors++;
          continue;
        }

        // Verify JSONB is valid
        if (fullChapter.micro_practice && !Array.isArray(fullChapter.micro_practice)) {
          console.error(`   ✗ ${chapter.chapter_code}: micro_practice is not an array`);
          jsonbErrors++;
        }

        if (fullChapter.cross_links && !Array.isArray(fullChapter.cross_links)) {
          console.error(`   ✗ ${chapter.chapter_code}: cross_links is not an array`);
          jsonbErrors++;
        }
      } catch (e) {
        console.error(`   ✗ Error parsing JSONB for ${chapter.chapter_code}:`, e);
        jsonbErrors++;
      }
    }

    if (jsonbErrors === 0) {
      console.log("   ✓ All JSONB fields parse correctly");
    } else {
      console.error(`   ✗ Found ${jsonbErrors} JSONB parsing errors`);
    }

    // 5. Check existing chapters preserved
    console.log("\n5. Checking existing chapters preserved...");
    const { count: a0Count } = await supabase
      .from("grammar_chapters")
      .select("*", { count: "exact", head: true })
      .eq("cefr_level", "A0");

    const { count: a1Count } = await supabase
      .from("grammar_chapters")
      .select("*", { count: "exact", head: true })
      .eq("cefr_level", "A1");

    const { count: a2Count } = await supabase
      .from("grammar_chapters")
      .select("*", { count: "exact", head: true })
      .eq("cefr_level", "A2");

    console.log(`   A0 chapters: ${a0Count} (expected: 12)`);
    console.log(`   A1 chapters: ${a1Count} (expected: 24)`);
    console.log(`   A2 chapters: ${a2Count} (expected: 28)`);
    console.log(`   B1 chapters: ${b1Count} (expected: 32)`);

    const totalExpected = 12 + 24 + 28 + 32;
    const totalActual = (a0Count || 0) + (a1Count || 0) + (a2Count || 0) + (b1Count || 0);

    console.log(`   Total: ${totalActual} (expected: ${totalExpected})`);

    if (totalActual === totalExpected) {
      console.log("   ✓ All chapters preserved correctly");
    } else {
      console.error(`   ✗ Chapter count mismatch: expected ${totalExpected}, got ${totalActual}`);
    }

    // 6. Check is_published flag
    console.log("\n6. Checking is_published flag...");
    const { data: unpublished } = await supabase
      .from("grammar_chapters")
      .select("chapter_code")
      .eq("cefr_level", "B1")
      .eq("is_published", false);

    if (unpublished && unpublished.length === 0) {
      console.log("   ✓ All B1 chapters are published");
    } else {
      console.error(`   ✗ Found ${unpublished?.length || 0} unpublished B1 chapters`);
    }

    // 7. Sample chapter verification
    console.log("\n7. Sample chapter verification (B1.G.01)...");
    const { data: sampleChapter, error: sampleError } = await supabase
      .from("grammar_chapters")
      .select("*")
      .eq("chapter_code", "B1.G.01")
      .single();

    if (sampleError) {
      console.error("   ✗ Error fetching B1.G.01:", sampleError);
    } else if (!sampleChapter) {
      console.error("   ✗ B1.G.01 not found");
    } else {
      console.log("   ✓ B1.G.01 found");
      console.log(`     Title: ${sampleChapter.title}`);
      console.log(`     CEFR Level: ${sampleChapter.cefr_level}`);
      console.log(`     Sort Order: ${sampleChapter.sort_order}`);
      console.log(`     Published: ${sampleChapter.is_published}`);
      console.log(`     Has form_content: ${!!sampleChapter.form_content}`);
      console.log(`     Has meaning_content: ${!!sampleChapter.meaning_content}`);
      console.log(`     Has use_content: ${!!sampleChapter.use_content}`);
      console.log(`     Micro-practice exercises: ${sampleChapter.micro_practice?.length || 0}`);
      console.log(`     Cross-links: ${sampleChapter.cross_links?.length || 0}`);
    }

    console.log("\n=== Verification Complete ===");
  } catch (error) {
    console.error("Verification failed:", error);
  }
}

verifyB1Migration();
