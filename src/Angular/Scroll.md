# Scroll

Para hacer scroll hay varias opciones:

1. Hacer scroll de forma simple
   
   Para este caso usaremos `ViewChild`de angular
   
   ```typescript
   @ViewChildren('documento') documentoViewchild: any;
   ...
   ngAfterViewInit(): void {
              this.documentoViewchild.last.nativeElement.scrollIntoView({ behavior: 'smooth'});
   }
   ```

> Se hace en el ngAfterViewInit ya que necesitamos que el DOM este inicializado ya que si no el ViewChild sera undefined y tendremos problemas.
> 
> >  Otro apunte curioso es que aun ejecutando esto dentro del ViewChild hay veces que sigue siendo undefined, por lo tanto lo que se hace es crear dentro del ngAfterViewInit un bucle que se ejecute como 5 veces (por ejemplo) con un `setTimeout()` para esperar a que realmente el elemento HTML se carge en el DOM.

> [ViewChildren angular](https://angular.io/api/core/ViewChildren) 
> 
> [medium](https://medium.com/better-programming/angular-viewchild-and-viewchildren-fde2d252b9ab)

> En este ejemplo estoy haciendo scroll al ultimo elemento del `documentoViewchild` .
> 
> Si se esta usando `ViewChildren` en un bloque `for` y queremos hacer scroll a un elemento que no es el primero y no es el ultimo.
> 
> `ViwChildren` nos proporciona un objeto que se llama `_results` (que es un array) donde estan contenidos todos los elementos HTML que tienen el tag del `ViewChildren` . 
> 
> Entonces el proceso es el mismo:
> 
> `this.documentoViewchild._results[5].nativeElement.scrollIntoView({ behavior: 'smooth'});`

> > <u>Problema encontrado:</u>
> > 
> > Esta funcion al hacerlo dentro de un componente externo aparecia un problema.
> > 
> > Cuando se ejecutaba el scroll por alguna razon no se quedaba el elemento al que se queria ahcer scroll en el medio de la pantalla.
> > 
> > Yo creo que esto es porque al meter el componente que contenia el scroll dentro una aplicacion angular por alguna razon no se calculaba bien a que posicion X e Y tenia que ir y no se hacia bien el scroll.

2. Otra forma de hacer scroll.
   
   Esta forma es la solucion al problema que se genera usando la opcion 1 de scroll.
   
   ```typescript
   const y = item.nativeElement.getBoundingClientRect().top + window.pageYOffset - window.innerHeight * 2 / 5;
   window.scrollTo({ top: y, behavior: 'smooth' });
   ```

> Lo que se esta haciendo aqui es calcular a mano el alto y ancho de todo el contenido del navegador para saber exactemente que hay encima y abajo del componente que contiene el scroll
