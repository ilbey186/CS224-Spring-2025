    .data
prompt1: .asciiz "Enter first 32-bit number: "
prompt2: .asciiz "Enter second 32-bit number: "
resultMsg: .asciiz "Hamming Distance: "
contMsg: .asciiz "\nDo you want to continue? (1 = Yes, 0 = No): "

    .text
    .globl main

main:

    li $v0, 4
    la $a0, prompt1
    syscall


    li $v0, 5
    syscall
    move $s0, $v0    


    li $v0, 4
    la $a0, prompt2
    syscall


    li $v0, 5
    syscall
    move $s1, $v0


    jal hamming_distance


    li $v0, 4
    la $a0, resultMsg
    syscall

    move $a0, $v1 
    li $v0, 1
    syscall


    li $v0, 4
    la $a0, contMsg
    syscall

    li $v0, 5
    syscall
    beq $v0, 1, main

    li $v0, 10
    syscall


hamming_distance:
    xor $s2, $s0, $s1  
    li $v1, 0          

count_loop:
    beqz $s2, end_count  
    andi $s3, $s2, 1     
    add $v1, $v1, $s3    
    srl $s2, $s2, 1    
    j count_loop

end_count:
    jr $ra

