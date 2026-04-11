`timescale 1ns/1ps

module test_bench;

    reg clk;
    reg reset;
    reg data_in;
    reg submit;
    wire locked;
    wire unlocked;

    digital_lock_fsm dut (
        .clk(clk),
        .reset(reset),
        .data_in(data_in),
        .submit(submit),
        .locked(locked),
        .unlocked(unlocked)
    );
    

    // Clock generation
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end
    initial begin
    $monitor("time=%0t reset=%b data_in=%b submit=%b state=%b err_count=%d locked=%b unlocked=%b",
              $time, reset, data_in, submit, dut.present_state, dut.err_count, locked, unlocked);
end

    initial begin
        // Initial values
        reset   = 1'b1;
        data_in = 1'b0;
        submit  = 1'b0;

        // Apply reset
        @(negedge clk);
        reset = 1'b1;
        @(negedge clk);
        reset = 1'b0;

        // -------------------------
        // Test 1: Correct password = 1011
        // -------------------------

        // Enter 1
        @(negedge clk);
        data_in = 1'b1;
        submit  = 1'b1;
        @(negedge clk);
        submit  = 1'b0;

        // Enter 0
        @(negedge clk);
        data_in = 1'b0;
        submit  = 1'b1;
        @(negedge clk);
        submit  = 1'b0;

        // Enter 1
        @(negedge clk);
        data_in = 1'b1;
        submit  = 1'b1;
        @(negedge clk);
        submit  = 1'b0;

        // Enter 1
        @(negedge clk);
        data_in = 1'b1;
        submit  = 1'b1;
        @(negedge clk);
        submit  = 1'b0;

        // Wait one cycle
        @(negedge clk);

        // Return from unlock_state to idle
        submit = 1'b1;
        @(negedge clk);
        submit = 1'b0;

        // -------------------------
        // Test 2: Wrong attempt 1
        // -------------------------
        @(negedge clk);
        data_in = 1'b0;
        submit  = 1'b1;
        @(negedge clk);
        submit  = 1'b0;

        // Return from error_state
        @(negedge clk);
        submit = 1'b1;
        @(negedge clk);
        submit = 1'b0;

        // -------------------------
        // Test 3: Wrong attempt 2
        // -------------------------
        @(negedge clk);
        data_in = 1'b0;
        submit  = 1'b1;
        @(negedge clk);
        submit  = 1'b0;

        // Return from error_state
        @(negedge clk);
        submit = 1'b1;
        @(negedge clk);
        submit = 1'b0;

        // -------------------------
        // Test 4: Wrong attempt 3 -> lock_state
        // -------------------------
        @(negedge clk);
        data_in = 1'b0;
        submit  = 1'b1;
        @(negedge clk);
        submit  = 1'b0;

        @(negedge clk);
        @(negedge clk);

        $stop;
    end

endmodule
