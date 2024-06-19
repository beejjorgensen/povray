# mencoder "mf://*.png" -mf fps=24 -o output.avi -ovc lavc -lavcopts vcodec=mpeg4:vbitrate=1000
#
# for a in logo*.png; do convert $a `basename $a .png`.gif; done
# gifsicle --colors 256 --loopcount=0 --delay=6 -O2 logo[0-9]*.gif > logoanim.gif

#DIMS=+W1280 +H1024
#DIMS=+W1024 +H768
#DIMS=+W800 +H600
DIMS=+W320 +H240
#DIMS=+W160 +H120
SRC=../logo.pov
#OUTPUT=logo_quick.png logo.png
#OPTS=+ua
ANIMOPTS=+KFF240 +KC

.PHONY: anim

anim:
	#povray $(OPTS) $(ANIMOPTS) -A -I $(SRC) $(DIMS)
	povray $(OPTS) $(ANIMOPTS) +A0.3 -I $(SRC) $(DIMS)

.PHONY: clean

clean:
	rm -f logo[0-9]*.png

