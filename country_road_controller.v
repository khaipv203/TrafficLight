module CR_Controller(
    input clk, rst_n, sensor, time_out,
    output reg [2:0] CR_LED
);
    localparam s0 = 2'b00;
    localparam s1 = 2'b01;
    localparam s2 = 2'b10;
    localparam s3 = 2'b11;

    reg [1:0] state, nextstate;


always @(sensor, state) begin
    case (state)
        s0 : begin
            if(sensor) begin
                nextstate <= s1;
            end
            else begin
                nextstate <= s0;
            end
            CR_LED <= 3'b001;
        end
        s1: begin
            nextstate <= s2;
            CR_LED <= 3'b001;
        end
        s2: begin
            nextstate <= s3;
            CR_LED <= 3'b100;
        end
        s3: begin
            nextstate <= s0;
            CR_LED <= 3'b010;
        end
        default: begin
            if(sensor) begin
                nextstate <= s1;
            end
            else begin
                nextstate <= s0;
            end
            CR_LED <= 3'b001;
        end
    endcase
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state <= s0;
    end
    else begin
        if (time_out) begin
            state <= nextstate;
        end
        else begin
            state <= state;
        end
    end
end
endmodule