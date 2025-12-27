module digital_lock_fsm (
    input  clk,
    input  reset,
    input  data_in,
    input  submit,
    output reg locked,
    output reg unlocked
);

    parameter idle         = 3'b000;
    parameter s1           = 3'b001;
    parameter s2           = 3'b010;
    parameter s3           = 3'b011;
    parameter unlock_state = 3'b100;
    parameter lock_state   = 3'b101;
    parameter error_state  = 3'b110;

    reg [2:0] present_state, next_state;
    reg [1:0] err_count;

    // Sequential logic: State and Error Counter
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            present_state <= idle;
            err_count <= 2'b00;
        end else begin
            present_state <= next_state;
            if(present_state == error_state)
                err_count <= err_count + 1'b1;
            else if(present_state == unlock_state)
                err_count <= 2'b00;
        end
    end
      
    // Combinational logic: Transitions and Outputs
    always @(*) begin
        next_state = present_state;
        locked = 1'b1;
        unlocked = 1'b0;
            
        case(present_state)
            idle : begin
                if(data_in == 1'b1 && err_count < 3) next_state = s1;
                else next_state = error_state;
            end
            s1 : begin
                if(data_in == 1'b0 && err_count < 3) next_state = s2;
                else next_state = error_state;
            end
            s2 : begin
                if(data_in == 1'b1 && err_count < 3) next_state = s3;
                else next_state = error_state;
            end
            s3 : begin
                if(data_in == 1'b1 && err_count < 3) next_state = unlock_state;
                else next_state = error_state;
            end
            unlock_state : begin
                unlocked = 1'b1;
                locked = 1'b0;
                if(submit) next_state = lock_state;
                else next_state = unlock_state;
            end
            lock_state : begin
                locked = 1'b1;
                unlocked = 1'b0;
                next_state = idle;
            end
            error_state : begin
                if(submit) next_state = idle;
                else next_state = error_state;
            end
            default: next_state = idle;
        endcase
    end
endmodule