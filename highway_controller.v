module HW_Controller(
    input clk, rst_n, sensor, time_out,
    output reg [2:0] HW_LED,
    output reg mode_count, CR_Ena
);
    localparam s0 = 2'b00;
    localparam s1 = 2'b01;
    localparam s2 = 2'b10;
    localparam s3 = 2'b11;

    reg [1:0] state, nextstate;
always @(sensor, time_out, state) begin
    case (state)
        s0 : begin
            if(sensor & time_out) begin
                nextstate <= s1;
            end
            else begin
                nextstate <= s0;
            end
            HW_LED <= 3'b100;
            mode_count <= 1'b0;
            CR_Ena <= 1'b0;
        end
        s1: begin
            if(time_out) begin
                nextstate <= s2;
            end
            else begin
                nextstate <= s1;
            end
            HW_LED <= 3'b010;
            mode_count <= 1'b1;
            CR_Ena <= 1'b0;
        end
        s2: begin
            if(time_out) begin
                nextstate <= s3;
            end
            else begin
                nextstate <= s2;
            end
            HW_LED <= 3'b001;
            mode_count <= 1'b0;
            CR_Ena <= 1'b1;
        end
        s3: begin
            if(time_out) begin
                nextstate <= s0;
            end
            else begin
                nextstate <= s2;
            end
            HW_LED <= 3'b001;
            mode_count <= 1'b1;
            CR_Ena <= 1'b0;
        end
        default: begin
             if(sensor & time_out) begin
                nextstate <= s1;
            end
            else begin
                nextstate <= s0;
            end
            HW_LED <= 3'b100;
            mode_count <= 1'b0;
            CR_Ena <= 1'b0;
        end
    endcase
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) 
    state <= s0;
    else
    state <= nextstate;
end
endmodule