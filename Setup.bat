@echo off
color 4f

::Make Structure
if not exist c:\acr md c:\acr
if not exist c:\acr\bat md c:\acr\bat

::Begin Header
::Call header.bat
xcopy "%~dp0bat\header.bat" "c:\acr\bat" /dsiy
set window.name=%~nx0
CALL c:\acr\bat\header.bat %~nx0

set Virophage.Source = %~dp0
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
::End Header

::Install Chocolatey
if not exist "C:\ProgramData\chocolatey\bin" @powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
if exist "C:\ProgramData\chocolatey\bin" echo Chocolatey already installed

::Determine Initialize or Download
if exist "%~dp0bat\virophage.main.window.bat" goto initialize
echo %~dp0bat\
goto virdown

:initialize
echo Initializing

xcopy "%~dp0bat\*" "%virdir%bat" /dsiy

::Chrome
echo Close Ninite when it finishes installing Chrome
if exist "%localappdata%\google\Chrome\Application\chrome.exe" goto skip.chrome
if exist "C:\Program Files\Google\Chrome\Application\chrome.exe" goto skip.chrome
if exist "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" goto skip.chrome
if exist "%userprofile%\Local Settings\Application Data\Google\Chrome\Application\chrome.exe" goto skip.chrome
"%virdir%bat\chrome.ninite.exe"

:skip.chrome
xcopy "%virdir%bat\Virophage.lnk" "%virdir%" /dsiy
xcopy "%virdir%bat\Virophage.lnk" "C:\Windows\system32\" /dsiy
start /min "Otto" "c:\acr\bat\otto.main.bat"
start "Virophage" "%virdir%Virophage.lnk"
color 04
if not exist c:\acr\bat\nircmdc.exe xcopy "%Virophage.Source%bat\nircmdc.exe" "c:\acr\bat\*" /dsiy

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