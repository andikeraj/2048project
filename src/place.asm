.text
	.globl place
	
# 	$a0 board address + 18
# 	$a1 board length
#	$a2 field number to place into 9
#	$a3 number to place
#
#	$v0 == 0 iff place succesfull else 1
#

place_tile:
	sh	$a3 ($a0)
	li	$v0 0
	jr	$ra

	
place:	  
	
	mulu    $a2 $a2 2
	addu    $a0 $a0 $a2
	lhu 	$s0 ($a0)
	beq	$s0 0 place_tile
	b 	occupied
occupied:
	li	$v0 1
	jr	$ra
	