#include "x86.hpp"

void disable_hardware_cursor()
{
	outb(0x3D4, 0x0A);
	outb(0x3D5, 0x20);
}