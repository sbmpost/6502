module top (hwclk, led1, led2, led3, led4, led5, led6, led7, led8, out1, out2);
  input hwclk;
  output led1;
  output led2;
  output led3;
  output led4;
  output led5;
  output led6;
  output led7;
  output led8;
  output out1;
  output out2;


  // Modeline "320x200@71d" 12.02 320 352 368 400 200 204 207 211 doublescan (12.01MHZ)
  //
  //   ---------------------------320----352   368----400
  //   |                           |      |     |      |
  //   |                           |       -----       |
  //   |                           |                   |
  //   |                           |                   |
  //   |                           |                   |
  //   |                           |                   |
  //   |                           |                   |
  //   |                           |                   |
  //  200--------------------------                    |
  //   |                                               |
  //  204--                                            |
  //       |                                           |
  //  207--                                            |
  //   |                                               |
  //  211-----------------------------------------------
  //

  /* 1 Hz clock generation (from 12 MHz) */
  reg clk_1 = 0;
  reg [31:0] cntr_1 = 32'b0;
  parameter period_1 = 6000000;

  /* Low speed clock generation */
  always @(posedge hwclk) begin
    /* generate 1 Hz clock */
    cntr_1 <= cntr_1 + 1;
    if (cntr_1 == period_1) begin
      clk_1 <= ~clk_1;
      cntr_1 <= 32'b0;
    end
  end

  reg res = 1'b0;
  reg [7:0] cntr_2 = 8'b0;
  parameter loop = 15;

  always @(posedge clk_1) begin
    cntr_2 <= cntr_2 + 1;
    if (cntr_2 == 0) begin
      res <= 1'b1;
    end
    else if (cntr_2 == loop) begin
      cntr_2 <= 8'b0;
    end
    else
      res <= 0'b0;
  end

  reg[7:0] reg_a;

  cpu cpu_6502(
    .CLK(clk_1),
    .R(res),
    .reg_a(reg_a)
  );


/*
  reg clk_2 = 0;
  reg [31:0] cntr_3 = 32'b0;
  parameter period_2 = 6;

  always @(posedge hwclk) begin
    cntr_3 <= cntr_3 + 1;
    if (cntr_3 == period_2) begin
      clk_2 <= ~clk_2;
      cntr_3 <= 32'b0;
    end
  end

  wire       sysclk;
  wire       locked;
  pll myPLL (.clock_in(hwclk), .global_clock(sysclk), .locked(locked));
*/

  assign {led1, led2, led3, led4, led5, led6, led7, led8} = reg_a;
  assign out1 = clk_1;
  assign out2 = hwclk; // sysclk; // clk_2;

endmodule
