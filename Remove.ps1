$ErrorActionPreference = "Stop";

# Source variables
. $PSScriptRoot\variables.ps1;

# Check if pkg is installed
$to_remove = @();
$installed = Pkg-List $vcpkg_name;
if (!$installed) {
    Write-Warning "'$vcpkg_name' is not installed."
    return;
}

# Retrieve local versions
$installed | %{
    $version = ((vcpkg list $_).Split(" ") | ?{$_})[1];
    if ($version -match "local_") {
        $to_remove += $_;
    }
}

if (!$to_remove) {
    Write-Warning "'$vcpkg_name' is installed, but as a release version and not locally."
    return;
}

# Remove pkg
vcpkg remove $to_remove;
