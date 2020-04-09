AS = 64tass
FLAGS = -C -a -B -f
PYTHON = python3

.SUFFIXES:
.PHONY: all clean
.SECONDEXPANSION:
.PRECIOUS: %.2bpp %.1bpp

includes = $(PYTHON) utils/incscan.py
gfx = $(PYTHON) utils/gfx.py
sources = \
	src/bss.asm \
	src/home.asm

all: planetn3.nes

clean:
	rm -f planetn3.nes

%.asm: ;
%.png: ;

%.1bpp: %.png
	$(gfx) 1bpp $<
%.2bpp: %.png
	$(gfx) 2bpp $<

planetn3.nes: src/main.asm $(sources) $(shell $(includes) $(sources))
	$(AS) $(FLAGS) -l planetn3.lst -o $@ src/main.asm $(sources)
