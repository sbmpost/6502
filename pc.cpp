// DESCRIPTION: Verilator Example: Top level main for invoking model
//
// Copyright 2003-2014 by Wilson Snyder. This program is free software; you can
// redistribute it and/or modify it under the terms of either the GNU
// Lesser General Public License Version 3 or the Perl Artistic License
// Version 2.0.

#include <verilated.h>		   // Defines common routines
#include "Vpc.h"
#if VM_TRACE
# include <verilated_vcd_c.h>  // Trace file format header
#endif

Vpc *pc;			        // Instantiation of module

vluint64_t main_time = 0;	// Current simulation time (64-bit unsigned)

double sc_time_stamp () {	// Called by $time in Verilog
    return main_time;		// Note does conversion to real, to match SystemC
}

int main(int argc, char **argv, char **env) {
    if (0 && argc && argv && env) {}	// Prevent unused variable warnings
    pc = new Vpc;		// Create instance of module

    Verilated::commandArgs(argc, argv);
    Verilated::debug(0);

#if VM_TRACE			// If verilator was invoked with --trace
    Verilated::traceEverOn(true);	// Verilator must compute traced signals
    VL_PRINTF("Enabling waves...\n");
    VerilatedVcdC* tfp = new VerilatedVcdC;
    pc->trace (tfp, 99);	// Trace 99 levels of hierarchy
    tfp->open ("vlt_dump.vcd");	// Open the dump file
#endif

    pc->CI = 0;
    pc->LO = 0;
    pc->HI = 0;
    pc->R = 0;
    pc->WR = 0;
    pc->INC = 1;
    pc->CLK = 0;

    int counter = 0;
    bool passed = true;
    while (counter != 2*65536 && !Verilated::gotFinish() && passed) {
    	if (main_time != 0 && (main_time % 2) == 0) {
            pc->CLK = 0;
    	}

    	if (main_time != 0 && (main_time % 2) == 1) {
            pc->CLK = 1;
            if (!pc->CO) {
                counter++;
            }
    	}

    	if (main_time == 1) {
            pc->R = 0;
    	} else if (main_time == 0) {
            pc->R = 1;
    	}

    	pc->eval();		// Evaluate model
#if VM_TRACE
    	if (tfp) tfp->dump (main_time);	// Create waveform trace for this timestamp
#endif

        if (pc->CO) {
            if ((pc->PC % 256) != 0 || (counter % 256) != 0) {
                passed = false;
            }
        } else if (pc->PC != (counter % 65536)) {
            passed = false;
        }

        if (!passed || (counter > 65533 && counter < 65538)) {
            VL_PRINTF ("[%" VL_PRI64 "d] clk: %x co: %x pc: %04x counter: %04x\n",
                main_time,
                pc->CLK,
                pc->CO,
                pc->PC,
                counter
            );
        }

    	main_time++; // Time passes...
    }

    pc->final();

#if VM_TRACE
    if (tfp) tfp->close();
#endif

    if (!passed) {
    	VL_PRINTF ("A Test failed\n");
    	abort();
    } else {
    	VL_PRINTF ("All Tests passed\n");
    }

    exit(0L);
}
