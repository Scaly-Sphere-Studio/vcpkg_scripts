# Local existing directories
$pkg_dir    = Resolve-Path "$PSScriptRoot\..";
$inc_dir    = "$pkg_dir\inc";

# Repo name taken from the git http
$repo_name  = (git --git-dir="$pkg_dir\.git" config --get remote.origin.url `
    ).Split('/')[-1].Split('.')[0].ToLower();

# Package name
$pkg_name   = "sss-$repo_name";

# Export directory and archive, to be created
$export_dir = "$pkg_dir\export"
$export_pkg = "$export_dir\$pkg_name"
$export_zip = "$export_dir\$pkg_name.zip"

# Path extension to access scripts from VCPKG_OVERLAY_PORTS
$path_ext   = $env:VCPKG_OVERLAY_PORTS.Split(';') `
    | %{Resolve-Path "$_\.."} | select -Unique | %{"$_;"};