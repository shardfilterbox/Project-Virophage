REM ===== START HEADER =====
@echo off
color 17
set virdir=C:\acr\
for /f "delims=" %%x in (%virvar%job.number.var) do set "job.number=%%x"
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


echo %version%

echo v20 gamma
echo -fixed malwarebytes installing and looking for v1 instead of v2
echo -trimmed bloatware so that everything is now useful and speedy
echo -replaced ninite with chocolatey
echo.
echo v10.101 beta
echo -auto run as admin
echo -RUN FROM PORTABLE DRIVE
echo -auto signed ccleaner
echo -skip wifi, mic, webcam, fn keys, audio etc if desktop
echo -static virophage title line
echo -improved system specs enforcer
echo -added skip open combofix link if log found
echo.
echo v10.11 beta
echo -Run virophage from the run box (Win + R)
echo -Added tracking with the ttracker number
echo.
echo v10.111 beta
echo -tracking by job number
echo -Fixed "Run virophage from the run box (Win + R)"
echo.
echo v11.0 beta
echo -background windows are a different color
echo -only downloads files if there is a newer version
echo -cleaned up log file
echo -added automatic product key pulling to the log folder
echo -skips installation of malwarebytes if already installed
echo =====================================================
echo                 Virophage %version%
echo =====================================================
ECHO V       V I RRR   OOOO  PPP  H  H     A      GGG  EEEE
ECHO  V     V  I R  R O    O P  P H  H    A A    G     E
ECHO   V   V   I RRR  O    O PPP  HHHH   AAAAA   G  GG EEE
ECHO    V V    I R R  O    O P    H  H  A     A  G   G E
ECHO     V     I R  R  OOOO  P    H  H A       A  GGG  EEEE
echo =====================================================
echo                 Virophage %version%
echo =====================================================
pause
goto exit

:exit
exit