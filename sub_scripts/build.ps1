$ErrorActionPreference = "Stop";

# Source pkg parameters
. $PSScriptRoot\variables.ps1;

# Visual Studio parameters
$vcxproj    = Resolve-Path "$main_dir\$repo_name.vcxproj";
$vc_dir     = (Get-CimInstance MSFT_VSInstance).InstallLocation;
if (!(Test-Path $vc_dir)) {
    $msg = "Could not find Microsoft Visual Studio.";
    Write-Error $msg;
}
$vc_varsall = "$vc_dir\VC\Auxiliary\Build\vcvarsall.bat"
$vc_build_project   = "devenv $vcxproj /Project $repo_name /Build"

# List of configs to build
$jobs = @(
    "`"Debug|x86`"",
    "`"Release|x86`"",
    "`"Debug|x64`"",
    "`"Release|x64`""
)

# Build configs in threads
$jobs | %{
    $cmd = "`"$vc_varsall`" x64 >NUL && $vc_build_project $_";
    $script = {
        param([Parameter()] [string] $arg);
        CMD /c $arg;
    }
    $_ = Start-Job -Name $_ -ScriptBlock $script -ArgumentList $cmd;
    $_;
}
Write-Host "";

# Wait end of all threads
Wait-Job $jobs | Out-Null;

# Format and display outputs
$success = 1;
$jobs | %{
    $output = Receive-Job $_;
    $output;
    $result = $output.Split("\n")[-1];
    if ($result -like "*0 failed*") {
        Write-Host -ForegroundColor green "Build $_ succeeded.";
    }
    else {
        Write-Host -ForegroundColor red "Build $_ failed";
        $success = 0;
    }
    Remove-Job $_;
}
Write-Host "";

if (!$success) {
    Write-Error "One or more build(s) failed.";
}
