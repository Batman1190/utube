$filePath = 'c:\Users\Elizabeth\Downloads\index.html'
$content = Get-Content $filePath -Raw

# Enhanced JavaScript for better YouTube integration
$enhancedScript = @'
<script>
(function() {
    // Enhanced hamburger menu with YouTube-like features
    function initEnhancedHamburgerMenu() {
        // Multiple selectors to find hamburger button
        const hamburgerSelectors = [
            'button[aria-label*="Menu"]',
            'button[aria-label*="Guide"]',
            'yt-icon-button[aria-label*="Guide"]',
            'yt-icon-button[aria-label*="Menu"]',
            '[class*="guide-icon"]',
            '[class*="menu-icon"]',
            'ytd-masthead button',
            '#guide-button',
            '.yt-icon-button[aria-label*="Guide"]'
        ];
        
        let hamburgerBtn = null;
        for (const selector of hamburgerSelectors) {
            hamburgerBtn = document.querySelector(selector);
            if (hamburgerBtn) break;
        }
        
        // If still not found, look for icon elements
        if (!hamburgerBtn) {
            const iconElements = document.querySelectorAll('yt-icon, yt-icon-button');
            iconElements.forEach(el => {
                const ariaLabel = el.getAttribute('aria-label') || '';
                if (ariaLabel.toLowerCase().includes('menu') || ariaLabel.toLowerCase().includes('guide')) {
                    hamburgerBtn = el.closest('button') || el.parentElement;
                }
            });
        }
        
        // Create or get sidebar
        let sidebar = document.getElementById('yt-enhanced-sidebar');
        if (!sidebar) {
            sidebar = document.createElement('div');
            sidebar.id = 'yt-enhanced-sidebar';
            sidebar.className = 'yt-enhanced-sidebar';
            sidebar.setAttribute('role', 'navigation');
            sidebar.setAttribute('aria-label', 'Navigation menu');
            
            sidebar.innerHTML = `
                <div class="yt-sidebar-scroll">
                    <div class="yt-sidebar-section">
                        <a href="/" class="yt-sidebar-link active" data-page="home">
                            <div class="yt-sidebar-icon-wrapper">
                                <svg class="yt-sidebar-icon" viewBox="0 0 24 24" fill="currentColor">
                                    <path d="M10 20v-6h4v6h5v-8h3L12 3 2 12h3v8z"/>
                                </svg>
                            </div>
                            <span class="yt-sidebar-text">Home</span>
                        </a>
                        <a href="/feed/explore" class="yt-sidebar-link" data-page="explore">
                            <div class="yt-sidebar-icon-wrapper">
                                <svg class="yt-sidebar-icon" viewBox="0 0 24 24" fill="currentColor">
                                    <path d="M12 10.9c-.61 0-1.1.49-1.1 1.1s.49 1.1 1.1 1.1c.61 0 1.1-.49 1.1-1.1s-.49-1.1-1.1-1.1zM12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm2.19 12.19L6 18l3.81-8.19L18 6l-3.81 8.19z"/>
                                </svg>
                            </div>
                            <span class="yt-sidebar-text">Explore</span>
                        </a>
                        <a href="/feed/subscriptions" class="yt-sidebar-link" data-page="subscriptions">
                            <div class="yt-sidebar-icon-wrapper">
                                <svg class="yt-sidebar-icon" viewBox="0 0 24 24" fill="currentColor">
                                    <path d="M18.7 8.7H5.3V7h13.4v1.7zm-1.7-5H7v1.6h10V3.7zm1.7 8.3v7c0 1-.7 1.7-1.7 1.7H7c-1 0-1.7-.7-1.7-1.7v-7h14.4zm0-1.7H5.3c-1 0-1.7.7-1.7 1.7V21c0 1 .7 1.7 1.7 1.7h10c1 0 1.7-.7 1.7-1.7v-9.3c0-1-.7-1.7-1.7-1.7z"/>
                                </svg>
                            </div>
                            <span class="yt-sidebar-text">Subscriptions</span>
                        </a>
                    </div>
                    
                    <div class="yt-sidebar-divider"></div>
                    
                    <div class="yt-sidebar-section">
                        <a href="/feed/library" class="yt-sidebar-link" data-page="library">
                            <div class="yt-sidebar-icon-wrapper">
                                <svg class="yt-sidebar-icon" viewBox="0 0 24 24" fill="currentColor">
                                    <path d="M4 6H2v14c0 1.1.9 2 2 2h14v-2H4V6zm16-4H8c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zm-1 9H9V9h10v2zm-4-4H9V5h6v2z"/>
                                </svg>
                            </div>
                            <span class="yt-sidebar-text">Library</span>
                        </a>
                        <a href="/feed/history" class="yt-sidebar-link" data-page="history">
                            <div class="yt-sidebar-icon-wrapper">
                                <svg class="yt-sidebar-icon" viewBox="0 0 24 24" fill="currentColor">
                                    <path d="M13 3c-4.97 0-9 4.03-9 9H1l3.89 3.89.07.14L9 12H6c0-3.87 3.13-7 7-7s7 3.13 7 7-3.13 7-7 7c-1.93 0-3.68-.79-4.94-2.06l-1.42 1.42C8.27 19.99 10.51 21 13 21c4.97 0 9-4.03 9-9s-4.03-9-9-9zm-1 5v5l4.28 2.54.72-1.21-3.5-2.08V8H12z"/>
                                </svg>
                            </div>
                            <span class="yt-sidebar-text">History</span>
                        </a>
                    </div>
                    
                    <div class="yt-sidebar-divider"></div>
                    
                    <div class="yt-sidebar-section">
                        <div class="yt-sidebar-section-title">MORE FROM UTUBE</div>
                        <a href="/premium" class="yt-sidebar-link" data-page="premium">
                            <div class="yt-sidebar-icon-wrapper">
                                <svg class="yt-sidebar-icon" viewBox="0 0 24 24" fill="currentColor">
                                    <path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/>
                                </svg>
                            </div>
                            <span class="yt-sidebar-text">Utube Premium</span>
                        </a>
                        <a href="/music" class="yt-sidebar-link" data-page="music">
                            <div class="yt-sidebar-icon-wrapper">
                                <svg class="yt-sidebar-icon" viewBox="0 0 24 24" fill="currentColor">
                                    <path d="M12 3v10.55c-.59-.34-1.27-.55-2-.55-2.21 0-4 1.79-4 4s1.79 4 4 4 4-1.79 4-4V7h4V3h-6z"/>
                                </svg>
                            </div>
                            <span class="yt-sidebar-text">Utube Music</span>
                        </a>
                        <a href="/kids" class="yt-sidebar-link" data-page="kids">
                            <div class="yt-sidebar-icon-wrapper">
                                <svg class="yt-sidebar-icon" viewBox="0 0 24 24" fill="currentColor">
                                    <path d="M12.5 2C6.81 2 2 6.81 2 12.5S6.81 23 12.5 23 23 18.19 23 12.5 18.19 2 12.5 2zm0 20c-4.41 0-8-3.59-8-8s3.59-8 8-8 8 3.59 8 8-3.59 8-8 8z"/>
                                    <circle cx="9" cy="10" r="1.5"/>
                                    <circle cx="16" cy="10" r="1.5"/>
                                    <path d="M12 15.5c-1.38 0-2.5-1.12-2.5-2.5h1c0 .83.67 1.5 1.5 1.5s1.5-.67 1.5-1.5h1c0 1.38-1.12 2.5-2.5 2.5z"/>
                                </svg>
                            </div>
                            <span class="yt-sidebar-text">Utube Kids</span>
                        </a>
                    </div>
                    
                    <div class="yt-sidebar-divider"></div>
                    
                    <div class="yt-sidebar-section">
                        <a href="/feed/trending" class="yt-sidebar-link" data-page="trending">
                            <div class="yt-sidebar-icon-wrapper">
                                <svg class="yt-sidebar-icon" viewBox="0 0 24 24" fill="currentColor">
                                    <path d="M16 6l2.29 2.29-4.88 4.88-4-4L2 16.59 3.41 18l6-6 4 4 6.3-6.29L22 12V6z"/>
                                </svg>
                            </div>
                            <span class="yt-sidebar-text">Trending</span>
                        </a>
                        <a href="/gaming" class="yt-sidebar-link" data-page="gaming">
                            <div class="yt-sidebar-icon-wrapper">
                                <svg class="yt-sidebar-icon" viewBox="0 0 24 24" fill="currentColor">
                                    <path d="M15.5 12c0 .83-.67 1.5-1.5 1.5s-1.5-.67-1.5-1.5.67-1.5 1.5-1.5 1.5.67 1.5 1.5zm-2-5C13.5 6.67 12.83 6 12 6s-1.5.67-1.5 1.5S11.17 9 12 9s1.5-.67 1.5-1.5zm5 0C18.5 6.67 17.83 6 17 6s-1.5.67-1.5 1.5S16.17 9 17 9s1.5-.67 1.5-1.5zM21 12c0-4.42-3.58-8-8-8s-8 3.58-8 8 3.58 8 8 8 8-3.58 8-8zm-2 0c0 3.31-2.69 6-6 6s-6-2.69-6-6 2.69-6 6-6 6 2.69 6 6z"/>
                                </svg>
                            </div>
                            <span class="yt-sidebar-text">Gaming</span>
                        </a>
                        <a href="/live" class="yt-sidebar-link" data-page="live">
                            <div class="yt-sidebar-icon-wrapper">
                                <svg class="yt-sidebar-icon" viewBox="0 0 24 24" fill="currentColor">
                                    <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 14.5v-9l6 4.5-6 4.5z"/>
                                </svg>
                            </div>
                            <span class="yt-sidebar-text">Live</span>
                        </a>
                    </div>
                </div>
            `;
            document.body.appendChild(sidebar);
        }
        
        // Enhanced CSS
        if (!document.getElementById('yt-enhanced-sidebar-styles')) {
            const style = document.createElement('style');
            style.id = 'yt-enhanced-sidebar-styles';
            style.textContent = `
                .yt-enhanced-sidebar {
                    position: fixed;
                    top: 0;
                    left: -240px;
                    width: 240px;
                    height: 100vh;
                    background: #0f0f0f;
                    color: #fff;
                    z-index: 10000;
                    transition: left 0.2s cubic-bezier(0.4, 0, 0.2, 1);
                    overflow-y: auto;
                    overflow-x: hidden;
                    box-shadow: 2px 0 8px rgba(0,0,0,0.5);
                }
                .yt-enhanced-sidebar.open {
                    left: 0;
                }
                .yt-sidebar-scroll {
                    padding: 8px 0;
                }
                .yt-sidebar-section {
                    padding: 12px 0;
                }
                .yt-sidebar-link {
                    display: flex;
                    align-items: center;
                    padding: 10px 24px;
                    color: #fff;
                    text-decoration: none;
                    font-size: 14px;
                    transition: background 0.15s;
                    cursor: pointer;
                }
                .yt-sidebar-link:hover {
                    background: #272727;
                }
                .yt-sidebar-link.active {
                    background: #272727;
                    font-weight: 500;
                }
                .yt-sidebar-link.active .yt-sidebar-icon {
                    fill: #fff;
                }
                .yt-sidebar-icon-wrapper {
                    width: 24px;
                    height: 24px;
                    margin-right: 24px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                }
                .yt-sidebar-icon {
                    width: 24px;
                    height: 24px;
                    fill: #909090;
                    transition: fill 0.15s;
                }
                .yt-sidebar-link:hover .yt-sidebar-icon {
                    fill: #fff;
                }
                .yt-sidebar-text {
                    flex: 1;
                }
                .yt-sidebar-divider {
                    height: 1px;
                    background: #272727;
                    margin: 12px 0;
                }
                .yt-sidebar-section-title {
                    padding: 8px 24px;
                    font-size: 14px;
                    font-weight: 500;
                    color: #aaa;
                    text-transform: uppercase;
                    letter-spacing: 0.5px;
                }
                #yt-sidebar-overlay {
                    position: fixed;
                    top: 0;
                    left: 0;
                    width: 100%;
                    height: 100%;
                    background: rgba(0,0,0,0.5);
                    z-index: 9999;
                    display: none;
                    opacity: 0;
                    transition: opacity 0.2s;
                }
                #yt-sidebar-overlay.show {
                    display: block;
                    opacity: 1;
                }
                @media (max-width: 768px) {
                    .yt-enhanced-sidebar {
                        width: 100%;
                        left: -100%;
                    }
                }
                /* Smooth scrollbar */
                .yt-enhanced-sidebar::-webkit-scrollbar {
                    width: 10px;
                }
                .yt-enhanced-sidebar::-webkit-scrollbar-track {
                    background: #0f0f0f;
                }
                .yt-enhanced-sidebar::-webkit-scrollbar-thumb {
                    background: #272727;
                    border-radius: 5px;
                }
                .yt-enhanced-sidebar::-webkit-scrollbar-thumb:hover {
                    background: #3d3d3d;
                }
            `;
            document.head.appendChild(style);
        }
        
        // Overlay
        let overlay = document.getElementById('yt-sidebar-overlay');
        if (!overlay) {
            overlay = document.createElement('div');
            overlay.id = 'yt-sidebar-overlay';
            document.body.appendChild(overlay);
        }
        
        // Functions
        function toggleSidebar() {
            sidebar.classList.toggle('open');
            overlay.classList.toggle('show');
            const isOpen = sidebar.classList.contains('open');
            document.body.style.overflow = isOpen ? 'hidden' : '';
            if (isOpen) {
                sidebar.setAttribute('aria-hidden', 'false');
            } else {
                sidebar.setAttribute('aria-hidden', 'true');
            }
        }
        
        function closeSidebar() {
            sidebar.classList.remove('open');
            overlay.classList.remove('show');
            document.body.style.overflow = '';
            sidebar.setAttribute('aria-hidden', 'true');
        }
        
        // Event listeners
        if (hamburgerBtn) {
            hamburgerBtn.addEventListener('click', function(e) {
                e.preventDefault();
                e.stopPropagation();
                toggleSidebar();
            });
        }
        
        overlay.addEventListener('click', closeSidebar);
        
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape' && sidebar.classList.contains('open')) {
                closeSidebar();
            }
        });
        
        // Handle active states
        const links = sidebar.querySelectorAll('.yt-sidebar-link');
        links.forEach(link => {
            link.addEventListener('click', function(e) {
                links.forEach(l => l.classList.remove('active'));
                this.classList.add('active');
            });
        });
        
        // Set initial state
        sidebar.setAttribute('aria-hidden', 'true');
    }
    
    // Initialize
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initEnhancedHamburgerMenu);
    } else {
        initEnhancedHamburgerMenu();
    }
    
    setTimeout(initEnhancedHamburgerMenu, 500);
    setTimeout(initEnhancedHamburgerMenu, 2000);
})();
</script>
'@

# Remove old script and add enhanced one
if ($content -match '<script>[\s\S]*?initHamburgerMenu[\s\S]*?</script>') {
    $newContent = $content -replace '<script>[\s\S]*?initHamburgerMenu[\s\S]*?</script>', $enhancedScript
} elseif ($content -match '</body>') {
    $newContent = $content -replace '</body>', ($enhancedScript + "`n</body>")
} else {
    $newContent = $content + $enhancedScript
}

$newContent | Set-Content $filePath -NoNewline
Write-Host "Enhanced hamburger menu with YouTube-like features added!"

