# MCU 8051 Assembly Programs

This repository contains assembly code designed for the MCU 8051 microcontroller. The codes perform specific arithmetic and display operations as detailed below.

## Division of 16-bit by 8-bit Numbers

### Description
This program performs the division of a 16-bit unsigned number by an 8-bit unsigned number. The results include both the quotient and the remainder of the division.

### Functionality
- Accepts 16-bit dividends and 8-bit divisors.
- Calculates the quotient and the remainder.
- Outputs the results into specific registers:
  - Quotient: High part in R4, Low part in R3
  - Remainder in R5

## Product of Prime Factors Display on LCD

### Description
This program takes an integer input via a keypad and displays the product of its prime factors on an LCD. The operation is intended for numbers in the range of 1 to 255.

### Functionality
- Interacts with a user through a keypad to receive numerical input.
- Calculates the product of prime factors for the input number.
- Displays the result on an LCD in the format `(prime1,prime2,...)`.

## Running the Code

### Requirements
- MCU 8051 IDE for simulations.
- Proteus software for visual simulations involving LCD and keypad interactions.

### Setup and Execution
1. Load the corresponding assembly file into your simulation environment.
2. Follow specific simulation procedures to test the functionality of each program.

## Contributing
Feel free to fork this repository and submit pull requests with enhancements or fixes.
