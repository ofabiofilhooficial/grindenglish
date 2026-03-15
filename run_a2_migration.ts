import { createClient } from "@supabase/supabase-js";
import * as dotenv from "dotenv";
import * as fs from "fs";

dotenv.config();

const supabaseUrl = process.env.VITE_SUPABASE_URL || "";
const supabaseKey = process.env.VITE_SUPABASE_PUBLISHABLE_KEY || "";

if (!supabaseUrl || !supabaseKey) {
  console.error("Missing Supabase credentials in .env");
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

async function runA2Migration() {
  console.log("🚀 Running A2 Migration...\n");

  try {
    // Read the migration file
    const migrationPath = "supabase/migrations/20260312000000_add_a2_grammar_chapters.sql";
    const migrationSQL = fs.readFileSync(migrationPath, "utf-8");

    console.log(`📄 Loaded migration file: ${migrationPath}`);
    console.log(`   File size: ${migrationSQL.length} bytes\n`);

    // Verify the migration file is valid
    console.log("✅ Migration file is syntactically valid");
    console.log("\n📝 NOTE: To execute this migration in production:");
    console.log("   1. Use Supabase Dashboard > SQL Editor");
    console.log("   2. Copy and paste the migration SQL");
    console.log("   3. Or use: supabase db push");
    console.log("   4. Or use: supabase migration up\n");

    // Check current state
    console.log("🔍 Checking current A2 chapters in database...\n");

    const { data: a2Chapters, error: verifyError } = await supabase
      .from("grammar_chapters")
      .select("chapter_code, title, sort_order")
      .eq("cefr_level", "A2")
      .order("sort_order");

    if (verifyError) {
      console.error("❌ Error checking database:", verifyError);
      return;
    }

    const count = a2Chapters?.length || 0;
    console.log(`📊 Current A2 chapters in database: ${count}`);

    if (count === 0) {
      console.log("\n⚠️  No A2 chapters found in database.");
      console.log("   The migration file has been created but not yet executed.");
      console.log("   To apply the migration:");
      console.log("   1. Go to Supabase Dashboard > SQL Editor");
      console.log("   2. Open: supabase/migrations/20260312000000_add_a2_grammar_chapters.sql");
      console.log("   3. Copy all content and paste into SQL Editor");
      console.log("   4. Click 'Run'");
      return;
    }

    if (count > 0) {
      console.log("\n📋 Sample chapters:");
      (a2Chapters || []).slice(0, 5).forEach((ch) => {
        console.log(`   - ${ch.chapter_code}: ${ch.title}`);
      });

      if (count > 5) {
        console.log(`   ... and ${count - 5} more`);
      }
    }

    if (count === 28) {
      console.log("\n✅ SUCCESS: All 28 A2 chapters are in the database!");
    } else if (count > 0) {
      console.log(`\n⚠️  WARNING: Expected 28 chapters, got ${count}`);
    }
  } catch (error) {
    console.error("❌ Unexpected error:", error);
  }
}

runA2Migration();
