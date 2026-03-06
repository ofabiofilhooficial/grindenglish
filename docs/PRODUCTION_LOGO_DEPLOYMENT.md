# Production Logo Deployment Guide

## Where to Upload Files

Since you're using **Lovable** (which deploys from GitHub), you need to:

1. **Add files to your local project** in the `public` folder
2. **Commit to Git**
3. **Push to GitHub**
4. **Lovable will automatically deploy** with the new logos

## Exact File Names & Formats

### Required Files (Choose ONE format per file)

You can use **either PNG or SVG** - both work fine. PNG is simpler if you're not familiar with SVG.

#### Option A: PNG Files (Simpler, Recommended)

```
public/
├── icon.png                 (Required - 512x512px or larger)
├── logo-stacked.png         (Required - transparent background)
├── logo-horizontal.png      (Optional - for navbar)
├── logo-inverted.png        (Optional - for dark backgrounds)
├── favicon.ico              (Required - 16x16 and 32x32)
├── favicon-16x16.png        (Optional but recommended)
└── favicon-32x32.png        (Optional but recommended)
```

#### Option B: SVG Files (Better quality, scalable)

```
public/
├── icon.svg                 (Required)
├── logo-stacked.svg         (Required)
├── logo-horizontal.svg      (Optional)
├── logo-inverted.svg        (Optional)
├── favicon.ico              (Required)
├── favicon-16x16.png        (Optional)
└── favicon-32x32.png        (Optional)
```

#### Option C: Both (Best - automatic fallback)

```
public/
├── icon.svg                 (Preferred)
├── icon.png                 (Fallback)
├── logo-stacked.svg         (Preferred)
├── logo-stacked.png         (Fallback)
├── logo-horizontal.svg      (Optional)
├── logo-horizontal.png      (Optional)
├── logo-inverted.svg        (Optional)
├── logo-inverted.png        (Optional)
├── favicon.ico              (Required)
├── favicon-16x16.png        (Optional)
└── favicon-32x32.png        (Optional)
```

## Step-by-Step Deployment

### Step 1: Prepare Your Logo Files

From the 4 images you sent, save them as:

**Image 1** (Icon only, beige background):
- Save as: `icon.png` (or `icon.svg`)
- Recommended size: 512x512px
- Must have: Transparent background (remove beige)

**Image 4** (Stacked - icon on top, text below, beige background):
- Save as: `logo-stacked.png` (or `logo-stacked.svg`)
- Recommended size: 400px wide minimum
- Must have: Transparent background (remove beige)

**Image 3** (Horizontal - icon left, text right):
- Save as: `logo-horizontal.png` (optional)
- Recommended size: 600px wide minimum
- Must have: Transparent background

**Image 2** (Dark background version):
- Save as: `logo-inverted.png` (optional)
- This one can keep the dark background

### Step 2: Create Favicons

**Easy Way** (Recommended):
1. Go to https://favicon.io/favicon-converter/
2. Upload your `icon.png` (the eagle only)
3. Download the generated files
4. You'll get: `favicon.ico`, `favicon-16x16.png`, `favicon-32x32.png`

**Manual Way**:
1. Resize icon to 32x32 pixels
2. Save as PNG
3. Convert to ICO format using online tool

### Step 3: Add Files to Your Project

**On Windows:**
1. Open your project folder in File Explorer
2. Navigate to the `public` folder
3. Copy/paste your logo files there
4. Verify the names match exactly

**File structure should look like:**
```
your-project/
├── public/
│   ├── icon.png              ← Your eagle icon
│   ├── logo-stacked.png      ← Your stacked logo
│   ├── favicon.ico           ← Generated favicon
│   ├── favicon-16x16.png     ← Generated
│   ├── favicon-32x32.png     ← Generated
│   ├── placeholder.svg       ← (existing, can delete)
│   └── robots.txt            ← (existing, keep)
├── src/
├── package.json
└── ...
```

### Step 4: Test Locally (Optional but Recommended)

```bash
# In your project folder
npm run dev
```

Then open http://localhost:8080 and check:
- Browser tab shows eagle icon
- Sidebar shows "GRIND ENGLISH" with icon
- Login page shows stacked logo

### Step 5: Commit to Git

```bash
# In your project folder
git add public/icon.png
git add public/logo-stacked.png
git add public/favicon.ico
git add public/favicon-16x16.png
git add public/favicon-32x32.png

# Or add all at once
git add public/*.png public/*.ico

git commit -m "Add Grind English logos and branding"
```

### Step 6: Push to GitHub

```bash
git push origin main
```

(Or `git push origin master` if your branch is called master)

### Step 7: Deploy via Lovable

**Lovable automatically deploys** when you push to GitHub!

1. Go to your Lovable dashboard
2. Wait for the deployment to complete (usually 1-2 minutes)
3. Click "View Site" or refresh your production URL
4. Logos should now appear!

## File Format Recommendations

### PNG vs SVG - Which to Use?

| Format | Pros | Cons | Recommendation |
|--------|------|------|----------------|
| **PNG** | ✅ Simple<br>✅ Universal support<br>✅ Easy to create | ⚠️ Fixed size<br>⚠️ Larger files | **Use if you're not familiar with SVG** |
| **SVG** | ✅ Scalable<br>✅ Smaller files<br>✅ Crisp at any size | ⚠️ Requires vector software<br>⚠️ More complex | **Use if you have SVG files** |

**My Recommendation**: Start with PNG - it's simpler and works perfectly fine. You can always switch to SVG later.

## Minimum Required Files

To get your site working with logos, you ONLY need:

1. **`icon.png`** (or `.svg`) - 512x512px, transparent background
2. **`logo-stacked.png`** (or `.svg`) - transparent background
3. **`favicon.ico`** - 16x16 and 32x32 sizes

That's it! The other files are optional.

## Image Specifications

### icon.png / icon.svg
- **Content**: Eagle icon only, no text
- **Size**: 512x512px (PNG) or any size (SVG)
- **Background**: Transparent
- **Format**: PNG or SVG
- **Used in**: Sidebar, browser tab, dialogs

### logo-stacked.png / logo-stacked.svg
- **Content**: Eagle icon on top, "GRIND ENGLISH" text below
- **Size**: 400px wide minimum (PNG) or any size (SVG)
- **Background**: Transparent
- **Format**: PNG or SVG
- **Used in**: Login page, signup page

### favicon.ico
- **Content**: Eagle icon
- **Size**: 16x16 and 32x32 (both sizes in one file)
- **Background**: Transparent or solid color
- **Format**: ICO
- **Used in**: Browser tab

## Troubleshooting

### "I don't see the logos after deploying"

**Solution 1**: Hard refresh
- Windows: Ctrl + Shift + R
- Mac: Cmd + Shift + R

**Solution 2**: Check file names
- Must be exact: `icon.png` not `Icon.png` or `icon.PNG`
- Case-sensitive!

**Solution 3**: Check file location
- Files must be in `public/` folder
- NOT in `src/` or `public/images/`

**Solution 4**: Check Git
```bash
# Verify files were committed
git status

# Verify files were pushed
git log --oneline -1
```

### "I see a broken image icon"

This means the file path is correct but the file is missing or corrupted.

**Check**:
1. File exists in `public/` folder
2. File name matches exactly
3. File is not corrupted (can you open it?)
4. File was committed and pushed to Git

### "Favicon not updating"

Favicons are heavily cached by browsers.

**Solution**:
1. Clear browser cache completely
2. Try in incognito/private window
3. Try different browser
4. Wait 5-10 minutes for CDN to update

## Quick Checklist

Before deploying:

- [ ] Logo files saved with correct names
- [ ] Files have transparent backgrounds (except inverted)
- [ ] Files are in `public/` folder
- [ ] Tested locally (optional)
- [ ] Files committed to Git
- [ ] Files pushed to GitHub
- [ ] Lovable deployment completed
- [ ] Hard refreshed browser
- [ ] Logos appear on site

## Need Help?

If logos still don't appear:
1. Check browser console (F12) for 404 errors
2. Verify file names match exactly
3. Check that files were pushed to GitHub
4. Wait a few minutes for deployment to complete
5. Try incognito mode to bypass cache
