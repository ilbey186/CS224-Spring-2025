.data
    prompt_size: .asciiz "Enter the size of the array: "
    prompt_element: .asciiz "Enter an element of the array: "
    newline: .asciiz "\n"
    FreqTable: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0  

.text
    .globl main

main:

    li $v0, 4
    la $a0, prompt_size
    syscall

    li $v0, 5  
    syscall
    move $t0, $v0 


    jal CreateArray
    move $s0, $v0  


    move $a0, $s0      
    move $a1, $t0     
    la $a2, FreqTable 
    jal FindFreq


    li $t1, 0  
print_freq:
    la $t2, FreqTable  
    add $t2, $t2, $t1  
    lw $a0, 0($t2)  
    li $v0, 1
    syscall


    li $v0, 4
    la $a0, newline
    syscall

    addi $t1, $t1, 4  
    blt $t1, 44, print_freq


    li $v0, 10
    syscall

CreateArray:
    li $v0, 9         
    move $a0, $t0      
    mul $a0, $a0, 4    
    syscall
    move $t2, $v0      


    move $t3, $t2      
    li $t4, 0          
initialize_loop:
    li $v0, 4
    la $a0, prompt_element
    syscall

    li $v0, 5          
    syscall
    sw $v0, 0($t3)     

    addi $t3, $t3, 4   
    addi $t4, $t4, 1   
    blt $t4, $t0, initialize_loop  

    move $v0, $t2     
    jr $ra

FindFreq:

    li $t4, 0
    la $t5, FreqTable
    li $t6, 11  
init_freq:
    sw $zero, 0($t5)    
    addi $t5, $t5, 4
    addi $t6, $t6, -1
    bgtz $t6, init_freq 


    li $t6, 0        
process_array:
    lw $t8, 0($a0)     
    blt $t8, 0, continue_loop  
    bge $t8, 10, update_last  


    la $t9, FreqTable
    mul $t8, $t8, 4    
    add $t9, $t9, $t8 
    lw $t7, 0($t9)
    addi $t7, $t7, 1
    sw $t7, 0($t9)
    j continue_loop

update_last:

    la $t9, FreqTable
    addi $t9, $t9, 40   
    lw $t7, 0($t9)
    addi $t7, $t7, 1
    sw $t7, 0($t9)

continue_loop:
    addi $t6, $t6, 1  
    addi $a0, $a0, 4   
    blt $t6, $a1, process_array  
    jr $ra
