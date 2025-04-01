# Assembly

This repository, named **Arquitetura**, contains a collection of assembly language projects developed as part of a final assignment and supplementary exercises. The projects demonstrate various concepts including conditional branching, loops, file I/O, simple encryption, and string operations — all implemented using x86 assembly on Linux with the `int 80h` syscall interface.

## Projects Overview

- **FinalProject.s (File Encryption):**  
  This final assignment reads an input file (`input.txt`), encrypts its content by modifying characters whose ASCII codes range from 65 to 157 using the formula:
   ```
    encrypted = 157 - original
    ```
and writes the encrypted result to `output.txt`.  
- **Key Features:** File opening, reading, writing, and a simple encryption algorithm based on ASCII arithmetic.
- **Sample Input:** `input.txt` contains sample text provided in the repository.

- **Conditional.s and Conditional2.s:**  
These files illustrate the use of conditional branching.
- **Conditional.s:** Prompts the user to enter a phrase (up to 99 characters) and compares the first character with `'A'`.
- **Conditional2.s:** Prompts the user to enter a character and checks if it falls within the range `'a'` to `'z'`, printing the appropriate message.

- **Cryptography.s:**  
Demonstrates basic file I/O and a simple cryptographic transformation on characters within a specified ASCII range.

- **Repetition1.s and Repetition2.s:**  
These programs demonstrate looping constructs. They read a phrase from the user, copy it into another buffer, and display the copied message.

- **Additional Examples (Hello.s, Read.s, FileClose.s):**  
Smaller programs that illustrate basic output (e.g., printing a greeting), reading input from the keyboard, and file closing operations with error handling.

##  All projects are written in NASM syntax for 32-bit Linux. You will need NASM and a 32-bit capable GCC toolchain (e.g., gcc-multilib) to build these programs.
