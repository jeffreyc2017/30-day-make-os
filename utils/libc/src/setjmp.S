.text
.global _setjmp
.global _longjmp

_setjmp:
    movl 4(%esp), %eax   # Get the address of jmp_buf
    movl %ebx, (%eax)    # Save ebx
    movl %esi, 4(%eax)   # Save esi
    movl %edi, 8(%eax)   # Save edi
    movl %ebp, 12(%eax)  # Save ebp
    movl %esp, 16(%eax)  # Save esp
    movl (%esp), %ecx    # Get return address
    movl %ecx, 20(%eax)  # Save eip (return address)
    xorl %eax, %eax      # Return 0
    ret

_longjmp:
    movl 4(%esp), %edx   # Get the address of jmp_buf
    movl 8(%esp), %eax   # Get the return value
    testl %eax, %eax     # Check if return value is 0
    jnz 1f
    incl %eax            # If 0, change it to 1
1:
    movl (%edx), %ebx    # Restore ebx
    movl 4(%edx), %esi   # Restore esi
    movl 8(%edx), %edi   # Restore edi
    movl 12(%edx), %ebp  # Restore ebp
    movl 16(%edx), %esp  # Restore esp
    movl 20(%edx), %ecx  # Get saved eip
    movl %ecx, (%esp)    # Set up return address
    ret
