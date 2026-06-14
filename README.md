<h1 align="center">
  <br>
  <a href=""><img src="https://i.ibb.co/v44GsVRk/Duck-ai-image-2026-06-14-18-17.jpg" width="200"></a>
  <br>
  C.U.B.I.C
  <br>
  <br>
</h1>

# C.U.B.I.C - COBOL Universal Base Interactive Converter

![COBOL](https://img.shields.io/badge/Language-COBOL-blue)
![Precision](https://img.shields.io/badge/Math_Precision-6_Decimals-green)

**C.U.B.I.C** stands for **C**OBOL **U**niversal **B**ase **I**nteractive **C**onverter. 

My first COBOL code, highly precise, terminal-based unit converter written in pure COBOL. Designed with strict mathematical accuracy, C.U.B.I.C converts between multiple unit categories with up to 6 decimal places of precision without the risk of silent truncation errors.

## Features

* **6 Unit Categories**: Length, Temperature, Area, Volume, Weight, and Time.
* **High Precision Math**: Internal calculation variables use `9(9)V999999` and `9(9)V999999999` precision guarantees, ensuring that fractional conversions (like 69.420 Meters to Kilometers) compute flawlessly to `0.069420` without truncation.
* **Base-Factor Architecture**: Converts inputs into a standardized base unit (e.g., Meters for Length, Liters for Volume) before translating to the target unit, ensuring mathematical consistency across the board.
* **Interactive Terminal UI**: Continuous REPL-style loop allowing for multiple conversions in a single session without restarting the program.
* **Input Validation**: Catches invalid category selections gracefully without crashing.

## Compilation & Execution

C.U.B.I.C is designed for **GnuCOBOL** (`cobc`). It utilizes standard fixed-format COBOL syntax.

### Compiling
Open your terminal and compile the source code into an executable:

```bash
cobc -x cubic.cob -o cubic
```

### Running
Execute the compiled binary:

```bash
./cubic
```
(If using an online IDE like JDoodle, simply paste the code and hit Execute!)

### Usage Guide

* Select Category: C.U.B.I.C will prompt you with a numbered list of categories (1-6). Enter the corresponding number.
* Select Units: You will be shown a list of unit codes for your chosen category. Enter the 2-digit (or 1-digit where applicable) code for the From Unit, press Enter, then enter the code for the To Unit.
* Enter Value: Type the numeric value you wish to convert (e.g., 69.420) and press Enter.
* View Result: The precise converted result will display on the screen up to 6 decimal points.
* Repeat or Exit: You will be asked CONVERT ANOTHER? (Y/N):. Type Y and press Enter to run another conversion, or N to terminate C.U.B.I.C

## What I Learned

This was my first COBOL project.
* **LVL 88** Made validating menu choices and unit codes way easier than writing massive IF/ELSE blocks.
* **Decimal Precision & Truncation:** Figuring out that if you don't give your computation variables enough decimal places (I used `V9(9)`), COBOL will silently truncate your math, causing totally wrong conversion outputs.
* **COBOL MATH** `COMPUTE` is incredibly flexible for handling complex formulas (especially for Temperature conversions) compared to the strict syntax of `MULTIPLY` and `DIVIDE`.
* **Paragraphs over braces.** Had to get used to top-down paragraph flow instead of curly-brace loops, but it actually makes sense once you get going.
* **EVALUATE TRUE is basically switch/case.** `EVALUATE TRUE` is COBOL's elegant version of a `switch/case` statement.
