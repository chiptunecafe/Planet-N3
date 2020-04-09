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
