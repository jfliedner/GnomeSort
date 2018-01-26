#
# Input the size of the array
# Allocate space for the array on the heap
# Input the numbers for the array, one per line
# Call the Gnome sorting function, which returns a sorted version of the input array
# The sort function should allocate a new array for its output, and not mutate the input array
# Output both the original and sorted array
# The arrays you print must be a squence of numbers on one line seperated by a single space
.globl main

.data 
input: .asciiz "Enter the size of the array: \n"
entries: .asciiz "Enter the elements of the array, one line at a time: \n"
output: .asciiz "Original array and then sorted array: \n"
space: .asciiz " "
newline: .asciiz "\n"   

.text
main:
	
	li $s4, 4
	
	la $a0, input
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $s0, $v0
	
	# allocate space for the array on the heap
	mul $s1, $s0, $s4
	li $v0, 9
	move $a0, $s1
	syscall
	move $s2, $v0
	
	li $s3, 0
	la $a0, entries
	li $v0, 4
	syscall
read_array:
	
	li $v0, 5
	syscall
	move $s5, $v0
	
	# placing in right spot in array ($sp + 4ii)
	mul $s1, $s3, $s4
	add $s1, $s2, $s1
	sw $s5, 0($s1)
	
	# increase counter
	addi $s3, $s3, 1
	
	# loop back if necessary
	blt $s3, $s0, read_array

	li $s3, 0
gnome_sort:
	mul $t1, $s0, $s4
	li $v0, 9
	move $a0, $t1
	syscall
	move $t2, $v0
	
	copy_array:
	mul $s1, $s3, $s4
	add $s1, $s2, $s1
	lw $t4, 0($s1)
	
	mul $t1, $s3, $s4
	add $t1, $t2, $t1
	lw $t5, 0($t1)
	sw $t4, 0($t1)
	
	addi $s3, $s3, 1
	blt $s3, $s0, copy_array
	
	li $s3, 0
	
	while:
	# if statement
	bge $s3, $s0, finish_gnome
	beq $s3, $zero, increment_i
	mul $t4, $s3, $s4
	add $t4, $t2, $t4
	lw $t6, 0($t4) # ys[ii]
	subi $t5, $t4, 4
	
	lw $t3, 0($t5) # ys[ii - 1]
	bge $t6, $t3, increment_i
	
	# outside of if
	sw $t3, 0($t4) 
	
	sw $t6, 0($t5)
	subi $s3, $s3, 1
	
	j while
	
	increment_i:
	addi $s3, $s3, 1
	j while
	
	finish_gnome:
	move $a0, $s2
	move $a1, $t2
	j print_array
	

print_array:
	move $s5, $a0
	li $s7, 0
	print_loop:
	mul $s1, $s7, 4
	add $s1, $s5, $s1
	
	lw $s6, 0($s1)
	
	move $a0, $s6
	li $v0, 1
	syscall
	
	la $a0, space
	li $v0, 4
	syscall
	
	addi $s7, $s7, 1
	blt $s7, $s0, print_loop
	
	la $a0, newline
	li $v0, 4
	syscall

print_sorted:
	move $s5, $a1
	li $s7, 0
	print_loop_sort:
	mul $s1, $s7, 4
	add $s1, $s5, $s1
	
	lw $s6, 0($s1)
	
	move $a0, $s6
	li $v0, 1
	syscall
	
	la $a0, space
	li $v0, 4
	syscall
	
	addi $s7, $s7, 1
	blt $s7, $s0, print_loop_sort																					
	
finish:
	li $v0, 10
	syscall
	
	lw $ra, 0($sp)
	lw $s0, 4($sp) # size of the array
	lw $s4, 8($sp) # the number 4
	lw $s1, 12($sp) # temporary register
	lw $s2, 16($sp) # the array (original)
	lw $s3, 20($sp) # counter
	lw $s5, 24($sp) # one element
	lw $t1, 28($sp) # second temp
	lw $t2, 32($sp) # copied array
	lw $t3, 36($sp) # saved word
	lw $t4, 40($sp)
	lw $t5, 44($sp)
	lw $t6, 48($sp)
	lw $t7, 52($sp)
	lw $s6, 56($sp)
	lw $s7, 60($sp)
	addi $sp, $sp, 64
			
	
																																																																																																																																	
	
					
          
