TARGETS=sierpinski.png

.PHONY: all clean

all: $(TARGETS)

sierpinski.png: sierpinski.pov
	povray +A +I$< +O$@ +GD +FN +W1600 +H1200

bhg-sierpinski-anim.gif: sierpinski.pov
	povray bhg-animation.ini
	ffmpeg -y -i sierpinski%02d.png -filter_complex "[0:v] palettegen" palette.tmp.png
	ffmpeg -y -i sierpinski%02d.png -i palette.tmp.png -filter_complex "[0:v] colorkey=black:0.0001:0.0001, crop=28:21:6:2 [cropped]; [cropped][1:v] paletteuse" $@
	rm -f palette.tmp.png
	rm -f sierpinski[0-9][0-9].png

clean:
	rm -f $(TARGETS)
	rm -f palette.tmp.png
	rm -f sierpinski[0-9][0-9].png
