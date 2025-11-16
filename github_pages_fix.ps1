# GitHub Pages Fix Script
# This script helps diagnose and fix common GitHub Pages issues

$filePath = 'c:\Users\Elizabeth\Downloads\index.html'
$content = Get-Content $filePath -Raw

Write-Host "=== GitHub Pages Fix Script ===" -ForegroundColor Cyan
Write-Host ""

# Check if file starts with proper DOCTYPE
if (-not ($content -match '^<!doctype')) {
    Write-Host "WARNING: File doesn't start with DOCTYPE" -ForegroundColor Yellow
    Write-Host "Adding DOCTYPE if missing..." -ForegroundColor Yellow
    
    if (-not ($content -match '<!doctype')) {
        $content = "<!doctype html>`n" + $content
    }
}

# Check for common issues that cause blank pages
Write-Host "Checking for common issues..." -ForegroundColor Cyan

# Issue 1: Check for unclosed tags
$openBody = ([regex]::Matches($content, '<body[^>]*>', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)).Count
$closeBody = ([regex]::Matches($content, '</body>', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)).Count

if ($openBody -ne $closeBody) {
    Write-Host "WARNING: Mismatched body tags (Open: $openBody, Close: $closeBody)" -ForegroundColor Yellow
}

# Issue 2: Check for script errors
$scriptErrors = $content -match 'console\.(error|warn)'
if ($scriptErrors) {
    Write-Host "Found potential JavaScript errors in code" -ForegroundColor Yellow
}

# Issue 3: Check file encoding
Write-Host "`nFile Statistics:" -ForegroundColor Cyan
Write-Host "  Size: $([math]::Round($content.Length / 1MB, 2)) MB"
Write-Host "  Lines: $((Get-Content $filePath).Count)"

# Create a simple verification script
$verificationScript = @'
<script>
// GitHub Pages Verification Script
(function() {
    console.log('Page loaded successfully');
    console.log('Document ready state:', document.readyState);
    console.log('Body element:', document.body ? 'Found' : 'Missing');
    
    // Check for common issues
    if (!document.body) {
        console.error('ERROR: Body element not found!');
    }
    
    if (document.body && document.body.innerHTML.trim() === '') {
        console.warn('WARNING: Body is empty');
    }
    
    // Log any errors
    window.addEventListener('error', function(e) {
        console.error('JavaScript Error:', e.message, e.filename, e.lineno);
    });
})();
</script>
'@

# Add verification script if not already present
if ($content -notmatch 'GitHub Pages Verification') {
    if ($content -match '</body>') {
        $content = $content -replace '</body>', ($verificationScript + "`n</body>")
        Write-Host "Added verification script" -ForegroundColor Green
    }
}

# Save the file
$content | Set-Content $filePath -NoNewline -Encoding UTF8
Write-Host "`nFile updated and saved as UTF-8" -ForegroundColor Green

Write-Host "`n=== Next Steps ===" -ForegroundColor Cyan
Write-Host "1. Commit and push this file to GitHub"
Write-Host "2. Enable GitHub Pages in repository settings"
Write-Host "3. Wait 5-10 minutes for GitHub Pages to update"
Write-Host "4. Open browser console (F12) to check for errors"
Write-Host "5. Try accessing: https://YOUR_USERNAME.github.io/REPO_NAME/"

