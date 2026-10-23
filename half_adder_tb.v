`timescale 1ns/1ps

module half_adder_tb;
    reg a;
    reg b;
    wire sum;
    wire carry;
    integer tests;
    integer failures;

    half_adder dut (
        .a(a),
        .b(b),
        .sum(sum),
        .carry(carry)
    );

    task check;
        input test_a;
        input test_b;
        reg expected_sum;
        reg expected_carry;
        begin
            a = test_a;
            b = test_b;
            expected_sum = test_a ^ test_b;
            expected_carry = test_a & test_b;
            #10;
            tests = tests + 1;
            if ({sum, carry} === {expected_sum, expected_carry}) begin
                $display("PASS: a=%b b=%b -> sum=%b carry=%b",
                         a, b, sum, carry);
            end else begin
                failures = failures + 1;
                $display("FAIL: a=%b b=%b -> sum=%b carry=%b (expected sum=%b carry=%b)",
                         a, b, sum, carry, expected_sum, expected_carry);
            end
        end
    endtask

    initial begin
        $dumpfile("half_adder.vcd");
        $dumpvars(0, half_adder_tb);

        tests = 0;
        failures = 0;
        check(1'b0, 1'b0);
        check(1'b0, 1'b1);
        check(1'b1, 1'b0);
        check(1'b1, 1'b1);

        if (failures == 0)
            $display("PASS: half_adder passed all %0d tests", tests);
        else
            $display("FAIL: half_adder failed %0d of %0d tests", failures, tests);
        $finish;
    end
endmodule
