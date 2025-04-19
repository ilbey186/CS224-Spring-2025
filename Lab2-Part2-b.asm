    .data
promptNum: .asciiz "Enter a 32-bit number: "
resultMsg2: .asciiz "Reversed Number: "
contMsg2: .asciiz "\nDo you want to continue? (1 = Yes, 0 = No): "

    .text
    .globl main

main:

    li $v0, 4
    la $a0, promptNum
    syscall


    li $v0, 5
    syscall
    move $s0, $v0 


    jal reverse_bits


    li $v0, 4
    la $a0, resultMsg2
    syscall

    move $a0, $v1 
    li $v0, 34
    syscall


    li $v0, 4
    la $a0, contMsg2
    syscall

    li $v0, 5
    syscall
    beq $v0, 1, main

    li $v0, 10
    syscall


reverse_bits:
    li $v1, 0     
    li $s1, 32   

reverse_loop:
    beqz $s1, end_reverse  
    sll $v1, $v1, 1        
    andi $s2, $s0, 1       
    or $v1, $v1, $s2      
    srl $s0, $s0, 1        
    sub $s1, $s1, 1       
    j reverse_loop

end_reverse:
    jr $ra
