# This scripts builds (visual studio), exports (.zip), and installs (vcpkg)
# the package from which this script is called.

$ErrorActionPreference = "Stop";

# Source variables
. $PSScriptRoot\sub_scripts\variables.ps1;

# Export project
. $PSScriptRoot\sub_scripts\export.ps1;
Write-Host "";

# Expand PATH with VCPKG_OVERLAY script path
$env:PATH += ";$path_ext";

# Install local pkg
InstallLocal.ps1 "$pkg_name" "$export_zip";
