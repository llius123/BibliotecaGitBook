# Documentacion Kotlin

## Variables

Las variables en kotlin se pueden definir de la misma forma que en Java.
Hay varias diferencias con respesto a Java.

1. Al definir una variable y asignarle un valor en la misma linea no hace falta definirle el tipo
   `val nombre = "Jesus"`

2. Al definir una variable en una linea y despues rellenar la variable en la otra si que es OBLIGATORIO tipar esa variable.
   `val nombre: String`
   `nombre = "Jesus"`
   
   Val
   
   1. Definicion de variable que NO puede cambiar
   
   Var
   
   1. Definicion de variable que SI que puede cambiar
   
   ?
   
   1. Se puede definir los tipos de las variables asi val test: String? y esto significa que la varible test puede contener un string o un null

## Concatenar Strings

2 Formas:

1. "Jesus " + apellidos

2. "Jesus $apellidos"

## !! y  ?

Esto sirve para comprobar que la variable no es null
[+info](https://medium.com/@agrawalsuneet/safe-calls-vs-null-checks-in-kotlin-f7c56623ab30)
