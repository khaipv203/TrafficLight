module Timer (
    input clk, rst_n, mode_count, pulse,
    output reg time_out,
    output reg [5:0] time_display
);
    localparam mode_1 = 6'b001001;
    localparam mode_0 = 6'b111011;

    reg [5:0] cnt;
    reg state, nextstate, prev_pulse;
    // always @(mode_count, state)
    //     begin
    //         case (state)
    //             0: begin
    //                 if (mode_count == 1'b0) nextstate <= 1'b0;
    //                 else nextstate <= 1'b1;
    //             end
    //             1: begin
    //                 nextstate <= 1'b0;
    //             end
    //             default: begin
    //                 if (mode_count == 1'b0) nextstate <= 1'b0;
    //                 else nextstate <= 1'b1;
    //             end
    //         endcase
    //     end
    // always @(posedge clk or negedge rst_n) begin
    //     if (!rst_n) state <= 1'b0;
    //     else state <= nextstate;
    // end
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            cnt <= 0;
            prev_pulse <= 0;
            time_out <= 0;
            time_display <= 6'b111011;
        end
        else begin
            time_out <= 0;
            if(pulse & !prev_pulse) begin
                if(mode_count) begin
                    if (cnt > mode_1) begin
                        cnt <= cnt + 1;
                        //time_display <= mode_1 - cnt;
                    end
                    else begin
                        cnt <= 0;
                        time_out <= 1;
                        //time_display <= mode_1 - cnt;
                    end
                    
                end
                else begin
                    if (cnt < mode_0) begin
                        cnt <= cnt + 1;
                        //time_display <= mode_0 - cnt;
                    end
                    else begin
                        cnt <= 0;
                        time_out <= 1;
                        //time_display <= mode_0 - cnt;
                    end
                    
                end
                end
            end
        end
    always @(cnt) begin
        if(mode_count) time_display <= mode_1 - cnt;
        else time_display <= mode_0 - cnt;
    end
endmodule
            
module pulse_1s (
  input clk,
  input rst_n,
  output reg pulse
);

  reg [31:0] counter;

  always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        counter <= 0;
        pulse <= 0;
    end
    else begin
        if(counter < 500) begin
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
