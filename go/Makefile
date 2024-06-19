TARGETS=go.png

.PHONY: all clean

all: $(TARGETS)

go.png: go.pov
	povray +A +I$< +O$@ +GD +FN +W1600 +H1200

clean:
	rm -f $(TARGETS)
