
chcp 65001 

@REM powershell
@REM # - if (-not (Test-Path -Path ".\tools\onescript-version-manager")) {New-Item -Path ".\tools\onescript-version-manager" -ItemType Directory}
@REM # - choco install -r --no-progress curl -y
@REM # - curl -L "$OVM_DOWNLOAD_URL" --output ".\tools\onescript-version-manager\ovm.exe"
@REM # - .\tools\onescript-version-manager\ovm install -c $OVM_INSTALL_VERSION 
@REM # - .\tools\onescript-version-manager\ovm use $OVM_USE_VERSION
@REM # - .\tools\onescript-version-manager\ovm which current
@REM # - curl -L "$OPM_DOWNLOAD_URL" --output ".\tools\onescript-version-manager\opm.ospx"
@REM # - opm install -f ".\tools\onescript-version-manager\opm.ospx"

call mkdir ".\tools\onescript-version-manager"
call choco install -r --no-progress curl -y
call curl.exe -L %OVM_DOWNLOAD_URL% --output ".\tools\onescript-version-manager\ovm.exe"
call .\tools\onescript-version-manager\ovm install -c %OVM_INSTALL_VERSION%
call .\tools\onescript-version-manager\ovm use %OVM_USE_VERSION%
call .\tools\onescript-version-manager\ovm which current
@REM call curl -L %OPM_DOWNLOAD_URL% --output ".\tools\onescript-version-manager\opm.ospx"
@REM call opm install -f ".\tools\onescript-version-manager\opm.ospx"