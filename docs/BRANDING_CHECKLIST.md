# Grind English Branding - Implementation Checklist

## Phase 1: Core System (COMPLETED ✅)

- [x] Update Tailwind config with brand colors
- [x] Add Grind English color classes
- [x] Update CSS variables for light/dark modes
- [x] Change typography to Oswald/Inter
- [x] Set headings to UPPERCASE
- [x] Remove gradient utilities
- [x] Remove shadow-glow effects
- [x] Sharpen border radius
- [x] Update HTML meta descriptions
- [x] Create branding documentation

## Phase 2: Logo Integration (PENDING 📋)

### Upload Logo Files
- [ ] Upload `logo-stacked.svg` to `/public`
- [ ] Upload `logo-horizontal.svg` to `/public`
- [ ] Upload `logo-inverted.svg` to `/public`
- [ ] Upload `icon.svg` to `/public`
- [ ] Upload `favicon.ico` to `/public`
- [ ] Upload `favicon-16x16.png` to `/public`
- [ ] Upload `favicon-32x32.png` to `/public`

### Update HTML
- [ ] Add favicon links to `index.html`
- [ ] Add apple-touch-icon if needed

### Update Components
- [ ] Update AppHeader/Navbar with horizontal logo
- [ ] Update LoginPage with stacked logo
- [ ] Update SignupPage with stacked logo
- [ ] Update LandingPage with stacked logo

## Phase 3: Component Audit (TODO 🔍)

### UI Components
- [ ] `src/components/ui/button.tsx` - Remove gradients
- [ ] `src/components/ui/card.tsx` - Remove shadows
- [ ] `src/components/ui/dialog.tsx` - Check styling
- [ ] `src/components/ui/badge.tsx` - Simplify
- [ ] `src/components/ui/alert.tsx` - Check colors
- [ ] `src/components/ui/progress.tsx` - Remove gradients

### Page Components
- [ ] `src/pages/LandingPage.tsx` - Full audit
- [ ] `src/pages/LoginPage.tsx` - Remove gradients
- [ ] `src/pages/SignupPage.tsx` - Remove gradients
- [ ] `src/pages/DashboardPage.tsx` - Check styling
- [ ] `src/pages/CoursePage.tsx` - Check styling
- [ ] `src/pages/LevelPage.tsx` - Check styling
- [ ] `src/pages/UnitPage.tsx` - Check styling
- [ ] `src/pages/LessonPlayerPage.tsx` - Check styling

### Layout Components
- [ ] `src/components/layout/AppLayout.tsx` - Check styling
- [ ] `src/components/layout/AppHeader.tsx` - Update logo
- [ ] `src/components/layout/Sidebar.tsx` - Check colors

## Phase 4: Testing (TODO ✓)

### Visual Testing
- [ ] Light mode appearance
- [ ] Dark mode appearance
- [ ] Heading typography (UPPERCASE)
- [ ] No gradients visible
- [ ] Sharp borders
- [ ] Crimson accents on CTAs
- [ ] Logo displays correctly
- [ ] Favicon shows in browser tab

### Functional Testing
- [ ] All pages load
- [ ] Navigation works
- [ ] Buttons clickable
- [ ] Forms usable
- [ ] Dark mode toggle
- [ ] Responsive design

### Accessibility
- [ ] Text contrast (WCAG AA)
- [ ] Focus states visible
- [ ] Keyboard navigation
- [ ] Screen reader friendly

## Phase 5: Deployment (TODO 🚀)

- [ ] Test locally
- [ ] Commit changes
- [ ] Push to repository
- [ ] Deploy to production
- [ ] Verify on live site
- [ ] Check mobile appearance
- [ ] Check different browsers

## Quick Commands

### Test Locally
```bash
npm run dev
```

### Build for Production
```bash
npm run build
```

### Check for Gradients
```bash
# Search for gradient classes in components
grep -r "gradient" src/components/
grep -r "shadow-glow" src/components/
```

## Status Summary

| Phase | Status | Progress |
|-------|--------|----------|
| Core System | ✅ Complete | 100% |
| Logo Integration | 📋 Pending | 0% (waiting for files) |
| Component Audit | 🔍 TODO | 0% |
| Testing | ✓ TODO | 0% |
| Deployment | 🚀 TODO | 0% |

## Current State

**What Works Now**:
- Brand colors configured
- Typography updated
- CSS variables set
- Gradients removed from system
- Meta descriptions updated

**What Needs Logo Files**:
- Favicon
- Navigation logo
- Auth page logos
- Landing page logo

**What Needs Manual Audit**:
- Individual components with hardcoded gradients
- Pages with custom styling
- Any inline styles

## Notes

- The branding system is configured and ready
- Most components will automatically use new colors
- Only explicit gradient/shadow classes need removal
- Logo integration is straightforward once files are available
- No breaking changes to functionality
