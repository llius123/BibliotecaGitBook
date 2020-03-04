# Webcomponent

Un tutorial muy completo es el [siguiente](https://enmilocalfunciona.io/crea-tu-primer-componente-con-angular-elements-en-6-pasos/)

> Con el tutorial anterior lo que se consigue es crear el webcomponent pero todos los assets anterior lo que se consigue es crear el webcomponent pero todos los assets no estarian incrustados dentro del …-elements.js asi que yo prefiero usar la configuracion descrita en este archivo.

Mi idea es cuando se crea un webcomponent que se genere un unico archivo: proyecto-elements.js

Con las siguientes pautas y configuraciones vamos a incrustar todo (fuentes, literales, iconos) en unico js.

Comando para construir un WebComponent:

`"build:elements": "ng build --output-hashing none && node build-elements.js"` 

Modificar el app.module y añadir lo siguiente:

```typescript
@NgModule({
        ...
    entryComponents: [CerHeaderElementComponent]
})
export class AppModule {
    constructor(private injector: Injector) {}
    ngDoBootstrap() {
    // using createCustomElement from angular package it will convert angular component to stander web component
        const el = createCustomElement(CerHeaderElementComponent, {
            injector: this.injector
        });
// using built in the browser to create your own custome element name
customElements.define("cer-header", el);
    }
}
```

Build-elements.js

```javascript
const fs = require('fs-extra');
const concat = require('concat');
(async function build() {
const files = [
'./dist/cer-footer-element/runtime.js',
'./dist/cer-footer-element/polyfills-es5.js',
'./dist/cer-footer-element/polyfills.js',
'./dist/cer-footer-element/styles.js',
'./dist/cer-footer-element/scripts.js',
'./dist/cer-footer-element/vendor.js',
'./dist/cer-footer-element/main.js'
];
await fs.ensureDir('elements');
await concat(files, 'elements/cer-footer-element.js');
})();
```

Se creara una carpeta llamada elements que contendra un Index.html y un cer-footer-element.js

```html
<html lang="en">
<head>
<meta charset="utf-8">
<title>CerFooterElement</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" type="image/x-icon" href="favicon.ico">
</head>
<body>
<cer-footer></cer-footer>
<script src="./cer-footer-element.js" ></script>
</body>
</html>
```

Para meter/escuchar eventos del WebComponent

```html
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>CerHeaderElement</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" type="image/x-icon" href="favicon.ico">
</head>
<body>
    Usuario loggeado/ sin loggear
    <div id="primerHeader">
        <cer-header></cer-header>
        <button id="primerHeaderBoton">Cambiar usuario</button>
    </div>
    Eventos de cambio de url
    <div id="segundoHeader">
        <cer-header></cer-header>
    </div>
    Cambio de idioma
    <div id="tercerHeader">
        <cer-header></cer-header>
    </div>
    Pasar datos de usuario al webcomponent
    <div id="cuartoHeader">
        <cer-header></cer-header>
    </div>
    Logout
    <div id="quintoHeader">
        <cer-header></cer-header>
    </div>

<script src="./cer-header-element.js" ></script>
<script>
window.onload = function() {
    /**
     * Cambiar el tipo de usuario de logeado a 
     * no logeado
     */
    var primerHeader = document.getElementById("primerHeader").querySelector("cer-header")
    var primerHeaderBoton = document.getElementById("primerHeaderBoton");
    var auxTipoUsuario = 0;
    primerHeader.setAttribute("logged", auxTipoUsuario);
    primerHeaderBoton.addEventListener("click", function () {
        if(auxTipoUsuario == 0){
            primerHeader.setAttribute("logged", 1);
            auxTipoUsuario = 1;
        }else{
            primerHeader.setAttribute("logged", 0);
            auxTipoUsuario = 0;
        }
        console.log("Tipo de usuario: " + auxTipoUsuario)
    })
    /**
     * Cambios de pestañas
    */
    var segundoHeader = document.getElementById("segundoHeader").querySelector("cer-header")
    segundoHeader.setAttribute("logged", 0);
    segundoHeader.addEventListener('url', e => {
        console.log("Url: " + e.detail);
    });
    /**
     * Cambio de idioma
     */
    var tercerHeader = document.getElementById("tercerHeader").querySelector("cer-header")
    tercerHeader.setAttribute("logged", 0);
    tercerHeader.addEventListener('idiomaSeleccionado', e => {
        console.log("Idioma seleccionado: " + e.detail);
    });
    /**
     * PAsandole datos de usuario al webcomponent
     **/
    var cuartoHeader = document.getElementById("cuartoHeader").querySelector("cer-header")
    cuartoHeader.setAttribute("usuario", "Usuario prueba");
    /**
     * Evento de logout
    **/
    var quintoHeader = document.getElementById("quintoHeader").querySelector("cer-header")
    quintoHeader.setAttribute("logged", 0);
    quintoHeader.addEventListener('logout', e => {
        console.log("Logout: " + e.detail);
    });
};
</script>
</body>
</html>
```

## Polyfills.ts

Para desarrollar el webcomponent levantando el servidor angular hay que tenerlo tal cual te lo genera el webcomponent, pero una vez el proyecto se quiera transformar en webcomponent hay que comentar todo lo que haya en polyfills.ts

## Esto no es seguro pero creo que tambien hay que hacerlo

1. Añadir estas librería:
   
   1. [npm i document-register-element](https://www.npmjs.com/package/document-register-element)
   
   2. [npm i ngx-build-plus](https://www.npmjs.com/package/ngx-build-plus)

2. Modificar el angular.json en estos lugares:
   
   1. ```json
      "build": {
      "builder": "ngx-build-plus:browser",
      ...
      "scripts": [
              {
              "input": "node_modules/document-register-element/build/document-register-element.js"
              }
          ]
      },
      ...
      }
      ```

## Para incrustar iconos en el webcomponent

```typescript
this.icono1 = require("!!url-loader?limit=10000!../../assets/logo.png");
```

> Seguramente haga falta instalar la siguiente librería
> 
> [npm install url-loader](https://www.npmjs.com/package/url-loader)

> Esto ultimo no creo que sea obligatorio al 100%, si no que en ese momento solo me funcionaria asi por X o Y.
> 
> Para pasar datos de la aplicación que contiene el webcomponent con el webcomponent hay que hacerlo asi:
> 
> ```typescript
>     @Input('idioma') public set idioma(data: string) {}
>     public get idioma(): string { return this._idioma; }
>     private _idioma: string;
>     <webcomponent idioma="español"</webcomponent>
> ```

> Se pone el Input de idioma de esta forma (@Input('idioma')) para poder pasarle los parametros de la siguiente forma idioma="español"

## Partes de codigo entero

### Package.json

```json
{
  "name": "cer-header-element",
  "version": "0.0.0",
  "scripts": {
    "ng": "ng",
    "start": "ng serve",
    "build": "ng build",
    "test": "ng test",
    "lint": "ng lint",
    "e2e": "ng e2e",
    "build:elements": "ng build --prod --single-bundle true --output-hashing none --vendor-chunk false && node build-elements.js"
  },
  "private": true,
  "dependencies": {
    "@angular/animations": "^8.0.3",
    "@angular/common": "~8.0.0",
    "@angular/compiler": "~8.0.0",
    "@angular/core": "~8.0.0",
    "@angular/elements": "^8.0.3",
    "@angular/forms": "~8.0.0",
    "@angular/platform-browser": "~8.0.0",
    "@angular/platform-browser-dynamic": "~8.0.0",
    "@angular/router": "~8.0.0",
    "@ngx-translate/core": "^11.0.1",
    "@ngx-translate/http-loader": "^4.0.0",
    "@webcomponents/custom-elements": "^1.2.4",
    "document-register-element": "^1.7.2",
    "ngx-build-plus": "^8.1.4",
    "rxjs": "~6.4.0",
    "tslib": "^1.9.0",
    "zone.js": "~0.9.1"
  },
  "devDependencies": {
    "@angular-devkit/build-angular": "~0.800.0",
    "@angular/cli": "~8.0.1",
    "@angular/compiler-cli": "~8.0.0",
    "@angular/language-service": "~8.0.0",
    "@types/jasmine": "~3.3.8",
    "@types/jasminewd2": "~2.0.3",
    "@types/node": "~8.9.4",
    "@webcomponents/webcomponentsjs": "^2.3.0",
    "codelyzer": "^5.0.0",
    "concat": "^1.0.3",
    "file-loader": "^4.2.0",
    "fs-extra": "^8.1.0",
    "jasmine-core": "~3.4.0",
    "jasmine-spec-reporter": "~4.2.1",
    "karma": "~4.1.0",
    "karma-chrome-launcher": "~2.2.0",
    "karma-coverage-istanbul-reporter": "~2.0.1",
    "karma-jasmine": "~2.0.1",
    "karma-jasmine-html-reporter": "^1.4.0",
    "protractor": "~5.4.0",
    "ts-node": "~7.0.0",
    "tslint": "~5.15.0",
    "typescript": "~3.4.3",
    "url-loader": "^2.1.0"
  }
}
```

### Build-elements.js

```typescript
const fs = require('fs-extra');
const concat = require('concat');
(async function build() {
const files = [
'./dist/cer-header-element/scripts.js',
'./dist/cer-header-element/main.js'
];
await fs.ensureDir('elements');
await concat(files, 'elements/cer-header-element.js');
})();
```

### Angular.json

```json
{
  "$schema": "./node_modules/@angular/cli/lib/config/schema.json",
  "version": 1,
  "newProjectRoot": "projects",
  "projects": {
    "cer-header-element": {
      "projectType": "application",
      "schematics": {},
      "root": "",
      "sourceRoot": "src",
      "prefix": "app",
      "architect": {
        "build": {
          "builder": "ngx-build-plus:browser",
          "options": {
            "outputPath": "dist/cer-header-element",
            "index": "src/index.html",
            "main": "src/main.ts",
            "polyfills": "src/polyfills.ts",
            "tsConfig": "tsconfig.app.json",
            "assets": [
              "src/favicon.ico",
              "src/assets"
            ],
            "styles": [
              "src/styles.css",
              "src/assets/OpensSansBold.scss",
              "src/assets/OpensSansLight.scss",
              "src/assets/OpensSansRegular.scss",
              "src/assets/OpensSansSemibold.scss"
            ],
            "scripts": [
              {
                "input": "node_modules/document-register-element/build/document-register-element.js"
              }
            ]
          },
          "configurations": {
            "production": {
              "fileReplacements": [
                {
                  "replace": "src/environments/environment.ts",
                  "with": "src/environments/environment.prod.ts"
                }
              ],
              "optimization": true,
              "outputHashing": "all",
              "sourceMap": false,
              "extractCss": true,
              "namedChunks": false,
              "aot": true,
              "extractLicenses": true,
              "vendorChunk": false,
              "buildOptimizer": true,
              "budgets": [
                {
                  "type": "initial",
                  "maximumWarning": "2mb",
                  "maximumError": "5mb"
                }
              ]
            }
          }
        },
        "serve": {
          "builder": "ngx-build-plus:dev-server",
          "options": {
            "browserTarget": "cer-header-element:build"
          },
          "configurations": {
            "production": {
              "browserTarget": "cer-header-element:build:production"
            }
          }
        },
        "extract-i18n": {
          "builder": "@angular-devkit/build-angular:extract-i18n",
          "options": {
            "browserTarget": "cer-header-element:build"
          }
        },
        "test": {
          "builder": "ngx-build-plus:karma",
          "options": {
            "main": "src/test.ts",
            "polyfills": "src/polyfills.ts",
            "tsConfig": "tsconfig.spec.json",
            "karmaConfig": "karma.conf.js",
            "assets": [
              "src/favicon.ico",
              "src/assets"
            ],
            "styles": [
              "src/styles.css"
            ],
            "scripts": []
          }
        },
        "lint": {
          "builder": "@angular-devkit/build-angular:tslint",
          "options": {
            "tsConfig": [
              "tsconfig.app.json",
              "tsconfig.spec.json",
              "e2e/tsconfig.json"
            ],
            "exclude": [
              "**/node_modules/**"
            ]
          }
        },
        "e2e": {
          "builder": "@angular-devkit/build-angular:protractor",
          "options": {
            "protractorConfig": "e2e/protractor.conf.js",
            "devServerTarget": "cer-header-element:serve"
          },
          "configurations": {
            "production": {
              "devServerTarget": "cer-header-element:serve:production"
            }
          }
        }
      }
    }
  },
  "defaultProject": "cer-header-element"
}
```

### App.module.ts

Si en nuestro webcomponent vamos a usar traducciones es muy importante generar y configurar el translate de la siguiente forma: 

Los literales tienen que estar en archivos ts como se puede ver a continuacion:

```javascript
export const translationCaEs = {
    header: {
        titulo1: "Titulo"
    }
};
```

Cuando los improtamos en el app.module tenemos la ventaja de que cuando hagamos la compilacion de codigo angularCli cojeras estos literales y los comprimira en el proyecto sin tener que configurar nada mas

```typescript

```
