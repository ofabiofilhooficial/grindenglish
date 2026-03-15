import { createClient } from "@supabase/supabase-js";
import * as dotenv from "dotenv";
import * as fs from "fs";

dotenv.config();

const supabaseUrl = process.env.VITE_SUPABASE_URL;
const supabaseKey = process.env.VITE_SUPABASE_PUBLISHABLE_KEY;

if (!supabaseUrl || !supabaseKey) {
  console.error("Missing Supabase credentials");
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

async function runB1Migration() {
  console.log("=== Running B1 Migration ===\n");

  try {
    // Read the B1 migration file
    const migrationPath = "supabase/migrations/20260312000001_add_b1_grammar_chapters.sql";
    const migrationSQL = fs.readFileSync(migrationPath, "utf-8");

    console.log("1. Executing B1 migration SQL...");

    // Execute the migration
    const { error } = await supabase.rpc("exec", {
      sql: migrationSQL,
    });

    if (error) {
      console.error("   ✗ Migration failed:", error);
      return;
    }

    console.log("   ✓ Migration executed successfully");

    // Verify the migration
    console.log("\n2. Verifying B1 chapters inserted...");
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
      console.log("   ✓ Correct count: 32 B1 chapters");
    } else {
      console.error(`   ✗ Expected 32 B1 chapters, got ${b1Count}`);
    }

    console.log("\n=== Migration Complete ===");
  } catch (error) {
    console.error("Migration failed:", error);
  }
}

runB1Migration();
