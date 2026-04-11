module digital_lock_fsm (
    input  clk,
    input  reset,
    input  data_in,
    input  submit,
    output reg locked,
    output reg unlocked
);

    // -------------------------
    // State encoding
    // -------------------------
    localparam idle         = 3'b000;
    localparam s1           = 3'b001;
    localparam s2           = 3'b010;
    localparam s3           = 3'b011;
    localparam unlock_state = 3'b100;
    localparam lock_state   = 3'b101;
    localparam error_state  = 3'b110;

    reg [2:0] present_state, next_state;
    reg [1:0] err_count, next_err_count;

    // -------------------------
    // Present state logic
    // -------------------------
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            present_state <= idle;
            err_count     <= 2'b00;
        end
        else begin
            present_state <= next_state;
            err_count     <= next_err_count;
        end
    end

    // -------------------------
    // Next state logic + output logic
    // Password = 1 0 1 1
    // -------------------------
    always @(*) begin
        // default values
        next_state     = present_state;
        next_err_count = err_count;

        locked   = 1'b1;
        unlocked = 1'b0;

        case (present_state)

            // Wait for first bit = 1
            idle: begin
                if (submit) begin
                    if (data_in == 1'b1) begin
                        next_state = s1;
                    end
                    else begin
                        next_err_count = err_count + 1'b1;
                        if (err_count == 2'd2)
                            next_state = lock_state;   // 3rd wrong attempt
                        else
                            next_state = error_state;
                    end
                end
            end

            // First bit matched: 1
            s1: begin
                if (submit) begin
                    if (data_in == 1'b0) begin
                        next_state = s2;
                    end
                    else begin
                        next_err_count = err_count + 1'b1;
                        if (err_count == 2'd2)
                            next_state = lock_state;
                        else
                            next_state = error_state;
                    end
                end
            end

            // First two bits matched: 10
            s2: begin
                if (submit) begin
                    if (data_in == 1'b1) begin
                        next_state = s3;
                    end
                    else begin
                        next_err_count = err_count + 1'b1;
                        if (err_count == 2'd2)
                            next_state = lock_state;
                        else
                            next_state = error_state;
                    end
                end
            end

            // First three bits matched: 101
            s3: begin
                if (submit) begin
                    if (data_in == 1'b1) begin
                        next_state     = unlock_state;
                        next_err_count = 2'b00;   // clear errors after success
                    end
                    else begin
                        next_err_count = err_count + 1'b1;
                        if (err_count == 2'd2)
                            next_state = lock_state;
                        else
                            next_state = error_state;
                    end
                end
            end

            // Correct password entered
            unlock_state: begin
                locked   = 1'b0;
                unlocked = 1'b1;

                // press submit to return to idle
                if (submit) begin
                    next_state     = idle;
                    next_err_count = 2'b00;
                end
            end

            // Wrong attempt state
            error_state: begin
                locked   = 1'b1;
                unlocked = 1'b0;

                // press submit to try again
                if (submit) begin
                    next_state = idle;
                end
            end

            // Hard lock after 3 wrong attempts
            lock_state: begin
                locked   = 1'b1;
                unlocked = 1'b0;

                // stays locked until reset
                next_state = lock_state;
            end

            default: begin
                next_state     = idle;
                next_err_count = 2'b00;
                locked         = 1'b1;
                unlocked       = 1'b0;
            end

        endcase
    end

endmodule
