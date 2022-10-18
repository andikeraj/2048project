.text
	.globl move_check
#
#	$a0 buffer address
#	$a1 buffer length
#
#   $v0 == 1 iff left move possible and would change something
#            else 0
#

move_check:
	lw	$t0 ($a0)
	lh	$t1 ($t0)
	beqz	$t1 checknextifnonzero
	bgtz	$t1 precheckequal
	
precheckequal:
	addiu	$a0 $a0 4
	addiu	$a1 $a1 -1
	beq	$a1 0 no_moves
	lw	$t0 ($a0)
	lh	$t2 ($t0)
	beq	$t1 $t2 move_available
	beqz	$t2 checknextifnonzero
	b	checkequal
	
checkequal:
	addiu	$a0 $a0 4 
	addiu	$a1 $a1 -1
	beq	$a1 0 no_moves
	move	$t1 $t2
	lw	$t0 ($a0)
	lh	$t2 ($t0)
	beq	$t1 $t2 move_available
	beq	$t2 0 checknextifnonzero
	b 	checkequal
	
	
checknextifnonzero:
	addiu	$a0 $a0 4
	addiu	$a1 $a1 -1
	beq	$a1 0 no_moves
	lw	$t0 ($a0)
	lh	$t1 ($t0)
	bgtz	$t1 move_available
	beqz	$t1 checknextifnonzero
	
move_available:
	li $v0 1
	jr $ra
	 
no_moves:
	li $v0 0
	jr $ra
	
