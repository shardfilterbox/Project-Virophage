@echo off
color 4f
set virdir=C:\acr\
for /f "delims=" %%x in (%virvar%job.number.var) do set "job.number=%%x"
set logname=ACR%job.number%Log
echo %virlog%

start chrome.exe -incognito --new-window "https://docs.google.com/a/authorizedcomputers.com/document/d/1378viV9YGLQCwBp4UO0g_kg9fNEFzxg8v1E0lwqIwJA/edit?hl=en_US"
exit