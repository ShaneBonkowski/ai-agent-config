[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)][string]$Target,
    [ValidateSet('python', 'typescript', 'both', 'none')][string]$Language = 'both',
    [string[]]$Agents = @('orchestrator', 'pragmatic-coder', 'focused-debugger', 'reviewer')
)

$ErrorActionPreference = 'Stop'
$sourceRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$targetRoot = (Resolve-Path -LiteralPath $Target).Path
$validAgents = @('orchestrator', 'pragmatic-coder', 'focused-debugger', 'reviewer')
foreach ($agent in $Agents) {
    if ($agent -notin $validAgents) { throw "Unknown agent '$agent'. Valid agents: $($validAgents -join ', ')" }
}

$files = @(@{ From = 'AGENTS.md'; To = 'AGENTS.md' })
if ($Language -in @('python', 'both')) {
    $files += @{ From = 'instructions/python.instructions.md'; To = '.github/instructions/python.instructions.md' }
}
if ($Language -in @('typescript', 'both')) {
    $files += @{ From = 'instructions/typescript.instructions.md'; To = '.github/instructions/typescript.instructions.md' }
}
foreach ($agent in $Agents) {
    $files += @{ From = "agents/$agent.agent.md"; To = ".github/agents/$agent.agent.md" }
}

$installed = 0
$skipped = @()
foreach ($file in $files) {
    $src = Join-Path $sourceRoot $file.From
    $dest = Join-Path $targetRoot $file.To
    if (Test-Path -LiteralPath $dest) {
        $skipped += $file.To
        Write-Host "Skipped existing $($file.To)"
        continue
    }
    $destDir = Split-Path -Parent $dest
    New-Item -ItemType Directory -Path $destDir -Force | Out-Null
    Copy-Item -LiteralPath $src -Destination $dest
    Write-Host "Installed $($file.To)"
    $installed++
}
Write-Host "Installation complete: $installed installed; $($skipped.Count) skipped. Existing files were not overwritten."
if ($skipped.Count -gt 0) {
    Write-Host "Skipped files (reconcile manually if desired):"
    $skipped | ForEach-Object { Write-Host "  $_" }
}
Write-Host 'Files are independent copies; future changes are manual.'
