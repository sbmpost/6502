module cpu(
  input CLK,
  input R,
  output opcode,
  output op_amode,
  output op_group,
  output addr_bus,
  output data_bus,
  output curr_st,
  output pc_inc,
  output op,
  output alu_a,
  output lo_byte,
  output alu_out,
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
  parameter st_initial    = 6'b000000;
  parameter st_new_op     = 6'b000001; // 0x01
  parameter st_lo_byte    = 6'b000010; // 0x02
  parameter st_indirect   = 6'b000100; // 0x04
  parameter st_hi_byte    = 6'b001000; // 0x08
  parameter st_carry_out  = 6'b010000; // 0x10
  parameter st_write_reg  = 6'b100000; // 0x20

  reg[5:0] curr_st;
  reg[7:0] curr_op;
  reg[7:0] lo_byte;
  reg[7:0] reg_x;
  reg[7:0] reg_y;
  reg[7:0] reg_a;
  reg[3:0] reg_p;
  reg[15:0] prev_addr;

  wire[7:0] data_bus;

  wire[7:0] op       = curr_st == st_new_op ? data_bus : curr_op;
  wire[2:0] opcode   = op[7:5];
  wire[2:0] op_amode = op[4:2];
  wire[1:0] op_group = op[1:0];
  wire[3:0] op_lo    = op[3:0];
  wire[3:0] op_hi    = op[7:4];
  // todo: M2R, R2R, MA2A, BR, CP, SH, IDM signals
  // todo: wX, wY, wA signals

  wire pc_inc =
    curr_st == st_initial ||
    curr_st == st_new_op ||
    curr_st == st_write_reg ||
    (curr_st == st_hi_byte && op_amode[bit_ab]);

  wire[15:0] pc_out;

  pc pc_1(
    .LO(8'b0),
    .HI(8'b0),
    .CI(1'b0),
    .R(R),
    .WR(1'b0),
    .INC(pc_inc),
    .CLK(CLK),
    .PC(pc_out),
    .CO()
  );

  wire lo_addr_from_data_bus = op_amode == zp || op_amode == zp_y_in;
  wire hi_addr_from_data_bus = op_amode[bit_ab] || op_amode == zp_y_in;

  reg[15:0] addr_bus;
  always @(*) begin
    case (curr_st)
      st_lo_byte: begin
        if (lo_addr_from_data_bus)
          addr_bus = { 8'h00, data_bus };
        else
          addr_bus = pc_out;
      end
      st_hi_byte: begin
        if (hi_addr_from_data_bus)
          addr_bus = { data_bus, alu_out };
        else
          addr_bus = { 8'h00, alu_out};
      end
      st_indirect: begin
        addr_bus = { 8'h00, alu_out };
      end
      st_carry_out: begin
        addr_bus = { alu_out, prev_addr[7:0] };
      end
      default: begin
        addr_bus = pc_out;
      end
    endcase
  end

  MEMORY mem(
    .CLK(CLK),
    .WE(1'b0),
    .Address(addr_bus),
    .DataIn(0'b0),
    .DataOut(data_bus)
  );

  wire alu_cout;
  wire[7:0] alu_out;

  parameter alu_op_lo_plus_index = 6'h19;
  reg[5:0] alu_op = alu_op_lo_plus_index;

  wire[7:0] alu_a =
    curr_st == st_indirect ||
    curr_st == st_carry_out ||
    ~op_amode[bit_id] ? 8'h00 : (op_amode[bit_xy] ? reg_x : reg_y);

  wire alu_cin =
    curr_st == st_indirect ||
    curr_st == st_carry_out;

  alu8 alu_1(
    .A(alu_a),
    .B(lo_byte),
    .CI(alu_cin),
    .OP(alu_op),
    .CO(alu_cout),
    .F(alu_out)
  );

  wire[2:0] immediate = op_group == 2'b01 ? imm : zp_x_in;
  wire p_carry = curr_st == st_hi_byte ? alu_cout : reg_p[bit_carry];

  always @(posedge CLK or posedge R) begin
    if (R) begin
      curr_st <= st_initial;
    end
    else
      case (curr_st)
        st_initial: begin               curr_st <= st_new_op;
        end
        st_new_op: begin
          if (op_amode == immediate)    curr_st <= st_write_reg;
          else                          curr_st <= st_lo_byte;
        end
        st_lo_byte: begin
          if (op_amode == zp_y_in)      curr_st <= st_indirect;
          else if (op_amode == zp)      curr_st <= st_write_reg;
          else                          curr_st <= st_hi_byte;
        end
        st_indirect: begin              curr_st <= st_hi_byte;
        end
        st_hi_byte: begin
          if (hi_addr_from_data_bus && p_carry)
                                        curr_st <= st_carry_out;
          else                          curr_st <= st_write_reg;
        end
        st_carry_out: begin             curr_st <= st_write_reg;
        end
        st_write_reg: begin             curr_st <= st_new_op;
        end
        default: begin
        end
      endcase
  end

  always @(posedge CLK) begin
    prev_addr <= addr_bus;
    case (curr_st)
      st_new_op: begin
        curr_op <= data_bus;
      end
      st_lo_byte: begin
        lo_byte <= data_bus;
      end
      st_indirect: begin
        lo_byte <= data_bus;
      end
      st_hi_byte: begin
        lo_byte <= data_bus;
      end
      st_carry_out: begin
      end
      st_write_reg: begin
        reg_p <= {3'b000, alu_cout };
        if ((op_hi == 4'h0a || op_hi == 4'h0b) &&
            (op_lo != 4'h08 && op_lo != 4'h0a) &&
             op[4:0] != 5'b10000) begin
          if (op_group == 2'b10)
            reg_x <= data_bus;
          else if (op_group == 2'b00)
            reg_y <= data_bus;
          else if (op_group == 2'b01)
            reg_a <= data_bus;
        end
      end
      default: begin
      end
    endcase
  end

endmodule
