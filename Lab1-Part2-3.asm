.data
prompt_a:   .asciiz "Enter value for a: "  
prompt_b:   .asciiz "Enter value for b: "  
result_msg: .asciiz "The result of x = (2*A-B)/(A + B)) is: "  
endl:    .asciiz "\n"  

.text
.globl main

main:

    li $v0, 4             
    la $a0, prompt_a      
    syscall

    li $v0, 5             
    syscall
    move $t0, $v0        

   
    li $v0, 4             
    la $a0, prompt_b      
    syscall

    li $v0, 5             
    syscall
    move $t1, $v0        

    
    add $t2, $t0, $t1     

  
    sll $t2, $t2, 1      

    li $t3, 3             
    div $t2, $t3          
    mflo $t4              

   
    div $t0, $t1          
    mfhi $t5              

  
    sub $t6, $t4, $t5    

 
    li $v0, 4             
    la $a0, result_msg    
    syscall

   
    li $v0, 1             
    move $a0, $t6         
    syscall

  
    li $v0, 4             
    la $a0, endl     
    syscall

    
    li $v0, 10            
    syscall
