$filePath = 'c:\Users\Elizabeth\Downloads\index.html'
$content = Get-Content $filePath -Raw

# Search for hamburger/menu button patterns
Write-Host "Searching for menu button patterns..."
$patterns = @('guide-icon', 'yt-icon-button', 'hamburger', 'menu.*button', 'button.*menu', 'ytd-masthead', 'masthead')

foreach ($pattern in $patterns) {
    $matches = [regex]::Matches($content, $pattern, [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
    if ($matches.Count -gt 0) {
        Write-Host "Found $($matches.Count) matches for pattern: $pattern"
    }
}

# Check if there's a sidebar or guide section
if ($content -match 'ytd-app|ytd-guide|sidebar') {
    Write-Host "Found YouTube app structure detected"
}

# Check file size
Write-Host "`nFile size: $([math]::Round($content.Length / 1MB, 2)) MB"
Write-Host "File length: $($content.Length) characters"

