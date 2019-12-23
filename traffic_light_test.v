`timescale 1ns/1ps

module traffic_light_test;

reg clk, rstn;
wire red, green, yellow;

initial begin
    clk = 1'b0;
    rstn = 1'b0;
    #4 rstn = 1'b1;
end

always #1 clk = ~clk;

traffic_light tl (
    .clk(clk),
    .rstn(rstn),
    .green(green),
    .red(red),
    .yellow(yellow)
);

endmodule // traffic_light_test
