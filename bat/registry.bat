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
cls
rem end header

echo Starting CCleaner for registry cleaning
if NOT "%processor_architecture%"=="%processor_architecture:32=%" start "" c:\acr\app\CCleaner.exe /registry
if NOT "%processor_architecture%"=="%processor_architecture:86=%" start "" c:\acr\app\CCleaner.exe /registry
if NOT "%processor_architecture%"=="%processor_architecture:64=%" start "" c:\acr\app\CCleaner64.exe /registry

:exit
exit