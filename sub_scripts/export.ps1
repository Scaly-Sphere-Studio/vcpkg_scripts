$ErrorActionPreference = "Stop";

# Source pkg parameters
. $PSScriptRoot\variables.ps1;

# Build all binaries
. $PSScriptRoot\build.ps1

# Create (or recreate) export dir
if (Test-Path $export_dir) {
    Remove-Item -Recurse -Force $export_dir
}
New-Item -ItemType directory $pkg_dir | Out-Null;

# Copy binaries and headers, along with vcpkg files
Copy-Item -Recurse -Path "$main_dir\Debug"       -Destination "$pkg_dir\Debug";
Copy-Item -Recurse -Path "$main_dir\Release"     -Destination "$pkg_dir\Release";
Copy-Item -Recurse -Path "$main_dir\x64\Debug"   -Destination "$pkg_dir\x64\Debug";
Copy-Item -Recurse -Path "$main_dir\x64\Release" -Destination "$pkg_dir\x64\Release";
Copy-Item -Recurse -Path "$inc_dir"              -Destination "$pkg_dir\include";
Copy-Item -Recurse -Path "export_files\*"        -Destination "$pkg_dir";
Copy-Item -Recurse -Path "$main_dir\CONTROL"     -Destination "$pkg_dir";

# Create export archive
Compress-Archive -Path "$pkg_dir" -DestinationPath "$export_zip"

# Output success
Write-Host "vcpkg export archive ready at: '$export_zip'";
