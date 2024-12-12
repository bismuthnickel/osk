#pragma once

#include <stdint.h>

struct Cursor {
    uint16_t x;
    uint16_t y;
};

void normalize_cursor(Cursor* cursor);