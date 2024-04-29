module HW_Controller(
    input clk, rst_n, sensor, time_out,
    output reg [2:0] HW_LED
);
    localparam s0 = 2'b00;
    localparam s1 = 2'b01;
    localparam s2 = 2'b10;

    reg [1:0] state, nextstate;


always @(state, sensor) begin
    case (state)
        s0 : begin
            if(sensor) begin
                nextstate <= s1;
            end
            else begin
                nextstate <= s0;
            end
            HW_LED <= 3'b100;
        end
        s1: begin
            nextstate <= s2;
            HW_LED <= 3'b010;
        end
        s2: begin
            nextstate <= s0;
            HW_LED <= 3'b001;
        end
        default: begin
            if(sensor) begin
                nextstate <= s1;
            end
            else begin
                nextstate <= s0;
            end
            HW_LED <= 3'b100;
        end
    endcase
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state <= s0;
    end
    else begin
        if(time_out) begin
            state <= nextstate;
        end
        else begin
            state <= state;
        end
    end
end
endmodule