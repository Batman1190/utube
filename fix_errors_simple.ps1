$filePath = 'c:\Users\Elizabeth\Downloads\index.html'
$content = Get-Content $filePath -Raw

Write-Host "Fixing console errors..." -ForegroundColor Cyan

# Fix 1: Remove manifest.webmanifest link
$content = $content -replace '<link[^>]*manifest\.webmanifest[^>]*>', ''

# Fix 2: Remove generate_204 preload
$content = $content -replace '<link[^>]*generate_204[^>]*>', ''

# Fix 3: Add error suppression script
$errorScript = '<script>window.addEventListener("error",function(e){if(e.target&&(e.target.href&&e.target.href.includes("manifest")||e.target.src&&e.target.src.includes("manifest"))){e.preventDefault();return true;}},true);</script>'

if ($content -match '</head>') {
    $content = $content -replace '</head>', "$errorScript`n</head>"
}

# Save
$content | Set-Content $filePath -NoNewline -Encoding UTF8
Write-Host "Done! Fixed manifest and preload errors." -ForegroundColor Green

