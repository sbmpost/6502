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
  reg[31:0] cntr_1 = 32'b0;
  reg started = 0;
  parameter period_1 = 60000;

  reg res = 1'b1;
  always @(posedge CLK) begin
    cntr_1 <= cntr_1 + 1;
    if (cntr_1 == period_1) begin
      cntr_1 <= 32'b0;
      clk_count <= clk_count + 1;
      if ((started || clk_count > 5) && clk_count < 528) begin
        started <= 1'b1;
        clk_1 <= ~clk_1;
      end
      if (clk_count > 2)
        res <= 1'b0;
    end
  end

  wire[2:0] opcode;
  wire[2:0] op_amode;
  wire[1:0] op_group;
  wire[15:0] addr_bus;
  wire[7:0] data_out;
  wire[7:0] data_in;
  wire data_write;
  wire[7:0] curr_st;
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
  reg[7:0] reg_a;

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

  assign {led1, led2, led3, led4, led5, led6, led7, led8} = reg_a;

endmodule
