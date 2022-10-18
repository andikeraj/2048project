.text 
	.globl move_one
	
#
#	$a0 buffer address
#	$a1 buffer length
#
#	|----|----|----|----|----|		|----|----|----|----|----|	
#	|  2 |  0 |  2 |  0 |  4 |	=> 	|  2 |  2 |  0 |  4 |  0 |
#	|----|----|----|----|----|		|----|----|----|----|----|
#
#	$v0 1 iff something changed else 0
 
move_one:
	lw	$t0 ($a0)
	lh	$t1 ($t0)
	beqz	$a1 nothingmoved
	beqz	$t1 checkifnextnon0
	bgtz	$t1 checknext
	
checknext:
	addiu	$a0 $a0 4 
	addiu	$a1 $a1 -1
	beqz	$a1 nothingmoved
	lw	$t0 ($a0)
	lh	$t1 ($t0)
	beqz	$t1 checkifnextnon0
	bgtz	$t1 checknext
	
checkifnextnon0:
	addiu	$a0 $a0 4 
	addiu	$a1 $a1 -1
	beqz	$a1 nothingmoved
	lw	$t3 ($a0)
	lh	$t2 ($t3)
	beqz	$t2 checkifnextnon0
	bgtz	$t2 moveit
	
moveit:
	addiu	$a0 $a0 -4
	addiu	$a1 $a1 1
	lw	$t3 ($a0)
	sh	$t2 ($t3)
	addiu	$a0 $a0 4
	addiu	$a1 $a1 -1
	lw	$t0 ($a0)
	sh	$t1 ($t0)
	beqz	$a1 movehappened
	
checknextafmove:
	addiu	$a0 $a0 4
	addiu	$a1 $a1 -1
	beqz	$a1 movehappened
	lw	$t3 ($a0)
	lh	$t2 ($t3)
	beqz	$t2 checkifnextnon0afmove
	bgtz	$t2 moveit

checkifnextnon0afmove:
	addiu	$a0 $a0 4
	addiu	$a1 $a1 -1
	beqz	$a1 movehappened
	move	$t1 $t2
	lw	$t3 ($a0)
	lh 	$t2 ($t3)
	bgtz	$t2 moveit 
	beqz	$t2 checkifnextnon0afmove
	
nothingmoved:
	li $v0 0
	jr $ra
	
movehappened:
	li $v0 1
	jr $ra


	
