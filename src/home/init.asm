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
    lda #2 ; 1-screen mirroring
    inx
    stx MAP_ADDR
    sta MAP_DATA
    lda #0 ; disable timer IRQ
    inx
    stx MAP_ADDR
    sta MAP_DATA
    lda #$40 ; inhibit APU frame IRQ
    sta JOY2

    ldx #0
    ldy #0
    ; wait until PPU is done initializing
    bit PPUSTATUS
-   bit PPUSTATUS
    bpl -
-   bit PPUSTATUS
    bpl -
    ; determine the system type by cycle counting until the next VBlank
    ; NTSC  = 29780 cycles / 12 = $9b1
    ; PAL   = 33247 cycles / 12 = $ad2
    ; Dendy = 35464 cycles / 12 = $b8b
    .page
-
    iny ; 2
    bne + ; 2/3
    inx ; 2
+   bit PPUSTATUS ; 4
    bpl - ; 3
          ; = 12 (11)
    lda #0
    cpx #$9 ; NTSC
    beq +
    lda #1
    cpx #$b ; Dendy
    beq +
    lda #3 ; PAL
+   sta z_timing
    .endp

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
    sta A0
    lda #>nes19_tilemap
    sta A0+1
    ldx #20
-
    ldy #0
-
    lda (A0), y
    sta PPUDATA
    iny
    cpy #26
    bne -
    tya
    clc
    adc A0
    sta A0
    bcc +
    inc A0+1
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

nes19_tilemap
    .binary "../nes19_tiles.bin"
nes19_attrmap
    .binary "../nes19_attrs.bin"
nes19_palette
    .byte $0d, $11, $22, $32
    .byte $0d, $17, $37, $30
    .byte $0d, $13, $23, $33
    .byte $0d, $1b, $2b, $3b
