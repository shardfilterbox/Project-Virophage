::Sat 06/07/2014  7:27:25.67
::start.header 
::set.virophage
@echo off
color 2F
set Virophage.Source = %~dp0
if not exist c:\acr\bat\nircmdc.exe xcopy "%Virophage.Source%bat\nircmdc.exe" "c:\acr\bat\*" /dsiy
if "%path%"=="%path:acr=%" setx path "%path%;c:\acr\bat;c:\acr\app" 
CALL :error.log %errorlevel%
::set.windows.mode
set windows.mode=Normal
if defined safeboot_option set windows.mode=%safeboot_option%
if NOT %windows.mode%==Normal set windows.mode=Safe
set virdir=C:\acr\
set virapp=%virdir%app\
set virbat=c:\acr\bat\
set virzip=%virdir%zip\
set virvar=%virdir%var\
for /f "delims=" %%x in (%virvar%job.number.var) do set "job.number=%%x"
for /f "delims=" %%x in (%virvar%first.name.var) do set "first.name=%%x"
for /f "delims=" %%x in (%virvar%last.name.var) do set "last.name=%%x"
set logname=ACR %first.name% %last.name% Q%job.number% Log
set virlog="c:\acr\%logname%.txt"
if not exist %virdir%var md %virdir%var
if not exist %virdir%bak md %virdir%bak
for /f "delims=" %%x in (c:\acr\var\os.version.name.var) do set "version=%%x"

::set.window
C:\acr\bat\nircmdc win setsize ititle "Virophage.Main.Window" 0 0 400 450
title Virophage.Main.Window
rem if %windows.mode%=Safe nircmdc win setsize ititle "Virophage.Main.Window" 0 0 

cls
::end.header

start "Log.File" "c:\acr\bat\log.file.bat"

:CHECKS

if not exist %virvar%job.number.var goto set.job.number
IF NOT EXIST "c:\acr\%logname%.txt" goto system.specs
if not exist "c:\acr\var\job.number.var" goto system.specs
if not exist "c:\acr\var\os.version.name.var" goto system.specs
if not exist "c:\acr\var\service.pack.var" goto system.specs
if not exist "c:\acr\var\ram.var" goto system.specs
if not exist "c:\acr\var\architecture.var" goto system.specs
if not exist "c:\acr\var\avtype.var" goto system.specs
if not exist "c:\acr\var\os.free.space.var" goto system.specs
if not exist %virvar%resume.var goto skipresume
if exist %virvar%hdsentinel.percent.var goto skip.hd.health.check
if exist %virvar%hdsentinel.status.var goto skip.hd.health.check
if exist %virvar%long.hd.diag.var goto skip.hd.health.check
if exist %virvar%hd.new.var goto skip.hd.health.check
goto hd.health
:skip.hd.health.check

::Delete Autorun  -- look for set.autorun.bat
if exist c:\acr\bat\del.autorun.bat goto del.autorun else goto dont.del.autorun

:del.autorun
start /min "Delete Autorun Entry" "c:\acr\bat\del.autorun.bat"
goto done.del.autorun

:dont.del.autorun
Please let Shard know that there is no del.autorun.bat

:done.del.autorun



:resume
cls


echo 
echo %autorunstate% virophage.
echo %computername%
echo %first.name% %last.name%
echo Invoice #: %job.number%
echo  
if exist %virvar%resume.var set /p resume=<%virvar%resume.var
if exist %virvar%resume.var echo Last Run: %resume%
if %resume% == finished.hd.health del /f %virvar%resume.var
if %resume% == finished.hd.health goto CHECKS
IF NOT EXIST "c:\acr\%logname%.txt" goto system.specs
echo Would you like to resume from this point?
echo Y or N 
set /p choice=
if %choice% == n goto skipresume
if %choice% == N goto skipresume

set /p resume=<%virvar%resume.var
start /min c:\acr\bat\set.autorun.bat
if exist %virvar%resume.var goto %resume%

:skipresume
if exist %virvar%resume.var del /f %virvar%resume.var
:viro.start

cls
rem color 17
rem echo Displaying Change Log
rem start /wait "Change Log" "c:\acr\bat\change.log.bat"
rem color 2F
rem cls
rem echo ====================================================
rem echo                 Virophage %version% beta
rem echo ====================================================
rem echo.
rem echo.
rem echo.
rem echo.
rem 
rem if exist %virlog% goto viewlog

:main.menu
:finished.system.specs
:finished.first.aid
:finished.new.computer


cls

for /f "delims=" %%x in (%virvar%job.number.var) do set "job.number=%%x"

set autorunstate= 

if exist "%UserProfile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\virophage.lnk" set autorunstate= X 
if exist "%AllUsersProfile%\Start Menu\Programs\Startup\virophage.lnk" set autorunstate= X 
if exist "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\virophage.lnk" set autorunstate= X 

rem echo ====================================================
rem set /p tipnum=<%virvar%ran.var
rem type %virbat%tips\%tipnum%
rem echo:
rem echo ===================TIPS AND TRICKS==================


@echo off
echo (%autorunstate%) Virophage
echo %computername%
echo %first.name% %last.name%
echo Invoice %job.number%
@echo off
if exist %virvar%resume.var set /p resume=<%virvar%resume.var
if exist %virvar%resume.var echo Last Run: %resume%
IF NOT EXIST "c:\acr\%logname%.txt" goto system.specs
echo 1 Log File
echo 2 System Specs
echo 3 First Aid
echo 4 Fresh Reload
echo 5 New Computer
echo 6 Checkover
echo 7 Update TT
echo 8 Update Virophage
echo 0 Change Job Number
@echo off
echo commands:
echo note . exit . admin . snap
set /p choice="Enter Choice: "
if %choice% == 1 goto viewlog
if %choice% == 2 goto system.specs
if %choice% == 3 goto firstaidmode
if %choice% == 4 goto fresh.reload
if %choice% == 5 goto new.computer
if %choice% == 6 goto checkover
if %choice% == 7 goto up
if %choice% == 8 goto update.reload
if %choice% == 0 goto set.job.number
if %choice% == exit goto exit
if %choice% == note goto add.note
if %choice% == admin goto admin.tools
if %choice% == snap goto snap.shot
goto main.menu

:update.reload
if exist "c:\acr\var\alpha.var" "%Virophage.Source%Virophage.Setup.bat"
if not exist "c:\acr\var\alpha.var" start "Virophage" "c:\acr\Virophage.lnk"
goto exit


:firstaidmode

::Set Autorun
start /min c:\acr\bat\set.autorun.bat

start "First Aid MBAM" "c:\acr\bat\first.aid.mbam.bat"

echo firstaidmode >%virvar%resume.var
cls

echo ========================================
echo [%autorunstate%] Virophage Will Start Next Boot
echo COMPUTERNAME: %computername%
echo Customer Name: %first.name% %last.name%
echo Invoice #: %job.number% 
echo ========================================
if exist %virvar%resume.var set /p resume=<%virvar%resume.var
if exist %virvar%resume.var echo Last Run: %resume%
IF NOT EXIST "c:\acr\%logname%.txt" goto system.specs
echo.
echo.
echo.
echo 1 Safe Mode
echo 2 Normal Mode
echo.
set /p choice="Enter Choice: "
if %choice% == 1 goto safe.mode.first.aid
if %choice% == 2 goto normal.mode.first.aid


goto main.menu


:viewlog
cls
echo ========================================
echo [%autorunstate%] Virophage Will Start Next Boot
echo COMPUTERNAME: %computername%
echo Customer Name: %first.name% %last.name%
echo Invoice #: %job.number% 
echo ========================================
if exist %virvar%resume.var set /p resume=<%virvar%resume.var
if exist %virvar%resume.var echo Last Run: %resume%
IF NOT EXIST "c:\acr\%logname%.txt" goto system.specs
if exist %virlog% (
echo ---------------
echo LOG FILE EXISTS
echo ---------------
echo.
type %virlog%
)

pause
goto main.menu

:installwot
echo installwot >%virvar%resume.var
start "" %virbat%installwot.bat
goto main.menu

:system.specs
echo system.specs >%virvar%resume.var
echo Computer Name:%COMPUTERNAME% >>%virlog%
cls
echo ========================================
echo [%autorunstate%] Virophage Will Start Next Boot
echo COMPUTERNAME: %computername%
echo Customer Name: %first.name% %last.name%
echo Invoice #: %job.number% 
echo ========================================
if exist %virvar%resume.var set /p resume=<%virvar%resume.var
if exist %virvar%resume.var echo Last Run: %resume%
echo -----------------------------
echo YOU NEED TO RUN SYSTEM SPECS 
echo BEFORE DOING ANYTHING ELSE
echo -----------------------------
echo Starting Point?
if not exist "c:\acr\var\job.number.var" echo 0 Job Number
if not exist "c:\acr\var\os.version.name.var" echo 1 Windows Version
if not exist "c:\acr\var\service.pack.var" echo 2 Service Pack
if not exist "c:\acr\var\ram.var" echo 3 Ram
if not exist "c:\acr\var\architecture.var" echo 4 Architecture
if not exist "c:\acr\var\avtype.var" echo 6 Antivirus
if not exist "c:\acr\var\computer.type.var" echo 7 Laptop or Desktop
if not exist "c:\acr\var\os.free.space.var" echo 8 Storage Space


echo.

set /p choice="Enter Choice: "
if %choice% == 1 goto os.version
if %choice% == 2 goto service.pack
if %choice% == 3 goto System.Specs.RAM
if %choice% == 4 goto architecture
if %choice% == 6 goto startav
if %choice% == 7 goto System.Specs.Laptop.AIO.Desktop
if %choice% == 8 goto storage.space
if %choice% == admin goto admin.tools
echo.>>%virlog%
echo SYSTEM SPECS (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%)>>%virlog%
echo ========================================>>%virlog%
cls

echo.

:system.specs.job.number
echo system.specs.job.number >%virvar%resume.var
echo CURRENT JOB NUMBER: %job.number% 
echo Verify Job Number is correct?
echo Y or N 
set /p choice=
if %choice% == n goto set.job.number
if %choice% == N goto set.job.number 
echo Initial
set /p initial=
echo (%initial%) Correct Job Number: %job.number% (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%


:os.version
echo os.version >%virvar%resume.var
if exist c:\acr\var\os.version.name.var goto skip.os.version
color 17
start /wait "Detect OS Version" "c:/acr/bat/detect.os.version.bat"
color 2F

:skip.os.version
for /f "delims=" %%x in (c:/acr/var/os.version.name.var) do set "os.version.name=%%x"
for /f "delims=" %%x in (%virvar%os.version.number.var) do set "os.version.number=%%x"
echo OS Version Name: %os.version.name%
echo OS Version Number: %os.version.number%
echo (vp) OS Version Name: %os.version.name% (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode% %windows.mode%)>>%virlog%

:service.pack
echo service.pack >%virvar%resume.var
if exist c:\acr\var\service.pack.var goto skip.service.pack
color 17
start /wait "Detect Service Pack" "c:/acr/bat/detect.service.pack.bat"
:skip.service.pack
for /f "delims=" %%x in (c:/acr/var/service.pack.var) do set "service.pack=%%x"
echo (vp) Service Pack %service.pack% (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%)>>%virlog%
color 2F
::set servicepack=0
::FOR /F "tokens=2* delims=	 " %%A IN ('REG QUERY "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CSDversion') DO SET servicepack=%%B
::set servicepack=%servicepack:~13%
::echo %servicepack%>%virdir%var\service.pack.var

:::virosp
::echo virosp >%virvar%resume.var
::echo Service Pack %servicepack%
::echo (vp) Services Pack %servicepack% (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%)>>%virlog%
::REM usersp	
::REM echo The system may not have a service pack installed.
::REM echo Service Pack?
::REM set /p answer=
::REM echo Initial
::REM set /p initial=
::REM echo (%initial%) %initial% says Service Pack: %answer% Virophage says Service Pack %servicepack% (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%

:System.Specs.RAM
echo System.Specs.RAM >%virvar%resume.var
color 17
start /wait %virbat%getram.bat
color 2F

for /f "delims=" %%x in (%virvar%ram.var) do set "ramtemp=%%x"
echo It looks like you have %ramtemp%. Does this look correct?
echo (vp) RAM: %ramtemp%GB (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
cls

echo.
echo.

goto architecture

:architecture
echo.
echo architecture >%virvar%resume.var
set architecture=0
set architecture=%processor_architecture%
if %architecture% == 0 goto manarch
goto autoarch

:manarch
echo manarch >%virvar%resume.var
echo Architecture? Virophage says %processor_architecture%)
set /p architecture=
echo Initial
set /p initial=
goto reparch

:autoarch
echo autoarch >%virvar%resume.var
set initial=vp

:reparch
echo reparch >%virvar%resume.var
echo (%initial%) Architecture %architecture% (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
cls

echo.
echo.

echo %architecture% >%virdir%var\architecture.var

:startav
echo startav >%virvar%resume.var

echo What AV does the computer have
if NOT "%processor_architecture%"=="%processor_architecture:32=%" start "" c:\acr\app\CCleaner.exe /tools
if NOT "%processor_architecture%"=="%processor_architecture:86=%" start "" c:\acr\app\CCleaner.exe /tools
if NOT "%processor_architecture%"=="%processor_architecture:64=%" start "" c:\acr\app\CCleaner64.exe /tools
set /p answer=
echo %answer%>c:\acr\var\avtype.var
echo Initial
set /p initial=
echo (%initial%) Antivirus %answer% (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
cls

echo.
echo.
echo.
if initial == exit exit
if initial == main.menu goto main.menu

:System.Specs.Laptop.AIO.Desktop
echo System.Specs.Laptop.AIO.Desktop >%virvar%resume.var

echo This is a: 
echo 1.Laptop or All in One 
echo 2.Desktop
set /p lapordesk=
if %lapordesk% == 1 set lapordesk=laptop
if %lapordesk% == 2 set lapordesk=desktop
echo %lapordesk% > c:\acr\var\computer.type.var
echo Initial
set /p lapordeskini=
echo (%lapordeskini%) %lapordesk% (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
cls

echo.
echo.

:storage.space
echo storage.space >%virvar%resume.var

rem echo list disk | diskpart
rem echo DISC MANAGEMENT
rem echo Size of Hard Drive(s) in gb?
rem set /p answer=
rem echo Initial
rem set /p initial=
rem echo (%initial%) Hard Drive Size %answer% gb (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
rem cls

echo Starting Disk Management for OS 
echo Partitions size and free space
ping 127.0.0.1 -n 5 -w 1000 > nul 
start diskmgmt.msc

echo Partitioned correctly? (no unpartitioned
echo space, reasonable amount of partitions, 
echo Windows partion is C:)

echo Initial
set /p initial=
echo (%initial%) Disc Management(DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
cls

::for /f "tokens=3,6,7 delims= " %%a in ('echo list volume ^| diskpart') do if "%%a"=="C" set size=%%b && set size2=%%c
@echo off & setlocal ENABLEDELAYEDEXPANSION
SET "volume=C:"
FOR /f "tokens=1*delims=:" %%i IN ('fsutil volume diskfree %volume%') DO (
    SET "diskfree=!disktotal!"
    SET "disktotal=!diskavail!"
    SET "diskavail=%%j"
)
FOR /f "tokens=1,2" %%i IN ("%disktotal% %diskavail%") DO SET "disktotal=%%i"& SET "diskavail=%%j"
(ECHO(It looks to me like %volume% has 
ECHO(%disktotal:~0,-9% GB in total and
ECHO(%diskavail:~0,-9% GB free)
echo.
echo Size of OS Partition in gb?
echo Virophage says (%disktotal:~0,-9% GB
set/p ossize=
echo Initial
set /p ossizeini=
echo %ossize% > %virvar%ossize.var
echo (%ossizeini%) OS Size %ossize%gb >>%virlog%


::wmic logicaldisk where "DeviceID='C:'" get FreeSpace /format:value > c:\acr\var\temp.free.space.var
::wmic logicaldisk where "DeviceID='C:'" get Size /format:value > c:\acr\var\temp.full.size.var
::for /f "delims=" %%f in (%virvar%temp.free.space.var) do set "FreeMB=%%f"
::for /f "delims=" %%t in (%virvar%temp.full.size.var) do set "SizeMB=%%t"

::set FreeMB=%FreeSpace:~0,-6%
::set SizeMB=%Size:~0,-6%
::set /a Percentage=100 * FreeMB / SizeMB
::echo C: is %Percentage% % free
echo.

echo Percent Free?
set /a percent.free = %diskavail:~0,-9% / %disktotal:~0,-9%
echo Virophage says %percent.free%
set /p percentfree=

echo %percentfree% > %virvar%os.free.space.var

echo Initial
set /p initial=
echo (%initial%) Percent Free %percentfree% % (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >> %virlog%
echo.


echo finished.system.specs >%virvar%resume.var
if not exist %virvar%hdsentinel.percent.var goto hd.health
goto finished.system.specs


:safe.mode.first.aid
echo safe.mode.first.aid >%virvar%resume.var
echo. >>%virlog%
echo SAFE MODE (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
echo ======================================== >>%virlog%
start /min c:\acr\bat\first.aid.mbam.bat
start /min otto.first.aid.safe.mode.bat

IF NOT EXIST %virlog% goto main.menu
cls
echo ========================================
echo [%autorunstate%] Virophage Will Start Next Boot
echo COMPUTERNAME: %computername%
echo Customer Name: %first.name% %last.name%
echo Invoice #: %job.number% 
echo ========================================
if exist %virvar%resume.var set /p resume=<%virvar%resume.var
if exist %virvar%resume.var echo Last Run: %resume%
IF NOT EXIST "c:\acr\%logname%.txt" goto system.specs
echo.
echo Starting Point?
echo 1 Beginning
echo 2 CCleaner
echo 3 Reset Internet Settings
echo 4 Reset Firewall Settings
echo 5 Combofix
echo 6 Malware Bytes
echo 7 SAS Portable
echo 8 Spybot
echo 9 Secondary AV Scan
echo 10 Hitman Pro
echo 11 TDSSKiller
echo 12 AutoRuns
echo 13 HijackThis!
echo 14 System File Checker
echo 15 MSConfig
echo.

if "%windows.mode%"=="Normal" echo YOU ARE TRYING TO RUN SAFE MODE FIRST 
if "%windows.mode%"=="Normal" echo AID WHILE IN NORMAL MODE!!!!!!!!!!!!!
set /p choice="Enter Choice: "
if %choice% == 2 goto sccleaner
if %choice% == 3 goto sinet
if %choice% == 4 goto sfirewall
if %choice% == 5 goto safe.mode.combofix
if %choice% == 6 goto safe.mode.mbam
if %choice% == 7 goto ssas
if %choice% == 8 goto sspybot
if %choice% == 9 goto seset
if %choice% == 10 goto shitmanpro
if %choice% == 11 goto stdsskiller
if %choice% == 12 goto sautoruns
if %choice% == 13 goto shijackthis
if %choice% == 14 goto safe.mode.sfc
if %choice% == 15 goto smsconfig
cls
echo ========================================
echo [%autorunstate%] Virophage Will Start Next Boot
echo COMPUTERNAME: %computername%
echo Customer Name: %first.name% %last.name%
echo Invoice #: %job.number% 
echo ========================================
if exist %virvar%resume.var set /p resume=<%virvar%resume.var
if exist %virvar%resume.var echo Last Run: %resume%
IF NOT EXIST "c:\acr\%logname%.txt" goto system.specs
echo.
echo.
echo.
cls

:safe.mode.system.restore
echo safe.mode.system.restore >%virvar%resume.var
set restore.choice=0
echo SYSTEM RESTORE

start /wait "" "rstrui.exe"

echo Was a system restore 
echo successfully performed?
echo Initial
set /p initial=
echo (%initial%) System Restore (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%


:safe.mode.boot.ini
echo safe.mode.boot.ini >%virvar%resume.var
echo Did you modify the boot.ini for Safe Mode with Networking?
start msconfig -2
echo Initial
set /p initial=
echo (%initial%) Boot.ini Safe Mode w/ Networking (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
cls




:sccleaner
echo sccleaner >%virvar%resume.var
echo CCLEANER
set name=Ccleaner
if NOT "%processor_architecture%"=="%processor_architecture:32=%" start "" c:\acr\app\CCleaner.exe /AUTO
if NOT "%processor_architecture%"=="%processor_architecture:86=%" start "" c:\acr\app\CCleaner.exe /AUTO
if NOT "%processor_architecture%"=="%processor_architecture:64=%" start "" c:\acr\app\CCleaner64.exe /AUTO
echo (vp) %name%  (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
cls

:sinet
echo sinet >%virvar%resume.var
echo Reset Internet and LAN Settings (inetcpl.cpl)
inetcpl.cpl
echo Connections > Lan Settings > Make sure ONLY Automatically Detect Settings is checked.
echo Advanced > Restore Advanced Settings and Reset, deleting personal Settings.
inetcpl.cpl
echo Please initial
set /p initial=
echo (%initial%) Reset Internet and LAN Settings  (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%


echo.

:sfirewall
echo sfirewall >%virvar%resume.var
color 17
start /wait "" "firewallcheck.lnk"
color 2F
for /f "delims=" %%x in (%virvar%firewall.var) do set "firewall=%%x"
for /f "delims=" %%x in (%virvar%os.version.number.var) do set "winvernum=%%x"
echo Resetting Firewall.  
echo If I am successful, I will say "OK." but 
echo if something goes wrong, this windows may
echo close.  If this happens, please run 
echo Virophage again and resume the first aid.
echo.
echo Resetting the Firewall...
If %winvernum% GEQ 4 goto 4.firewall.reset
goto 3.firewall.reset

:4.firewall.reset
netsh advfirewall reset
goto after.firewall.reset

:3.firewall.reset
netsh firewall reset

:after.firewall.reset
rem if %firewall% == "Firewall Disabled" (
rem	netsh firewall set opmode disable
rem	echo Firewall disable because log says firewall was already off.
rem	)
echo Were there any errors? let shard know 
echo and/or restore defaults yourself.
echo Please initial
set /p initial=
echo (%initial%) Reset firewall settings (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
cls

echo.
echo.
echo.

:safe.mode.combofix
echo safe.mode.combofix >%virvar%resume.var
echo COMBOFIX
color 17
start /wait "ComboFix" "c:\acr\bat\combofix.bat.lnk"
color 2F


echo.
echo.
echo.

:safe.mode.mbam
echo safe.mode.mbam >%virvar%resume.var
echo MALWARE BYTES
set name=Malware Bytes

::Check if MBAM exists
if exist "C:\Program Files (x86)\Malwarebytes Anti-Malware\mbam.exe" goto safe.mode.skip.mbam.install

::Install MBAM
echo Installing Malwarebytes
mbam-setup.exe /silent /NORESTART

:safe.mode.skip.mbam.install
::Run RKILL and MBAM quick
%virapp%rkill.com
"C:\Program Files (x86)\Malwarebytes Anti-Malware\mbam.exe"
echo Please scan for threats on Malwarebytes.
echo Did %name% finish completely?
echo Please initial
set /p initial=
echo (%initial%) %name%  (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%

if exist "%programdata%\Malwarebytes\Malwarebytes Anti-Malware\Logs\*" xcopy "%programdata%\Malwarebytes\Malwarebytes Anti-Malware\Logs\*" "c:\acr\log\*" /dsiy

%programdata%\Malwarebytes\Malwarebytes Anti-Malware\Logs
cls

echo.
echo.
echo.

:ssas
echo ssas >%virvar%resume.var
echo SAS PORTABLE
set name=SAS
%virapp%sas.com

echo Did %name% finish completely?
echo Please initial
set /p initial=
echo (%initial%) %name%  (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
cls

echo.
echo.
echo.

:sspybot
echo sspybot >%virvar%resume.var
echo SPYBOT
set name=Spybot

if exist "C:\Program Files\Spybot - Search & Destroy\SpybotSD.exe" goto safe.run.spybot
if exist "C:\Program Files (x86)\Spybot - Search & Destroy\SpybotSD.exe" goto safe.run.spybot

:safe.install.spybot
%virdir%app\spybot.exe /verysilent /components="main" /tasks="!launchteatimer" /norestart

:safe.run.spybot
if exist "C:\Program Files\Spybot - Search & Destroy\SpybotSD.exe" start "" "C:\Program Files\Spybot - Search & Destroy\SpybotSD.exe"
if exist "C:\Program Files (x86)\Spybot - Search & Destroy\SpybotSD.exe" start "" "C:\Program Files (x86)\Spybot - Search & Destroy\SpybotSD.exe"

echo Did %name% finish completely?
echo Please initial
set /p initial=
echo (%initial%) %name%  (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
cls

echo.
echo.
echo.

:seset
echo seset >%virvar%resume.var
echo ESET
set name=eset
%virapp%eset
echo Did %name% finish completely?
echo Please initial
set /p initial=
echo (%initial%) %name%  (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
cls

echo.
echo.
echo.

:shitmanpro
echo shitmanpro >%virvar%resume.var
echo HITMAN PRO
::for /f "delims=" %%x in (c:/acr/var/architecture.var) do set "architecture=%%x"

set architecture=%processor_architecture%
echo %architecture%

if NOT "%architecture%"=="%architecture:86=%" goto safe.mode.hitmanpro.32
if NOT "%architecture%"=="%architecture:32=%" goto safe.mode.hitmanpro.32
if NOT "%architecture%"=="%architecture:64=%" goto safe.mode.hitmanpro.64


:checkshitmanpro
echo Architecture? (32 or 64)
echo (system variable says %processor_architecture%)
set /p architecture=
goto shitmanpro

:safe.mode.hitmanpro.32
	echo Hitman Pro 32
	%virdir%app\hitmanpro32.exe
	goto passshitmanpro

:safe.mode.hitmanpro.64
	echo Hitman Pro 64
	%virdir%app\hitmanpro64.exe
	goto passshitmanpro


:passshitmanpro
echo Did Hitman Pro finish completely?
echo Please initial
set /p initial=
echo (%initial%) Hitman Pro (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
xcopy C:\ProgramData\HitmanPro\Logs c:\acr\log\hitman /dsiy
cls

echo.
echo.
echo.

:stdsskiller
echo stdsskiller >%virvar%resume.var
echo TDSSKILLER
set name=TdssKiller

if not exist c:\acr md c:\ACR
if not exist c:\acr\log md c:\ACR\log
%virapp%tdsskiller -l "c:\ACR\log\tdss.txt"

echo Did %name% finish completely?
echo Please initial
set /p initial=
echo (%initial%) %name%  (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
cls

echo.
echo.
echo.

:sautoruns
echo sautoruns >%virvar%resume.var
echo AUTORUNS
%virapp%autoruns
echo Did you run autoruns?
echo Please initial
set /p initial=
echo (%initial%) Autoruns  (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
cls

echo.
echo.
echo.

:shijackthis
echo shijackthis >%virvar%resume.var
echo HIJACKTHIS
%virdir%app\hijackthis.exe

echo Did you go over the hijack this log?
echo Please initial
set /p initial=
echo (%initial%) HijackThis  (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
cls

echo.
echo.
echo.

:safe.mode.sfc
echo safe.mode.sfc >%virvar%resume.var
echo System File Checker
start /wait "" "c:\acr\bat\sfc.scannow.lnk"
echo Did SFC finish completely?
echo Please initial
set /p initial=
echo (%initial%) System File Check  (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%

:smsconfig
echo smsconfig >%virvar%resume.var
echo MSCONFIG
start msconfig
echo Did you change msconfig to Normal Startup?
echo Please initial
set /p initial=
echo (%initial%) MSConfig  (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
cls

echo.
echo.
echo.




echo SAFE MODE DONE (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>%virlog%
echo safe.mode.done >%virvar%resume.var
echo We will now reboot into normal mode
pause
shutdown -r -t 0
goto main.menu

:normal.mode.first.aid
:safe.mode.done
echo normal.mode.first.aid >%virvar%resume.var

echo NORMAL MODE
echo.>>%virlog%
echo NORMAL MODE (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
echo ========================================>>%virlog%

IF NOT EXIST %virlog% goto main.menu

cls
echo ========================================
echo [%autorunstate%] Virophage Will Start Next Boot
echo COMPUTERNAME: %computername%
echo Customer Name: %first.name% %last.name%
echo Invoice #: %job.number% 
echo ========================================
if exist %virvar%resume.var set /p resume=<%virvar%resume.var
if exist %virvar%resume.var echo Last Run: %resume%
IF NOT EXIST "c:\acr\%logname%.txt" goto system.specs
echo.
echo.
echo.
echo Starting Point?
echo 1 Beginning
echo 2 CCleaner
echo 3 Chocolatey Updates
echo 4 TFC
echo 5 ADWCleaner
echo 6 Junk Removal Tool
echo 7 Reset Internet Settings
echo 8 Reset Firewall Settings
echo 9 Malware Bytes
echo 10 SAS Portable
echo 11 Spybot
echo 12 Secondary AV Scan
echo 13 Hitman Pro
echo 14 TDSSKiller
echo 15 AutoRuns
echo 16 HijackThis!
echo 17 Remove Bloatware
echo 18 Spybot Immunize
echo 19 CCleaner Registry Fix
echo 20 WOT
echo 21 AdBlockers
echo 22 Firefox Proxy Settings
echo 23 Arbiter Virus?
echo.
if "%windows.mode%"=="Safe" echo YOU ARE TRYING TO RUN NORMAL MODE FIRST 
if "%windows.mode%"=="Safe" echo AID WHILE IN SAFE MODE!!!!!!!!!!!!!!!!!
echo.
set /p choice="Enter Choice: "
if %choice% == 2 goto nccleaner
if %choice% == 3 goto chocoupdates
if %choice% == 4 goto ntfc
if %choice% == 5 goto normal.mode.adwcleaner
if %choice% == 6 goto normal.mode.JRT
if %choice% == 7 goto ninet
if %choice% == 8 goto nfirewall
if %choice% == 9 goto nmbam
if %choice% == 10 goto nsas
if %choice% == 11 goto nspybot
if %choice% == 12 goto neset
if %choice% == 13 goto nhitmanpro
if %choice% == 14 goto ntdsskiller
if %choice% == 15 goto nautoruns
if %choice% == 16 goto nhijackthis
if %choice% == 17 goto nbloatware
if %choice% == 18 goto nimmunize
if %choice% == 19 goto nregistry
if %choice% == 20 goto normal.mode.wot
if %choice% == 21 goto normal.mode.adblockers
if %choice% == 22 goto firefox.proxy
if %choice% == 23 goto arbiter.virus

cls
echo ========================================
echo [%autorunstate%] Virophage Will Start Next Boot
echo COMPUTERNAME: %computername%
echo Customer Name: %first.name% %last.name%
echo Invoice #: %job.number% 

if exist %virvar%resume.var set /p resume=<%virvar%resume.var
if exist %virvar%resume.var echo Last Run: %resume%
IF NOT EXIST "c:\acr\%logname%.txt" goto system.specs
echo.
echo.
echo.

cls

echo.
echo.

echo Is the boot.ini set to start in Normal Mode?
start msconfig -2
echo Initial
set /p initial=
echo (%initial%) Msconfig set to NORMAL MODE (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
cls

echo.
echo.

:nccleaner
echo nccleaner >%virvar%resume.var
echo CCLEANER
set name=Ccleaner
if NOT "%processor_architecture%"=="%processor_architecture:32=%" start "" c:\acr\app\CCleaner.exe /AUTO
if NOT "%processor_architecture%"=="%processor_architecture:86=%" start "" c:\acr\app\CCleaner.exe /AUTO
if NOT "%processor_architecture%"=="%processor_architecture:64=%" start "" c:\acr\app\CCleaner64.exe /AUTO
echo (vp) CCleaner >> %virlog%
echo.

:chocolatey
echo Installing Chocolatey
if exist "%ALLUSERSPROFILE%\chocolatey\bin" goto skip.choco
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin

:skip.choco
echo Chocolatey is installed

:chocoupdates
echo chocoupdates >%virvar%resume.var
echo CHOCOLATEY UPDATES
set name=Chocolatey Updates
choco install GoogleChrome Silverlight flashplayeractivex flashplayerplugin AdobeAIR javaruntime k-litecodecpackstandard adobereader DotNet4.5
echo Did %name% finish completely?
echo Please initial
set /p initial=
echo (%initial%) %name%  (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
cls

echo.
echo.

:ntfc
echo ntfc >%virvar%resume.var
echo TFC
if not exist "c:\acr" md "c:\ACR"
if not exist "c:\acr\log" md "c:\ACR\log"
if exist "c:\acr\app\tfc.exe" goto ntfc.exist
xcopy "%Virophage.Source%app\tfc.exe" "%virapp%" /dsiy

:ntfc.exist
%virapp%tfc.exe --nogui --log="c:\ACR\log\normaltfc.txt"
echo (vp) TFC (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >> %virlog%


cls


:normal.mode.adwcleaner
echo normal.mode.adwcleaner >%virvar%resume.var
echo ADWCleaner
color 17
start /wait "ADWCleaner" "c:\acr\bat\adwcleaner.bat"
color 2F



cls

:normal.mode.JRT
echo normal.mode.JRT >%virvar%resume.var
echo JRT - Junk Removal Tool
color 17
start /wait "" "c:\acr\bat\jrt.bat"
color 2F
cls


:ninet
echo ninet >%virvar%resume.var
echo INETCPL.CPL
inetcpl.cpl
echo Did you reset internet Settings (delete personal settings for first aid virus)?
echo Please initial
set /p initial=
echo (%initial%) Reset Internet Settings  (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
cls

echo.
echo.
echo.

:nfirewall
echo nfirewall >%virvar%resume.var
start "" "firewallcheck.bat"
for /f "delims=" %%x in (%virvar%firewall.var) do set "firewall=%%x"
for /f "delims=" %%x in (%virvar%os.version.number.var) do set "winvernum=%%x"
echo Resetting Firewall
if %winvernum% GEQ 4 goto 4.firewall.reset
goto 3.firewall.reset

:4.firewall.reset
netsh advfirewall reset
goto after.firewall.reset

:3.firewall.reset
netsh firewall reset

:after.firewall.reset
rem if %firewall% == "Firewall Disabled" (
rem	netsh firewall set opmode disable
rem	echo Firewall disable because log says firewall was already off.
rem	)
echo Were there any errors? let shard know and/or restore defaults yourself.
echo Please initial
set /p initial=
echo (%initial%) Reset firewall settings (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
cls

echo.
echo.
echo.

:nmbam
echo nmbam >%virvar%resume.var
echo MALWARE BYTES
set name=Malware Bytes

::Check if MBAM exists
if exist "C:\Program Files (x86)\Malwarebytes' Anti-Malware\mbam.exe" goto normal.mode.skip.mbam.install
if exist "C:\Program Files\Malwarebytes' Anti-Malware\mbam.exe" goto normal.mode.skip.mbam.install

::Install MBAM
%virdir%app\mbam-setup.exe /SP- /SILENT /NOCANCEL
:normal.mode.skip.mbam.install

::Update MBAM
if exist "C:\Program Files (x86)\Malwarebytes' Anti-Malware\mbam.exe" "C:\Program Files (x86)\Malwarebytes' Anti-Malware\mbam.exe" /updateshowdialog
if exist "C:\Program Files\Malwarebytes' Anti-Malware\mbam.exe" "C:\Program Files\Malwarebytes' Anti-Malware\mbam.exe" /updateshowdialog

::Run RKILL and MBAM quick
%virapp%rkill.com
if exist "C:\Program Files\Malwarebytes' Anti-Malware\mbam.exe" start "" "C:\Program Files\Malwarebytes' Anti-Malware\mbam.exe" /quickscan
if exist "C:\Program Files (x86)\Malwarebytes' Anti-Malware\mbam.exe" start "" "C:\Program Files (x86)\Malwarebytes' Anti-Malware\mbam.exe" /quickscan

echo Did %name% finish completely?
echo Please initial
set /p initial=
echo (%initial%) %name%  (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%

if exist "%userprofile%\Application Data\Malwarebytes\Malwarebytes' Anti-Malware\Logs\*" xcopy "%userprofile%\Application Data\Malwarebytes\Malwarebytes' Anti-Malware\Logs\*" "c:\acr\log\*" /dsiy
if exist "%userprofile%\AppData\Roaming\Malwarebytes\Malwarebytes' Anti-Malware\Logs\*" xcopy "%userprofile%\AppData\Roaming\Malwarebytes\Malwarebytes' Anti-Malware\Logs\*" "c:\acr\log\*" /dsiy

cls

echo.
echo.
echo.

:nsas
echo nsas >%virvar%resume.var
echo SAS PORTABLE
set name=SAS
%virapp%sas.com

echo Did %name% finish completely?
echo Please initial
set /p initial=
echo (%initial%) %name%  (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
cls

echo.
echo.
echo.

:nspybot
echo nspybot >%virvar%resume.var
echo SPYBOT
set name=Spybot

if exist "C:\Program Files\Spybot - Search & Destroy\SpybotSD.exe" goto normal.run.spybot
if exist "C:\Program Files (x86)\Spybot - Search & Destroy\SpybotSD.exe" goto normal.run.spybot

:normal.install.spybot
%virdir%app\spybot.exe /verysilent /components="main" /tasks="!launchteatimer" /norestart

:normal.run.spybot
if exist "C:\Program Files\Spybot - Search & Destroy\SpybotSD.exe" start "" "C:\Program Files\Spybot - Search & Destroy\SpybotSD.exe"
if exist "C:\Program Files (x86)\Spybot - Search & Destroy\SpybotSD.exe" start "" "C:\Program Files (x86)\Spybot - Search & Destroy\SpybotSD.exe"

echo Did %name% finish completely?
echo Please initial
set /p initial=
echo (%initial%) %name%  (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%


if exist "%allusersprofile%\Application Data\Spybot - Search & Destroy\Logs\*" xcopy "%userprofile%\Application Data\Spybot - Search & Destroy\Logs\*" "c:\acr\log\*" /dsiy
if exist "%allusersprofile%\AppData\Roaming\Spybot - Search & Destroy\Logs\*" xcopy "%userprofile%\AppData\Roaming\Spybot - Search & Destroy\Logs\*" "c:\acr\log\*" /dsiy

cls

echo.
echo.
echo.

:neset
echo nreset >%virvar%resume.var
echo ESET
set name=eset
%virapp%eset
echo Did %name% finish completely?
echo Please initial
set /p initial=
echo (%initial%) %name%  (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
cls

:nhitmanpro
echo nhitmanpro >%virvar%resume.var
echo HITMAN PRO

::for /f "delims=" %%x in (c:/acr/var/architecture.var) do set "architecture=%%x"

set architecture=%processor_architecture%
echo %architecture%


if NOT "%processor_architecture%"=="%processor_architecture:32=%" goto normal.mode.hitmanpro.32
if NOT "%processor_architecture%"=="%processor_architecture:86=%" goto normal.mode.hitmanpro.32
if NOT "%processor_architecture%"=="%processor_architecture:64=%" goto normal.mode.hitmanpro.64


:checknhitmanpro
echo Architecture? (32 or 64)
echo (system variable says %processor_architecture%)
set /p architecture=
goto nhitmanpro

:normal.mode.hitmanpro.32
	echo Hitman Pro 32
	%virdir%app\hitmanpro32.exe
	goto passnhitmanpro

:normal.mode.hitmanpro.64
	echo Hitman Pro 64
	%virdir%app\hitmanpro64.exe
	goto passnhitmanpro




:passnhitmanpro
echo passnhitmanpro >%virvar%resume.var
echo Did Hitman Pro finish completely?
echo Please initial
set /p initial=
echo (%initial%) Hitman Pro  (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
xcopy C:\ProgramData\HitmanPro\Logs c:\acr\log\hitman /dsiy

cls

echo.
echo.
echo.

:ntdsskiller
echo ntdsskiller >%virvar%resume.var
echo TDSSKILLER
set name=TdssKiller

md c:\ACR
md c:\ACR\log
%virapp%tdsskiller -l "c:\ACR\log\tdss.txt"

echo Did TDSSKiller finish completely?
echo Please initial
set /p initial=
echo (%initial%) TDSSKiller  (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
cls

echo.
echo.
echo.

:nmsconfig
echo nmsconfig >%virvar%resume.var
echo MSCONFIG
start msconfig
echo Go the General tab and change to 'Normal Startup'. Remember, 
echo MSConfig is only to be used for diagnostic purposes.  This is
echo why we use 'Normal Startup' and block Startups and Services
echo using other methods like Autoruns and Hijackthis!
echo.
echo Please initial
set /p initial=
echo (%initial%) MSConfig  (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
cls

echo.
echo.
echo.


:nautoruns
echo nautoruns >%virvar%resume.var
echo AUTORUNS
%virapp%autoruns
echo Did you run autoruns?
echo Please initial
set /p initial=
echo (%initial%) Autoruns  (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
cls

echo.
echo.
echo.

:nhijackthis
echo nhijackthis >%virvar%resume.var
echo HIJACKTHIS
%virdir%app\hijackthis.exe

echo Did you go over the hijack this log?
echo Please initial
set /p initial=
echo (%initial%) HijackThis  (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
cls

echo.
echo.
echo.


:nbloatware
echo nbloatware >%virvar%resume.var
echo REMOVE BLOATWARE
start /wait "" "%virbat%bloatware.bat"
if NOT "%processor_architecture%"=="%processor_architecture:32=%" start "" c:\acr\app\CCleaner.exe /tools
if NOT "%processor_architecture%"=="%processor_architecture:86=%" start "" c:\acr\app\CCleaner.exe /tools
if NOT "%processor_architecture%"=="%processor_architecture:64=%" start "" c:\acr\app\CCleaner64.exe /tools
echo Did you remove common bloatware?
echo Please initial
set /p initial=
echo (%initial%) Remove Bloatware  (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
cls

echo.
echo.
echo.

:nimmunize
echo nimmunize >%virvar%resume.var
echo Immunize with Spybot
"C:\Program Files\Spybot - Search & Destroy\SpybotSD.exe"
"C:\Program Files (x86)\Spybot - Search & Destroy\SpybotSD.exe"
echo Did you immunize with spybot?
echo Please initial
set /p immunizeini=
echo (%immunizeini%) Immunize with Spybot (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
::log preview start
cls

echo.
echo.
::log preview end


:normal.mode.choco
echo normal.mode.choco >%virvar%resume.var
echo CHOCO UPDATES
set name=Choco Updates
choco update GoogleChrome Silverlight flashplayeractivex flashplayerplugin AdobeAIR javaruntime k-litecodecpackstandard adobereader DotNet4.5
color 2F
start %virbat%cleanup.firstaid.bat
color 2F
echo Did Choco Updates finish completely?
echo Please initial
set /p initial=
echo (%initial%) Choco Updates  (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
cls

echo.
echo.

:nregistry
echo nregistry >%virvar%resume.var
echo CCLEANER REGISTRY FIX
echo Save registry backups in c:/acr/bak
start registry.bat
echo Did you clean the registry?
echo Please initial
set /p initial=
echo (%initial%) CCleaner Registry Fix (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
cls

echo.
echo.

:normal.mode.wot
echo normal.mode.wot >%virvar%resume.var
echo Web of Trust
color 17
start "" "c:\acr\bat\installwot.bat"
color 2F
echo Did you install Web of Trust on all browsers?
echo Please initial
set /p initial=
echo (%initial%) Web of Trust (DATE: %date% %time:~0, -6% USER:"%username%" %windows.mode%) >>%virlog%
cls

:normal.mode.adblockers
echo normal.mode.adblockers >%virvar%resume.var
echo Ad Blockers
color 17
start "" "c:\acr\bat\install.adblockers.bat"
color 2F
echo Did you install AdBlockers?
echo Please initial
set /p initial=
echo (%initial%) AdBlockers (DATE: %date% %time:~0, -6% USER:"%username%" %windows.mode%) >>%virlog%
cls

:firefox.proxy
echo firefox.proxy >%virvar%resume.var
echo Detected Firefox proxy settings:
findstr /S "proxy" %APPDATA%\Mozilla\Firefox\Profiles\*.js
echo.
pause
echo.
echo Did you check for malicious Firefox 
echo proxy settings?
echo Please initial
set /p initial=
echo (%initial%) Firefox Proxy (DATE: %date% %time:~0, -6% USER:"%username%" %windows.mode%) >>%virlog%
cls

:arbiter virus
echo arbiter.virus >%virvar%resume.var
echo Did you check the user library for 
echo hidden data (arbiter virus)?
echo Please initial
set /p initial=
echo (%initial%) Arbiter Virus (DATE: %date% %time:~0, -6% USER:"%username%" %windows.mode%) >>%virlog%
cls


::finished.first.aid
echo NORMAL MODE DONE (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>%virlog%
echo finished.first.aid >%virvar%resume.var
goto main.menu


:fresh.reload
echo fresh.reload >%virvar%resume.var
echo.>>%virlog%
echo FRESH RELOAD>>%virlog%
echo ========================================>>%virlog%
echo.
echo 1 Activate Windows
echo 2 Drivers
echo 3 Ninite Updates
echo 4 Desktop Links
echo 5 Install Wot
echo 6 Install Adblockers
echo 7 Install MBAM
echo 8 Battery Tray Utility

set /p fresh="Enter Choice: "
if %fresh% == 1 goto fresh.reload.activate
if %fresh% == 2 goto fresh.reload.drivers
if %fresh% == 3 goto fresh.reload.ninite
if %fresh% == 4 goto fresh.reload.desktop.links
if %fresh% == 5 goto fresh.reload.install.wot
if %fresh% == 6 goto fresh.reload.install.adblockers
if %fresh% == 7 goto fresh.reload.install.mbam
if %fresh% == 8 goto fresh.reload.battery.tray.utility

goto main.menu

:fresh.reload.activate
echo.
echo Fresh Reload
echo FRESH RELOAD
echo.
echo Opening Windows Activation
if not exist "c:\acr\var\os.version.name.var" goto system.specs
::if XP
for /f "delims=" %%x in (c:\acr\var\os.version.name.var) do set "version=%%x"
if "%version%"=="%version:xp=%" goto fresh.reload.activate.not.xp
start /wait "" "%systemroot%\system32\oobe\msoobe.exe" /a
goto fresh.reload.activate.done

:fresh.reload.activate.not.xp
start /wait "" "slui.exe"

:fresh.reload.activate.done
echo Did you activate Windows?
echo Please initial
set /p initial=
echo (%initial%) Windows activated (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%


:fresh.reload.drivers
echo fresh.reload.drivers >%virvar%resume.var
echo.
echo Opening Device Manager (devmgmt.msc)
start /wait "" "devmgmt.msc"
echo Did you install all of the drivers?
echo Please initial
set /p initial=
echo (%initial%) Drivers  (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%


:fresh.reload.ninite
echo fresh.reload.ninite >%virvar%resume.var
echo Please wait while Ninite updates your computer

set name=Ninite Updates
%virdir%app\freshupdates.exe
start %virbat%cleanup.freshreload.bat
echo Did %name% finish completely?
echo Please initial
set /p initial=
echo (%initial%) %name%  (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
cls

echo.
echo.
 

:fresh.reload.desktop.links
echo fresh.reload.desktop.links >%virvar%resume.var
xcopy "c:\acr\bat\Try Dropbox free!.url" "%allusersprofile%\desktop\*" /siy
xcopy "c:\acr\bat\Try Dropbox free!.url" "%public%\desktop\*" /siy
regedit /s c:/acr/bat/reg/xp.desktop.items.reg
regedit /s c:/acr/bat/reg/addcomputeranduserfoldertodesktop.reg
echo (vp) Placed My Computer and User Folder/My Documents on Desktop (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
echo Placed My Computer, IE, and User Folder/My Documents on Desktop (Click the desktop and press F5 to refresh the desktop and see the changes)
xcopy "c:\acr\bat\lnk\Internet Explorer.lnk" "%allusersprofile%\desktop\*" /siy


:fresh.reload.install.wot
echo fresh.reload.install.wot >%virvar%resume.var
echo. 
echo Web of Trust
color 17
start /wait "" "c:\acr\bat\installwot.bat"
color 2F
pause

:fresh.reload.install.adblockers
echo fresh.reload.adblockers >%virvar%resume.var
echo Ad Blockers
color 17
start "" "c:\acr\bat\install.adblockers.bat"
color 2F
echo Did you install AdBlockers?
echo Please initial
set /p initial=
echo (%initial%) AdBlockers (DATE: %date% %time:~0, -6% USER:"%username%" %windows.mode%) >>%virlog%
cls




rem :fresh.reload.install.mbam
rem echo fresh.reload.install.mbam >%virvar%resume.var
rem echo.
rem echo OPENING FIREFOX PORTABLE FOR MALWARE BYTES LICENSING
rem ECHO.
rem ECHO PLEASE ENTER LICENSING INFO AFTER LOGGING INTO GOOGLE ACCOUNT.
rem if exist "%programfiles(x86)%\Malwarebytes' Anti-Malware\mbam.exe" goto skip.mbam.install
rem if exist "%ProgramFiles%\Malwarebytes' Anti-Malware\mbam.exe" goto skip.mbam.install
rem if exist "C:\Program Files\Malwarebytes' Anti-Malware\mbam.exe" goto skip.mbam.install
rem %virdir%app\mbam-setup.exe /SP- /SILENT /NOCANCEL
rem 
rem :skip.mbam.install

rem start /min %virbat%mbamfirefox.bat

rem echo Paste ID
rem set /p ID=
rem echo Paste KEY
rem set /p KEY=
rem 
rem if exist "%ProgramFiles%\Malwarebytes' Anti-Malware\mbam.exe" "%ProgramFiles%\Malwarebytes' Anti-Malware\mbam.exe" /register %ID% %KEY%
rem if exist "%programfiles(x86)%\Malwarebytes' Anti-Malware\mbam.exe" "%programfiles(x86)%\Malwarebytes' Anti-Malware\mbam.exe" /register %ID% %KEY%
rem 
rem echo Malware Bytes ID: %ID%  Key: %KEY% >%virvar%mbam.var
rem for /f "delims=" %%x in (%virvar%mbam.var) do set "mbam.key.license=%%x"
rem echo (vp) %mbam.key.license% (DATE: %date% %time:~0, -6% USER:"%username%" %windows.mode%) >>%virlog%
rem echo finished.fresh.reload >%virvar%resume.var
rem */

:fresh.reload.battery.tray.utility
cls
echo fresh.reload.battery.tray.utility >%virvar%resume.var
echo Battery Tray Utility
echo Does it seem to be operating correctly?
echo When you plug and unplug the charger
echo does the icon change accordingly?
echo Please initial
set /p initial=
echo (%initial%) Battery Tray Utility (DATE: %date% %time:~0, -6% USER:"%username%" %windows.mode%) >>%virlog%


echo finished.fresh.reload >%virvar%resume.var

goto main.menu



:new.computer
echo new.computer >%virvar%resume.var
echo.>>%virlog%
echo NEW COMPUTER>>%virlog%
echo ========================================>>%virlog%
echo.
echo 1 Activate Windows
echo 2 Drivers
echo 3 Ninite Updates
echo 4 Desktop Links
echo 5 Install Wot

set /p fresh="Enter Choice: "
if %fresh% == 1 goto new.computer.activate
if %fresh% == 2 goto new.computer.drivers
if %fresh% == 3 goto new.computer.ninite
if %fresh% == 4 goto new.computer.desktop.links
if %fresh% == 5 goto new.computer.install.wot
goto main.menu

:new.computer.activate
echo.
echo New Computer
echo.
echo Opening Windows Activation
if not exist "c:\acr\var\os.version.name.var" goto system.specs
::if XP
for /f "delims=" %%x in (c:\acr\var\os.version.name.var) do set "version=%%x"
if "%version%"=="%version:xp=%" goto new.computer.activate.not.xp
start /wait "" "%systemroot%\system32\oobe\msoobe.exe" /a
goto new.computer.activate.done

:new.computer.activate.not.xp
start /wait "" "slui.exe"

:new.computer.activate.done
echo Did you activate Windows?
echo Please initial
set /p initial=
echo (%initial%) Windows activated (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%


:new.computer.drivers
echo new.computer.drivers >%virvar%resume.var
echo.
echo Opening Device Manager (devmgmt.msc)
start /wait "" "devmgmt.msc"
echo Did you install all of the drivers?
echo Please initial
set /p initial=
echo (%initial%) Drivers  (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%


:new.computer.ninite
echo new.computer.ninite >%virvar%resume.var
::log preview start
cls

echo.
echo.
::Log preview end


echo Please wait while Ninite updates your computer

%virdir%app\newupdates.exe
start %virbat%bloatware.bat
echo Did Ninite Updates finish completely?
echo Please initial
set /p initial=
echo (%initial%) Ninite Updates  (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
cls

echo.
echo.
xcopy "c:\acr\bat\Try Dropbox free!.url" "%allusersprofile%\desktop\*" /siy

:new.computer.desktop.links
echo new.computer.desktop.links >%virvar%resume.var

regedit /s c:/acr/bat/reg/xp.desktop.items.reg
regedit /s c:/acr/bat/reg/addcomputeranduserfoldertodesktop.reg
echo (vp) Placed My Computer and User Folder/My Documents on Desktop (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
echo Placed My Computer, IE, and User Folder/My Documents on Desktop (Click the desktop and press F5 to refresh the desktop and see the changes)
xcopy "c:\acr\bat\lnk\Internet Explorer.lnk" "%allusersprofile%\desktop\*" /siy


:new.computer.install.wot
echo new.computer.install.wot >%virvar%resume.var
echo. 
echo Web of Trust
color 17
start /wait "" "c:\acr\bat\installwot.bat"
color 2F


echo finished.new.computer >%virvar%resume.var
goto finished.new.computer








:checkover
echo checkover >%virvar%resume.var


IF NOT EXIST %virlog% goto main.menu

echo ========================================
echo [%autorunstate%] Virophage Will Start Next Boot
echo COMPUTERNAME: %computername%
echo Customer Name: %first.name% %last.name%
echo Invoice #: %job.number% 
echo ========================================
if exist %virvar%resume.var set /p resume=<%virvar%resume.var
if exist %virvar%resume.var echo Last Run: %resume%
IF NOT EXIST "c:\acr\%logname%.txt" goto system.specs

echo Make sure all problems of job are addressed? (Signed off by an officer)
set name=Make sure all problems of job are addressed
echo Initial
set /p initial=
echo (%initial%) %name%(DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
cls


echo HERE ARE SOME FLAGGED NOTES WE HAVE FOUND.
type "%virdir%%logname%.txt" | find "Note:" 
type "%virdir%%logname%.txt" | find "!" 
ECHO HAVE WE ADDRESSED ALL OF THESE?
echo Initial:
set /p initial=
echo (%initial%) Flags addressed (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
cls

echo.
echo. 





cls
echo ========================================
echo [%autorunstate%] Virophage Will Start Next Boot
echo COMPUTERNAME: %computername%
echo Customer Name: %first.name% %last.name%
echo Invoice #: %job.number% 
echo ========================================
if exist %virvar%resume.var set /p resume=<%virvar%resume.var
if exist %virvar%resume.var echo Last Run: %resume%
IF NOT EXIST "c:\acr\%logname%.txt" goto system.specs
echo Starting Point?
echo.
echo.
echo 1 Beginning
echo 2 Latest Service Pack
echo 3 Verify Office
echo 4 Autoplay DVD
echo 5 Hide Hidden Files
echo 6 Verify User Data and Apps
echo 7 Essential 4
echo.
set /p choice="Enter Choice: "

if %choice% == 2 goto latest.service.pack
if %choice% == 3 goto check.over.office
if %choice% == 4 goto autoplay.dvd
if %choice% == 5 goto check.over.hide.hidden.files
if %choice% == 6 goto check.over.verify.data.and.apps
if %choice% == 7 goto essential

cls
echo ========================================
echo [%autorunstate%] Virophage Will Start Next Boot
echo COMPUTERNAME: %computername%
echo Customer Name: %first.name% %last.name%
echo Invoice #: %job.number% 
echo ========================================
if exist %virvar%resume.var set /p resume=<%virvar%resume.var
if exist %virvar%resume.var echo Last Run: %resume%
IF NOT EXIST "c:\acr\%logname%.txt" goto system.specs
echo CHECKOVER
echo.
echo.>>%virlog%
echo CHECKOVER (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
echo ========================================>>%virlog%
cls

echo.
echo.

REM CHECK CPU USAGE
start "" "taskmgr.exe"

echo TASK MANAGER
echo Go to the processes tab in Task Manager. Make sure the computer will idle below 10% cpu usage before initialing to continue
echo Initial:
set /p initial=
echo (%initial%) Task Manager idles below 10% (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
cls

:latest.service.pack
echo latest.service.pack >%virvar%resume.var
echo CHECKING SERVICE PACK...
start c:\acr\bat\check.service.pack.bat

cls

eventvwr /c:system
echo EVENTVIEWER
echo Are there any large chunks of error messages (10 or so) that we need to address?
echo If no, then initial, else explain
set /p initial=
echo (%initial%) Eventviewer(DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
cls

echo.
echo.
echo.

echo DEVICE MANAGER
echo no yellow exclamations + no 'generic' or 'standard' video drivers?
start "" "devmgmt.msc"
set name=Drivers
echo Initial
set /p initial=
echo (%initial%) %name%(DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
cls

echo.
echo.
echo.

echo At least IE8?
set name=IE8
echo Initial
set /p initial=
echo (%initial%) %name%(DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
cls

echo.
echo.
echo.

:check.over.office
echo check.over.office >%virvar%resume.var
echo Please open an office document to verify it is working.
echo Please initial
set /p initial=
echo (%initial%) Verify Office (DATE: %date% %time:~0, -6% USER:"%username%" %windows.mode%) >>%virlog%
cls

:check.over.one.office
echo check.over.one.office >%virvar%resume.var
echo Please verify that there is only 1 version of office installed.
echo Please initial
set /p initial=
echo (%initial%) Only 1 Office Installation (DATE: %date% %time:~0, -6% USER:"%username%" %windows.mode%) >>%virlog%
cls


echo Ethernet?
set name=Ethernet
echo Initial
set /p initial=
echo (%initial%) %name%(DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
cls

echo.
echo.
echo.

type %virlog% | find "desktop" >nul
if errorlevel 1 goto wifiyes
echo wifi skipped (desktop)
goto skipwifi
:wifiyes
echo wifiyes >%virvar%resume.var
echo Wifi?
set name=Wifi
echo Initial
set /p initial=
echo (%initial%) %name%(DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
cls

echo.
echo.
echo.
:skipwifi
echo skipwifi >%virvar%resume.var


type %virlog% | find "desktop" >nul
if errorlevel 1 goto camyes
echo Webcam skipped (desktop)
goto skipcam
:camyes
echo camyes >%virvar%resume.var
echo Webcam?
start %virapp%\ffx\FirefoxPortable.exe -private-window http://www.allthingsinc.com/tek/test-webcam/
set name=Webcam
echo Initial
set /p initial=
echo (%initial%) %name%(DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
cls

echo.
echo.
echo.
:skipcam
echo skipcam >%virvar%resume.var

type %virlog% | find "desktop" >nul
if errorlevel 1 goto micyes
echo Mic skipped (desktop)
goto skipmic
:micyes
echo micyes >%virvar%resume.var
echo Mic?
set name=Mic
echo Initial
set /p initial=
echo (%initial%) %name%(DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
cls

echo.
echo.
echo.
:skipmic
echo skipmic >%virvar%resume.var
echo.


:autoplay.dvd
echo Autoplays DVDs?
echo autoplay.dvd >%virvar%resume.var
"c:\acr\bat\nircmdc.exe" cdrom open d:
"c:\acr\bat\nircmdc.exe" cdrom open e:
"c:\acr\bat\nircmdc.exe" cdrom open f:


set name=Autoplays DVD
echo Initial
set /p initial=
echo (%initial%) %name%(DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
cls

echo.
echo.
echo.

type %virlog% | find "desktop" >nul
if errorlevel 1 goto audioyes
echo Audio skipped (desktop)
goto skipaudio
:audioyes
echo audioyes >%virvar%resume.var
echo Audio (laptops only)?
set name=Audio
echo Initial
set /p initial=
echo (%initial%) %name%(DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
cls

echo.
echo.
echo.
:skipaudio
echo skipaudio >%virvar%resume.var

type %virlog% | find "desktop" >nul
if errorlevel 1 goto fnyes
echo Functions keys skipped (desktop)
goto skipfn
:fnyes
echo gnyes >%virvar%resume.var
echo FN Keys and Extra Palmrest Buttons are functional?
set name=FN Keys and Extra Buttons
echo Initial
set /p initial=
echo (%initial%) %name%(DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
cls

echo.
echo.
echo.
:skipfn
echo skipfn >%virvar%resume.var

echo Time and Date are correct?
set name=Time and Date
echo Initial
set /p timeini=
echo (%timeini%) %name%(DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
cls

echo Clean up desktop, remove any icons added by us?
set name=Clean up desktop, remove any icons added by us
echo Initial
set /p initial=
echo (%initial%) %name%(DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
cls

echo.
echo.
echo.

:check.over.hide.hidden.files
echo check.over.hide.hidden.files >%virvar%resume.var
echo Please verify that hiddens files are in
echo fact hidden
echo Please initial
set /p initial=
echo (%initial%) Hide Hidden Files (DATE: %date% %time:~0, -6% USER:"%username%" %windows.mode%) >>%virlog%
cls


echo Check CD Player for company discs?
"c:\acr\bat\nircmdc.exe" cdrom open d:
"c:\acr\bat\nircmdc.exe" cdrom open e:
"c:\acr\bat\nircmdc.exe" cdrom open f:
set name=Check CD Player for company discs
echo Initial
set /p initial=
echo (%initial%) %name%(DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
cls

echo.
echo.
echo.

:check.over.verify.data.and.apps
cls
echo check.over.verify.data.and.apps >%virvar%resume.var
echo Please verify the data and apps noted
echo by the customer on the checkin form.
echo Please initial
set /p initial=
echo (%initial%) Verify User Data and Apps (DATE: %date% %time:~0, -6% USER:"%username%" %windows.mode%) >>%virlog%


:essential

start /min %virbat%getram.bat
echo essential >%virvar%resume.var
cls
echo ========================================
echo [%autorunstate%] Virophage Will Start Next Boot
echo COMPUTERNAME: %computername%
echo Customer Name: %first.name% %last.name%
echo Invoice #: %job.number% 
echo ========================================
if exist %virvar%resume.var set /p resume=<%virvar%resume.var
if exist %virvar%resume.var echo Last Run: %resume%
IF NOT EXIST "c:\acr\%logname%.txt" goto system.specs
echo ESSENTIAL 4
echo.
echo.
echo ===============ESSENTIAL 4=============== >>%virlog%
pause

cls
echo.
echo.
echo.
echo Virophage says
type %virvar%ram.var
set adequateram=NO
echo.
echo Adequate RAM(YES/NO)?
SET /P adequateram=
echo Initial (Adequate RAM or customer knows there is less than recommended RAM)
set /p endRAMini=
set /p ram=<%virvar%ram.var
echo (%endRAMini%) Adequate RAM? %adequateram% Current Ram: %ram% >> %virlog%
echo.

for /f "delims=" %%x in (%virvar%os.free.space.var) do set "os.free.space=%%x"
echo The log says: 
echo %os.free.space% %%
echo Is there at least 10% free space on the OS drive?
echo Initial
set /p initial=
echo (%initial%) Percent Free: %os.free.space% %% >>%virlog%
cls

echo.
echo.
echo.

echo Does the computer only have one real-time scan antivirus?
echo Initial
set /p avini=
echo What type(s) of Malware or Virus protection is present?
set /p avtype=
echo %avtype%>c:\acr\var\avtype.var
echo (%avini%) AntiVirus: %avtype% >>%virlog%
cls

echo.
echo.
echo.

echo What backup system is in place?
set /p backup=
echo %backup%>c:\acr\var\backup.system.var
echo Initial
set /p backupini=
echo (%backupini%) Backup System: %backup% >>%virlog%
cls

echo.
echo.



echo ==========(DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%)========== >>%virlog%
cls

echo.
echo.

type "%virvar%mbam.var" >>%virlog%
cls

echo.
echo.

echo HERE ARE SOME FLAGGED NOTES WE HAVE FOUND.
type "%virdir%%logname%.txt" | find "Note:" 
type "%virdir%%logname%.txt" | find "!" 

echo Summary for customer of things we did that helped fix this computer (Must be done by an officer)
set name=Quick Summary
set /p answer=
echo Initial
set /p initial=
echo (%initial%) %name%: %answer% >>%virlog%
cls


echo.
echo.
echo.



goto up


:up
echo up >%virvar%resume.var
cls

echo.
echo.
for /f "delims=" %%x in (%virvar%first.name.var) do set "first.name=%%x"
for /f "delims=" %%x in (%virvar%last.name.var) do set "last.name=%%x"
start %virapp%\ffx\FirefoxPortable.exe -private-window https://lansend.lmi.net/tt/search.php?go=Search&other=ACR+%first.name%+%last.name%&status=&users=&queues=&types=                                          
Type %virlog% | "%virapp%clip.exe"
goto main.menu

:clear
echo clear >%virvar%resume.var
del %virlog%
goto main.menu

:set.job.number
color 17
start %virbat%set.job.number.bat
goto exit

:show.file.extension
start %~dp0reg\show.file.extension.bat
goto exit

:add.note
cls
type "%virdir%%logname%.txt" | find "Note:"
echo What note would you like to add?
set /p note=
echo Initial
set /p initial=

echo (%initial%) Note:%note% >>%virlog%
goto main.menu

:admin.tools
cls

for /f "delims=" %%x in (%virvar%job.number.var) do set "job.number=%%x"

echo ========================================
echo [%autorunstate%] Virophage Will Start Next Boot
echo COMPUTERNAME: %computername%
echo Customer Name: %first.name% %last.name%
echo Invoice #: %job.number% 
echo ========================================
if exist %virvar%resume.var set /p resume=<%virvar%resume.var
if exist %virvar%resume.var echo Last Run: %resume%
IF NOT EXIST "c:\acr\%logname%.txt" goto system.specs
echo.
echo 1 View Log File
echo 2 Set as a Workstation
echo 3 Change Job Number
echo 4 Install GotoAssist
echo 9 Exit
echo Type 'clear' to delete the log file
echo.
set /p choice="Enter Choice: "
if %choice% == 1 goto viewlog
if %choice% == 2 goto set.as.a.workstation
if %choice% == 3 goto set.job.number
if %choice% == 4 goto install.gotoassist
if %choice% == 9 goto exit
if %choice% == clear goto clear
if %choice% == vim goto vim
goto main.menu

:install.gotoassist
color 17
start /wait "Install Gotoassist" "c:\acr\bat\install.gotoassist.bat"
color 2F
goto main.menu


:set.as.a.workstation
color 17
start /wait "Set as a Workstation" "c:\acr\bat\set.as.a.workstation.bat"
start /wait "Workstation" "c:\acr\bat\workstation.bat"
color 2F
goto admin.tools

:hd.health
cls
echo hd.health >%virvar%resume.var
echo HD HEALTH
echo 1 Hard Disk Sentinel (or other quick test)
echo 2 Long Diagnostic Test (preferrably Seatools or WD Diag)
echo 3 This is a new hard drive
echo 4 Ask me later
set /p choice="Enter Choice: "

if %choice% == 1 goto hd.sentinel
if %choice% == 2 goto hd.long
if %choice% == 3 goto hd.new
goto main.menu

:hd.sentinel
echo Percent: _ _ _ %%
set /p percent=
echo %percent% >%virvar%hdsentinel.percent.var
echo Initial
set /p initial=
echo. >>%virlog%
echo HD Health >>%virlog%
echo ======================================== >>%virlog%
echo (%initial%) HD Sentinel Health Percentage:%percent% %% (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
cls

echo What is the health status from HD Sentinel?
set /p status=
echo %status% >%virvar%hdsentinel.status.var
echo Initial
set /p initial=
echo (%initial%) HD Sentinel Health Status: %status% (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
cls
goto finished.hd.health

:hd.long
echo What are the results from the long, full hd diagnostic?
set /p diagnostic=
echo %diagnostic% >%virvar%long.hd.diag.var 
echo Initial
set /p initial=
echo (%initial%) HD Diagnostic: %diagnostic% (DATE: %date% %time:~0,-6% USER:"%username%" %windows.mode%) >>%virlog%
cls
goto finished.hd.health

:hd.new
echo %date% >%virvar%hd.new.var 

:finished.hd.health
echo finished.hd.health >%virvar%resume.var


goto skip.hd.health.check

:snap.shot
cls
echo Snap Shot
echo ========================================
echo.

echo Notes and Flags
echo ========================================
type "%virdir%%logname%.txt" | find "Note:" 
type "%virdir%%logname%.txt" | find "!" 
for /f "delims=" %%x in (c:\acr\var\long.hd.diag.var) do set "hd.diagnostic=%%x"
echo.
echo.
echo Hard Drive Diagnostic:%hd.diagnostic%
if exist %virvar%resume.var set /p resume=<%virvar%resume.var
if exist %virvar%resume.var echo Last Run: %resume%
echo.

echo INFECTIONS:
echo Trojans
findstr /I "trojan" c:\acr\log\*.txt
echo.

echo System32
findstr /I "system32" c:\acr\log\mbam*.txt
echo.

echo Hijacks
findstr /I "hijack" c:\acr\log\*.txt
echo.

echo Essential 4
echo ========================================

if exist %virvar%ram.var for /f "delims=" %%x in (%virvar%ram.var) do set "ram=%%x"
echo RAM:%ram%
if exist %virvar%os.free.space.var for /f "delims=" %%x in (%virvar%os.free.space.var) do set "free.space=%%x"
echo Free Space:%free.space% %%
if exist %virvar%avtype.var for /f "delims=" %%x in (%virvar%avtype.var) do set "av.type=%%x"
echo AV:%av.type%
if exist %virvar%backup.system.var for /f "delims=" %%x in (%virvar%backup.system.var) do set "backup.system=%%x"
echo Backup:%backup.system%
pause
goto main.menu

:vim
start "VIM Window" "c:\acr\bat\vim.bat"
goto main.menu

::start.footer Sat 06/07/2014  7:25:23.27 
:error.log
echo %~1
echo %date%,%time% - %~1 >>c:\acr\log\error.log.txt
exit /b 0
main.menu
::end.footer

:exit
exit