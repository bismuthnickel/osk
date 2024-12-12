#include "cursor.h"

void normalize_cursor(Cursor* cursor) {
    if (!cursor) return; // Null check for safety

    // Calculate quotient and remainder
    uint16_t quotient = cursor->x / 80;
    uint16_t remainder = cursor->x % 80;

    // Update cursor's coordinates
    cursor->x = remainder;
    cursor->y += quotient;
}
