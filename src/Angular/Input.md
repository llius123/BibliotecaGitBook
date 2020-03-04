# @Input()

Explicacion de cuando se ejecuta @Input() en un componente

> Input properties are populated before ngOnInit() is called. However, this assumes the parent property that feeds the input property is already populated when the child component is created.
> 
> In your scenario, this is not the case – the images data is being populated asynchronously from a service (hence an http request). Therefore, the input property will not be populated when ngOnInit() is called. 
> 
> To solve your problem, when the data is returned from the server, assign a new array to the parent property. Implement ngOnChanges() in the child. ngOnChanges() will be called when Angular change detection propagates the new array value down to the child.

[source](https://stackoverflow.com/questions/38020950/angular-in-which-lifecycle-hook-is-input-data-available-to-the-component/38021985#38021985)

En resumidas cuentas el @Input siempre se ejecuta antes del ngOnInit() asi que por asi decirlo siempre se ejecutara 2 veces, asi que hay que controlar esto.

Por otro lado tambien habla sobre ngOnChanges() que se supone que es un metodo que se ejecuta cuando se detectan cambios (entiendo que detectara cuando haya cambios en el Input)
