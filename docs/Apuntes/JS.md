# JavaScript apuntes

## Como restar 2 fechas

```javascript
Math.trunc((new Date(validateDate).getTime() - new Date(actionDate).getTime() ) /1000/60/60/24)
```

## Concatenar JS OBjects

```javascript
const target = { a: 1, b: 2 };
const source = { b: 4, c: 5 };

const returnedTarget = Object.assign(target, source);
```

