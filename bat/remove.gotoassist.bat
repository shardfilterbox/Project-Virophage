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

echo REMOVING GOTOASSIST CUSTOMER
echo Windows User Password?
set /p user.pass=

wmic /node:%computername% /user:%username% /password:%user.pass% product where name="GoToAssist Customer 1.6.0.498" call uninstall
rem if exist "C:\Program Files (x86)\Citrix\GoToAssist Remote Support Customer\498\g2ax_uninstaller_customer.exe" "C:\Program Files (x86)\Citrix\GoToAssist Remote Support Customer\498\g2ax_uninstaller_customer.exe"
rem if exist "C:\Program Files\Citrix\GoToAssist Remote Support Customer\498\g2ax_uninstaller_customer.exe" "C:\Program Files\Citrix\GoToAssist Remote Support Customer\498\g2ax_uninstaller_customer.exe"

:exit
exit