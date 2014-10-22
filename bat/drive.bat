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
cls
rem end header

setLocal EnableDelayedExpansion
set drive=c:\
:: find total used space
for /f "tokens=3 delims= " %%A in ('dir /s/-c %dp0~~ ^|find "File(s)"') do (
set totalused=%%A
)
pause
:: find total free space
for /f "tokens=3 delims= " %%A in ('dir /-c %drive% ^|find "Dir(s)"') do (
set freespace=%%A
)
:: output truncated totals in temp file for use later
echo.Used !totalused:~0,-9! >"testtemp.txt"
echo.Free !freespace:~0,-9! >>"testtemp.txt"
:: input truncated total used space from temp file
for /f "tokens=2 delims= " %%A in ('type testtemp.txt ^|find "Used"') do (
set totalused=%%A
)
:: input truncated free space
for /f "tokens=2 delims= " %%A in ('type testtemp.txt ^|find "Free"') do (
set freespace=%%A
)

:: calculate total drive space, percentage used, and percentage free
set /a totalspace=!totalused!+!freespace!
set /a percentused=(!totalused!*100)/!totalspace!
set /a percentfree=100-!percentused!
:: output results
echo.
echo Total space: %totalspace% GB
echo Free space: %freespace% GB (%percentfree%%%)
echo Used space: %totalused% GB (%percentused%%%)
:: clean up temp file
del testtemp.txt
goto end
:: syntax info
:syntax
echo.
echo.Usage: TESTER [path]
echo.
echo. where [path] is a directory on drive or network path
echo.
echo. example: TESTER \
echo. TESTER \\mynetwork\sharedfolder
goto end
:: invalid path
:badpath
echo.
echo.The path %drive% is not accessible.
echo.
pause
:exit