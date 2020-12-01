.PHONY : all

all:
	cd jemdoc && $(MAKE)
	cd research/jemdoc && $(MAKE)
	cd simulation/jemdoc && $(MAKE)
	cd music/jemdoc && $(MAKE)

