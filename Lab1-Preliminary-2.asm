.data
promptB: .asciiz "Enter value for B: "
promptC: .asciiz "Enter value for C: "
promptD: .asciiz "Enter value for D: "
result_msg: .asciiz "The result of the computation is: "
newline: .asciiz "\n"

.text
.globl main

main:
 
    li $v0, 4
    la $a0, promptB
    syscall
    li $v0, 5
    syscall
    move $t0, $v0   

   
    li $v0, 4
    la $a0, promptC
    syscall
    li $v0, 5
    syscall
    move $t1, $v0   


    li $v0, 4
    la $a0, promptD
    syscall
    li $v0, 5
    syscall
    move $t2, $v0  

  
    move $t3, $t0  
    move $t4, $zero

div_loop:
    blt $t3, $t1, div_done  
    sub $t3, $t3, $t1       
    addi $t4, $t4, 1        
    j div_loop

div_done:
    move $t5, $t4  

   
    move $t6, $t2  
mod_loop:
    blt $t6, $t0, mod_done 
    sub $t6, $t6, $t0      
    j mod_loop

mod_done:
    move $t7, $t6  

    
    add $t8, $t5, $t7  
    sub $t8, $t8, $t1 

  
    move $t9, $t8   
    move $s0, $zero 

final_div:
    blt $t9, $t0, final_done 
    sub $t9, $t9, $t0         
    addi $s0, $s0, 1         
    j final_div

final_done:
   
    li $v0, 4
    la $a0, result_msg
    syscall

    li $v0, 1
    move $a0, $s0
    syscall

    li $v0, 4
    la $a0, newline
    syscall

 
    li $v0, 10
    syscall