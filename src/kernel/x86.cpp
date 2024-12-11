// In x86.cpp (source file)
#include <stdint.h>
#include "x86.hpp"

void outb(unsigned short port, unsigned char value) {
    __asm__ __volatile__ (
        "out %%al, %%dx"
        : // No output operands
        : "a"(value), "d"(port)  // Input operands: value to AL, port to DX
    );
}

// Function prototype with cdecl calling convention
uint8_t inb(uint16_t port) {
    uint8_t result;
    
    // Inline assembly to perform the I/O port read (in AL, port)
    __asm__ __volatile__ (
        "in %%dx, %%al"       // Read byte from port (dx -> port, AL <- value)
        : "=a"(result)         // Output: result = AL (value from I/O port)
        : "d"(port)           // Input: port is passed in DX
    );
    
    return result;
}
