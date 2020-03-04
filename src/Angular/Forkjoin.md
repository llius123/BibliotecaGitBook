# Forkjoin

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


