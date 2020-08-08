module alu4(
  input[3:0] A,
  input[3:0] B,
  input CI,
  input M,
  input[3:0] S,   // operation
  output CO,
  output[3:0] F,
  output G,       // generate
  output P        // propagate
);

  wire p0, p1, p2, p3;
  wire g0, g1, g2, g3;

  pg pg_0(.A(A[0]), .B(B[0]), .S(S), .G(g0), .P(p0));
  pg pg_1(.A(A[1]), .B(B[1]), .S(S), .G(g1), .P(p1));
  pg pg_2(.A(A[2]), .B(B[2]), .S(S), .G(g2), .P(p2));
  pg pg_3(.A(A[3]), .B(B[3]), .S(S), .G(g3), .P(p3));

  assign F[0] = (p0 ^ g0) ^
    ((M & CI));
  assign F[1] = (p1 ^ g1) ^
    ((M & CI & p0          ) | (M & g0));
  assign F[2] = (p2 ^ g2) ^
    ((M & CI & p0 & p1     ) | (M & g0 & p1     ) | (M & g1));
  assign F[3] = (p3 ^ g3) ^
    ((M & CI & p0 & p1 & p2) | (M & g0 & p1 & p2) | (M & g1 & p2) | (M & g2));

  assign G = (g0 & p1 & p2 & p3) | (g1 & p2 & p3) | (g2 & p3) | g3;
  assign CO = (CI & p0 & p1 & p2 & p3) | G;
  assign P = (p0 & p1 & p2 & p3);

endmodule
