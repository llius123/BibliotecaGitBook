# Encapsulacion

Defino como quiero que funcione la encapsulación de los estilos del componente ([docs](https://angular.io/api/core/ViewEncapsulation))

En resumen, esta opción tiene 3 estados

enum ViewEncapsulation {
  Emulated: 0
  ~~Native: 1~~
  None: 2
  ShadowDom: 3
}

Por defecto angular está usando 'Emulated'.

Con None angular no encapsula los estilos y en resumidas cuentas estos estilos definidos en el componente se suben hasta los estilos globales y todos pueden usarlos.

> En CanalEmpresa hemos tenido que activar el None por una razón: El componente esta generando dinámicamente otro componente(componente externo 2, hecho con JQuery), que dependen de una petición REST.
> 
> El problema que hay es que angular esta cargando el contenido del componente antes de que el componente2 se haya cargado completamente y correctamente.
> El resultado es que los estilos del componente2 no se cargan correctamente y se rompe.
> 
> La solución a sido usar ViewEncapsulation.None para así, cuando el componente 2 cargue completamente y busque los estilos, angular al haberlos cargado globalmente, los encontrara y los usará.

Un tutorial en español y muy bueno es el siguiente: [medium](https://medium.com/@teffcode/c%C3%B3mo-encapsular-nuestros-estilos-de-css-en-angular-bc486be3005f)
