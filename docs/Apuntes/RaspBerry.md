# Raspberry apuntes

## Despelgar aplicaciones

https://surge.sh/

## Flamerobin & Firebird

## Problemas:

1. Cuando ejecutas el entorno grafico no se esta ejecutando en modo sudo, por lo tanto esta bastante limitado.

2. Todas las bases de datos/backups hay que darles permisos ya que si no ningun programa podra acceder a la base de datos ni podra modificar los datos.

   1. Sudo chmod 777 database.fdb.

3. Hay que buscar/configurar la base de datos para poder acceder desde fuera de la raspberry tal como ocurre con mysql (Firebird > 3.0 (Leer abajo))

## Instalar el flamerobin:

`sudo apt-get install flamerobin` 

## Instalar el Firebird

https://mapopa.blogspot.com/2012/11/debian-and-raspberry-pi-love-small-arm.html

1. Buscas que repositorios de firebird hay en la nube.

   1. `apt-cache search firebird`

2. A continuacion descargas el que quieras que te haya salido con la busqueda anterior (En este caso cojo la 2.5)

   1. `sudo apt-get install firebird2.5-super.`

3. Habilitas el servidor

   1. `sudo dpkg-reconfigure firebird2.5-super`

4. Revisas que se ha iniado correctamente

   1. `ps axu | grep firebird`

5. Para abrir la linea de comandos de firebird

   1. `isql-fb`

## Restaurar una base de datos

http://www.firebirdmanual.com/firebird/es/firebird-manual/2/gbak-backup-files/47 Usamos el siguiente comando

> `gbak -r o -v -user SYSDBA -password masterkey warehouse.fbk warehouse.fdb`

> ERROR:could not drop database gestion.fdb (database might be in use)
> https://stackoverflow.com/a/28415639

## Solucion al problema de que no se arranca el server

Solucion al siguiente problema:

> unable to start /opt/firebird/bin/fbguard (Exec format error)

Ejecutar el siguiente comando en la consola:
`sudo dpkg-reconfigure firebird3.0-server`

> (Firebird3.0-server porque es el server que yo he instalado actualamente)

## Shutdown error

Solcion al shutdown error:
`sudo gfix -user "SYSDBA" -password "masterkey"  -online gestion.fd`

## Firebird > 3.0

Modificar el archivo del servidor `firebird.conf`
AuthServer = Legacy_Auth
WireCrypt = Disabled

## Instalar Firebird 2.5 en ubuntu

Tutorial muy completo la verdad
https://help.ubuntu.com/community/Firebird2.5

## Microfono

Instalar un microfono en la raspberry y un software para que escuche y responda cosas ([aqui](https://rhasspy.readthedocs.io/en/latest/usage/))

## Notas

| usuario        | ubuntu              |                 |
| -------------- | ------------------- | --------------- |
| **contraseña** | **mellamojesus619** |                 |
| **Wifi**       | **192.168.1.131**   |                 |
| **Ethe**       | **192.168.1.134**   |                 |
| **Mysql**      | **jesus**           | **y55VDqj2LP%** |

## Iso ubuntu

https://ubuntu.com/download/raspberry-pi

## Wifi desactivado

1. Interfaz grafica para ver las redes wifi disponibles

   > [NetworkManager-tui](https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/Networking_Guide/sec-Networking_Config_Using_nmtui.html)
   > `Sudo apt install nmtui`

2. Activar el wifi, que seguramente no este activado

   > `sudo ifconfig wlan0 up`

## Tutoriales

Primer tutorial en español
https://www.prometec.net/indice-raspberry-pi/
http://www.circuitbasics.com/access-raspberry-pi-desktop-remote-connection/

Instalar jenkins 
https://raspberrytips.com/install-jenkins-raspberry-pi/

Instalar ubuntu server 
https://ubuntu.com/download/iot/raspberry-pi

