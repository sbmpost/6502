// DESCRIPTION: Verilator Example: Top level main for invoking model
//
// Copyright 2003-2014 by Wilson Snyder. This program is free software; you can
// redistribute it and/or modify it under the terms of either the GNU
// Lesser General Public License Version 3 or the Perl Artistic License
// Version 2.0.

#include <verilated.h>		   // Defines common routines
#include "Vcpu.h" // From Verilating "LogisimToplevelShell.v"
#if VM_TRACE
# include <verilated_vcd_c.h>	   // Trace file format header
#endif

Vcpu *logisim;			// Instantiation of module

vluint64_t main_time = 0;	// Current simulation time (64-bit unsigned)

double sc_time_stamp () {	// Called by $time in Verilog
    return main_time;		// Note does conversion to real, to match SystemC
}

int main(int argc, char **argv, char **env) {
    if (0 && argc && argv && env) {}	// Prevent unused variable warnings
    logisim = new Vcpu;		// Create instance of module

    Verilated::commandArgs(argc, argv);
    Verilated::debug(0);

#if VM_TRACE			// If verilator was invoked with --trace
    Verilated::traceEverOn(true);	// Verilator must compute traced signals
    VL_PRINTF("Enabling waves...\n");
    VerilatedVcdC* tfp = new VerilatedVcdC;
    logisim->trace (tfp, 99);	// Trace 99 levels of hierarchy
    tfp->open ("vlt_dump.vcd");	// Open the dump file
#endif

    logisim->LOGISIM_CLOCK_TREE_0 = 0;
    logisim->R = 0;
    // logisim->passed = 0;

    while (main_time < 400 // && !logisim->passed
	&& !Verilated::gotFinish()) {

	if (main_time > 7 && (main_time % 2) == 0) {	// Toggle clock
            logisim->LOGISIM_CLOCK_TREE_0 = 0x10;
	}
	if (main_time > 7 && (main_time % 2) == 1) {	// Toggle clock
            logisim->LOGISIM_CLOCK_TREE_0 = 0x00;
	}
        if (main_time > 7 && (main_time % 8) == 0) {
            logisim->LOGISIM_CLOCK_TREE_0 = 0x14;
        }
        if (main_time > 7 && (main_time % 8) == 1) {
            logisim->LOGISIM_CLOCK_TREE_0 = 0x04;
        }

	if (main_time > 7) {
            logisim->R = 0;
	} else if (main_time == 0) {
            logisim->R = 1;
	}

	logisim->eval();		// Evaluate model
#if VM_TRACE
	if (tfp) tfp->dump (main_time);	// Create waveform trace for this timestamp
#endif
        
	VL_PRINTF ("[%" VL_PRI64 "d] clk: %x rst: %x r_a: %x\n", // _%08x_%08x\n",
          main_time,
          logisim->LOGISIM_CLOCK_TREE_0,
          logisim->R,
          logisim->R_OUT
        );

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
