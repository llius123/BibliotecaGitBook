# Como abrir un formulario(como si se pulsara para cambiar de tab)

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
