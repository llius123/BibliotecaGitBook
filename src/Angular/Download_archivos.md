# Download archivos

```javascript
this.tramiteDetalleService.getInfoTramite(this.caseCode,this.idDoc).subscribe(
            resp => {
                let blob = resp.body;
                let contentDisposition = resp.headers.get('content-disposition');
                let fileName = contentDisposition.split(';')[1].split('filename')[1].split('=')[1].replace(new RegExp("\"", 'g'),"").trim();
                if (navigator.appVersion.toString().indexOf('.NET') > 0) {
                    window.navigator.msSaveOrOpenBlob(blob, fileName);
                } else {
                    const element: HTMLAnchorElement = document.createElement('a');
                    element.href = window.URL.createObjectURL(blob);
                    element.download = fileName;
                    document.body.appendChild(element);
                    element.click();
                    document.body.removeChild(element);
                }
            }
        )
```
