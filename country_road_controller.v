module CR_Controller(
    input clk, rst_n, CR_Ena, time_out,
    output reg [2:0] CR_LED
);
    localparam s0 = 2'b00;
    localparam s1 = 2'b01;
    localparam s2 = 2'b10;

    reg [1:0] state, nextstate;
always @(CR_Ena, time_out, state) begin
    case (state)
        s0 : begin
            if(CR_Ena & time_out) begin
                nextstate <= s1;
            end
            else begin
                nextstate <= s0;
            end
            CR_LED <= 3'b001;
        end
        s1: begin
            if(time_out) begin
                nextstate <= s2;
            end
            else begin
                nextstate <= s1;
            end
            CR_LED <= 3'b100;
        end
        s2: begin
            if(time_out) begin
                nextstate <= s0;
            end
            else begin
                nextstate <= s2;
            end
            CR_LED <= 3'b10;
        end
        default: begin
            if(CR_Ena & time_out) begin
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
    if (!rst_n) 
    state <= s0;
    else
    state <= nextstate;
end
endmodule