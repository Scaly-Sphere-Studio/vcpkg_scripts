$ErrorActionPreference = "Stop";

# Source variables
. $PSScriptRoot\variables.ps1;

# Export sources
$date = $(Get-Date -UFormat %s).Split(",")[0];
Create-Port $vcpkg_name local_$date $main_dir;

# Install pkg
Pkg-Install $vcpkg_name;