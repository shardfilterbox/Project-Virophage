@echo off
color 2F
set virdir=C:\acr\
for /f "delims=" %%x in (%virvar%job.number.var) do set "job.number=%%x"
set logname=ACR%job.number%Log
set virapp=%virdir%app\
set virbat=%virdir%bat\
set virzip=%virdir%zip\
set virvar=%virdir%var\
if not exist %virdir%var md %virdir%var

setlocal


for /f "delims=" %%x in (c:/acr/var/os.version.name.var) do set "os.version.name=%%x"
if NOT "%os.version.name%" == "%os.version.name:xp=%" goto manual.ram

for /f "tokens=2* delims=:" %%a in ('systeminfo ^| findstr /I /C:"Total Physical Memory"') do set TotalRAM=%%a
set TotalRam=%TotalRam:,=.%
set TotalRam=%TotalRam:~4,-3%
echo %TotalRam% >%virdir%var\ram.var
goto done

:manual.ram
echo Manual.RAM.Detection >%virvar%resume.var
echo RAM in gb?
set /p ram=
echo Initial
set /p initial=
echo %ram% >%virvar%ram.var

:done
:exit
exit
EXIT /B n
goto:eof

