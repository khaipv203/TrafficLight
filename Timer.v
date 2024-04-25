module Timer (
    input clk, rst_n, mode_count, pulse,
    output time_out,
    output [5:0] time_display
);
    localparam mode_1 = 6'b001010;
    localparam mode_0 = 6'b111100;

    reg [5:0] cnt;
    reg state, nextstate, prev_pulse;
    always @(mode_count, state)
        begin
            case (state)
                0: begin
                    if (mode_count == 1'b0) nextstate <= 1'b0;
                    else nextstate <= 1'b1;
                    max_time = mode_0;
                end
                1: begin
                    nextstate <= 1'b0;
                end
                default: begin
                    if (mode_count == 1'b0) nextstate <= 1'b0;
                    else nextstate <= 1'b1;
                end
            endcase
        end
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) state <= 1'b0;
        else state <= nextstate;
    end
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            cnt <= 1;
            prev_pulse <= 0;
            time_out <= 0;
        end
        else begin
            time_out <= 0;
            if(pulse & !prev_pulse) begin
                if(state) begin
                    if (cnt < mode_1) begin
                        cnt <= cnt + 1;
                    end
                    else begin
                        cnt <= 1;
                        time_out <= 1;
                    end
                    time_display = mode_1 - cnt;
                else begin
                    if (cnt < mode_0) begin
                        cnt <= cnt + 1;
                    end
                    else begin
                        cnt <= 1;
                        time_out <= 1;
                    end
                    time_display = mode_0 - cnt;
                end
                end
            end
        end
    end
endmodule
            
module pulse_1s (
  input clk,
  input rst_p,
  output reg pulse
);

  reg [31:0] counter;

  always @(posedge clk or posedge rst_p) begin
    if(rst_p) begin
        counter <= 0;
        pulse <= 0;
    end
    else begin
        if(counter < 25000000) begin
            counter <= counter + 1;
            pulse <= 0;
        end
        else begin
            counter <= 0;
            pulse <= 1;
        end
    end
  end
endmodule
