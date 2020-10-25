# Source pkg parameters
. $PSScriptRoot\variables.ps1;

# Visual Studio parameters
$vcxproj    = Resolve-Path "$pkg_dir\$repo_name.vcxproj";
$vc_dir     = "C:\Program Files (x86)\Microsoft Visual Studio";
$vc_version = "2019";
$vc_edition = "Community";
$vc_varsall = "$vc_dir\$vc_version\$vc_edition\VC\Auxiliary\Build\vcvarsall.bat"
$vc_build_project   = "devenv $vcxproj /Project $repo_name /Build"

# List of configs to build
$configs = @(
    "`"Debug|x86`"",
    "`"Release|x86`"",
    "`"Debug|x64`"",
    "`"Release|x64`""
)

# Build configs in threads
$configs | %{
    $cmd = "`"$vc_varsall`" x64 && $vc_build_project $_";
    $script = {
        param([Parameter()] [string] $arg);
        CMD /c $arg;
    }
    Start-Job -Name $_ -ScriptBlock $script -ArgumentList $cmd;
}
"";

# Wait end of all threads
Get-Job | Wait-Job

# Format and display outputs
$configs | %{
    "";"";$_;
    Get-Job -Name $_ | Receive-Job;
}