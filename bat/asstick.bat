@echo off
color 4f
set virdir=C:\acr\

::Set Log Name
for /f "delims=" %%x in (%virvar%job.number.var) do set "job.number=%%x"
for /f "delims=" %%x in (%virvar%first.name.var) do set "first.name=%%x"
for /f "delims=" %%x in (%virvar%last.name.var) do set "last.name=%%x"
set logname=ACR%first.name%%last.name%%job.number%
set virlog="c:\acr\%logname%.txt"

set virapp=%virdir%app\
set virbat=%virdir%bat\
set virzip=%virdir%zip\
set virvar=%virdir%var\
if not exist %virdir%var md %virdir%var
if not exist %virdir%bak md %virdir%bak
cls
rem end header


:virostart
if not exist %virvar%resume.var goto skipresume

:resume
echo There is a resume file.
echo Resume file says:
type %virvar%resume.var
echo Would you like to use this resume point? Y or N 
set /p choice=
if %choice% == n goto skipresume
if %choice% == N goto skipresume

set /p resume=<%virvar%resume.var
if exist %virvar%resume.var goto %resume%

:skipresume
cls
ECHO V       V I RRR   OOOO  PPP  H  H     A      GGG  EEEE
ECHO  V     V  I R  R O    O P  P H  H    A A    G     E
ECHO   V   V   I RRR  O    O PPP  HHHH   AAAAA   G  GG EEE
ECHO    V V    I R R  O    O P    H  H  A     A  G   G E
ECHO     V     I R  R  OOOO  P    H  H A       A  GGG  EEEE
ECHO.
PAUSE
cls
echo ====================================================
echo                 Virophage v10.101 beta
echo ====================================================
echo.
echo.
echo.
echo NEW IN THIS VERSION:
echo.
echo auto run as admin
echo RUN FROM PORTABLE DRIVE
echo auto signed ccleaner
echo skip wifi, mic, webcam, fn keys, audio etc if desktop
echo static virophage title line
echo imporved system specs enforcer
echo added skip open combofix link if log found
pause
cls
echo ====================================================
echo                 Virophage v10.101 beta
echo ====================================================
echo.
echo.
echo.
echo.
rem END HEADER

if exist %virlog% goto viewlog

:Menu


cls
echo ====================================================
echo                 Virophage v10.101 beta
echo ====================================================
start /min /wait %virbat%tiprand.bat
set /p tipnum=<%virvar%ran.var
type %virbat%tips\%tipnum%
echo:
echo ===================TIPS AND TRICKS==================

IF NOT EXIST %virlog% goto systemspecs
echo.
echo 1 View Log File
echo 2 System Specs
echo 3 Installs
echo 4 First Aid
echo 5 Fresh Reload
echo 6 New Computer
echo 7 Checkover
echo 8 Upload to ttracker
echo 9 Exit
echo Type 'clear' to delete the log file
echo.
set /p choice="Enter Choice: "
if %choice% == 1 goto viewlog
if %choice% == 2 goto systemspecs
if %choice% == 3 goto installs
if %choice% == 4 goto firstaidmode
if %choice% == 5 goto freshreload
if %choice% == 6 goto newcomputer
if %choice% == 7 goto checkover
if %choice% == 8 goto up
if %choice% == 9 goto exit
if %choice% == clear goto clear
goto menu

:firstaidmode
echo firstaidmode >%virvar%resume.var
cls
echo ====================================================
echo                 Virophage v10.101 beta
echo ====================================================
echo.
echo.
echo.
echo 1 Safe Mode
echo 2 Normal Mode
echo.
set /p choice="Enter Choice: "
if %choice% == 1 goto s
if %choice% == 2 goto n


goto menu


:viewlog
echo viewlog >%virvar%resume.var
cls
echo ====================================================
echo                 Virophage v10.101 beta
echo ====================================================
if exist %virlog% (
echo ---------------
echo LOG FILE EXISTS
echo ---------------
echo.
type %virlog%
)

pause
goto menu

:installs
echo installs >%virvar%resume.var
cls
echo ====================================================
echo                 Virophage v10.101 beta
echo ====================================================
echo.
echo.
echo.
echo 1 Avira Registered
echo 2 Malware Bytes Registered
echo 3 Wot
set /p install="Enter Choice: "
if %install% == 1 goto installavirareg
if %install% == 2 goto installmbamreg
if %install% == 3 goto installwot

:installavirareg
echo installavirareg >%virvar%resume.var
start %virbat%avirachrome.bat
start %virdir%app\avira-premium.exe

goto menu
:installmbamreg
echo installmbamreg >%virvar%resume.var
%virdir%app\mbam-setup.exe /SP- /SILENT /NOCANCEL

start /min %virbat%mbamchrome.bat

echo Paste ID
set /p ID=
echo Paste KEY
set /p KEY=

"%ProgramFiles%\Malwarebytes' Anti-Malware\mbam.exe" /register %ID% %KEY%
"%programfiles(x86)%\Malwarebytes' Anti-Malware\mbam.exe" /register %ID% %KEY%

echo Malware Bytes ID: %ID%  Key: %KEY% >%virvar%mbam.var

goto menu

:installwot
echo installwot >%virvar%resume.var
start "" %virbat%installwot.bat
goto menu

:systemspecs
echo systemspecs >%virvar%resume.var

cls
echo ====================================================
echo                 Virophage v10.101 beta
echo ====================================================
echo -------------------------------------------------------
echo YOU NEED TO RUN SYSTEM SPECS BEFORE DOING ANYTHING ELSE
echo -------------------------------------------------------
echo.
echo Starting Point?
echo 1 Windows Version
echo 2 Service Pack
echo 3 Ram
echo 4 Architecture
echo 5 Browser Default
echo 6 AV
echo 7 Laptop or Desktop
echo 8 Hard Drive
echo.

set /p choice="Enter Choice: "
if %choice% == 2 goto sp
if %choice% == 3 goto startram
if %choice% == 4 goto architecture
if %choice% == 5 goto browserdefault
if %choice% == 6 goto startav
if %choice% == 7 goto lapordesk
if %choice% == 8 goto hard drive
echo SYSTEM SPECS >>%virlog%
echo SYSTEM SPECS (windows + pause)

set wvernum=0
start control /name microsoft.system
ver | findstr /i "5\.0\." > nul
IF %ERRORLEVEL% EQU 0 set wvernum=1
ver | findstr /i "5\.1\." > nul
IF %ERRORLEVEL% EQU 0 set wvernum=2
ver | findstr /i "5\.2\." > nul
IF %ERRORLEVEL% EQU 0 set wvernum=3
ver | findstr /i "6\.0\." > nul
IF %ERRORLEVEL% EQU 0 set wvernum=4
ver | findstr /i "6\.1\." > nul
echo.
IF %ERRORLEVEL% EQU 0 set wvernum=5
IF %wvernum% == 0 goto manwver
goto autowver

:manwver
echo manwver >%virvar%resume.var

echo Windows Version?
echo 1 Windows 2000
echo 2 Windows XP
echo 3 Windows 2003
echo 4 Windows Vista
echo 5 Windows 7
echo if other just type in
set /p wversion="Enter Choice: "

:autowver
echo autover >%virvar%resume.var
if %wvernum% == 1 set versionname=Windows 2000 
if %wvernum% == 2 set versionname=Windows XP
if %wvernum% == 3 set versionname=Windows Server 2003
if %wvernum% == 4 set versionname=Windows Vista
if %wvernum% == 5 set versionname=Windows 7

set winvernum=%virdir%var\winvernum.var
echo.
echo %wvernum% >%winvernum%
echo.
echo Windows Version is %versionname%
echo.


echo Windows Edition? (Home Premium, Professional, MCE...)
set /p edition=
echo Initial
set /p initial=
echo (%initial% )%versionname% %edition%>> %virlog%
echo.

:sp
echo sp >%virvar%resume.var

set servicepack=0
FOR /F "tokens=2* delims=	 " %%A IN ('REG QUERY "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CSDversion') DO SET servicepack=%%B
echo %servicepack% >%virdir%var\sp.var

:virosp
echo virosp >%virvar%resume.var
echo Service Pack %servicepack%
echo (VP) Service Pack %servicepack% >>%virlog%
goto spdone

REM usersp	
REM echo The system may not have a service pack installed.
REM echo Service Pack?
REM set /p answer=
REM echo Initial
REM set /p initial=
REM echo (%initial%) %initial% says Service Pack %answer% Virophage says Service Pack %servicepack% >>%virlog%

:spdone
echo spdone >%virvar%resume.var
echo.

:startram
echo startram >%virvar%resume.var
set ram=0
start /min %virbat%getram.bat
for /f "delims=" %%x in (%virvar%ram.var) do set "ram=%%x"
echo Virophage says %ram%
echo (vp)RAM %ram% >>%virlog%
if %ram% == 0 goto manram
set initial=vp
goto autoram

:manram
echo manram >%virvar%resume.var
echo RAM in gb?
set /p ram=
echo Initial
set /p initial=
echo %ram% >%virvar%ram.var

:autoram
echo autoram >%virvar%resume.var
echo (%initial%) RAM %ram% >>%virlog%

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
echo (%initial%) Architecture %architecture% >>%virlog%
echo %architecture% >%virdir%var\architecture.var

:browserdefault
echo browserdefault>%virvar%resume.var

echo What is the default browser and homepage(s)?
set /p answer=
echo Initial
set /p initial=
echo (%initial%) Default Browser and Homepage "%answer%" >>%virlog%
echo.

:startav
echo startav >%virvar%resume.var

echo What AV does the computer have


start "" %virdir%app\CCleaner.exe /tools
set /p answer=
echo Initial
set /p initial=
echo (%initial%) Antivirus %answer% >>%virlog%
echo.
if initial == exit exit
if initial == menu goto menu

:lapordesk
echo lapordesk >%virvar%resume.var

echo Is this a 1.laptop or 2.desktop?
set /p lapordesk=
if %lapordesk% == 1 set lapordesk=laptop
if %lapordesk% == 2 set lapordesk=desktop
echo %lapordesk% > lapordesk.txt
echo Initial
set /p lapordeskini=
echo (%lapordeskini%) %lapordesk% >>%virlog%

:disk
echo disk >%virvar%resume.var
start diskmgmt.msc
echo DISC MANAGEMENT
echo Size of Hard Drive(s) in gb?
set /p answer=
echo Initial
set /p initial=
echo (%initial%) Hard Drive Size %answer% %% >>%virlog%
echo.

echo Partitioned correctly?
set name=Disc Management
echo Initial
set /p initial=
echo (%initial%) %name%>>%virlog%
echo.

echo Size of OS Partition in gb?
set/p ossize=
echo Initial
set /p ossizeini=
echo %ossize% > %virvar%ossize.var
echo (%ossizeini%) OS Size %ossize%gb >> %virlog%
echo.

echo Percent Free?
set /p percentfree=
echo Initial
set /p initial=
echo (%initial%) Percent Free %percentfree%  >>%virlog%
echo.


goto menu
:s
echo s >%virvar%resume.var

IF NOT EXIST %virlog% goto menu
cls
echo ====================================================
echo                 Virophage v10.101 beta
echo ====================================================
echo.
echo.
echo.
type %virlog%
echo Starting Point?
echo 1 Beginning
echo 2 CCleaner
echo 3 TFC
echo 4 Reset Internet Settings
echo 5 Reset Firewall Settings
echo 6 Combofix
echo 7 Malware Bytes
echo 8 SAS Portable
echo 9 Spybot
echo 10 Secondary AV Scan
echo 11 Hitman Pro
echo 12 TDSSKiller
echo 13 AutoRuns
echo 14 HijackThis!
echo 15 MSConfig
echo 22 Ninite Updates
echo.
set /p choice="Enter Choice: "
if %choice% == 2 goto sccleaner
if %choice% == 3 goto stfc
if %choice% == 4 goto sinet
if %choice% == 5 goto sfirewall
if %choice% == 6 goto scombofix
if %choice% == 7 goto smbam
if %choice% == 8 goto ssas
if %choice% == 9 goto sspybot
if %choice% == 10 goto seset
if %choice% == 11 goto shitmanpro
if %choice% == 12 goto stdsskiller
if %choice% == 13 goto sautoruns
if %choice% == 14 goto shijackthis
if %choice% == 15 goto smsconfig
if %choice% == 22 goto sninite
cls
echo ====================================================
echo                 Virophage v10.101 beta
echo ====================================================
echo.
echo.
echo.
echo SAFE MODE >>%virlog%

echo Did you modify the boot.ini for Safe Mode with Networking?
start msconfig -2
echo Initial
set /p initial=
echo (%initial%) Safe Mode w/ Networking >>%virlog%

:sccleaner
echo sccleaner >%virvar%resume.var
echo CCLEANER
set name=Ccleaner
start %virdir%app\CCleaner.exe /AUTO
echo (VP) %name%  >>%virlog%
echo.

:stfc
echo stfc >%virvar%resume.var
echo TFC
set name=TFC
md "c:\ACR"
md "c:\ACR\logs"
%virapp%tfc.exe --nogui --log="c:\ACR\logs\safetfc.txt"
start %virbat%beep.bat
echo Free Space in gb (found at bottom of TFC readout)?
set /p answer=
echo Please initial
set /p initial=
echo (%initial%) Free Space %answer%gb >>%virlog%
echo Did %name% finish completely?
echo Please initial
set /p initial=
echo (%initial%) %name%  >>%virlog%
echo.

:sinet
echo sinet >%virvar%resume.var
echo INETCPL.CPL
inetcpl.cpl
echo Connections > Lan Settings > Make sure ONLY Automatically Detect Settings is checked.
echo Advanced > Restore Advanced Settings and Reset, deleting personal Settings.
echo Please initial
set /p initial=
echo (%initial%) Reset Internet and LAN Settings  >>%virlog%
echo.

:sfirewall
echo sfirewall >%virvar%resume.var
start firewallcheck.bat
for /f "delims=" %%x in (%virvar%firewall.var) do set "firewall=%%x"
for /f "delims=" %%x in (%virvar%winvernum.var) do set "winvernum=%%x"
echo Resetting Firewall
if %winvernum% GEQ 4 (netsh advfirewall reset) else (netsh firewall reset)
if %firewall% == "Firewall Disabled" (
	netsh firewall set opmode disable
	echo Firewall disable because log says firewall was alreadry off.
	)
echo Were there any errors? let shard know and/or restore defaults yourself.
echo Please initial
set /p initial=
echo (%initial%) Reset firewall settings >>%virlog%
echo.

:scombofix
echo scombofix >%virvar%resume.var
echo COMBOFIX
set name=Combofix
if not exist c:\combofix.txt goto startbrowser
move c:\combofix.txt %virdir%logs
echo Save combofix log as? (suggest date and time no spaces no special chars)
set /p combolog=
ren %virdir%logs\ComboFix.txt "cf-%combolog%".txt
goto skipcombrowser

:startbrowser
echo startbrowser >%virvar%resume.var
pause
start "" "%virdir%app\chrome\chrome.exe" http://www.bleepingcomputer.com/forums/topic114351.html
start "" "%virdir%app\chrome\chrome.exe" http://www.bleepingcomputer.com/download/anti-virus/combofix

:skipcombrowser
echo skipcombrowser >%virvar%resume.var

echo Did %name% finish completely?
echo Please initial
set /p initial=

echo (%initial%) %name%  >>%virlog%
echo.

:smbam
echo smbam >%virvar%resume.var
echo MALWARE BYTES
set name=Malware Bytes
%virdir%app\mbam-setup.exe /SP- /SILENT /NOCANCEL

"C:\Program Files (x86)\Malwarebytes' Anti-Malware\mbam.exe" /updateshowdialog
"C:\Program Files\Malwarebytes' Anti-Malware\mbam.exe" /updateshowdialog

%virapp%rkill.com
"C:\Program Files\Malwarebytes' Anti-Malware\mbam.exe" /quickscan
"C:\Program Files (x86)\Malwarebytes' Anti-Malware\mbam.exe" /quickscan

echo Did %name% finish completely?
echo Please initial
set /p initial=
echo (%initial%) %name%  >>%virlog%
echo.

:ssas
echo ssas >%virvar%resume.var
echo SAS PORTABLE
set name=SAS
%virapp%sas.com

echo Did %name% finish completely?
echo Please initial
set /p initial=
echo (%initial%) %name%  >>%virlog%
echo.

:sspybot
echo sspybot >%virvar%resume.var
echo SPYBOT
set name=Spybot
%virdir%app\spybot.exe /verysilent /components="main" /tasks="!launchteatimer" /norestart
"C:\Program Files\Spybot - Search & Destroy\SpybotSD.exe"
"C:\Program Files (x86)\Spybot - Search & Destroy\SpybotSD.exe"

echo Did %name% finish completely?
echo Please initial
set /p initial=
echo (%initial%) %name%  >>%virlog%
echo.

:seset
echo seset >%virvar%resume.var
echo ESET
set name=eset
%virapp%eset
echo Did %name% finish completely?
echo Please initial
set /p initial=
echo (%initial%) %name%  >>%virlog%
echo.

:shitmanpro
echo shitmanpro >%virvar%resume.var
echo HITMAN PRO
set name=Hitman Pro
if "%architecture%" == "" goto checkshitmanpro
if %architecture% == 32 (
	%virdir%app\hitmanpro32.exe
	goto passshitmanpro
	)
if %architecture% == 64 (
	%virdir%app\hitmanpro64.exe
	goto passshitmanpro
	)
:checkshitmanpro
echo checkshitmanpro>%virvar%resume.var
echo Architecture? (32 or 64)
echo (system variable says %SYSTEM_PROCESSOR%)
set /p architecture=
goto shitmanpro
:passshitmanpro
echo passshitmanpro >%virvar%resume.var
echo Did %name% finish completely?
echo Please initial
set /p initial=
echo (%initial%) %name%  >>%virlog%
echo.

:stdsskiller
echo stdsskiller >%virvar%resume.var
echo TDSSKILLER
set name=TdssKiller

md c:\ACR
md c:\ACR\logs
%virapp%tdsskiller -l "c:\ACR\logs\tdss.txt"

echo Did %name% finish completely?
echo Please initial
set /p initial=
echo (%initial%) %name%  >>%virlog%
echo.

:sautoruns
echo sautoruns >%virvar%resume.var
echo AUTORUNS
%virapp%autoruns
echo Did you run autoruns?
echo Please initial
set /p initial=
echo (%initial%) Autoruns  >>%virlog%
echo.

:shijackthis
echo shijackthis >%virvar%resume.var
echo HIJACKTHIS
%virdir%app\hijackthis.exe

echo Did you go over the hijack this log?
echo Please initial
set /p initial=
echo (%initial%) HijackThis  >>%virlog%
echo.

:smsconfig
echo smsconfig>%virvar%resume.var
echo MSCONFIG
start msconfig
echo Did you go over the msconfig startup programs and services?
echo Please initial
set /p initial=
echo (%initial%) MSConfig  >>%virlog%
echo.

:sninite
echo sninite >%virvar%resume.var
echo NINITE UPDATES
set name=Ninite Updates
%virdir%app\sfirstupdates.exe
pause
start %virbat%cleanup.bat
echo Did %name% finish completely?
echo Please initial
set /p initial=
echo (%initial%) %name%  >>%virlog%

goto menu

:n
echo n >%virvar%resume.var
IF NOT EXIST %virlog% goto menu

cls
echo ====================================================
echo                 Virophage v10.101 beta
echo ====================================================
echo.
echo.
echo.
type %virlog%
echo Starting Point?
echo 1 Beginning
echo 2 CCleaner
echo 3 TFC
echo 4 Reset Internet Settings
echo 5 Reset Firewall Settings
echo 6 Combofix
echo 7 Malware Bytes
echo 8 SAS Portable
echo 9 Spybot
echo 10 Secondary AV Scan
echo 11 Hitman Pro
echo 12 TDSSKiller
echo 13 AutoRuns
echo 14 HijackThis!
echo 15 MSConfig
echo 16 Remove Bloatware
echo 20 Spybot Immunize
echo 22 Ninite Updates
echo 23 CCleaner Registry Fix
echo.
set /p choice="Enter Choice: "
if %choice% == 2 goto nccleaner
if %choice% == 3 goto ntfc
if %choice% == 4 goto ninet
if %choice% == 5 goto nfirewall
if %choice% == 6 goto ncombofix
if %choice% == 7 goto nmbam
if %choice% == 8 goto nsas
if %choice% == 9 goto nspybot
if %choice% == 10 goto neset
if %choice% == 11 goto nhitmanpro
if %choice% == 12 goto ntdsskiller
if %choice% == 13 goto nautoruns
if %choice% == 14 goto nhijackthis
if %choice% == 15 goto nmsconfig
if %choice% == 16 goto nbloatware
if %choice% == 20 goto nimmunize
if %choice% == 22 goto nninite
if %choice% == 23 goto nregistry

cls
echo ====================================================
echo                 Virophage v10.101 beta
echo ====================================================
echo.
echo.
echo.
echo NORMAL MODE
echo NORMAL MODE >>%virlog%

echo Is the boot.ini set to start in Normal Mode?
start msconfig -2
echo Initial
set /p initial=
echo (%initial%) NORMAL MODE >>%virlog%

:nccleaner
echo nccleaner >%virvar%resume.var
echo CCLEANER
set name=Ccleaner
%virdir%app\CCleaner.exe /AUTO
echo (VP) CCleaner >> %virlog%
echo.


echo RUNTIME UPDATES
set name=Runtime Updates
%virdir%app\sfirstupdates.exe
echo Did %name% finish completely?
echo Please initial
set /p initial=
echo (%initial%) %name%  >>%virlog%

:ntfc
echo ntfc >%virvar%resume.var
echo TFC
set name=TFC
md "c:\ACR"
md "c:\ACR\logs"
%virapp%tfc.exe --nogui --log="c:\ACR\logs\normaltfc.txt"
start %virbat%beep.bat
echo How much free space in gb is there now (shows at the end of the TFC readout)?
set /p freespace=

echo Please initial
set /p initial=
set freespaceini=initial
echo (%initial%) %freespace%gb Free Space >>%virlog%
echo (%initial%) TFC >>%virlog%
echo.

:ninet
echo ninet >%virvar%resume.var
echo INETCPL.CPL
inetcpl.cpl
echo Did you reset internet Settings (delete personal settings for first aid virus)?
echo Please initial
set /p initial=
echo (%initial%) Reset Internet Settings  >>%virlog%
echo.

:nfirewall
echo nfirewall >%virvar%resume.var
echo FIREWALL.CPL
firewall.cpl
pause
echo Did you restore firewall settings?
echo Please initial
set /p initial=
echo (%initial%) Reset firewall settings   >>%virlog%
echo.

:ncombofix
echo ncombofix >%virvar%resume.var
echo COMBOFIX
set name=Combofix
if not exist c:\combofix.txt goto startbrowser
move c:\combofix.txt %virdir%logs
echo Save combofix log as? (suggest date and time no spaces no special chars)
set /p combolog=
ren %virdir%logs\ComboFix.txt "cf-%combolog%".txt
goto skipcombrowser

:startbrowser
echo startbrowser >%virvar%resume.var

start "" "%virdir%app\chrome\chrome.exe" http://www.bleepingcomputer.com/forums/topic114351.html
start "" "%virdir%app\chrome\chrome.exe" http://www.bleepingcomputer.com/download/anti-virus/combofix

:skipcombrowser
echo skipcombrowser >%virvar%resume.var

echo Did %name% finish completely?
echo Please initial
set /p initial=

echo (%initial%) %name%  >>%virlog%
echo.

:nmbam
echo nmbam >%virvar%resume.var
echo MALWARE BYTES
set name=Malware Bytes
%virdir%app\mbam-setup.exe /SP- /SILENT /NOCANCEL

"C:\Program Files (x86)\Malwarebytes' Anti-Malware\mbam.exe" /updateshowdialog
"C:\Program Files\Malwarebytes' Anti-Malware\mbam.exe" /updateshowdialog

%virapp%rkill.com
"C:\Program Files\Malwarebytes' Anti-Malware\mbam.exe" /quickscan
"C:\Program Files (x86)\Malwarebytes' Anti-Malware\mbam.exe" /quickscan

echo Did %name% finish completely?
echo Please initial
set /p initial=
echo (%initial%) %name%  >>%virlog%
echo.

:nsas
echo nsas >%virvar%resume.var
echo SAS PORTABLE
set name=SAS
%virapp%sas.com

echo Did %name% finish completely?
echo Please initial
set /p initial=
echo (%initial%) %name%  >>%virlog%
echo.

:nspybot
echo nspybot >%virvar%resume.var
echo SPYBOT
set name=Spybot
%virdir%app\spybot.exe /verysilent /components="main" /tasks="!launchteatimer" /norestart
"C:\Program Files\Spybot - Search & Destroy\SpybotSD.exe"
"C:\Program Files (x86)\Spybot - Search & Destroy\SpybotSD.exe"

echo Did %name% finish completely?
echo Please initial
set /p initial=
echo (%initial%) %name%  >>%virlog%
echo.

:neset
echo nreset >%virvar%resume.var
echo ESET
set name=eset
%virapp%eset
echo Did %name% finish completely?
echo Please initial
set /p initial=
echo (%initial%) %name%  >>%virlog%
echo.

:nhitmanpro
echo nhitmanpro >%virvar%resume.var
echo HITMAN PRO
set name=Hitman Pro
if "%architecture%" == "" goto checknhitmanpro
if %architecture% == 32 (
	%virdir%app\hitmanpro32.exe
	goto passnhitmanpro
	)
if %architecture% == 64 (
	%virdir%app\hitmanpro64.exe
	goto passnhitmanpro
	)
:checknhitmanpro
echo checknhitmanpro >%virvar%resume.var
echo Architecture? (32 or 64)
echo (system variable says %SYSTEM_PROCESSOR%)
set /p architecture=
goto nhitmanpro
:passnhitmanpro
echo passnhitmanpro>%virvar%resume.var
echo Did %name% finish completely?
echo Please initial
set /p initial=
echo (%initial%) %name%  >>%virlog%
echo.

:ntdsskiller
echo ntdsskiller >%virvar%resume.var
echo TDSSKILLER
set name=TdssKiller

md c:\ACR
md c:\ACR\logs
%virapp%tdsskiller -l "c:\ACR\logs\tdss.txt"

echo Did %name% finish completely?
echo Please initial
set /p initial=
echo (%initial%) %name%  >>%virlog%
echo.

:nautoruns
echo nautoruns>%virvar%resume.var
echo AUTORUNS
%virapp%autoruns
echo Did you run autoruns?
echo Please initial
set /p initial=
echo (%initial%) Autoruns  >>%virlog%
echo.

:nhijackthis
echo nhijackthis>%virvar%resume.var
echo HIJACKTHIS
%virdir%app\hijackthis.exe

echo Did you go over the hijack this log?
echo Please initial
set /p initial=
echo (%initial%) HijackThis  >>%virlog%
echo.

:nmsconfig
echo nmsconfig >%virvar%resume.var
echo MSCONFIG
start msconfig
echo Did you go over the msconfig startup programs and services?
echo Please initial
set /p initial=
echo (%initial%) MSConfig  >>%virlog%
echo.

:nbloatware
echo nbloatware >%virvar%resume.var
echo REMOVE BLOATWARE
start %virbat%bloatware.bat
%virdir%app\CCleaner.exe /tools
echo Did you remove common bloatware?
echo Please initial
set /p initial=
echo (%initial%) Remove Bloatware  >>%virlog%
echo.

:nimmunize
echo nimmunize >%virvar%resume.var
echo Immunize with Spybot
"C:\Program Files\Spybot - Search & Destroy\SpybotSD.exe"
"C:\Program Files (x86)\Spybot - Search & Destroy\SpybotSD.exe"
echo Did you immunize with spybot?
echo Please initial
set /p immunizeini=
echo (%immunizeini%) Immunize with Spybot >>%virlog%

:nninite
echo nninite >%virvar%resume.var
echo NINITE UPDATES
set name=Ninite Updates
%virdir%app\nfirstupdates.exe
pause
start %virbat%cleanup.bat
echo Did %name% finish completely?
echo Please initial
set /p initial=
echo (%initial%) %name%  >>%virlog%

:nregistry
echo nregistry >%virvar%resume.var
echo CCLEANER REGISTRY FIX
echo Save registry backups in c:/acr/bak
start registry.bat
echo Did you clean the registry?
echo Please initial
set /p initial=
echo (%initial%) CCleaner Registry Fix >>%virlog%

goto menu


:freshreload
echo freshreload >%virvar%resume.var
echo 1 Ninite Updates
set /p fresh="Enter Choice: "
if %fresh% == 1 goto fninite else goto menu

:newcomputer
echo newcomputer >%virvar%resume.var
echo 1 Ninite Updates
set /p new="Enter Choice: "
if %new% == 1 goto nninite else goto menu

:fninite
echo fninite >%virvar%resume.var

echo Please wait while Ninite updates your computer

set name=Ninite Updates
%virdir%app\freshupdates.exe
start %virbat%cleanup.bat
echo Did %name% finish completely?
echo Please initial
set /p initial=
echo (%initial%) %name%  >>%virlog%
xcopy "%virdir%bat\Try Dropbox free!.url" "%allusersprofile%\desktop" /siy
goto menu

:nninite
echo nninite >%virvar%resume.var

echo Please wait while Ninite updates your computer
%virdir%app\newupdates.exe
start %virbat%cleanup.bat
echo Did NINITE UPDATES finish completely?
echo Please initial
set /p initial=
echo (%initial%) %name% >>%virlog%
xcopy "%virdir%bat\Try Dropbox free!.url" "%allusersprofile%\desktop" /siy
goto menu

:checkover
echo checkover >%virvar%resume.var


IF NOT EXIST %virlog% goto menu

echo ====================================================
echo                 Virophage v10.101 beta
echo ====================================================
echo HERE ARE SOME FLAGGED NOTES WE HAVE FOUND.
type "%virdir%log.txt" | find "!" >%virvar%!.var
type %virvar%!.var
ECHO HAVE WE ADDRESSED ALL OF THESE?
echo Initial:
set /p initial=
echo (%initial%) Flags addressed >>%virlog%




cls
echo ====================================================
echo                 Virophage v10.101 beta
echo ====================================================
echo Starting Point?
echo.
echo.
echo 1 Beginning
echo 2 Essential 4
echo.
set /p choice="Enter Choice: "

if %choice% == 2 goto :essential

cls
echo ====================================================
echo                 Virophage v10.101 beta
echo ====================================================
echo CHECKOVER
echo.
echo.
echo CHECKOVER >>%virlog%

eventvwr /c:system
echo EVENTVIEWER
echo Are there any large chunks of error messages (10 or so) that we need to address?
echo If no, then initial, else explain
set /p initial=
echo (%initial%) Eventviewer>>%virlog%
echo.

devmgmt.msc
echo DEVICE MANAGER
echo no yellow exclamations + no 'generic' or 'standard' video drivers?
set name=Drivers
echo Initial
set /p initial=
echo (%initial%) %name%>>%virlog%
echo.

echo At least IE8?
set name=IE8
echo Initial
set /p initial=
echo (%initial%) %name%>>%virlog%
echo.

echo Ethernet?
set name=Ethernet
echo Initial
set /p initial=
echo (%initial%) %name%>>%virlog%
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
echo (%initial%) %name%>>%virlog%
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
start "%virdir%app\chrome\chrome.exe" http://webcamvideo.us/
set name=Webcam
echo Initial
set /p initial=
echo (%initial%) %name%>>%virlog%
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
echo (%initial%) %name%>>%virlog%
echo.
:skipmic
echo skipmic>%virvar%resume.var
echo.

echo Autoplays DVDs?
set name=Autoplays DVD
echo Initial
set /p initial=
echo (%initial%) %name%>>%virlog%
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
echo (%initial%) %name%>>%virlog%
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
echo (%initial%) %name%>>%virlog%
echo.
:skipfn
echo skipfn >%virvar%resume.var

echo Time and Date are correct?
set name=Time and Date
echo Initial
set /p timeini=
echo (%timeini%) %name%>>%virlog%
echo.

echo Make sure all problems of job are addressed?
set name=Make sure all problems of job are addressed
echo Initial
set /p initial=
echo (%initial%) %name%>>%virlog%
echo.

echo Clean up desktop, remove any icons added by us?
set name=Clean up desktop, remove any icons added by us
echo Initial
set /p initial=
echo (%initial%) %name%>>%virlog%
echo.

echo Check CD Player for company discs?
set name=Check CD Player for company discs
echo Initial
set /p initial=
echo (%initial%) %name%>>%virlog%
echo.

:essential
echo essential >%virvar%resume.var
cls
echo ====================================================
echo                 Virophage v10.101 beta
echo ====================================================
echo ESSENTIAL 4
echo.
echo.
echo ==========ESSENTIAL 4========== >> %virlog%
echo.
echo Virophage says
type %virvar%ram.var
set adequateram=NO
echo.
echo Adequate RAM(YES/NO)?
SET /P adequateram=
echo Initial (Adequate RAM or customer knows there is less than recommended RAM)
set /p endRAMini=
start /min %virbat%getram.bat
set /p ram=<%virvar%ram.var
echo (%endRAMini%) Adequate RAM? %adequateram% Current Ram: %ram% >> %virlog%
echo.

echo LOG SAYS
type "%virlog%" | find "Percent"
echo Enough Free Space?
echo Initial
set /p initial=
echo (%initial%) Percent Free %percentfree%  >>%virlog%
echo.

echo Has only one up-to-date AV?
echo Initial
set /p avini=
echo What type of AV?
set /p avtype=
echo (%avini%) AntiVirus: %avtype% >>%virlog%
echo.

echo What backup system is in place?
set /p backup=
echo Initial
set /p backupini=
echo (%backupini%) Backup System: %backup%>>%virlog%



echo =============================================================== >>%virlog%

type "%virvar%mbam.var">>%virlog%

echo HERE ARE SOME FLAGGED NOTES WE HAVE FOUND.
type "%virdir%log.txt" | find "!" >>%virvar%!.var
type "%virvar%!.var"

echo Summary for customer of things we did that helped fix this computer (Must be done by an officer)
set name=Quick Summary
set /p answer=
echo Initial
set /p initial=
echo (%initial%) %name%: %answer% >>%virlog%
echo.



goto menu


:up
echo up >%virvar%resume.var
type %virvar%!.var >>%virlog%
start "" "%virdir%app\chrome\chrome.exe" https://lansend.lmi.net/tt/index.php?showme=1
Type %virlog% | %virapp%clip.exe
goto menu

:clear
echo clear >%virvar%resume.var
del %virlog%
goto menu

:exit
