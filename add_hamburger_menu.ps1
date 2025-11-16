$filePath = 'c:\Users\Elizabeth\Downloads\index.html'
$content = Get-Content $filePath -Raw

# JavaScript for hamburger menu functionality
$hamburgerScript = @'
<script>
(function() {
    // Wait for DOM to be ready
    function initHamburgerMenu() {
        // Find or create hamburger button
        let hamburgerBtn = document.querySelector('button[aria-label*="Menu"], button[aria-label*="Guide"], ytd-masthead button, [class*="guide-icon"], [class*="menu-icon"]');
        
        if (!hamburgerBtn) {
            // Try to find by icon
            hamburgerBtn = document.querySelector('yt-icon[class*="guide"], yt-icon-button[class*="guide"]');
            if (hamburgerBtn) {
                hamburgerBtn = hamburgerBtn.closest('button') || hamburgerBtn.parentElement;
            }
        }
        
        // Create sidebar if it doesn't exist
        let sidebar = document.getElementById('yt-sidebar-menu');
        if (!sidebar) {
            sidebar = document.createElement('div');
            sidebar.id = 'yt-sidebar-menu';
            sidebar.className = 'yt-sidebar-menu';
            sidebar.innerHTML = `
                <div class="yt-sidebar-header">
                    <button class="yt-sidebar-close" aria-label="Close menu">✕</button>
                </div>
                <div class="yt-sidebar-content">
                    <a href="/" class="yt-sidebar-item yt-sidebar-item-active">
                        <span class="yt-sidebar-icon">🏠</span>
                        <span>Home</span>
                    </a>
                    <a href="/feed/explore" class="yt-sidebar-item">
                        <span class="yt-sidebar-icon">🔥</span>
                        <span>Explore</span>
                    </a>
                    <a href="/feed/subscriptions" class="yt-sidebar-item">
                        <span class="yt-sidebar-icon">📺</span>
                        <span>Subscriptions</span>
                    </a>
                    <a href="/feed/library" class="yt-sidebar-item">
                        <span class="yt-sidebar-icon">📚</span>
                        <span>Library</span>
                    </a>
                    <a href="/feed/history" class="yt-sidebar-item">
                        <span class="yt-sidebar-icon">🕐</span>
                        <span>History</span>
                    </a>
                    <div class="yt-sidebar-divider"></div>
                    <a href="/premium" class="yt-sidebar-item">
                        <span class="yt-sidebar-icon">⭐</span>
                        <span>Utube Premium</span>
                    </a>
                    <a href="/music" class="yt-sidebar-item">
                        <span class="yt-sidebar-icon">🎵</span>
                        <span>Utube Music</span>
                    </a>
                    <a href="/kids" class="yt-sidebar-item">
                        <span class="yt-sidebar-icon">👶</span>
                        <span>Utube Kids</span>
                    </a>
                    <div class="yt-sidebar-divider"></div>
                    <a href="/feed/trending" class="yt-sidebar-item">
                        <span class="yt-sidebar-icon">📈</span>
                        <span>Trending</span>
                    </a>
                    <a href="/gaming" class="yt-sidebar-item">
                        <span class="yt-sidebar-icon">🎮</span>
                        <span>Gaming</span>
                    </a>
                    <a href="/live" class="yt-sidebar-item">
                        <span class="yt-sidebar-icon">📡</span>
                        <span>Live</span>
                    </a>
                    <div class="yt-sidebar-divider"></div>
                    <a href="/feed/channels" class="yt-sidebar-item">
                        <span class="yt-sidebar-icon">📺</span>
                        <span>Channels</span>
                    </a>
                    <a href="/playlist?list=WL" class="yt-sidebar-item">
                        <span class="yt-sidebar-icon">📋</span>
                        <span>Watch later</span>
                    </a>
                    <a href="/playlist?list=LL" class="yt-sidebar-item">
                        <span class="yt-sidebar-icon">👍</span>
                        <span>Liked videos</span>
                    </a>
                </div>
            `;
            document.body.appendChild(sidebar);
        }
        
        // Add CSS if not already added
        if (!document.getElementById('yt-hamburger-menu-styles')) {
            const style = document.createElement('style');
            style.id = 'yt-hamburger-menu-styles';
            style.textContent = `
                .yt-sidebar-menu {
                    position: fixed;
                    top: 0;
                    left: -240px;
                    width: 240px;
                    height: 100vh;
                    background: #0f0f0f;
                    color: #fff;
                    z-index: 10000;
                    transition: left 0.3s ease;
                    overflow-y: auto;
                    box-shadow: 2px 0 8px rgba(0,0,0,0.3);
                }
                .yt-sidebar-menu.open {
                    left: 0;
                }
                .yt-sidebar-overlay {
                    position: fixed;
                    top: 0;
                    left: 0;
                    width: 100%;
                    height: 100%;
                    background: rgba(0,0,0,0.5);
                    z-index: 9999;
                    display: none;
                }
                .yt-sidebar-overlay.show {
                    display: block;
                }
                .yt-sidebar-header {
                    padding: 16px;
                    display: flex;
                    justify-content: flex-end;
                    border-bottom: 1px solid #272727;
                }
                .yt-sidebar-close {
                    background: none;
                    border: none;
                    color: #fff;
                    font-size: 24px;
                    cursor: pointer;
                    padding: 0;
                    width: 32px;
                    height: 32px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                }
                .yt-sidebar-close:hover {
                    background: #272727;
                    border-radius: 50%;
                }
                .yt-sidebar-content {
                    padding: 8px 0;
                }
                .yt-sidebar-item {
                    display: flex;
                    align-items: center;
                    padding: 10px 24px;
                    color: #fff;
                    text-decoration: none;
                    font-size: 14px;
                    transition: background 0.2s;
                }
                .yt-sidebar-item:hover {
                    background: #272727;
                }
                .yt-sidebar-item-active {
                    background: #272727;
                    font-weight: 500;
                }
                .yt-sidebar-icon {
                    margin-right: 24px;
                    width: 24px;
                    text-align: center;
                    font-size: 20px;
                }
                .yt-sidebar-divider {
                    height: 1px;
                    background: #272727;
                    margin: 12px 0;
                }
                @media (max-width: 768px) {
                    .yt-sidebar-menu {
                        width: 100%;
                        left: -100%;
                    }
                }
            `;
            document.head.appendChild(style);
        }
        
        // Create overlay
        let overlay = document.getElementById('yt-sidebar-overlay');
        if (!overlay) {
            overlay = document.createElement('div');
            overlay.id = 'yt-sidebar-overlay';
            overlay.className = 'yt-sidebar-overlay';
            document.body.appendChild(overlay);
        }
        
        // Toggle sidebar function
        function toggleSidebar() {
            sidebar.classList.toggle('open');
            overlay.classList.toggle('show');
            document.body.style.overflow = sidebar.classList.contains('open') ? 'hidden' : '';
        }
        
        // Close sidebar function
        function closeSidebar() {
            sidebar.classList.remove('open');
            overlay.classList.remove('show');
            document.body.style.overflow = '';
        }
        
        // Add event listeners
        if (hamburgerBtn) {
            hamburgerBtn.addEventListener('click', function(e) {
                e.preventDefault();
                e.stopPropagation();
                toggleSidebar();
            });
        }
        
        // Close button
        const closeBtn = sidebar.querySelector('.yt-sidebar-close');
        if (closeBtn) {
            closeBtn.addEventListener('click', closeSidebar);
        }
        
        // Overlay click to close
        overlay.addEventListener('click', closeSidebar);
        
        // Close on escape key
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape' && sidebar.classList.contains('open')) {
                closeSidebar();
            }
        });
        
        // Handle sidebar item clicks
        const sidebarItems = sidebar.querySelectorAll('.yt-sidebar-item');
        sidebarItems.forEach(item => {
            item.addEventListener('click', function(e) {
                // Remove active class from all items
                sidebarItems.forEach(i => i.classList.remove('yt-sidebar-item-active'));
                // Add active class to clicked item
                this.classList.add('yt-sidebar-item-active');
            });
        });
    }
    
    // Initialize when DOM is ready
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initHamburgerMenu);
    } else {
        initHamburgerMenu();
    }
    
    // Also try after a short delay in case elements load dynamically
    setTimeout(initHamburgerMenu, 500);
    setTimeout(initHamburgerMenu, 2000);
})();
</script>
'@

# Insert the script before closing body tag
if ($content -match '</body>') {
    $newContent = $content -replace '</body>', ($hamburgerScript + "`n</body>")
    $newContent | Set-Content $filePath -NoNewline
    Write-Host "SUCCESS: Hamburger menu functionality added!"
} else {
    # If no body tag, append to end
    $newContent = $content + $hamburgerScript
    $newContent | Set-Content $filePath -NoNewline
    Write-Host "SUCCESS: Hamburger menu functionality added (appended to end)!"
}

