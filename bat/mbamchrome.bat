@echo off
color 4f
set virdir=C:\acr\
for /f "delims=" %%x in (%virvar%job.number.var) do set "job.number=%%x"
set logname=ACR%job.number%Log
set virapp=%virdir%app\
set virbat=%virdir%bat\
echo %virlog%

start chrome.exe -incognito --new-window "https://docs.google.com/a/authorizedcomputers.com/document/d/1bAmB3Jc5RtyUL3bsgYGiNf6jqe5QKFZDin_ohmBxbBg/edit"
exit