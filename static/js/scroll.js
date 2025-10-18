// ===== Portfolio CV - Scroll & Parallax Effects =====
// Performance optimized with debouncing and efficient DOM queries

class PortfolioCV {
    constructor() {
        this.parallax1 = document.getElementById('parallax1');
        this.parallax2 = document.getElementById('parallax2');
        this.sections = document.querySelectorAll('.cv-section');
        this.scrollIndicator = document.querySelector('.scroll-indicator');
        this.floatItems = null; // Lazy load on first use

        this.scrollState = 0;
        this.maxScrollState = 4;
        this.scrollProgress = 0;
        this.scrollTimeout = null;
        this.isScrolling = false;

        // Cache frequently accessed elements
        this.parallax1BgImage = null;
        this.parallax2Layer = null;

        this.init();
    }

    init() {
        // Intersection Observer for section visibility
        this.setupIntersectionObserver();

        // Throttled scroll event listener
        window.addEventListener('scroll', () => this.throttledScroll(), { passive: true });

        // Initial check
        this.onScroll();
    }

    throttledScroll() {
        if (this.scrollTimeout) return;
        this.scrollTimeout = requestAnimationFrame(() => {
            this.onScroll();
            this.scrollTimeout = null;
        });
    }

    setupIntersectionObserver() {
        const options = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                entry.target.classList.toggle('visible', entry.isIntersecting);
            });
        }, options);

        this.sections.forEach(section => {
            observer.observe(section);
        });
    }

    onScroll() {
        // Calculate scroll progress (0 to 1)
        const winScroll = document.documentElement.scrollTop;
        const height = document.documentElement.scrollHeight - document.documentElement.clientHeight;
        const scrolled = height > 0 ? (winScroll / height) : 0;

        // Parallax effect - move layers at different speeds
        this.updateParallax(scrolled);

        // Redux effect - change background based on scroll position
        this.updateReduxState(scrolled);

        // Update scroll indicator visibility
        this.updateScrollIndicator(scrolled);

        // Store scroll progress
        this.scrollProgress = scrolled;
    }

    updateParallax(scrollProgress) {
        // Parallax layer 1: slower movement (background scene)
        const offset1 = scrollProgress * 50;
        if (this.parallax1) {
            this.parallax1.style.transform = `translateY(${offset1 * 0.5}px)`;
        }

        // Parallax layer 2: slightly faster (floating objects)
        if (this.parallax2) {
            this.parallax2.style.transform = `translateY(${offset1 * 0.8}px)`;
        }

        // Floating items animation based on scroll (lazy load)
        if (!this.floatItems) {
            this.floatItems = document.querySelectorAll('.float-item');
        }

        this.floatItems.forEach((item, index) => {
            const drift = scrollProgress * 100;
            const direction = index % 2 === 0 ? 1 : -1;
            item.style.transform = `translateX(${drift * direction * 0.3}px) translateY(${drift * 0.2}px) rotate(${drift * 1.5}deg)`;
        });
    }

    updateReduxState(scrollProgress) {
        // Determine which state we're in (0-4)
        const newState = Math.floor(scrollProgress * this.maxScrollState);

        if (newState !== this.scrollState) {
            this.scrollState = newState;
            this.applyScrollState(newState);
        }

        // Smooth transition effect
        const stateTransition = (scrollProgress * this.maxScrollState) % 1;
        this.applyScrollTransition(newState, stateTransition);
    }

    applyScrollState(state) {
        // Remove previous state classes efficiently
        document.body.classList.remove(...Array.from({length: 5}, (_, i) => `scroll-state-${i}`));

        // Add current state
        document.body.classList.add(`scroll-state-${state}`);

        // Set ambience based on state
        const ambienceMap = ['morning', 'afternoon', 'evening', 'night', 'deep-night'];
        this.setAmbience(ambienceMap[state]);
    }

    applyScrollTransition(state, progress) {
        // Smooth color transitions during scroll
        if (!this.parallax1BgImage) {
            this.parallax1BgImage = document.querySelector('.parallax-1 .bg-image');
        }

        if (this.parallax1BgImage) {
            const brightness = 0.9 - (progress * 0.2);
            const saturation = 1.2 + (progress * 0.3);
            this.parallax1BgImage.style.filter = `saturate(${saturation}) brightness(${brightness})`;
        }
    }

    setAmbience(state) {
        // Change the overall ambience based on scroll state
        if (!this.parallax2Layer) {
            this.parallax2Layer = document.querySelector('.parallax-2');
        }

        if (this.parallax2Layer) {
            const ambienceSettings = {
                'morning': { mode: 'screen', opacity: '0.2' },
                'afternoon': { mode: 'multiply', opacity: '0.15' },
                'evening': { mode: 'overlay', opacity: '0.25' },
                'night': { mode: 'darken', opacity: '0.4' },
                'deep-night': { mode: 'darken', opacity: '0.5' }
            };

            const settings = ambienceSettings[state];
            if (settings) {
                this.parallax2Layer.style.mixBlendMode = settings.mode;
                this.parallax2Layer.style.opacity = settings.opacity;
            }
        }
    }

    updateScrollIndicator(scrollProgress) {
        // Hide scroll indicator when scrolled down
        if (scrollProgress > 0.1) {
            this.scrollIndicator.style.opacity = '0';
            this.scrollIndicator.style.pointerEvents = 'none';
        } else {
            this.scrollIndicator.style.opacity = '1';
            this.scrollIndicator.style.pointerEvents = 'auto';
        }
    }
}

// Initialize when DOM is ready
document.addEventListener('DOMContentLoaded', () => {
    new PortfolioCV();
});

// ===== Keyboard Navigation =====
const setupKeyboardNavigation = () => {
    document.addEventListener('keydown', (e) => {
        const sections = document.querySelectorAll('.cv-section');
        let currentIndex = -1;

        sections.forEach((section, index) => {
            if (section.classList.contains('visible')) {
                currentIndex = index;
            }
        });

        const handlers = {
            'ArrowDown': () => currentIndex < sections.length - 1 && sections[currentIndex + 1].scrollIntoView({ behavior: 'smooth' }),
            ' ': () => currentIndex < sections.length - 1 && sections[currentIndex + 1].scrollIntoView({ behavior: 'smooth' }),
            'ArrowUp': () => currentIndex > 0 && sections[currentIndex - 1].scrollIntoView({ behavior: 'smooth' }),
            'Home': () => sections[0]?.scrollIntoView({ behavior: 'smooth' }),
            'End': () => sections[sections.length - 1]?.scrollIntoView({ behavior: 'smooth' })
        };

        if (handlers[e.key]) {
            e.preventDefault();
            handlers[e.key]();
        }
    });
};

// ===== Touch Navigation =====
const setupTouchNavigation = () => {
    let touchStartY = 0;

    document.addEventListener('touchstart', (e) => {
        touchStartY = e.touches[0].clientY;
    }, { passive: true });

    document.addEventListener('touchend', (e) => {
        const touchEndY = e.changedTouches[0].clientY;
        const diff = touchStartY - touchEndY;

        if (Math.abs(diff) > 50) {
            const sections = document.querySelectorAll('.cv-section');
            let currentIndex = -1;

            sections.forEach((section, index) => {
                if (section.classList.contains('visible')) {
                    currentIndex = index;
                }
            });

            if (diff > 0 && currentIndex < sections.length - 1) {
                sections[currentIndex + 1].scrollIntoView({ behavior: 'smooth' });
            } else if (diff < 0 && currentIndex > 0) {
                sections[currentIndex - 1].scrollIntoView({ behavior: 'smooth' });
            }
        }
    }, { passive: true });
};

// Initialize enhancements
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', () => {
        setupKeyboardNavigation();
        setupTouchNavigation();
    });
} else {
    setupKeyboardNavigation();
    setupTouchNavigation();
}

// TODO: Analytics Integration
// Uncomment below to integrate analytics service
// OPTION 1: Google Analytics
// <script async src="https://www.googletagmanager.com/gtag/js?id=GA_MEASUREMENT_ID"></script>
// <script>
//   window.dataLayer = window.dataLayer || [];
//   function gtag(){dataLayer.push(arguments);}
//   gtag('js', new Date());
//   gtag('config', 'GA_MEASUREMENT_ID');
// </script>

// OPTION 2: Plausible Analytics (Privacy-friendly)
// <script defer data-domain="yourdomain.com" src="https://plausible.io/js/script.js"></script>

// OPTION 3: Track Custom Events
// function trackEvent(eventName, eventData) {
//     if (window.gtag) {
//         gtag('event', eventName, eventData);
//     }
// }
// Example: trackEvent('section_viewed', { section: 'skills' });

// TODO: Social Sharing Meta Tags
// Add to <head> in layouts/index.html:
// <meta property="og:title" content="Portfolio - Your Name">
// <meta property="og:description" content="Creative developer specializing in pixel art and interactive experiences">
// <meta property="og:image" content="https://yourdomain.com/images/og-image.png">
// <meta property="og:url" content="https://yourdomain.com">
// <meta name="twitter:card" content="summary_large_image">
// <meta name="twitter:creator" content="@yourhandle">

// TODO: SEO Schema Markup
// Add to layouts/index.html:
// <script type="application/ld+json">
// {
//   "@context": "https://schema.org",
//   "@type": "Person",
//   "name": "Your Name",
//   "url": "https://yourdomain.com",
//   "jobTitle": "Creative Developer",
//   "image": "https://yourdomain.com/images/profile.jpg",
//   "sameAs": [
//     "https://www.linkedin.com/in/yourprofile",
//     "https://github.com/yourprofile",
//     "https://twitter.com/yourhandle"
//   ],
//   "contactPoint": {
//     "@type": "ContactPoint",
//     "contactType": "Professional Inquiry",
//     "email": "your@email.com"
//   }
// }
// </script>
