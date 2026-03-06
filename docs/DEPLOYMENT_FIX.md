# Deployment Fix - TypeScript Configuration Issue

## Problem
Lovable deployment was failing with the error:
```
Cannot find type definition file for 'vitest/globals'.
The file is in the program because:
Entry point of type library 'vitest/globals' specified in compilerOptions
```

## Root Cause
The `tsconfig.app.json` file had `"types": ["vitest/globals"]` in the compilerOptions, which was trying to include vitest test globals in the production build. This is incorrect because:

1. Vitest globals should only be available in test files, not in the app build
2. The vitest config already has `globals: true` which makes test globals available in test files
3. Including test types in the app build causes TypeScript compilation errors

## Solution
Removed the `types` array from `tsconfig.app.json`:

**Before:**
```json
{
  "compilerOptions": {
    ...
    "types": [
      "vitest/globals"
    ],
    ...
  }
}
```

**After:**
```json
{
  "compilerOptions": {
    ...
    // types array removed
    ...
  }
}
```

## Files Modified
- ✅ `tsconfig.app.json` - Removed vitest/globals from types array

## What This Fixes
- ✅ TypeScript compilation errors during build
- ✅ Lovable deployment should now succeed
- ✅ Test files still have access to vitest globals via vitest.config.ts

## Next Steps

1. **Commit and push** the tsconfig.app.json change to GitHub
2. **Try deploying again** via Lovable's Publish button
3. **Verify deployment succeeds** - the button should become greyed out with "Up to date"

## About the SQL Migrations

The SQL migrations you ran in Lovable's SQL Editor are already applied to your database:
- ✅ `20260308000000_fix_progress_and_cohort_issues.sql` - Applied
- ✅ `20260308000001_fix_words_learned_counter.sql` - Applied

You don't need to run them again. The deployment issue was purely a TypeScript configuration problem, not related to the SQL.

## Testing After Deployment

Once deployment succeeds:

1. **Fix your words_learned counter** (if still showing 0):
   - Go to Supabase SQL Editor
   - Run: `SELECT public.recalculate_words_learned(auth.uid());`

2. **Become a teacher**:
   - Visit `/teach` page
   - Click "Become Teacher (Dev)" button
   - Try creating a cohort

3. **Test streak tracking**:
   - Visit dashboard daily
   - Verify streak increments correctly
