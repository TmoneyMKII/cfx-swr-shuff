# Rebuilds production/cfx-swr-shuff with only the files FiveM needs at runtime.
# Run from the repo root:  powershell -File .\build-production.ps1
# (-LiteralPath everywhere: the [SCRIPTS] folder name would otherwise be read as a wildcard.)

$root = $PSScriptRoot
$out = Join-Path $root 'production\cfx-swr-shuff'

if (Test-Path -LiteralPath $out) { Remove-Item -LiteralPath $out -Recurse -Force }
New-Item -ItemType Directory -Path $out | Out-Null

# Everything the manifest references
$items = @('fxmanifest.lua', 'config.lua', 'client')

foreach ($item in $items) {
    Copy-Item -LiteralPath (Join-Path $root $item) -Destination $out -Recurse -Force
}

Write-Host "Built $out"
