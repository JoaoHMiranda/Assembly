# Final Project: File Encryption in Assembly

This project is a final assignment developed by João Henrique and Sophia Luna. It is written in assembly language for Linux and demonstrates file I/O and a simple encryption algorithm. The program reads a text file (`arq1.txt`), encrypts its content by modifying characters within the ASCII range 65 to 157, and writes the encrypted output to another file (`arq2.txt`).

## Overview

- **File I/O**:  
  - Opens `arq1.txt` for reading.
  - Attempts to open `arq2.txt` for writing. If the file already exists, an error message is printed.
- **Encryption Algorithm**:  
  - Reads a block of characters from `arq1.txt`.
  - For each character with an ASCII value between 65 and 157 (inclusive), it subtracts the character's value from 157 to compute a new value.
  - The new encrypted character replaces the original in the buffer.
- **Output**:  
  - Writes the encrypted buffer to `arq2.txt`.
  - Properly closes file descriptors.
- **Error Handling**:  
  - Displays error messages if file operations fail.

## Project Files

- **Trabalho.s**  
  The main assembly source file containing the encryption logic and file operations.
- **arq1.txt**  
  A sample input file containing text to be encrypted.
- **arq2.txt**  
  The output file that will be created by the program with the encrypted content.

## How to Compile and Run

This project is built using NASM and GCC. Follow these steps to compile and run:

1. **Assemble the Source Code**  
   Use NASM to convert the assembly source file into an object file:
   ```bash
   nasm -f elf32 Trabalho.s -o Trabalho.o
