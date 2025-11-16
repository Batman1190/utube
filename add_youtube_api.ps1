$filePath = 'c:\Users\Elizabeth\Downloads\index.html'
$content = Get-Content $filePath -Raw

# YouTube API Configuration with rotation system
$youtubeApiScript = @'
<script>
// YouTube API Configuration with Key Rotation
const YOUTUBE_API_KEYS = [
    'AIzaSyBRB8bXp-UFdoNFhTqh9n2hWdthpm--gXk',
    'AIzaSyBi9XME_hKIdmFyKT2sX9Qzq-YW4uwaPGc',
    'AIzaSyAaT_fn6jzNLUjee7n7hQIJAdjvQiKHSTU',
    'AIzaSyD0ZhRR292c95yMkSx-ZPWtsGL-FkwEH2Y',
    'AIzaSyB0z2xXRZX5dh8tMw3PZh9oqfSGgwiWx-U',
    'AIzaSyByQDjEkBdrbJqi3O35UUyOEgGrEqImoXU',
    'AIzaSyA4iPnRBOkNcVnG6i2Osdplr-6KOOidJso',
    'AIzaSyBp1KT6xYFkP5pkq5vldiS5M-275Jyhk1o',
    'AIzaSyBSUK5rvC9NUIfGg7Ol-c5fByZDLxkV4MA',
    'AIzaSyBBN1oCDauSMk_QdRMKfriv3KsP--jGgIE',
    'AIzaSyBzD1zDrYqVl-RH3vTwfmXDkGqjdH3Zlr0',
    'AIzaSyDzoPLaJUFjAB0kSSPRGQfUwiMlywWIO4I',
    'AIzaSyCSMlS_3EpigNZYoyxU7L6mnLPfpFbJ6vA',
    'AIzaSyAvw2xoR4eaQOzsyEBjthCQSFo5x60jNV8',
    'AIzaSyDOd-fwjmHblCWYZWFtu6V0QNGHNBMb0Tw',
    'AIzaSyDKye_UeYzygyeo7H35-bKrM3wgCXb3wPs',
    'AIzaSyBg_4VpFdldAYh4eyEOdJKibMS1HeM7wZQ',
    'AIzaSyDIhTB0yw5Qkbdp3Wpu1n0djdJQXvELGlc',
    'AIzaSyCCgPxoUbeo3yiKo-2i8FTDyMO2MEhVS5Q',
    'AIzaSyDc-OSidO2qU5QAiXi7Ad1qASH3rPGZB3w',
    'AIzaSyA1KrCE-nCrnw_6lCrm0WK3n5iE5LlOpoQ',
    'AIzaSyCHby00rzviTneGRsYoaXPDSTNZ5mByYRs',
    'AIzaSyANh88_Ut5RXlGkw8TgbpgCcHHXTPqgN74',
    'AIzaSyCjgMk3Q_D-545I-slLdpOkcsi5rhUbwLg',
    'AIzaSyBRGmaiOgS9Ma0d6X6GqDxLbfJLFolkgCs',
    'AIzaSyBwQVmWudUVfBSA-Xd0Py3dWaBdubjEKDk',
    'AIzaSyAohDXe4nuKALD07eQGXG7WiCPC9u4j-No',
    'AIzaSyDEDWKHYGpjRJHM_xvgwzqUgCUgTI4BP24'
];

// API Key Rotation Manager
class YouTubeAPIKeyManager {
    constructor(apiKeys) {
        this.apiKeys = apiKeys;
        this.currentIndex = 0;
        this.failedKeys = new Set();
        this.keyUsageCount = new Map();
        this.quotaLimit = 10000; // Daily quota per key (adjust as needed)
        this.requestCount = 0;
        
        // Load state from localStorage
        this.loadState();
    }
    
    // Get current API key
    getCurrentKey() {
        return this.apiKeys[this.currentIndex];
    }
    
    // Get next available API key
    getNextKey() {
        let attempts = 0;
        const maxAttempts = this.apiKeys.length;
        
        while (attempts < maxAttempts) {
            const key = this.apiKeys[this.currentIndex];
            
            // Check if key is not failed and not over quota
            if (!this.failedKeys.has(key) && this.getKeyUsage(key) < this.quotaLimit) {
                return key;
            }
            
            // Move to next key
            this.currentIndex = (this.currentIndex + 1) % this.apiKeys.length;
            attempts++;
        }
        
        // If all keys are exhausted, reset failed keys and try again
        console.warn('All API keys exhausted, resetting failed keys...');
        this.failedKeys.clear();
        this.currentIndex = 0;
        return this.apiKeys[this.currentIndex];
    }
    
    // Rotate to next key
    rotateKey() {
        this.currentIndex = (this.currentIndex + 1) % this.apiKeys.length;
        this.saveState();
    }
    
    // Mark key as failed
    markKeyFailed(key, reason) {
        this.failedKeys.add(key);
        console.warn(`API Key marked as failed: ${key.substring(0, 10)}... Reason: ${reason}`);
        this.saveState();
    }
    
    // Mark key as successful
    markKeySuccess(key) {
        const count = this.getKeyUsage(key);
        this.keyUsageCount.set(key, count + 1);
        this.requestCount++;
        this.saveState();
    }
    
    // Get usage count for a key
    getKeyUsage(key) {
        return this.keyUsageCount.get(key) || 0;
    }
    
    // Handle API error and rotate if needed
    handleAPIError(error, currentKey) {
        if (error && error.error) {
            const errorCode = error.error.code;
            const errorMessage = error.error.message || '';
            
            // Check for quota exceeded error
            if (errorCode === 403 && (
                errorMessage.includes('quota') || 
                errorMessage.includes('quotaExceeded') ||
                errorMessage.includes('dailyLimitExceeded')
            )) {
                this.markKeyFailed(currentKey, 'Quota exceeded');
                this.rotateKey();
                return true; // Indicates key was rotated
            }
            
            // Check for invalid API key
            if (errorCode === 400 && errorMessage.includes('API key')) {
                this.markKeyFailed(currentKey, 'Invalid API key');
                this.rotateKey();
                return true;
            }
        }
        
        return false; // No rotation needed
    }
    
    // Save state to localStorage
    saveState() {
        try {
            const state = {
                currentIndex: this.currentIndex,
                failedKeys: Array.from(this.failedKeys),
                keyUsageCount: Object.fromEntries(this.keyUsageCount),
                requestCount: this.requestCount,
                lastReset: new Date().toISOString()
            };
            localStorage.setItem('youtube_api_manager_state', JSON.stringify(state));
        } catch (e) {
            console.warn('Failed to save API manager state:', e);
        }
    }
    
    // Load state from localStorage
    loadState() {
        try {
            const saved = localStorage.getItem('youtube_api_manager_state');
            if (saved) {
                const state = JSON.parse(saved);
                const lastReset = new Date(state.lastReset);
                const now = new Date();
                const daysDiff = (now - lastReset) / (1000 * 60 * 60 * 24);
                
                // Reset if more than 1 day has passed (daily quota reset)
                if (daysDiff >= 1) {
                    this.resetDailyQuota();
                    return;
                }
                
                this.currentIndex = state.currentIndex || 0;
                this.failedKeys = new Set(state.failedKeys || []);
                this.keyUsageCount = new Map(Object.entries(state.keyUsageCount || {}));
                this.requestCount = state.requestCount || 0;
            }
        } catch (e) {
            console.warn('Failed to load API manager state:', e);
        }
    }
    
    // Reset daily quota (called daily)
    resetDailyQuota() {
        this.keyUsageCount.clear();
        this.failedKeys.clear();
        this.requestCount = 0;
        this.currentIndex = 0;
        this.saveState();
        console.log('Daily quota reset');
    }
    
    // Get statistics
    getStats() {
        return {
            totalKeys: this.apiKeys.length,
            currentKey: this.getCurrentKey(),
            currentIndex: this.currentIndex,
            failedKeys: this.failedKeys.size,
            totalRequests: this.requestCount,
            availableKeys: this.apiKeys.length - this.failedKeys.size
        };
    }
}

// Initialize API Key Manager
const youtubeAPIKeyManager = new YouTubeAPIKeyManager(YOUTUBE_API_KEYS);

// Enhanced YouTube API wrapper with automatic key rotation
window.YouTubeAPI = {
    // Make API request with automatic key rotation
    async request(endpoint, params = {}) {
        let maxRetries = youtubeAPIKeyManager.apiKeys.length;
        let retryCount = 0;
        
        while (retryCount < maxRetries) {
            const apiKey = youtubeAPIKeyManager.getNextKey();
            const url = new URL(`https://www.googleapis.com/youtube/v3/${endpoint}`);
            
            // Add API key to params
            params.key = apiKey;
            
            // Add all params to URL
            Object.keys(params).forEach(key => {
                url.searchParams.append(key, params[key]);
            });
            
            try {
                const response = await fetch(url.toString());
                const data = await response.json();
                
                if (response.ok) {
                    // Success - mark key as used
                    youtubeAPIKeyManager.markKeySuccess(apiKey);
                    return data;
                } else {
                    // Error - check if we need to rotate
                    const rotated = youtubeAPIKeyManager.handleAPIError(data, apiKey);
                    if (rotated && retryCount < maxRetries - 1) {
                        retryCount++;
                        continue; // Retry with next key
                    }
                    throw new Error(data.error?.message || 'API request failed');
                }
            } catch (error) {
                console.error('YouTube API request error:', error);
                if (retryCount < maxRetries - 1) {
                    youtubeAPIKeyManager.rotateKey();
                    retryCount++;
                    continue;
                }
                throw error;
            }
        }
        
        throw new Error('All API keys exhausted');
    },
    
    // Get video details
    async getVideoDetails(videoId) {
        return await this.request('videos', {
            part: 'snippet,contentDetails,statistics',
            id: videoId
        });
    },
    
    // Search videos
    async searchVideos(query, maxResults = 10) {
        return await this.request('search', {
            part: 'snippet',
            q: query,
            type: 'video',
            maxResults: maxResults
        });
    },
    
    // Get channel details
    async getChannelDetails(channelId) {
        return await this.request('channels', {
            part: 'snippet,statistics',
            id: channelId
        });
    },
    
    // Get trending videos
    async getTrendingVideos(regionCode = 'US', maxResults = 25) {
        return await this.request('videos', {
            part: 'snippet,contentDetails,statistics',
            chart: 'mostPopular',
            regionCode: regionCode,
            maxResults: maxResults
        });
    },
    
    // Get API manager stats
    getStats() {
        return youtubeAPIKeyManager.getStats();
    }
};

// Auto-rotate key periodically to distribute load
setInterval(() => {
    const stats = youtubeAPIKeyManager.getStats();
    if (stats.totalRequests > 0 && stats.totalRequests % 50 === 0) {
        youtubeAPIKeyManager.rotateKey();
        console.log('Auto-rotated API key to distribute load');
    }
}, 60000); // Check every minute

// Log API manager initialization
console.log('YouTube API Key Manager initialized:', youtubeAPIKeyManager.getStats());
</script>
'@

# Insert the script before closing body tag
if ($content -match '</body>') {
    $newContent = $content -replace '</body>', ($youtubeApiScript + "`n</body>")
    $newContent | Set-Content $filePath -NoNewline
    Write-Host "SUCCESS: YouTube API key rotation system added!"
} else {
    # If no body tag, append to end
    $newContent = $content + $youtubeApiScript
    $newContent | Set-Content $filePath -NoNewline
    Write-Host "SUCCESS: YouTube API key rotation system added (appended to end)!"
}

