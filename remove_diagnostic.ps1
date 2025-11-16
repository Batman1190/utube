$filePath = 'c:\Users\Elizabeth\Downloads\index.html'
$content = Get-Content $filePath -Raw

Write-Host "Removing diagnostic box..." -ForegroundColor Cyan

# Remove the diagnostic box
$content = $content -replace '<div id="page-content-check"[^>]*>.*?</div>', '', 'Singleline'
$content = $content -replace '<script>[\s\S]*?page-content-check[\s\S]*?</script>', ''

# Clean up any remaining diagnostic code
$content = $content -replace '// Ensure body is visible[\s\S]*?setTimeout.*?}, 5000\);[\s\S]*?}\)\);', ''

$content | Set-Content $filePath -NoNewline -Encoding UTF8
Write-Host "Done! Diagnostic box removed." -ForegroundColor Green
Write-Host "Note: The box was set to auto-hide after 5 seconds anyway." -ForegroundColor Yellow

