@echo off
title Virophage.Setup
color 2F
set Virophage.Source = %~dp0
if not exist c:\acr\bat\nircmdc.exe xcopy "%Virophage.Source%bat\nircmdc.exe" "c:\acr\bat\*" /dsiy
c:\acr\bat\nircmdc.exe win setsize ititle "Virophage.Setup" 0 451 400 100
set virdir=C:\acr\
set virver=v100
for /f "delims=" %%x in (%virvar%job.number.var) do set "job.number=%%x"
for /f "delims=" %%x in (%virvar%first.name.var) do set "first.name=%%x"
for /f "delims=" %%x in (%virvar%last.name.var) do set "last.name=%%x"
set logname="ACR%job.number%Log"
set virlog="c:\acr\ACR%job.number%Log.txt"
set virapp=%virdir%app\
set virbat=%virdir%bat\
set virzip=%virdir%zip\
set virvar=%virdir%var\
if not exist %virdir%var md %virdir%var
if not exist %virdir%bak md %virdir%bak
cls
rem end header

::Start updates of application files to source
if exist %Virophage.Source%app\update.server.apps.bat start "Updating Source Files" "%Virophage.Source%app\update.server.apps.bat" else echo Could not update server apps

::ALPHA
if "%~dp0"=="%Virophage.Source%" echo 1 >"c:\acr\var\alpha.var"
if exist "c:\acr\var\alpha.var" goto run.alpha.setup
goto skip.alpha.setup

:run.alpha.setup
if not "%~dp0"=="%Virophage.Source%" start "" "C:\acr\bat\alphasetup.lnk"
if not "%~dp0"=="%Virophage.Source%" goto exit

:skip.alpha.setup
rem name source, folder that setup was run from
echo %~dp0>c:\acr\var\source.var
echo %date% %time% >%virvar%last.updated.var


::Determine Initialize or Download
if exist "%~dp0bat\virophage.bat" goto initialize
echo %~dp0bat\
goto virdown

:initialize
echo Initializing

xcopy "%~dp0bat\*" "%virdir%bat" /dsiy

:skip.chrome
xcopy "%virdir%bat\Virophage.lnk" "%virdir%" /dsiy
xcopy "%virdir%bat\Virophage.lnk" "C:\Windows\system32\" /dsiy
xcopy "%virdir%bat\alphasetup.lnk" "c:\windows\system32\" /dsiy
start /min "Otto" "c:\acr\bat\otto.main.bat"
start "Virophage" "%virdir%Virophage.lnk"
color 17
c:\acr\bat\nircmdc.exe win setsize ititle "Virophage Setup" 651 0 650 800
xcopy "%~dp0app\wget.exe" "%virapp%" /dsiy
xcopy "%~dp0app\CCleaner.exe" "%virapp%" /dsiy
xcopy "%~dp0app\freshupdates.exe" "%virapp%" /dsiy
xcopy "%~dp0app\newupdates.exe" "%virapp%" /dsiy
xcopy "%~dp0app\*" "%virdir%app" /dsiy
xcopy "%~dp0fix\*" "%virdir%fix" /dsiy
xcopy "%~dp0rmv\*" "%virdir%rmv" /dsiy
timeout /t 10
goto exit

:virdown
echo Can't find Virophage Server
pause
goto exit
echo Downloading
timeout /t 3
xcopy "%~dp0wget.exe" "%virbat%" /dsiy
wget -NP c:\acr\ "http://dl.dropbox.com/u/48424618/Virophagev100/bat/Virophage v100.lnk" --no-check-certificate
wget -NP c:\acr\bat "http://dl.dropbox.com/u/48424618/Virophagev100/bat/virophage.bat" --no-check-certificate
wget -NP c:\acr\bat "http://dl.dropbox.com/u/48424618/Virophagev100/bat/install.bat" --no-check-certificate
start "Virophage %virver%" "%virdir%Virophage v100.lnk"
start "Installing" "%virbat%install.bat"
:exit