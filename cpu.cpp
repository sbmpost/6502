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

char * states[] = {"S00", "SOP", "SLO", "SIN", "SHI", "SCO", "SLR"};


int indexOf(int state) {
    int index = 0;
    switch(state) {
        case 1: index = 1; break;
        case 2: index = 2; break;
        case 4: index = 3; break;
        case 8: index = 4; break;
        case 16: index = 5; break;
        case 32: index = 6; break;
    }
    return index;
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
/*
            VL_PRINTF ("[%" VL_PRI64 "d] reg_a: %02x\n",
                main_time,
                cpu->reg_a
            );

*/
///*      
            VL_PRINTF ("[%" VL_PRI64 "d] addr: %04x data: %02x state: %s op: %02x alu_a: %02x lo: %02x alu: %02x reg_a: %02x\n",
                main_time,
//                cpu->R,
                cpu->addr_bus,
                cpu->data_bus,
                states[indexOf(cpu->curr_st)],
//                cpu->op_amode,
                cpu->op,
                cpu->alu_a,
                cpu->lo_byte,
                cpu->alu_out,
                cpu->reg_a
            );

            if (cpu->curr_st == 0x20) {
                VL_PRINTF("\n");
            }
//*/      
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
