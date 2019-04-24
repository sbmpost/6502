module pg(
  input A,
  input B,
  input [3:0] S, // operation
  output G,      // generate
  output P       // propagate
);

  assign G = (A & B & S[3]) | (A & ~B & S[2]);
  assign P = A | (~B & S[1]) | B & S[0];

endmodule
