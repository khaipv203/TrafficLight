module HW_Timer (
    input clk, rst_n, sensor,
    output reg hw_time_out,
    output reg [6:0] hw_time
);
    localparam T = 7'b0111011;
    localparam t = 7'b0001001;

    localparam s0 = 2'b00;
    localparam s1 = 2'b01;
    localparam s2 = 2'b10;

    reg [31:0] counter;
    reg [1:0] state, nextstate;
    reg [6:0] max_time;


    always @(state,sensor) begin
        case (state)
            s0: begin
                    if(sensor) begin
                        nextstate <= s1;
                        max_time <= t;
                    end 
                    else begin
                        nextstate <= s0;
                        max_time <= T;
                    end 
                end
                
            s1: begin
                nextstate <= s2;
                max_time <= t+T+1;
            end
            s2: begin
                nextstate <= s0;
                max_time <= T;
            end
            default: begin
                if(sensor) begin
                        nextstate <= s1;
                        max_time <= t;
                    end 
                    else begin
                        nextstate <= s0;
                        max_time <= T;
                    end 
            end
        endcase
    end
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            counter <= 0;
            state <= s0;
            hw_time <= max_time;
            hw_time_out <= 0;
        end
        else begin
            hw_time_out <= 0;
            if(counter < 10) begin
                counter <= counter + 1;
            end
            else begin
                counter <= 0;
                if (hw_time > 0) begin
                    hw_time <= hw_time - 7'b0000001;
                end
                else begin
                    hw_time_out <= 1;
                    state <= nextstate;
                    hw_time <= max_time;
                end
            end
        end
    end
endmodule
        

module CR_Timer(
    input clk, rst_n, sensor,
    output reg cr_time_out,
    output reg [6:0] cr_time
);
    localparam T = 7'b0111011;
    localparam t = 7'b0001001;

    localparam s0 = 2'b00;
    localparam s1 = 2'b01;
    localparam s2 = 2'b10;
    localparam s3 = 2'b11;
    reg [31:0] counter;
    reg [1:0] state, nextstate;
    reg [6:0] max_time;


    always @(state, sensor) begin
        case (state)
            s0: begin
                if(sensor) begin
                    nextstate <= s1;
                    max_time <= t;
                end 
                else begin
                    nextstate <= s0;
                    max_time <= T;
                end 
            end 
            s1: begin
                nextstate <= s2;
                max_time <= T;
            end
            s2: begin
                nextstate <= s3;
                max_time <= t;
            end
            s3: begin
                nextstate <= s0;
                max_time <= T;
            end
            default: begin
                if(sensor) begin
                    nextstate <= s1;
                    max_time <= t;
                end 
                else begin
                    nextstate <= s0;
                    max_time <= T;
                end 
            end
        endcase
    end
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            counter <= 0;
            state <= s0;
            cr_time <= max_time;
            cr_time_out <= 0;
        end
        else begin
            cr_time_out <= 0;
            if(counter < 10) begin
                counter <= counter + 1;
            end
            else begin
                counter <= 0;
                if (cr_time > 0) begin
                    cr_time <= cr_time - 7'b0000001;
                end
                else begin
                    cr_time_out <= 1;
                    state <= nextstate;
                    cr_time <= max_time;
                end
                
            end
        end
    end
endmodule
        