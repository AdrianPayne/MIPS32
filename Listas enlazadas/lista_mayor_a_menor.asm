.data
msg: .ascii "Inserta un numero loco: "
msg2: .ascii "Va bien la cosa"
.text
main:
#Entrada
	la $a0, msg
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	
primer_nodo:
	#inicializo
	move $a0, $v0
	move $a1, $zero
	beqz $a0, exit
	
jal create

	#P_first
	move $s0, $v0
bucle:
#Entrada
	la $a0, msg
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	
	move $a0, $s0 #1. P_First
	move $a1, $v0 #2. Valor
	
jal insert_in_order

	
create: #(valor, p_next) => p_new
	#CONVENIO: abrir pila
	subu $sp, $sp, 32
	sw $ra, 20($sp)
	sw $fp, 16($sp)
	addiu $fp, $sp, 24
	sw $a0, 0($fp)
	sw $a1, 4($fp)
	
	#Reservo memoria [4bytes por variable]
	li $a0, 8
	li $v0, 9
	syscall

	lw $a0, 0($fp)
	lw $a1, 4($fp)
	sw $a0, 0($v0)
	sw $a1, 4($v0)
	
	#CONVENIO: cerrar pila
	lw $ra, 20($sp)
	lw $fp, 16($sp)
	addiu $sp, $sp, 32

	jr $ra
insert_in_order: #(p_inicial, valor)
	#CONVENIO: Abrir pila
	subu $sp, $sp, 32
	sw $ra, 20($sp)
	sw $fp, 16($sp)
	addiu $fp, $sp, 24
	sw $a0, 0($fp)
	sw $a1, 4($fp)
	
	busqueda_buble:
	
exit:
	li $v0, 10
	syscall