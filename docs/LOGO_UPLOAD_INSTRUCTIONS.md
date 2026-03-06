# Logo Upload Instructions

## Images You Sent

You provided 4 logo variations in the images:
1. **Icon only** (eagle with wings, no text) - beige background
2. **Full logo on dark** (icon + "GRIND ENGLISH" text) - navy background
3. **Horizontal logo** (icon left, text right) - beige background  
4. **Stacked logo** (icon top, text bottom) - beige background

## How to Save and Upload

### Step 1: Save the Images

From the images you sent, save them as:

1. **`icon.svg`** or **`icon.png`** - The eagle icon only (first image)
2. **`logo-inverted.svg`** or **`logo-inverted.png`** - Logo on dark background (second image)
3. **`logo-horizontal.svg`** or **`logo-horizontal.png`** - Horizontal layout (third image)
4. **`logo-stacked.svg`** or **`logo-stacked.png`** - Stacked layout (fourth image)

### Step 2: Upload to Project

Place all logo files in the **`public`** folder of your project:

```
your-project/
├── public/
│   ├── icon.svg (or .png)
│   ├── logo-horizontal.svg (or .png)
│   ├── logo-stacked.svg (or .png)
│   ├── logo-inverted.svg (or .png)
│   └── favicon.ico (create from icon)
```

### Step 3: Create Favicon

Use the icon image to create favicons:
- **favicon.ico** - 16x16 and 32x32 sizes
- **favicon-16x16.png**
- **favicon-32x32.png**

You can use online tools like:
- https://favicon.io/
- https://realfavicongenerator.net/

## File Naming Convention

| File Name | Usage | Description |
|-----------|-------|-------------|
| `icon.svg` or `icon.png` | Favicon, app icon | Eagle only, no text |
| `logo-horizontal.svg` or `.png` | Navbar | Icon left, text right |
| `logo-stacked.svg` or `.png` | Auth pages, landing | Icon top, text bottom |
| `logo-inverted.svg` or `.png` | Dark backgrounds | Light version |
| `favicon.ico` | Browser tab | 16x16, 32x32 |

## After Upload

Once you've uploaded the files, the components are already configured to use them. Just refresh your app and the logos should appear!

If using PNG instead of SVG, update the file extensions in the components (I'll show you how in the next step).

## Quick Test

After uploading, check:
1. Browser tab shows the eagle icon
2. Sidebar shows "GRIND ENGLISH" with logo
3. Login page shows stacked logo
4. Navbar shows horizontal logo

## Need Help?

If the logos don't appear:
1. Check the file names match exactly
2. Check they're in the `/public` folder
3. Hard refresh your browser (Ctrl+Shift+R)
4. Check browser console for 404 errors
