.data
    prompt1: .asciiz "Enter the first value: "
    prompt2: .asciiz "\nEnter the second value: "
    menu: .asciiz "\nSelect an operation:\n+ Add\n- Subtract\n* Multiply\n/ Divide\n$ Continue with new number\n& Calculate with current numbers\n"
    continuePrompt: .asciiz "\nDo you want to continue? (Enter $ for a new number, & to calculate): "
    resultMsg: .asciiz "\nThe result is: "

.text
    # Function to print a string
    printString:
        li $v0, 4
        syscall
        jr $ra

    # Function to read an integer
    readInt:
        li $v0, 5
        syscall
        jr $ra

    # Function to perform addition
    addFunction:
        add $s2, $s0, $s1
        j continueOrPrint

    # Function to perform subtraction
    subFunction:
        sub $s2, $s0, $s1
        j continueOrPrint

    # Function to perform multiplication
    mulFunction:
        mul $s2, $s0, $s1
        j continueOrPrint

    # Function to perform division
    divFunction:
        div $s0, $s1
        mflo $s2
        j continueOrPrint

    # Function to continue or print result
    continueOrPrint:
        printString continuePrompt
        li $v0, 12
        syscall
        beq $v0, 36, inputNewNumber
        beq $v0, 38, printResult
        j continueOrPrint

    # Function to input a new number
    inputNewNumber:
        printString prompt2
        readInt $s5
        j selectOperationForNewNumber

    # Function to print the final result
    printResult:
        printString resultMsg
        li $v0, 1
        move $a0, $s2
        syscall
        j terminate

    # Function to select operation for a new number
    selectOperationForNewNumber:
        printString menu
        li $v0, 12
        syscall
        move $s4, $v0
        beq $s4, 43, addFunction
        beq $s4, 45, subFunction
        beq $s4, 42, mulFunction
        beq $s4, 47, divFunction
        j terminate

    # Entry point
    main:
        printString prompt1
        readInt $s0

        printString prompt2
        readInt $s1

        selectOperation:
            printString menu
            li $v0, 12
            syscall
            move $s4, $v0
            beq $s4, 43, addFunction
            beq $s4, 45, subFunction
            beq $s4, 42, mulFunction
            beq $s4, 47, divFunction
            beq $s4, 36, inputNewNumber
            beq $s4, 38, printResult
            j selectOperation

    # Function to terminate the program
    terminate:
        li $v0, 10
        syscall
