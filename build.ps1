# Source pkg parameters
. $PSScriptRoot\variables.ps1;

# Visual Studio parameters
$vcxproj    = Resolve-Path "$pkg_dir\$repo_name.vcxproj";
$vc_dir     = "C:\Program Files (x86)\Microsoft Visual Studio";
$vc_version = "2019";
$vc_edition = "Community";
$vc_varsall = "$vc_dir\$vc_version\$vc_edition\VC\Auxiliary\Build\vcvarsall.bat"
$vc_build_project   = "devenv $vcxproj /Project $repo_name /Build"

# Prepare batch command to set Visual C++ env and build the project
$batch_cmd  = "`"$vc_varsall`" x64";
$batch_cmd += " && $vc_build_project `"Debug|x86`"";
$batch_cmd += " && $vc_build_project `"Release|x86`"";
$batch_cmd += " && $vc_build_project `"Debug|x64`"";
$batch_cmd += " && $vc_build_project `"Release|x64`"";

# Call batch command
CMD /c $batch_cmd
