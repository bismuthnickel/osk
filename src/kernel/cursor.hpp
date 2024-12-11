#pragma once

#include <stdint.h>

void enable_cursor(uint8_t cursor_start, uint8_t cursor_end);
void disable_cursor();
void set_cursor(uint16_t cursor);
void update_cursor(int x, int y, int VGA_WIDTH);
uint16_t get_cursor_position(void);