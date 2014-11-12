REM ===== START HEADER =====
@echo off
color 2f
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
REM ===== END HEADER =====

schtasks /create /sc daily /tn virophage.update1 /tr c:\acr\bat\update1.bat /st 03:00:00
schtasks /create /sc daily /tn virophage.update2 /tr c:\acr\bat\update2.bat /st 03:10:00

:exit
