::Begin Header
::Call header.bat
xcopy "%~dp0bat\header.bat" "c:\acr\bat" /dsiy
set window.name=%~nx0
CALL c:\acr\bat\header.bat %~nx0

set Virophage.Source = %~dp0
set virdir=C:\acr\
set virver=v100
for /f "delims=" %%x in (%virvar%job.number.var) do set "job.number=%%x"
for /f "delims=" %%x in (%virvar%first.name.var) do set "first.name=%%x"
for /f "delims=" %%x in (%virvar%last.name.var) do set "last.name=%%x"
set logname="ACR%job.number%Log"
set virlog="c:\acr\ACR%job.number%Log.txt"

set virapp=%virdir%app\
set virbat=%virdir%bat\
set virzip=%virdir%zip\
set virvar=%virdir%var\
if not exist %virdir%var md %virdir%var
if not exist %virdir%bak md %virdir%bak
cls
::End Header

:check.computer.name
echo install.crashplan >%virvar%resume.var
echo I will open the Disk Management for you 
echo to assign the xHD to X:
echo.
echo.
echo Please plug in the xHD before continuing
echo.
echo.
pause
start /wait "" "diskmgmt.msc"
mkdir x:\ACRBackups
echo Created directory X:\ACRBackups
echo.
echo Crashplan will now start installing.
echo .
echo Make sure to use the customers email
echo and phone number, with a default
echo password of 5107867103
echo.
pause

:check.architecture.crashplan
set architecture=%processor_architecture%
echo %architecture%

if NOT "%architecture%"=="%architecture:32=%" goto crashplan.32
if NOT "%architecture%"=="%architecture:86=%" goto crashplan.32
if NOT "%architecture%"=="%architecture:64=%" goto crashplan.64


:set.architecture.crashplan
echo Architecture? (32 or 64)
echo (system variable says %processor_architecture%)
set /p architecture=

goto check.architecture.crashplan

:crashplan.32
	echo Crashplan 32
	%virdir%app\Crashplan32.exe
	goto installed
:crashplan.64
	echo Crashplan 64
	%virdir%app\Crashplan64.exe
	goto installed

:installed

echo Make sure you chose all pertinent data,
echo and backup to the x:\ACRBackups folder.
save




goto exit


:exit
exit