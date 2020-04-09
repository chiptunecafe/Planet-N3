*   = $0000
    .dsection zp
    .cerror * >= $0100, "Too many zero page variables"

*   = $0200
    .dsection bss
    .cerror * >= $0800, "Too many internal RAM variables"

*   = $6000
    .dsection wbss0
    .cerror * >= $8000, "Too many work RAM 0 variables"

    .section zp

; General-purpose zp registers

D0  .byte ?
D1  .byte ?
D2  .byte ?
D3  .byte ?
D4  .byte ?
D5  .byte ?
D6  .byte ?
D7  .byte ?
A0  .word ?
A1  .word ?
A2  .word ?
A3  .word ?

; Timing information
; bit 0: Slow down engine speed to 5/6 times
; bit 1: Use PAL NES scanline counter
z_timing    .byte ?

    .send
