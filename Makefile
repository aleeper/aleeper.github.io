.PHONY : all

all:
	cd jemdoc && $(MAKE)
	cd research/jemdoc && $(MAKE)
	cd music/jemdoc && $(MAKE)

