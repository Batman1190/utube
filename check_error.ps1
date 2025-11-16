$content = Get-Content 'c:\Users\Elizabeth\Downloads\index.html'
$line24 = $content[23]
Write-Host "Searching for the problematic pattern..."
$idx = $line24.IndexOf('}})</script>')
if ($idx -ge 0) {
    Write-Host "Found '}})</script>' at position: $idx"
    Write-Host "`nFull context (100 chars before):"
    $start = [Math]::Max(0, $idx - 100)
    $line24.Substring($start, $idx - $start + 10)
}

