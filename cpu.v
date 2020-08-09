// copyright by sbmpost

// todo: consider use $display
// todo: consider pla decoder
// todo: sl by adding to itself?
// todo: improve alu_overflow logic
// todo: simplify alu_op logic
// todo: reg_s should be setup by the code?
// todo: implement remaining 2 instructions
// todo: implement decimal mode?
// todo: sync logisim circuit?

module cpu(
  input CLK,
  input R,
  output[2:0] opcode,
  output[2:0] op_amode,
  output[1:0] op_group,
  output[15:0] addr_bus,
  output[7:0] data_out,
  output[7:0] data_in,
  output data_write,
  output[7:0] curr_st,
  output pc_inc,
  output[15:0] pc_out,
  output pc_write,
  output[7:0] op,
  output[6:0] alu_op,
  output alu_cin,
  output[7:0] alu_a,
  output[7:0] alu_b,
  output[7:0] alu_out,
  output[7:0] reg_s,
  output[7:0] reg_p,
  output[7:0] reg_x,
  output[7:0] reg_y,
  output led1,
  output led2,
  output led3,
  output led4,
  output led5,
  output led6,
  output led7,
  output led8
);

  assign led1 = reg_a[0];
  assign led2 = reg_a[1];
  assign led3 = reg_a[2];
  assign led4 = reg_a[3];
  assign led5 = reg_a[4];
  assign led6 = reg_a[5];
  assign led7 = reg_a[6];
  assign led8 = reg_a[7];

  // cpu states
  parameter st_initial    = 8'b00000000; // 0x00
  parameter st_new_op     = 8'b00000001; // 0x01
  parameter st_lo_byte    = 8'b00000010; // 0x02
  parameter st_indirect   = 8'b00000100; // 0x04
  parameter st_hi_byte    = 8'b00001000; // 0x08
  parameter st_carry_add  = 8'b00010000; // 0x10
  parameter st_carry_sub  = 8'b00100000; // 0x20
  parameter st_write_data = 8'b01000000; // 0x40
  parameter st_load_reg   = 8'b10000000; // 0x80

  // bits in reg_p
  parameter bit_negative  = 7; // 0x80
  parameter bit_overflow  = 6; // 0x40
  // parameter bit_ignored   = 5; // 0x20
  // parameter bit_break     = 4; // 0x10
  parameter bit_decimal   = 3; // 0x08
  parameter bit_interrupt = 2; // 0x04
  parameter bit_zero      = 1; // 0x02
  parameter bit_carry     = 0; // 0x01

  // bits in a_mode
  parameter bit_id = 2; // indexed (i)
  parameter bit_ab = 1; // absolute (a)
  parameter bit_xy = 0; // x/y reg (x)

  //                     iax
  parameter zp_x_in = 3'b000;
  parameter imm     = 3'b010;
  parameter zp_y_in = 3'b100;
  parameter zp      = 3'b001;
  // parameter ab_y    = 3'b110;
  // parameter ab      = 3'b011;
  // parameter zp_x    = 3'b101;
  // parameter ab_x    = 3'b111;

  // nr of addressing modes
  parameter group8 = 2'b01;
  parameter group6 = 2'b10;
  parameter group5 = 2'b00;

  wire amode_zpx_indirect = op_group == group8 && op_amode == zp_x_in;
  wire amode_zpy_indirect = op_group == group8 && op_amode == zp_y_in;
  wire amode_zp_indirect = amode_zpx_indirect || amode_zpy_indirect;
  wire lo_addr_from_data_out = op_amode == zp || amode_zp_indirect;
  wire hi_addr_from_data_out = op_amode[bit_ab] || amode_zp_indirect;
  wire accumulator = op_group == group6 && op_amode == imm;
  wire[2:0] immediate = op_group == group8 ? imm : zp_x_in;

  reg[7:0] curr_st;
  reg[7:0] reg_o;
  reg[7:0] reg_l;
  reg[7:0] reg_x;
  reg[7:0] reg_y;
  reg[7:0] reg_a;
  reg[7:0] reg_p;
  reg[7:0] reg_s;
  reg[15:0] prev_addr;

  wire[7:0] data_out;

  wire[7:0] op       = curr_st == st_new_op ? data_out : reg_o;
  wire[2:0] opcode   = op[7:5];
  wire[2:0] op_amode = op[4:2];
  wire[1:0] op_group = op[1:0];
  wire[3:0] op_lo    = op[3:0];
  wire[3:0] op_hi    = op[7:4];

  // -----------------instruction decoding (consider using PLA instead)-----------------
  // 0x0 = 0000  0x8 = 1000
  // 0x1 = 0001  0x9 = 1001
  // 0x2 = 0010  0xA = 1010
  // 0x3 = 0011  0xB = 1011
  // 0x4 = 0100  0xC = 1100
  // 0x5 = 0101  0xD = 1101
  // 0x6 = 0110  0xE = 1110
  // 0x7 = 0111  0xF = 1111

  wire hi_0_or_1_or_2_or_3 = op_hi[3:2] == 2'b00;
  wire hi_4_or_5_or_6_or_7 = op_hi[3:2] == 2'b01;
  wire hi_8_or_9_or_A_or_B = op_hi[3:2] == 2'b10;
  wire hi_C_or_D_or_E_or_F = op_hi[3:2] == 2'b11;

  wire hi_0_or_1 = hi_0_or_1_or_2_or_3 && op_hi[1] == 1'b0;
  wire hi_2_or_3 = hi_0_or_1_or_2_or_3 && op_hi[1] == 1'b1;
  wire hi_4_or_5 = hi_4_or_5_or_6_or_7 && op_hi[1] == 1'b0;
  wire hi_6_or_7 = hi_4_or_5_or_6_or_7 && op_hi[1] == 1'b1;
  wire hi_8_or_9 = hi_8_or_9_or_A_or_B && op_hi[1] == 1'b0;
  wire hi_A_or_B = hi_8_or_9_or_A_or_B && op_hi[1] == 1'b1;
  // wire hi_8_or_A = hi_8_or_9_or_A_or_B && op_hi[0] == 1'b0;
  wire hi_9_or_B = hi_8_or_9_or_A_or_B && op_hi[0] == 1'b1;
  wire hi_9_or_A = hi_8_or_9_or_A_or_B && op_hi[0] ^ op_hi[1];
  wire hi_C_or_D = hi_C_or_D_or_E_or_F && op_hi[1] == 1'b0;
  wire hi_E_or_F = hi_C_or_D_or_E_or_F && op_hi[1] == 1'b1;

  wire lo_0 = op_lo == 4'h0;
  wire lo_8 = op_lo == 4'h8;
  wire lo_A = op_lo == 4'hA;
  wire lo_C = op_lo == 4'hC;

  // in terms of or's above?
  wire hi_0 = op_hi == 4'h0;
  wire hi_2 = op_hi == 4'h2;
  wire hi_4 = op_hi == 4'h4;
  wire hi_6 = op_hi == 4'h6;
  wire hi_8 = op_hi == 4'h8;
  wire hi_9 = op_hi == 4'h9;
  wire hi_A = op_hi == 4'hA;
  wire hi_B = op_hi == 4'hB;
  wire hi_C = op_hi == 4'hC;
  wire hi_E = op_hi == 4'hE;

  wire lo_1_or_5_or_9_or_D = op_lo[1:0] == 2'b01;
  wire lo_0_or_4_or_8_or_C = op_lo[1:0] == 2'b00;
  wire lo_2_or_6_or_A_or_E = op_lo[1:0] == 2'b10;
  wire lo_0_or_4_or_C = lo_0_or_4_or_8_or_C && ~lo_8;
  wire lo_4_or_C = lo_0_or_4_or_C && ~lo_0;
  wire lo_6_or_E = op_lo[2:0] == 3'b110;
  wire lo_8_or_A = lo_8 || lo_A;

  wire instr_ora     = hi_0_or_1 && lo_1_or_5_or_9_or_D;           // 1
  wire instr_and     = hi_2_or_3 && lo_1_or_5_or_9_or_D;           // 1
  wire instr_eor     = hi_4_or_5 && lo_1_or_5_or_9_or_D;           // 1
  wire instr_adc     = hi_6_or_7 && lo_1_or_5_or_9_or_D;           // 1
  wire instr_sbc     = hi_E_or_F && lo_1_or_5_or_9_or_D;           // 1
  wire instr_load    = hi_A_or_B && ~lo_8_or_A && ~instr_branch;   // 3
  wire instr_store   = hi_8_or_9 && ~lo_8_or_A && ~instr_branch;   // 3
  wire instr_txa     = hi_8 && lo_A;                               // 1
  wire instr_tax     = hi_A && lo_A;                               // 1
  wire instr_txs     = hi_9 && lo_A;                               // 1
  wire instr_tsx     = hi_B && lo_A;                               // 1
  wire instr_tya     = hi_9 && lo_8;                               // 1
  wire instr_tay     = hi_A && lo_8;                               // 1
  wire instr_incx    = hi_E && lo_8;                               // 1
  wire instr_incy    = hi_C && lo_8;                               // 1
  wire instr_decx    = hi_C && lo_A;                               // 1
  wire instr_decy    = hi_8 && lo_8;                               // 1
  wire instr_asl     = hi_0_or_1 && lo_2_or_6_or_A_or_E;           // 1
  wire instr_rol     = hi_2_or_3 && lo_2_or_6_or_A_or_E;           // 1
  wire instr_lsr     = hi_4_or_5 && lo_2_or_6_or_A_or_E;           // 1
  wire instr_ror     = hi_6_or_7 && lo_2_or_6_or_A_or_E;           // 1
  wire instr_cmp     = hi_C_or_D && lo_1_or_5_or_9_or_D;           // 1
  wire instr_cpx     = hi_E && lo_0_or_4_or_C;                     // 1
  wire instr_cpy     = hi_C && lo_0_or_4_or_C;                     // 1
  wire instr_bit     = hi_2 && lo_4_or_C;                          // 1
  wire instr_nop     = hi_E && lo_A;                               // 1
  wire instr_php     = hi_0 && lo_8;                               // 1
  wire instr_plp     = hi_2 && lo_8;                               // 1
  wire instr_pha     = hi_4 && lo_8;                               // 1
  wire instr_pla     = hi_6 && lo_8;                               // 1

  wire instr_push = instr_php || instr_pha;
  wire instr_pull = instr_plp || instr_pla;

  // Change program counter
  // wire instr_brk = hi_0 && lo_0;
  wire instr_jsr = hi_2 && lo_0;                                   // 1
  // wire instr_rti = hi_4 && lo_0;
  wire instr_rts = hi_6 && lo_0;                                   // 1
  wire instr_jmpabs  = hi_4 && lo_C;                               // 1
  wire instr_jmpind  = hi_6 && lo_C;
  wire instr_branch  = op_hi[0] == 1'b1 && lo_0;                   // 8
  wire instr_jump    = instr_jmpabs || instr_jsr || instr_jmpind;

  // Set/Clear bits in reg_p
  wire instr_setflag = op_hi[0] == 1'b1 && ~hi_9 && lo_8;          // 7

  // m2m (group6)
  wire instr_incmem  = hi_E_or_F && lo_6_or_E;                     // 1
  wire instr_decmem  = hi_C_or_D && lo_6_or_E;                     // 1
                                                                   // tot: 54
  // m2m/a2a (group6, accumulator mode indicates A2A)
  wire instr_shl     = instr_asl || instr_rol;
  wire instr_shr     = instr_lsr || instr_ror;
  wire instr_shift   = instr_shl || instr_shr;
  wire instr_rotate  = instr_rol || instr_ror;
  wire instr_sh_acc  = instr_shift && accumulator;
  wire instr_sh_mem  = instr_shift && ~accumulator;

  // r2r
  wire instr_incxy   = instr_incx || instr_incy;
  wire instr_decxy   = instr_decx || instr_decy;
  wire instr_trans   = hi_8_or_9_or_A_or_B && lo_A || hi_9_or_A && lo_8;

  wire instr_r2r     = instr_incxy || instr_decxy || instr_trans || instr_sh_acc;
  wire instr_wrmem   = instr_store || instr_incmem || instr_decmem || instr_sh_mem;

  // mr2p (cmp: group8, cpx/cpy/bit: group5)
  wire instr_compare = instr_cmp || instr_cpx || instr_cpy;

  // ma2a (group8)
  wire instr_acc     = instr_ora || instr_and || instr_eor ||
                       instr_adc || instr_sbc || instr_compare;

  // m2r (lda: group8, ldy/sty: group5, ldx/stx: group6)

  // REMAINING: brk, rti                                           // tot: 2
  // -----------------------------------------------------------------------------------

  wire pc_inc =
    curr_st == st_initial ||
    curr_st == st_new_op && ~instr_r2r && ~instr_push && ~instr_pull ||
    curr_st == st_hi_byte && (op_amode[bit_ab] || instr_branch || instr_rts) ||
    curr_st == st_carry_add && instr_branch ||
    curr_st == st_carry_sub && instr_branch ||
    curr_st == st_load_reg;

  wire pc_write =
    curr_st == st_hi_byte && (instr_jmpabs || instr_branch || instr_rts) ||
    curr_st == st_carry_add && instr_branch ||
    curr_st == st_carry_sub && instr_branch ||
    curr_st == st_load_reg && instr_jump;

  reg[15:0] pc_out;
  always @(posedge CLK or posedge R) begin
    if (R)
      pc_out <= 16'h0000; // 16'h0400;
    else
      pc_out <= (pc_write ? addr_bus : pc_out) + { 15'b0, pc_inc };
  end

  reg[15:0] addr_bus;
  always @(*) begin
    case (curr_st)
      st_new_op: begin
        if (instr_push || instr_pull || instr_rts)
          addr_bus = { 8'h01, alu_out };
        else
          addr_bus = pc_out;
      end
      st_lo_byte: begin
        case (1'b1) // synopsys parallel_case
          instr_rts: addr_bus = { 8'h01, alu_out };
          lo_addr_from_data_out: addr_bus = { 8'h00, alu_out };
          default: addr_bus = pc_out;
        endcase
      end
      st_indirect: begin
        if (instr_jsr)
          addr_bus = { data_out, alu_out };
        else
          addr_bus = { 8'h00, alu_out };
      end
      st_hi_byte: begin
        case (1'b1) // synopsys parallel_case
          instr_jsr: addr_bus = { 8'h01, alu_out };
          instr_branch: addr_bus = { prev_addr[15:8], alu_out };
          instr_rts,
          hi_addr_from_data_out: addr_bus = { data_out, alu_out };
          default: addr_bus = { 8'h00, alu_out};
        endcase
      end
      st_carry_add,
      st_carry_sub: begin
        addr_bus = { alu_out, prev_addr[7:0] };
      end
      st_write_data: begin
        case (1'b1) // synopsys parallel_case
          instr_jmpind: addr_bus = { prev_addr[15:8], alu_out };
          instr_jsr: addr_bus = { 8'h01, alu_out };
          instr_wrmem: addr_bus = prev_addr;
          default: addr_bus = pc_out;
        endcase
      end
      st_load_reg: begin
        case (1'b1) // synopsys parallel_case
          instr_jmpind: addr_bus = { data_out, alu_out };
          instr_jsr: addr_bus = prev_addr;
          default: addr_bus = pc_out;
        endcase
      end
      default: begin
        addr_bus = pc_out;
      end
    endcase
  end

  reg[7:0] reg_xya;
  always @(*) begin
    case (op_group)
      group6: begin
        if (instr_shift)
          reg_xya = reg_a;
        else
          reg_xya = reg_x;
      end
      group5: begin
        if (hi_E)
          reg_xya = reg_x;
        else
          reg_xya = reg_y;
      end
      default: begin
        reg_xya = reg_a;
      end
    endcase
  end

  reg[7:0] data_in;
  always @(*) begin
    case (1'b1) // synopsys parallel_case
      instr_store: data_in = reg_xya;
      instr_php: data_in = reg_p | 8'h30;
      instr_pha: data_in = reg_a;
      instr_jsr: begin
        if (curr_st == st_hi_byte)
          data_in = pc_out[15:8];
        else
          data_in = pc_out[7:0];
      end
      default: data_in = alu_out;
    endcase
  end

  wire data_write = curr_st == st_new_op && instr_push ||
    (curr_st == st_carry_add || curr_st == st_write_data) && instr_wrmem ||
    (curr_st == st_hi_byte || curr_st == st_write_data) && instr_jsr;

  MEMORY mem(
    .CLK(CLK),
    .WE(data_write),
    .Address(addr_bus),
    .DataIn(data_in),
    .DataOut(data_out)
  );

  wire alu_cout;
  wire[7:0] alu_out;

  // sl, sr, mode, s3-s0
  parameter alu_op_or = 7'b0000001;
  parameter alu_op_and = 7'b0000100;
  parameter alu_op_eor = 7'b0001001;
  parameter alu_op_adc = 7'b0011001;
  parameter alu_op_sbc = 7'b0010110;

  reg[6:0] alu_op;
  always @(*) begin
    case (1'b1) // synopsys parallel_case
      curr_st == st_carry_add && instr_branch: alu_op = alu_op_adc;
      curr_st == st_carry_sub && instr_branch: alu_op = alu_op_sbc;
      curr_st == st_write_data: begin
        case (1'b1) // synopsys parallel_case
          instr_decmem || instr_jsr: alu_op = alu_op_sbc;
          instr_shift: alu_op = { instr_shl, instr_shr, 5'b00000 };
          default: alu_op = alu_op_adc;
        endcase
      end
      curr_st == st_load_reg: begin
        case (1'b1) // synopsys parallel_case
          instr_jsr: alu_op = alu_op_sbc;
          instr_decxy: alu_op = alu_op_sbc;
          instr_ora: alu_op = alu_op_or;
          instr_and || instr_bit: alu_op = alu_op_and;
          instr_eor: alu_op = alu_op_eor;
          instr_sbc || instr_compare: alu_op = alu_op_sbc;
          instr_shift: alu_op = { instr_shl, instr_shr, 5'b00000 };
          instr_push: alu_op = alu_op_sbc;
          default: alu_op = alu_op_adc;
        endcase
      end
      default: alu_op = alu_op_adc;
    endcase
  end

  reg[7:0] reg_xyas;
  always @(*) begin
    case (1'b1) // synopsys parallel_case
      instr_txa || instr_txs: reg_xyas = reg_x;
      instr_tya: reg_xyas = reg_y;
      instr_tsx: reg_xyas = reg_s;
      default: reg_xyas = reg_a;
    endcase
  end

  reg[7:0] alu_a;
  always @(*) begin
    if (instr_r2r && ~instr_trans) begin
      alu_a = reg_xya;
    end
    else begin
      case (curr_st)
        st_new_op: begin
          alu_a = reg_s;
        end
        st_lo_byte: begin
          if (lo_addr_from_data_out)
            alu_a = data_out;
          else
            alu_a = reg_s;
        end
        st_hi_byte: begin
          case (1'b1) // synopsys parallel_case
            instr_branch: alu_a = prev_addr[7:0];
            instr_jsr: alu_a = reg_s;
            default: alu_a = reg_l;
          endcase
        end
        st_write_data: begin
          case (1'b1) // synopsys parallel_case
            instr_jmpind: alu_a = prev_addr[7:0];
            instr_wrmem: alu_a = data_out;
            default: alu_a = reg_s;
          endcase
        end
        st_load_reg: begin
          case (1'b1) // synopsys parallel_case
            instr_load || instr_pla: alu_a = data_out;
            instr_acc: alu_a = reg_xya;
            instr_trans: alu_a = reg_xyas;
            instr_bit: alu_a = reg_a;
            instr_push || instr_jsr: alu_a = reg_s;
            instr_jmpind: alu_a = reg_l;
            default: alu_a = reg_s;
          endcase
        end
        default: begin
          alu_a = reg_l;
        end
      endcase
    end
  end

  reg[7:0] alu_b;
  always @(*) begin
    case (curr_st)
      st_lo_byte: begin
        if (amode_zpx_indirect)
          alu_b = reg_x;
        else
          alu_b = 8'h00;
      end
      st_indirect: begin
        if (amode_zpx_indirect)
          alu_b = reg_x;
        else
          alu_b = 8'h00;
      end
      st_hi_byte: begin
        case (1'b1) // synopsys parallel_case
          instr_branch: alu_b = data_out;
          op_amode[bit_id]: begin
            if (op_amode[bit_xy] && ~(hi_9_or_B && lo_6_or_E))
              alu_b = reg_x;
            else
              alu_b = reg_y;
          end
          default: alu_b = 8'h00;
        endcase
      end
      st_load_reg: begin
        if (instr_acc || instr_bit)
          alu_b = data_out;
        else
          alu_b = 8'h00;
      end
      default: begin
        alu_b = 8'h00;
      end
    endcase
  end

  wire alu_cin =
    curr_st == st_new_op && (instr_pull || instr_rts) ||
    curr_st == st_lo_byte && instr_rts ||
    curr_st == st_indirect && amode_zp_indirect ||
    curr_st == st_hi_byte && (instr_branch || instr_rts) ||
    curr_st == st_carry_add ||
    curr_st == st_write_data && (instr_incmem || instr_jmpind ||
      (reg_p[bit_carry] && instr_rotate)) ||
    curr_st == st_load_reg && (instr_incxy || instr_compare ||
      (reg_p[bit_carry] && (instr_adc || instr_sbc || instr_rotate))
    );

  alu8 alu_1(
    .A(alu_a),
    .B(alu_b),
    .CI(alu_cin),
    .OP(alu_op),
    .CO(alu_cout),
    .F(alu_out)
  );

  wire alu_zero = alu_out == 8'h00;
  wire alu_negative = alu_out[7];
  wire alu_overflow =
    instr_adc && (
      ~alu_a[7] && ~alu_b[7] && alu_out[7] ||
      alu_a[7] && alu_b[7] && ~alu_out[7]
    ) ||
    instr_sbc && (
      ~alu_a[7] && alu_b[7] && alu_out[7] ||
      alu_a[7] && ~alu_b[7] && ~alu_out[7]
    );

  reg[7:0] st_load_or_write;
  always @(*) begin
    if (instr_wrmem || instr_jump)
      st_load_or_write = st_write_data;
    else
      st_load_or_write = st_load_reg;
  end

  reg branch_test_bit;
  always @(*) begin
    case (op_hi[3:2])
      2'b00: branch_test_bit = reg_p[bit_negative];
      2'b01: branch_test_bit = reg_p[bit_overflow];
      2'b10: branch_test_bit = reg_p[bit_carry];
      2'b11: branch_test_bit = reg_p[bit_zero];
    endcase
  end

  always @(posedge CLK or posedge R) begin
    if (R) begin
      curr_st <= st_initial;
    end
    else
      case (curr_st)
        st_initial: begin                              curr_st <= st_new_op;
        end
        st_new_op: begin
          if (instr_r2r || instr_push || instr_pull)   curr_st <= st_load_reg;
          else if (instr_setflag || instr_nop)         curr_st <= st_new_op;
          else if (instr_branch) begin
            if (op_hi[1] == branch_test_bit)           curr_st <= st_hi_byte;
            else                                       curr_st <= st_load_reg;
          end
          else if (instr_jump || instr_rts)            curr_st <= st_lo_byte;
          else if (op_amode == immediate)              curr_st <= st_load_or_write;
          else                                         curr_st <= st_lo_byte;
        end
        st_lo_byte: begin
          if (instr_rts)                               curr_st <= st_hi_byte;
          else if (amode_zp_indirect || instr_jsr)     curr_st <= st_indirect;
          else if (op_amode == zp)                     curr_st <= st_load_or_write;
          else                                         curr_st <= st_hi_byte;
        end
        st_indirect: begin                             curr_st <= st_hi_byte;
        end
        st_hi_byte: begin
          if (instr_branch) begin
            if (data_out[7] && ~alu_cout)              curr_st <= st_carry_sub;
            else if (~data_out[7] && alu_cout)         curr_st <= st_carry_add;
            else                                       curr_st <= st_new_op;
          end
          else if (instr_jmpabs || instr_rts)          curr_st <= st_new_op;
          else if (hi_addr_from_data_out && alu_cout)  curr_st <= st_carry_add;
          else                                         curr_st <= st_load_or_write;
        end
        st_carry_add,
        st_carry_sub: begin
          if (instr_wrmem)                             curr_st <= st_load_reg;
          else if (instr_branch)                       curr_st <= st_new_op;
          else                                         curr_st <= st_load_or_write;
        end
        st_write_data: begin
          if (instr_wrmem || instr_jump)               curr_st <= st_load_reg;
          else                                         curr_st <= st_new_op;
        end
        st_load_reg: begin                             curr_st <= st_new_op;
        end
        default: begin
        end
      endcase
  end

  wire[7:0] prev_data =
    curr_st == st_hi_byte && instr_branch ? prev_addr[15:8] : data_out;

  always @(posedge CLK) begin
    if (~instr_jsr || curr_st == st_indirect)
      prev_addr <= addr_bus;
    reg_l <= prev_data;
    case (curr_st)
      st_initial: begin
        reg_s <= 8'hff;
      end
      st_new_op: begin
        reg_o <= data_out;
        if (instr_pull || instr_rts)
          reg_s <= alu_out;
      end
      st_lo_byte,
      st_write_data: begin
        if (instr_jsr || instr_rts)
          reg_s <= alu_out;
      end
      st_load_reg: begin
        if (instr_push || instr_jsr)
          reg_s <= alu_out;
        if (instr_pla)
          reg_a <= alu_out;

        if (instr_load) begin
          if (op_group == group6)
            reg_x <= data_out;
          if (op_group == group5)
            reg_y <= data_out;
          if (op_group == group8)
            reg_a <= data_out;
        end
        if (instr_incx || instr_decx)
          reg_x <= alu_out;
        if (instr_incy || instr_decy)
          reg_y <= alu_out;
        if (instr_tax)
          reg_x <= alu_out;
        if (instr_txa)
          reg_a <= alu_out;
        if (instr_tay)
          reg_y <= alu_out;
        if (instr_tya)
          reg_a <= alu_out;
        if (instr_tsx)
          reg_x <= alu_out;
        if (instr_txs)
          reg_s <= alu_out;
        if (instr_acc && ~instr_compare)
          reg_a <= alu_out;
        if (instr_sh_acc)
          reg_a <= alu_out;
      end
      default: begin
      end
    endcase
  end

always @(posedge CLK) begin
  case (curr_st)
    st_new_op: begin
      if (instr_setflag) begin
        case (op_hi[3:2])
          2'b00: reg_p[bit_carry]     <= op_hi[1];
          2'b01: reg_p[bit_interrupt] <= op_hi[1];
          2'b10: reg_p[bit_overflow]  <= 1'b0;
          2'b11: reg_p[bit_decimal]   <= op_hi[1];
        endcase
      end
    end
    st_write_data: begin
      if (~instr_store && ~instr_jump) begin
        reg_p[bit_zero] <= alu_zero;
        reg_p[bit_negative] <= alu_negative;
        if (instr_sh_mem)
          reg_p[bit_carry] <= alu_cout;
      end
    end
    st_load_reg: begin
      if (instr_plp)
        reg_p <= data_out | 8'h30;
      else if (instr_bit) begin
        reg_p[bit_zero] <= alu_zero;
        reg_p[bit_negative] <= data_out[7];
        reg_p[bit_overflow] <= data_out[6];
      end
      else if (
        ~instr_wrmem && ~instr_jump && ~instr_branch &&
        ~instr_push && ~instr_nop && ~instr_txs
      ) begin
        reg_p[bit_zero] <= alu_zero;
        reg_p[bit_negative] <= alu_negative;
        if (instr_adc || instr_sbc || instr_compare || instr_sh_acc) begin
          reg_p[bit_carry] <= alu_cout;
          if (instr_adc || instr_sbc)
            reg_p[bit_overflow] <= alu_overflow;
        end
      end
    end
    default: begin
    end
  endcase
end

endmodule
