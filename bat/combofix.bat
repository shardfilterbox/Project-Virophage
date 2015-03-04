REM ===== START HEADER =====
@echo off
color 4f
sset virdir=C:\acr\

::Set Log Name
for /f "delims=" %%x in (%virvar%job.number.var) do set "job.number=%%x"
for /f "delims=" %%x in (%virvar%first.name.var) do set "first.name=%%x"
for /f "delims=" %%x in (%virvar%last.name.var) do set "last.name=%%x"
set logname=ACR%first.name%%last.name%%job.number%
set virlog="c:\acr\%logname%.txt"

set virapp=%virdir%app\
set virbat=%virdir%bat\
set virzip=%virdir%zip\
set virvar=%virdir%var\
if not exist %virdir%var md %virdir%var
if not exist %virdir%bak md %virdir%bak
for /f "delims=" %%x in (c:\acr\bat\version.var) do set "version=%%x"
cls
REM ===== END HEADER =====

if exist "%userprofile%\Contacts\Downloads\Combofix.exe" del /f "%userprofile%\Contacts\Downloads\Combofix.exe"
if exist "%userprofile%\downloads\Combofix.exe" del /f "%userprofile%\downloads\Combofix.exe"
if exist c:\combofix.txt goto combofix.log
goto open.browser

:combofix.log
set combofix.var=Combofix DATE %date% TIME %time:~0,-6%
set combofix.var=%combofix.var::= %
set combofix.var=%combofix.var:/= %
echo %combofix.var%
move c:\combofix.txt "c:\acr\log\"
ren "c:\acr\log\combofix.txt" "%combofix.var%.txt"
goto write.to.log

:open.browser
echo Opening a browser window with the Combofix downloads page, 
echo and how to disable commonly installed anti-virus protection 
echo (necessary for combofix to do it's job)
echo It may open up in the background so check your taskbar.
echo.
echo Opening Chrome for downloading Combofix...
start /wait chrome.exe -incognito --new-window "http://www.bleepingcomputer.com/download/combofix/dl/12/"
pause

:write.to.log
echo Did Combofix finish completely?
echo Please initial
set /p initial=

echo (%initial%) Combofix  (DATE: %date% %time:~0,-6% USER:%USERNAME% %windows.mode%) >>%virlog%
cls
:exit
exit