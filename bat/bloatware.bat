@echo off
color 4f
set virdir=C:\acr\

::Set Log Name
for /f "delims=" %%x in (%virvar%job.number.var) do set "job.number=%%x"
for /f "delims=" %%x in (%virvar%first.name.var) do set "first.name=%%x"
for /f "delims=" %%x in (%virvar%last.name.var) do set "last.name=%%x"
set logname=ACR%first.name%%last.name%%job.number%
set virlog="c:\acr\%logname%.txt"

set virapp=%virdir%app\
set virbat=%virdir%bat\



echo Removing Bing Bar
if "C:\Program Files (x86)\Microsoft\BingBar\Installers\BingBar7.0.610\BingBar.msi" == EXIST Msiexec /uninstall "C:\Program Files (x86)\Microsoft\BingBar\Installers\BingBar7.0.610\BingBar.msi"
if exist "C:\Program Files\Bing Bar Installer\InstallManager.exe" "C:\Program Files\Bing Bar Installer\InstallManager.exe" /UNINSTALL /silent
if exist "C:\Program Files (x86)\Bing Bar Installer\InstallManager.exe" "C:\Program Files x86\Bing Bar Installer\InstallManager.exe" /UNINSTALL /silent

echo Removing StartNow Toolbar
"C:\Program Files (x86)\StartNow Toolbar\StartNowToolbarUninstall.exe"
:exit
exit