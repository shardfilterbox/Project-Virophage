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

::Call service pack and windows version
for /f "delims=" %%x in (%virvar%service.pack.var) do set "service.pack=%%x"
for /f "delims=" %%x in (%virvar%os.version.name.var) do set "os.version.name=%%x"
set os.version.name="%os.version.name%"

set service.pack=3
set os.version.name="Windows xp Professional"

::Compare windows version and service pack to determine if it has the latest one
if %service.pack% == 3 goto latest.service.pack.yes
if %service.pack% == 2 goto latest.service.pack.2
if %service.pack% == 1 goto latest.service.pack.1
if %service.pack% == 0 goto latest.service.pack.0
:latest.service.pack.3
if not x%os.version.name:XP=%==x%os.version.name% goto latest.service.pack.yes
goto latest.service.pack.no
:latest.service.pack.2
if not x%os.version.name:Vista=%==x%os.version.name% goto latest.service.pack.yes
goto latest.service.pack.no
:latest.service.pack.1
if not x%os.version.name:7=%==x%os.version.name% goto latest.service.pack.yes
:latest.service.pack.0
if not x%os.version.name:8=%==x%os.version.name% goto latest.service.pack.yes
goto latest.service.pack.no
:latest.service.pack.no
echo (vp) Latest Service Pack:NO! (DATE: %date% %time:~0,-6% USER:%USERNAME%) >>%virlog% > c:\acr\var\latest.service.pack.var
goto call.latest.service.pack
:latest.service.pack.yes
echo (vp) Latest Service Pack:Yes (DATE: %date% %time:~0,-6% USER:%USERNAME%) >>%virlog% > c:\acr\var\latest.service.pack.var
:call.latest.service.pack
for /f "delims=" %%x in (c:\acr\var\latest.service.pack.var) do set "latest.service.pack=%%x"
echo %latest.service.pack% >>%virlog%

:exit
exit
EXIT /B n
goto:eof

