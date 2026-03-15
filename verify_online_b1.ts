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

async function verifyOnlineB1() {
  console.log("=== Verifying B1 Migration (Online Database) ===\n");
  console.log(`Supabase URL: ${supabaseUrl}\n`);

  try {
    // 1. Check B1 chapter count
    console.log("1. Checking B1 chapter count...");
    const { count: b1Count, error: countError } = await supabase
      .from("grammar_chapters")
      .select("*", { count: "exact", head: true })
      .eq("cefr_level", "B1");

    if (countError) {
      console.error("   ✗ Error fetching B1 count:", countError);
      return;
    }

    console.log(`   ✓ B1 chapters found: ${b1Count}`);
    if (b1Count === 32) {
      console.log("   ✓ CORRECT: 32 B1 chapters inserted");
    } else if (b1Count > 0) {
      console.error(`   ⚠ WARNING: Expected 32 B1 chapters, got ${b1Count}`);
    } else {
      console.error(`   ✗ ERROR: No B1 chapters found`);
    }

    // 2. Check B1 chapter codes
    console.log("\n2. Checking B1 chapter codes...");
    const { data: b1Chapters, error: codesError } = await supabase
      .from("grammar_chapters")
      .select("chapter_code, sort_order, title")
      .eq("cefr_level", "B1")
      .order("sort_order");

    if (codesError) {
      console.error("   ✗ Error fetching B1 chapters:", codesError);
      return;
    }

    if (b1Chapters && b1Chapters.length > 0) {
      console.log(`   ✓ Found ${b1Chapters.length} B1 chapters`);
      console.log("   First 5 chapters:");
      b1Chapters.slice(0, 5).forEach((ch) => {
        console.log(`     - ${ch.chapter_code}: ${ch.title}`);
      });
      if (b1Chapters.length > 5) {
        console.log(`   ... and ${b1Chapters.length - 5} more`);
      }
    }

    // 3. Check all CEFR levels
    console.log("\n3. Checking all CEFR levels...");
    const levels = ["A0", "A1", "A2", "B1"];
    let totalCount = 0;

    for (const level of levels) {
      const { count: levelCount } = await supabase
        .from("grammar_chapters")
        .select("*", { count: "exact", head: true })
        .eq("cefr_level", level);

      console.log(`   ${level}: ${levelCount} chapters`);
      totalCount += levelCount || 0;
    }

    console.log(`   Total: ${totalCount} chapters (expected: 96)`);

    if (totalCount === 96) {
      console.log("   ✓ CORRECT: All 96 chapters present");
    } else if (totalCount > 0) {
      console.log(`   ⚠ WARNING: Expected 96 chapters, got ${totalCount}`);
    }

    // 4. Check JSONB fields
    console.log("\n4. Checking JSONB fields...");
    const { data: sampleB1 } = await supabase
      .from("grammar_chapters")
      .select("chapter_code, micro_practice, cross_links")
      .eq("cefr_level", "B1")
      .limit(1)
      .single();

    if (sampleB1) {
      console.log(`   ✓ Sample B1 chapter: ${sampleB1.chapter_code}`);
      console.log(`     - micro_practice: ${Array.isArray(sampleB1.micro_practice) ? `✓ Valid array (${sampleB1.micro_practice.length} items)` : "✗ Invalid"}`);
      console.log(`     - cross_links: ${Array.isArray(sampleB1.cross_links) ? `✓ Valid array (${sampleB1.cross_links.length} items)` : "✗ Invalid"}`);
    }

    // 5. Check is_published flag
    console.log("\n5. Checking is_published flag...");
    const { data: unpublished } = await supabase
      .from("grammar_chapters")
      .select("chapter_code")
      .eq("cefr_level", "B1")
      .eq("is_published", false);

    if (unpublished && unpublished.length === 0) {
      console.log("   ✓ All B1 chapters are published");
    } else {
      console.log(`   ⚠ Found ${unpublished?.length || 0} unpublished B1 chapters`);
    }

    console.log("\n=== Verification Complete ===");
  } catch (error) {
    console.error("Verification failed:", error);
  }
}

verifyOnlineB1();
