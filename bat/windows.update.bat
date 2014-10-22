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


set WUInstall.var=WUInstall DATE %date% TIME %time:~0,-6%

:cycle.updates
c:\acr\app\wuinstall /install /logfile_append c:\acr\%WUInstall.var%.txt /rebootcycle 3

:all.updates
rem c:\acr\app\wuinstall /install /logfile_append c:\acr\%WUInstall.var%.txt

:Important.Updates
rem c:\acr\app\wuinstall /install /criteria "IsHidden=0 and IsInstalled=0 and IsAssigned=1" /logfile_append c:\acr\%WUInstall.var%.txt

exit
:exit