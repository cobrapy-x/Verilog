`timescale 1ns/1ps

module and_gate_tb;
    reg x;
    reg y;
    wire z;
    integer tests;
    integer failures;

    and_gate dut (
        .x(x),
        .y(y),
        .z(z)
    );

    task check;
        input test_x;
        input test_y;
        reg expected_z;
        begin
            x = test_x;
            y = test_y;
            expected_z = test_x & test_y;
            #10;
            tests = tests + 1;
            if (z === expected_z) begin
                $display("PASS: x=%b y=%b -> z=%b", x, y, z);
            end else begin
                failures = failures + 1;
                $display("FAIL: x=%b y=%b -> z=%b (expected %b)",
                         x, y, z, expected_z);
            end
        end
    endtask

    initial begin
        $dumpfile("and_gate.vcd");
        $dumpvars(0, and_gate_tb);

        tests = 0;
        failures = 0;
        check(1'b0, 1'b0);
        check(1'b0, 1'b1);
        check(1'b1, 1'b0);
        check(1'b1, 1'b1);

        if (failures == 0)
            $display("PASS: and_gate passed all %0d tests", tests);
        else
            $display("FAIL: and_gate failed %0d of %0d tests", failures, tests);
        $finish;
    end
endmodule
