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
add $a0, $a1, $a2
#3.Imprimir el resultado
li $v0, 1
syscall
#4.Salir del programa
li $v0, 10
syscall