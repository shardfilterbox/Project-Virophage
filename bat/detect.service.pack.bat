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

::FOR /F "tokens=2* delims=    " %%A IN ('REG QUERY "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CSDversion') DO SET service.pack=%%B
::FOR /F "usebackq skip=2 tokens=2* delims=    " %%A IN ('REG QUERY "HKLM\Software\Microsoft\Windows NT\CurrentVersion" /v CurrentVersion') DO SET currentversion=%%B
::FOR /F "usebackq skip=2 tokens=3" %%A IN (`REG QUERY "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CSDversion`) DO (
::    set service.pack=%%C
::)
for /f "tokens=2,*" %%i in ( 
    'reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CSDVersion^ 
    ^| find "REG_SZ"') do ( 
    set service.pack=%%j
    ) 
set service.pack=%service.pack:~13%
echo Service Pack %service.pack%
echo %service.pack% >%virdir%var\service.pack.var
goto service.pack.done
REM usersp  
REM echo The system may not have a service pack installed.
REM echo Service Pack?
REM set /p answer=
REM echo Initial
REM set /p initial=
REM echo (%initial%) %initial% says Service Pack: %answer% Virophage says Service Pack %service.pack% DATE:%date%  TIME:%time% USER:%USERNAME% >>%virlog%



:service.pack.done
:skip.service.pack
echo.

exit
goto exit
:exit
