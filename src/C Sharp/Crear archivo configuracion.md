# Crear archivo de configuracion

Sacado de [aqui](https://stackoverflow.com/questions/10864755/adding-and-reading-from-a-config-file/10864790#10864790)

1. Añadir un archivo: Archivo de configuración de aplicaciones

2. Añadir las variables de configuracion que se quieran en este formato
   
   > ```xml
   >   <appSettings>
   >     <add key="keyname" value="value" />  
   >   </appSettings>
   > ```

3. Para llamar a las variables del archivo de configuracion:
   
   > ConfigurationManager.AppSettings["api_runaterra"]
