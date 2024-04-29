`timescale 1ps/1ps
module test ();
    reg clk, rst_n, sensor;
    // wire cr_time_out, hw_time_out;
    wire [2:0] CR_LED, HW_LED;
    // wire [6:0] hw_time, cr_time;
    wire [13:0] cr_time_display, hw_time_display;

    // HW_Timer timer0(.clk(clk), .rst_n(rst_n), .sensor(sensor), .hw_time_out(hw_time_out), .hw_time(hw_time));
    // CR_Timer timer1(.clk(clk), .rst_n(rst_n), .sensor(sensor), .cr_time_out(cr_time_out), .cr_time(cr_time));
    // HW_Controller hw_controller(.clk(clk), .rst_n(rst_n), .sensor(sensor), .HW_LED(HW_LED), .time_out(hw_time_out));
    // CR_Controller cr_controller(.clk(clk), .rst_n(rst_n), .sensor(sensor), .time_out(cr_time_out), .CR_LED(CR_LED));
    TrafficLight module_1(.clk(clk), .rst_n(rst_n), .sensor(sensor), .cr_time_display(cr_time_display), .hw_time_display(hw_time_display), .CR_LED(CR_LED), .HW_LED(HW_LED));

    always #1 clk = ~clk;
    initial begin
        clk = 0;
        sensor = 0;
        rst_n = 1; #200;
        rst_n = 0; #500;
        rst_n = 1; #200;
        sensor = 1;
        #10000;
        sensor = 0;
        #10000;
        sensor = 1;
        #10000;
        sensor = 0;
        
    end
endmodule