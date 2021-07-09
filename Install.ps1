$ErrorActionPreference = "Stop";

# Source variables
. $PSScriptRoot\variables.ps1;

# Install local pkg
InstallLocal.ps1 $pkg_name $main_dir;
