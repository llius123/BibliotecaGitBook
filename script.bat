@echo off

set fecha=%date%
set hora=%time%

set/p commit=Fecha: %fecha% , hora: %hora%

echo %commit%

git add -A --

git commit -am '%commit%'
pause