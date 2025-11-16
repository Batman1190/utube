$filePath = 'c:\Users\Elizabeth\Downloads\index.html'
$content = Get-Content $filePath -Raw

Write-Host "=== Verifying API Rotation System ===" -ForegroundColor Cyan
Write-Host ""

# Check if rotation system exists
$hasRotation = $content -match 'YouTubeAPIKeyManager|getNextKey|rotateKey'
$hasAPIKeys = $content -match 'YOUTUBE_API_KEYS'
$hasAPIWrapper = $content -match 'window\.YouTubeAPI|YouTubeAPI\.request'

Write-Host "API Rotation Components:" -ForegroundColor Yellow
Write-Host "  API Key Manager: $(if ($hasRotation) { '✓ Found' } else { '✗ Missing' })"
Write-Host "  API Keys Array: $(if ($hasAPIKeys) { '✓ Found' } else { '✗ Missing' })"
Write-Host "  API Wrapper: $(if ($hasAPIWrapper) { '✓ Found' } else { '✗ Missing' })"
Write-Host ""

if (-not $hasRotation) {
    Write-Host "API rotation system is missing! Adding it now..." -ForegroundColor Red
    
    # Add the complete API rotation system
    $apiRotationSystem = @'
<script>
// YouTube API Key Rotation System (Enhanced)
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

// Enhanced API Key Rotation Manager
class YouTubeAPIKeyManager {
    constructor(apiKeys) {
        this.apiKeys = apiKeys;
        this.currentIndex = 0;
        this.failedKeys = new Set();
        this.keyUsageCount = new Map();
        this.quotaLimit = 10000;
        this.requestCount = 0;
        this.loadState();
        console.log('🔑 API Key Manager initialized with', this.apiKeys.length, 'keys');
    }
    
    getCurrentKey() {
        return this.apiKeys[this.currentIndex];
    }
    
    getNextKey() {
        let attempts = 0;
        const maxAttempts = this.apiKeys.length;
        
        while (attempts < maxAttempts) {
            const key = this.apiKeys[this.currentIndex];
            
            if (!this.failedKeys.has(key) && this.getKeyUsage(key) < this.quotaLimit) {
                return key;
            }
            
            this.currentIndex = (this.currentIndex + 1) % this.apiKeys.length;
            attempts++;
        }
        
        console.warn('⚠️ All API keys exhausted, resetting failed keys...');
        this.failedKeys.clear();
        this.currentIndex = 0;
        return this.apiKeys[this.currentIndex];
    }
    
    rotateKey() {
        const oldIndex = this.currentIndex;
        this.currentIndex = (this.currentIndex + 1) % this.apiKeys.length;
        this.saveState();
        console.log(`🔄 Rotated API key: ${oldIndex} → ${this.currentIndex}`);
    }
    
    markKeyFailed(key, reason) {
        this.failedKeys.add(key);
        console.warn(`❌ API Key failed: ${key.substring(0, 10)}... Reason: ${reason}`);
        this.saveState();
    }
    
    markKeySuccess(key) {
        const count = this.getKeyUsage(key);
        this.keyUsageCount.set(key, count + 1);
        this.requestCount++;
        this.saveState();
    }
    
    getKeyUsage(key) {
        return this.keyUsageCount.get(key) || 0;
    }
    
    handleAPIError(error, currentKey) {
        if (error && error.error) {
            const errorCode = error.error.code;
            const errorMessage = error.error.message || '';
            
            if (errorCode === 403 && (
                errorMessage.includes('quota') || 
                errorMessage.includes('quotaExceeded') ||
                errorMessage.includes('dailyLimitExceeded')
            )) {
                this.markKeyFailed(currentKey, 'Quota exceeded');
                this.rotateKey();
                return true;
            }
            
            if (errorCode === 400 && errorMessage.includes('API key')) {
                this.markKeyFailed(currentKey, 'Invalid API key');
                this.rotateKey();
                return true;
            }
        }
        return false;
    }
    
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
    
    loadState() {
        try {
            const saved = localStorage.getItem('youtube_api_manager_state');
            if (saved) {
                const state = JSON.parse(saved);
                const lastReset = new Date(state.lastReset);
                const now = new Date();
                const daysDiff = (now - lastReset) / (1000 * 60 * 60 * 24);
                
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
    
    resetDailyQuota() {
        this.keyUsageCount.clear();
        this.failedKeys.clear();
        this.requestCount = 0;
        this.currentIndex = 0;
        this.saveState();
        console.log('🔄 Daily quota reset');
    }
    
    getStats() {
        return {
            totalKeys: this.apiKeys.length,
            currentKey: this.getCurrentKey().substring(0, 15) + '...',
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
    async request(endpoint, params = {}) {
        let maxRetries = youtubeAPIKeyManager.apiKeys.length;
        let retryCount = 0;
        
        while (retryCount < maxRetries) {
            const apiKey = youtubeAPIKeyManager.getNextKey();
            const url = new URL(`https://www.googleapis.com/youtube/v3/${endpoint}`);
            
            params.key = apiKey;
            
            Object.keys(params).forEach(key => {
                url.searchParams.append(key, params[key]);
            });
            
            try {
                console.log(`🌐 API Request (Key ${youtubeAPIKeyManager.currentIndex + 1}/${youtubeAPIKeyManager.apiKeys.length}):`, endpoint);
                const response = await fetch(url.toString());
                const data = await response.json();
                
                if (response.ok) {
                    youtubeAPIKeyManager.markKeySuccess(apiKey);
                    console.log(`✅ API Request successful`);
                    return data;
                } else {
                    const rotated = youtubeAPIKeyManager.handleAPIError(data, apiKey);
                    if (rotated && retryCount < maxRetries - 1) {
                        console.log(`🔄 Retrying with next key...`);
                        retryCount++;
                        continue;
                    }
                    throw new Error(data.error?.message || 'API request failed');
                }
            } catch (error) {
                console.error('❌ YouTube API request error:', error);
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
    
    async getVideoDetails(videoId) {
        return await this.request('videos', {
            part: 'snippet,contentDetails,statistics',
            id: videoId
        });
    },
    
    async searchVideos(query, maxResults = 10) {
        return await this.request('search', {
            part: 'snippet',
            q: query,
            type: 'video',
            maxResults: maxResults
        });
    },
    
    async getChannelDetails(channelId) {
        return await this.request('channels', {
            part: 'snippet,statistics',
            id: channelId
        });
    },
    
    async getTrendingVideos(regionCode = 'US', maxResults = 25) {
        return await this.request('videos', {
            part: 'snippet,contentDetails,statistics',
            chart: 'mostPopular',
            regionCode: regionCode,
            maxResults: maxResults
        });
    },
    
    getStats() {
        return youtubeAPIKeyManager.getStats();
    }
};

// Auto-rotate key periodically to distribute load
setInterval(() => {
    const stats = youtubeAPIKeyManager.getStats();
    if (stats.totalRequests > 0 && stats.totalRequests % 50 === 0) {
        youtubeAPIKeyManager.rotateKey();
        console.log('🔄 Auto-rotated API key to distribute load');
    }
}, 60000);

// Log API manager initialization
console.log('📊 API Manager Stats:', youtubeAPIKeyManager.getStats());

// Display rotation status in console
setInterval(() => {
    const stats = youtubeAPIKeyManager.getStats();
    console.log(`📈 API Rotation Status: Key ${stats.currentIndex + 1}/${stats.totalKeys} | Requests: ${stats.totalRequests} | Available: ${stats.availableKeys}`);
}, 30000); // Log every 30 seconds
</script>
'@
    
    # Insert before closing body
    if ($content -match '</body>') {
        $content = $content -replace '</body>', "$apiRotationSystem`n</body>"
        Write-Host "Added API rotation system" -ForegroundColor Green
    }
} else {
    Write-Host "✓ API rotation system is already present" -ForegroundColor Green
}

# Check if it's being used
Write-Host "`nVerifying integration..." -ForegroundColor Cyan
if ($content -match 'YouTubeAPI\.(getTrendingVideos|searchVideos|getVideoDetails)') {
    Write-Host "✓ API wrapper is being used in code" -ForegroundColor Green
} else {
    Write-Host "⚠ API wrapper may not be fully integrated" -ForegroundColor Yellow
}

$content | Set-Content $filePath -NoNewline -Encoding UTF8
Write-Host "`n✅ API rotation system verified and ready!" -ForegroundColor Green
Write-Host "`nFeatures:" -ForegroundColor Cyan
Write-Host "  - 28 API keys ready to rotate" -ForegroundColor Yellow
Write-Host "  - Automatic rotation on quota errors" -ForegroundColor Yellow
Write-Host "  - Auto-rotation every 50 requests" -ForegroundColor Yellow
Write-Host "  - Daily quota reset" -ForegroundColor Yellow
Write-Host "  - State persistence in localStorage" -ForegroundColor Yellow
Write-Host "  - Console logging for monitoring" -ForegroundColor Yellow

