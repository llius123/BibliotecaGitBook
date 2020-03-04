# Get/Post/Update/Delete genericos

```typescript
/**
* Peticions tipus DELETE a GSIT
* @param urlRequest URL de la operació DELETE a realitzar
* @param extraParams Paràmetres opcionals adicionals per a la petició
* @param tipusResposta Resposta esperada, JSON per defecte. 'arraybuffer' | 'blob' | 'json' | 'text'
*/
public deleteGsitGateway(urlRequest: string, extraParams?: any, tipusResposta?: string): Observable<any> {
    const url = this.basePathGsitGateway + urlRequest;
    const requestOptions = this.setOpcions(true, extraParams, tipusResposta);
    return this.http.delete(url, requestOptions);
}
/**
* Peticions tipus GET al nostre BackEnd
* @param urlRequest URL de la operació GET a realitzar
* @param extraParams Paràmetres opcionals adicionals per a la petició
*/
public getRequest(urlRequest: string, extraParams?: any): Observable<any> {
    const url = this.basePath + urlRequest;
    const requestOptions = this.setOpcions(false, undefined, extraParams);
    return this.http.get(url, requestOptions);
}
/**
* Peticions tipus POST al nostre BackEnd
* @param urlRequest URL de la operació GET a realitzar
* @param body Body opcional per a la petició
* @param extraParams Paràmetres opcionals adicionals per a la petició
* @param tipusResposta Resposta esperada, JSON per defecte. 'arraybuffer' | 'blob' | 'json' | 'text'
*/
public postRequest(urlRequest: string, body?: any, extraParams?: any, tipusResposta?: string): Observable<any> {
    const url = this.basePath + urlRequest;
    const requestOptions = this.setOpcions(true, extraParams, tipusResposta);
    return this.http.post(url, body, requestOptions);
}
/**
* Genera les opcions amb els paràmetres necesaris per a realitzar les peticions HTTP
* @param post Boolean que indica si la petició serà de tipus POST
* @param extraParams Paràmetres opcionals adicionals per a la petició
* @param tipusResposta Resposta esperada, JSON per defecte. 'arraybuffer' | 'blob' | 'json' | 'text'
*/
private setOpcions(post: boolean, extraParams?: any, tipusResposta?: string) {
        let headers;
        if (this.translate.currentLang) {
            headers = new HttpHeaders().set('locale', this.translate.currentLang);
        } else {
            headers = new HttpHeaders().set('locale', 'ca_ES');
        }
       if (post) {
        headers.set('Content-Type', AppSettings.MEDIA_TYPE_APP_JSON);
       }
       let options;
       options = {
        headers: headers,
        withCredentials: this.configuration.withCredentials,
       };
       if (tipusResposta) {
        options.responseType = tipusResposta;
        if (tipusResposta === AppSettings.MEDIA_TYPE_BLOB) {
            options.observe = 'response';
        }
       }
       if (extraParams) {
        options = (Object as any).assign(options, extraParams);
       }
       return options;
}
```
