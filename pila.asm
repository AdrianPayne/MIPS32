	.data
msg: .ascii "Introduce un numero: "
br: .ascii "\n"

main:	.text
	li $v0, 4
	la $a0, msg
	syscall
	
	li $v0, 5
	syscall
	
	move $a0, $v0
	move $a1, $zero
	
	jal create
	
	move $s0, $v0
	
loop:
	#PRINT
	move $a0, $s0
	jal print
	li $v0, 4
	la $a0, br
	syscall
	##############

	li $v0, 4
	la $a0, msg
	syscall
	
	li $v0, 5
	syscall
	
	move $a1, $v0
	beqz $a1, exit
	move $a0, $s0
	
	jal insert_in_order
	
	beqz $v0, loop
	move $s0, $v0
	
	b loop

exit:
	li $v0, 10
	syscall
	
create: #IN: val, P_next; OUT: P_me
	#PROTOCOL start
	subu $sp, $sp, 32
	sw $ra, 16($sp)
	sw $fp, 20($sp)
	addiu $fp, $sp, 24
	sw $a0, 0($fp)
	sw $a1, 4($fp)
	
	li $a0, 8
	li $v0, 9
	syscall
	
	lw $a0, 0($fp)
	lw $a1, 4($fp)
	
	sw $a0, 0($v0)
	sw $a1, 4($v0)
	
	#PROTOCOL end
	lw $ra, 16($sp)
	lw $fp, 20($sp)
	addiu $sp, $sp, 32
	jr $ra
	
insert_in_order: #IN: P_First, Val; OUT: P_First_b (0 if no changes)
	#PROTOCOL start
	subu $sp, $sp, 32
	sw $ra, 16($sp)
	sw $fp, 20($sp)
	addiu $fp, $sp, 24
	sw $a0, 0($fp)
	sw $a1, 4($fp)

	move $t2, $a0	####	$t2 = vector n | $a0 = vector n + 1
	lw $a0, 4($a0)
insert_in_order_loop:
	lw $t0, 0($t2)
	ble $t0, $a1, insert_first
	
	beqz $a0, insert_post
	lw $t0, 0($a0)
	ble $t0, $a1, insert_post
	
	move $t2, $a0
	lw $a0, 4($a0)
	b insert_in_order_loop
insert_first:
	lw $a0, 4($fp)
	lw $a1, 0($fp)
	jal create
	
	b insert_in_order_end

insert_post:
	move $a1, $a0
	lw $a0, 4($fp)
	sw $t2, 0($fp)
	
	jal create
	
	lw $t2, 0($fp)
	sw $v0, 4($t2)
	
	li $v0, 0
insert_in_order_end:
	#PROTOCOL end
	lw $ra, 16($sp)
	lw $fp, 20($sp)
	addiu $sp, $sp, 32
	jr $ra
	
print: #IN: P_First(or next), P_Last
	#PROTOCOL start
	subu $sp, $sp, 32
	sw $ra, 16($sp)
	sw $fp, 20($sp)
	addiu $fp, $sp, 24
	sw $a0, 0($fp)
	
	lw $a0, 4($a0)
	
	beqz $a0, print_end
	jal print
print_end:
	li $v0, 1
	lw $a0, 0($fp)
	lw $a0, 0($a0)
	syscall
	
	#PROTOCOL end
	lw $ra, 16($sp)
	lw $fp, 20($sp)
	addiu $sp, $sp, 32
	jr $ra