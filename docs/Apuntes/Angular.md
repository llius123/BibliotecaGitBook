# Angular 6+ apuntes

## Actualizar angular

Por ejemplo estamos en la version 8.0 y queremos actualizar a la 8.3
ng update @angular/cli@^8 @angular/core@^8

Para upgradear de la 8 a la 9 por ejemplo hay que hacer mas tareas

## Doble data binding

.model.ts

```typescript
export interface ResponseBack{
    code:number,
    msg:string
}
```

```typescript
public test: ResponseBack;
```

.html

```html
{{test.code}}
```

**Problema:**
Si la variable test no esta inicializada angular cuando carge el DOM(que lo carga antes de que venga la respuesta del back), saltara error: undefined ,ya que la variable test no esta inicializada y el DOM esta intentando acceder a una proipedad de una avriable que no esta definida.

Solucion:
.html

```html
{{test?.code}}
```

De esta forma angular esta diciendo al DOM que la intente cargar y si esta undefined que no pasa nada que continue normal

(Referencia)

## ngClass

Varias formas de hacer ngclass
[ngClass]="VARIABLE_BOOLEAN ? 'CLASE_CSS1' : 'CLASE_CSS2'"

## ngModelChange

https://stackoverflow.com/a/45075106

## Componente modal puro

### Service

```typescript
import { Injectable } from '@angular/core';
@Injectable({
    providedIn: 'root'
})
export class ModalService {
    private modals: any[] = [];
    private modalActiva: any;
    constructor() {}
    add(modal: any) {
        // add modal to array of active modals
        this.modals.push(modal);
    }
    remove(id: string) {
        // remove modal from array of active modals
        this.modals = this.modals.filter(x => x.id !== id);
    }
    open(id: string) {
        // open modal specified by id
        const modal: any = this.modals.filter(x => x.id === id)[0];
        this.modalActiva = modal;
        modal.open();
    }
    closeById(id: string) {
        // close modal specified by id
        const modal: any = this.modals.filter(x => x.id === id)[0];
        delete this.modalActiva;
        modal.close();
    }
    close() {
        this.closeById(this.modalActiva.id);
    }
}
```

### Component

```typescript
import { Component, ElementRef, Input, OnInit, OnDestroy } from '@angular/core';
import { ModalService } from './services/modal.service';

@Component({
    selector: 've-modal',
    template:
        `<div class="ve-modal">
            <div class="ve-modal-body">
                <button type="button" class="close" (click)="modalService.close()">
                <span aria-hidden="true">&times;</span>
               </button>
                <ng-content></ng-content>
                </div>
              </div>
        <div class="ve-modal-background"></div>`,
    styles: ['../inicio-tramite.component.scss']
})
export class ModalComponent implements OnInit, OnDestroy {
    @Input() id: string;
    private element: any;
    constructor(public modalService: ModalService, private el: ElementRef) {
        this.element = el.nativeElement;
    }
    ngOnInit(): void {
        const modal = this;
        // Nos aseguramos de que tenga un ID
        if (!this.id) {
            console.error('modal must have an id');
            return;
        }
        // Se mueve el elemento al final de la pagina (justo antes del cierre del body), para que pueda ser mostrado encima de todo
        document.body.appendChild(this.element);
        // Cierre de modal haciendo clock en cualquier parte del background
        this.element.addEventListener('click', (e: any) => {
            if (e.target.className === 've-modal') {
                modal.close();
            }
        });
        this.modalService.add(this);
    }
    ngOnDestroy(): void {
        this.modalService.remove(this.id);
        this.element.remove();
    }
    open(): void {
        this.element.style.display = 'block';
        document.body.classList.add('ve-modal-open');
    }
    close(): void {
        this.element.style.display = 'none';
        document.body.classList.remove('ve-modal-open');
    }
}
```

### Estilos

> Estilos (Estos estilos hay que añadirlos en el styles.scss (en los estilos padre de toda la aplicacion))
>
> ```scss
> // MODAL STYLE
> ve-modal {
>     /* modals are hidden by default */
>     display: none;
> }
> .ve-modal {
>      /* modal container fixed across whole screen */
>      position: fixed;
>      top: 0;
>      right: 0;
>      bottom: 0;
>      left: 0;
>      margin: auto;
>      /* z-index must be higher than .jw-modal-background */
>      z-index: 1000;
>      
>      /* enables scrolling for tall modals */
>      overflow: auto;
>      /* Border */
>      width: 100%;
> }
> .ve-modal .ve-modal-body {
>      margin: auto;
>      margin-top: 5em !important;
>      padding: 20px;
>      width: 60%;
>      background: $modalBotonBorde;
> }
> .ve-modal-body span {
>      font-size: 22px;
> }
> .ve-modal-background {
>      /* modal background fixed across whole screen */
>      position: fixed;
>      top: 0;
>      right: 0;
>      bottom: 0;
>      left: 0;
>      /* semi-transparent black */
>      background-color: #000;
>      opacity: 0.4;
>      
>      /* z-index must be below .jw-modal and above everything else */
>      z-index: 900;
> }
> body.ve-modal-open {
>     /* body overflow is hidden to hide main scrollbar when modal window is open */
>     overflow: hidden;
> }
> ```

## Curiosidades

### Pasar datos entre componentes.

En el componente 1 tengo esta variable inicializada de esta forma
TS

TS

```typescript
Public data: [] = []

Public data2: string = "";
```

HTML

```html
<componente [data2]="data2" [data]="data"></componente>   
```

En el componente 2 tengo este input
TS

```typescript
@Input() data: [];
@Input() data2: string;
```

Al ser un array se inicializa de una forma especial o algo asi porque cuando el componente 1 se carga el componente 2 detecta como que data le ha mandado datos y se pone a ejecutar los metodos afectados por el input de data.

Es muy curioso porque esto solo paso con la variable array, con la otra(string) no ocurre.

Esto se ha detectado gracias a un bug que ha ocurrido en nuestra aplicación por lo cual el componente 2 se ejecutaba una funcion al detectar datos del input data.

### importar un archivo json dentro de un archivo .ts

```json
{
"compilerOptions": {
"resolveJsonModule": true,
"esModuleInterop": true  
}
}
```

https://hackernoon.com/import-json-into-typescript-8d465beded79

## Deserializar la url

Cuando en una ruta de angular tienes caracteres especiales, angular por dentro esta serializando esta url.
../iOIC5IY5%2Fs2nQGfiwVjGKRH6Vw3rV5P6/..

Si en esta ruta de angular se hace F5 y se refresca la pagina, la url vuelve a cambiar ya que angular esta serializando esta url
../iOIC5IY5%252Fs2nQGfiwVjGKRH6Vw3rV5P6/…

Y si se vuelve a pulsar F5 vuelve a cambiar…
…/iOIC5IY5%25252Fs2nQGfiwVjGKRH6Vw3rV5P6/…

Como se puede ver la url a cada F5 esta siendo modificada

| No F5      | iOIC5IY5%2Fs2nQGfiwVjGKRH6Vw3rV5P6     |
| ---------- | -------------------------------------- |
| Primer F5  | iOIC5IY5%252Fs2nQGfiwVjGKRH6Vw3rV5P6   |
| Segundo F5 | iOIC5IY5%25252Fs2nQGfiwVjGKRH6Vw3rV5P6 |

La solucion que se ha encontrado es la que esta explicada en el siguiente [post](https://digitalflask.com/blog/extend-angular-router/)

La solucion que aplica es deserializar la url

```typescript
import { UrlSerializer, UrlTree, DefaultUrlSerializer } from '@angular/router';
export class CustomUrlSerializer implements UrlSerializer {
        parse(url: any): UrlTree {
                const dus = new DefaultUrlSerializer();
                return dus.parse(unescape(url));
        }
        serialize(tree: UrlTree): any {
                const dus = new DefaultUrlSerializer();
                return dus.serialize(tree);
        }
}
```

Y obviamente hay que modificar el app.module para aplicar esta clase custom UrlSerializer

```typescrip
import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { UrlSerializer } from '@angular/router';
import { AppComponent } from 'app/app.component';
import { CustomUrlSerializer } from './custom-url-serializer';
@NgModule({
	imports: [
		BrowserModule
	],
	declarations: [ AppComponent ],
	providers: [
		{ provide: UrlSerializer, useClass: CustomUrlSerializer }
	],
	bootstrap: [ AppComponent ]
})
export class AppModule { }
```

## Despliegue

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

## Download archivos

```javascript
this.tramiteDetalleService.getInfoTramite(this.caseCode,this.idDoc).subscribe(
            resp => {
                let blob = resp.body;
                let contentDisposition = resp.headers.get('content-disposition');
                let fileName = contentDisposition.split(';')[1].split('filename')[1].split('=')[1].replace(new RegExp("\"", 'g'),"").trim();
                if (navigator.appVersion.toString().indexOf('.NET') > 0) {
                    window.navigator.msSaveOrOpenBlob(blob, fileName);
                } else {
                    const element: HTMLAnchorElement = document.createElement('a');
                    element.href = window.URL.createObjectURL(blob);
                    element.download = fileName;
                    document.body.appendChild(element);
                    element.click();
                    document.body.removeChild(element);
                }
            }
        )
```

## Encapsulacion

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

## Forkjoin

Forkjoin sirve para juntar varios subscribers en uno solo.

```typescript
forkJoin(
    Subscriber1,
    Subscriber2
).subscribe(resp => {
            console.log(resp)
            respuestaSubscriber1 = resp[0];
            respuestaSubscriber2 = resp[1];
}, error => {
    //Si hay algun error el forkjoin no devuelve nada
})
```

## Get/Post/Update/Delete genericos

```typescript
/**
* Peticions tipus DELETE a GSIT
* @param urlRequest URL de la operació DELETE a realitzar
* @param extraParams Paràmetres opcionals adicionals per a la petició
* @param tipusResposta Resposta esperada, JSON per defecte. 'arraybuffer' | 'blob' | 'json' | 'text'
*/
public deleteGsitGateway(urlRequest: string, extraParams?: any, tipusResposta?: string): Observable<any> {
    const url = this.basePathGsitGateway + urlRequest;
    const requestOptions = this.setOpcions(true, extraParams, tipusResposta);
    return this.http.delete(url, requestOptions);
}
/**
* Peticions tipus GET al nostre BackEnd
* @param urlRequest URL de la operació GET a realitzar
* @param extraParams Paràmetres opcionals adicionals per a la petició
*/
public getRequest(urlRequest: string, extraParams?: any): Observable<any> {
    const url = this.basePath + urlRequest;
    const requestOptions = this.setOpcions(false, undefined, extraParams);
    return this.http.get(url, requestOptions);
}
/**
* Peticions tipus POST al nostre BackEnd
* @param urlRequest URL de la operació GET a realitzar
* @param body Body opcional per a la petició
* @param extraParams Paràmetres opcionals adicionals per a la petició
* @param tipusResposta Resposta esperada, JSON per defecte. 'arraybuffer' | 'blob' | 'json' | 'text'
*/
public postRequest(urlRequest: string, body?: any, extraParams?: any, tipusResposta?: string): Observable<any> {
    const url = this.basePath + urlRequest;
    const requestOptions = this.setOpcions(true, extraParams, tipusResposta);
    return this.http.post(url, body, requestOptions);
}
/**
* Genera les opcions amb els paràmetres necesaris per a realitzar les peticions HTTP
* @param post Boolean que indica si la petició serà de tipus POST
* @param extraParams Paràmetres opcionals adicionals per a la petició
* @param tipusResposta Resposta esperada, JSON per defecte. 'arraybuffer' | 'blob' | 'json' | 'text'
*/
private setOpcions(post: boolean, extraParams?: any, tipusResposta?: string) {
        let headers;
        if (this.translate.currentLang) {
            headers = new HttpHeaders().set('locale', this.translate.currentLang);
        } else {
            headers = new HttpHeaders().set('locale', 'ca_ES');
        }
       if (post) {
        headers.set('Content-Type', AppSettings.MEDIA_TYPE_APP_JSON);
       }
       let options;
       options = {
        headers: headers,
        withCredentials: this.configuration.withCredentials,
       };
       if (tipusResposta) {
        options.responseType = tipusResposta;
        if (tipusResposta === AppSettings.MEDIA_TYPE_BLOB) {
            options.observe = 'response';
        }
       }
       if (extraParams) {
        options = (Object as any).assign(options, extraParams);
       }
       return options;
}
```

## Historial de rutas

Este post describe como crear un servicio que almacene todas las rutas por las que has pasado.
Es muy interesante ya que en algun momento se puede necesitar saber de donde se viene para aplicar o no unos filtros o para redireccionar a un sitio o a otro siempre dependiendo de donde hayas venido

Primero sera crear el servicio que almacene todas las rutas por las que pasamos

```typescript
@Injectable()
export class RoutingState {
 private history = [];
 constructor(private router: Router) {}

public loadRouting(): void {
 this.router.events
 .pipe(filter(event => event instanceof NavigationEnd))
 .subscribe(({urlAfterRedirects}: NavigationEnd) => {
 this.history = [...this.history, urlAfterRedirects];
 });
 }
}
```

Despues hace falta inicializar en el app.module este servicio para que vaya guardando desde el principio las rutas por las que nos movemos.

```typescript
@Component(...)
export class AppComponent {
 constructor(routingState: RoutingState) {
 routingState.loadRouting();
 }
}
```

Para mejorar este servicio se pueden añadir metodos para obtener la lista de rutas/ etc…

```typescript
@Injectable()
export class RoutingState {
 private history = [];

constructor(private router: Router) {}
public loadRouting(): void {
 this.router.events
 .pipe(filter(event => event instanceof NavigationEnd))
 .subscribe(({urlAfterRedirects}: NavigationEnd) => {
 this.history = [...this.history, urlAfterRedirects];
 });
}
public getHistory(): string[] {
 return this.history;
}
public getPreviousUrl(): string {
 return this.history[this.history.length - 2] || '/index';
}
}
```

Copiado de este post de medium
https://blog.hackages.io/our-solution-to-get-a-previous-route-with-angular-5-601c16621cf0

## Hot module reload

https://codinglatte.com/posts/angular/enabling-hot-module-replacement-angular-6/

## @Input()

Explicacion de cuando se ejecuta @Input() en un componente

> Input properties are populated before ngOnInit() is called. However, this assumes the parent property that feeds the input property is already populated when the child component is created.
>
> In your scenario, this is not the case – the images data is being populated asynchronously from a service (hence an http request). Therefore, the input property will not be populated when ngOnInit() is called. 
>
> To solve your problem, when the data is returned from the server, assign a new array to the parent property. Implement ngOnChanges() in the child. ngOnChanges() will be called when Angular change detection propagates the new array value down to the child.

[source](https://stackoverflow.com/questions/38020950/angular-in-which-lifecycle-hook-is-input-data-available-to-the-component/38021985#38021985)

En resumidas cuentas el @Input siempre se ejecuta antes del ngOnInit() asi que por asi decirlo siempre se ejecutara 2 veces, asi que hay que controlar esto.

Por otro lado tambien habla sobre ngOnChanges() que se supone que es un metodo que se ejecuta cuando se detectan cambios (entiendo que detectara cuando haya cambios en el Input)

## Link que no parece link <a href>

Crear un link que sea un ng-click con la etiqueta href para que parezca un link pero que no redireccione.

```typescript
<a [routerLink]=""  (click)="volver()"><a>
```

## Linter para angular

http://codelyzer.com/

Es un linter especifico para angular 2+

## Ng-container

Muchas veces cuando estamos desarrollando nuestra app, tendemos a agrupar nuestro contenido en un tag html adicional

Ejemplo:

> ```html
> <section *ngIf="show">
> <div>
> <h2>Div one</h2>
> </div>
> 
> <div>
> <h2>Div two</h2>
> </div>
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

## Ng-switch

En vez de usar ngIf podemos usar ngSwitch y tendremos un codigo mas limpio y tendremos mas condiciones:

```html
<div [ngSwitch]="value">
  <span *ngSwitchCase="0">Text one</span>
  <span *ngSwitchCase="1">Text two</span>
</div>
```

En este caos podemos usar el ng-container y quedaria muchisimo mejor

```html
<div [ngSwitch]="value">
 <ng-container *ngSwitchCase="0">Text one</ng-container>
 <ng-container *ngSwitchCase="1">Text two</ng-container>
</div>
```

## Pipes

Hay un problema con las pipes y es que si necesito usar una pipe dentro de un componente que a su vez tiene su propio ngModule no la puedo importar de la forma normal (en declaration) ya que si esta misma pipe se necesita en otro lugar de la aplicación donde tambien usan su propio ngModule saltara un conflicto(la declaracion de la pipe esta duplicada)

La solucion es crear un ngModule exclusivo para las pipes, y asi puedes importar en todos los ngModules de los componentes que la necesiten sin problemas.

**Pipe.module.ts**

```typescript
import { NgModule } from '@angular/core';
import { EjemploPipe } from './ejemplo.pipe';

@NgModule({
    declarations: [
        EjemploPipe,
    ],
    exports: [
        EjemploPipe,
    ]
})
export class PipeModule { }
```

**Ejemplo.pipe.ts**

```tyescript
import { Pipe, PipeTransform } from '@angular/core';
@Pipe({
 name: 'ejemploPipe'
})
export class EjemploPipe implements PipeTransform {
 constructor() { }
 public transform(value: any): number {
 return value;
 }
}
```

## Se pueden concatenar pipes

Se pueden usar varias pipes juntas como aparece en el siguiente ejemplo.

```html
{{... | pipe1: 'EEEE' | pipe2: 'dd:MM:yyyy'}}
```

## Comprobar si la pagina es responsive

Las herramientas que he encontrado:
[xrespond](http://app.xrespond.com/) --> Pagina web donde tu metes tu url y te la carga en varias formatos
[ResponsiveViewer](https://addons.mozilla.org/en-US/firefox/addon/responsiveviewer/) --> Addon para chrome y para firefox que permite cargar la pagina web con varios tamaños
[responsive](http://mattkersley.com/responsive/) --> Igual que xrespond
[designmodo](https://designmodo.com/responsive-test/) --> Es otra pagiona web pero aquí tienes que ir cambiando tu a mano que tamaño quieres

## Para saltarse el problema de CORS por parte del client-side.

Package.json

```json
"start": "ng serve --proxy-config proxy.conf.json"
```

Proxy.conf.json

```json
{
 "/api/*": {
 "target": "http://localhost:3000",
 "secure": false,
 "logLevel": "debug",
 "changeOrigin": true
 }
}
```

## Scroll

Para hacer scroll hay varias opciones:

1. Hacer scroll de forma simple

   Para este caso usaremos `ViewChild`de angular

   ```
   @ViewChildren('documento') documentoViewchild: any;
   ...
   ngAfterViewInit(): void {
              this.documentoViewchild.last.nativeElement.scrollIntoView({ behavior: 'smooth'});
   }
   ```

> Se hace en el ngAfterViewInit ya que necesitamos que el DOM este inicializado ya que si no el ViewChild sera undefined y tendremos problemas.
>
> > Otro apunte curioso es que aun ejecutando esto dentro del ViewChild hay veces que sigue siendo undefined, por lo tanto lo que se hace es crear dentro del ngAfterViewInit un bucle que se ejecute como 5 veces (por ejemplo) con un `setTimeout()` para esperar a que realmente el elemento HTML se carge en el DOM.

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
> ```
> this.documentoViewchild._results[5].nativeElement.scrollIntoView({ behavior: 'smooth'});
> ```

> > Problema encontrado:
> >
> > Esta funcion al hacerlo dentro de un componente externo aparecia un problema.
> >
> > Cuando se ejecutaba el scroll por alguna razon no se quedaba el elemento al que se queria ahcer scroll en el medio de la pantalla.
> >
> > Yo creo que esto es porque al meter el componente que contenia el scroll dentro una aplicacion angular por alguna razon no se calculaba bien a que posicion X e Y tenia que ir y no se hacia bien el scroll.

1. Otra forma de hacer scroll.

   Esta forma es la solucion al problema que se genera usando la opcion 1 de scroll.

   ```
   const y = item.nativeElement.getBoundingClientRect().top + window.pageYOffset - window.innerHeight * 2 / 5;
   window.scrollTo({ top: y, behavior: 'smooth' });
   ```

> Lo que se esta haciendo aqui es calcular a mano el alto y ancho de todo el contenido del navegador para saber exactemente que hay encima y abajo del componente que contiene el scroll

## SVG en angular

1. Tienes el SVG en un json

2. Lo importas el json en el componente

3. Haces bypass del string del json

```typescript
public todoSvgIcon: SafeHtml;

private sanitizer: DomSanitizer

this.todoSvgIcon = this.sanitizer.bypassSecurityTrustHtml(svg.todo_icon.icon);
```

```html
<div [innerHTML]="todoSvgIcon" ></div>
```

## Webcomponent

Un tutorial muy completo es el [siguiente](https://enmilocalfunciona.io/crea-tu-primer-componente-con-angular-elements-en-6-pasos/)

> Con el tutorial anterior lo que se consigue es crear el webcomponent pero todos los assets anterior lo que se consigue es crear el webcomponent pero todos los assets no estarian incrustados dentro del …-elements.js asi que yo prefiero usar la configuracion descrita en este archivo.

Mi idea es cuando se crea un webcomponent que se genere un unico archivo: proyecto-elements.js

Con las siguientes pautas y configuraciones vamos a incrustar todo (fuentes, literales, iconos) en unico js.

Comando para construir un WebComponent:

`"build:elements": "ng build --output-hashing none && node build-elements.js"` 

Modificar el app.module y añadir lo siguiente:

```typescript
@NgModule({
        ...
    entryComponents: [CerHeaderElementComponent]
})
export class AppModule {
    constructor(private injector: Injector) {}
    ngDoBootstrap() {
    // using createCustomElement from angular package it will convert angular component to stander web component
        const el = createCustomElement(CerHeaderElementComponent, {
            injector: this.injector
        });
// using built in the browser to create your own custome element name
customElements.define("cer-header", el);
    }
}
```

Build-elements.js

```javascript
const fs = require('fs-extra');
const concat = require('concat');
(async function build() {
const files = [
'./dist/cer-footer-element/runtime.js',
'./dist/cer-footer-element/polyfills-es5.js',
'./dist/cer-footer-element/polyfills.js',
'./dist/cer-footer-element/styles.js',
'./dist/cer-footer-element/scripts.js',
'./dist/cer-footer-element/vendor.js',
'./dist/cer-footer-element/main.js'
];
await fs.ensureDir('elements');
await concat(files, 'elements/cer-footer-element.js');
})();
```

Se creara una carpeta llamada elements que contendra un Index.html y un cer-footer-element.js

```html
<html lang="en">
<head>
<meta charset="utf-8">
<title>CerFooterElement</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" type="image/x-icon" href="favicon.ico">
</head>
<body>
<cer-footer></cer-footer>
<script src="./cer-footer-element.js" ></script>
</body>
</html>
```

Para meter/escuchar eventos del WebComponent

```html
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>CerHeaderElement</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" type="image/x-icon" href="favicon.ico">
</head>
<body>
    Usuario loggeado/ sin loggear
    <div id="primerHeader">
        <cer-header></cer-header>
        <button id="primerHeaderBoton">Cambiar usuario</button>
    </div>
    Eventos de cambio de url
    <div id="segundoHeader">
        <cer-header></cer-header>
    </div>
    Cambio de idioma
    <div id="tercerHeader">
        <cer-header></cer-header>
    </div>
    Pasar datos de usuario al webcomponent
    <div id="cuartoHeader">
        <cer-header></cer-header>
    </div>
    Logout
    <div id="quintoHeader">
        <cer-header></cer-header>
    </div>

<script src="./cer-header-element.js" ></script>
<script>
window.onload = function() {
    /**
     * Cambiar el tipo de usuario de logeado a 
     * no logeado
     */
    var primerHeader = document.getElementById("primerHeader").querySelector("cer-header")
    var primerHeaderBoton = document.getElementById("primerHeaderBoton");
    var auxTipoUsuario = 0;
    primerHeader.setAttribute("logged", auxTipoUsuario);
    primerHeaderBoton.addEventListener("click", function () {
        if(auxTipoUsuario == 0){
            primerHeader.setAttribute("logged", 1);
            auxTipoUsuario = 1;
        }else{
            primerHeader.setAttribute("logged", 0);
            auxTipoUsuario = 0;
        }
        console.log("Tipo de usuario: " + auxTipoUsuario)
    })
    /**
     * Cambios de pestañas
    */
    var segundoHeader = document.getElementById("segundoHeader").querySelector("cer-header")
    segundoHeader.setAttribute("logged", 0);
    segundoHeader.addEventListener('url', e => {
        console.log("Url: " + e.detail);
    });
    /**
     * Cambio de idioma
     */
    var tercerHeader = document.getElementById("tercerHeader").querySelector("cer-header")
    tercerHeader.setAttribute("logged", 0);
    tercerHeader.addEventListener('idiomaSeleccionado', e => {
        console.log("Idioma seleccionado: " + e.detail);
    });
    /**
     * PAsandole datos de usuario al webcomponent
     **/
    var cuartoHeader = document.getElementById("cuartoHeader").querySelector("cer-header")
    cuartoHeader.setAttribute("usuario", "Usuario prueba");
    /**
     * Evento de logout
    **/
    var quintoHeader = document.getElementById("quintoHeader").querySelector("cer-header")
    quintoHeader.setAttribute("logged", 0);
    quintoHeader.addEventListener('logout', e => {
        console.log("Logout: " + e.detail);
    });
};
</script>
</body>
</html>
```

### Polyfills.ts

Para desarrollar el webcomponent levantando el servidor angular hay que tenerlo tal cual te lo genera el webcomponent, pero una vez el proyecto se quiera transformar en webcomponent hay que comentar todo lo que haya en polyfills.ts

### Esto no es seguro pero creo que tambien hay que hacerlo

1. Añadir estas librería:

   1. [npm i document-register-element](https://www.npmjs.com/package/document-register-element)

   2. [npm i ngx-build-plus](https://www.npmjs.com/package/ngx-build-plus)

2. Modificar el angular.json en estos lugares:

   1. ```json
      "build": {
      "builder": "ngx-build-plus:browser",
      ...
      "scripts": [
              {
              "input": "node_modules/document-register-element/build/document-register-element.js"
              }
          ]
      },
      ...
      }
      ```

### Para incrustar iconos en el webcomponent

```typescript
this.icono1 = require("!!url-loader?limit=10000!../../assets/logo.png");
```

> Seguramente haga falta instalar la siguiente librería
>
> [npm install url-loader](https://www.npmjs.com/package/url-loader)

> Esto ultimo no creo que sea obligatorio al 100%, si no que en ese momento solo me funcionaria asi por X o Y.
>
> Para pasar datos de la aplicación que contiene el webcomponent con el webcomponent hay que hacerlo asi:
>
> ```typescript
>  @Input('idioma') public set idioma(data: string) {}
>  public get idioma(): string { return this._idioma; }
>  private _idioma: string;
>  <webcomponent idioma="español"</webcomponent>
> ```

> Se pone el Input de idioma de esta forma (@Input('idioma')) para poder pasarle los parametros de la siguiente forma idioma="español"

### Partes de codigo entero

#### Package.json

```json
{
  "name": "cer-header-element",
  "version": "0.0.0",
  "scripts": {
    "ng": "ng",
    "start": "ng serve",
    "build": "ng build",
    "test": "ng test",
    "lint": "ng lint",
    "e2e": "ng e2e",
    "build:elements": "ng build --prod --single-bundle true --output-hashing none --vendor-chunk false && node build-elements.js"
  },
  "private": true,
  "dependencies": {
    "@angular/animations": "^8.0.3",
    "@angular/common": "~8.0.0",
    "@angular/compiler": "~8.0.0",
    "@angular/core": "~8.0.0",
    "@angular/elements": "^8.0.3",
    "@angular/forms": "~8.0.0",
    "@angular/platform-browser": "~8.0.0",
    "@angular/platform-browser-dynamic": "~8.0.0",
    "@angular/router": "~8.0.0",
    "@ngx-translate/core": "^11.0.1",
    "@ngx-translate/http-loader": "^4.0.0",
    "@webcomponents/custom-elements": "^1.2.4",
    "document-register-element": "^1.7.2",
    "ngx-build-plus": "^8.1.4",
    "rxjs": "~6.4.0",
    "tslib": "^1.9.0",
    "zone.js": "~0.9.1"
  },
  "devDependencies": {
    "@angular-devkit/build-angular": "~0.800.0",
    "@angular/cli": "~8.0.1",
    "@angular/compiler-cli": "~8.0.0",
    "@angular/language-service": "~8.0.0",
    "@types/jasmine": "~3.3.8",
    "@types/jasminewd2": "~2.0.3",
    "@types/node": "~8.9.4",
    "@webcomponents/webcomponentsjs": "^2.3.0",
    "codelyzer": "^5.0.0",
    "concat": "^1.0.3",
    "file-loader": "^4.2.0",
    "fs-extra": "^8.1.0",
    "jasmine-core": "~3.4.0",
    "jasmine-spec-reporter": "~4.2.1",
    "karma": "~4.1.0",
    "karma-chrome-launcher": "~2.2.0",
    "karma-coverage-istanbul-reporter": "~2.0.1",
    "karma-jasmine": "~2.0.1",
    "karma-jasmine-html-reporter": "^1.4.0",
    "protractor": "~5.4.0",
    "ts-node": "~7.0.0",
    "tslint": "~5.15.0",
    "typescript": "~3.4.3",
    "url-loader": "^2.1.0"
  }
}
```

#### Build-elements.js

```typescript
const fs = require('fs-extra');
const concat = require('concat');
(async function build() {
const files = [
'./dist/cer-header-element/scripts.js',
'./dist/cer-header-element/main.js'
];
await fs.ensureDir('elements');
await concat(files, 'elements/cer-header-element.js');
})();
```

#### Angular.json

```json
{
  "$schema": "./node_modules/@angular/cli/lib/config/schema.json",
  "version": 1,
  "newProjectRoot": "projects",
  "projects": {
    "cer-header-element": {
      "projectType": "application",
      "schematics": {},
      "root": "",
      "sourceRoot": "src",
      "prefix": "app",
      "architect": {
        "build": {
          "builder": "ngx-build-plus:browser",
          "options": {
            "outputPath": "dist/cer-header-element",
            "index": "src/index.html",
            "main": "src/main.ts",
            "polyfills": "src/polyfills.ts",
            "tsConfig": "tsconfig.app.json",
            "assets": [
              "src/favicon.ico",
              "src/assets"
            ],
            "styles": [
              "src/styles.css",
              "src/assets/OpensSansBold.scss",
              "src/assets/OpensSansLight.scss",
              "src/assets/OpensSansRegular.scss",
              "src/assets/OpensSansSemibold.scss"
            ],
            "scripts": [
              {
                "input": "node_modules/document-register-element/build/document-register-element.js"
              }
            ]
          },
          "configurations": {
            "production": {
              "fileReplacements": [
                {
                  "replace": "src/environments/environment.ts",
                  "with": "src/environments/environment.prod.ts"
                }
              ],
              "optimization": true,
              "outputHashing": "all",
              "sourceMap": false,
              "extractCss": true,
              "namedChunks": false,
              "aot": true,
              "extractLicenses": true,
              "vendorChunk": false,
              "buildOptimizer": true,
              "budgets": [
                {
                  "type": "initial",
                  "maximumWarning": "2mb",
                  "maximumError": "5mb"
                }
              ]
            }
          }
        },
        "serve": {
          "builder": "ngx-build-plus:dev-server",
          "options": {
            "browserTarget": "cer-header-element:build"
          },
          "configurations": {
            "production": {
              "browserTarget": "cer-header-element:build:production"
            }
          }
        },
        "extract-i18n": {
          "builder": "@angular-devkit/build-angular:extract-i18n",
          "options": {
            "browserTarget": "cer-header-element:build"
          }
        },
        "test": {
          "builder": "ngx-build-plus:karma",
          "options": {
            "main": "src/test.ts",
            "polyfills": "src/polyfills.ts",
            "tsConfig": "tsconfig.spec.json",
            "karmaConfig": "karma.conf.js",
            "assets": [
              "src/favicon.ico",
              "src/assets"
            ],
            "styles": [
              "src/styles.css"
            ],
            "scripts": []
          }
        },
        "lint": {
          "builder": "@angular-devkit/build-angular:tslint",
          "options": {
            "tsConfig": [
              "tsconfig.app.json",
              "tsconfig.spec.json",
              "e2e/tsconfig.json"
            ],
            "exclude": [
              "**/node_modules/**"
            ]
          }
        },
        "e2e": {
          "builder": "@angular-devkit/build-angular:protractor",
          "options": {
            "protractorConfig": "e2e/protractor.conf.js",
            "devServerTarget": "cer-header-element:serve"
          },
          "configurations": {
            "production": {
              "devServerTarget": "cer-header-element:serve:production"
            }
          }
        }
      }
    }
  },
  "defaultProject": "cer-header-element"
}
```

#### App.module.ts

Si en nuestro webcomponent vamos a usar traducciones es muy importante generar y configurar el translate de la siguiente forma: 

Los literales tienen que estar en archivos ts como se puede ver a continuacion:

```javascript
export const translationCaEs = {
    header: {
        titulo1: "Titulo"
    }
};
```

Cuando los improtamos en el app.module tenemos la ventaja de que cuando hagamos la compilacion de codigo angularCli cojeras estos literales y los comprimira en el proyecto sin tener que configurar nada mas

```typescript

```