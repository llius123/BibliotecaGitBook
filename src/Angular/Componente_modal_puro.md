# Componente modal puro

## Service

```typescript
import { Injectable } from '@angular/core';
@Injectable({
    providedIn: 'root'
})
export class ModalService {
    private modals: any[] = [];
    private modalActiva: any;
    constructor() {}
    add(modal: any) {
        // add modal to array of active modals
        this.modals.push(modal);
    }
    remove(id: string) {
        // remove modal from array of active modals
        this.modals = this.modals.filter(x => x.id !== id);
    }
    open(id: string) {
        // open modal specified by id
        const modal: any = this.modals.filter(x => x.id === id)[0];
        this.modalActiva = modal;
        modal.open();
    }
    closeById(id: string) {
        // close modal specified by id
        const modal: any = this.modals.filter(x => x.id === id)[0];
        delete this.modalActiva;
        modal.close();
    }
    close() {
        this.closeById(this.modalActiva.id);
    }
}
```

## Component

```typescript
import { Component, ElementRef, Input, OnInit, OnDestroy } from '@angular/core';
import { ModalService } from './services/modal.service';

@Component({
    selector: 've-modal',
    template:
        `<div class="ve-modal">
            <div class="ve-modal-body">
                <button type="button" class="close" (click)="modalService.close()">
                <span aria-hidden="true">&times;</span>
               </button>
<ng-content></ng-content>
</div>
</div>
        <div class="ve-modal-background"></div>`,
    styles: ['../inicio-tramite.component.scss']
})
export class ModalComponent implements OnInit, OnDestroy {
    @Input() id: string;
    private element: any;
    constructor(public modalService: ModalService, private el: ElementRef) {
        this.element = el.nativeElement;
    }
    ngOnInit(): void {
        const modal = this;
        // Nos aseguramos de que tenga un ID
        if (!this.id) {
            console.error('modal must have an id');
            return;
        }
        // Se mueve el elemento al final de la pagina (justo antes del cierre del body), para que pueda ser mostrado encima de todo
        document.body.appendChild(this.element);
        // Cierre de modal haciendo clock en cualquier parte del background
        this.element.addEventListener('click', (e: any) => {
            if (e.target.className === 've-modal') {
                modal.close();
            }
        });
        this.modalService.add(this);
    }
    ngOnDestroy(): void {
        this.modalService.remove(this.id);
        this.element.remove();
    }
    open(): void {
        this.element.style.display = 'block';
        document.body.classList.add('ve-modal-open');
    }
    close(): void {
        this.element.style.display = 'none';
        document.body.classList.remove('ve-modal-open');
    }
}
```

## Estilos

> Estilos (Estos estilos hay que añadirlos en el styles.scss (en los estilos padre de toda la aplicacion))
> 
> ```scss
> // MODAL STYLE
> ve-modal {
>     /* modals are hidden by default */
>     display: none;
> }
> .ve-modal {
>      /* modal container fixed across whole screen */
>      position: fixed;
>      top: 0;
>      right: 0;
>      bottom: 0;
>      left: 0;
>      margin: auto;
>      /* z-index must be higher than .jw-modal-background */
>      z-index: 1000;
>      
>      /* enables scrolling for tall modals */
>      overflow: auto;
>      /* Border */
>      width: 100%;
> }
> .ve-modal .ve-modal-body {
>      margin: auto;
>      margin-top: 5em !important;
>      padding: 20px;
>      width: 60%;
>      background: $modalBotonBorde;
> }
> .ve-modal-body span {
>      font-size: 22px;
> }
> .ve-modal-background {
>      /* modal background fixed across whole screen */
>      position: fixed;
>      top: 0;
>      right: 0;
>      bottom: 0;
>      left: 0;
>      /* semi-transparent black */
>      background-color: #000;
>      opacity: 0.4;
>      
>      /* z-index must be below .jw-modal and above everything else */
>      z-index: 900;
> }
> body.ve-modal-open {
>     /* body overflow is hidden to hide main scrollbar when modal window is open */
>     overflow: hidden;
> }
> ```
