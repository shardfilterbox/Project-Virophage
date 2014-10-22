@echo off
color 4f
cd %~dp0
for /f "delims=" %%b in ("%cd%") do set logname="%%~nb"
set logname=%logname%.txt
set path=C:\Windows\System32;%~dp0;%~dp0PortableApps


del "%ALLUSERSPROFILE%\Desktop\Media Player Classic.lnk"
del "%ALLUSERSPROFILE%\Desktop\Adobe Reader X.lnk"
del "C:\Users\Public\Desktop\Media Player Classic.lnk"
del "C:\Users\Public\Desktop\Adobe Reader 8.lnk"
del "C:\Program Files\K-Lite Codec Pack\Media Player Classic"
del "C:\Program Files (x86)\K-Lite Codec Pack\Media Player Classic"
del "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\K-Lite Codec Pack\Media Player Classic.lnk"
del "C:\Documents and Settings\All Users\Start Menu\Programs\K-Lite Codec Pack\Media Player Classic.lnk"
del "C:\Users\Owner\Desktop\Call of Duty 4 MultiPlayer.lnk"
del "C:\Users\Owner\Desktop\Call of Duty 4 SinglePlayer.lnk"
del "C:\Users\Owner\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Call of Duty 4 MultiPlayer.lnk"
del "C:\Users\Owner\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Call of Duty 4 SinglePlayer.lnk"
rmdir "c:\acr\Gaming Day!" /s /q
rmdir /s /q "C:\Users\Owner\Desktop\Call of Duty 4"
pause

exit