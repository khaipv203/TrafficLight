module TrafficLight (
    input clk, rst_n, sensor,
    output [2:0] CR_LED, HW_LED,
    output [13:0] display
);
    wire mode_count, pulse, time_out, CR_Ena;
    wire [5:0] time_display;

    pulse_1s pulse_gen(.clk(clk), .rst_n(rst_n), .pulse(pulse));
    Timer timer(.clk(clk), .rst_n(rst_n), .mode_count(mode_count), .pulse(pulse), .time_out(time_out), .time_display(time_display));
    HW_Controller hw_controller(.clk(clk), .rst_n(rst_n), .sensor(sensor), .mode_count(mode_count), .CR_Ena(CR_Ena), .HW_LED(HW_LED), .time_out(time_out));
    CR_Controller cr_controller(.clk(clk), .rst_n(rst_n), .CR_Ena(CR_Ena), .time_out(time_out), .CR_LED(CR_LED));
    display display_module(.bin(time_display), .display(display));
endmodule