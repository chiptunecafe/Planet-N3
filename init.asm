    .include "hw.asm"

    .section init
start
    sei
    ; init mapper
    ldx #0
-   stx MAP_ADDR
    stx MAP_DATA
    inx
    cpx #8
    bne -
    lda #$c0 ; enable RAM and map $6000 to RAM
    stx MAP_ADDR
    sta MAP_DATA
    lda #0
    inx ; $8000
    stx MAP_ADDR
    sta MAP_DATA
    inx ; $A000
    stx MAP_ADDR
    sta MAP_DATA
    inx ; $C000
    stx MAP_ADDR
    sta MAP_DATA
    lda #1 ; horizontal mirroring
    inx
    stx MAP_ADDR
    sta MAP_DATA
    lda #0 ; disable timer IRQ
    inx
    stx MAP_ADDR
    sta MAP_DATA
    lda #$40 ; inhibit APU frame IRQ
    sta JOY2

    ; wait until PPU is done initializing
    bit PPUSTATUS
-   bit PPUSTATUS
    bpl -
-   bit PPUSTATUS
    bpl -

    ; transfer the tilemap
    lda #$20
    sta PPUADDR
    lda #$00
    sta PPUADDR
    sta PPUMASK
    ldx #196
-
    sta PPUDATA
    dex
    bne -
    lda #<nes19_tilemap
    sta 0
    lda #>nes19_tilemap
    sta 1
    ldx #20
-
    ldy #0
-
    lda (0), y
    sta PPUDATA
    iny
    cpy #26
    bne -
    tya
    clc
    adc 0
    sta 0
    bcc +
    inc 1
+
    lda #0
-
    sta PPUDATA
    iny
    cpy #32
    bne -
    dex
    bne ---
    ldx #124
-
    sta PPUDATA
    dex
    bne -
    ldx #0
-
    lda nes19_attrmap,x
    sta PPUDATA
    inx
    cpx #64
    bne -

    ; palettes
    lda #$3f
    sta PPUADDR
    lda #$00
    sta PPUADDR
    ldx #0
-
    lda nes19_palette,x
    sta PPUDATA
    inx
    cpx #16
    bne -

    lda #8
    sta PPUSCROLL
    sta PPUSCROLL
    lda #%10000000 ; tilemap 0, write +1, 8x8 sprite 0, bg 0, vblank on
    sta PPUCTRL
    lda #%00001010
    sta PPUMASK
    cli

-   jmp -

nmiv
    bit PPUSTATUS ; read and clear VBlank occurred flag
    pha
    txa
    pha

timer = $41c4
    ldx #MAP_TIM_HI
    lda #>timer
    stx MAP_ADDR
    sta MAP_DATA
    dex
    lda #<timer
    stx MAP_ADDR
    sta MAP_DATA
    dex
    lda #$ff
    stx MAP_ADDR
    sta MAP_DATA
    
    lda #%10000000 ; tilemap 0, write +1, 8x8 sprite 0, bg 0, vblank on
    sta PPUCTRL
    pla
    tax
    pla
    rti

irqv
    pha
    lda #%10010000 ; tilemap 0, write +1, 8x8 sprite 0, bg 1, vblank on
    sta PPUCTRL

    lda #MAP_TIM_IRQ
    sta MAP_ADDR
    lda #0
    sta MAP_DATA ; acknowledge and stop timer irq
    pla
    rti

nes19_tilemap
    .binary "nes19_tiles.bin"
nes19_attrmap
    .binary "nes19_attrs.bin"
nes19_palette
    .byte $0d, $11, $22, $32
    .byte $0d, $17, $37, $30
    .byte $0d, $13, $23, $33
    .byte $0d, $1b, $2b, $3b

    .send

    .section cpuvec
    .word nmiv
    .word start
    .word irqv
    .send
