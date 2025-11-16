$filePath = 'c:\Users\Elizabeth\Downloads\index.html'
$content = Get-Content $filePath -Raw

# Count occurrences before replacement
$countBefore = ([regex]::Matches($content, 'Youtube', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)).Count
Write-Host "Found $countBefore occurrences of 'Youtube' (case-insensitive)"

# Perform replacement (case-sensitive first, then case variations)
$newContent = $content -replace 'Youtube', 'Utube'
$newContent = $newContent -replace 'youtube', 'utube'
$newContent = $newContent -replace 'YOUTUBE', 'UTUBE'
$newContent = $newContent -replace 'YouTube', 'Utube'

# Save the file
$newContent | Set-Content $filePath -NoNewline

# Verify replacement
$contentAfter = Get-Content $filePath -Raw
$countAfter = ([regex]::Matches($contentAfter, 'Youtube', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)).Count

if ($countAfter -eq 0) {
    Write-Host "SUCCESS: All occurrences replaced. Found 0 remaining instances."
} else {
    Write-Host "WARNING: Still found $countAfter occurrences"
}

