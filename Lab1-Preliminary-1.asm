.data

array: .space 80  
msg_size: .asciiz "Enter the number of elements (max 20): "
msg_elem: .asciiz "Enter element: "
msg_before: .asciiz "Array before swap: "
msg_after: .asciiz "Array after swap: "
msg_space: .asciiz " "
msg_newline: .asciiz "\n"

.text

main:
   
    li $v0, 4
    la $a0, msg_size
    syscall
    
    li $v0, 5
    syscall
    move $t0, $v0   
    
    blez $t0, print_before  
    li $t1, 0       
    la $t2, array    

input_loop:
    
    li $v0, 4
    la $a0, msg_elem
    syscall
    
    li $v0, 5
    syscall
    sw $v0, 0($t2)  
    
    addi $t2, $t2, 4  
    addi $t1, $t1, 1  
    blt $t1, $t0, input_loop

print_before:
    
    li $v0, 4
    la $a0, msg_before
    syscall
    
    jal print_array

swap:
   
    la $t2, array    
    move $t3, $t0   
    subi $t3, $t3, 1 
    srl $t3, $t3, 1 
    li $t4, 0       

swap_loop:
    bge $t4, $t3, print_after  
    
   
    la $t5, array
    sll $t6, $t4, 2  
    add $t5, $t5, $t6
    lw $t7, 0($t5)   
    
    la $t8, array
    sll $t9, $t0, 2
    sub $t9, $t9, 4
    sub $t9, $t9, $t6  
    add $t8, $t8, $t9
    lw $s0, 0($t8) 
    
   
    sw $s0, 0($t5)
    sw $t7, 0($t8)
    
    addi $t4, $t4, 1  
    j swap_loop

print_after:
 
    li $v0, 4
    la $a0, msg_after
    syscall
    
    jal print_array

exit:
    li $v0, 10
    syscall

print_array:
    li $t1, 0        
    la $t2, array   

print_loop:
    bge $t1, $t0, end_print
    
    lw $a0, 0($t2)
    li $v0, 1
    syscall
    
    li $v0, 4
    la $a0, msg_space
    syscall
    
    addi $t2, $t2, 4
    addi $t1, $t1, 1
    j print_loop

end_print:
    li $v0, 4
    la $a0, msg_newline
    syscall
    jr $ra
