# Gennymotion

Cosas necesarias para que funcione el ionic en gennymotion

1. Descargar [Gennymotion](https://www.genymotion.com/fun-zone/)

2. Descargar [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

> Cuando se instale, añadir todos los iconos porque si no se instalara pero no podras iniciarlo desde el buscador de windows

3. Descargar [AndroidStudio](https://developer.android.com/studio/) 
   
   > Cuando se instale, descargar los sdk que se necesiten(yo me descargue el ultimo que me dejaba Android 9.0)
   > Añadir a las path variables lo siguiente:
   > **(Explorador de archivos/Este equipo(Boton derecho)/Propiedades/Configuracion avanzada del sistema/Variables de entorno(Esta en opciones avanzadas, es un boton))**
   > ADB 
   > D:\sdk\platform-tools
   > 
   > ANDROID_SDK_ROOT
   > D:\sdk

4. Iniciar el gennymotion

5. Descargar una version de android superior a la 5.0 (Yo he cogido la ultima que hay 9.0)

6. Iniciar ese dispositivo

7. Lanzar este comando para preparar el proyecto (Que ya tiene que estar creado)
   
   > `ionic cordova prepare android`

8. Iniciar el dev server
   
   > `ionic cordova run android -l`
