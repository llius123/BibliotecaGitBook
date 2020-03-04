# Deserializar la url
Cuando en una ruta de angular tienes caracteres especiales, angular por dentro esta serializando esta url.
../iOIC5IY5%2Fs2nQGfiwVjGKRH6Vw3rV5P6/..

Si en esta ruta de angular se hace F5 y se refresca la pagina, la url vuelve a cambiar ya que angular esta serializando esta url
../iOIC5IY5%252Fs2nQGfiwVjGKRH6Vw3rV5P6/…

Y si se vuelve a pulsar F5 vuelve a cambiar…
…/iOIC5IY5%25252Fs2nQGfiwVjGKRH6Vw3rV5P6/…

Como se puede ver la url a cada F5 esta siendo modificada

| No F5     | iOIC5IY5%2Fs2nQGfiwVjGKRH6Vw3rV5P6 |
|-----------|------------------------------------|
| Primer F5 | iOIC5IY5%252Fs2nQGfiwVjGKRH6Vw3rV5P6 |
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