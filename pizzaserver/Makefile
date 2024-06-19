#DIMS=+W1280 +H1024
#DIMS=+W1024 +H768
#DIMS=+W800 +H600
#DIMS=+W320 +H240
DIMS=+W1920 +H1080
SRC=logo.pov
OUTPUT=logo_quick.png logo.png
#OPTS=+ua

logo_quick.png: $(SRC)
	povray $(OPTS) -A -I$< -O$@ $(DIMS)

logo.png: $(SRC)
	povray $(OPTS) +A0.3 -I$< -O$@ $(DIMS)

logo_800.png: $(SRC)
	povray $(OPTS) +A0.3 -I$< -O$@ +W800 +H600

logo_1280.png: $(SRC)
	povray $(OPTS) +A0.3 -I$< -O$@ +W1280 +H1024

logo_1600.png: $(SRC)
	povray $(OPTS) +A0.3 -I$< -O$@ +W1600 +H1200

logo_1920x1080.png: $(SRC)
	povray $(OPTS) +A0.3 -I$< -O$@ +W1920 +H1080

.PHONY: clean

clean:
	rm -f $(OUTPUT)

