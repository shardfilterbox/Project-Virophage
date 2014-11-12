@echo off
color 2f
set virdir=C:\acr\
for /f "delims=" %%x in (%virvar%job.number.var) do set "job.number=%%x"
set logname=ACR%job.number%Log
set virapp=%virdir%app\
set virbat=%virdir%bat\
set virzip=%virdir%zip\

wget -NP %virapp% "http://dl.dropbox.com/u/48424618/Virophagev100/app/7za.exe" --no-check-certificate

REM CHROME
wget -NP %virzip% "http://dl.dropbox.com/u/48424618/Virophagev100/zip/chrome.zip" --no-check-certificate
echo %virapp%7za.exe e %virzip%chrome.zip -o%virzip%chrome -y

REM APPS


REM BAT


wget -NP %virapp% "http://dl.dropbox.com/u/48424618/Virophagev100/app/tfc.exe" --no-check-certificate
wget -NP %virapp% "http://dl.dropbox.com/u/48424618/Virophagev100/app/mbam-setup.exe" --no-check-certificate
wget -NP %virapp% "http://dl.dropbox.com/u/48424618/Virophagev100/app/SAS.COM" --no-check-certificate
wget -NP %virapp% "http://dl.dropbox.com/u/48424618/Virophagev100/app/spybot.exe" --no-check-certificate
wget -NP %virapp% "http://dl.dropbox.com/u/48424618/Virophagev100/app/eset.exe" --no-check-certificate
wget -NP %virapp% "http://dl.dropbox.com/u/48424618/Virophagev100/app/hitmanpro32.exe" --no-check-certificate
wget -NP %virapp% "http://dl.dropbox.com/u/48424618/Virophagev100/app/HitmanPro64.exe" --no-check-certificate
wget -NP %virapp% "http://dl.dropbox.com/u/48424618/Virophagev100/app/TDSSKiller.exe" --no-check-certificate
wget -NP %virapp% "http://dl.dropbox.com/u/48424618/Virophagev100/app/autoruns.exe" --no-check-certificate
wget -NP %virapp% "http://dl.dropbox.com/u/48424618/Virophagev100/app/HijackThis.exe" --no-check-certificate
wget -NP %virapp% "http://dl.dropbox.com/u/48424618/Virophagev100/app/sfirstupdates.exe" --no-check-certificate
wget -NP %virapp% "http://dl.dropbox.com/u/48424618/Virophagev100/app/nfirstupdates.exe" --no-check-certificate
wget -NP %virapp% "http://dl.dropbox.com/u/48424618/Virophagev100/app/freshupdates.exe" --no-check-certificate
wget -NP %virbat% "http://dl.dropbox.com/u/48424618/Virophagev100/bat/avirachrome.bat" --no-check-certificate
wget -NP %virbat% "http://dl.dropbox.com/u/48424618/Virophagev100/bat/avirachrome.bat" --no-check-certificate
wget -NP %virbat% "http://dl.dropbox.com/u/48424618/Virophagev100/bat/avirachrome.bat" --no-check-certificate
wget -NP %virbat% "http://dl.dropbox.com/u/48424618/Virophagev100/bat/avirachrome.bat" --no-check-certificate
wget -NP %virbat% "http://dl.dropbox.com/u/48424618/Virophagev100/bat/avirachrome.bat" --no-check-certificate
wget -NP %virbat% "http://dl.dropbox.com/u/48424618/Virophagev100/bat/avirachrome.bat" --no-check-certificate
wget -NP %virbat% "http://dl.dropbox.com/u/48424618/Virophagev100/bat/beep.bat" --no-check-certificate
wget -NP %virbat% "http://dl.dropbox.com/u/48424618/Virophagev100/bat/bloatware.bat" --no-check-certificate
wget -NP %virbat% "http://dl.dropbox.com/u/48424618/Virophagev100/bat/cleanup.bat" --no-check-certificate
wget -NP %virbat% "http://dl.dropbox.com/u/48424618/Virophagev100/bat/mbamchrome.bat" --no-check-certificate
wget -NP %virbat% "http://dl.dropbox.com/u/48424618/Virophagev100/bat/virophage.bat" --no-check-certificate
wget -NP %virbat% "http://dl.dropbox.com/u/48424618/Virophagev100/bat/install.bat" --no-check-certificate


pause

exit