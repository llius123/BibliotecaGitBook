# Doble data binding

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

# ngClass

Varias formas de hacer ngclass
[ngClass]="VARIABLE_BOOLEAN ? 'CLASE_CSS1' : 'CLASE_CSS2'"

# ngModelChange

https://stackoverflow.com/a/45075106
