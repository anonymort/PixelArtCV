# Favicon Setup Guide

Your Pixel Art CV references favicon files that need to be added for a complete professional appearance.

## Quick Setup (2 minutes)

### Option 1: Generate Online (Easiest)
1. Go to **[favicon-generator.org](https://www.favicon-generator.org/)**
2. Upload your pixel art image or logo (suggest 512x512px)
3. Download the favicon package
4. Extract to `static/` directory
5. Done! Your favicon will now appear in browser tabs

### Option 2: Manual (If you have favicon files)
1. Place `favicon.ico` in `static/` directory
2. Place `apple-touch-icon.png` (180x180px) in `static/` directory

### Required Files
- `static/favicon.ico` - Browser tab icon (any size, but 16x16, 32x32, or 64x64 recommended)
- `static/apple-touch-icon.png` - iOS bookmark icon (180x180px recommended)

### What Gets Generated
These files are already referenced in `layouts/index.html`:

```html
<link rel="icon" type="image/x-icon" href="/favicon.ico">
<link rel="apple-touch-icon" href="/apple-touch-icon.png">
```

## Create from Your Pixel Art

If you want to use your existing pixel art assets:

1. **Use your workspace.png or avatar.png** - Crop to square (512x512px)
2. **Generate ICO file** from PNG:
   - Online: [convertio.co/png-ico/](https://convertio.co/png-ico/)
   - Or use ImageMagick: `convert image.png favicon.ico`

3. **Create apple-touch-icon.png** - Same dimensions (180x180px)

## Pro Tip: Match Your Aesthetic

Your pixel art CV uses retro colors:
- `#ff6464` (red)
- `#64c8ff` (blue)
- `#64ff64` (green)
- `#ffd700` (gold)
- `#0a0e27` (dark background)

Consider creating a small 32x32px pixel art icon using these colors for maximum brand cohesion.

## Testing

After adding favicon files:

1. Clear browser cache: `Cmd+Shift+Delete` (Mac) or `Ctrl+Shift+Delete` (Windows)
2. Restart `hugo server`
3. Reload page in browser
4. Favicon should appear in browser tab

## Files to Add

```
static/
├── favicon.ico              # Browser tab icon
├── apple-touch-icon.png     # iOS bookmark icon
└── [other images...]
```

**You're done!** Your portfolio will now have a professional appearance across all devices and browsers.
