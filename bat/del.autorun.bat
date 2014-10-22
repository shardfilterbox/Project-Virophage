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
cls
rem end header


if exist "%UserProfile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\virophage.lnk" del "%UserProfile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\virophage.lnk"
if exist "%AllUsersProfile%\Start Menu\Programs\Startup\virophage.lnk" del "%AllUsersProfile%\Start Menu\Programs\Startup\virophage.lnk"
if exist "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\virophage.lnk" del "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\virophage.lnk"

goto exit

:exit
exit