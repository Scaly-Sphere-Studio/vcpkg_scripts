# Local directory root
$main_dir   = Resolve-Path "$PSScriptRoot\..";

# Repo name taken from the git http
$repo_name  = (git --git-dir="$main_dir\.git" config --get remote.origin.url `
    ).Split('/')[-1].Split('.')[0].ToLower();

# Package name
$vcpkg_name   = "sss-$repo_name";

# Source our fonctions from the VCPKG_OVERLAY_PORTS repo
$path_ext = $env:VCPKG_OVERLAY_PORTS.Split(';') `
    | %{Resolve-Path "$_\..\internal"} | select -Unique | %{"$_;"};
$env:path += ";$path_ext";
. Functions.ps1;