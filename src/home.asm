    .include "hw.asm"

    .section home
    .include "home/init.asm"
    .include "home/vectors.asm"
    .send

    .section cpuvec
    .word nmiv
    .word start
    .word irqv
    .send
