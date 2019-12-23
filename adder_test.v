`timescale 1ns/1ps

module adder_test;

localparam width = 8;
localparam [width-1 : 0] max_num = (1 << width) - 1;

reg clk;
reg [width-1 : 0] a, b;
wire [width-1 : 0] rc_sum, ac_sum, pt_sum;
wire rc_cout, ac_cout, pt_cout;

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
    if ((rc_sum != ac_sum) || (rc_cout != ac_cout) || (rc_sum != pt_sum) || (rc_cout != pt_cout))
        $display("a = ", a, " b = ", b, " error occour!");
end

ripply_carry_adder #(
    .width(width)
) rc_adder (
    .a(a),
    .b(b),
    .cin(1'b0),
    .sum(rc_sum),
    .cout(rc_cout)
);

anticipated_carry_adder #(
    .block_width(4),
    .width(width)
) ac_adder (
    .a(a),
    .b(b),
    .cin(1'b0),
    .sum(ac_sum),
    .cout(ac_cout)
);

prefix_tree_adder #(
    .width(width)
) pt_adder (
    .a(a),
    .b(b),
    .cin(1'b0),
    .sum(pt_sum),
    .cout(pt_cout)
);

endmodule // adder_test
