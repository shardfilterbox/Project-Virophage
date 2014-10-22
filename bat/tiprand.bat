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

setlocal enabledelayedexpansion

dir /b /s /A-d %virbat%tips\ | find "" /v /n /c >%virvar%tip.var
set /p max=<%virvar%tip.var
echo %max%

set /a ran = %random% %% %max% + 1

if %ran% lss 10 set ran=0%ran%
if %ran% lss 100 set ran=0%ran%

echo %ran% >%virvar%ran.var
exit