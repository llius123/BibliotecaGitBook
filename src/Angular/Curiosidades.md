# Curiosidades

## Pasar datos entre componentes.

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

## importar un archivo json dentro de un archivo .ts

```json
{
"compilerOptions": {
"resolveJsonModule": true,
"esModuleInterop": true  
}
}
```

https://hackernoon.com/import-json-into-typescript-8d465beded79
