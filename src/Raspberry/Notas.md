# Notas

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
