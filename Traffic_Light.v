module TrafficLight (
    input clk, rst_n, sensor,
    output [2:0] CR_LED, HW_LED,
    output [13:0] cr_time_display, hw_time_display
    
);
    wire [6:0] hw_time, cr_time;
    wire cr_time_out, hw_time_out;

    HW_Timer timer0(.clk(clk), .rst_n(rst_n), .sensor(sensor), .hw_time_out(hw_time_out), .hw_time(hw_time));
    CR_Timer timer1(.clk(clk), .rst_n(rst_n), .sensor(sensor), .cr_time_out(cr_time_out), .cr_time(cr_time));
    HW_Controller hw_controller(.clk(clk), .rst_n(rst_n), .sensor(sensor), .HW_LED(HW_LED), .time_out(hw_time_out));
    CR_Controller cr_controller(.clk(clk), .rst_n(rst_n), .sensor(sensor), .time_out(cr_time_out), .CR_LED(CR_LED));
    display disp_module_hw(.bin(hw_time), .display(hw_time_display));
    display disp_module_cr(.bin(cr_time), .display(cr_time_display));
endmodule