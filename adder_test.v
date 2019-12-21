`timescale 1ns/1ps

module adder_test;

localparam width = 8;
localparam [width-1 : 0] max_num = (1 << width) - 1;

reg clk;
reg [width-1 : 0] a;
reg [width-1 : 0] b;
wire [width-1 : 0] sum;
wire cout;

initial begin
    clk = 1'b0;
    a = 0;
    b = 0;
end

always #1 clk = ~clk;

always @(posedge clk) begin
    if (b == max_num && a == max_num)
        $stop;
end

always @(posedge clk) begin
    if (a == max_num)
        b = b + 1;
    else
        b = b;
end

always @(posedge clk) begin
    a = a + 1;
end

ripply_carry_adder #(
    .width(width)
) rc_adder (
    .a(a),
    .b(b),
    .cin(1'b0),
    .sum(sum),
    .cout(cout)
);

endmodule // adder_test
