.PHONY: all clean

all:
	$(MAKE) -C desk
	$(MAKE) -C go
	$(MAKE) -C pizzaserver
	$(MAKE) -C spherething

clean:
	$(MAKE) -C desk clean
	$(MAKE) -C go clean
	$(MAKE) -C pizzaserver clean
	$(MAKE) -C spherething clean

