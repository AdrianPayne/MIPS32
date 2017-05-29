.data
str: .ascii "El resultado es: "
.text
main: 

#1.Leer dos números del usuario
li $v0, 5
syscall
move $a1, $v0
li $v0, 5
syscall
move $a2, $v0
#2. Realizar la suma
add $a3, $a1, $a2
#2.5 Añadir texto
la $a0, str
#3.Imprimir el resultado
li $v0, 4
syscall
move $a0, $a2
li $v0, 1
syscall
#4.Salir del programa
li $v0, 10
syscall