# Path to vcvars64.bat
$vcvars = "C:\Program Files (x86)\Microsoft Visual Studio\18\BuildTools\VC\Auxiliary\Build\vcvars64.bat"

if (!(Test-Path $vcvars)) {
    Write-Error "vcvars64.bat が見つかりません: $vcvars"
    exit 1
}

# Run vcvars64.bat inside cmd.exe and capture environment variables
$envOutput = cmd /c "`"$vcvars`" && set"

# Extract INCLUDE, LIB, LIBPATH
$include = ($envOutput | Select-String "^INCLUDE=").ToString().Substring(8)
$lib     = ($envOutput | Select-String "^LIB=").ToString().Substring(4)
$libpath = ($envOutput | Select-String "^LIBPATH=").ToString().Substring(8)

Write-Host "INCLUDE: $include"
Write-Host "LIB:     $lib"
Write-Host "LIBPATH: $libpath"

# Write environment variables permanently (User scope)
[Environment]::SetEnvironmentVariable('INCLUDE',$include,'User')
[Environment]::SetEnvironmentVariable('LIB',$lib,'User')
[Environment]::SetEnvironmentVariable('LIBPATH',$libpath,'User')

Write-Host "ユーザ環境変数へ永続登録しました。"
