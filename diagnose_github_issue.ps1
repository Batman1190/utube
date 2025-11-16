$filePath = 'c:\Users\Elizabeth\Downloads\index.html'
$content = Get-Content $filePath -Raw

Write-Host "=== GitHub Pages Diagnostic ===" -ForegroundColor Cyan
Write-Host ""

# Check file size
$fileSize = [math]::Round($content.Length / 1MB, 2)
Write-Host "File size: $fileSize MB" -ForegroundColor Yellow
if ($fileSize -gt 1) {
    Write-Host "WARNING: File is very large. GitHub Pages may have issues." -ForegroundColor Red
}

# Check HTML structure
Write-Host "`nChecking HTML structure..." -ForegroundColor Cyan
$hasDoctype = $content -match '<!doctype'
$hasHtml = $content -match '<html'
$hasHead = $content -match '<head>'
$hasBody = $content -match '<body>'
$hasClosingBody = $content -match '</body>'
$hasClosingHtml = $content -match '</html>'

Write-Host "  DOCTYPE: $(if ($hasDoctype) { '✓' } else { '✗' })"
Write-Host "  <html>: $(if ($hasHtml) { '✓' } else { '✗' })"
Write-Host "  <head>: $(if ($hasHead) { '✓' } else { '✗' })"
Write-Host "  <body>: $(if ($hasBody) { '✓' } else { '✗' })"
Write-Host "  </body>: $(if ($hasClosingBody) { '✓' } else { '✗' })"
Write-Host "  </html>: $(if ($hasClosingHtml) { '✓' } else { '✗' })"

# Check for common issues
Write-Host "`nChecking for common issues..." -ForegroundColor Cyan

# Check if file is minified (single line)
$lines = (Get-Content $filePath).Count
Write-Host "  Total lines: $lines"
if ($lines -lt 10) {
    Write-Host "  WARNING: File appears to be minified (very few lines)" -ForegroundColor Yellow
}

# Check for script errors
if ($content -match 'console\.(error|warn)') {
    Write-Host "  Found console errors/warnings" -ForegroundColor Yellow
}

# Check for external resources
if ($content -match 'https?://[^"''\s]+') {
    $externalUrls = [regex]::Matches($content, 'https?://[^"''\s]+')
    Write-Host "  Found $($externalUrls.Count) external URLs"
    if ($externalUrls.Count -gt 0) {
        Write-Host "  WARNING: External resources may be blocked by CORS" -ForegroundColor Yellow
    }
}

# Check for inline scripts
$scriptCount = ([regex]::Matches($content, '<script', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)).Count
Write-Host "  Found $scriptCount script tags"

Write-Host "`n=== Recommendations ===" -ForegroundColor Green
Write-Host "1. Ensure index.html is in the root of your repository"
Write-Host "2. Enable GitHub Pages in repository settings"
Write-Host "3. Check browser console for JavaScript errors"
Write-Host "4. Verify the file is not corrupted"
Write-Host "5. Try accessing via: https://YOUR_USERNAME.github.io/REPO_NAME/"

