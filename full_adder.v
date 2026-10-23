module half_adder_1(
    input a,
    input b,
    output s1,
    output c1
);
    assign s1 = a ^ b;
    assign c1 = a & b;
endmodule
module half_adder_2(
    input C_in,
    input s1,
    output sum,
    output c2
);
    assign sum = C_in ^ s1;
    assign c2 = C_in & s1;
endmodule
module or_gate(
    input c1,
    input c2,
    output C_out
);
    assign C_out = c1 | c2;
endmodule
module full_adder(
    input a,
    input b,
    input C_in,
    output sum,
    output C_out
);

    wire s1, c1, c2;

    half_adder_1 HA1(
        .a(a),
        .b(b),
        .s1(s1),
        .c1(c1)
    );

    half_adder_2 HA2(
        .C_in(C_in),
        .s1(s1),
        .sum(sum),
        .c2(c2)
    );

    or_gate OR1(
        .c1(c1),
        .c2(c2),
        .C_out(C_out)
    );

endmodule