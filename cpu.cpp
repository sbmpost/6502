#include <verilated.h>
#include "Vcpu.h"
#if VM_TRACE
# include <verilated_vcd_c.h>
#endif

Vcpu *cpu;

vluint64_t main_time = 0;	// Current simulation time (64-bit unsigned)

double sc_time_stamp () {	// Called by $time in Verilog
    return main_time;		// Note does conversion to real, to match SystemC
}

int main(int argc, char **argv, char **env) {
    if (0 && argc && argv && env) {}	// Prevent unused variable warnings
    cpu = new Vcpu;

    Verilated::commandArgs(argc, argv);
    Verilated::debug(0);

#if VM_TRACE
    Verilated::traceEverOn(true);
    VL_PRINTF("Enabling waves...\n");
    VerilatedVcdC* tfp = new VerilatedVcdC;
    cpu->trace(tfp, 99);
    tfp->open("vlt_dump.vcd");
#endif

    while (main_time < 100 && !Verilated::gotFinish()) {
        if (main_time > 1 && (main_time % 2) == 0) {
            cpu->CLK = 0x00;
        }

        if (main_time > 1 && (main_time % 2) == 1) {
            cpu->CLK = 0x01;
        }

        if (main_time == 1) {
            cpu->R = 0;
        } else if (main_time == 0) {
            cpu->R = 1;
        }

/*
    	if (main_time > 7 && (main_time % 2) == 0) {	// Toggle clock
            cpu->cpu_CLOCK_TREE_0 = 0x10;
    	}
    	if (main_time > 7 && (main_time % 2) == 1) {	// Toggle clock
            cpu->cpu_CLOCK_TREE_0 = 0x00;
    	}
        if (main_time > 7 && (main_time % 8) == 0) {
            cpu->cpu_CLOCK_TREE_0 = 0x15;
        }
        if (main_time > 7 && (main_time % 8) == 1) {
            cpu->cpu_CLOCK_TREE_0 = 0x04;
        }

    	if (main_time > 7) {
            cpu->R = 0;
    	} else if (main_time == 0) {
            cpu->R = 1;
    	}
*/

    	cpu->eval();
    #if VM_TRACE
    	if (tfp) tfp->dump (main_time);
    #endif
            
        if (cpu->CLK) {
            VL_PRINTF ("[%" VL_PRI64 "d] clk: %x r: %x addr: %04x data: %x state: %x mode: %x op: %x\n",
                main_time,
                cpu->CLK,
                cpu->R,
                cpu->addr_bus,
                cpu->data_bus,
                cpu->curr_st,
                cpu->op_amode,
                cpu->op
            );

            if (cpu->curr_st == 0x20) {
                VL_PRINTF("\n");
            }
        }
/*    	VL_PRINTF ("[%" VL_PRI64 "d] clk: %x r: %x opc: %x amode: %x group: %x addr: %04x\n",
            main_time,
            cpu->CLK,
            cpu->R,
            cpu->opcode,
            cpu->addr_mode,
            cpu->group,
            cpu->addr_bus
        );
*/
    	main_time++;
    }

    cpu->final();

#if VM_TRACE
    if (tfp) tfp->close();
#endif

/*
    if (!cpu->passed) {
	VL_PRINTF ("A Test failed\n");
	abort();
    } else {
	VL_PRINTF ("All Tests passed\n");
    }
*/

    exit(0L);
}
