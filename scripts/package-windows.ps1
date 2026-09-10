<#
.SYNOPSIS
  Zips a built Windows app into something a person can download and run.

.DESCRIPTION
  A Windows Flutter app is a folder, not a file. The executable needs
  flutter_windows.dll, every plugin's DLL and the whole data directory beside
  it, and none of that is inside the .exe -- so shipping the executable alone
  produces a download that fails to start with a dialog naming a DLL.

  One script rather than a copy in each workflow. The release workflow, the
  development build and CI all package the same way, which also means the
  packaging that a release depends on has already run on every pull request
  before any release needs it.

.PARAMETER Stem
  The name to build the archive around, e.g. kyron-0.1.0+42. The archive
  becomes <Stem>-windows-x64.zip.

.PARAMETER OutputDirectory
  Where to write the archive. Created if it is not there.

.PARAMETER Configuration
  Which build to package. Release unless you have a reason: a Debug build links
  against the Visual C++ debug runtime, which ships with Visual Studio and not
  with Windows, so a Debug zip does not start on an ordinary machine.
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory = $true)] [string] $Stem,
  [string] $OutputDirectory = 'release-artifacts',
  [string] $Configuration = 'Release'
)

$ErrorActionPreference = 'Stop'

# Located rather than spelled out. Flutter moved this from build/windows to
# build/windows/x64 once already, and a hard-coded path that stops matching
# would package nothing and say nothing.
$exe = Get-ChildItem -Recurse -Filter kyron.exe -Path app/build/windows |
       Where-Object { $_.DirectoryName -match [regex]::Escape($Configuration) } |
       Select-Object -First 1

if (-not $exe) {
  throw "No $Configuration kyron.exe under app/build/windows. Did the build run?"
}

$built = $exe.DirectoryName
Write-Host "packaging $built"

# Staged under a folder with a name, so unzipping does not scatter a hundred
# DLLs across whatever directory the download landed in.
$staging = Join-Path (Get-Location) 'staging'
if (Test-Path $staging) { Remove-Item -Recurse -Force $staging }
$inside = Join-Path $staging 'Kyron'
New-Item -ItemType Directory -Force -Path $inside | Out-Null
Copy-Item -Path (Join-Path $built '*') -Destination $inside -Recurse -Force

# What has to be in there for it to start on somebody else's machine. Checked
# because a package missing any of it still zips perfectly and only fails
# where nobody is watching.
$required = @('kyron.exe', 'flutter_windows.dll', 'data')
foreach ($name in $required) {
  if (-not (Test-Path (Join-Path $inside $name))) {
    throw "$name is missing from the package, which would not start."
  }
}

New-Item -ItemType Directory -Force -Path $OutputDirectory | Out-Null
$archive = Join-Path $OutputDirectory "$Stem-windows-x64.zip"
if (Test-Path $archive) { Remove-Item -Force $archive }
Compress-Archive -Path $inside -DestinationPath $archive

$size = [math]::Round((Get-Item $archive).Length / 1MB, 1)
Write-Host "wrote $archive ($size MB)"
