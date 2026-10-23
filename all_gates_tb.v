`timescale 1ns/1ps

module all_gates_tb;
    reg a;
    reg b;
    wire and_out;
    wire or_out;
    wire not_out;
    wire nand_out;
    wire nor_out;
    wire xor_out;
    wire xnor_out;
    integer tests;
    integer failures;

    all_gates dut (
        .a(a),
        .b(b),
        .and_out(and_out),
        .or_out(or_out),
        .not_out(not_out),
        .nand_out(nand_out),
        .nor_out(nor_out),
        .xor_out(xor_out),
        .xnor_out(xnor_out)
    );

    task check;
        input test_a;
        input test_b;
        reg expected_and;
        reg expected_or;
        reg expected_not;
        reg expected_nand;
        reg expected_nor;
        reg expected_xor;
        reg expected_xnor;
        begin
            a = test_a;
            b = test_b;
            expected_and = test_a & test_b;
            expected_or = test_a | test_b;
            expected_not = ~test_a;
            expected_nand = ~(test_a & test_b);
            expected_nor = ~(test_a | test_b);
            expected_xor = test_a ^ test_b;
            expected_xnor = ~(test_a ^ test_b);
            #10;
            tests = tests + 1;
            if ({and_out, or_out, not_out, nand_out, nor_out, xor_out, xnor_out}
                === {expected_and, expected_or, expected_not, expected_nand,
                     expected_nor, expected_xor, expected_xnor}) begin
                $display("PASS: a=%b b=%b -> and=%b or=%b not(a)=%b nand=%b nor=%b xor=%b xnor=%b",
                         a, b, and_out, or_out, not_out, nand_out, nor_out,
                         xor_out, xnor_out);
            end else begin
                failures = failures + 1;
                $display("FAIL: a=%b b=%b -> got %b%b%b%b%b%b%b, expected %b%b%b%b%b%b%b",
                         a, b, and_out, or_out, not_out, nand_out, nor_out,
                         xor_out, xnor_out, expected_and, expected_or,
                         expected_not, expected_nand, expected_nor,
                         expected_xor, expected_xnor);
            end
        end
    endtask

    initial begin
        $dumpfile("all_gates.vcd");
        $dumpvars(0, all_gates_tb);

        tests = 0;
        failures = 0;
        check(1'b0, 1'b0);
        check(1'b0, 1'b1);
        check(1'b1, 1'b0);
        check(1'b1, 1'b1);

        if (failures == 0)
            $display("PASS: all_gates passed all %0d tests", tests);
        else
            $display("FAIL: all_gates failed %0d of %0d tests", failures, tests);
        $finish;
    end
endmodule
