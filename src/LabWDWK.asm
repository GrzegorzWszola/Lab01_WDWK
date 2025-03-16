.section .data
    nsq:            .long 0
    format_out:     .asciz "Wynik: %d\n"
    format_in:      .asciz "%d"
    insert_text:    .asciz "Podaj n: "
    overflow_message: .asciz "Overflow occurred\n"
    max_value:      .long 2147483647  # Max 32-bit signed integer value

.section .bss
    n:      .long 0  # User input
    result: .long 0  # Storage for result

.section .text
    .global main
    .extern printf
    .extern scanf
    .extern fflush
    .extern stdout
    	
overflow_error:
    # Handle overflow error and display an error message
    pushl $overflow_message
    call printf
    addl $4, %esp
    
    # FFlush to show the message
    pushl stdout    # Push address of stdout
    call fflush
    addl $4, %esp  # Clean up stack

    # Exit program with an error code
    movl $1, %ebx
    movl $1, %eax
    int $0x80


main:
    # Print prompt message asking for user input
    pushl $insert_text
    call printf
    addl $4, %esp

    # Get user input for n
    pushl $n
    pushl $format_in
    call scanf
    addl $8, %esp

    # Check if the input exceeds max_value
    movl n, %eax
    movl $max_value, %ebx
    cmpl %ebx, %eax
    jg overflow_error

    # Calculate n*n*n (n^3)
    movl n, %eax
    imull %eax, %eax
    jo overflow_error
    movl %eax, nsq
    movl %eax, result
    imull n, %eax
    jo overflow_error
    movl %eax, result

    # Calculate result + 3*n*n (3*n^2)
    movl nsq, %eax
    imull $3, %eax
    jo overflow_error
    addl %eax, result
    jo overflow_error

    # Calculate result - 2*n
    movl n, %eax
    imull $2, %eax
    jo overflow_error
    movl result, %ecx
    subl %eax, %ecx
    jo overflow_error
    movl %ecx, result

    # Print the result
    pushl result
    pushl $format_out
    call printf
    addl $8, %esp

    # Exit program normally
    movl $0, %ebx
    movl $1, %eax
    int $0x80

.section .note.GNU-stack,"",@progbits

