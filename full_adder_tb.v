`timescale 1ns/1ps

module full_adder_tb;

    reg a, b, C_in;
    wire sum, C_out;

    full_adder dut(
        .a(a),
        .b(b),
        .C_in(C_in),
        .sum(sum),
        .C_out(C_out)
    );

    initial begin

        $dumpfile("full_adder.vcd");
        $dumpvars(0, full_adder_tb);

        a = 0; b = 0; C_in = 0;
        #10;

        a = 0; b = 0; C_in = 1;
        #10;

        a = 0; b = 1; C_in = 0;
        #10;

        a = 0; b = 1; C_in = 1;
        #10;

        a = 1; b = 0; C_in = 0;
        #10;

        a = 1; b = 0; C_in = 1;
        #10;

        a = 1; b = 1; C_in = 0;
        #10;

        a = 1; b = 1; C_in = 1;
        #10;

        $finish;

    end

endmodule