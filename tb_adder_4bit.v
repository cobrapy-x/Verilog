`timescale 1ns / 1ps
`default_nettype none

module tb_adder_4bit;

    // Stimulus: driven by procedural code, so these must be reg
    reg [3:0] A;
    reg [3:0] B;
    reg       C_in;

    // Responses from the DUT: driven by the module, so these are wire
    wire [3:0] S;
    wire       C_out;

    // Bookkeeping
    integer i, j, k;
    integer errors;

    // Golden reference. The 5-bit left-hand side forces the addition
    // to be evaluated in 5 bits, so the carry is not truncated away.
    wire [4:0] expected;
    assign expected = A + B + C_in;

    // Device under test
    adder_4bit DUT (
        .A(A),
        .B(B),
        .C_in(C_in),
        .S(S),
        .C_out(C_out)
    );

    task check;
        begin
            if ({C_out, S} !== expected) begin
                errors = errors + 1;
                $display("FAIL  A=%b B=%b Cin=%b -> got C_out=%b S=%b (%0d), expected %0d",
                         A, B, C_in, C_out, S, {C_out, S}, expected);
            end
        end
    endtask

    initial begin
        $dumpfile("adder_4bit.vcd");
        $dumpvars(0, tb_adder_4bit);

        errors = 0;
        A = 0; B = 0; C_in = 0;

        $display("Sweeping all 512 input combinations...");

        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                for (k = 0; k < 2; k = k + 1) begin
                    A    = i[3:0];
                    B    = j[3:0];
                    C_in = k[0];
                    #10;
                    check;
                end
            end
        end

        $display("----------------------------------------");
        if (errors == 0)
            $display("PASS: all 512 vectors correct.");
        else
            $display("FAIL: %0d of 512 vectors wrong.", errors);
        $display("----------------------------------------");

        $finish;
    end

endmodule

`default_nettype wire