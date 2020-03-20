*   = $0000

; NES 2.0 header

mapper = 69 ; FME-7 / 5B
prg_rom_size = (prg_rom_end - prg_rom) >> 14
chr_rom_size = (chr_rom_end - chr_rom) >> 13

    .byte $4e, $45, $53, $1a
    .byte <prg_rom_size
    .byte <chr_rom_size
    .byte ((mapper << 4) & $f0) | %0000
    .byte (mapper & $f0) | %1000
    .byte >mapper
    .byte (>chr_rom_size << 4) | >prg_rom_size
    .byte 9 ; 32k PRG-RAM
    .fill $10 - *, 0

prg_rom

bank0
    .logical $c000

    .fill $e000 - *, 0
    .here

home
    .logical $e000
    .dsection init

    .fill $fffa - *, 0
    .dsection cpuvec
    .here

prg_rom_end

chr_rom
    .binary "nes19.chr"
chr_rom_end
