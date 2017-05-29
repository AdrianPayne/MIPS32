.data
str: .ascii "Hellow world!\n"

.text
la $a0, str
#Imprime
li $v0, 4
syscall
#Salir del programa
li $v0, 10
syscall