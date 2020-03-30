# ElectronJS apuntes

## Aplicacion con angular + electron + nodegit

Para ejecutar un script desde el electron

```javascript
const exec = require('child_process').exec;

function execute(command, callback) {
    exec(command, (error, stdout, stderr) => { 
        callback(stdout); 
    });
};

// call the function
execute('ping -c 4 0.0.0.0', (output) => {
    console.log(output);
});
```

https://tortoisegit.org/docs/tortoisegit/tgit-automation.html

