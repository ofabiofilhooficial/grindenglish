import { createClient } from "@supabase/supabase-js";
import * as dotenv from "dotenv";

dotenv.config();

const supabaseUrl = process.env.VITE_SUPABASE_URL || "";
const supabaseKey = process.env.VITE_SUPABASE_PUBLISHABLE_KEY || "";

if (!supabaseUrl || !supabaseKey) {
  console.error("Missing Supabase credentials in .env");
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

async function verifyA2Migration() {
  console.log("🔍 Verifying A2 Migration...\n");

  try {
    // 1. Check total A2 chapters
    console.log("1️⃣  Checking total A2 chapters...");
    const { data: allA2, error: countError } = await supabase
      .from("grammar_chapters")
      .select("chapter_code, cefr_level", { count: "exact" })
      .eq("cefr_level", "A2");

    if (countError) {
      console.error("❌ Error fetching A2 chapters:", countError);
      return;
    }

    const a2Count = allA2?.length || 0;
    console.log(`   Found ${a2Count} A2 chapters`);

    if (a2Count !== 28) {
      console.error(`   ❌ FAILED: Expected 28 A2 chapters, got ${a2Count}`);
    } else {
      console.log(`   ✅ PASSED: Exactly 28 A2 chapters found`);
    }

    // 2. Verify chapter codes A2.G.01 through A2.G.28
    console.log("\n2️⃣  Verifying chapter codes (A2.G.01 - A2.G.28)...");
    const expectedCodes = Array.from({ length: 28 }, (_, i) =>
      `A2.G.${String(i + 1).padStart(2, "0")}`
    );
    const actualCodes = (allA2 || [])
      .map((ch) => ch.chapter_code)
      .sort();

    const missingCodes = expectedCodes.filter((code) => !actualCodes.includes(code));
    const extraCodes = actualCodes.filter((code) => !expectedCodes.includes(code));

    if (missingCodes.length > 0) {
      console.error(`   ❌ Missing codes: ${missingCodes.join(", ")}`);
    } else {
      console.log(`   ✅ PASSED: All chapter codes A2.G.01 - A2.G.28 present`);
    }

    if (extraCodes.length > 0) {
      console.error(`   ⚠️  Extra codes found: ${extraCodes.join(", ")}`);
    }

    // 3. Check required fields
    console.log("\n3️⃣  Checking required fields...");
    const { data: a2Chapters, error: fieldsError } = await supabase
      .from("grammar_chapters")
      .select(
        "chapter_code, title, cefr_level, form_content, meaning_content, use_content, is_published, sort_order"
      )
      .eq("cefr_level", "A2")
      .order("sort_order");

    if (fieldsError) {
      console.error("❌ Error fetching A2 chapters with fields:", fieldsError);
      return;
    }

    let requiredFieldsOk = true;
    const missingFields: string[] = [];

    (a2Chapters || []).forEach((ch) => {
      if (!ch.title) missingFields.push(`${ch.chapter_code}: missing title`);
      if (!ch.form_content) missingFields.push(`${ch.chapter_code}: missing form_content`);
      if (!ch.meaning_content) missingFields.push(`${ch.chapter_code}: missing meaning_content`);
      if (!ch.use_content) missingFields.push(`${ch.chapter_code}: missing use_content`);
      if (ch.is_published !== true) missingFields.push(`${ch.chapter_code}: is_published not true`);
    });

    if (missingFields.length > 0) {
      console.error(`   ❌ FAILED: Missing required fields:`);
      missingFields.forEach((msg) => console.error(`      - ${msg}`));
      requiredFieldsOk = false;
    } else {
      console.log(`   ✅ PASSED: All required fields populated`);
    }

    // 4. Check sort_order sequence
    console.log("\n4️⃣  Checking sort_order sequence (1-28)...");
    let sortOrderOk = true;
    (a2Chapters || []).forEach((ch, idx) => {
      const expectedSort = idx + 1;
      if (ch.sort_order !== expectedSort) {
        console.error(
          `   ❌ ${ch.chapter_code}: expected sort_order ${expectedSort}, got ${ch.sort_order}`
        );
        sortOrderOk = false;
      }
    });

    if (sortOrderOk) {
      console.log(`   ✅ PASSED: sort_order values 1-28 correctly assigned`);
    }

    // 5. Check JSONB fields (micro_practice and cross_links)
    console.log("\n5️⃣  Checking JSONB fields...");
    const { data: jsonbChapters, error: jsonbError } = await supabase
      .from("grammar_chapters")
      .select("chapter_code, micro_practice, cross_links")
      .eq("cefr_level", "A2");

    if (jsonbError) {
      console.error("❌ Error fetching JSONB fields:", jsonbError);
      return;
    }

    let jsonbOk = true;
    const jsonbIssues: string[] = [];

    (jsonbChapters || []).forEach((ch) => {
      // Check micro_practice
      if (ch.micro_practice) {
        try {
          const parsed = typeof ch.micro_practice === "string" 
            ? JSON.parse(ch.micro_practice) 
            : ch.micro_practice;
          if (!Array.isArray(parsed)) {
            jsonbIssues.push(`${ch.chapter_code}: micro_practice is not an array`);
            jsonbOk = false;
          }
        } catch (e) {
          jsonbIssues.push(`${ch.chapter_code}: micro_practice JSON parse error`);
          jsonbOk = false;
        }
      }

      // Check cross_links
      if (ch.cross_links) {
        try {
          const parsed = typeof ch.cross_links === "string" 
            ? JSON.parse(ch.cross_links) 
            : ch.cross_links;
          if (!Array.isArray(parsed)) {
            jsonbIssues.push(`${ch.chapter_code}: cross_links is not an array`);
            jsonbOk = false;
          }
        } catch (e) {
          jsonbIssues.push(`${ch.chapter_code}: cross_links JSON parse error`);
          jsonbOk = false;
        }
      }
    });

    if (jsonbIssues.length > 0) {
      console.error(`   ❌ FAILED: JSONB parsing issues:`);
      jsonbIssues.forEach((msg) => console.error(`      - ${msg}`));
    } else {
      console.log(`   ✅ PASSED: All JSONB fields parse correctly`);
    }

    // 6. Check is_published status
    console.log("\n6️⃣  Checking is_published status...");
    const unpublished = (a2Chapters || []).filter((ch) => ch.is_published !== true);
    if (unpublished.length > 0) {
      console.error(`   ❌ FAILED: ${unpublished.length} chapters not published`);
      unpublished.forEach((ch) => console.error(`      - ${ch.chapter_code}`));
    } else {
      console.log(`   ✅ PASSED: All 28 A2 chapters have is_published=true`);
    }

    // 7. Summary
    console.log("\n" + "=".repeat(60));
    console.log("📊 VERIFICATION SUMMARY");
    console.log("=".repeat(60));
    console.log(`✅ Total A2 chapters: ${a2Count}/28`);
    console.log(`✅ Chapter codes: ${missingCodes.length === 0 ? "All present" : `${missingCodes.length} missing`}`);
    console.log(`✅ Required fields: ${missingFields.length === 0 ? "All populated" : `${missingFields.length} issues`}`);
    console.log(`✅ Sort order: ${sortOrderOk ? "Correct sequence" : "Issues found"}`);
    console.log(`✅ JSONB fields: ${jsonbOk ? "All valid" : "Issues found"}`);
    console.log(`✅ Published status: ${unpublished.length === 0 ? "All published" : `${unpublished.length} not published`}`);

    const allPassed =
      a2Count === 28 &&
      missingCodes.length === 0 &&
      missingFields.length === 0 &&
      sortOrderOk &&
      jsonbOk &&
      unpublished.length === 0;

    console.log("=".repeat(60));
    if (allPassed) {
      console.log("✅ ALL CHECKS PASSED - A2 MIGRATION VERIFIED");
    } else {
      console.log("❌ SOME CHECKS FAILED - REVIEW ABOVE");
    }
    console.log("=".repeat(60));
  } catch (error) {
    console.error("❌ Unexpected error:", error);
  }
}

verifyA2Migration();
