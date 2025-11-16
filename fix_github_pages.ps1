$filePath = 'c:\Users\Elizabeth\Downloads\index.html'
$content = Get-Content $filePath -Raw

Write-Host "=== Diagnosing GitHub Pages Issue ===" -ForegroundColor Cyan
Write-Host ""

# Check if file has proper structure
$hasDoctype = $content -match '^<!doctype'
$hasHtml = $content -match '<html'
$hasHead = $content -match '<head>'
$hasBody = $content -match '<body[^>]*>'

Write-Host "File Structure Check:" -ForegroundColor Yellow
Write-Host "  Starts with DOCTYPE: $(if ($hasDoctype) { 'YES ✓' } else { 'NO ✗ - THIS IS THE PROBLEM!' })"
Write-Host "  Has <html> tag: $(if ($hasHtml) { 'YES ✓' } else { 'NO ✗' })"
Write-Host "  Has <head> tag: $(if ($hasHead) { 'YES ✓' } else { 'NO ✗' })"
Write-Host "  Has <body> tag: $(if ($hasBody) { 'YES ✓' } else { 'NO ✗' })"
Write-Host ""

# Check if content is actually there
$bodyContent = ''
if ($content -match '<body[^>]*>(.*)</body>') {
    $bodyContent = $matches[1]
    $bodyLength = $bodyContent.Length
    Write-Host "Body content length: $bodyLength characters"
    if ($bodyLength -lt 100) {
        Write-Host "  WARNING: Body content seems very short!" -ForegroundColor Red
    }
}

# Check for common GitHub Pages issues
Write-Host "`nChecking for GitHub Pages blockers..." -ForegroundColor Yellow

# Issue 1: File might be minified into one line
$lineCount = (Get-Content $filePath).Count
Write-Host "  Total lines: $lineCount"
if ($lineCount -lt 5) {
    Write-Host "  WARNING: File appears to be minified (all on one line)" -ForegroundColor Red
    Write-Host "  GitHub Pages may have issues with minified files" -ForegroundColor Red
}

# Issue 2: Check for JavaScript that might prevent rendering
$hasScriptErrors = $content -match 'throw\s+new\s+Error|\.error\(|console\.error'
if ($hasScriptErrors) {
    Write-Host "  Found potential JavaScript errors" -ForegroundColor Yellow
}

# Issue 3: Check if there's actual visible content
$hasTextContent = $content -match '>[^<]{50,}<'  # Text content between tags
if (-not $hasTextContent) {
    Write-Host "  WARNING: May not have visible text content" -ForegroundColor Yellow
}

# Fix: Ensure proper HTML structure
Write-Host "`n=== Applying Fixes ===" -ForegroundColor Green

# Ensure file starts with DOCTYPE
if (-not $hasDoctype) {
    Write-Host "  Adding DOCTYPE declaration..." -ForegroundColor Yellow
    if ($content -notmatch '^<!doctype') {
        $content = "<!doctype html>`n" + $content
    }
}

# Ensure proper encoding and structure
Write-Host "  Ensuring UTF-8 encoding and proper structure..." -ForegroundColor Yellow

# Add a simple fallback to show something if JavaScript fails
$fallbackContent = @'
<noscript>
    <div style="padding: 50px; text-align: center; font-family: Arial, sans-serif;">
        <h1>JavaScript Required</h1>
        <p>This page requires JavaScript to function properly.</p>
        <p>Please enable JavaScript in your browser settings.</p>
    </div>
</noscript>
'@

# Add fallback if not present
if ($content -notmatch '<noscript>') {
    if ($content -match '<body[^>]*>') {
        $content = $content -replace '(<body[^>]*>)', "`$1`n$fallbackContent"
        Write-Host "  Added noscript fallback" -ForegroundColor Green
    }
}

# Add a simple visible element to test rendering
$testElement = @'
<div id="page-loaded" style="display: none; padding: 20px; background: #f0f0f0; text-align: center;">
    <h1>Page is Loading...</h1>
    <p>If you see this, the HTML is rendering correctly.</p>
</div>
<script>
// Simple test to show page is working
document.addEventListener('DOMContentLoaded', function() {
    console.log('✅ Page loaded successfully!');
    var testDiv = document.getElementById('page-loaded');
    if (testDiv) {
        testDiv.style.display = 'block';
        setTimeout(function() {
            testDiv.style.display = 'none';
        }, 3000);
    }
});
</script>
'@

# Add test element if body exists
if ($content -match '<body[^>]*>') {
    if ($content -notmatch 'id="page-loaded"') {
        $content = $content -replace '(<body[^>]*>)', "`$1`n$testElement"
        Write-Host "  Added page load test element" -ForegroundColor Green
    }
}

# Save the file
$content | Set-Content $filePath -NoNewline -Encoding UTF8
Write-Host "`n✅ File updated!" -ForegroundColor Green

Write-Host "`n=== What to Do Next ===" -ForegroundColor Cyan
Write-Host "1. Commit and push this file to GitHub"
Write-Host "2. Make sure GitHub Pages is enabled (Settings → Pages)"
Write-Host "3. Wait 5-10 minutes"
Write-Host "4. Visit: https://YOUR_USERNAME.github.io/REPO_NAME/"
Write-Host "5. Open browser console (F12) and check for errors"
Write-Host "6. You should see 'Page is Loading...' message briefly"
Write-Host ""
Write-Host "If still blank, check browser console for specific errors!" -ForegroundColor Yellow

