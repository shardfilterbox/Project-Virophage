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


echo Backup from clone or original hard drive
echo What is the source drive letter? (Target destination will ABC (Always Be C))
echo.
set /p source="Enter drive letter: " 
echo.
echo THIS WILL OVERWRITE ANY PREVIOUS BACKUP MADE TO ACR FOLDER
PAUSE
xcopy "%sOURCE%:\documents and settings\*" "%virdir%backups\documents and settings" /reiy
xcopy "%SOURCE%:\users\*" "%virdir%backups\users" /reiy
xcopy "%SOURCE%:\program files\*" "%virdir%backups\program files" /reiy
xcopy "%SOURCE%:\program files (x86)\*" "%virdir%backups\program files" /reiy

pause
goto exit





























:virostart
cls
ECHO V       V I RRR   OOOO  PPP  H  H     A      GGG  EEEE
ECHO  V     V  I R  R O    O P  P H  H    A A    G     E
ECHO   V   V   I RRR  O    O PPP  HHHH   AAAAA   G  GG EEE
ECHO    V V    I R R  O    O P    H  H  A     A  G   G E
ECHO     V     I R  R  OOOO  P    H  H A       A  GGG  EEEE
ECHO.
PAUSE
cls
echo ====================
echo Virophage v10.1 beta
echo ====================
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
echo ====================
echo Virophage v10.1 beta
echo ====================
echo.
echo.
echo.
rem END HEADER

if exist %virlog% goto viewlog

:Menu
cls
echo ====================
echo Virophage v10.1 beta
echo ====================

IF NOT EXIST %virlog% (
echo -------------------------------------------------------
echo YOU NEED TO RUN SYSTEM SPECS BEFORE DOING ANYTHING ELSE
echo -------------------------------------------------------
) ELSE (
echo.
echo.
echo.)

echo 1 View Log File
echo 2 System Specs
IF EXIST %virlog% (
echo 3 Installs
echo 4 First Aid
echo 5 Fresh Reload
echo 6 Checkover
echo 7 Upload to ttracker
)
echo 8 Exit
echo Type 'clear' to delete the log file
echo.
set /p choice="Enter Choice: "
if %choice% == 1 goto viewlog
if %choice% == 2 goto systemspecs
if %choice% == 3 goto installs
if %choice% == 4 goto firstaidmode
if %choice% == 5 goto freshreload
if %choice% == 6 goto checkover
if %choice% == 7 goto up
if %choice% == 8 goto exit
if %choice% == clear goto clear
goto menu

:firstaidmode
cls
echo ====================
echo Virophage v10.1 beta
echo ====================
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
cls
echo ====================
echo Virophage v10.1 beta
echo ====================
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
echo 1 Avira Registered
echo 2 Malware Bytes Registered
set /p install="Enter Choice: "
if %install% == 1 goto installavirareg
if %install% == 2 goto installmbamreg

:installavirareg
start %virbat%avirachrome.bat
start %virdir%app\avira-premium.exe

goto menu
:installmbamreg
%virdir%app\mbam-setup.exe /SP- /SILENT /NOCANCEL

start %virbat%mbamchrome.bat

echo Paste ID
set /p ID=
echo Paste KEY
set /p KEY=

"%ProgramFiles%\Malwarebytes' Anti-Malware\mbam.exe" /register %ID% %KEY%
"%programfiles(x86)%\Malwarebytes' Anti-Malware\mbam.exe" /register %ID% %KEY%

goto menu

:systemspecs

cls
echo ====================
echo Virophage v10.1 beta
echo ====================
echo.
echo.
echo.
echo Starting Point?
echo 1 Windows Version
echo 2 Service Pack
echo 3 Ram
echo 4 Architecture
echo 5 Browser Default
echo 6 AV
echo 7 Laptop or Desktop
echo.

set /p choice="Enter Choice: "
if %choice% == 2 goto sp
if %choice% == 3 goto startram
if %choice% == 4 goto architecture
if %choice% == 5 goto browserdefault
if %choice% == 6 goto startav
if %choice% == 7 goto lapordesk

echo SYSTEM SPECS >>%virlog%
echo SYSTEM SPECS (windows + pause)

start control /name microsoft.system
ver | findstr /i "5\.0\." > nul
IF %ERRORLEVEL% EQU 0 set wversion="Windows 2000"
ver | findstr /i "5\.1\." > nul
IF %ERRORLEVEL% EQU 0 set wversion="Windows XP"
ver | findstr /i "5\.2\." > nul
IF %ERRORLEVEL% EQU 0 set wversion="Windows Server 2003"
ver | findstr /i "6\.0\." > nul
IF %ERRORLEVEL% EQU 0 set wversion="Windows Vista"
ver | findstr /i "6\.1\." > nul
IF %ERRORLEVEL% EQU 0 set wversion="Windows 7"	
echo Windows Version? Virophage says %wversion%
echo 1 Windows 2000
echo 2 Windows XP
echo 3 Windows 2003
echo 4 Windows Vista
echo 5 Windows 7
echo if other just type in
set /p choice="Enter Choice: "
if %choice% == 1 set versionname=Windows 2000 
if %choice% == 2 set versionname=Windows XP
if %choice% == 3 set versionname=Windows Server 2003
if %choice% == 4 set versionname=Windows Vista
if %choice% == 5 set versionname=Windows 7
set winvernum=%virdir%var\winvernum.var
echo %choice% >%winvernum%
echo.

echo Windows Edition? (Home Premium, Professional, MCE...)
set /p answer=
echo Initial
set /p initial=
echo (%initial%) %initial% says %versionname% Virophage says %wversion% %answer%>> %virlog%
echo.

:sp
set servicepack=0
FOR /F "tokens=2* delims=	 " %%A IN ('REG QUERY "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CSDversion') DO SET servicepack=%%B
echo %servicepack% >%virdir%var\sp.var
if %servicepack% == 0 goto usersp

:virosp
echo Virophage says %servicepack%
echo (VP) Virophage says %servicepack% >>%virlog%
goto spdone

:usersp	
echo The system may not have a service pack installed.
echo Service Pack?
set /p answer=
echo Initial
set /p initial=
echo (%initial%) %initial% says Service Pack %answer% Virophage says Service Pack %servicepack% >>%virlog%

:spdone
echo.

:startram

start /wait %virbat%getram.bat
for /f "delims=" %%x in (%virvar%ram.var) do set "ram=%%x"
echo Virophage says %ram%
echo RAM in gb?
set /p answer=
echo Initial
set /p initial=
echo (%initial%) RAM %answer% >>%virlog%
echo.

:architecture

echo Architecture? Virophage says %processor_architecture%)
set /p architecture=
echo Initial
set /p initial=
echo (%initial%) Architecture  %initial% says %architecture%, Virophage says %processor_architecture% >>%virlog%
echo.

:browserdefault

echo What is the default browser and homepage(s)?
set /p answer=
echo Initial
set /p initial=
echo (%initial%) Default Browser and Homepage %answer% >>%virlog%
echo.

:startav

echo What AV does the computer have


%virdir%app\CCleaner.exe /tools
set /p answer=
echo Initial
set /p initial=
echo (%initial%) Antivirus %answer% >>%virlog%
echo.
if initial == exit exit
if initial == menu goto menu

:lapordesk

echo Is this a 1.laptop or 2.desktop?
set /p lapordesk=
if %lapordesk% == 1 set lapordesk=laptop
if %lapordesk% == 2 set lapordesk=desktop
echo %lapordesk% > lapordesk.txt
echo Initial
set /p lapordeskini=
echo (%lapordeskini%) %lapordesk% >>%virlog%

goto menu
:s

IF NOT EXIST %virlog% goto menu
cls
echo ====================
echo Virophage v10.1 beta
echo ====================
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
echo ====================
echo Virophage v10.1 beta
echo ====================
echo.
echo.
echo.
echo SAFE MODE >>%virlog%

echo Did you modify the boot.ini for Safe Mode with Networking?
msconfig -2
echo Initial
set /p initial=
echo (%initial%) Safe Mode w/ Networking >>%virlog%

:sccleaner
echo CCLEANER
set name=Ccleaner
start %virdir%app\CCleaner.exe /AUTO
echo (VP) %name%  >>%virlog%
echo.

:stfc
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
echo INETCPL.CPL
inetcpl.cpl
echo Connections > Lan Settings > Make sure ONLY Automatically Detect Settings is checked.
echo Advanced > Restore Advanced Settings and Reset, deleting personal Settings.
echo Please initial
set /p initial=
echo (%initial%) Reset Internet and LAN Settings  >>%virlog%
echo.

:sfirewall
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
echo COMBOFIX
set name=Combofix
if not exist c:\combofix.txt goto startbrowser
move c:\combofix.txt %virdir%logs
echo Save combofix log as? (suggest date and time no spaces no special chars)
set /p combolog=
ren %virdir%logs\ComboFix.txt "cf-%combolog%".txt
goto skipcombrowser

:startbrowser

start "" "%virdir%app\chrome\chrome.exe" http://www.bleepingcomputer.com/forums/topic114351.html
start "" "%virdir%app\chrome\chrome.exe" http://www.bleepingcomputer.com/download/anti-virus/combofix

:skipcombrowser

echo Did %name% finish completely?
echo Please initial
set /p initial=

echo (%initial%) %name%  >>%virlog%
echo.

:smbam
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
echo SAS PORTABLE
set name=SAS
%virapp%sas.com

echo Did %name% finish completely?
echo Please initial
set /p initial=
echo (%initial%) %name%  >>%virlog%
echo.

:sspybot
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
echo ESET
set name=eset
%virapp%eset
echo Did %name% finish completely?
echo Please initial
set /p initial=
echo (%initial%) %name%  >>%virlog%
echo.

:shitmanpro
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
echo Architecture? (32 or 64)
echo (system variable says %SYSTEM_PROCESSOR%)
set /p architecture=
goto shitmanpro
:passshitmanpro
echo Did %name% finish completely?
echo Please initial
set /p initial=
echo (%initial%) %name%  >>%virlog%
echo.

:stdsskiller
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
echo AUTORUNS
%virapp%autoruns
echo Did you run autoruns?
echo Please initial
set /p initial=
echo (%initial%) Autoruns  >>%virlog%
echo.

:shijackthis
echo HIJACKTHIS
%virdir%app\hijackthis.exe

echo Did you go over the hijack this log?
echo Please initial
set /p initial=
echo (%initial%) HijackThis  >>%virlog%
echo.

:smsconfig
echo MSCONFIG
msconfig
echo Did you go over the msconfig startup programs and services?
echo Please initial
set /p initial=
echo (%initial%) MSConfig  >>%virlog%
echo.

:sninite
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
IF NOT EXIST %virlog% goto menu

cls
echo ====================
echo Virophage v10.1 beta
echo ====================
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
cls
echo ====================
echo Virophage v10.1 beta
echo ====================
echo.
echo.
echo.
echo NORMAL MODE
echo NORMAL MODE >>%virlog%

echo Is the boot.ini set to start in Normal Mode?
msconfig -2
echo Initial
set /p initial=
echo (%initial%) NORMAL MODE >>%virlog%

:nccleaner
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
echo INETCPL.CPL
inetcpl.cpl
echo Did you reset internet Settings (delete personal settings for first aid virus)?
echo Please initial
set /p initial=
echo (%initial%) Reset Internet Settings  >>%virlog%
echo.

:nfirewall
echo FIREWALL.CPL
firewall.cpl
echo Did you restore firewall settings?
echo Please initial
set /p initial=
echo (%initial%) Reset firewall settings   >>%virlog%
echo.

:ncombofixecho COMBOFIX
set name=Combofix
if not exist c:\combofix.txt goto startbrowser
move c:\combofix.txt %virdir%logs
echo Save combofix log as? (suggest date and time no spaces no special chars)
set /p combolog=
ren %virdir%logs\ComboFix.txt "cf-%combolog%".txt
goto skipcombrowser

:startbrowser

start "" "%virdir%app\chrome\chrome.exe" http://www.bleepingcomputer.com/forums/topic114351.html
start "" "%virdir%app\chrome\chrome.exe" http://www.bleepingcomputer.com/download/anti-virus/combofix

:skipcombrowser

echo Did %name% finish completely?
echo Please initial
set /p initial=

echo (%initial%) %name%  >>%virlog%
echo.

:nmbam
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
echo SAS PORTABLE
set name=SAS
%virapp%sas.com

echo Did %name% finish completely?
echo Please initial
set /p initial=
echo (%initial%) %name%  >>%virlog%
echo.

:nspybot
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
echo ESET
set name=eset
%virapp%eset
echo Did %name% finish completely?
echo Please initial
set /p initial=
echo (%initial%) %name%  >>%virlog%
echo.

:nhitmanpro
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
echo Architecture? (32 or 64)
echo (system variable says %SYSTEM_PROCESSOR%)
set /p architecture=
goto nhitmanpro
:passnhitmanpro
echo Did %name% finish completely?
echo Please initial
set /p initial=
echo (%initial%) %name%  >>%virlog%
echo.

:ntdsskiller
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
echo AUTORUNS
%virapp%autoruns
echo Did you run autoruns?
echo Please initial
set /p initial=
echo (%initial%) Autoruns  >>%virlog%
echo.

:nhijackthis
echo HIJACKTHIS
%virdir%app\hijackthis.exe

echo Did you go over the hijack this log?
echo Please initial
set /p initial=
echo (%initial%) HijackThis  >>%virlog%
echo.

:nmsconfig
echo MSCONFIG
msconfig
echo Did you go over the msconfig startup programs and services?
echo Please initial
set /p initial=
echo (%initial%) MSConfig  >>%virlog%
echo.

:nbloatware
echo REMOVE BLOATWARE
start %virbat%bloatware.bat
%virdir%app\CCleaner.exe /tools
echo Did you remove common bloatware?
echo Please initial
set /p initial=
echo (%initial%) Remove Bloatware  >>%virlog%
echo.

:nimmunize
echo Immunize with Spybot
"C:\Program Files\Spybot - Search & Destroy\SpybotSD.exe"
"C:\Program Files (x86)\Spybot - Search & Destroy\SpybotSD.exe"
echo Did you immunize with spybot?
echo Please initial
set /p immunizeini=
echo (%immunizeini%) Immunize with Spybot >>%virlog%

:nninite
echo NINITE UPDATES
set name=Ninite Updates
%virdir%app\nfirstupdates.exe
pause
start %virbat%cleanup.bat
echo Did %name% finish completely?
echo Please initial
set /p initial=
echo (%initial%) %name%  >>%virlog%
goto menu

:freshreload
echo 1 Ninite Updates
set /p fresh="Enter Choice: "
if %fresh% == 1 goto fninite else goto menu


:fninite
echo NINITE UPDATES
set name=Ninite Updates
%virdir%app\freshupdates.exe
pause
start %virbat%cleanup.bat
echo Did %name% finish completely?
echo Please initial
set /p initial=
echo (%initial%) %name%  >>%virlog%

goto menu
:checkover


IF NOT EXIST %virlog% goto menu
cls
echo ====================
echo Virophage v10.1 beta
echo ====================
echo Starting Point?
echo.
echo.
echo 1 Beginning
echo 2 Essential 4
echo.
set /p choice="Enter Choice: "

if %choice% == 2 goto :essential

cls
echo ====================
echo Virophage v10.1 beta
echo ====================
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

echo Size of OS drive in gb?
set/p ossize=
echo Initial
set /p ossizeini=
echo (%ossizeini%) OS Size %ossize%gb >> %virlog%
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
echo Wifi?
set name=Wifi
echo Initial
set /p initial=
echo (%initial%) %name%>>%virlog%
echo.
:skipwifi


type %virlog% | find "desktop" >nul
if errorlevel 1 goto camyes
echo Webcam skipped (desktop)
goto skipcam
:camyes
echo Webcam?
start "%virdir%app\chrome\chrome.exe" http://webcamvideo.us/
set name=Webcam
echo Initial
set /p initial=
echo (%initial%) %name%>>%virlog%
echo.
:skipcam

type %virlog% | find "desktop" >nul
if errorlevel 1 goto micyes
echo Mic skipped (desktop)
goto skipmic
:micyes
echo Mic?
set name=Mic
echo Initial
set /p initial=
echo (%initial%) %name%>>%virlog%
echo.
:skipmic
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
echo Audio (laptops only)?
set name=Audio
echo Initial
set /p initial=
echo (%initial%) %name%>>%virlog%
echo.
:skipaudio

type %virlog% | find "desktop" >nul
if errorlevel 1 goto fnyes
echo Functions keys skipped (desktop)
goto skipfn
:fnyes
echo FN Keys and Extra Palmrest Buttons are functional?
set name=FN Keys and Extra Buttons
echo Initial
set /p initial=
echo (%initial%) %name%>>%virlog%
echo.
:skipfn

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
cls
echo ====================
echo Virophage v10.1 beta
echo ====================
echo ESSENTIAL 4
echo.
echo.
echo ==========ESSENTIAL 4========== >> %virlog%
echo.
echo LOG SAYS
type "%virdir%First Aid.txt" | find "RAM"
set adequateram=NO
echo.
echo Adequate RAM(YES/NO)?
SET /P adequateram=
echo Initial (Adequate RAM or customer knows there is less than recommended RAM)
set /p endRAMini=
echo (%endRAMini%) Adequate RAM? %adequateram% >>%virlog%
echo.

echo LOG SAYS
type "%virlog%" | find "OS Size"
type "%virlog%" | find "Free Space"
echo.
echo Approximate Percent Free?
set /p percentfree=
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

echo =============================== >>%virlog%

echo Summary for customer of things we did that helped fix this computer (Must be done by an officer)
set name=Quick Summary
set /p answer=
echo Initial
set /p initial=
echo (%initial%) %name%: %answer% >>%virlog%
echo.

goto menu


:up
start "" "%virdir%app\chrome\chrome.exe" https://lansend.lmi.net/tt/index.php?showme=1
Type %virlog% | clip
goto menu




:clear
del %virlog%
goto menu

:exit