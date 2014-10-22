REM ===== START HEADER =====
@echo off
color 04
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

echo Otto Running Safe Mode First Aid


start /min "" "%virbat%bloatware.bat"

exit
goto exit
:exit
