$ErrorActionPreference = "Stop";

# Source variables
. $PSScriptRoot\variables.ps1;

# Remove local pkg
UninstallLocal.ps1 "$pkg_name";
