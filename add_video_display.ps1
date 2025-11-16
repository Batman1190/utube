$filePath = 'c:\Users\Elizabeth\Downloads\index.html'
$content = Get-Content $filePath -Raw

Write-Host "=== Adding Video Display Functionality ===" -ForegroundColor Cyan
Write-Host ""

# Check if there's a main content area
$hasMainContent = $content -match 'main|content|container|ytd-app'

# Add video display system
$videoSystem = @'
<!-- Video Display System -->
<div id="video-container" style="padding: 20px; background: #0f0f0f; min-height: 100vh;">
    <div id="video-grid" style="display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 20px; max-width: 1400px; margin: 0 auto;">
        <!-- Videos will be loaded here -->
    </div>
</div>

<script>
// Video Display System
(function() {
    const videoContainer = document.getElementById('video-container');
    const videoGrid = document.getElementById('video-grid');
    
    // Sample videos to display (you can replace with API calls)
    const sampleVideos = [
        {
            id: 'dQw4w9WgXcQ',
            title: 'Rick Astley - Never Gonna Give You Up',
            thumbnail: 'https://img.youtube.com/vi/dQw4w9WgXcQ/maxresdefault.jpg',
            channel: 'RickAstleyVEVO',
            views: '1.2B views',
            duration: '3:33'
        },
        {
            id: 'jNQXAC9IVRw',
            title: 'Me at the zoo',
            thumbnail: 'https://img.youtube.com/vi/jNQXAC9IVRw/maxresdefault.jpg',
            channel: 'jawed',
            views: '250M views',
            duration: '0:19'
        },
        {
            id: 'kJQP7kiw5Fk',
            title: 'Luis Fonsi - Despacito ft. Daddy Yankee',
            thumbnail: 'https://img.youtube.com/vi/kJQP7kiw5Fk/maxresdefault.jpg',
            channel: 'LuisFonsiVEVO',
            views: '8.1B views',
            duration: '4:41'
        },
        {
            id: '9bZkp7q19f0',
            title: 'PSY - GANGNAM STYLE',
            thumbnail: 'https://img.youtube.com/vi/9bZkp7q19f0/maxresdefault.jpg',
            channel: 'officialpsy',
            views: '4.7B views',
            duration: '4:12'
        },
        {
            id: 'OPf0YbXqDm0',
            title: 'Mark Ronson - Uptown Funk ft. Bruno Mars',
            thumbnail: 'https://img.youtube.com/vi/OPf0YbXqDm0/maxresdefault.jpg',
            channel: 'MarkRonsonVEVO',
            views: '5.1B views',
            duration: '4:30'
        },
        {
            id: 'RgKAFK5djSk',
            title: 'Wiz Khalifa - See You Again ft. Charlie Puth',
            thumbnail: 'https://img.youtube.com/vi/RgKAFK5djSk/maxresdefault.jpg',
            channel: 'AtlanticRecords',
            views: '6.4B views',
            duration: '3:49'
        }
    ];
    
    // Create video card HTML
    function createVideoCard(video) {
        return `
            <div class="video-card" style="cursor: pointer; background: #1a1a1a; border-radius: 12px; overflow: hidden; transition: transform 0.2s;" onclick="playVideo('${video.id}')">
                <div class="video-thumbnail" style="position: relative; width: 100%; padding-bottom: 56.25%; background: #000;">
                    <img src="${video.thumbnail}" alt="${video.title}" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; object-fit: cover;" onerror="this.src='https://via.placeholder.com/320x180?text=Video'">
                    <div class="video-duration" style="position: absolute; bottom: 8px; right: 8px; background: rgba(0,0,0,0.8); color: white; padding: 2px 6px; border-radius: 4px; font-size: 12px; font-weight: 500;">${video.duration}</div>
                </div>
                <div class="video-info" style="padding: 12px;">
                    <h3 class="video-title" style="color: #fff; font-size: 14px; font-weight: 500; margin: 0 0 8px 0; line-height: 1.4; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">${video.title}</h3>
                    <div class="video-meta" style="color: #aaa; font-size: 12px;">
                        <div>${video.channel}</div>
                        <div>${video.views}</div>
                    </div>
                </div>
            </div>
        `;
    }
    
    // Load videos
    function loadVideos() {
        if (!videoGrid) {
            console.error('Video grid not found');
            return;
        }
        
        // Clear existing content
        videoGrid.innerHTML = '';
        
        // Add sample videos
        sampleVideos.forEach(video => {
            const card = document.createElement('div');
            card.innerHTML = createVideoCard(video);
            videoGrid.appendChild(card.firstElementChild);
        });
        
        console.log('Videos loaded:', sampleVideos.length);
    }
    
    // Play video function
    window.playVideo = function(videoId) {
        // Create video player modal
        const modal = document.createElement('div');
        modal.id = 'video-modal';
        modal.style.cssText = 'position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.95); z-index: 100000; display: flex; align-items: center; justify-content: center;';
        
        modal.innerHTML = `
            <div style="position: relative; width: 90%; max-width: 1280px;">
                <button onclick="closeVideo()" style="position: absolute; top: -40px; right: 0; background: none; border: none; color: white; font-size: 30px; cursor: pointer; z-index: 100001;">✕</button>
                <div style="position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden;">
                    <iframe 
                        id="yt-player" 
                        src="https://www.youtube.com/embed/${videoId}?autoplay=1&rel=0" 
                        frameborder="0" 
                        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
                        allowfullscreen
                        style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;">
                    </iframe>
                </div>
            </div>
        `;
        
        document.body.appendChild(modal);
        document.body.style.overflow = 'hidden';
    };
    
    // Close video function
    window.closeVideo = function() {
        const modal = document.getElementById('video-modal');
        if (modal) {
            modal.remove();
            document.body.style.overflow = '';
        }
    };
    
    // Close on escape key
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            closeVideo();
        }
    });
    
    // Load videos when page is ready
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', loadVideos);
    } else {
        loadVideos();
    }
    
    // Also try loading after a delay in case content loads dynamically
    setTimeout(loadVideos, 500);
})();
</script>

<style>
.video-card:hover {
    transform: scale(1.02);
}
.video-card img {
    transition: opacity 0.2s;
}
.video-card:hover img {
    opacity: 0.9;
}
</style>
'@

# Check where to insert the video system
if ($content -match '<body[^>]*>') {
    # Check if there's existing content structure
    if ($content -match 'ytd-app|main-content|content-wrapper') {
        # Insert before closing body
        if ($content -match '</body>') {
            $content = $content -replace '</body>', "$videoSystem`n</body>"
            Write-Host "Added video system before closing body" -ForegroundColor Green
        }
    } else {
        # Insert right after body tag
        $content = $content -replace '(<body[^>]*>)', "`$1`n$videoSystem"
        Write-Host "Added video system after body tag" -ForegroundColor Green
    }
} else {
    # No body tag, append to end
    $content = $content + $videoSystem
    Write-Host "Added video system to end of file" -ForegroundColor Green
}

# Save
$content | Set-Content $filePath -NoNewline -Encoding UTF8
Write-Host "`n✅ Video display system added!" -ForegroundColor Green
Write-Host "The page will now show a grid of videos that users can click to play." -ForegroundColor Cyan

