# Grind English - Brand Implementation Guide

## Brand Overview

Grind English is a modern, no-fluff English learning platform built around discipline and measurable progress. The brand projects "Coach energy" - disciplined, confident, direct, and motivating.

## Core Brand Colors

### Official Palette (HEX Codes)

| Color Role | Name | HEX Code | Usage |
|------------|------|----------|-------|
| Primary Dark | Deep Navy | `#0B1630` | Primary text, outer eagle geometry, corporate professionalism |
| Primary Action | Crimson | `#D61F3A` | Inner wing panels, CTA buttons, urgency and momentum |
| Neutral Base | Off-White | `#F3EBDD` | Default light-mode background, warmer than pure white |
| Micro-Accent | Tiny Gold | `#D6A74A` | Eagle's beak highlight ONLY (not for UI elements) |

### Tailwind Classes

```css
/* Background Colors */
.bg-grind-navy      /* #0B1630 */
.bg-grind-crimson   /* #D61F3A */
.bg-grind-offwhite  /* #F3EBDD */

/* Text Colors */
.text-grind-navy
.text-grind-crimson
.text-grind-offwhite

/* Border Colors */
.border-grind-navy
.border-grind-crimson
```

### CSS Variables

```css
/* Light Mode */
--background: 210 60% 97%;     /* Off-White base */
--foreground: 220 65% 10%;     /* Deep Navy */
--primary: 220 65% 10%;        /* Deep Navy */
--accent: 352 75% 48%;         /* Crimson */

/* Dark Mode */
--background: 220 65% 10%;     /* Deep Navy */
--foreground: 40 35% 95%;      /* Off-White */
--primary: 352 75% 48%;        /* Crimson */
--accent: 352 75% 48%;         /* Crimson */
```

## Typography

### Font Families

**Primary Font**: Inter, Roboto Condensed
- Body text, paragraphs, UI elements
- Clean, readable, professional

**Display Font**: Oswald, Inter
- Headings, wordmarks, primary buttons
- Bold, condensed, uppercase

### Typography Rules

```css
/* All headings */
h1, h2, h3, h4, h5, h6 {
  font-family: 'Oswald', 'Inter', sans-serif;
  text-transform: uppercase;
  letter-spacing: 0.05em; /* Increased spacing */
}
```

**Key Principles**:
- Main wordmarks: ALWAYS UPPERCASE
- Slightly increased letter-spacing for premium readability
- Bold, condensed sans-serif for authority

## Stylistic Rules

### DO USE ✅
- Flat solid color fills
- Crisp vector edges
- Transparent backgrounds
- Sharp, flat borders
- Solid color transitions

### DO NOT USE ❌
- Gradients
- 3D bevels
- Drop shadows (except subtle borders)
- Photorealism
- Textures
- Warped text
- Rounded scrollbars (use flat)

## Logo Variations

### 1. Primary Logo (Stacked)
**File**: `logo-stacked.svg` or `logo-stacked.png`
**Usage**: General use where vertical space is not restricted
**Description**: Icon centered on top, "GRIND ENGLISH" text centered below

### 2. Navbar Horizontal
**File**: `logo-horizontal.svg` or `logo-horizontal.png`
**Usage**: Top navigation bar (AppHeader.tsx)
**Description**: Icon on left, text on right, optimized for limited vertical space

### 3. Dark Mode / Inverted
**File**: `logo-inverted.svg` or `logo-inverted.png`
**Usage**: Dark backgrounds
**Description**: Navy elements inverted to Off-White, Crimson wings remain

### 4. App Icon / Favicon
**File**: `icon.svg` or `icon.png`
**Usage**: Browser tabs (16x16, 32x32), mobile app icons, social avatars
**Description**: Geometric eagle icon only, no text

### 5. Isolation Master
**File**: `logo-isolation.png`
**Usage**: Internal production tool only
**Description**: Stacked logo on chroma-green/magenta for background removal

## Implementation Checklist

### ✅ Completed

- [x] Updated `tailwind.config.ts` with Grind English colors
- [x] Updated `src/index.css` with brand color variables
- [x] Changed typography to Oswald/Inter with uppercase headings
- [x] Removed all gradients from CSS
- [x] Removed shadow-glow utilities
- [x] Updated HTML meta descriptions
- [x] Set sharper border radius (0.375rem)

### 📋 TODO (Requires Logo Files)

- [ ] Add logo files to `/public` directory:
  - `logo-stacked.svg`
  - `logo-horizontal.svg`
  - `logo-inverted.svg`
  - `icon.svg`
  - `favicon.ico` (16x16, 32x32)

- [ ] Update `index.html` favicon:
  ```html
  <link rel="icon" type="image/svg+xml" href="/icon.svg" />
  <link rel="icon" type="image/png" sizes="32x32" href="/favicon-32x32.png" />
  <link rel="icon" type="image/png" sizes="16x16" href="/favicon-16x16.png" />
  ```

- [ ] Update `AppHeader.tsx` (or Navbar component):
  ```tsx
  <img src="/logo-horizontal.svg" alt="Grind English" className="h-8" />
  ```

- [ ] Update `LoginPage.tsx`:
  ```tsx
  <img src="/logo-stacked.svg" alt="Grind English" className="h-24" />
  ```

- [ ] Update `SignupPage.tsx`:
  ```tsx
  <img src="/logo-stacked.svg" alt="Grind English" className="h-24" />
  ```

- [ ] Update `LandingPage.tsx`:
  ```tsx
  <img src="/logo-stacked.svg" alt="Grind English" className="h-32" />
  ```

### 🔍 Components to Audit

Scan these components and remove any:
- Gradient classes (`bg-gradient-*`, `text-gradient-*`)
- Shadow glow classes (`shadow-glow`, `shadow-accent-glow`)
- 3D effects or bevels
- Rounded elements that should be sharp

**Priority Components**:
- `src/components/ui/button.tsx`
- `src/components/ui/card.tsx`
- `src/components/ui/dialog.tsx`
- `src/pages/LandingPage.tsx`
- `src/pages/LoginPage.tsx`
- `src/pages/SignupPage.tsx`
- `src/pages/DashboardPage.tsx`

## Brand Voice & Messaging

### Tone
- Short sentences
- Action verbs
- Concrete outcomes
- Direct and motivating

### Example Copy
✅ Good:
- "Show up daily. Improve weekly."
- "Build real English ability through consistent effort."
- "Structured immersion. Repetition. Momentum."

❌ Avoid:
- "Your amazing journey to fluency!"
- "Fun and easy English learning!"
- "Unlock your potential with our revolutionary method!"

## Color Usage Guidelines

### Backgrounds
- **Light Mode**: Off-White (#F3EBDD) for main background
- **Dark Mode**: Deep Navy (#0B1630) for main background
- **Cards**: Slightly lighter/darker than background

### Text
- **Light Mode**: Deep Navy (#0B1630) for primary text
- **Dark Mode**: Off-White (#F3EBDD) for primary text

### Actions (Buttons, Links)
- **Primary CTA**: Crimson (#D61F3A) background, Off-White text
- **Secondary**: Deep Navy border, transparent background
- **Hover**: Slightly darker shade of base color (no gradients)

### Accents
- **Energy/Urgency**: Crimson (#D61F3A)
- **Success**: Keep existing green
- **Warning**: Keep existing amber
- **Error**: Keep existing red

## Technical Notes

### Border Radius
Changed from `0.625rem` to `0.375rem` for sharper, more disciplined appearance.

### Scrollbar
Removed rounded corners - now flat and minimal.

### Shadows
Removed glow effects. Use subtle flat borders instead:
```css
border: 1px solid hsl(var(--border));
```

### Transitions
Keep transitions simple and fast:
```css
transition: background-color 0.2s, border-color 0.2s;
```

## Next Steps

1. **Upload logo files** to `/public` directory
2. **Update components** to use new logos
3. **Audit UI components** for gradients/shadows
4. **Test in both light and dark modes**
5. **Verify accessibility** (contrast ratios)
6. **Deploy and verify** on production

## Support

For questions about brand implementation, refer to:
- Brand SSOT document (provided by user)
- This implementation guide
- Tailwind config and CSS variables
