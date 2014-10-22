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

if not exist "%UserProfile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\virophage.lnk" xcopy "%virdir%bat\Virophage.lnk" "%UserProfile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\*" /dsiy
if not exist "%AllUsersProfile%\Start Menu\Programs\Startup\virophage.lnk" xcopy "%virdir%bat\Virophage.lnk" "%AllUsersProfile%\Start Menu\Programs\Startup\*" /dsiy
if not exist "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\virophage.lnk" xcopy "%virdir%bat\Virophage.lnk" "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\*" /dsiy
if not exist "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Virophage.lnk" xcopy "%virdir%bat\Virophage.lnk" "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\*" /dsiy

goto exit

:exit
exit