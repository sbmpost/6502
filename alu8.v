module alu8(
  input[7:0] A,
  input[7:0] B,
  input CI,
  input[6:0] OP, // shift left, shift right, mode, s3-s0
  output CO,
  output wire[7:0] F
);

  wire g_lo, p_lo;
  wire[3:0] f_lo;
  wire[3:0] f_hi;
  wire co_hi;

  wire[7:0] sr = { CI, A[7:1] };
  wire[7:0] sl = { A[6:0], CI };

  wire co_lo;       // unused
  wire g_hi, p_hi;  // unused

  alu4 lo(.A(A[3:0]),
           .B(B[3:0]),
           .CI(CI),
           .M(OP[4]),
           .S(OP[3:0]),
           .CO(co_lo),
           .F(f_lo),
           .G(g_lo),
           .P(p_lo));

  alu4 hi(.A(A[7:4]),
           .B(B[7:4]),
           .CI(g_lo | (CI & p_lo)),
           .M(OP[4]),
           .S(OP[3:0]),
           .CO(co_hi),
           .F(f_hi),
           .G(g_hi),
           .P(p_hi));

  assign CO = OP[5] ? A[0] : (OP[6] ? A[7] : co_hi);
  assign F = OP[5] ? sr : (OP[6] ? sl : { f_hi, f_lo });

endmodule
