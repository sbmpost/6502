// copyright by sbmpost
/*
  "mark_style": "squiggly underline",
  "warning_color": "DDB700",
  "error_color": "D02000",
  "show_errors_on_save": false,
  "tooltip_fontsize": "1rem",
  "tooltip_theme": "Packages/SublimeLinter/tooltip-themes/Default/Default.tooltip-theme",
  "tooltips": false,
  "passive_warnings": false,
  "use_current_shell_path": false,
  "wrap_find": true,
  "rc_search_limit": 3,
  "shell_timeout": 10,
*/

module cpu(
  input CLK,
  input R,
  output opcode,
  output op_amode,
  output op_group,
  output addr_bus,
  output data_out,
  output data_in,
  output data_write,
  output curr_st,
  output pc_inc,
  output pc_out,
  output pc_write,
  output op,
  output alu_op,
  output alu_cin,
  output alu_a,
  output reg_l,
  output alu_out,
  output reg_p,
  output reg_x,
  output reg_y,
  output reg_a
);

  // bits in a_mode
  parameter bit_id = 2; // indexed (i)
  parameter bit_ab = 1; // absolute (a)
  parameter bit_xy = 0; // x/y reg (x)

  // bits in reg_p
  parameter bit_negative = 3;
  parameter bit_overflow = 2;
  parameter bit_zero     = 1;
  parameter bit_carry    = 0;

  //                     iax
  parameter zp_x_in = 3'b000;
  parameter imm     = 3'b010;
  parameter zp_y_in = 3'b100;
  parameter zp      = 3'b001;
  parameter ab_y    = 3'b110;
  parameter ab      = 3'b011;
  parameter zp_x    = 3'b000;
  parameter ab_x    = 3'b111;

  // cpu states
  parameter st_initial    = 8'b00000000;
  parameter st_new_op     = 8'b00000001; // 0x01
  parameter st_lo_byte    = 8'b00000010; // 0x02
  parameter st_indirect   = 8'b00000100; // 0x04
  parameter st_hi_byte    = 8'b00001000; // 0x08
  parameter st_carry_out  = 8'b00010000; // 0x10
  parameter st_write_data = 8'b00100000; // 0x20
  parameter st_load_reg   = 8'b01000000; // 0x40
  parameter st_jmp_ind    = 8'b10000000; // 0x80

  // nr of addressing modes
  parameter group8 = 2'b01;
  parameter group6 = 2'b10;
  parameter group5 = 2'b00;

  reg[7:0] curr_st;
  reg[7:0] reg_o;
  reg[7:0] reg_l;
  reg[7:0] reg_x;
  reg[7:0] reg_y;
  reg[7:0] reg_a;
  reg[3:0] reg_p;
  reg[15:0] prev_addr;

  wire[7:0] data_out;

  wire[7:0] op       = curr_st == st_new_op ? data_out : reg_o;
  wire[2:0] opcode   = op[7:5];
  wire[2:0] op_amode = op[4:2];
  wire[1:0] op_group = op[1:0];
  wire[3:0] op_lo    = op[3:0];
  wire[3:0] op_hi    = op[7:4];

  // -----------------instruction decoding (consider using ROM instead)-----------------
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
  wire hi_8_or_A = hi_8_or_9_or_A_or_B && op_hi[0] == 1'b0;
  wire hi_9_or_B = hi_8_or_9_or_A_or_B && op_hi[0] == 1'b1;
  wire hi_9_or_A = hi_8_or_9_or_A_or_B && op_hi[0] ^ op_hi[1];
  wire hi_C_or_D = hi_C_or_D_or_E_or_F && op_hi[1] == 1'b0;
  wire hi_E_or_F = hi_C_or_D_or_E_or_F && op_hi[1] == 1'b1;

  wire lo_0 = op_lo == 4'h0;
  wire lo_8 = op_lo == 4'h8;
  wire lo_A = op_lo == 4'hA;
  wire lo_C = op_lo == 4'hC;

  wire hi_2 = op_hi == 4'h2;
  wire hi_4 = op_hi == 4'h4;
  wire hi_6 = op_hi == 4'h6;
  wire hi_8 = op_hi == 4'h8;
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
  wire instr_load    = hi_A_or_B && ~lo_8_or_A && ~instr_branch;   // 1
  wire instr_store   = hi_8_or_9 && ~lo_8_or_A && ~instr_branch;   // 1
  wire instr_trxa    = hi_8_or_A && lo_A;                          // 2
  wire instr_trxs    = hi_9_or_B && lo_A;                          // 2
  wire instr_trya    = hi_9_or_A && lo_8;                          // 2
  wire instr_incx    = hi_E && lo_8;                               // 1
  wire instr_incy    = hi_C && lo_8;                               // 1
  wire instr_decx    = hi_C && lo_A;                               // 1
  wire instr_decy    = hi_8 && lo_8;                               // 1
  wire instr_shl     = hi_0_or_1_or_2_or_3 && lo_2_or_6_or_A_or_E; // 4
  wire instr_shr     = hi_4_or_5_or_6_or_7 && lo_2_or_6_or_A_or_E; // 4
  wire instr_cmp     = hi_C_or_D && lo_1_or_5_or_9_or_D;           // 1
  wire instr_cpx     = hi_E && lo_0_or_4_or_C;                     // 1
  wire instr_cpy     = hi_C && lo_0_or_4_or_C;                     // 1
  wire instr_bit     = hi_2 && lo_4_or_C;                          // 1
  wire instr_nop     = hi_E && lo_A;                               // 1

  // Change program counter
  wire instr_jmpabs  = hi_4 && lo_C;                               // 1
  wire instr_jmpind  = hi_6 && lo_C;
  wire instr_branch  = op_hi[0] == 1'b1 && lo_0;                   // 8

  // Set/Clear bits in reg_p
  wire instr_setflag = op_hi[0] == 1'b1 && lo_8;                   // 7

  // m2m (group6)
  wire instr_incmem  = hi_E_or_F && lo_6_or_E;                     // 1
  wire instr_decmem  = hi_C_or_D && lo_6_or_E;                     // 1
                                                                   // tot: 48
  // m2m/a2a (group6, accumulator mode indicates A2A)
  wire instr_shift   = instr_shl || instr_shr;

  // r2r
  wire instr_incxy   = instr_incx || instr_incy;
  wire instr_decxy   = instr_decx || instr_decy;
  wire instr_trans   = instr_trxa || instr_trxs || instr_trya;
  wire instr_r2r     = instr_incxy || instr_decxy || instr_trans;

  // ma2a (group8)
  wire instr_logic   = instr_ora || instr_and || instr_eor;
  wire instr_arith   = instr_adc || instr_sbc;

  // mr2p (cmp: group8, cpx/cpy/bit: group5)
  wire instr_compare = instr_cmp || instr_cpx || instr_cpy || instr_bit;

  // m2r (lda: group8, ldy/sty: group5, ldx/stx: group6)
  wire instr_memreg  = instr_load || instr_store;

  // REMAINING: brk, jsr, rti, rts, pha, php, pla, plp             // tot: 8
  // -----------------------------------------------------------------------------------

  wire pc_inc =
    curr_st == st_initial ||
    curr_st == st_new_op && ~instr_r2r ||
    curr_st == st_hi_byte && op_amode[bit_ab] ||
    curr_st == st_write_data && ~instr_store ||
    curr_st == st_load_reg ||
    curr_st == st_jmp_ind;

  wire pc_write =
    curr_st == st_hi_byte && instr_jmpabs ||
    curr_st == st_jmp_ind;

  wire[15:0] pc_out;

  pc pc_1(
    .D({data_out, alu_out}),
    .R(R),
    .WE(pc_write),
    .INC(pc_inc),
    .CLK(CLK),
    .PC(pc_out)
  );

  wire lo_addr_from_data_out = op_amode == zp || op_amode == zp_y_in;
  wire hi_addr_from_data_out = op_amode[bit_ab] || op_amode == zp_y_in;

  reg[15:0] addr_bus;
  always @(*) begin
    case (curr_st)
      st_lo_byte: begin
        if (lo_addr_from_data_out)
          addr_bus = { 8'h00, data_out };
        else
          addr_bus = pc_out;
      end
      st_hi_byte: begin
        if (hi_addr_from_data_out)
          addr_bus = { data_out, alu_out };
        else
          addr_bus = { 8'h00, alu_out};
      end
      st_indirect: begin
        addr_bus = { 8'h00, alu_out };
      end
      st_carry_out: begin
        addr_bus = { alu_out, prev_addr[7:0] };
      end
      st_write_data: begin
        if (instr_store)
          addr_bus = prev_addr;
        else
          addr_bus = pc_out;
      end
      st_load_reg: begin
        if (instr_jmpind)
          addr_bus = { prev_addr[15:8], alu_out };
        else
          addr_bus = pc_out;
      end
      st_jmp_ind: begin
        addr_bus = { data_out, alu_out };
      end
      default: begin
        addr_bus = pc_out;
      end
    endcase
  end

  MEMORY mem(
    .CLK(CLK),
    .WE(data_write),
    .Address(addr_bus),
    .DataIn(data_in),
    .DataOut(data_out)
  );

  wire alu_cout;
  wire[7:0] alu_out;

  // sr, mode, s3-s0
  parameter alu_op_lo_plus_index = 6'b011001;
  parameter alu_op_increm_a_by_1 = 6'b010000; // and set alu_cin
  parameter alu_op_decrem_a_by_1 = 6'b011111;

  reg[5:0] alu_op;
  always @(*) begin
    if (instr_incxy)
      alu_op = alu_op_increm_a_by_1;
    else if (instr_decxy)
      alu_op = alu_op_decrem_a_by_1;
    else
      alu_op = alu_op_lo_plus_index;
  end

  reg[7:0] alu_a;
  always @(*) begin
    if (instr_incx || instr_decx)
      alu_a = reg_x;
    else if (instr_incy || instr_decy)
      alu_a = reg_y;
    else if (curr_st == st_hi_byte) begin
      if (op_amode[bit_id]) begin
        if (op_amode[bit_xy])
          alu_a = reg_x;
        else
          alu_a = reg_y;
      end
    end
    else
      alu_a = 8'h00;
  end

  wire alu_cin =
    curr_st == st_indirect ||
    curr_st == st_carry_out ||
    curr_st == st_write_data && instr_incxy ||
    curr_st == st_load_reg; // for instr_jmpind;

  alu8 alu_1(
    .A(alu_a),
    .B(reg_l),
    .CI(alu_cin),
    .OP(alu_op),
    .CO(alu_cout),
    .F(alu_out)
  );

  wire[2:0] immediate = op_group == group8 ? imm : zp_x_in;
  // wire accumulator = op_group == group6 && op_amode == imm;
  wire p_carry = curr_st == st_hi_byte ? alu_cout : reg_p[bit_carry];

  reg[7:0] st_load_or_write;
  always @(*) begin
    if (instr_load)
      st_load_or_write = st_load_reg;
    else if (instr_store)
      st_load_or_write = st_write_data;
  end

  always @(posedge CLK or posedge R) begin
    if (R) begin
      curr_st <= st_initial;
    end
    else
      case (curr_st)
        st_initial: begin                 curr_st <= st_new_op;
        end
        st_new_op: begin
          if (instr_r2r)
                                          curr_st <= st_write_data;
          else if (op_amode == immediate) curr_st <= st_load_or_write;
          else                            curr_st <= st_lo_byte;
        end
        st_lo_byte: begin
          if (op_amode == zp_y_in)        curr_st <= st_indirect;
          else if (op_amode == zp)        curr_st <= st_load_or_write;
          else                            curr_st <= st_hi_byte;
        end
        st_indirect: begin                curr_st <= st_hi_byte;
        end
        st_hi_byte: begin
          if (hi_addr_from_data_out && p_carry)
                                          curr_st <= st_carry_out;
          else if (instr_jmpabs)          curr_st <= st_new_op;
          else                            curr_st <= st_load_or_write;
        end
        st_carry_out: begin
          if (instr_store)                curr_st <= st_load_reg;
          else                            curr_st <= st_load_or_write;
        end
        st_write_data: begin
          if (instr_store)                curr_st <= st_load_reg;
          else                            curr_st <= st_new_op;
        end
        st_load_reg: begin
          if (instr_jmpind)               curr_st <= st_jmp_ind;
          else                            curr_st <= st_new_op;
        end
        st_jmp_ind: begin                 curr_st <= st_new_op;
        end
        default: begin
        end
      endcase
  end

  wire data_write = instr_store && (
    curr_st == st_carry_out ||
    curr_st == st_write_data
  );

  reg[7:0] data_in;
  always @(*) begin
    if (op_group == group6)
      data_in = reg_x;
    else if (op_group == group5)
      data_in = reg_y;
    else if (op_group == group8)
      data_in = reg_a;
  end

  always @(posedge CLK) begin
    prev_addr <= addr_bus;
    case (curr_st)
      st_new_op: begin
        reg_o <= data_out;
      end
      st_lo_byte: begin
        reg_l <= data_out;
      end
      st_indirect: begin
        reg_l <= data_out;
      end
      st_hi_byte: begin
        if (~instr_jmpind)
          reg_l <= data_out;
      end
      st_carry_out: begin
      end
      st_write_data: begin
        reg_p <= { 3'b000, alu_cout };
        if (instr_incx || instr_decx)
          reg_x <= alu_out;
        if (instr_incy || instr_decy)
          reg_y <= alu_out;
      end
      st_load_reg: begin
        reg_l <= data_out;
        if (instr_load) begin
          if (op_group == group6)
            reg_x <= data_out;
          else if (op_group == group5)
            reg_y <= data_out;
          else if (op_group == group8)
            reg_a <= data_out;
        end
      end
      default: begin
      end
    endcase
  end

endmodule
