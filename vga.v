module vga(
  input hwclk,
  output led1,
  output led2,
  output led3,
  output led4,
  output led5,
  output led6,
  output led7,
  output led8,
  output x,
  output y,
  output r,
  output g,
  output b
);

  // Modeline "320x200@71" 12.02 320 352 368 400 200 204 207 211 doublescan (12.01MHZ)
  // Modeline "320x200@71" 12.00 320 336 380 396 200 204 207 211
  // -----------------------------------------------------------
  // Modeline "640x400@80" 27.00 640 672 768 800 400 407 413 421
  // Modeline "640x400@60" 19.88 640 672 744 776 400 408 412 421

  // 640x480  60  25.175  640 16  96  48  480 10  2 33  n n
  // 640x400  70  25.175  640 16  96  48  400 12  2 35  n p
  // Modeline "640x400@75" 25.18 640 672 760 792 400 408 413 421
  //
  //   ---------------------------640----672   768----800
  //   |                           |      |     |      |
  //   |                           |       -----       |
  //   |                           |                   |
  //   |                           |                   |
  //   |                           |                   |
  //   |                           |                   |
  //   |                           |                   |
  //   |                           |                   |
  //  400--------------------------                    |
  //   |                                               |
  //  407--                                            |
  //       |                                           |
  //  413--                                            |
  //   |                                               |
  //  421-----------------------------------------------
  //
  //  horizontal 30.04 kHz / 30.3 kHz
  //  vertical 71.19 Hz / 71.97 Hz
  //

  /* 1 Hz clock generation (from 12 MHz) */
  reg clk_1 = 0;
  reg [31:0] cntr_1 = 32'b0;
  parameter period_1 = 60; // 6000000;

  /* Low speed clock generation */
  always @(posedge hwclk) begin
    /* generate 1 Hz clock */
    cntr_1 <= cntr_1 + 1;
    if (cntr_1 == period_1) begin
      clk_1 <= ~clk_1;
      cntr_1 <= 32'b0;
    end
  end

///*
  // 640x400
  parameter x_visible = 640-1;
  parameter x_front = 32;
  parameter x_pulse = 88;
  parameter x_back = 32;

  parameter y_visible = 400-1;
  parameter y_front = 8;
  parameter y_pulse = 5;
  parameter y_back = 8;
//*/

/*
  parameter x_visible = 640-1;
  parameter x_front = 16;
  parameter x_pulse = 96;
  parameter x_back = 48;

  // 720x400 or 640x350(v polarity)
  parameter y_visible = 400-1;
  parameter y_front = 12;
  parameter y_pulse = 2;
  parameter y_back = 35;

  // 640x480
  parameter y_visible = 480-1;
  parameter y_front = 10;
  parameter y_pulse = 2;
  parameter y_back = 33;
*/

//*
  wire       sysclk;
  wire       locked;
  pll myPLL (.clock_in(hwclk), .global_clock(sysclk), .locked(locked));
//*/

//  wire clk = clk_1; // test with leds

//  wire clk = hwclk; // test with verilator

  wire clk = sysclk; // test with oscilloscope

  reg[9:0] reg_x = 0;
  reg[9:0] reg_y = 0;
  wire[9:0] reg_x_1 = reg_x + 1;
  wire[5:0] ind_x = reg_x_1[9:4];
  wire[8:0] ind_y = reg_y[9:1];

  reg [7:0] frame = 0;
  wire [13:0] offset = (ind_y * 40)+ind_x;
  wire [13:0] addr_bus = frame[0] ? offset : 8000+offset;
  wire [7:0] data_out;
  bitmap myBITMAP(
    .CLK(clk),
    .WE(1'b0),
    .Address(addr_bus),
    .DataIn(8'h00),
    .DataOut(data_out)
  );

  wire pixel = data_out[7-reg_x[3:1]];
  always @(posedge clk) begin
    if (reg_x <= x_visible && reg_y <= y_visible) begin
      r <= pixel;
      g <= pixel;
      b <= pixel;
    end
    else begin
      r <= 0'b0;
      g <= 0'b0;
      b <= 0'b0;
    end
  end

  always @(posedge clk) begin
    case (reg_x)
      x_visible: begin
        reg_x <= reg_x + 1;
        led1 <= 1'b0;
        led2 <= 1'b1;
      end
      x_visible + x_front: begin
        reg_x <= reg_x + 1;
        led2 <= 1'b0;
        led3 <= 1'b1;
        x <= 1'b1;
      end
      x_visible + x_front + x_pulse: begin
        reg_x <= reg_x + 1;
        led3 <= 1'b0;
        led4 <= 1'b1;
        x <= 1'b0;
      end
      x_visible + x_front + x_pulse + x_back: begin
        reg_x <= 0;
        led4 <= 1'b0;
        led1 <= 1'b1;
      end
      default:
        reg_x <= reg_x + 1;
    endcase
  end

  always @(posedge led1) begin
    case (reg_y)
      y_visible: begin
        reg_y <= reg_y + 1;
        led5 <= 1'b0;
        led6 <= 1'b1;
      end
      y_visible + y_front: begin
        reg_y <= reg_y + 1;
        led6 <= 1'b0;
        led7 <= 1'b1;
//        y <= 1'b1;
        y <= 1'b0;
      end
      y_visible + y_front + y_pulse: begin
        reg_y <= reg_y + 1;
        led7 <= 1'b0;
        led8 <= 1'b1;
//        y <= 1'b0;
        y <= 1'b1;
      end
      y_visible + y_front + y_pulse + y_back: begin
        frame <= frame + 1;
        reg_y <= 0;
        led8 <= 1'b0;
        led5 <= 1'b1;
      end
      default:
        reg_y <= reg_y + 1;
    endcase
  end
endmodule
