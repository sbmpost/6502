module alu8(
  input[7:0] A,
  input[7:0] B,
  input CI,
  input[5:0] OP, // sr, mode, s3-s0
  output CO,
  output[7:0] F
);

  wire g_lo, p_lo;
  wire[3:0] f_lo;
  wire[3:0] f_hi;
  wire co_hi;

  wire[7:0] a_sr = { CI, A[7:1] };

  alu4 lo(.A(A[3:0]),
           .B(B[3:0]),
           .CI(CI),
           .M(OP[4]),
           .S(OP[3:0]),
           .CO(),
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
           .G(),
           .P());

  assign CO = OP[5] ? A[0] : co_hi;
  assign F = OP[5] ? a_sr : { f_hi, f_lo };

endmodule
