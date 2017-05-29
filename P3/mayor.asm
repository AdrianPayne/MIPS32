.text
#Leer dos números del usuario
li $v0, 5
syscall
move $a0, $v0
li $v0, 5
syscall
move $a1, $v0
#compara
bgt $a0, $a1, label
move $a0, $a1

label:
#Imprimir el resultado
li $v0, 1
syscall
