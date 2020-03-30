# Ionic V4+ apuntes

## Iniciar el servidor

`ionic cordova run android -l`
`ng run app:ionic-cordova-serve --host=0.0.0.0 --port=8100 --platform=android`

## Conectar el movil al pc

Abrir chrome y escribir lo siguiente
chrome://inspect/

https://coursetro.com/posts/code/83/Using-Ionic-Cordova's-Speech-Recognition-Plugin-(Tutorial)

## HttpClientModule

Como uso angular en ionic la forma de hacer peticiones http normalmente es a traves del HttpClientModule que tiene angular.
El problema que hay es que siempre salta el problema del CORS, aun habiendo configurado el back para que no salte este tipo de error.

La solucion que he usado es usar la librería que tiene ionic HTTP para hacer las peticiones rest.

En el app.module hay que añadir la librería como si fuera un modulo (en el apartado de modulos) porque si no dara un error de injeccion