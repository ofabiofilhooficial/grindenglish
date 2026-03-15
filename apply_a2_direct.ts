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

async function applyA2Direct() {
  console.log("🚀 Applying A2 Migration Directly...\n");

  try {
    // Read the migration file
    const migrationPath = "supabase/migrations/20260312000000_add_a2_grammar_chapters.sql";
    const migrationSQL = fs.readFileSync(migrationPath, "utf-8");

    console.log(`📄 Loaded migration file: ${migrationPath}`);
    console.log(`   File size: ${migrationSQL.length} bytes\n`);

    // Extract just the INSERT statement (skip comments and setup)
    const lines = migrationSQL.split("\n");
    let insertStart = -1;
    let insertEnd = -1;

    for (let i = 0; i < lines.length; i++) {
      if (lines[i].includes("INSERT INTO public.grammar_chapters")) {
        insertStart = i;
      }
      if (insertStart !== -1 && lines[i].trim().endsWith(";")) {
        insertEnd = i;
        break;
      }
    }

    if (insertStart === -1 || insertEnd === -1) {
      console.error("❌ Could not find INSERT statement in migration file");
      return;
    }

    const insertSQL = lines.slice(insertStart, insertEnd + 1).join("\n");
    console.log("⏳ Executing INSERT statement...");
    console.log(`   Statement length: ${insertSQL.length} bytes\n`);

    // Execute using raw SQL via Supabase
    const { error } = await supabase.rpc("exec_sql", {
      sql: insertSQL,
    });

    if (error) {
      // Try alternative approach - check if exec_sql exists
      console.log("⚠️  exec_sql RPC not available, trying alternative...");
      
      // Since we can't execute raw SQL directly through the client,
      // we need to inform the user to do it manually
      console.log("\n📝 MANUAL EXECUTION REQUIRED:");
      console.log("   The migration file is ready but requires manual execution.");
      console.log("   Please follow these steps:\n");
      console.log("   1. Go to: https://app.supabase.com/project/nyovkitllfvbjslunned/sql/new");
      console.log("   2. Open file: supabase/migrations/20260312000000_add_a2_grammar_chapters.sql");
      console.log("   3. Copy all content");
      console.log("   4. Paste into Supabase SQL Editor");
      console.log("   5. Click 'Run'\n");
      return;
    }

    console.log("✅ Migration executed successfully\n");

    // Wait for database to process
    await new Promise((resolve) => setTimeout(resolve, 2000));

    // Verify
    console.log("🔍 Verifying migration results...\n");

    const { data: a2Chapters, error: verifyError } = await supabase
      .from("grammar_chapters")
      .select("chapter_code, title, sort_order")
      .eq("cefr_level", "A2")
      .order("sort_order");

    if (verifyError) {
      console.error("❌ Error verifying migration:", verifyError);
      return;
    }

    const count = a2Chapters?.length || 0;
    console.log(`✅ Found ${count} A2 chapters after migration`);

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
      console.log("\n✅ SUCCESS: All 28 A2 chapters inserted!");
    } else if (count > 0) {
      console.log(`\n⚠️  WARNING: Expected 28 chapters, got ${count}`);
    }
  } catch (error) {
    console.error("❌ Unexpected error:", error);
  }
}

applyA2Direct();
