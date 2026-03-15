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

async function checkGrammarChapters() {
  console.log("=== Checking Grammar Chapters Table ===\n");

  try {
    // Check if table exists and has any data
    console.log("1. Checking grammar_chapters table...");
    const { data, error, count } = await supabase
      .from("grammar_chapters")
      .select("*", { count: "exact" })
      .limit(1);

    if (error) {
      console.error("   ✗ Error accessing table:", error);
      return;
    }

    console.log(`   ✓ Table accessible`);
    console.log(`   Total rows: ${count}`);

    // Check each CEFR level
    console.log("\n2. Checking by CEFR level...");
    const levels = ["A0", "A1", "A2", "B1"];

    for (const level of levels) {
      const { count: levelCount, error: levelError } = await supabase
        .from("grammar_chapters")
        .select("*", { count: "exact", head: true })
        .eq("cefr_level", level);

      if (levelError) {
        console.error(`   ✗ Error checking ${level}:`, levelError);
      } else {
        console.log(`   ${level}: ${levelCount} chapters`);
      }
    }

    // Try to fetch a sample chapter
    console.log("\n3. Fetching sample chapters...");
    const { data: samples, error: sampleError } = await supabase
      .from("grammar_chapters")
      .select("chapter_code, title, cefr_level")
      .limit(5);

    if (sampleError) {
      console.error("   ✗ Error fetching samples:", sampleError);
    } else if (!samples || samples.length === 0) {
      console.log("   ℹ No chapters found in database");
    } else {
      console.log("   ✓ Sample chapters:");
      samples.forEach((ch) => {
        console.log(`     - ${ch.chapter_code}: ${ch.title} (${ch.cefr_level})`);
      });
    }

    // Check table schema
    console.log("\n4. Checking table schema...");
    const { data: schema, error: schemaError } = await supabase
      .from("information_schema.columns")
      .select("column_name, data_type")
      .eq("table_name", "grammar_chapters")
      .eq("table_schema", "public");

    if (schemaError) {
      console.log("   ℹ Could not fetch schema (may require admin access)");
    } else if (schema && schema.length > 0) {
      console.log("   ✓ Table columns:");
      schema.forEach((col) => {
        console.log(`     - ${col.column_name}: ${col.data_type}`);
      });
    }
  } catch (error) {
    console.error("Check failed:", error);
  }
}

checkGrammarChapters();
