# Ng-container

Muchas veces cuando estamos desarrollando nuestra app, tendemos a agrupar nuestro contenido en un tag html adicional

Ejemplo:

> ```html
> <section *ngIf="show">
>  <div>
>    <h2>Div one</h2>
>  </div>
>  
>  <div>
>    <h2>Div two</h2>
>  </div>
> </section>
> ```

En este ejemplo estamos forzados a usar un nuevo tag porque queremos usar un `ngIf` para los 2 divs.

Esto no es correcto por estas 2 razones:

1. Estamos añadiendo DOM innecesario.

2. Alomejor rompe los estilos.

Solucion:

> <ng-container> is a logical container that can be used to group nodes but is not rendered in the DOM tree as a node.
> 
> <ng-container> is rendered as an HTML comment.

```html
<ng-container *ngIf="show">

 <div>
   <h2>Div one</h2>
 </div>
 
  <div>
    <h2>Div two</h2>
  </div>
  
 </ng-container>
```


