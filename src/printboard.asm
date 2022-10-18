
#
#a0 Address of the first field of the board
#
#	-----------------------------
#	|      |      |      |      |
#	| 2048 |  128 |    8 | 1024 |
#	|      |      |      |      |
#	-----------------------------
#	|      |      |      |      |
#	| 1024 |   64 |    4 |    8 |
#	|      |      |      |      |
#	-----------------------------
#	|      |      |      |      |
#	|  512 |   32 |  512 |  128 |
#	|      |      |      |      |
#	-----------------------------
#	|      |      |      |      |
#	|  256 |   16 | 2048 | 1024 |
#	|      |      |      |      |
#	-----------------------------
#

.data
border:
.asciiz "-----------------------------\n"
emptyspace:
.asciiz "|      |      |      |      |\n"

digitnum4:
.asciiz "| "
.align 2

digitnum3:
.asciiz "|  "
.align 2

digitnum2:
.asciiz "|   "
.align 2

digitnum1:
.asciiz "|    "
.align 2

leftborder:
.asciiz " " 

endborder:
.asciiz "|\n" 
	.globl printboard

.text

printboard:
	li	$t7 4
	move	$t0 $a0
bigloop:
	li	$t2 3
	la	$a0 border
	li	$v0 4
	syscall
	la	$a0 emptyspace
	li	$v0 4
	syscall
	
numcheck:
	lh	$t1 ($t0)
	addiu	$t2 $t2 -1
	bgt	$t1 999 dig4
	bgt	$t1 99 dig3
	bgt	$t1 9 dig2
	bge 	$t1 0 dig1
	
dig4:
	la	$a0 digitnum4
	li	$v0 4
	syscall
	la	$a0 ($t1)
	li	$v0 1
	syscall 
	la	$v0 leftborder
	li	$v0 4
	syscall 
	addiu	$t0 $t0 2
	beq	$t2 -1 rightborder
	bgez	$t2 numcheck

dig3:
	la	$a0 digitnum3
	li	$v0 4
	syscall
	la	$a0 ($t1)
	li	$v0 1
	syscall 
	la	$a0 leftborder
	li	$v0 4
	syscall
	addiu	$t0 $t0 2
	beq	$t2 -1 rightborder 
	bgez	$t2 numcheck

dig2:
	la	$a0 digitnum2
	li	$v0 4
	syscall
	la	$a0 ($t1)
	li	$v0 1
	syscall 
	la	$a0 leftborder
	li	$v0 4
	syscall 
	addiu	$t0 $t0 2
	beq	$t2 -1 rightborder
	bgez	$t2 numcheck

dig1:
	la	$a0 digitnum1
	li	$v0 4
	syscall
	la	$a0 ($t1)
	li	$v0 1
	syscall 
	la	$a0 leftborder
	li	$v0 4
	syscall 
	addiu	$t0 $t0 2
	beq	$t2 -1 rightborder
	bgez	$t2 numcheck
	
rightborder:
	la	$a0 endborder
	li 	$v0 4
	syscall
	
nextlines:
	addiu	$t7 $t7 -1
	la	$a0 emptyspace
	li	$v0 4
	syscall
	bgtz	$t7 bigloop
	la	$a0 border
	li	$v0 4
	syscall
	jr $ra
	 
	

	 
	
	

	
	

	
  
