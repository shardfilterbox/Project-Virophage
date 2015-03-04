::start.header 
::set.virophage
@echo off
color 4f
set Virophage.Source = %~dp0
if not exist c:\acr\bat\nircmdc.exe xcopy "%Virophage.Source%bat\nircmdc.exe" "c:\acr\bat\*" /dsiy
if "%path%"=="%path:acr=%" setx path "%path%;c:\acr\bat;c:\acr\app"

for /f "delims=" %%x in (%virvar%job.number.var) do set "job.number=%%x"
for /f "delims=" %%x in (%virvar%first.name.var) do set "first.name=%%x"
for /f "delims=" %%x in (%virvar%last.name.var) do set "last.name=%%x"
for /f "delims=" %%x in (c:\acr\var\os.version.name.var) do set "version=%%x"

::set.windows.mode
set windows.mode=Normal
if defined safeboot_option set windows.mode=%safeboot_option%
if NOT %windows.mode%==Normal set windows.mode=Safe
if not exist %virdir%var md %virdir%var
if not exist %virdir%bak md %virdir%bak
set source.dir=%~dp0
set virdir=C:\acr\
set virapp=%virdir%app\
set virbat=c:\acr\bat\
set virzip=%virdir%zip\
set virvar=%virdir%var\

:set.log.name
set logname=ACR%first.name%%last.name%%job.number%
set virlog="c:\acr\%logname%.txt"



cls
::end.header