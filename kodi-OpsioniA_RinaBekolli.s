 .text
.globl main

main:

	li   $s0, 10       # Reg $s0 = test = 4

	move $a0, $s0
	jal func

	j exit

exit:
	li $v0, 10         # exit
	syscall

func:
	slti $t0, $a0, 1   # if(test< 1)
	beq $t0, $zero, L1 

	jr $ra


L1:
	addi $sp, $sp, -8
	sw   $ra, 0($sp)
	sw   $a0, 4($sp)

	move $s0, $a0

	# print test
	li   $v0, 1          # print_int syscall code = 1
	move $a0, $s0
	syscall

	# Print space " "
	li $v0, 4            # print_string syscall code = 4
	la $a0, space
	syscall

	move $a0, $s0
	addi $a0, $a0, -1    # test= test - 1

	jal func

L2:
	lw   $a0, 4($sp)      
	lw   $ra, 0($sp)      
	addi $sp, $sp, 8      # Reset stack pointer

	# print test
	li $v0, 1             # print_int syscall code = 1
	syscall

	# Print space " "
	li $v0, 4             # print_string syscall code = 4
	la $a0, space
	syscall

	# Return from function
	jr $ra                # Jump to address stored in $ra

.data
space: .asciiz " "
test:  .word 10