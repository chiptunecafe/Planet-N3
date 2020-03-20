; NES hardware registers

; PPU
PPUCTRL     = $2000
PPUMASK     = $2001
PPUSTATUS   = $2002
OAMADDR     = $2003
OAMDATA     = $2004
PPUSCROLL   = $2005
PPUADDR     = $2006
PPUDATA     = $2007

; APU
SQ1_VOL     = $4000
SQ1_SWEEP   = $4001
SQ1_LO      = $4002
SQ1_HI      = $4003
SQ2_VOL     = $4004
SQ2_SWEEP   = $4005
SQ2_LO      = $4006
SQ2_HI      = $4007
TRI_LINEAR  = $4008
TRI_LO      = $400a
TRI_HI      = $400b
NOISE_VOL   = $400c
NOISE_LO    = $400e
NOISE_HI    = $400f
DMC_FREQ    = $4010
DMC_RAW     = $4011
DMC_START   = $4012
DMC_LEN     = $4013
OAMDMA      = $4014
SND_CHN     = $4015
JOY1        = $4016
JOY2        = $4017

; FME-7 / 5B
MAP_ADDR    = $8000
MAP_DATA    = $a000
AY_ADDR     = $c000
AY_DATA     = $e000

MAP_CHR_00  = $0
MAP_CHR_04  = $1
MAP_CHR_08  = $2
MAP_CHR_0C  = $3
MAP_CHR_10  = $4
MAP_CHR_14  = $5
MAP_CHR_18  = $6
MAP_CHR_1C  = $7
MAP_PRG_60  = $8
MAP_PRG_80  = $9
MAP_PRG_A0  = $a
MAP_PRG_C0  = $b
MAP_MIRROR  = $c
MAP_TIM_IRQ = $d
MAP_TIM_LO  = $e
MAP_TIM_HI  = $f

; AY
AY_A_LO     = $0
AY_A_HI     = $1
AY_B_LO     = $2
AY_B_HI     = $3
AY_C_LO     = $4
AY_C_HI     = $5
AY_NOISE    = $6
AY_ENABLE   = $7
AY_A_VOL    = $8
AY_B_VOL    = $9
AY_C_VOL    = $a
AY_ENV_LO   = $b
AY_ENV_HI   = $c
AY_ENV_WAVE = $d
AY_IOA      = $e
AY_IOB      = $f
