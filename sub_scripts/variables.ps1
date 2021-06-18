# Local existing directories
$main_dir   = Resolve-Path "$PSScriptRoot\..";
$inc_dir    = "$main_dir\inc";

# Repo name taken from the git http
$repo_name  = (git --git-dir="$main_dir\.git" config --get remote.origin.url `
    ).Split('/')[-1].Split('.')[0].ToLower();

# Package name
$pkg_name   = "sss-$repo_name";

# Export directory and archive, to be created
$export_dir = "$main_dir\export"
$pkg_dir    = "$export_dir\$pkg_name"
$export_zip = "$export_dir\$pkg_name.zip"

# Path extension to access scripts from VCPKG_OVERLAY_PORTS
$path_ext   = $env:VCPKG_OVERLAY_PORTS.Split(';') `
    | %{Resolve-Path "$_\.."} | select -Unique | %{"$_;"};
