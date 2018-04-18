// DESCRIPTION: Verilator Example: Top level main for invoking model
//
// Copyright 2003-2014 by Wilson Snyder. This program is free software; you can
// redistribute it and/or modify it under the terms of either the GNU
// Lesser General Public License Version 3 or the Perl Artistic License
// Version 2.0.

#include <verilated.h>		   // Defines common routines
#include "VLogisimToplevelShell.h" // From Verilating "LogisimToplevelShell.v"
#if VM_TRACE
# include <verilated_vcd_c.h>	   // Trace file format header
#endif

VLogisimToplevelShell *logisim;			// Instantiation of module

vluint64_t main_time = 0;	// Current simulation time (64-bit unsigned)

double sc_time_stamp () {	// Called by $time in Verilog
    return main_time;		// Note does conversion to real, to match SystemC
}

int main(int argc, char **argv, char **env) {
    if (0 && argc && argv && env) {}	// Prevent unused variable warnings
    logisim = new VLogisimToplevelShell;		// Create instance of module

    Verilated::commandArgs(argc, argv);
    Verilated::debug(0);

#if VM_TRACE			// If verilator was invoked with --trace
    Verilated::traceEverOn(true);	// Verilator must compute traced signals
    VL_PRINTF("Enabling waves...\n");
    VerilatedVcdC* tfp = new VerilatedVcdC;
    logisim->trace (tfp, 99);	// Trace 99 levels of hierarchy
    tfp->open ("vlt_dump.vcd");	// Open the dump file
#endif

    logisim->FPGA_GlobalClock = 0;
    logisim->FPGA_INPUT_PIN_0 = 0;
    // logisim->passed = 0;

    vluint8_t a_out = 0;
    unsigned long prev_time = 0;
    while (main_time < 250 // && !logisim->passed
	&& !Verilated::gotFinish()) {

	if (main_time > 1 && (main_time % 2) == 1) {	// Toggle clock
            logisim->FPGA_GlobalClock = 1;
	}
	if (main_time > 1 && (main_time % 2) == 0) {
            logisim->FPGA_GlobalClock = 0;
	}

	if (main_time > 1) {
            logisim->FPGA_INPUT_PIN_0 = 1; // inverted in LogisimToplevelShell.v
	} else if (main_time == 1) {
            logisim->FPGA_INPUT_PIN_0 = 0;
	}

	logisim->eval();		// Evaluate model
#if VM_TRACE
	if (tfp) tfp->dump (main_time);	// Create waveform trace for this timestamp
#endif
        
        vluint8_t a_new =
          logisim->FPGA_OUTPUT_PIN_0 |
          logisim->FPGA_OUTPUT_PIN_1 << 1 |
          logisim->FPGA_OUTPUT_PIN_2 << 2 |
          logisim->FPGA_OUTPUT_PIN_3 << 3 |
          logisim->FPGA_OUTPUT_PIN_4 << 4 |
          logisim->FPGA_OUTPUT_PIN_5 << 5 |
          logisim->FPGA_OUTPUT_PIN_6 << 6 |
          logisim->FPGA_OUTPUT_PIN_7 << 7;

if(logisim->FPGA_INPUT_PIN_0 && a_new != a_out || main_time < 6) {
	VL_PRINTF ("[%" VL_PRI64 "d] clk: %x rst: %x r_a: %x dur: %ld\n", // _%08x_%08x\n",
          main_time,
          logisim->FPGA_GlobalClock,
          !logisim->FPGA_INPUT_PIN_0,
          a_new,
          (main_time - prev_time) / 8
        );

        prev_time = main_time;
        a_out = a_new;
}

	// logisim->fastclk = !logisim->fastclk;
	main_time++;		// Time passes...
    }

    logisim->final();

#if VM_TRACE
    if (tfp) tfp->close();
#endif

/*
    if (!logisim->passed) {
	VL_PRINTF ("A Test failed\n");
	abort();
    } else {
	VL_PRINTF ("All Tests passed\n");
    }
*/

    exit(0L);
}
