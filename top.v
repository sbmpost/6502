module top (CLK, led1, led2, led3, led4, led5, led6, led7, led8);
  input CLK;
  output led1;
  output led2;
  output led3;
  output led4;
  output led5;
  output led6;
  output led7;
  output led8;

  // 1 Hz clock generation (from 12 MHz)
  reg clk_1 = 0;
  reg[31:0] clk_count = 0;
//  reg[31:0] cntr_1 = 32'b0;
//  parameter period_1 = 6000000;
  parameter start = 100;
//  parameter stop = 519+start;
//  parameter stop = 137615200+start;
  parameter stop = 237615200+start;

  reg res = 1'b1;
  always @(posedge CLK) begin
//    cntr_1 <= cntr_1 + 1;
//    if (cntr_1 == period_1) begin
//      cntr_1 <= 32'b0;
      if (clk_count != stop) begin
        clk_count <= clk_count + 1;
        if (clk_count >= start) begin
          clk_1 <= ~clk_1;
          res <= 1'b0;
        end
      end
//    end
  end

  wire[2:0] opcode;
  wire[2:0] op_amode;
  wire[1:0] op_group;
  wire[15:0] addr_bus;
  wire[7:0] data_out;
  wire[7:0] data_in;
  wire data_write;
  wire[8:0] curr_st;
  wire pc_inc;
  wire[15:0] pc_out;
  wire pc_write;
  wire[7:0] op;
  wire[6:0] alu_op;
  wire alu_cin;
  wire[7:0] alu_a;
  wire[7:0] alu_b;
  wire[7:0] alu_out;
  wire[7:0] reg_p;
  wire[7:0] reg_x;
  wire[7:0] reg_y;
  wire[7:0] reg_s;
  wire[7:0] reg_a;

  cpu cpu_6502(
    .CLK(clk_1),
    .R(res),
    .opcode(opcode),
    .op_amode(op_amode),
    .op_group(op_group),
    .addr_bus(addr_bus),
    .data_out(data_out),
    .data_in(data_in),
    .data_write(data_write),
    .curr_st(curr_st),
    .pc_inc(pc_inc),
    .pc_out(pc_out),
    .pc_write(pc_write),
    .op(op),
    .alu_op(alu_op),
    .alu_cin(alu_cin),
    .alu_a(alu_a),
    .alu_b(alu_b),
    .alu_out(alu_out),
    .reg_p(reg_p),
    .reg_x(reg_x),
    .reg_y(reg_y),
    .reg_a(reg_a),
    .reg_s(reg_s)
  );

  // assign {led2, led1} = {clk_1, res};
  assign {led8, led7, led6, led5, led4, led3, led2, led1} = reg_a;

endmodule
