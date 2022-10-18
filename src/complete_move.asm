.text
	.globl complete_move
	

#
#	$a0 buffer address
#	$a1 buffer length
#
#	|----|----|----|----|		|----|----|----|----|
#	|  2 |  2 |  0 |  4 |  => 	|  4 |  4 |  0 |  0 |
#	|----|----|----|----|		|----|----|----|----|
#
#   BONUS: Return the number of merges in $v0 and the
#          total base score of the merges in $v1. 


complete_move:
	addiu	$sp $sp -12
	sw	$a0 0($sp)
	sw	$ra 4($sp)
	sw	$a1 8($sp)

movenmerge:
	jal	move_left
	lw	$a0 0($sp)
	lw	$a1 8($sp)
	lw	$ra 4($sp)
	addiu	$sp $sp 12
	addiu	$sp $sp -12
	sw	$a0 0($sp)
	sw	$ra 4($sp)
	sw	$a1 8($sp)
	jal	merge
	lw	$a0 0($sp)
	lw	$a1 8($sp)
	lw	$ra 4($sp)
	addiu	$sp $sp 12
	addiu	$sp $sp -12
	sw	$a0 0($sp)
	sw	$ra 4($sp)
	sw	$a1 8($sp)
	jal	move_left
	lw	$a0 0($sp)
	lw	$a1 8($sp)
	lw	$ra 4($sp)
	addiu	$sp $sp 12
	jr	$ra
