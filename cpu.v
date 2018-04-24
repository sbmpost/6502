module cpu(
  input CLK,
  input R,
  output opcode,
  output op_amode,
  output op_group,
  output addr_bus,
  output data_bus,
  output curr_st,
  output increase,
  output op
  // output R_OUT
);

  reg[5:0] curr_st;
  reg[7:0] curr_op;

  wire[7:0] data_bus;
  wire[15:0] addr_bus;

  wire[7:0] op       = curr_st == st_new_op ? data_bus : curr_op;
  wire[2:0] opcode   = op[7:5];
  wire[2:0] op_amode = op[4:2];
  wire[1:0] op_group = op[1:0];

  wire increase =
    curr_st == st_initial ||
    curr_st == st_new_op || curr_st == st_load_reg ||
    (curr_st == st_hi_byte && op_amode[bit_ab]);

  pc pc_1(
    .LO(8'b0),
    .HI(8'b0),
    .CI(1'b0),
    .R(R),
    .WR(1'b0),
    .INC(increase),
    .CLK(CLK),
    .PC(addr_bus),
    .CO()
  );

  MEMORY mem(
    .CLK(CLK),
    .WE(1'b0),
    .Address(addr_bus),
    .DataIn(0'b0),
    .DataOut(data_bus)
  );

  wire alu_ci;

  alu8 alu_1(
    .A(8'b0),
    .B(8'b0),
    .CI(1'b0),
    .OP(0'b0),
    .CO(alu_ci),
    .F()
  );

  parameter bit_id = 2; // indexed (i)
  parameter bit_ab = 1; // absolute (a)
  parameter bit_xy = 0; // x/y reg (x)

  //                       iax
  parameter zp_x_in   = 3'b000;
  parameter immediate = 3'b010;
  parameter zp_y_in   = 3'b100;
  parameter zp        = 3'b001;
  parameter abs_y     = 3'b110;
  parameter abs       = 3'b011;
  parameter zp_x      = 3'b000;
  parameter abs_x     = 3'b111;

  parameter st_initial    = 6'b000000;

  parameter st_new_op     = 6'b000001;
  parameter st_lo_byte    = 6'b000010;
  parameter st_indirect   = 6'b000100;
  parameter st_hi_byte    = 6'b001000;
  parameter st_carry_out  = 6'b010000;
  parameter st_load_reg   = 6'b100000;

  wire[2:0] acc = immediate;
  wire[2:0] imm = op_group == 2'b01 ? immediate : zp_x_in;

  always @(posedge CLK or posedge R) begin
    if (R) begin
      curr_st <= st_initial;
    end
    else
      case (curr_st)
        st_initial: begin               curr_st <= st_new_op;
        end
        st_new_op: begin
          if (op_amode == imm)          curr_st <= st_load_reg;
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
          if ((op_amode == zp_y_in | op_amode[bit_ab]) & alu_ci)
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
    case (curr_st)
      st_new_op: begin
        curr_op <= data_bus;
      end
      st_lo_byte: begin
      end
      st_indirect: begin
      end
      st_hi_byte: begin
      end
      st_carry_out: begin
      end
      st_load_reg: begin
      end
    endcase
  end

endmodule
