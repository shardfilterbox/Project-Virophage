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
echo %virlog%



if exist "%ALLUSERSPROFILE%\Desktop\Media Player Classic.lnk" del "%ALLUSERSPROFILE%\Desktop\Media Player Classic.lnk"
if exist "%ALLUSERSPROFILE%\Desktop\Adobe Reader X.lnk" del "%ALLUSERSPROFILE%\Desktop\Adobe Reader X.lnk"
if exist "C:\Users\Public\Desktop\Media Player Classic.lnk" del "C:\Users\Public\Desktop\Media Player Classic.lnk"
if exist "C:\Users\Public\Desktop\Adobe Reader 8.lnk" del "C:\Users\Public\Desktop\Adobe Reader 8.lnk"
if exist "C:\Users\Public\Desktop\Adobe Reader XI.lnk" del "C:\Users\Public\Desktop\Adobe Reader XI.lnk"
if exist "C:\Program Files\K-Lite Codec Pack\Media Player Classic" del "C:\Program Files\K-Lite Codec Pack\Media Player Classic" /y
if exist "C:\Program Files (x86)\K-Lite Codec Pack\Media Player Classic" del "C:\Program Files (x86)\K-Lite Codec Pack\Media Player Classic" /y
if exist "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\K-Lite Codec Pack\Media Player Classic.lnk" del "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\K-Lite Codec Pack\Media Player Classic.lnk"
if exist "C:\Documents and Settings\All Users\Start Menu\Programs\K-Lite Codec Pack\Media Player Classic.lnk" del "C:\Documents and Settings\All Users\Start Menu\Programs\K-Lite Codec Pack\Media Player Classic.lnk"
if exist "C:\Program Files (x86)\Delta\delta\1.8.16.16\uninstall.exe" "C:\Program Files (x86)\Delta\delta\1.8.16.16\uninstall.exe" /q 
if exist "C:\ProgramData\BrowserProtect\2.6.1249.132\{c16c1ccb-7046-4e5c-a2f3-533ad2fec8e8}\uninstall.exe" "C:\ProgramData\BrowserProtect\2.6.1249.132\{c16c1ccb-7046-4e5c-a2f3-533ad2fec8e8}\uninstall.exe" /Uninstall /{15D2D75C-9CB2-4efd-BAD7-B9B4CB4BC693} /su=3b3336eddfd63c2a /um


exit