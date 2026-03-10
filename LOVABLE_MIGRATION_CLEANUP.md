# Lovable to Vercel/Supabase Migration Cleanup

## Status: Ready to Execute

This document outlines all Lovable-specific code and configurations that need to be removed/updated after migrating from Lovable to Vercel + Supabase + GitHub.

## Critical Findings

### ✅ Good News
- Authentication is already using pure Supabase (no Lovable auth in use)
- Core functionality is platform-agnostic
- Database is fully on Supabase

### 🔧 Items to Fix

#### 1. Remove Lovable Auth Package (UNUSED)
- **File**: `src/integrations/lovable/index.ts`
- **Status**: Dead code - not imported anywhere
- **Action**: Delete file

#### 2. Remove Lovable Dependencies
- **Package**: `@lovable.dev/cloud-auth-js` (unused)
- **Package**: `lovable-tagger` (dev tool, optional)
- **Action**: Remove from package.json and reinstall

#### 3. Update Vite Configuration
- **File**: `vite.config.ts`
- **Issue**: Uses `lovable-tagger` plugin
- **Action**: Remove import and plugin usage

#### 4. Update Documentation
- **File**: `README.md`
- **Issues**: 
  - References Lovable project URLs
  - Deployment instructions for Lovable
  - No Vercel deployment info
- **Action**: Rewrite for Vercel deployment

#### 5. Update HTML Meta Tags
- **File**: `index.html`
- **Issue**: Twitter meta tag references @Lovable
- **Action**: Update to your brand

#### 6. Update Admin UI
- **File**: `src/pages/admin/AdminSettingsPage.tsx`
- **Issue**: Shows "Lovable Cloud" badge
- **Action**: Change to "Supabase"

#### 7. Create Vercel Configuration
- **File**: `vercel.json` (missing)
- **Action**: Create with proper SPA routing and environment variables

#### 8. Archive Lovable Plan
- **File**: `.lovable/plan.md`
- **Action**: Keep for reference but mark as archived

## Execution Plan

1. Delete unused Lovable auth integration
2. Remove Lovable dependencies from package.json
3. Update vite.config.ts
4. Create vercel.json for proper deployment
5. Update README.md with Vercel instructions
6. Update index.html meta tags
7. Update Admin Settings page UI
8. Archive .lovable directory

## Post-Migration Checklist

- [ ] All Lovable dependencies removed
- [ ] Vercel deployment configured
- [ ] SPA routing works (F5 refresh issue fixed)
- [ ] Environment variables configured in Vercel
- [ ] Documentation updated
- [ ] No references to Lovable in UI
