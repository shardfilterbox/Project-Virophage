@echo off
color 4f

set virapp=%virdir%app\
set virbat=%virdir%bat\
echo %virlog%

color 04
start /wait "Doing First Aid Cleanup First" c:\acr\bat\cleanup.firstaid.bat
color 4f

if exist "C:\Program Files\Trend Micro\Titanium\Remove.exe" "C:\Program Files\Trend Micro\Titanium\Remove.exe"
del "C:\Program Files\Trend Micro\Titanium\UIFramework\uiWinMgr.exe" /f


exit