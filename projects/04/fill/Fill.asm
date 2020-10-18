// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.

(ROOTLOOP)
    @color
    M = 0       // By default fill with white
    @KBD
    D = M
    @FILLSCREEN
    D; JEQ      // No keys are pressed, skip setting color to black, goto FILLSCREEN
    @color
    M = -1      // Some key is pressed, cst color to black

    (FILLSCREEN)
    @SCREEN
    //@24573    // For debugging purposes uncomment current line, it will fill only a small line at the end of the screen
                // because filling the whole screen takes eternity
    D = A
    @address
    M = D       // address = 16384 (base address of the Hack screen)

    (FILLSCREENLOOP)
        @color
        D = M
        @address
        A = M		// Writing to memory using a pointer
        M = D		// RAM[address] = color

        @address
        M = M + 1	// address = address + 1

        D = M
        @24575
        D = D - A
        @FILLSCREENLOOP
        D; JLE		// if address <= 24575 (address of the last screen register) goto FILLSCREENLOOP

        @ROOTLOOP
        0; JMP      // Goto ROOTLOOP