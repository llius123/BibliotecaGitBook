# Pipes

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
