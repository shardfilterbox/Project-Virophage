REM ===== START HEADER =====
@echo off
color 4f
set virdir=C:\acr\
for /f "delims=" %%x in (%virvar%job.number.var) do set "job.number=%%x"

set virapp=%virdir%app\
set virbat=%virdir%bat\
set virzip=%virdir%zip\
set virvar=%virdir%var\
for /f "delims=" %%x in (%virvar%job.number.var) do set "job.number=%%x"
for /f "delims=" %%x in (%virvar%first.name.var) do set "first.name=%%x"
for /f "delims=" %%x in (%virvar%last.name.var) do set "last.name=%%x"
set logname=ACR%first.name%%last.name%%job.number%
set virlog="c:\acr\%logname%.txt"
if not exist %virdir%var md %virdir%var
if not exist %virdir%bak md %virdir%bak
for /f "delims=" %%x in (c:\acr\bat\version.var) do set "version=%%x"
cls
REM ===== END HEADER =====

:jrt.start
if exist "%userprofile%\desktop\jrt.txt" goto jrt.log
goto open.jrt

:jrt.log
set jrt.var=jrt DATE %date% TIME %time:~0,-6%
set jrt.var=%jrt.var::= %
set jrt.var=%jrt.var:/= %
echo %jrt.var%
if exist "%userprofile%\desktop\jrt.txt" move "%userprofile%\desktop\jrt.txt" "c:\acr\log\"
ren "c:\acr\log\jrt.txt" "%jrt.var%.txt"
goto write.to.log

:open.jrt
echo Now Running JRT...
start /wait "" "c:\acr\app\JRT.exe"

:write.to.log
echo Did you delete common adware, toolbars, and potentially unwanted programs (PUPs) using Junk Removal Tool?
echo Please initial
set /p initial=
echo (%initial%) Junk Removal Tool  (DATE: %date% %time:~0,-6% USER:%USERNAME% %windows.mode%) >>%virlog%



cls
:exit
exit