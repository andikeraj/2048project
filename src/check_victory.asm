.text
	.globl check_victory


#
#	$a0 board address
#	$a1 board length
#
#	$v0 == 1 iff 2048 found
#

check_victory:
	lh	$t1 ($a0)
	beq	$t1 2048 victory
	b	checknext

checknext:
	addiu	$a0 $a0 2
	addiu   $a1 $a1 -1
	beqz	$a1 novictory
	lh	$t1 ($a0)
	beq	$t1 2048 victory
	b	checknext
	

victory:
	li	$v0 1
    	jr	$ra
    
novictory:
   	li	$v0 0 
   	jr	$ra
