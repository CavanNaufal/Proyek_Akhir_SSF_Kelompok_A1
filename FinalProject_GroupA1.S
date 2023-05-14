#define __SFR_OFFSET 0x00
#include "avr/io.h"

.global main

main:
SBI DDRB, 0 ;set PB0 (pin D8 as o/p - LED)
CBI DDRC, 0 ;clear PC0 (pin A0 as i/p - button)

loop:
    sbic PINC, 0      ; skip next instruction if PC0 is low
    rjmp led_on       ; jump to led_on if PC0 is high
    
    ldi R16, 0b00000000   ; turn off LED if PC0 is low
    out PORTB, R16
    rjmp loop
    
led_on:
    ldi R16, 0b00000001   ; turn on LED if PC0 is high
    out PORTB, R16
    
    ldi R17, 0xFF         ; set delay counter to 255
    
delay_loop:
    dec R17               ; decrement counter
    brne delay_loop       ; repeat until counter reaches zero
    
    ldi R16, 0b00000000   ; turn off LED after delay
    out PORTB, R16
    rjmp loop