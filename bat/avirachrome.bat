@echo off
color 4f
set virdir=C:\acr\

::Set Log Name
for /f "delims=" %%x in (%virvar%job.number.var) do set "job.number=%%x"
for /f "delims=" %%x in (%virvar%first.name.var) do set "first.name=%%x"
for /f "delims=" %%x in (%virvar%last.name.var) do set "last.name=%%x"
set logname=ACR%first.name%%last.name%%job.number%
set virlog="c:\acr\%logname%.txt"


start chrome.exe -incognito --new-window "https://docs.google.com/a/authorizedcomputers.com/document/d/1378viV9YGLQCwBp4UO0g_kg9fNEFzxg8v1E0lwqIwJA/edit?hl=en_US"
exit