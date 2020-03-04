# Docs

## Instalacion desde cero

En base a este repositorio de github he conseguido añadir phaser.io a una aplicación angular.
https://github.com/kidthales/phaser-component-library

1. Paso 1
   
   Añadir phaser a traves de npm
   `Npm i phaser`
   
   > Esto en verdad no se porque hay que añadirlo si luego no lo añado en el angular.json pero bueno se añade por si las moscas.

2. Paso 2
   
   Descargarte este archivo y meterlo en src/
   https://raw.githubusercontent.com/photonstorm/phaser/master/types/phaser.d.ts

3. Paso 3
   Descargarte esta carpeta y meterla en el proyecto
   https://github.com/kidthales/phaser-component-library/tree/master/src/app/modules
   Añadir al app.module el import de ./modulesç
   
   ```typescript
   imports: [
    ...,
       PhaserModule
   ]
   ```

4. Paso 4
   Crear un servicio basico donde se inicialize phaser, el mundo, personajes etc…
   import { Injectable } from '@angular/core';
   
   ```typescript
   @Injectable()
   
   export class SceneService extends Phaser.Scene {
            /**
   
           Instantiate scene service
           */
           public constructor() {
               super({ key: 'Scene' });
           }
           /**
   
           Scene creation handler.
           */
           public create(): void {
               this.cameras.main.startFollow(this.add.text(0, 0, 'Hello World!'), false);
           }
   }
   ```

> Si escribes this. te saldran todas las clases heredadas de Phaser tal como se ve en la declaracion del Servicio (que esta heredado de Phaser.Scene)

5. Paso 5
   
       Añadir al componente que yo quiera phaser
       …componente.ts
   
   ```typescript
   import { Component } from '@angular/core';
   import { SceneService } from './scene.service';
   @Component({
   selector: 'app-root',
   templateUrl: './app.component.html',
   styleUrls: ['./app.component.scss'],
   providers: [SceneService]
   })
   export class AppComponent {
       /**
       * Game configuration.
       */
       public readonly config = {
           title: 'Phaser Component Library',
           version: '1.0.0',
           type: Phaser.AUTO,
           pixelArt: true,
           width: window.innerWidth,
           height: window.innerHeight
       };
       /**
       * Phaser API.
       */
       public readonly phaser = Phaser;
       /**
       * Instantiate application component.
       *
       * @param sceneService Scene service.
       */
       public constructor(public sceneService: SceneService) { }
       /**
       * On game ready event handler.
       *
       * @param game Game instance.
       */
       public onGameReady(game): void {
           game.scene.add('Scene', this.sceneService, true);
       }
   }
   ```
   
   ...component.html
   
   ```html
       <phaser-component 
           (gameReady)="onGameReady($event)"
           [gameConfig]="config"
           [Phaser]="phaser">
       </phaser-component>
   ```

6. Paso 6
   
   Añadir al final de polyfills.ts el import de phaser.
   
   ```typescript
   /** Phaser 3 **/
   require('phaser/dist/phaser');
   ```

7. Paso 7
   
   Añadir en tsconfig.json > compilerOptions > lib
   
   ```json
   "lib": [
   ...,
   "scripthost"
   ]
   ```

8. Paso 8
   
   Añadir en tsconfig.app.json > compilerOptions > lib
   
   ```json
   "types": ["node"]
   ```

## Otra opción es usa phaser a través de este webcomponent

https://github.com/proyecto26/ion-phaser

## Crear 8 bits imagenes

https://make8bitart.com/

## Tutoriales

https://github.com/kidthales/phaser-component-library

## Crear sprites

https://www.codeandweb.com/free-sprite-sheet-packer

https://www.leshylabs.com/apps/sstool/
