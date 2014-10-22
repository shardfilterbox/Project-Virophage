@echo off
color 4f
set virdir=C:\acr\
for /f "delims=" %%x in (%virvar%job.number.var) do set "job.number=%%x"
set logname=ACR%job.number%Log
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