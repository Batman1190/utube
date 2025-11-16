$content = Get-Content 'c:\Users\Elizabeth\Downloads\index.html'
$line24 = $content[23]
Write-Host "Checking for the problematic pattern..."
$idx = $line24.IndexOf('}})</script>')
if ($idx -ge 0) {
    Write-Host "ERROR: Still found '}})</script>' at position: $idx"
    Write-Host "Attempting fix..."
    $newLine = $line24 -replace '}}\)</script>', '}});</script>'
    $content[23] = $newLine
    $content | Set-Content 'c:\Users\Elizabeth\Downloads\index.html' -NoNewline
    Write-Host "Fix applied. Verifying..."
    $content2 = Get-Content 'c:\Users\Elizabeth\Downloads\index.html'
    $line24new = $content2[23]
    $idx2 = $line24new.IndexOf('}})</script>')
    if ($idx2 -ge 0) {
        Write-Host "ERROR: Pattern still exists after fix attempt"
    } else {
        Write-Host "SUCCESS: Pattern fixed - semicolon added"
    }
} else {
    Write-Host "Pattern not found - may already be fixed or pattern is different"
    $idx3 = $line24.IndexOf('}});</script>')
    if ($idx3 -ge 0) {
        Write-Host "Found fixed version at position: $idx3"
    }
}

