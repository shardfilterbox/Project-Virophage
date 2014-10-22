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
for /f "delims=" %%x in (c:\acr\bat\version.var) do set "version=%%x"
cls
REM ===== END HEADER =====

echo normal.mode.adwcleaner >%virvar%resume.var
xcopy "\\66.117.141.46\nads\tech\virophage\app\adwcleaner.exe" "%virapp%" /dsiy
cls




if exist c:\adwcleaner goto adw.log
goto run.adwcleaner

:adw.log
set adw.var=ADWCleaner DATE %date% TIME %time:~0,-6%
set adw.var=%adw.var::= %
set adw.var=%adw.var:/= %
echo %adw.var%
move c:\adwcleaner "c:\acr\log\"
ren "c:\acr\log\adwcleaner" "%adw.var%.txt"
goto write.to.log

:run.adwcleaner
echo ADWCleaner
start /wait "" "c:\acr\app\AdwCleaner.exe"

:write.to.log
echo Did you delete Adware, Toolbars, Potentially Unwanted Programs (PUP), and browser Hijackers using ADWCleaner?
echo Please initial
set /p initial=
echo (%initial%) ADWCleaner  (DATE: %date% %time:~0,-6% USER:%USERNAME% %windows.mode%) >>%virlog%

:exit
exit