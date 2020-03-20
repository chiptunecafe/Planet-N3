AS = 64tass
FLAGS = -C -a -B -f
PYTHON = python3

.SUFFIXES:
.PHONY: all clean
.SECONDEXPANSION:
.PRECIOUS: %.4bpp %.2bpp %.1bpp

includes = $(PYTHON) utils/incscan.py
gfx = $(PYTHON) utils/gfx.py
sources = \
	init.asm

all: planetn3.nes

clean:
	rm -f planetn3.nes

%.asm: ;
%.png: ;

%.1bpp: %.png
	$(gfx) 1bpp $<
%.2bpp: %.png
	$(gfx) 2bpp $<

planetn3.nes: main.asm $(sources) $(shell $(includes) $(sources))
	$(AS) $(FLAGS) -l planetn3.lst -o $@ main.asm $(sources)
