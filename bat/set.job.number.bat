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

echo What is the Invoice #?
set /p job.number=
set job.number=%job.number: =%
echo %job.number%>%virvar%job.number.var

echo What is the customer's first name? (spelling is important)
set /p first.name=
echo %first.name%>%virvar%first.name.var

echo What is the customer's last name? (spelling is important)
set /p last.name=
echo %last.name%>%virvar%last.name.var

set logname=ACR%first.name%%last.name%%job.number%
echo ACR%first.name%%last.name%%job.number% >>%virlog%

if exist "c:\acr\var\alpha.var" start "" "C:\acr\bat\alphasetup.lnk"
if not exist "c:\acr\var\alpha.var" start "" "C:\acr\virophage.lnk"

:exit
exit
