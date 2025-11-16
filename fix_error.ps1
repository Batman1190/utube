$content = Get-Content 'c:\Users\Elizabeth\Downloads\index.html'
$line24 = $content[23]
$newLine = $line24 -replace '}}\)</script>', '}});</script>'
$content[23] = $newLine
$content | Set-Content 'c:\Users\Elizabeth\Downloads\index.html' -NoNewline
Write-Host "Fixed: Added semicolon before </script> tag"

