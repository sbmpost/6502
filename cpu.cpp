#include <verilated.h>
#include "Vcpu.h"
#if VM_TRACE
#include <verilated_vcd_c.h>
#endif

Vcpu *cpu;

unsigned main_time = 0;

double sc_time_stamp () {	// Called by $time in Verilog
    return main_time;		// Note does conversion to real, to match SystemC
}

char * states[] = {"S00", "SOP", "SLO", "SIN", "SHI", "SCA", "SCS", "SWD", "SLR"};

char * instructions[] = {
    "LDX #07",
    "LDY #08",
    "LDA $00ff,y",
    "LDA $0108,y",
    "LDA $01f0,x",
    "LDA $30,x",
    "LDA $40,x",
    "LDA $ff,x",
    "LDA $0110",
    "LDA $37",
    "LDA ($1e),y",
    "JMP $0021",
    "STA $0108,y",
    "LDA #19",
    "LDA $0108,y",
    "LDA #20",
    "STA $00ff,x",
    "LDA #21",
    "LDA $00ff,x",
    "JMP $0305",
    "INX",
    "INY",
    "DEX",
    "DEY",
    "JMP ($02ff)",
    "TXA",
    "TYA",
    "TAX",
    "INY",
    "TAY",
    "INY",
    "ORA $02f7,x",
    "AND $0b",
    "EOR ($1e),y",
    "ADC #08",
    "ADC $02fc,x",
    "SBC #44",
    "CPY $01",
    "CPX $0304",
    "CMP ($1e),y",
    "INC $02ff",
    "LDX $02ff",
    "DEC $08,x",
    "LDA #81",
    "LSR A",
    "ROL A",
    "ASL A",
    "ROR A",
    "LDY $08,x",
    "LSR $08,x",
    "LDY $08,x",
    "ASL $08,x",
    "LDY $08,x",
    "ROR $08,x",
    "LDY $08,x",
    "ROL $08,x",
    "LDY $08,x",
    "SEC",
    "CLC",
    "CLV",
    "BVS $02",
    "BVC $82",
    "LDX $01ab,y",
    "STX $77,y",
    "DEX",
    "LDA ($20,x)",
    "BVC $74",
    "INX",
    "DEX",
    "LDA #01",
    "TXA",
    "TSX",
    "NOP",
    "PHP",
    "PHA",
    "PLP",
    "PLA",
    "NOP",
    "JSR $0364",
    "NOP",
    "RTS",
    "JMP $0366",
    "NOP"
};

int indexOf(int state) {
    int index = 0;
    switch(state) {
        case 0x01: index = 0; break;
        case 0x02: index = 1; break;
        case 0x04: index = 2; break;
        case 0x08: index = 3; break;
        case 0x10: index = 4; break;
        case 0x20: index = 5; break;
        case 0x40: index = 6; break;
        case 0x80: index = 7; break;
        case 0x100: index = 8; break;
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

    int instruction = 0;
//    while (main_time < 137615200 && !Verilated::gotFinish()) {
//    while (main_time < 137615142 && !Verilated::gotFinish()) {
//    while (main_time < 300000 && !Verilated::gotFinish()) {
    while (main_time < 519 && !Verilated::gotFinish()) {
        cpu->eval();

        if (/*main_time > 1 && */(main_time % 2) == 0) {
            cpu->CLK = 0x00;
        }

        if (/*main_time > 1 && */(main_time % 2) == 1) {
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

    #if VM_TRACE
    	if (tfp) tfp->dump (main_time);
    #endif
        if (cpu->CLK) {
            if (cpu->curr_st == 0x02 && cpu->op != 0x00 && cpu->op != 0xfc &&
                instruction < sizeof(instructions)/sizeof(char *))
//                VL_PRINTF("\nNEW\n");
                VL_PRINTF("\n%s\n", instructions[instruction++]);

            VL_PRINTF ("%03d adr:%04x out:%02x in:%02x wr:%01x st:%s "
                "pc_i:%01x pc_o:%04x pc_wr:%01x op:%02x a_op:%02x a_ci:%01x "
                "a_a:%02x a_b:%02x a_out:%02x r_p:%02x r_x:%02x r_y:%02x r_a:%02x r_s:%02x\n",
                main_time,
                cpu->addr_bus,
                cpu->data_out,
                cpu->data_in,
                cpu->data_write,
                states[indexOf(cpu->curr_st)],
                cpu->pc_inc,
                cpu->pc_out,
                cpu->pc_write,
                cpu->op,
                cpu->alu_op,
                cpu->alu_cin,
                cpu->alu_a,
                cpu->alu_b,
                cpu->alu_out,
                cpu->reg_p,
                cpu->reg_x,
                cpu->reg_y,
                cpu->reg_a,
                cpu->reg_s
            );
        }

    	main_time++;
    }

    cpu->final();

#if VM_TRACE
    if (tfp) tfp->close();
#endif

    exit(0L);
}
