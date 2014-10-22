REM ===== START HEADER =====
@echo off
color 4f
set virdir=C:\acr\
for /f "delims=" %%x in (%virvar%job.number.var) do set "job.number=%%x"
set logname=ACR%job.number%Log
set virapp=%virdir%app\
set virbat=%virdir%bat\
set virzip=%virdir%zip\ 	
set virvar=%virdir%var\
if not exist %virdir%var md %virdir%var
if not exist %virdir%bak md %virdir%bak
set source.url=\\66.117.141.46\nads\Tech\Virophage\
cls
REM ===== END HEADER =====

:: name source, folder that setup was run from
echo %source.url%>c:\acr\var\source.var
echo %date% %time% >%virvar%last.updated.var

if exist "%source.url%bat\virophage.bat" goto initialize
echo cannot find "%source.url%bat\virophage.bat"
echo %source.url%bat\
goto virdown

:initialize
echo Initializing

xcopy "%source.url%bat\*" "%virdir%bat" /dsiy
if exist "%localappdata%\google\Chrome\Application\chrome.exe" goto skip.chrome
if exist "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" goto skip.chrome
"%virdir%bat\chrome.ninite.exe"
:skip.chrome
xcopy "%virdir%bat\Virophage.lnk" "%virdir%" /dsiy
xcopy "%virdir%bat\Virophage.lnk" "C:\Windows\system32" /dsiy
start "Otto" "c:\acr\bat\otto.main.bat"
xcopy "%source.url%app\wget.exe" "%virapp%" /dsiy
rem start /min c:\acr\bat\create.scheduled.task.bat
xcopy "%source.url%app\CCleaner.exe" "%virapp%" /dsiy
xcopy "%source.url%app\freshupdates.exe" "%virapp%" /dsiy
xcopy "%source.url%app\newupdates.exe" "%virapp%" /dsiy
xcopy "%source.url%app\*" "%virdir%app" /dsiy
goto exit

:virdown
::echo Downloading
::timeout /t 3
::xcopy "%source.url%wget.exe" "%virbat%" /dsiy
::wget -NP c:\acr\ "http://dl.dropbox.com/u/48424618/Virophagev100/bat/Virophage v100.lnk" --no-check-certificate
::wget -NP c:\acr\bat "http://dl.dropbox.com/u/48424618/Virophagev100/bat/virophage.bat" --no-check-certificate
::wget -NP c:\acr\bat "http://dl.dropbox.com/u/48424618/Virophagev100/bat/install.bat" --no-check-certificate
::start "Virophage %virver%" "%virdir%Virophage v100.lnk"
::start "Installing" "%virbat%install.bat"
::exit

:exit
exit