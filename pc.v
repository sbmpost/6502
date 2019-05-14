module pc(
  input[15:0] D,
  input R,
  input WE,
  input INC,
  input CLK,
  output reg[15:0] PC
);

  wire[15:0] prv = WE ? D : PC;
  always @(posedge CLK or posedge R) begin
    if (R)
      PC <= 16'h0000;
    else
      PC <= prv + { 15'b0, INC };
  end

endmodule
