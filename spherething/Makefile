TARGETS=spherething.png

.PHONY: all clean

all: $(TARGETS)

spherething.png: spherething.pov
	povray +A +I$< +O$@ +GD +FN +W1600 +H1200

clean:
	rm -f $(TARGETS)
