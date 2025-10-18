# 🎮 Pixel Art CV - Isometric Redux

A beautiful, interactive one-page CV built with Hugo and featuring custom pixel art graphics in Habbo and isometric styles. The CV features scroll-reactive parallax effects and a Redux-style state system that transforms the scene as you scroll.

## Features

✨ **Pixel Perfect Design**
- Mixed Habbo hotel + isometric pixel art aesthetic
- Custom AI-generated pixel art assets
- Retro 8-bit color palette with modern web animations
- CRT scanline effects for authentic retro feel

🎯 **Interactive Scroll Effects**
- Parallax background layers with multi-speed movement
- Redux-style state changes as you scroll
- Smooth transitions and animations
- Floating decorative elements that drift with scroll

🎨 **Visual Components**
- Isometric workspace scene background
- Habbo-style character avatar
- Pixel art skill icons
- Dynamic section cards with gradient borders
- Glowing text effects and animations

📱 **Responsive & Accessible**
- Mobile-friendly design with touch support
- Keyboard navigation (Arrow keys, Home/End)
- Reduced motion support for accessibility
- Touch swipe navigation for mobile devices

⚡ **Performance & Security**
- Optimized pixel art rendering with CSS transforms
- Smooth 60fps animations using GPU acceleration
- Minimal JavaScript for fast interactions
- Static site generation with Hugo
- Cross-browser scroll compatibility (Safari/iOS safe)
- Production-ready with security optimizations

## Project Structure

```
PixelArtCV/
├── hugo.toml              # Hugo configuration
├── content/
│   └── _index.md          # CV content (frontmatter)
├── layouts/
│   └── index.html         # Main template
├── static/
│   ├── css/
│   │   └── main.css       # All styling with pixel art aesthetic
│   ├── js/
│   │   └── scroll.js      # Parallax & Redux effects
│   └── images/
│       └── pixel-art/
│           ├── workspace.png    # Isometric background
│           ├── avatar.png       # Character avatar
│           └── icons.png        # Skill icons
└── README.md
```

## Quick Setup

### Prerequisites
- [Hugo](https://gohugo.io/installation/) (v0.109+)
- Modern web browser
- Git (optional, for version control)

### 1️⃣ Quick Start (Interactive Setup)

Run the interactive setup script to configure your portfolio with personal details:

**macOS / Linux / Git Bash:**
```bash
chmod +x setup.sh
./setup.sh
```

**Windows (PowerShell - Recommended):**
```powershell
# First time only: Allow script execution
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Run setup
.\setup.ps1
```

**Windows (Command Prompt):**
```cmd
setup.bat
```

The setup script will prompt you for:
- ✅ Full name
- ✅ Email address
- ✅ Website domain
- ✅ GitHub username
- ✅ Twitter/X handle
- ✅ LinkedIn profile

All fields are optional - press Enter to skip.

### 2️⃣ Manual Setup (Skip Interactive)

If you prefer manual configuration, edit `layouts/index.html` and replace:
- `YOUR NAME HERE` → Your name
- `your@email.com` → Your email
- `yourdomain.com` → Your domain
- `yourprofile` → Your GitHub/LinkedIn username
- `yourhandle` → Your Twitter handle
- `Portfolio Owner` → Your name (in meta tags)

### 3️⃣ Local Development

```bash
# Navigate to project directory
cd PixelArtCV

# Start Hugo development server
hugo server

# Visit http://localhost:1313 in your browser
```

The site auto-reloads on file changes. Use keyboard navigation:
- ↑/↓ : Navigate sections
- Space : Scroll next
- Home/End : Jump to top/bottom

### 4️⃣ Build for Production

```bash
# Generate static site
hugo

# Output in 'public' directory
# Deploy this folder to your hosting
```

## 🚀 Deployment Options

### GitHub Pages (Free & Easy)

1. **Create a GitHub repository** and push your code
2. **Enable GitHub Pages:**
   - Go to Settings → Pages
   - Set source to `gh-pages` branch
   - Set publishing directory to `/` (root)

3. **Automatic deployment** (GitHub Actions):
   ```yaml
   # .github/workflows/deploy.yml
   name: Hugo Build & Deploy
   on:
     push:
       branches: [main]
   jobs:
     deploy:
       runs-on: ubuntu-latest
       steps:
         - uses: actions/checkout@v3
         - uses: peaceiris/actions-hugo@v4
           with:
             hugo-version: '0.109.0'
         - run: hugo
         - uses: peaceiris/actions-gh-pages@v3
           with:
             github_token: ${{ secrets.GITHUB_TOKEN }}
             publish_dir: ./public
   ```

### Netlify (Drag & Drop Deploy)

[![Deploy to Netlify](https://www.netlify.com/img/deploy/button.svg)](https://app.netlify.com/start/deploy?repository=https://github.com/your-username/your-repo)

Or manually:
1. Push to GitHub
2. Connect Netlify to your repository
3. Set build command: `hugo`
4. Set publish directory: `public`

### Vercel (Next-Gen Hosting)

1. Import from Git repository
2. Framework: Hugo
3. Deploy!

### Traditional Hosting

1. **Build locally:**
   ```bash
   hugo
   ```

2. **Upload `public/` folder** via FTP/SFTP to your hosting

3. **Point domain** to your hosting provider

## 📊 Analytics & Tracking

The site includes commented blocks for easy analytics integration:

### Google Analytics
Uncomment in `layouts/index.html` `<head>`:
```html
<script async src="https://www.googletagmanager.com/gtag/js?id=GA_YOUR_ID"></script>
```

### Plausible Analytics (Privacy-Friendly)
```html
<script defer data-domain="yourdomain.com" src="https://plausible.io/js/script.js"></script>
```

### Track Custom Events
```javascript
// In static/js/scroll.js
function trackEvent(eventName, eventData) {
    if (window.gtag) {
        gtag('event', eventName, eventData);
    }
}
// Example: trackEvent('section_viewed', { section: 'skills' });
```

## 🔍 SEO Configuration

### Open Graph (Social Sharing)
Meta tags are pre-configured for Twitter, Facebook, LinkedIn sharing. Update in `layouts/index.html`:
- `og:title` - Page title
- `og:description` - Page description
- `og:image` - Share image (1200x630px recommended)
- `og:url` - Your domain

### JSON-LD Schema
Structured data for search engines included. Customize the `<script type="application/ld+json">` block with:
- Your actual name and profile
- Social media URLs
- Contact information
- Job title

### Sitemap
Hugo auto-generates `sitemap.xml` - submit to:
- Google Search Console
- Bing Webmaster Tools

### robots.txt
Add to `static/robots.txt`:
```
User-agent: *
Allow: /
Sitemap: https://yourdomain.com/sitemap.xml
```

## Customization

### Update CV Content
Edit `content/_index.md` and `layouts/index.html` to update your personal information, skills, and experience.

### Modify Colors & Styling
Edit `static/css/main.css`:
- Color palette: Search for hex color codes like `#ff6464`, `#64c8ff`, `#ffd700`
- Animations: Modify keyframe animations and transition durations
- Layout: Adjust grid columns, padding, and margins

### Change Background Image
1. Generate or create your custom pixel art background
2. Save to `static/images/pixel-art/workspace.png`
3. Adjust `main.css` parallax effects if needed

### Customize Parallax Behavior
Edit `static/js/scroll.js`:
- `updateParallax()` function controls layer movement speeds
- `updateReduxState()` function controls state transitions
- Adjust multipliers (0.5, 0.8, etc.) to change parallax intensity

## Scroll States & Redux Effects

The CV has 5 scroll states that progressively darken and transform the scene:

- **State 0 (0-20%)**: Morning - Bright, saturated scene
- **State 1 (20-40%)**: Afternoon - Slightly warmer
- **State 2 (40-60%)**: Evening - More muted colors
- **State 3 (60-80%)**: Night - Dark and deep
- **State 4 (80-100%)**: Deep Night - Maximum darkness

Each state changes:
- Background gradient colors
- Parallax blend modes
- Floating object visibility
- Overall atmosphere

## Browser Support

- Chrome/Edge 90+
- Firefox 88+
- Safari 14+ (including iOS Safari with scroll compatibility fix)
- Mobile browsers (iOS Safari, Chrome Mobile, Samsung Internet)

**Note**: Recent security updates ensure smooth parallax effects across all platforms including Safari/iOS

## Performance Notes

- Pixel art uses `image-rendering: pixelated` for sharp rendering
- GPU acceleration via CSS transforms for smooth animations
- Intersection Observer API for efficient section visibility detection
- Optional scanline effect can be disabled in CSS if needed

## Keyboard Shortcuts

- ↑ / ↓ : Navigate sections
- Space : Scroll next
- Home : Jump to top
- End : Jump to bottom

## Mobile Features

- Touch swipe navigation
- Optimized touch targets (44px minimum)
- Responsive text sizing
- Reduced parallax intensity on mobile

## 🤝 Contributing

Found a bug or want to improve? Feel free to:
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is open source and available under the [MIT License](LICENSE).

You're free to:
- ✅ Use for personal or commercial projects
- ✅ Modify and customize
- ✅ Redistribute with attribution
- ✅ Fork and create variants

## 🎮 Future Enhancements

- [ ] Interactive pixel art mini-games
- [ ] Sound effects (toggle on/off)
- [ ] Dark/light mode switcher
- [ ] Export to PDF functionality
- [ ] Multiple portfolio themes
- [ ] Admin panel for easy editing
- [ ] Blog section support
- [ ] Multi-language support

## 📞 Support & Issues

- 🐛 **Report bugs**: [Open an issue](../../issues)
- 💡 **Feature requests**: [Discussions](../../discussions)
- 📧 **Email**: [your@email.com](mailto:your@email.com)

## 📚 Resources

- [Hugo Documentation](https://gohugo.io/documentation/)
- [Hugo Deployment Guide](https://gohugo.io/hosting-and-deployment/)
- [Web Accessibility Guidelines](https://www.w3.org/WAI/fundamentals/)
- [Open Graph Documentation](https://ogp.me/)
- [JSON-LD Spec](https://json-ld.org/)

## 🙏 Credits

- **Pixel Art**: AI-generated with modern generative tools
- **Inspiration**: Habbo Hotel aesthetic & retro gaming
- **Built with**: [Hugo](https://gohugo.io/) static site generator
- **Font**: [Press Start 2P](https://fonts.google.com/specimen/Press+Start+2P) by Cody Boisclair
- **Architecture**: Modern performance-first design patterns

---

<div align="center">

**Made with ❤️ and 8-bit pixels**

[⭐ Star this repo if you like it!](../../stargazers)

[🚀 Deploy Now](#-deployment-options) • [📖 Read Docs](#-seo-configuration) • [💬 Discuss](../../discussions)

</div>
