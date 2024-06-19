TARGETS=desk.png

.PHONY: all clean

all: $(TARGETS)

desk.png: desk.pov
	povray +A +I$< +O$@ +GD +FN +W1600 +H1200

clean:
	rm -f $(TARGETS)
