REM ===== START HEADER =====
@echo off
color 4f

set virapp=%virdir%app\
set virbat=%virdir%bat\
set virzip=%virdir%zip\
set virvar=%virdir%var\
if not exist %virdir%var md %virdir%var
if not exist %virdir%bak md %virdir%bak
for /f "delims=" %%x in (c:\acr\bat\version.var) do set "version=%%x"
cls
REM ===== END HEADER =====

echo %Date% %Time% >> "c:\acr\log\Evernote Log.log" 

if exist "C:\Program Files (x86)\Evernote\Evernote\" goto open.evernote

:install.evernote
start /wait "c:\acr\app\evernote.exe" /quiet
pause

:open.evernote
"C:\Program Files (x86)\Evernote\Evernote\ENScript.exe" SyncDatabase /l "c:\acr\log\Evernote Log.log" /u acrlmi /p acrlmi4204201
"C:\Program Files (x86)\Evernote\Evernote\ENScript.exe" showNotes /q "notebook:Customer Check-Ups 2x Daily and Voicemails"
if %errorlevel% gtr 0 "C:\Program Files (x86)\Evernote\Evernote\evernote.exe"

:exit
exit