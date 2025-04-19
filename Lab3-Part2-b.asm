.data
prompt1: .asciiz "Enter dividendqwe: "  
prompt2: .asciiz "Enter divisorew: "  
quotient_msg: .asciiz "Quotient: "  
remainder_msg: .asciiz "\nRemainder: "  
endl: .asciiz "\n"

.text
.globl main

main:

    li   $v0, 4
    la   $a0, prompt1
    syscall


    li   $v0, 5
    syscall
    move $s0, $v0


    li   $v0, 4
    la   $a0, prompt2
    syscall


    li   $v0, 5
    syscall
    move $s1, $v0 


    beq  $s0, $zero, exit_program
    beq  $s1, $zero, exit_program


    move $a0, $s0 
    move $a1, $s1 
    jal  recursive_division  

    move $s2, $v0 
    move $s3, $v1  


    li   $v0, 4
    la   $a0, quotient_msg
    syscall

    li   $v0, 1
    move $a0, $s2 
    syscall


    li   $v0, 4
    la   $a0, remainder_msg
    syscall

    li   $v0, 1
    move $a0, $s3  
    syscall


    li   $v0, 4
    la   $a0, endl
    syscall

    j    main  


recursive_division:
  
    blt  $a0, $a1, base_case

   
    addi $sp, $sp, -8 
    sw   $ra, 4($sp)    
    sw   $a0, 0($sp)    

   
    sub  $a0, $a0, $a1   
    jal  recursive_division  

  
    lw   $a0, 0($sp)    
    lw   $ra, 4($sp)    
    addi $sp, $sp, 8  

    addi $v0, $v0, 1  
    jr   $ra

base_case:
    move $v0, $zero  
    move $v1, $a0    
    jr   $ra


exit_program:
    li   $v0, 10  
    syscall




