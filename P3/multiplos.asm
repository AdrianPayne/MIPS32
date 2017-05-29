.text
#Leer dos números del usuario
li $v0, 5
syscall
move $a1, $v0
li $v0, 5
syscall
move $a2, $v0
#compara
bgt $a2, $a1, label

label:
#Imprimir el resultado
move $a0, $a1
bucle:
li $v0, 1
syscall
	#incrementa
	add $a0, $a0, $a1
	bgt $a2, $a0, bucle

#salir
li $v0, 10
syscall
