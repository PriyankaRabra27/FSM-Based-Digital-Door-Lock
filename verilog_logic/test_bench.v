`timescale 1ns/1ps

module test_bench;
    reg clk, reset, data_in, submit;
    wire locked, unlocked;
    
    // Explicit port mapping to avoid any simulator confusion
    digital_lock_fsm dut (
        .clk(clk),
        .reset(reset),
        .data_in(data_in),
        .submit(submit),
        .locked(locked),
        .unlocked(unlocked)
    );
    
    // Clock: 10ns period
    initial clk = 0;
    always #5 clk = ~clk;
        
    initial begin
        // --- 1. INITIALIZATION ---
        reset = 1; data_in = 0; submit = 0;
        #20 reset = 0;
        $display("Starting Comprehensive Tests...");

        // --- 2. SUCCESS CASE (Sequence: 1 -> 0 -> 1 -> 1) ---
        @(negedge clk) data_in = 1; 
        @(negedge clk) data_in = 0; 
        @(negedge clk) data_in = 1; 
        @(negedge clk) data_in = 1; 
        #5;
        if (unlocked) $display("SUCCESS: 1011 Unlocked the FSM.");
        
        // Return to idle
        @(negedge clk) submit = 1;
        @(negedge clk) submit = 0;
        #10;

        // --- 3. FAILURE CASE 1 (Sequence: 1 -> 1 -> X -> X) ---
        // Entering '1' then another '1' should jump to error_state immediately
        @(negedge clk) data_in = 1;
        @(negedge clk) data_in = 1; 
        #5;
        if (locked && !unlocked) $display("SUCCESS: Wrong bit sent FSM to Error State.");
        
        // Must press submit to try again
        @(negedge clk) submit = 1;
        @(negedge clk) submit = 0;
        #10;

        // --- 4. LOCKOUT TEST (3 Consecutive Failures) ---
        // We already failed once above. Let's fail twice more.
        repeat (2) begin
            @(negedge clk) data_in = 0; // Immediate wrong bit
            #5;
            @(negedge clk) submit = 1;
            @(negedge clk) submit = 0;
            #10;
        end
        
        // After 3 failures, try the correct code. 
        // Per your logic (err_count < 3), it should stay locked.
        @(negedge clk) data_in = 1; 
        @(negedge clk) data_in = 0; 
        @(negedge clk) data_in = 1; 
        @(negedge clk) data_in = 1; 
        #5;
        if (locked) $display("SUCCESS: Lockout active after 3 failed attempts.");

        // --- 5. FINAL RESET ---
        #10 reset = 1;
        #10 reset = 0;
        $display("Tests Completed. Ready for hardware mapping.");
        $finish;
    end
    
    endmodule