# Project setup
PROJ      = top
BUILD     = ./build
DEVICE    = 8k
FOOTPRINT = ct256

# Files
FILES = cpu.v alu8.v alu4.v pg.v MEMORY.v

.PHONY: all compile analyze burn stats svg ps1 ps2 verilator run test clean

all: compile analyze

analyze: compile

burn: compile

run: verilator

test: verilator

compile:
	mkdir -p $(BUILD)
	yosys -p "synth_ice40 -top $(PROJ) -blif $(BUILD)/$(PROJ).blif" $(PROJ).v $(FILES)

analyze:
	arachne-pnr -d $(DEVICE) -P $(FOOTPRINT) -o $(BUILD)/$(PROJ).asc $(BUILD)/$(PROJ).blif
	icetime -d hx$(DEVICE) $(BUILD)/$(PROJ).asc

burn:
	arachne-pnr -d $(DEVICE) -P $(FOOTPRINT) -o $(BUILD)/$(PROJ).asc -p $(PROJ).pcf $(BUILD)/$(PROJ).blif
	icepack $(BUILD)/$(PROJ).asc $(BUILD)/$(PROJ).bin
	iceprog -S $(BUILD)/$(PROJ).bin

stat:
	yosys \
	-p "hierarchy -check -top cpu" \
	-p "proc; opt; onehot;" \
	-p "stat" \
	$(FILES)

svg:
	yosys -o synth.v \
	-p "hierarchy -check -top cpu" \
	-p "proc; opt; onehot" \
	-p "show -format svg -prefix .yosys_show_3 cpu" \
	$(FILES)

ps1:
	yosys -o synth.v \
	-p "hierarchy -check -top cpu" \
	-p "proc; opt; onehot" \
	-p "show -format ps -prefix .yosys_show_1 -viewer echo" \
	$(FILES)

ps2:
	yosys -o synth.v \
	-p "hierarchy -check -top cpu" \
	-p "proc; opt; onehot" \
	-p "techmap; opt" \
	-p "show -format ps -prefix .yosys_show_2 -viewer echo" \
	$(FILES)

verilator:
	verilator -CFLAGS "-DVL_DEBUG=0 -Wno-write-strings" -cc cpu.v --exe cpu.cpp
	make -j -C obj_dir -f Vcpu.mk && obj_dir/Vcpu > test_out.txt;

run:
	less test_out.txt

test:
	./test.sh

clean:
	rm -f obj_dir/*
	rm -f build/*
	rm -f synth.v
	rm -f .yosys_*.dot
	rm -f .yosys_*.ps
