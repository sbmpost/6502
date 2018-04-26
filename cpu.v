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
  output reg_a
);

  parameter bit_id = 2; // indexed (i)
  parameter bit_ab = 1; // absolute (a)
  parameter bit_xy = 0; // x/y reg (x)

  //                     iax
  parameter zp_x_in = 3'b000;
  parameter imm     = 3'b010;
  parameter zp_y_in = 3'b100;
  parameter zp      = 3'b001;
  parameter ab_y    = 3'b110;
  parameter ab      = 3'b011;
  parameter zp_x    = 3'b000;
  parameter ab_x    = 3'b111;

  parameter st_initial    = 6'b000000;

  parameter st_new_op     = 6'b000001; // 0x01
  parameter st_lo_byte    = 6'b000010; // 0x02
  parameter st_indirect   = 6'b000100; // 0x04
  parameter st_hi_byte    = 6'b001000; // 0x08
  parameter st_carry_out  = 6'b010000; // 0x10
  parameter st_load_reg   = 6'b100000; // 0x20

  reg[5:0] curr_st;
  reg[7:0] curr_op;
  reg[7:0] lo_byte;
  reg[7:0] reg_x;
  reg[7:0] reg_y;
  reg[7:0] reg_a;
  reg[15:0] prev_addr;

  wire[7:0] data_bus;

  wire[7:0] op       = curr_st == st_new_op ? data_bus : curr_op;
  wire[2:0] opcode   = op[7:5];
  wire[2:0] op_amode = op[4:2];
  wire[1:0] op_group = op[1:0];
  // todo: ld, alu, wr signals
  // todo: wX, wY, wA signals

  wire pc_inc =
    curr_st == st_initial ||
    curr_st == st_new_op ||
    curr_st == st_load_reg ||
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

  wire[7:0] hi_correction = data_bus + 1; // todo: should be reg?
  wire[7:0] lo_addr = lo_addr_from_data_bus &&
    curr_st == st_lo_byte ? data_bus : alu_out;
  wire[7:0] hi_addr = hi_addr_from_data_bus &&
    curr_st != st_lo_byte && curr_st != st_indirect ?
    (curr_st == st_carry_out ? hi_correction : data_bus) : 8'h00;

  wire[15:0] addr_bus =
    (curr_st == st_lo_byte && lo_addr_from_data_bus) ||
    curr_st == st_indirect ||
    curr_st == st_hi_byte ||
    curr_st == st_carry_out ?
      (curr_st == st_hi_byte && hi_addr_from_data_bus && alu_cout ?
        prev_addr : {hi_addr, lo_addr}) : pc_out;

  MEMORY mem(
    .CLK(CLK),
    .WE(1'b0),
    .Address(addr_bus),
    .DataIn(0'b0),
    .DataOut(data_bus)
  );

  parameter alu_op_pass_lo_byte = 6'h05;
  parameter alu_op_lo_plus_index = 6'h19;

  wire alu_cout;
  wire[7:0] alu_out; // todo: should be reg?
  wire[5:0] alu_op;

  always @(curr_st) begin
    case (curr_st)
      st_indirect: begin
        alu_op = alu_op_lo_plus_index;
      end
      st_hi_byte,
      st_carry_out: begin
        if (op_amode[bit_id]) alu_op = alu_op_lo_plus_index;
        else                  alu_op = alu_op_pass_lo_byte;
      end
    endcase
  end

  wire[7:0] alu_a = curr_st == st_indirect ?
    8'h01 : (op_amode[bit_xy] ? reg_x : reg_y);

  alu8 alu_1(
    .A(alu_a),
    .B(lo_byte),
    .CI(1'b0),
    .OP(alu_op),
    .CO(alu_cout),
    .F(alu_out)
  );

  wire[2:0] immediate = op_group == 2'b01 ? imm : zp_x_in;

  always @(posedge CLK or posedge R) begin
    if (R) begin
      curr_st <= st_initial;
      reg_x <= 8'h07;
      reg_y <= 8'h08;
    end
    else
      case (curr_st)
        st_initial: begin               curr_st <= st_new_op;
        end
        st_new_op: begin
          if (op_amode == immediate)    curr_st <= st_load_reg;
          else                          curr_st <= st_lo_byte;
        end
        st_lo_byte: begin
          if (op_amode == zp_y_in)      curr_st <= st_indirect;
          else if (op_amode == zp)      curr_st <= st_load_reg;
          else                          curr_st <= st_hi_byte;
        end
        st_indirect: begin              curr_st <= st_hi_byte;
        end
        st_hi_byte: begin
          if (hi_addr_from_data_bus && alu_cout)
                                        curr_st <= st_carry_out;
          else                          curr_st <= st_load_reg;
        end
        st_carry_out: begin             curr_st <= st_load_reg;
        end
        st_load_reg: begin              curr_st <= st_new_op;
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
      end
      st_carry_out: begin
      end
      st_load_reg: begin
        reg_a <= data_bus;
      end
    endcase
  end

endmodule
