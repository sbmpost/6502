module pc(
  input[7:0] LO,
  input[7:0] HI,
  input CI,
  input R,
  input WR,
  input INC,
  input CLK,
  output[15:0] PC,
  output CO
);

  reg carry;
  reg[7:0] lbyte;
  reg[7:0] hbyte;

  assign CO = carry;
  assign PC = {hbyte, lbyte};

  // only 1 adder
  wire[7:0] src;
  wire[7:0] sum;
  wire ctmp, csum;
  assign src = carry ? hbyte : lbyte;
  assign {ctmp, sum} = src + 1;
  assign csum = ctmp & ~carry;

  always @(posedge CLK or posedge R) begin
    if (R) begin
      carry <= 1'b0;
      lbyte <= 8'b0;
      hbyte <= 8'b0;
    end
    else if (WR) begin
      carry <= CI;
      lbyte <= LO;
      hbyte <= HI;
    end
    else if (INC) begin
      // executes in parallel
      if (carry) hbyte <= sum;
      else       lbyte <= sum;
      carry <= csum;
    end
  end

endmodule
