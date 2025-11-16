$filePath = 'c:\Users\Elizabeth\Downloads\index.html'
$content = Get-Content $filePath -Raw

Write-Host "Adding video action buttons (Like, Watch Later, etc.)..." -ForegroundColor Cyan

# Enhanced video card with action buttons
$videoActionsScript = @'
<script>
// Enhanced Video Actions
(function() {
    // Override createVideoCard to include action buttons
    const originalCreateVideoCard = window.createVideoCard;
    
    window.createVideoCard = function(video) {
        const isLiked = window.StorageManager && window.StorageManager.isLiked(video.id);
        const likedClass = isLiked ? 'liked' : '';
        
        return `
            <div class="video-card" style="cursor: pointer; background: #1a1a1a; border-radius: 12px; overflow: hidden; transition: transform 0.2s; position: relative;" onmouseenter="showVideoActions(this)" onmouseleave="hideVideoActions(this)">
                <div class="video-thumbnail" style="position: relative; width: 100%; padding-bottom: 56.25%; background: #000;" onclick="playVideoWithHistory('${video.id}', ${JSON.stringify(video).replace(/"/g, '&quot;')})">
                    <img src="${video.thumbnail}" alt="${video.title}" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; object-fit: cover;" onerror="this.src='https://via.placeholder.com/320x180?text=Video'">
                    <div class="video-duration" style="position: absolute; bottom: 8px; right: 8px; background: rgba(0,0,0,0.8); color: white; padding: 2px 6px; border-radius: 4px; font-size: 12px; font-weight: 500;">${video.duration || 'N/A'}</div>
                </div>
                <div class="video-info" style="padding: 12px;">
                    <h3 class="video-title" style="color: #fff; font-size: 14px; font-weight: 500; margin: 0 0 8px 0; line-height: 1.4; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">${video.title}</h3>
                    <div class="video-meta" style="color: #aaa; font-size: 12px;">
                        <div>${video.channel || 'Unknown'}</div>
                        <div>${video.views || '0 views'}</div>
                    </div>
                </div>
                <div class="video-actions" style="position: absolute; top: 8px; right: 8px; display: none; gap: 4px; flex-direction: column;">
                    <button onclick="event.stopPropagation(); toggleLike('${video.id}', ${JSON.stringify(video).replace(/"/g, '&quot;')})" class="action-btn ${likedClass}" title="Like">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
                            <path d="M1 21h4V9H1v12zm22-11c0-1.1-.9-2-2-2h-6.31l.95-4.57.03-.32c0-.41-.17-.79-.44-1.06L14.17 1 7.59 7.59C7.22 7.95 7 8.45 7 9v10c0 1.1.9 2 2 2h9c.83 0 1.54-.5 1.84-1.22l3.02-7.05c.09-.23.14-.47.14-.73v-2z"/>
                        </svg>
                    </button>
                    <button onclick="event.stopPropagation(); addToWatchLater(${JSON.stringify(video).replace(/"/g, '&quot;')})" class="action-btn" title="Watch Later">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
                            <path d="M12 4.5C7 4.5 2.73 7.61 1 12c1.73 4.39 6 7.5 11 7.5s9.27-3.11 11-7.5c-1.73-4.39-6-7.5-11-7.5zM12 17c-2.76 0-5-2.24-5-5s2.24-5 5-5 5 2.24 5 5-2.24 5-5 5zm0-8c-1.66 0-3 1.34-3 3s1.34 3 3 3 3-1.34 3-3-1.34-3-3-3z"/>
                        </svg>
                    </button>
                    <button onclick="event.stopPropagation(); showPlaylistMenu('${video.id}', ${JSON.stringify(video).replace(/"/g, '&quot;')})" class="action-btn" title="Add to Playlist">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
                            <path d="M15 6H3v2h12V6zm0 4H3v2h12v-2zM3 16h8v-2H3v2zM17 6v14l7-7-7-7z"/>
                        </svg>
                    </button>
                </div>
            </div>
        `;
    };
    
    // Show video actions on hover
    window.showVideoActions = function(card) {
        const actions = card.querySelector('.video-actions');
        if (actions) {
            actions.style.display = 'flex';
        }
    };
    
    // Hide video actions
    window.hideVideoActions = function(card) {
        const actions = card.querySelector('.video-actions');
        if (actions) {
            actions.style.display = 'none';
        }
    };
    
    // Play video and add to history
    window.playVideoWithHistory = function(videoId, videoData) {
        if (window.StorageManager && videoData) {
            window.StorageManager.addToHistory(videoData);
        }
        if (window.playVideo) {
            window.playVideo(videoId);
        }
    };
    
    // Toggle like
    window.toggleLike = function(videoId, videoData) {
        if (!window.StorageManager) return;
        
        const isLiked = window.StorageManager.isLiked(videoId);
        if (isLiked) {
            window.StorageManager.removeFromLiked(videoId);
        } else {
            window.StorageManager.addToLiked(videoData);
        }
        
        // Update UI
        const btn = event.target.closest('.action-btn');
        if (btn) {
            btn.classList.toggle('liked');
        }
    };
    
    // Add to watch later
    window.addToWatchLater = function(videoData) {
        if (!window.StorageManager) return;
        
        window.StorageManager.addToWatchLater(videoData);
        
        // Show notification
        showNotification('Added to Watch Later');
    };
    
    // Show playlist menu
    window.showPlaylistMenu = function(videoId, videoData) {
        if (!window.StorageManager) return;
        
        const playlists = window.StorageManager.getPlaylists();
        
        let menuHtml = '<div id="playlist-menu" style="position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); background: #1a1a1a; border-radius: 8px; padding: 20px; z-index: 100001; min-width: 300px; box-shadow: 0 4px 20px rgba(0,0,0,0.5);">';
        menuHtml += '<h3 style="color: #fff; margin: 0 0 16px 0;">Add to Playlist</h3>';
        
        if (playlists.length === 0) {
            menuHtml += '<p style="color: #aaa; margin-bottom: 16px;">No playlists yet. Create one:</p>';
            menuHtml += '<input type="text" id="new-playlist-name" placeholder="Playlist name" style="width: 100%; padding: 8px; background: #0f0f0f; border: 1px solid #303030; color: #fff; border-radius: 4px; margin-bottom: 12px;">';
            menuHtml += '<button onclick="createPlaylistAndAdd()" style="width: 100%; padding: 10px; background: #065fd4; color: white; border: none; border-radius: 4px; cursor: pointer;">Create & Add</button>';
        } else {
            playlists.forEach(playlist => {
                const hasVideo = playlist.videos.some(v => v.id === videoId);
                menuHtml += `
                    <div style="padding: 12px; background: ${hasVideo ? '#272727' : '#0f0f0f'}; border-radius: 4px; margin-bottom: 8px; cursor: pointer; display: flex; justify-content: space-between; align-items: center;" onclick="addToPlaylist('${playlist.id}', '${videoId}', ${JSON.stringify(videoData).replace(/"/g, '&quot;')})">
                        <span style="color: #fff;">${playlist.name}</span>
                        ${hasVideo ? '<span style="color: #0f0;">✓</span>' : ''}
                    </div>
                `;
            });
            menuHtml += '<div style="margin-top: 16px; padding-top: 16px; border-top: 1px solid #272727;">';
            menuHtml += '<input type="text" id="new-playlist-name" placeholder="New playlist name" style="width: 100%; padding: 8px; background: #0f0f0f; border: 1px solid #303030; color: #fff; border-radius: 4px; margin-bottom: 12px;">';
            menuHtml += '<button onclick="createPlaylistAndAdd()" style="width: 100%; padding: 10px; background: #065fd4; color: white; border: none; border-radius: 4px; cursor: pointer;">Create New</button>';
            menuHtml += '</div>';
        }
        
        menuHtml += '<button onclick="closePlaylistMenu()" style="width: 100%; padding: 10px; background: #272727; color: white; border: none; border-radius: 4px; cursor: pointer; margin-top: 12px;">Cancel</button>';
        menuHtml += '</div>';
        
        // Add overlay
        const overlay = document.createElement('div');
        overlay.id = 'playlist-menu-overlay';
        overlay.style.cssText = 'position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.7); z-index: 100000;';
        overlay.onclick = closePlaylistMenu;
        
        document.body.appendChild(overlay);
        document.body.insertAdjacentHTML('beforeend', menuHtml);
    };
    
    window.closePlaylistMenu = function() {
        const menu = document.getElementById('playlist-menu');
        const overlay = document.getElementById('playlist-menu-overlay');
        if (menu) menu.remove();
        if (overlay) overlay.remove();
    };
    
    window.addToPlaylist = function(playlistId, videoId, videoData) {
        if (!window.StorageManager) return;
        
        window.StorageManager.addToPlaylist(playlistId, videoData);
        showNotification('Added to playlist');
        closePlaylistMenu();
    };
    
    window.createPlaylistAndAdd = function() {
        const nameInput = document.getElementById('new-playlist-name');
        const name = nameInput.value.trim();
        
        if (!name) {
            alert('Please enter a playlist name');
            return;
        }
        
        if (!window.StorageManager) return;
        
        const playlist = window.StorageManager.createPlaylist(name);
        const videoData = JSON.parse(document.querySelector('#playlist-menu').getAttribute('data-video') || '{}');
        
        if (videoData.id) {
            window.StorageManager.addToPlaylist(playlist.id, videoData);
        }
        
        showNotification('Playlist created and video added');
        closePlaylistMenu();
    };
    
    // Show notification
    function showNotification(message) {
        const notification = document.createElement('div');
        notification.style.cssText = 'position: fixed; bottom: 20px; right: 20px; background: #0f0f0f; color: #fff; padding: 16px 24px; border-radius: 8px; z-index: 100002; box-shadow: 0 4px 12px rgba(0,0,0,0.3);';
        notification.textContent = message;
        document.body.appendChild(notification);
        
        setTimeout(() => {
            notification.style.opacity = '0';
            notification.style.transition = 'opacity 0.3s';
            setTimeout(() => notification.remove(), 300);
        }, 2000);
    }
})();
</script>

<style>
.video-actions {
    display: flex;
    flex-direction: column;
    gap: 4px;
}

.action-btn {
    background: rgba(0,0,0,0.8);
    border: none;
    color: #fff;
    width: 36px;
    height: 36px;
    border-radius: 50%;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: background 0.2s;
}

.action-btn:hover {
    background: rgba(0,0,0,0.9);
}

.action-btn.liked {
    color: #065fd4;
    background: rgba(6, 95, 212, 0.2);
}

.action-btn svg {
    width: 20px;
    height: 20px;
}
</style>
'@

# Add video actions before closing body
if ($content -match '</body>') {
    $content = $content -replace '</body>', "$videoActionsScript`n</body>"
    Write-Host "Added video action buttons" -ForegroundColor Green
}

$content | Set-Content $filePath -NoNewline -Encoding UTF8
Write-Host "Done! Video actions integrated with local storage." -ForegroundColor Green

