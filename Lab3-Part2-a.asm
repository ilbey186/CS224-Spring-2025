.data
msg_add:  .asciiz "number of add instructions: "
msg_addi: .asciiz "\nnumber of adi instructions: "
endl:  .asciiz "\n"

.text
.globl main

main:
    la   $a0, start      
    la   $a1, end      

    jal  count_instructions  

    move $s4, $v0     
    move $s5, $v1      


    li   $v0, 4
    la   $a0, msg_add
    syscall

    li   $v0, 1
    move $a0, $s4       
    syscall

    li   $v0, 4
    la   $a0, msg_addi
    syscall

    li   $v0, 1
    move $a0, $s5      
    syscall

    li   $v0, 4
    la   $a0, endl
    syscall

    li   $v0, 10       
    syscall


count_instructions:
    move $s0, $a0       
    move $s1, $a1     
    li   $s2, 0        
    li   $s3, 0         

loop:
    bge  $s0, $s1, done  

    lw   $s4, 0($s0) 
    addi $s0, $s0, 4    

  
    andi $s5, $s4, 0x3F  
    li   $s6, 0x20       
    beq  $s5, $s6, count_add

   
    srl  $s5, $s4, 26    
    li   $s6, 0x08      
    beq  $s5, $s6, count_addi

    j    loop

count_add:
    addi $s2, $s2, 1
    j    loop

count_addi:
    addi $s3, $s3, 1
    j    loop

done:
    move $v0, $s2        
    move $v1, $s3       
    jr   $ra           


start:
    addi $s4, $s5, 2    
    addi $s7, $s3, 10     
    add  $s1, $s2, $s3    
    addi $s0, $s1, 5      
    add  $s5, $s6, $s7    
    add  $s2, $s3, $s4  
    addi $s1, $s2, 7      
end: