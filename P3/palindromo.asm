.data
si: .ascii "Es un palindromo\n"
.space 4
no: .ascii "No es un palindromo\n"
str: .space 1024

.text
main:
	li $a1,1024
	la $a0, str
	li $v0, 8
	syscall
	la $t1,str
	la $t2, ($t1)

# Encontramos el ultimo caracter
	apuntar_final:
	lb $t3, ($t2)
	beq $t3, 10, palindromo 
	add $t2, $t2, 1
	b apuntar_final
palindromo:
sub $t2, $t2, 1
lb $t3, ($t1)
lb $t4, ($t2)
bne $t3, $t4, negativo
bge $t1, $t2, positivo
add $t1, $t1, 1
b palindromo

positivo:
la $a0, si
li $v0, 4
syscall
li $v0, 10
syscall

negativo:
la $a0, no
li $v0, 4
syscall