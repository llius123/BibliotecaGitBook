# SVG en angular

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
