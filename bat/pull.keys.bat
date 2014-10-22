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

::Run ProduKey
mkdir c:\acr\log
for /f "delims=" %%x in (c:\acr\var\source.var) do set "source=%%x"
if not exist c:\acr\app\produkey.exe xcopy %source%\app\produkey.exe c:\acr\app\
if not exist "c:\acr\bak\%COMPUTERNAME% License Keys.txt" c:\acr\app\produkey.exe /stext "c:\acr\bak\%COMPUTERNAME% License Keys.txt"

exit
goto exit


:exit
