#pragma once

#include "ostd.h"

struct idt_entry {
    uint16_t base_low;
    uint16_t sel;
    uint8_t always0;
    uint8_t flags;
    uint16_t base_high;
};

struct idt_ptr {
    uint16_t limit;
    uint32_t base;
};

#define IDT_SIZE 256

struct idt_entry idt[IDT_SIZE];
struct idt_ptr idt_reg;

void set_idt_entry(int interrupt_number, void (*handler)(void), uint16_t sel, uint8_t flags) {
    uint32_t handler_address = (uint32_t)handler;

    idt[interrupt_number].base_low = handler_address & 0xFFFF;
    idt[interrupt_number].base_high = (handler_address >> 16) & 0xFFFF;
    idt[interrupt_number].sel = sel;
    idt[interrupt_number].always0 = 0;
    idt[interrupt_number].flags = flags;
}

void init_idt() {
    idt_reg.limit = (sizeof(struct idt_entry) * IDT_SIZE) - 1;
    idt_reg.base = (uint32_t)&idt;

    __asm__ volatile("lidt (%0)" : : "r"(&idt_reg));
}

void disable_interrupts() {
    __asm__ volatile("cli");
}

void enable_interrupts() {
    __asm__ volatile("sti");
}