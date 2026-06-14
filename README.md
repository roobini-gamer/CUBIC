# C.U.B.I.C - COBOL Universal Base Interactive Converter

![COBOL](https://img.shields.io/badge/Language-COBOL-blue)
![Precision](https://img.shields.io/badge/Math_Precision-6_Decimals-green)

**C.U.B.I.C** stands for **C**OBOL **U**niversal **B**ase **I**nteractive **C**onverter. 

My first COBOL code, highly precise, terminal-based unit converter written in pure COBOL. Designed with strict mathematical accuracy, C.U.B.I.C converts between multiple unit categories with up to 6 decimal places of precision without the risk of silent truncation errors.

---

## Features

* **6 Unit Categories**: Length, Temperature, Area, Volume, Weight, and Time.
* **High Precision Math**: Internal calculation variables use `9(9)V999999` and `9(9)V999999999` precision guarantees, ensuring that fractional conversions (like 69.420 Meters to Kilometers) compute flawlessly to `0.069420` without truncation.
* **Base-Factor Architecture**: Converts inputs into a standardized base unit (e.g., Meters for Length, Liters for Volume) before translating to the target unit, ensuring mathematical consistency across the board.
* **Interactive Terminal UI**: Continuous REPL-style loop allowing for multiple conversions in a single session without restarting the program.
* **Input Validation**: Catches invalid category selections gracefully without crashing.

---

## Compilation & Execution

C.U.B.I.C is designed for **GnuCOBOL** (`cobc`). It utilizes standard fixed-format COBOL syntax.

### Compiling
Open your terminal and compile the source code into an executable:
```bash
cobc -x cubic.cob -o cubic
