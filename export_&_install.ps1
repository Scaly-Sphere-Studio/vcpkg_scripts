$ErrorActionPreference = "Stop";

# Source variables
. $PSScriptRoot\variables.ps1;

# Export project
. $PSScriptRoot\export.ps1;
Write-Host "";

# Expand PATH with script path
$env:PATH += ";$path_ext";

# Install local pkg
InstallLocal.ps1 "$pkg_name" "$export_zip";
