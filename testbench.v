`timescale 1ps/1ps
module test ();
    reg clk, rst_n, sensor;
    wire mode_count, pulse, time_out, CR_Ena;
    wire [2:0] CR_LED, HW_LED;
    wire [5:0] time_display;

    pulse_1s pulse_gen(.clk(clk), .rst_n(rst_n), .pulse(pulse));
    Timer timer(.clk(clk), .rst_n(rst_n), .mode_count(mode_count), .pulse(pulse), .time_out(time_out), .time_display(time_display));
    HW_Controller hw_controller(.clk(clk), .rst_n(rst_n), .sensor(sensor), .mode_count(mode_count), .CR_Ena(CR_Ena), .HW_LED(HW_LED), .time_out(time_out));
    CR_Controller cr_controller(.clk(clk), .rst_n(rst_n), .CR_Ena(CR_Ena), .time_out(time_out), .CR_LED(CR_LED));


    always #1 clk = ~clk;
    initial begin
        clk = 0;
        sensor = 0;
        rst_n = 1; #20;
        rst_n = 0; #50;
        rst_n = 1; #20;
        sensor = 1;
        #500;
        sensor = 0;
        #20;
        #500;
        sensor = 1;
        
    end
endmodule