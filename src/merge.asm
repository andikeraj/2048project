.text
	.globl merge

#
#	$a0 buffer address
#	$a1 buffer length
#
#	|----|----|----|----|		|----|----|----|----|
#	|  2 |  2 |  0 |  4 |  => 	|  4 |  0 |  0 |  4 |
#	|----|----|----|----|		|----|----|----|----|
#
#   BONUS: Return the number of merges in $v0 and the
#          total base score of the merges in $v1. 

merge:
	lw	$t0 ($a0)
	lh	$t1 ($t0)
	li	$v0 0 
	li	$v1 0
	bgtz	$t1 checknext
	beqz	$t1 checknextif0
	
checknext:
	addiu	$a0 $a0 4
	addiu	$a1 $a1 -1
	beqz	$a1 end
	lw	$t3 ($a0)
	lh	$t2 ($t3)
	beqz	$t2 checknextif0
	beq	$t2 $t1 mergethem
	bne	$t2 $t1 ifnotequal

ifnotequal:
	move	$t1 $t2
	lw	$t0 ($a0)
	sh	$t1 ($t0)
	li 	$t2 0
	b	checknext
	
checknextif0:
	addiu	$a0 $a0 4
	addiu	$a1 $a1 -1
	beqz	$a1 end
	lw	$t0 ($a0)
	lh	$t1 ($t0)
	beqz	$t1 checknextif0
	bgtz	$t1 checknext
	
mergethem:
	addiu	$a0 $a0 -4
	addiu	$a1 $a1 1
	addu	$t4 $t2 $t1
	addu	$v1 $v1 $t4 
	addu	$t2 $t2 $t1
	lw	$t3 ($a0)
	sh	$t2 ($t3)
	addiu	$v0 $v0 1
	addiu	$a0 $a0 4
	addiu	$a1 $a1 -1
	li	$t1 0
	lw	$t0 ($a0)
	sh	$t1 ($t0)
	beqz	$a1 end
	b	checknext

	
end:
    jr $ra
