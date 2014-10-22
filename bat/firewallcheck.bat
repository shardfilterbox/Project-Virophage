@echo off
color 4f
set virdir=C:\acr\
for /f "delims=" %%x in (%virvar%job.number.var) do set "job.number=%%x"
set logname=ACR%job.number%Log
set virapp=%virdir%app\
set virbat=%virdir%bat\
set virzip=%virdir%zip\

@echo off
setlocal enabledelayedexpansion

set key=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile

set value=EnableFirewall


REM // make one call to reg to make sure the KEY/VALUE exists before reading it

reg query "%key%" /v "%value%" 1>nul 2>&1 || (set return=0x1)

for /f "tokens=2,*" %%a in ('reg query "%key%" /v "%value%" ^| findstr /c:"%value%"') do (
set data=%%b
)


:write.to.var

if {%data%}=={} set return=0x1

set return=%data%


set firewall="Unable to detect firewall settings"
echo %return%

if "%return%"=="0x1" set firewall="Firewall Enabled"

if "%return%"=="0x0" set firewall="Firewall Disabled"

set firewallvar=%virdir%var\firewall.var

echo %firewall% >%firewallvar%

exit

:exit