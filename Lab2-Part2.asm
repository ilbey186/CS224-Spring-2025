    .data
prompt1: .asciiz "Enter first 32-bit number: "
prompt2: .asciiz "Enter second 32-bit number: "
resultMsg: .asciiz "Hamming Distance: "
contMsg: .asciiz "\nDo you want to continue? (1 = Yes, 0 = No): "

    .text
    .globl main

main:
    # Prompt user for first number
    li $v0, 4
    la $a0, prompt1
    syscall

    # Read first number
    li $v0, 5
    syscall
    move $t0, $v0    # Store in $t0

    # Prompt user for second number
    li $v0, 4
    la $a0, prompt2
    syscall

    # Read second number
    li $v0, 5
    syscall
    move $t1, $v0    # Store in $t1

    # Compute Hamming Distance
    jal hamming_distance

    # Display result
    li $v0, 4
    la $a0, resultMsg
    syscall

    move $a0, $v1  # Print distance (fixed)
    li $v0, 1
    syscall

    # Ask if user wants to continue
    li $v0, 4
    la $a0, contMsg
    syscall

    li $v0, 5
    syscall
    beq $v0, 1, main

    li $v0, 10
    syscall

# Hamming Distance Function
hamming_distance:
    xor $t2, $t0, $t1  # XOR to find differing bits
    li $v1, 0          # Initialize count to 0

count_loop:
    beqz $t2, end_count  # If $t2 is 0, exit loop
    andi $t3, $t2, 1     # Extract least significant bit (LSB)
    add $v1, $v1, $t3    # If LSB is 1, increment count
    srl $t2, $t2, 1      # Shift right to check next bit
    j count_loop

end_count:
    jr $ra

