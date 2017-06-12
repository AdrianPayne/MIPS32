#EMPEZADO A LAS 18:25 -> CREATE e INSERT acabados correctamente a las 19:35 (1h10m) PRINT acabado a las 19:42(1h 17m)
	.data
msg: .asciiz "Introduzca un numero: "
sep: .asciiz " | "
	.text
main:
	la $a0, msg
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	
	move $a0,$v0
	move $a1, $zero
	jal create
	
	move $s0, $v0
main_loop:
	la $a0, msg
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	
	beqz $v0, exit
	
	move $a1,$v0
	move $a0, $s0
	jal insert_in_order_reverse #From smallest to biggest
	
	beqz $v0, main_loop
	move $s0, $v0
	b main_loop
exit:
	move $a0, $s0
	jal print_all
	
	li $v0, 10
	syscall
	
create: #IN (a0 -> Val; a1 -> P_Next) | OUT (v0 -> P_Me)
	#PROTOCOL START
	subu $sp, $sp, 32
	sw $ra, 16($sp)
	sw $fp, 20($sp)
	addiu $fp, $sp, 24
	sw $a0, 0($fp)
	sw $a1, 4($fp)
	
	li $a0,8
	li $v0,9
	syscall
	
	lw $a0, 0($fp)
	sw $a0, 0($v0)
	sw $a1, 4($v0)
		
	#PROTOCOL END
	lw $ra, 16($sp)
	lw $fp, 20($sp)
	addiu $sp, $sp, 32
	jr $ra
	
insert_in_order_reverse: #IN (a0 -> P_First; a1 -> Val) | OUT (v0 -> P_First_b [0 if not changes])
	#PROTOCOL START
	subu $sp, $sp, 32
	sw $ra, 16($sp)
	sw $fp, 20($sp)
	addiu $fp, $sp, 24
	sw $a0, 0($fp)
	sw $a1, 4($fp)
	
	lw $t0, 0($a0)
	ble $a1, $t0, insert_first
	
insert_loop:
	lw $t2, 4($a0) 
	beqz $t2, insert_post
	
	lw $t0, 0($t2)
	ble $a1, $t0, insert_post
	
	lw $a0, 4($a0)
	sw $a0, 0($fp) #Stack changes
	
	b insert_loop
	
insert_post: #a0(stack) -> P_n; #t2 -> P_next

	lw $a0, 4($fp)
	move $a1, $t2
	jal create
	
	lw $a0, 0($fp)
	sw $v0, 4($a0)
	li $v0, 0
	b insert_exit
insert_first:
	lw $a0, 4($fp)
	lw $a1, 0($fp)
	jal create
	
insert_exit:
	#PROTOCOL END
	lw $ra, 16($sp)
	lw $fp, 20($sp)
	addiu $sp, $sp, 32
	jr $ra
	
print_all: #a0 -> P_first
	#PROTOCOL START
	subu $sp, $sp, 32
	sw $ra, 16($sp)
	sw $fp, 20($sp)
	addiu $fp, $sp, 24
	sw $a0, 0($fp)
	
	lw $a0, 4($a0)
	beqz $a0, print_exit
	jal print_all

print_exit:
	lw $a0, 0($fp)
	lw $a0, 0($a0)
	li $v0, 1
	syscall
	
	la $a0, sep
	li $v0, 4
	syscall
	
	#PROTOCOL END
	lw $ra, 16($sp)
	lw $fp, 20($sp)
	addiu $sp, $sp, 32
	jr $ra