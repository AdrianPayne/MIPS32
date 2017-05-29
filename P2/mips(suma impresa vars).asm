.data
str: .ascii "El resultado es: "
num1: .word 4
num2: .word 5
.text
main: 

#1.Leer dos números del usuario
lw $a1, num1($zero)
lw $a2, num2($zero)
#2. Realizar la suma
add $a3, $a1, $a2
#2.5 Añadir texto
la $a0, str
#3.Imprimir el resultado
li $v0, 4
syscall
move $a0, $a3
li $v0, 1
syscall
#4.Salir del programa
li $v0, 10
syscall