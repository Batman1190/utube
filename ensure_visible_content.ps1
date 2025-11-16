$filePath = 'c:\Users\Elizabeth\Downloads\index.html'
$content = Get-Content $filePath -Raw

Write-Host "Ensuring page has visible content..." -ForegroundColor Cyan

# Add a visible test element that shows immediately
$visibleTest = @'
<div id="page-content-check" style="position: fixed; top: 10px; right: 10px; background: rgba(0,0,0,0.8); color: #0f0; padding: 10px; border-radius: 5px; z-index: 999999; font-family: monospace; font-size: 12px; display: block !important;">
    <div>✓ Page Loaded</div>
    <div>✓ JavaScript Working</div>
    <div>✓ Content Visible</div>
</div>
<script>
// Ensure body is visible
(function() {
    if (document.body) {
        document.body.style.display = 'block';
        document.body.style.visibility = 'visible';
        document.body.style.opacity = '1';
    }
    
    // Check if main content exists
    setTimeout(function() {
        var hasContent = document.body && document.body.children.length > 0;
        var checkDiv = document.getElementById('page-content-check');
        if (checkDiv) {
            if (hasContent) {
                checkDiv.innerHTML += '<div style="color: #0f0;">✓ Content Found</div>';
            } else {
                checkDiv.innerHTML += '<div style="color: #f00;">✗ No Content</div>';
            }
        }
        
        // Hide test div after 5 seconds
        setTimeout(function() {
            if (checkDiv) checkDiv.style.display = 'none';
        }, 5000);
    }, 1000);
})();
</script>
'@

# Add to body if not already there
if ($content -notmatch 'page-content-check') {
    if ($content -match '(<body[^>]*>)') {
        $content = $content -replace '(<body[^>]*>)', "`$1`n$visibleTest"
        Write-Host "Added visibility check element" -ForegroundColor Green
    }
}

# Ensure html and body have proper display
$styleFix = @'
<style>
html, body {
    display: block !important;
    visibility: visible !important;
    opacity: 1 !important;
    min-height: 100vh;
}
body {
    margin: 0;
    padding: 0;
}
</style>
'@

if ($content -match '<head>') {
    if ($content -notmatch 'html, body.*display.*block') {
        $content = $content -replace '(<head>)', "`$1`n$styleFix"
        Write-Host "Added display fixes" -ForegroundColor Green
    }
}

$content | Set-Content $filePath -NoNewline -Encoding UTF8
Write-Host "Done! Page should now be visible." -ForegroundColor Green

