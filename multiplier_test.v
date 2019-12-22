`timescale 1ns/1ps

module multiplier_test;

localparam width = 4;
localparam [width-1 : 0] max_num = (1 << width) - 1;

reg clk;
reg [width-1 : 0] a, b;
wire [2*width-1 : 0] res;

initial begin
    clk = 1'b0;
    a = 0;
    b = 0;
end

always #1 clk = ~clk;

always @(posedge clk) begin
    a <= a + 1;
end

always @(posedge clk) begin
    if (a == max_num)
        b <= b + 1;
    else
        b <= b;
end

always @(posedge clk) begin
    if (b == max_num && a == max_num)
        $stop;
    if (res != a * b)
        $display("a = ", a, " b = ", b, " error occor!");
end

multiplier #(
    .width(width)
) mul0 (
    .a(a),
    .b(b),
    .res(res)
);

endmodule // multiplier_test
