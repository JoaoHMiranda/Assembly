# Assembly

This repository, named **Arquitetura**, contains a collection of assembly language projects developed as part of a final assignment and supplementary exercises. The projects demonstrate various concepts including conditional branching, loops, file I/O, simple encryption, and string operations—all implemented using x86 assembly on Linux with the `int 80h` syscall interface.

> **Note:** Although the repository is named "Arquitetura," the projects focus on practical assembly programming techniques.

## Projects Overview

Below is a brief description of each project included in this repository:

- **Trabalho.s (Final Project – File Encryption):**  
  This is the final assignment developed by João Henrique and Sophia Luna. The program reads the file `arq1.txt`, encrypts its content by modifying characters whose ASCII codes range from 65 to 157, and writes the encrypted result to `arq2.txt`.  
  - **Key Features:** File opening, reading, writing, and a simple encryption algorithm based on ASCII arithmetic.
  - **Sample Input:** `arq1.txt` (provided in the repository) contains sample text.
  
- **Condicional.s and Condicional2.s:**  
  These files illustrate the use of conditional branching.  
  - **Condicional.s:** Prompts the user to enter a phrase (up to 99 characters) and compares the first character with `'A'`.  
  - **Condicional2.s:** Prompts the user to enter a character and checks if it lies within the interval `'a'` to `'z'`, printing corresponding messages.
  
- **Criptografia.s:**  
  Another encryption example that demonstrates basic file I/O and a simple cryptographic transformation on characters within a specific ASCII range.
  
- **Repetiçao1.s and Repetiçao2.s:**  
  These programs demonstrate looping (repetition) constructs in assembly. They read a phrase from the user, copy it into another buffer, and print the copied message.
  
- **Additional Examples (Hello, Read, etc.):**  
  Smaller programs that illustrate basic output (printing a greeting) and input operations from the keyboard.

## Repository Structure

A suggested directory layout for the repository is as follows:

