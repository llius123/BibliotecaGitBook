echo Construir el libro

mdbook build

set fecha=%date%
set hora=%time%

set commit=Fecha: %fecha% , hora: %hora%

echo Añadido archivos modificados
git add -A --

echo Añadido mensaje al commit
git commit -m "Fecha: %fecha% , hora: %hora%"

echo Push al github/master
git push github master

pause