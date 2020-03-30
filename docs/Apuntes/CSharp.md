# C# apuntes

## Importar dll al proyecto

Como ejemplo se usara este repositorio [data](https://github.com/RiotGames/LoRDeckCodes)

1. Te vas al repositorio y te descargas el proyecto

2. Abrir con el Visual el proyecto descargado

3. Compilas la solucion

   > Se creara una carpeta bin dentro del proyecto

4. Ahora en nuestro proyecto le damos a Referencias (En la parte de la derecha)

5. Agregar referencias

6. Proyectos > Solucion

7. Seleccionamos el dll del proyecto que hemos compilado antes.

8. El dll que hemos compilado del proyecto anterior añadirlo en nuestro proyecto (Yo lo he metido en assets porque si)

## Como abrir un formulario(como si se pulsara para cambiar de tab)

```csharp
private void AbrirFormHijos(object formHijo){
//panelContenedor es el panel que se encargara de contener el nuevo formulario
 if(this.panelContenedor.Controls.Count > 0)
 {
 //Si hay algun otro form cargado en el panel se borra
 this.panelContenedor.Controls.RemoveAt(0);
 }
 Form fh = formHijo as Form;
 fh.TopLevel = false;
 fh.Dock = DockStyle.Fill;
 this.panelContenedor.Controls.Add(fh);
 this.panelContenedor.Tag = fh;
 fh.Show();
}
```

## Crear archivo de configuracion

Sacado de [aqui](https://stackoverflow.com/questions/10864755/adding-and-reading-from-a-config-file/10864790#10864790)

1. Añadir un archivo: Archivo de configuración de aplicaciones

2. Añadir las variables de configuracion que se quieran en este formato

   > ```xml
   > <appSettings>
   >  <add key="keyname" value="value" />  
   > </appSettings>
   > ```

3. Para llamar a las variables del archivo de configuracion:

   > ConfigurationManager.AppSettings["api_runaterra"]

