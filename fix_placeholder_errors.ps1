$filePath = 'c:\Users\Elizabeth\Downloads\index.html'
$content = Get-Content $filePath -Raw

Write-Host "Fixing placeholder image errors..." -ForegroundColor Cyan

# Replace broken placeholder URLs with a working fallback
# Option 1: Use data URI for a simple placeholder
$dataUriPlaceholder = "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='320' height='180'%3E%3Crect fill='%231a1a1a' width='320' height='180'/%3E%3Ctext x='50%25' y='50%25' dominant-baseline='middle' text-anchor='middle' fill='%23fff' font-family='Arial' font-size='14'%3EVideo%3C/text%3E%3C/svg%3E"

# Option 2: Use YouTube's default thumbnail pattern
$youtubePlaceholder = "https://i.ytimg.com/vi/default/maxresdefault.jpg"

# Replace all instances of the broken placeholder
$content = $content -replace 'https://via\.placeholder\.com/320x180\?text=Video', $dataUriPlaceholder

# Also fix any other placeholder variations
$content = $content -replace "onerror=`"this\.src='https://via\.placeholder\.com/320x180\?text=Video'`"", "onerror=`"this.style.display='none'`""

Write-Host "Replaced broken placeholder URLs" -ForegroundColor Green

# Also add better error handling for images
$imageErrorHandler = @'
<script>
// Better image error handling
document.addEventListener('DOMContentLoaded', function() {
    // Handle all image load errors
    document.addEventListener('error', function(e) {
        if (e.target.tagName === 'IMG') {
            const img = e.target;
            // If it's a video thumbnail, try YouTube's default
            if (img.src && img.src.includes('youtube.com') || img.src.includes('ytimg.com')) {
                // Extract video ID if possible
                const videoIdMatch = img.src.match(/vi\/([^\/]+)/);
                if (videoIdMatch) {
                    img.src = `https://i.ytimg.com/vi/${videoIdMatch[1]}/maxresdefault.jpg`;
                } else {
                    // Use a simple colored placeholder
                    img.style.display = 'none';
                    img.parentElement.style.backgroundColor = '#1a1a1a';
                }
            } else {
                // Hide broken images
                img.style.display = 'none';
            }
        }
    }, true);
});
</script>
'@

# Add error handler before closing body
if ($content -match '</body>') {
    if ($content -notmatch 'Better image error handling') {
        $content = $content -replace '</body>', "$imageErrorHandler`n</body>"
        Write-Host "Added image error handler" -ForegroundColor Green
    }
}

$content | Set-Content $filePath -NoNewline -Encoding UTF8
Write-Host "`n✅ Fixed placeholder image errors!" -ForegroundColor Green
Write-Host "Replaced broken placeholder.com URLs with working fallbacks" -ForegroundColor Cyan

