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


:os.version.number
set wvernum=0
ver | findstr /i "5\.0\." > nul
IF %ERRORLEVEL% EQU 0 set wvernum=1
ver | findstr /i "5\.1\." > nul
IF %ERRORLEVEL% EQU 0 set wvernum=2
ver | findstr /i "5\.2\." > nul
IF %ERRORLEVEL% EQU 0 set wvernum=3
ver | findstr /i "6\.0\." > nul
IF %ERRORLEVEL% EQU 0 set wvernum=4
ver | findstr /i "6\.1\." > nul
IF %ERRORLEVEL% EQU 0 set wvernum=5
ver | findstr /i "6\.2\." > nul
IF %ERRORLEVEL% EQU 0 set wvernum=6
IF %wvernum% == 0 goto manwver
echo %wvernum% > %virvar%os.version.number.var
goto os.version.name

:manwver
echo Windows Version?
echo 1 Windows 2000
echo 2 Windows XP
echo 3 Windows 2003
echo 4 Windows Vista
echo 5 Windows 7
echo 6 Windows 8
echo if other just type in
set /p wversion="Enter Choice: "

pause
:os.version.name

REM if %wvernum% == 1 set versionname=Windows 2000 
REM if %wvernum% == 2 versionname=Windows XP
REM if %wvernum% == 3 set versionname=Windows Server 2003
REM if %wvernum% == 4 set versionname=Windows Vista
REM if %wvernum% == 5 set versionname=Windows 7
REM if %wvernum% == 6 set versionname=Windows 8

if not exist "%systemroot%\system32\prodspec.ini" goto skip.xp
type "c:\windows\system32\prodspec.ini" | find "Product=Windows" >c:\acr\var\os.version.name.var
set trim=8
goto trim.version.name

:skip.xp
systeminfo | find "Microsoft Windows" > c:/acr/var/os.version.name.var
set trim=27

:trim.version.name
for /f "delims=" %%x in (c:/acr/var/os.version.name.var) do set "os.version.name=%%x"
if %trim% == 27 set os.version.name=%os.version.name:~27%
if %trim% == 8 set os.version.name=%os.version.name:~8%
echo %os.version.name% > c:\acr\var\os.version.name.var

:call.version.name
for /f "delims=" %%x in (c:/acr/var/os.version.name.var) do set "os.version.name=%%x"

:exit
exit
EXIT /B n
goto:eof
pause
