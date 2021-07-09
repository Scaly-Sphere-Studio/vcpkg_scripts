# Local directory root
$main_dir   = Resolve-Path "$PSScriptRoot\..";

# Repo name taken from the git http
$repo_name  = (git --git-dir="$main_dir\.git" config --get remote.origin.url `
    ).Split('/')[-1].Split('.')[0].ToLower();

# Package name
$pkg_name   = "sss-$repo_name";

# Path extension to access scripts from VCPKG_OVERLAY_PORTS
$path_ext   = $env:VCPKG_OVERLAY_PORTS.Split(';') `
    | %{Resolve-Path "$_\.."} | select -Unique | %{"$_;"};
$env:PATH   += ";$path_ext";