<#
.SYNOPSIS
    Pins Git's global config to the local profile and sets commit identity.
.DESCRIPTION
    On machines where HOMEDRIVE/HOMEPATH points to a network share (e.g. H:\),
    Git for Windows reads its global .gitconfig from there. When the share is
    slow/unreachable, commits fail with "Author identity unknown".
    This script sets GIT_CONFIG_GLOBAL (User scope) to %USERPROFILE%\.gitconfig,
    re-adds Git LFS filters and sets user.name / user.email.
    Restart VS Code afterwards so it picks up the environment variable.
#>
param(
    [string]$Name = 'David Christiansson',
    [string]$Email = 'david@christiansson.name'
)

$cfg = Join-Path $env:USERPROFILE '.gitconfig'

[Environment]::SetEnvironmentVariable('GIT_CONFIG_GLOBAL', $cfg, 'User')
$env:GIT_CONFIG_GLOBAL = $cfg

git lfs install
git config --global user.name  $Name
git config --global user.email $Email

git config --global --list --show-origin
Write-Host "Done. Restart VS Code (all windows) to pick up GIT_CONFIG_GLOBAL." -ForegroundColor Green
