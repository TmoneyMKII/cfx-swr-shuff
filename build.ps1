# Copies only the files the server needs into production/cfx-swr-shuff.
# Drop that folder into your server's resources directory.
# -LiteralPath everywhere: the repo lives under [SCRIPTS], and PowerShell
# treats square brackets as wildcards otherwise.
$ErrorActionPreference = 'Stop'

$root = $PSScriptRoot
$out  = Join-Path $root 'production\cfx-swr-shuff'

$files = @(
    'fxmanifest.lua',
    'config.lua',
    'client\client.lua',
    'client\target.lua'
)

if (Test-Path -LiteralPath $out) { Remove-Item -LiteralPath $out -Recurse -Force }

foreach ($file in $files) {
    $dest = Join-Path $out $file
    New-Item -ItemType Directory -Force -Path ([Management.Automation.WildcardPattern]::Escape((Split-Path $dest))) | Out-Null
    Copy-Item -LiteralPath (Join-Path $root $file) -Destination ([Management.Automation.WildcardPattern]::Escape($dest))
}

Write-Host "Built $out"
