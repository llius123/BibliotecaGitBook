# Despliegue

Un tutorial como los 100 que hay en internet
https://coursetro.com/posts/code/112/Angular-5-Deployment---Deploy-your-Angular-App

Para compilar la aplicación de angular hay que hacer un ng build(ng build --prod), pero me salian algunos errores como los siguientes:

![](E:\Mark Text\marktext-user-data\images\2020-02-24-20-47-18-image.png)

Estos errores significa que cuando typescript esta transpilando y ademas esta el angular cli compilando, no encuentra estras variables definidas sobre todo en el html.
Esto significa que yo he definido **ngModel="searchName"** pero en el codigo typescript no la he definido **searchName: string**
Por lo tanto ahora toca ir definiendo en codigo typescript todas las variables que me salen en la captura de arriba.

Nota: En un futuro, si se desarrolla una aplicación web en angular hay que tener mucho cuidado con las variables que se crean y luego no se usan porque luego al intentar desplegar puede pasar estas cosas.

Otro error que no he acabado de entender el el siguiente:
Tengo una variable creada globalmente (**incidenciaResolver: IncidenciaInterface**) y angular me esta obligando a inicializarla 
(**incidenciaResolver: IncidenciaInterface = {id: null,vecino: { id: null, nombre: null, direccion: null,numero: null,nif: null,iban: null,comunidad: null,porcentaje_participacion: null,email: null,telefono: null,id_tipovecino: null,poblacion: null,login: null,pass: null},descripcion: null, fecha_creacion: null, atendido: null};**)

Una posible solucion seria añadir public delante de la variable(cosa que hay que ahcer siempre, leccion aprendida), pero aun asi este fallo sigue esatndo por lo que yo creo que es mas un fallo de codigo por dentro que de angular)

<u>Otro fallo</u>
He tenido que modificar el index.html que me ha generado el ng build ya que runtime.js,polyfills.js,styles.js etc.. No lo habia generado bien y he tenido que modificar los titulos de importacion a esto **/fincaV1-webapplication/runtime.js,/fincaV1-webapplication/polyfills.js,/fincaV1-webapplication/styles.js etc..** 

Otro mas:
En las rutas he tenido que cambiar el enrutamiento de /** , porque nada mas iniciar la aplicación se redirigia a esta ruta, y no habia forma de entrar en index.html 
