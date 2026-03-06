# Logo Upload - Quick Start (5 Minutes)

## What You Need

From the 4 images you sent, you only need **2 files** to start:

1. **Icon** (eagle only) → Save as `icon.png`
2. **Stacked logo** (icon + text) → Save as `logo-stacked.png`

## Step-by-Step (Simple)

### 1. Save Your Images

**From Image 1** (icon only, beige background):
- Remove the beige background (make it transparent)
- Save as: `icon.png`
- Size: 512x512 pixels

**From Image 4** (stacked logo, beige background):
- Remove the beige background (make it transparent)
- Save as: `logo-stacked.png`
- Keep it large (400px+ wide)

**How to remove background**:
- Use https://remove.bg (free, automatic)
- Or use Photoshop/GIMP
- Or ask me to help with a different format

### 2. Create Favicon

- Go to https://favicon.io/favicon-converter/
- Upload your `icon.png`
- Click "Download"
- Extract the zip file
- You'll get `favicon.ico`

### 3. Copy Files to Project

Put these 3 files in your `public` folder:

```
your-project/
└── public/
    ├── icon.png           ← Your eagle icon
    ├── logo-stacked.png   ← Your stacked logo
    └── favicon.ico        ← Generated favicon
```

### 4. Commit and Push

```bash
git add public/icon.png public/logo-stacked.png public/favicon.ico
git commit -m "Add Grind English logos"
git push
```

### 5. Wait for Deployment

Lovable will automatically deploy (1-2 minutes).

### 6. Check Your Site

Refresh your site (Ctrl+Shift+R) and you should see:
- ✅ Eagle icon in browser tab
- ✅ "GRIND ENGLISH" in sidebar
- ✅ Stacked logo on login page

## That's It!

You're done! The logos will appear throughout your site.

## File Format: PNG or SVG?

**Use PNG** - It's simpler and works great.

You don't need SVG unless you want perfect scaling at all sizes. PNG is perfectly fine for web use.

## Minimum Files Needed

| File | Required? | What it does |
|------|-----------|--------------|
| `icon.png` | ✅ YES | Shows in sidebar, browser tab |
| `logo-stacked.png` | ✅ YES | Shows on login/signup pages |
| `favicon.ico` | ✅ YES | Shows in browser tab |
| `logo-horizontal.png` | ❌ Optional | For navbar (not used yet) |
| `logo-inverted.png` | ❌ Optional | For dark backgrounds |

Start with just the 3 required files. You can add the optional ones later if needed.

## Quick Troubleshooting

**Logos not showing?**
1. Hard refresh: Ctrl+Shift+R
2. Check file names are exact: `icon.png` not `Icon.png`
3. Check files are in `public/` folder
4. Wait 2-3 minutes for deployment

**Still not working?**
- Open browser console (F12)
- Look for red errors
- Check if it says "404" (file not found)
- Verify files were pushed to GitHub: `git log`
