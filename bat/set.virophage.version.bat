@echo off
color 4f
set Virophage.Source = %~dp0
xcopy "%Virophage.Source%bat\virophage.header.bat" "c:\acr\bat\" /dsiy
CALL c:\acr\bat\virophage.header.bat
set date.year=%date:~12%
set date.month=%date:~7,-5%
set date.day=%date:~4,-8%
set virophage.version=%date.year%.%date.month%.%date.day%
set source.dir=%~dp0
echo %virophage.version% | clip

:exit
exit