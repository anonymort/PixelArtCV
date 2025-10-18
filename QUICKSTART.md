# Quick Start Guide

## 🚀 Get Running in 30 Seconds

### Prerequisites
- Hugo installed (`brew install hugo` on macOS)

### Steps

1. **Navigate to the project**
   ```bash
   cd /Users/mattkneale/Documents/Coding/PixelArtCV
   ```

2. **Start local development server**
   ```bash
   hugo server
   ```

3. **Open in browser**
   ```
   http://localhost:1313
   ```

That's it! Your pixel art CV is now running with live reload enabled.

## 🎨 Customization Quick Tips

### Update Your Info
Edit `layouts/index.html` and search for:
- `MATT KNEALE` → Your name
- `hello@example.com` → Your email
- Social links in contact section

### Change Colors
Edit `static/css/main.css`:
- `#ff6464` → Red accent color
- `#64c8ff` → Blue accent color
- `#64ff64` → Green accent color
- `#ffd700` → Gold/yellow accent

### Replace Pixel Art
1. Generate new pixel art or create your own
2. Replace files in `static/images/pixel-art/`
3. Update image paths in `layouts/index.html` if needed

### Adjust Parallax Speed
Edit `static/js/scroll.js`, function `updateParallax()`:
- Change `0.5` and `0.8` multipliers to adjust parallax intensity

## 📦 Build for Production

```bash
hugo
```

The optimized site is generated in the `public` folder. Deploy this folder to your hosting.

## 🎮 Features to Try

- **Scroll** to see parallax and scene transformation
- **Keyboard navigation**: ↑↓ arrows, Space, Home, End
- **Touch swipe**: On mobile, swipe up/down to navigate
- **Hover effects**: Skill cards and contact links are interactive

## 📚 Full Documentation

See `README.md` for comprehensive documentation on architecture, customization, and deployment.

## 🆘 Troubleshooting

**Site doesn't look right?**
- Clear browser cache (Ctrl+Shift+Delete or Cmd+Shift+Delete)
- Make sure CSS and JS files loaded (check browser console)

**Images not showing?**
- Verify image files exist in `static/images/pixel-art/`
- Check paths in `layouts/index.html` match file names

**Parallax not working?**
- JavaScript must be enabled
- Check browser console for errors
- Ensure `static/js/scroll.js` is being loaded

---

Happy scrolling! 🎨✨
