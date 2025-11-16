$filePath = 'c:\Users\Elizabeth\Downloads\index.html'
$content = Get-Content $filePath -Raw

Write-Host "Enhancing video system to use YouTube API..." -ForegroundColor Cyan

# Enhanced video loading with API integration
$apiVideoLoader = @'
<script>
// Enhanced Video Loader with YouTube API Integration
(function() {
    const videoGrid = document.getElementById('video-grid');
    
    if (!videoGrid) {
        console.error('Video grid not found');
        return;
    }
    
    // Load videos from YouTube API
    async function loadVideosFromAPI() {
        try {
            // Show loading state
            videoGrid.innerHTML = '<div style="grid-column: 1/-1; text-align: center; color: #fff; padding: 40px;">Loading videos...</div>';
            
            // Use YouTube API to get trending videos
            if (window.YouTubeAPI) {
                const response = await window.YouTubeAPI.getTrendingVideos('US', 24);
                
                if (response && response.items) {
                    displayVideos(response.items);
                } else {
                    // Fallback to sample videos
                    loadSampleVideos();
                }
            } else {
                console.warn('YouTubeAPI not available, using sample videos');
                loadSampleVideos();
            }
        } catch (error) {
            console.error('Error loading videos from API:', error);
            // Fallback to sample videos
            loadSampleVideos();
        }
    }
    
    // Display videos from API response
    function displayVideos(videos) {
        videoGrid.innerHTML = '';
        
        videos.forEach(item => {
            const video = {
                id: item.id,
                title: item.snippet.title,
                thumbnail: item.snippet.thumbnails.high?.url || item.snippet.thumbnails.default.url,
                channel: item.snippet.channelTitle,
                views: formatViews(item.statistics?.viewCount || '0'),
                publishedAt: item.snippet.publishedAt,
                duration: 'N/A' // Would need video details API call for duration
            };
            
            const card = document.createElement('div');
            card.innerHTML = createVideoCard(video);
            videoGrid.appendChild(card.firstElementChild);
        });
        
        console.log('Videos loaded from API:', videos.length);
    }
    
    // Format view count
    function formatViews(count) {
        const num = parseInt(count);
        if (num >= 1000000000) return (num / 1000000000).toFixed(1) + 'B views';
        if (num >= 1000000) return (num / 1000000).toFixed(1) + 'M views';
        if (num >= 1000) return (num / 1000).toFixed(1) + 'K views';
        return num + ' views';
    }
    
    // Sample videos fallback
    function loadSampleVideos() {
        const sampleVideos = [
            { id: 'dQw4w9WgXcQ', title: 'Rick Astley - Never Gonna Give You Up', thumbnail: 'https://img.youtube.com/vi/dQw4w9WgXcQ/maxresdefault.jpg', channel: 'RickAstleyVEVO', views: '1.2B views', duration: '3:33' },
            { id: 'jNQXAC9IVRw', title: 'Me at the zoo', thumbnail: 'https://img.youtube.com/vi/jNQXAC9IVRw/maxresdefault.jpg', channel: 'jawed', views: '250M views', duration: '0:19' },
            { id: 'kJQP7kiw5Fk', title: 'Luis Fonsi - Despacito ft. Daddy Yankee', thumbnail: 'https://img.youtube.com/vi/kJQP7kiw5Fk/maxresdefault.jpg', channel: 'LuisFonsiVEVO', views: '8.1B views', duration: '4:41' },
            { id: '9bZkp7q19f0', title: 'PSY - GANGNAM STYLE', thumbnail: 'https://img.youtube.com/vi/9bZkp7q19f0/maxresdefault.jpg', channel: 'officialpsy', views: '4.7B views', duration: '4:12' },
            { id: 'OPf0YbXqDm0', title: 'Mark Ronson - Uptown Funk ft. Bruno Mars', thumbnail: 'https://img.youtube.com/vi/OPf0YbXqDm0/maxresdefault.jpg', channel: 'MarkRonsonVEVO', views: '5.1B views', duration: '4:30' },
            { id: 'RgKAFK5djSk', title: 'Wiz Khalifa - See You Again ft. Charlie Puth', thumbnail: 'https://img.youtube.com/vi/RgKAFK5djSk/maxresdefault.jpg', channel: 'AtlanticRecords', views: '6.4B views', duration: '3:49' }
        ];
        
        videoGrid.innerHTML = '';
        sampleVideos.forEach(video => {
            const card = document.createElement('div');
            card.innerHTML = createVideoCard(video);
            videoGrid.appendChild(card.firstElementChild);
        });
    }
    
    // Create video card (reuse existing function if available, otherwise define it)
    if (typeof createVideoCard === 'undefined') {
        window.createVideoCard = function(video) {
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
        };
    }
    
    // Initialize
    setTimeout(function() {
        loadVideosFromAPI();
    }, 1000); // Wait for API to be ready
})();
</script>
'@

# Add the enhanced loader before closing body
if ($content -match '</body>') {
    $content = $content -replace '</body>', "$apiVideoLoader`n</body>"
    Write-Host "Added API video loader" -ForegroundColor Green
}

$content | Set-Content $filePath -NoNewline -Encoding UTF8
Write-Host "Done! Videos will now load from YouTube API." -ForegroundColor Green

