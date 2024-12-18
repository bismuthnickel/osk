#pragma once

#include "ostd.h"

uint8_t readb(uint32_t address) {
    uint8_t *ptr = (uint8_t *)address;
    return *ptr;
}

uint16_t readw(uint32_t address) {
    uint16_t *ptr = (uint16_t *)address;
    return *ptr;
}

uint32_t readd(uint32_t address) {
    uint32_t *ptr = (uint32_t *)address;
    return *ptr;
}

void writeb(uint32_t address, uint8_t value) {
    uint8_t *ptr = (uint8_t *)address;
    *ptr = value;
}

void writew(uint32_t address, uint16_t value) {
    uint16_t *ptr = (uint16_t *)address;
    *ptr = value;
}

void writed(uint32_t address, uint32_t value) {
    uint32_t *ptr = (uint32_t *)address;
    *ptr = value;
}
