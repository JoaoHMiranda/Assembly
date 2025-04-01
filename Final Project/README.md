# Final Project: File Encryption in Assembly

This project is a final assignment developed by João Henrique and Sophia Luna. It is written in assembly language for Linux and demonstrates file I/O along with a simple encryption algorithm. The program reads an input file (`input.txt`), encrypts its content by modifying each character within the ASCII range 65 to 157 using the formula:

## encrypted = 157 - original

and writes the encrypted output to an output file (`output.txt`).

## Overview

- **File I/O**:
  - Opens `input.txt` for reading.
  - Opens (or creates) `output.txt` for writing. If the file already exists, it is overwritten.
- **Encryption Algorithm**:
  - Reads a block of characters from `input.txt`.
  - For each character with an ASCII value between 65 and 157 (inclusive), it computes the new character as:
    ```
    encrypted = 157 - original
    ```
  - The new encrypted character replaces the original in the buffer.
- **Output**:
  - Writes the encrypted buffer to `output.txt`.
  - Closes file descriptors properly.
- **Error Handling**:
  - Displays error messages if any file operation fails.

## Project Files

- **FinalProject.s**  
  The main assembly source file containing the encryption logic and file operations.
- **input.txt**  
  A sample input file containing text to be encrypted.
- **output.txt**  
  The output file that will be created by the program with the encrypted content.
