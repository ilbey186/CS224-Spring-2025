.data
    list:  .word 12, 25, node1
    node1: .word 33, 8, node2
    node2: .word 15, 42, node3
    node3: .word 27, 11, node4
    node4: .word 19, 7, node5
    node5: .word 44, 18, node6
    node6: .word 55, 5, node7
    node7: .word 60, 30, node8
    node8: .word 22, 14, node9
    node9: .word 75, 9, node10
    node10:.word 90, 24, node11
    node11:.word 99, 3, 0   

    prompt: .asciiz "BOOOOOOOOOOOOOOOOOOOOOOOO\n"
    oddMsg: .asciiz "\nOdd Linked List:\n"
    evenMsg: .asciiz "\nEven Linked List:\n"
    reversePrompt: .asciiz "\nlinked list in reverse order...\n"
    newline: .asciiz "\n"

.text
.globl main

main:
    li $v0, 4
    la $a0, prompt
    syscall

    la $a0, list
    jal GenerateOddEvenLinkedLists

    move $s0, $v0  
    move $s1, $v1  

    li $v0, 4
    la $a0, oddMsg
    syscall
    move $a0, $s0
    jal DisplayList

    li $v0, 4
    la $a0, evenMsg
    syscall
    move $a0, $s1
    jal DisplayList

    li $v0, 4
    la $a0, reversePrompt
    syscall

    la $a0, list
    jal DisplayListRecursively

    li $v0, 10
    syscall

GenerateOddEvenLinkedLists:
    move $s2, $zero
    move $s3, $zero
    move $s4, $zero
    move $s5, $zero
    move $s6, $a0 

loop:
    beq $s6, $zero, done  

    lw $s7, 4($s6)  
    lw $a1, 8($s6)  

    li $v0, 9
    li $a0, 12
    syscall
    move $a2, $v0  

    lw $a3, 0($s6)  
    sw $a3, 0($a2)  
    sw $s7, 4($a2)  
    sw $zero, 8($a2)  

    andi $a3, $s7, 1  
    beq $a3, $zero, even_case

odd_case:
    beq $s2, $zero, first_odd
    sw $a2, 8($s4)  
    move $s4, $a2    
    j next_node

first_odd:
    move $s2, $a2  
    move $s4, $a2  
    j next_node

even_case:
    beq $s3, $zero, first_even
    sw $a2, 8($s5)  
    move $s5, $a2    
    j next_node

first_even:
    move $s3, $a2  
    move $s5, $a2  

next_node:
    move $s6, $a1  
    j loop

done:
    move $v0, $s2  
    move $v1, $s3  
    jr $ra

DisplayList:
    move $s6, $a0

display_loop:
    beq $s6, $zero, end_display

    lw $s7, 0($s6)  
    lw $a1, 4($s6)  
    lw $a2, 8($s6)  

    li $v0, 1
    move $a0, $s7  
    syscall

    li $v0, 11
    li $a0, 44 
    syscall

    li $v0, 1
    move $a0, $a1  
    syscall

    li $v0, 4
    la $a0, newline
    syscall

    move $s6, $a2  
    j display_loop

end_display:
    jr $ra

DisplayListRecursively:
    beq $a0, $zero, end_rec

    addi $sp, $sp, -12
    sw $ra, 0($sp)
    sw $a0, 4($sp)

    lw $s6, 8($a0)  
    move $a0, $s6
    jal DisplayListRecursively  

    lw $a0, 4($sp)

    lw $s7, 0($a0)  
    lw $a1, 4($a0)  

    li $v0, 1
    move $a0, $s7
    syscall

    li $v0, 11
    li $a0, 44
    syscall

    li $v0, 1
    move $a0, $a1
    syscall

    li $v0, 4
    la $a0, newline
    syscall

    lw $ra, 0($sp)
    addi $sp, $sp, 12
    jr $ra

end_rec:
    jr $ra
