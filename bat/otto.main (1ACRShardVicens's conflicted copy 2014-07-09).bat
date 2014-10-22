REM ===== START HEADER =====
@echo off
color 04
set Virophage.Source = %~dp0
set virdir=C:\acr\
for /f "delims=" %%x in (%virvar%job.number.var) do set "job.number=%%x"
for /f "delims=" %%x in (%virvar%first.name.var) do set "first.name=%%x"
for /f "delims=" %%x in (%virvar%last.name.var) do set "last.name=%%x"
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

echo Otto Running

::Pull Logs
xcopy "%userprofile%\AppData\Local\Temp\SAS_SelfExtract\Logs" "c:\acr\log" /dsiy


::Copying system32 links...
echo Copying system32 links...
xcopy "c:\acr\bat\sys32\*" "c:\windows\system32\" /dsiy
xcopy "c:\acr\bat\Virophage.lnk" c:\windows\system32 /s/z/e/Y
xcopy "c:\acr\bat\virosetup.lnk" c:\windows\system32 /s/z/e/Y
xcopy "c:\acr\%logname%.txt" "\\66.117.141.46\nads\Tech\Dropbox\ACRJobLogs\*"/dsiy


::Pulling Product Keys
echo Checking product keys...
if not exist "c:\acr\app\produkey.exe" xcopy "%Virophage.Source%app\produkey.exe" "c:\acr\app\" /dsiy
if not exist "c:\acr\bak\%COMPUTERNAME% License Keys.txt" start /min "Pulling Product Keys" "c:\acr\bat\pull.keys.bat"
if exist "c:\acr\bak\%COMPUTERNAME% License Keys.txt" echo (0110) Pulled keys for %COMPUTERNAME% (DATE: %date% %time:~0,-6% USER:%USERNAME% %windows.mode%) >> c:\acr\log\0110.log


::Pulling minidump files
echo Copying minidump log files...
xcopy C:\Windows\Minidump\* c:\acr\bak\minidump /dsiy
>nul 2>nul dir /a-d "c:\acr\bak\minidump\*" && echo (0110) Backed up minidumps for %COMPUTERNAME% (DATE: %date% %time:~0,-6% USER:%USERNAME% %windows.mode%) >> c:\acr\log\0110.log

::Autorun System Specs
echo Automatically finding system Specs
echo checking OS Version...
if not exist c:\acr\var\os.version.name.var start /wait /min "Detect OS Version" "c:\acr\bat\detect.os.version.bat"
echo (0110) Checked OS Version (DATE: %date% %time:~0,-6% USER:%USERNAME% %windows.mode%) >> c:\acr\log\0110.log

echo checking Service Pack...
if not exist c:\acr\var\service.pack.var start /wait /min "Detect Service Pack" "c:\acr\bat\detect.service.pack"
echo (0110) Checked Service Pack (DATE: %date% %time:~0,-6% USER:%USERNAME% %windows.mode%) >> c:\acr\log\0110.log

echo checking RAM...
if not exist c:\acr\var\ram.var start /wait /min "Detecting RAM" "c:\acr\bat\getram.bat"
echo (0110) Checked RAM (DATE: %date% %time:~0,-6% USER:%USERNAME% %windows.mode%) >> c:\acr\log\0110.log

::Windows update
echo Performing windows updates...
start /min /wait "" "c:\acr\bat\windows.update.bat"
echo (0110) Performed some windows updates (DATE: %date% %time:~0,-6% USER:%USERNAME% %windows.mode%) >> c:\acr\log\0110.log


::Remove Bloatware
start /min /wait "" "c:\acr\bat\bloatware.bat"

exit
goto exit
:exit
