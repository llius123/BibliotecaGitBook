# Historial de rutas

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
