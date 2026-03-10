# Post-Migration Checklist

## Immediate Actions (Do These Now)

### 1. Update Dependencies
```bash
npm install
```
This will regenerate `package-lock.json` without Lovable dependencies.

### 2. Verify Local Development
```bash
npm run dev
```
- [ ] Server starts without errors
- [ ] No console errors about missing modules
- [ ] App loads at http://localhost:8080
- [ ] Can navigate between pages
- [ ] F5 refresh works on all routes

### 3. Test Authentication
- [ ] Sign up with email/password works
- [ ] Login with email/password works
- [ ] Google OAuth works
- [ ] LinkedIn OAuth works
- [ ] GitHub OAuth works
- [ ] Sign out works
- [ ] Session persists on refresh

### 4. Test Core Features
- [ ] Dashboard loads with user data
- [ ] Course pages accessible
- [ ] Lesson player works
- [ ] Vocabulary practice works
- [ ] Admin pages accessible (if admin)
- [ ] Database queries return data

## Vercel Deployment Setup

### 1. Connect Repository
1. Go to [Vercel Dashboard](https://vercel.com/dashboard)
2. Click "Add New Project"
3. Import your GitHub repository
4. Select the repository

### 2. Configure Build Settings
Vercel should auto-detect these, but verify:
- **Framework Preset**: Vite
- **Build Command**: `npm run build`
- **Output Directory**: `dist`
- **Install Command**: `npm install`

### 3. Add Environment Variables
In Vercel project settings → Environment Variables, add:

```
VITE_SUPABASE_PROJECT_ID = nyovkitllfvbjslunned
VITE_SUPABASE_URL = https://nyovkitllfvbjslunned.supabase.co
VITE_SUPABASE_PUBLISHABLE_KEY = [your key from .env]
```

**Important**: Add these for all environments (Production, Preview, Development)

### 4. Deploy
- [ ] Click "Deploy"
- [ ] Wait for build to complete
- [ ] Visit deployment URL
- [ ] Test all features in production

## Supabase Configuration

### 1. Update Redirect URLs
In Supabase Dashboard → Authentication → URL Configuration:

Add your Vercel domains:
```
https://your-app.vercel.app/auth/callback
https://your-app-*.vercel.app/auth/callback (for preview deployments)
http://localhost:8080/auth/callback (for local dev)
```

### 2. Configure OAuth Providers
Ensure redirect URIs in OAuth provider settings include Vercel domains:
- Google Cloud Console
- LinkedIn Developer Portal
- GitHub OAuth Apps

### 3. Verify RLS Policies
- [ ] Run migrations if not already applied
- [ ] Test that users can only access their own data
- [ ] Test role-based access (admin, teacher, learner)

## GitHub Configuration

### 1. Branch Protection (Optional but Recommended)
- [ ] Protect main branch
- [ ] Require pull request reviews
- [ ] Require status checks to pass

### 2. Secrets (if using GitHub Actions)
If you plan to use GitHub Actions for CI/CD:
- Add `SUPABASE_ACCESS_TOKEN` as repository secret
- Add `VERCEL_TOKEN` if using Vercel CLI in actions

## Performance Optimization

### 1. Verify Build Output
```bash
npm run build
```
- [ ] Build completes without errors
- [ ] Check dist/ folder size (should be reasonable)
- [ ] No warnings about large chunks

### 2. Test Production Build Locally
```bash
npm run preview
```
- [ ] Preview server starts
- [ ] App works correctly
- [ ] No console errors

## Monitoring Setup (Optional)

### 1. Vercel Analytics
- [ ] Enable Vercel Analytics in project settings
- [ ] Monitor page load times
- [ ] Track Core Web Vitals

### 2. Supabase Monitoring
- [ ] Check database usage
- [ ] Monitor API requests
- [ ] Set up alerts for errors

### 3. Error Tracking (Optional)
Consider adding:
- Sentry for error tracking
- LogRocket for session replay
- PostHog for product analytics

## Final Verification

### Production Testing
- [ ] Visit production URL
- [ ] Test authentication flow
- [ ] Test all major features
- [ ] Test on mobile devices
- [ ] Test in different browsers
- [ ] Verify F5 refresh works on all routes
- [ ] Check console for errors
- [ ] Verify API calls succeed

### Performance Testing
- [ ] Run Lighthouse audit
- [ ] Check page load times
- [ ] Verify images load correctly
- [ ] Test with slow 3G connection

## Cleanup (Optional)

### Remove Lovable References
- [ ] Update project name in package.json if needed
- [ ] Remove .lovable directory (or keep for reference)
- [ ] Archive migration documentation files

### Documentation
- [ ] Update README with production URL
- [ ] Document deployment process
- [ ] Update team onboarding docs

## Rollback Plan (Just in Case)

If something goes wrong:
1. Vercel allows instant rollback to previous deployment
2. Keep .env file backed up
3. Database migrations are versioned in git
4. Can redeploy from any git commit

## Success Criteria

✅ Migration is successful when:
- [ ] Local development works perfectly
- [ ] Production deployment is live
- [ ] All authentication methods work
- [ ] Database queries succeed
- [ ] No Lovable dependencies remain
- [ ] F5 refresh works everywhere
- [ ] Team can deploy via git push
- [ ] Documentation is updated

## Support Resources

- [Vercel Documentation](https://vercel.com/docs)
- [Supabase Documentation](https://supabase.com/docs)
- [Vite Documentation](https://vitejs.dev/)
- [React Router Documentation](https://reactrouter.com/)

## Notes

- The `vercel.json` file handles SPA routing automatically
- The `public/_redirects` file is a backup for Netlify-style platforms
- Environment variables must start with `VITE_` to be exposed to the client
- Supabase client is already configured correctly
- Authentication is already using pure Supabase (no changes needed)
