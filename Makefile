# Project setup
PROJ      = cpu
BUILD     = ./build
DEVICE    = 8k
FOOTPRINT = ct256

# Files
FILES = cpu.v alu8.v alu4.v pg.v MEMORY.v

.PHONY: all burn clean

all:
	# if build folder doesn't exist, create it
	mkdir -p $(BUILD)
	# synthesize using Yosys
	yosys -p "synth_ice40 -top $(PROJ) -blif $(BUILD)/$(PROJ).blif" $(FILES)
	# yosys -p "hierarchy -check -top cpu; proc; stat" $(FILES)
	# yosys -o synth.v \
	# -p "hierarchy -check -top cpu" \
	# -p "proc; opt" \
	# -p "show -format ps -prefix .yosys_show_1 -viewer echo" \
	# -p "techmap; opt" \
	# -p "show -format ps -prefix .yosys_show_2 -viewer echo" \
	# $(FILES)

burn:
	arachne-pnr -d $(DEVICE) -P $(FOOTPRINT) -o $(BUILD)/$(PROJ).asc $(BUILD)/$(PROJ).blif
	# arachne-pnr -d $(DEVICE) -P $(FOOTPRINT) -o $(BUILD)/$(PROJ).asc -p $(PROJ).pcf $(BUILD)/$(PROJ).blif
	icetime -d hx$(DEVICE) $(BUILD)/$(PROJ).asc
	# iceprog -S $(BUILD)/$(PROJ).bin

clean:
	rm build/*
