module half_adder (
    input  a,
    input  b,
    output s,
    output c
);
    assign s = a ^ b;
    assign c = a & b;
endmodule

module or_gate (
    input  x,
    input  y,
    output z
);
    assign z = x | y;
endmodule

module full_adder (
    input  a,
    input  b,
    input  c_in,
    output sum,
    output c_out
);
    wire s1, c1, c2;

    half_adder HA1 (.a(a),    .b(b),  .s(s1),  .c(c1));
    half_adder HA2 (.a(c_in), .b(s1), .s(sum), .c(c2));
    or_gate    OR1 (.x(c1),   .y(c2), .z(c_out));
endmodule

module adder_4bit (
    input  [3:0] A,
    input  [3:0] B,
    input        C_in,
    output [3:0] S,
    output       C_out
);
    wire c1, c2, c3;

    full_adder FA0 (.a(A[0]), .b(B[0]), .c_in(C_in), .sum(S[0]), .c_out(c1));
    full_adder FA1 (.a(A[1]), .b(B[1]), .c_in(c1),   .sum(S[1]), .c_out(c2));
    full_adder FA2 (.a(A[2]), .b(B[2]), .c_in(c2),   .sum(S[2]), .c_out(c3));
    full_adder FA3 (.a(A[3]), .b(B[3]), .c_in(c3),   .sum(S[3]), .c_out(C_out));
endmodule