@echo off

set fecha=%date%
set hora=%time%

set commit=Fecha: %fecha% , hora: %hora%


git add -A --

git commit -m "Fecha: %fecha% , hora: %hora%"
pause