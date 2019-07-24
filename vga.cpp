#include <verilated.h>
#include "Vvga.h"
#if VM_TRACE
#include <verilated_vcd_c.h>
#endif

Vvga *vga;

unsigned main_time = 0;

double sc_time_stamp () {	// Called by $time in Verilog
    return main_time;		// Note does conversion to real, to match SystemC
}


int main(int argc, char **argv, char **env) {
    if (0 && argc && argv && env) {}	// Prevent unused variable warnings
    vga = new Vvga;

    Verilated::commandArgs(argc, argv);
    Verilated::debug(0);

#if VM_TRACE
    Verilated::traceEverOn(true);
    VL_PRINTF("Enabling waves...\n");
    VerilatedVcdC* tfp = new VerilatedVcdC;
    cpu->trace(tfp, 99);
    tfp->open("vlt_dump.vcd");
#endif

    while (main_time < (2*800*525)+2 && !Verilated::gotFinish()) {
        vga->eval();

        if ((main_time % 2) == 0) {
            vga->hwclk = 0x00;
        }

        if ((main_time % 2) == 1) {
            vga->hwclk = 0x01;
        }

    #if VM_TRACE
    	if (tfp) tfp->dump (main_time);
    #endif
        if (vga->hwclk) {
            VL_PRINTF ("%03d clk:%03d l1:%d l2:%d l3:%d l4:%d "
                "l5:%d l6:%d l7:%d l8:%d r_x:%02d r_y:%02d\n",
                main_time,
                vga->hwclk,
                vga->led1,
                vga->led2,
                vga->led3,
                vga->led4,
                vga->led5,
                vga->led6,
                vga->led7,
                vga->led8,
                vga->x,
                vga->y
//                vga->r,
//                vga->g,
//                vga->b
            );
        }

    	main_time++;
    }

    vga->final();

#if VM_TRACE
    if (tfp) tfp->close();
#endif

    exit(0L);
}
