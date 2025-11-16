$filePath = 'c:\Users\Elizabeth\Downloads\index.html'
$content = Get-Content $filePath -Raw

Write-Host "=== Creating YouTube-Style Navigation Bar ===" -ForegroundColor Cyan
Write-Host ""

# Complete Navigation Bar System
$navigationBar = @'
<!-- YouTube-Style Navigation Bar -->
<header id="yt-header" style="position: fixed; top: 0; left: 0; width: 100%; height: 56px; background: #0f0f0f; z-index: 1000; display: flex; align-items: center; padding: 0 16px; box-shadow: 0 2px 4px rgba(0,0,0,0.2);">
    <!-- Left Section: Hamburger + Logo -->
    <div style="display: flex; align-items: center; min-width: 140px;">
        <button id="nav-hamburger" style="background: none; border: none; color: #fff; padding: 8px; margin-right: 16px; cursor: pointer; border-radius: 50%; display: flex; align-items: center; justify-content: center;" aria-label="Menu">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor">
                <path d="M3 18h18v-2H3v2zm0-5h18v-2H3v2zm0-7v2h18V6H3z"/>
            </svg>
        </button>
        <a href="/" style="display: flex; align-items: center; text-decoration: none; color: #fff;">
            <span style="font-size: 20px; font-weight: 400; letter-spacing: -0.5px;">Utube</span>
        </a>
    </div>
    
    <!-- Center Section: Search Bar -->
    <div style="flex: 1; max-width: 640px; margin: 0 40px; display: flex; align-items: center;">
        <form id="search-form" style="display: flex; width: 100%;">
            <input 
                type="text" 
                id="search-input" 
                placeholder="Search" 
                style="flex: 1; height: 40px; padding: 0 16px; background: #121212; border: 1px solid #303030; border-right: none; color: #fff; font-size: 16px; border-radius: 40px 0 0 40px; outline: none;"
                autocomplete="off"
            >
            <button 
                type="submit" 
                id="search-button"
                style="width: 64px; height: 40px; background: #222; border: 1px solid #303030; border-left: none; border-radius: 0 40px 40px 0; cursor: pointer; display: flex; align-items: center; justify-content: center;"
                aria-label="Search"
            >
                <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor" style="color: #fff;">
                    <path d="M15.5 14h-.79l-.28-.27C15.41 12.59 16 11.11 16 9.5 16 5.91 13.09 3 9.5 3S3 5.91 3 9.5 5.91 16 9.5 16c1.61 0 3.09-.59 4.23-1.57l.27.28v.79l5 4.99L20.49 19l-4.99-5zm-6 0C7.01 14 5 11.99 5 9.5S7.01 5 9.5 5 14 7.01 14 9.5 11.99 14 9.5 14z"/>
                </svg>
            </button>
        </form>
    </div>
    
    <!-- Right Section: User Actions -->
    <div style="display: flex; align-items: center; gap: 8px; min-width: 140px; justify-content: flex-end;">
        <button id="nav-create" style="background: none; border: none; color: #fff; padding: 8px; cursor: pointer; border-radius: 50%;" aria-label="Create" title="Create">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor">
                <path d="M14 13h-3v3H9v-3H6v-2h3V8h2v3h3v2zm3-7H3v12h14v-12zm0-2H3c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2z"/>
            </svg>
        </button>
        <button id="nav-notifications" style="background: none; border: none; color: #fff; padding: 8px; cursor: pointer; border-radius: 50%; position: relative;" aria-label="Notifications" title="Notifications">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor">
                <path d="M10 20h4c0 1.1-.9 2-2 2s-2-.9-2-2zm9-5.5c-.83 0-1.5-.67-1.5-1.5 0-4-3.5-7.5-7.5-7.5S1.5 8 1.5 12c0 .83-.67 1.5-1.5 1.5S-1.5 12.83-1.5 12c0-5.24 4.26-9.5 9.5-9.5S17.5 6.76 17.5 12c0 .83-.67 1.5-1.5 1.5z"/>
            </svg>
        </button>
        <button id="nav-profile" style="background: #065fd4; border: none; color: #fff; width: 32px; height: 32px; border-radius: 50%; cursor: pointer; font-weight: 500; display: flex; align-items: center; justify-content: center;" aria-label="Profile" title="Profile">U</button>
    </div>
</header>

<!-- Sidebar Navigation -->
<aside id="yt-sidebar" style="position: fixed; left: -240px; top: 56px; width: 240px; height: calc(100vh - 56px); background: #0f0f0f; transition: left 0.2s; z-index: 999; overflow-y: auto;">
    <nav style="padding: 12px 0;">
        <!-- Main Navigation -->
        <div class="nav-section">
            <a href="#" data-page="home" class="nav-item active">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor"><path d="M10 20v-6h4v6h5v-8h3L12 3 2 12h3v8z"/></svg>
                <span>Home</span>
            </a>
            <a href="#" data-page="trending" class="nav-item">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor"><path d="M17.53 11.2c-.23-.3-.5-.56-.76-.82L19.77 4l-1.5-1.5-3.18 3.18c-.24-.13-.5-.24-.77-.32-.28-.09-.55-.15-.82-.15-.27 0-.54.06-.82.15-.27.08-.53.19-.77.32L6.73 2.5 5.23 4l3.18 3.18c-.26.26-.53.52-.76.82-.23.3-.42.62-.57.96-.15.34-.25.7-.3 1.06-.05.37-.05.74 0 1.11.05.37.15.72.3 1.06.15.34.34.66.57.96.23.3.5.56.76.82L5.23 20l1.5 1.5 3.18-3.18c.24.13.5.24.77.32.28.09.55.15.82.15.27 0 .54-.06.82-.15.27-.08.53-.19.77-.32L18.27 21.5l1.5-1.5-3.18-3.18c.26-.26.53-.52.76-.82.23-.3.42-.62.57-.96.15-.34.25-.7.3-1.06.05-.37.05-.74 0-1.11-.05-.37-.15-.72-.3-1.06-.15-.34-.34-.66-.57-.96zm-10.03 3.8c0-.83.67-1.5 1.5-1.5s1.5.67 1.5 1.5-.67 1.5-1.5 1.5-1.5-.67-1.5-1.5zm11.03-6c-.83 0-1.5-.67-1.5-1.5s.67-1.5 1.5-1.5 1.5.67 1.5 1.5-.67 1.5-1.5 1.5z"/></svg>
                <span>Trending</span>
            </a>
            <a href="#" data-page="subscriptions" class="nav-item">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor"><path d="M18.7 8.7H5.3V7h13.4v1.7zm-1.7-5H7v1.6h10V3.7zm1.7 8.3v7c0 1-.7 1.7-1.7 1.7H7c-1 0-1.7-.7-1.7-1.7v-7h14.4zm0-1.7H5.3c-1 0-1.7.7-1.7 1.7V21c0 1 .7 1.7 1.7 1.7h10c1 0 1.7-.7 1.7-1.7v-9.3c0-1-.7-1.7-1.7-1.7z"/></svg>
                <span>Subscriptions</span>
            </a>
        </div>
        
        <div class="nav-divider"></div>
        
        <!-- Library Section -->
        <div class="nav-section">
            <a href="#" data-page="library" class="nav-item">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor"><path d="M4 6H2v14c0 1.1.9 2 2 2h14v-2H4V6zm16-4H8c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zm-1 9H9V9h10v2zm-4-4H9V5h6v2z"/></svg>
                <span>Library</span>
            </a>
            <a href="#" data-page="history" class="nav-item">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor"><path d="M13 3c-4.97 0-9 4.03-9 9H1l3.89 3.89.07.14L9 12H6c0-3.87 3.13-7 7-7s7 3.13 7 7-3.13 7-7 7c-1.93 0-3.68-.79-4.94-2.06l-1.42 1.42C8.27 19.99 10.51 21 13 21c4.97 0 9-4.03 9-9s-4.03-9-9-9zm-1 5v5l4.28 2.54.72-1.21-3.5-2.08V8H12z"/></svg>
                <span>History</span>
            </a>
            <a href="#" data-page="watch-later" class="nav-item">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor"><path d="M12 4.5C7 4.5 2.73 7.61 1 12c1.73 4.39 6 7.5 11 7.5s9.27-3.11 11-7.5c-1.73-4.39-6-7.5-11-7.5zM12 17c-2.76 0-5-2.24-5-5s2.24-5 5-5 5 2.24 5 5-2.24 5-5 5zm0-8c-1.66 0-3 1.34-3 3s1.34 3 3 3 3-1.34 3-3-1.34-3-3-3z"/></svg>
                <span>Watch later</span>
            </a>
            <a href="#" data-page="liked" class="nav-item">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor"><path d="M1 21h4V9H1v12zm22-11c0-1.1-.9-2-2-2h-6.31l.95-4.57.03-.32c0-.41-.17-.79-.44-1.06L14.17 1 7.59 7.59C7.22 7.95 7 8.45 7 9v10c0 1.1.9 2 2 2h9c.83 0 1.54-.5 1.84-1.22l3.02-7.05c.09-.23.14-.47.14-.73v-2z"/></svg>
                <span>Liked videos</span>
            </a>
            <a href="#" data-page="playlists" class="nav-item">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor"><path d="M15 6H3v2h12V6zm0 4H3v2h12v-2zM3 16h8v-2H3v2zM17 6v14l7-7-7-7z"/></svg>
                <span>Playlists</span>
            </a>
        </div>
    </nav>
</aside>

<!-- Overlay for sidebar -->
<div id="sidebar-overlay" style="position: fixed; top: 56px; left: 0; width: 100%; height: calc(100vh - 56px); background: rgba(0,0,0,0.5); z-index: 998; display: none;"></div>

<style>
/* Navigation Styles */
#yt-header {
    font-family: 'Roboto', 'Arial', sans-serif;
}

#yt-sidebar {
    font-family: 'Roboto', 'Arial', sans-serif;
}

#yt-sidebar.open {
    left: 0;
}

.nav-section {
    padding: 12px 0;
}

.nav-item {
    display: flex;
    align-items: center;
    padding: 10px 24px;
    color: #fff;
    text-decoration: none;
    font-size: 14px;
    transition: background 0.15s;
    cursor: pointer;
}

.nav-item:hover {
    background: #272727;
}

.nav-item.active {
    background: #272727;
    font-weight: 500;
}

.nav-item svg {
    width: 24px;
    height: 24px;
    margin-right: 24px;
    fill: #909090;
}

.nav-item.active svg {
    fill: #fff;
}

.nav-item:hover svg {
    fill: #fff;
}

.nav-divider {
    height: 1px;
    background: #272727;
    margin: 12px 0;
}

#sidebar-overlay.show {
    display: block;
}

/* Main content padding for header */
body {
    padding-top: 56px;
}

/* Scrollbar for sidebar */
#yt-sidebar::-webkit-scrollbar {
    width: 10px;
}

#yt-sidebar::-webkit-scrollbar-track {
    background: #0f0f0f;
}

#yt-sidebar::-webkit-scrollbar-thumb {
    background: #272727;
    border-radius: 5px;
}

#yt-sidebar::-webkit-scrollbar-thumb:hover {
    background: #3d3d3d;
}

/* Search input focus */
#search-input:focus {
    border-color: #1c62b9;
}

#search-button:hover {
    background: #303030;
}

#nav-hamburger:hover,
#nav-create:hover,
#nav-notifications:hover {
    background: #272727;
}
</style>

<script>
// Navigation System with Local Storage
(function() {
    // Local Storage Manager
    const StorageManager = {
        // Watch History
        getHistory: function() {
            const history = localStorage.getItem('yt_watch_history');
            return history ? JSON.parse(history) : [];
        },
        addToHistory: function(video) {
            const history = this.getHistory();
            // Remove if already exists (to move to top)
            const filtered = history.filter(h => h.id !== video.id);
            // Add to beginning
            filtered.unshift({
                ...video,
                watchedAt: new Date().toISOString()
            });
            // Keep only last 100
            const limited = filtered.slice(0, 100);
            localStorage.setItem('yt_watch_history', JSON.stringify(limited));
        },
        clearHistory: function() {
            localStorage.removeItem('yt_watch_history');
        },
        
        // Watch Later
        getWatchLater: function() {
            const list = localStorage.getItem('yt_watch_later');
            return list ? JSON.parse(list) : [];
        },
        addToWatchLater: function(video) {
            const list = this.getWatchLater();
            if (!list.find(v => v.id === video.id)) {
                list.push({
                    ...video,
                    addedAt: new Date().toISOString()
                });
                localStorage.setItem('yt_watch_later', JSON.stringify(list));
            }
        },
        removeFromWatchLater: function(videoId) {
            const list = this.getWatchLater();
            const filtered = list.filter(v => v.id !== videoId);
            localStorage.setItem('yt_watch_later', JSON.stringify(filtered));
        },
        
        // Liked Videos
        getLiked: function() {
            const liked = localStorage.getItem('yt_liked_videos');
            return liked ? JSON.parse(liked) : [];
        },
        addToLiked: function(video) {
            const liked = this.getLiked();
            if (!liked.find(v => v.id === video.id)) {
                liked.push({
                    ...video,
                    likedAt: new Date().toISOString()
                });
                localStorage.setItem('yt_liked_videos', JSON.stringify(liked));
            }
        },
        removeFromLiked: function(videoId) {
            const liked = this.getLiked();
            const filtered = liked.filter(v => v.id !== videoId);
            localStorage.setItem('yt_liked_videos', JSON.stringify(filtered));
        },
        isLiked: function(videoId) {
            return this.getLiked().some(v => v.id === videoId);
        },
        
        // Playlists
        getPlaylists: function() {
            const playlists = localStorage.getItem('yt_playlists');
            return playlists ? JSON.parse(playlists) : [];
        },
        createPlaylist: function(name) {
            const playlists = this.getPlaylists();
            const newPlaylist = {
                id: Date.now().toString(),
                name: name,
                videos: [],
                createdAt: new Date().toISOString()
            };
            playlists.push(newPlaylist);
            localStorage.setItem('yt_playlists', JSON.stringify(playlists));
            return newPlaylist;
        },
        addToPlaylist: function(playlistId, video) {
            const playlists = this.getPlaylists();
            const playlist = playlists.find(p => p.id === playlistId);
            if (playlist && !playlist.videos.find(v => v.id === video.id)) {
                playlist.videos.push({
                    ...video,
                    addedAt: new Date().toISOString()
                });
                localStorage.setItem('yt_playlists', JSON.stringify(playlists));
            }
        },
        removeFromPlaylist: function(playlistId, videoId) {
            const playlists = this.getPlaylists();
            const playlist = playlists.find(p => p.id === playlistId);
            if (playlist) {
                playlist.videos = playlist.videos.filter(v => v.id !== videoId);
                localStorage.setItem('yt_playlists', JSON.stringify(playlists));
            }
        },
        deletePlaylist: function(playlistId) {
            const playlists = this.getPlaylists();
            const filtered = playlists.filter(p => p.id !== playlistId);
            localStorage.setItem('yt_playlists', JSON.stringify(filtered));
        }
    };
    
    // Make StorageManager globally available
    window.StorageManager = StorageManager;
    
    // Sidebar Toggle
    const hamburger = document.getElementById('nav-hamburger');
    const sidebar = document.getElementById('yt-sidebar');
    const overlay = document.getElementById('sidebar-overlay');
    
    function toggleSidebar() {
        sidebar.classList.toggle('open');
        overlay.classList.toggle('show');
    }
    
    if (hamburger) {
        hamburger.addEventListener('click', toggleSidebar);
    }
    
    if (overlay) {
        overlay.addEventListener('click', toggleSidebar);
    }
    
    // Navigation Item Click Handler
    const navItems = document.querySelectorAll('.nav-item');
    navItems.forEach(item => {
        item.addEventListener('click', function(e) {
            e.preventDefault();
            const page = this.getAttribute('data-page');
            
            // Update active state
            navItems.forEach(nav => nav.classList.remove('active'));
            this.classList.add('active');
            
            // Close sidebar on mobile
            if (window.innerWidth < 768) {
                toggleSidebar();
            }
            
            // Navigate to page
            navigateToPage(page);
        });
    });
    
    // Page Navigation
    function navigateToPage(page) {
        const container = document.getElementById('video-container');
        if (!container) return;
        
        switch(page) {
            case 'home':
                loadHomePage();
                break;
            case 'history':
                loadHistoryPage();
                break;
            case 'watch-later':
                loadWatchLaterPage();
                break;
            case 'liked':
                loadLikedPage();
                break;
            case 'playlists':
                loadPlaylistsPage();
                break;
            case 'trending':
                loadTrendingPage();
                break;
            case 'subscriptions':
                loadSubscriptionsPage();
                break;
            case 'library':
                loadLibraryPage();
                break;
            default:
                loadHomePage();
        }
    }
    
    // Page Loaders
    function loadHomePage() {
        const videoGrid = document.getElementById('video-grid');
        if (videoGrid && typeof loadVideosFromAPI === 'function') {
            loadVideosFromAPI();
        }
    }
    
    function loadHistoryPage() {
        const history = StorageManager.getHistory();
        displayVideosList(history, 'Watch History', 'No watch history yet');
    }
    
    function loadWatchLaterPage() {
        const watchLater = StorageManager.getWatchLater();
        displayVideosList(watchLater, 'Watch Later', 'No videos in watch later');
    }
    
    function loadLikedPage() {
        const liked = StorageManager.getLiked();
        displayVideosList(liked, 'Liked Videos', 'No liked videos yet');
    }
    
    function loadPlaylistsPage() {
        const playlists = StorageManager.getPlaylists();
        const container = document.getElementById('video-container');
        if (!container) return;
        
        let html = '<div style="padding: 20px; max-width: 1400px; margin: 0 auto;"><h1 style="color: #fff; margin-bottom: 20px;">Playlists</h1>';
        
        if (playlists.length === 0) {
            html += '<p style="color: #aaa;">No playlists yet. Create one by clicking the + button on any video.</p>';
        } else {
            playlists.forEach(playlist => {
                html += `
                    <div style="background: #1a1a1a; border-radius: 12px; padding: 20px; margin-bottom: 20px;">
                        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px;">
                            <h2 style="color: #fff; margin: 0;">${playlist.name}</h2>
                            <button onclick="deletePlaylist('${playlist.id}')" style="background: #ff0000; color: white; border: none; padding: 8px 16px; border-radius: 4px; cursor: pointer;">Delete</button>
                        </div>
                        <div id="playlist-${playlist.id}" style="display: grid; grid-template-columns: repeat(auto-fill, minmax(200px, 1fr)); gap: 16px;">
                            ${playlist.videos.map(v => createVideoCard(v)).join('')}
                        </div>
                    </div>
                `;
            });
        }
        
        html += '</div>';
        container.innerHTML = html;
    }
    
    function loadTrendingPage() {
        if (window.YouTubeAPI) {
            window.YouTubeAPI.getTrendingVideos('US', 24).then(response => {
                if (response && response.items) {
                    displayVideosList(response.items, 'Trending', 'No trending videos');
                }
            });
        }
    }
    
    function loadSubscriptionsPage() {
        displayVideosList([], 'Subscriptions', 'No subscriptions yet');
    }
    
    function loadLibraryPage() {
        const container = document.getElementById('video-container');
        if (!container) return;
        
        const history = StorageManager.getHistory();
        const watchLater = StorageManager.getWatchLater();
        const liked = StorageManager.getLiked();
        const playlists = StorageManager.getPlaylists();
        
        container.innerHTML = `
            <div style="padding: 20px; max-width: 1400px; margin: 0 auto;">
                <h1 style="color: #fff; margin-bottom: 30px;">Library</h1>
                <div style="display: grid; grid-template-columns: repeat(auto-fill, minmax(250px, 1fr)); gap: 20px;">
                    <div style="background: #1a1a1a; border-radius: 12px; padding: 20px; cursor: pointer;" onclick="navigateToPage('history')">
                        <h3 style="color: #fff; margin: 0 0 10px 0;">Watch History</h3>
                        <p style="color: #aaa; margin: 0;">${history.length} videos</p>
                    </div>
                    <div style="background: #1a1a1a; border-radius: 12px; padding: 20px; cursor: pointer;" onclick="navigateToPage('watch-later')">
                        <h3 style="color: #fff; margin: 0 0 10px 0;">Watch Later</h3>
                        <p style="color: #aaa; margin: 0;">${watchLater.length} videos</p>
                    </div>
                    <div style="background: #1a1a1a; border-radius: 12px; padding: 20px; cursor: pointer;" onclick="navigateToPage('liked')">
                        <h3 style="color: #fff; margin: 0 0 10px 0;">Liked Videos</h3>
                        <p style="color: #aaa; margin: 0;">${liked.length} videos</p>
                    </div>
                    <div style="background: #1a1a1a; border-radius: 12px; padding: 20px; cursor: pointer;" onclick="navigateToPage('playlists')">
                        <h3 style="color: #fff; margin: 0 0 10px 0;">Playlists</h3>
                        <p style="color: #aaa; margin: 0;">${playlists.length} playlists</p>
                    </div>
                </div>
            </div>
        `;
    }
    
    // Display videos list
    function displayVideosList(videos, title, emptyMessage) {
        const container = document.getElementById('video-container');
        if (!container) return;
        
        let html = '<div style="padding: 20px; max-width: 1400px; margin: 0 auto;">';
        html += `<h1 style="color: #fff; margin-bottom: 20px;">${title}</h1>`;
        
        if (videos.length === 0) {
            html += `<p style="color: #aaa;">${emptyMessage}</p>`;
        } else {
            html += '<div id="video-grid" style="display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 20px;">';
            videos.forEach(video => {
                const videoData = video.id ? video : {
                    id: video.id || video.snippet?.resourceId?.videoId,
                    title: video.title || video.snippet?.title,
                    thumbnail: video.thumbnail || video.snippet?.thumbnails?.high?.url,
                    channel: video.channel || video.snippet?.channelTitle,
                    views: video.views || formatViews(video.statistics?.viewCount || '0')
                };
                html += createVideoCard(videoData);
            });
            html += '</div>';
        }
        
        html += '</div>';
        container.innerHTML = html;
    }
    
    // Make navigateToPage globally available
    window.navigateToPage = navigateToPage;
    
    // Make deletePlaylist globally available
    window.deletePlaylist = function(playlistId) {
        if (confirm('Are you sure you want to delete this playlist?')) {
            StorageManager.deletePlaylist(playlistId);
            loadPlaylistsPage();
        }
    };
    
    // Search functionality
    const searchForm = document.getElementById('search-form');
    const searchInput = document.getElementById('search-input');
    
    if (searchForm) {
        searchForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const query = searchInput.value.trim();
            if (query && window.YouTubeAPI) {
                window.YouTubeAPI.searchVideos(query, 24).then(response => {
                    if (response && response.items) {
                        displayVideosList(response.items, 'Search Results', 'No results found');
                    }
                });
            }
        });
    }
    
    // Update playVideo to add to history
    const originalPlayVideo = window.playVideo;
    if (originalPlayVideo) {
        window.playVideo = function(videoId, videoData) {
            if (videoData) {
                StorageManager.addToHistory(videoData);
            }
            originalPlayVideo(videoId);
        };
    }
    
    // Initialize - load home page
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', function() {
            setTimeout(loadHomePage, 500);
        });
    } else {
        setTimeout(loadHomePage, 500);
    }
})();
</script>
'@

# Insert navigation bar right after opening body tag
if ($content -match '<body[^>]*>') {
    $content = $content -replace '(<body[^>]*>)', "`$1`n$navigationBar"
    Write-Host "Added navigation bar after body tag" -ForegroundColor Green
} else {
    # If no body tag, try to find where to insert
    if ($content -match '<html') {
        $content = $content -replace '(<html[^>]*>)', "`$1`n$navigationBar"
        Write-Host "Added navigation bar after html tag" -ForegroundColor Green
    } else {
        $content = $navigationBar + "`n" + $content
        Write-Host "Added navigation bar at beginning" -ForegroundColor Green
    }
}

$content | Set-Content $filePath -NoNewline -Encoding UTF8
Write-Host "`n✅ Navigation bar with local storage added!" -ForegroundColor Green
Write-Host "Features:" -ForegroundColor Cyan
Write-Host "  - Home, Trending, Subscriptions" -ForegroundColor Yellow
Write-Host "  - Watch History (saved locally)" -ForegroundColor Yellow
Write-Host "  - Watch Later (saved locally)" -ForegroundColor Yellow
Write-Host "  - Liked Videos (saved locally)" -ForegroundColor Yellow
Write-Host "  - Playlists (saved locally)" -ForegroundColor Yellow
Write-Host "  - Search functionality" -ForegroundColor Yellow

