$ErrorActionPreference = "Stop";

# Source variables
. $PSScriptRoot\sub_scripts\variables.ps1;

# Expand PATH with VCPKG_OVERLAY script path
$env:PATH += ";$path_ext";

# Remove local pkg
UninstallLocal.ps1 "$pkg_name";
