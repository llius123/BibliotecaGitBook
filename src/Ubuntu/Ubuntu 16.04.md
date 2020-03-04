# Ubuntu 16.04

## Ver la memoria libre de la maquina

`Free -m`

## Ver los programas que se estan ejecutando, pararlos y apagarlos

`systemctl status`

## Para ver los servidores nodejs (pm2)

`pm2 list --> Listar los servidores nodejs`
`pm2 start | stop | restart`

## Tutorial bastante bueno

https://www.digitalocean.com/community/tutorials/how-to-install-linux-apache-mysql-php-lamp-stack-on-ubuntu-16-04#prerequisites

## Como conectarme

`ssh <usuario>@<ip>`

## Mysql

Problema:

Cuando se instala todo no es posible acceder a mysql desde remoto por lo tanto hay que editar la configuracion de mysql.

1. Dar acceso desde fuera tambien
   
   1. Sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf
   2. Cambiar bind-address = 127.0.0.1 por bind-address = 0.0.0.0
   3. Reiniciar mysql: systemctl restart mysql.service

2. Dar privilegios a los usuario exteriores para que puedan modificar cosas.
   
   1. Entramos en la consola de mysql: /usr/bin/mysql -u root -p
   
   2. Copiamois estas querys y las ejecutamos
      
      > ```sql
      > CREATE USER 'monty'@'localhost' IDENTIFIED BY 'some_pass';
      > GRANT ALL PRIVILEGES ON *.* TO 'monty'@'localhost' WITH GRANT OPTION;
      > CREATE USER 'monty'@'%' IDENTIFIED BY 'some_pass';
      > GRANT ALL PRIVILEGES ON *.* TO 'monty'@'%' WITH GRANT OPTION;
      > ```
   
   3. Creditos:
      
      https://stackoverflow.com/a/1559992
      https://www.techrepublic.com/article/how-to-set-up-mysql-for-remote-access-on-ubuntu-server-16-04/

3. Ahora con el usuario y la contraseña que hayamos usado para crear los usuarios del punto 2 podremos usar heidi o cualquier otro entorno para poder acceder a mysq.

## Tomcat

### Instalacion

Facil, seguir el tutorial
https://www.digitalocean.com/community/tutorials/how-to-install-apache-tomcat-8-on-ubuntu-16-04

### Reiniciar tomcat:

`sudo systemctl daemon-reload`
`sudo systemctl stop tomcat`
`sudo systemctl start tomcat`
`sudo systemctl status tomcat`

### Recordatorio:

> Si alguna vez se modifican archivos de configuracion tomcat y cuando se intenta acceder a 178.62.202.55:8080 y se queda la pantalla cargando y no da error pero tampoco carga lo que hay que hacer es eliminar este archivo: /etc/systemd/system/tomcat.service.
> 
> Si el back-end esta hecho en java, desplegar el back en el tomcat y el front en apache2.
> 
> Si el back esta hecho con nodejs usar pm2.

## Angular App

Angular App
Solamente hace falta hacer un gn build y si sale algun error solucionarlo.
Tambien esta el comando `ng build --prod`, se supone que este comando lo comprime mas
https://www.mokkapps.de/blog/how-to-build-an-angular-app-once-and-deploy-it-to-multiple-environments/

## Multiple webpages ubuntu

Tener varias paginas web en un mismo droplet
https://www.digitalocean.com/community/tutorials/how-to-set-up-apache-virtual-hosts-on-ubuntu-16-04
https://www.liquidweb.com/kb/configure-apache-virtual-hosts-ubuntu-18-04/

## Desplegar un servidor node en ubuntu

https://www.digitalocean.com/community/tutorials/how-to-set-up-a-node-js-application-for-production-on-ubuntu-16-04

## Mostrar errores

Cuando algo sale error, si se pone este comando te muestra los logs de lo que ha fallado, es bastante util
journalctl -xn

## Como configurar apache2 para desplegar la aplicación de angular y que al hacer el f5 no se rompa

https://github.com/mgechev/angular-seed/wiki/Deploying-prod-build-to-Apache-2

## Como configurar el apache2.conf para que cada vez que entre en el apache desde el navegador vaya directo a index.html y no se vea el contenido de www/

https://serverfault.com/a/771118
