# Para saltarse el problema de CORS por parte del client-side.

Package.json

```json
"start": "ng serve --proxy-config proxy.conf.json"
```

Proxy.conf.json

```json
{
 "/api/*": {
 "target": "http://localhost:3000",
 "secure": false,
 "logLevel": "debug",
 "changeOrigin": true
 }
}
```
