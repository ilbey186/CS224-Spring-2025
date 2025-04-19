    .data
array:      .space 400          
max_size:   .word 100           
menu:       .asciiz "\nMenu:\n1. Find max\n2. Count max occurrences\n3. Compute average\n4. Compare with average\n5. Quit\nEnter your choice: "
prompt_n:   .asciiz "Enter number of elements (max 100): "
prompt_elem:.asciiz "Enter element: "
max_msg:    .asciiz "Maximum value: "
count_msg:  .asciiz "Occurrences of max: "
avg_msg:    .asciiz "Average: "
less_msg:   .asciiz " elements less than average: "
greater_msg:.asciiz " elements greater than average: "
newline:    .asciiz "\n"
error_msg:  .asciiz "Invalid choice! Try again.\n"

    .text

main:
    li $v0, 4
    la $a0, prompt_n
    syscall
    
    li $v0, 5  
    syscall
    move $s0, $v0  

    li $t0, 100
    bgt $s0, $t0, main  

    li $t1, 0  
read_loop:
    bge $t1, $s0, menu_loop  

    li $v0, 4
    la $a0, prompt_elem
    syscall

    li $v0, 5  
    syscall

    la $t2, array
    sll $t3, $t1, 2   
    add $t2, $t2, $t3
    sw $v0, 0($t2)    

    addi $t1, $t1, 1  
    j read_loop

menu_loop:
    li $v0, 4
    la $a0, menu
    syscall

    li $v0, 5
    syscall
    move $t0, $v0  

    beq $t0, 1, find_max
    beq $t0, 2, count_max
    beq $t0, 3, compute_avg
    beq $t0, 4, compare_avg
    beq $t0, 5, exit
    j menu_loop 

find_max:
    la $t1, array    
    lw $s2, 0($t1)     
    li $t3, 1         

find_max_loop:
    bge $t3, $s0, print_max  

    sll $t4, $t3, 2    
    add $t5, $t1, $t4 
    lw $t6, 0($t5)     

    bgt $t6, $s2, update_max
    j continue_max

update_max:
    move $s2, $t6 

continue_max:
    addi $t3, $t3, 1
    j find_max_loop

print_max:
    li $v0, 4
    la $a0, max_msg
    syscall

    li $v0, 1
    move $a0, $s2
    syscall

    j menu_loop

count_max:
    la $t1, array
    li $t3, 0  
    li $t4, 0 

count_loop:
    bge $t3, $s0, print_count  

    sll $t5, $t3, 2
    add $t6, $t1, $t5
    lw $t7, 0($t6)

    beq $t7, $s2, inc_count

    j continue_count

inc_count:
    addi $t4, $t4, 1 

continue_count:
    addi $t3, $t3, 1
    j count_loop

print_count:
    li $v0, 4
    la $a0, count_msg
    syscall

    li $v0, 1
    move $a0, $t4
    syscall

    j menu_loop

compute_avg:
    la $t1, array
    li $t3, 0  
    li $t4, 0  

sum_loop:
    bge $t3, $s0, compute_avg_done  

    sll $t5, $t3, 2
    add $t6, $t1, $t5
    lw $t7, 0($t6)

    add $t4, $t4, $t7  

    addi $t3, $t3, 1
    j sum_loop

compute_avg_done:
    div $t4, $s0  
    mflo $s1 

    li $v0, 4
    la $a0, avg_msg
    syscall

    li $v0, 1
    move $a0, $s1
    syscall

    j menu_loop

compare_avg:
    la $t1, array
    li $t3, 0  
    li $t4, 0 
    li $t5, 0  

compare_loop:
    bge $t3, $s0, print_compare  

    sll $t6, $t3, 2
    add $t7, $t1, $t6
    lw $t8, 0($t7)

    blt $t8, $s1, inc_less
    bgt $t8, $s1, inc_greater

    j continue_compare

inc_less:
    addi $t4, $t4, 1
    j continue_compare

inc_greater:
    addi $t5, $t5, 1

continue_compare:
    addi $t3, $t3, 1
    j compare_loop

print_compare:
    li $v0, 4
    la $a0, less_msg
    syscall

    li $v0, 1
    move $a0, $t4
    syscall

    li $v0, 4
    la $a0, greater_msg
    syscall

    li $v0, 1
    move $a0, $t5
    syscall

    j menu_loop

exit:
    li $v0, 10
    syscall

