.text
	.globl move_left
	
#
#	$a0 buffer address
#	$a1 buffer length
#
#	|----|----|----|----|		|----|----|----|----|	
#	|  0 |  2 |  0 |  4 |	=> 	|  2 |  4 |  0 |  0 |
#	|----|----|----|----|		|----|----|----|----|	
#
	
move_left:
	addiu	$sp $sp -12
	sw	$a0 0($sp)
	sw	$ra 4($sp)
	sw	$a1 8($sp)
repeatmove:
	jal	move_one
	lw	$a0 0($sp)
	lw	$a1 8($sp)
	beq	$v0 1 repeatmove
	lw	$ra 4($sp)
	addiu	$sp $sp 12
	jr	$ra
	



	

