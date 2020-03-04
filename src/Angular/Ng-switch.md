# Ng-switch

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


