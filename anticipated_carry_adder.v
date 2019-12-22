module anticipated_carry_adder #(
    parameter width = 4
)(
    input  wire [width-1 : 0] a,
                [width-1 : 0] b,
                              cin,
    output wire [width-1 : 0] sum,
                              cout
);

wire [width-1 : 0] g, p;
wire [width   : 0] c;

assign g = a & b;
assign p = a ^ b;
assign c[0] = cin;
assign c[width : 1] = g[width-1 : 0] | (p[width-1 : 0] & c[width-1 : 0]);
assign cout = c[width];

genvar i;
generate
    for (i = 0; i < width; i = i+1) begin : full_adders
        full_adder fa(
            .a(a[i]),
            .b(b[i]),
            .cin(c[i]),
            .sum(sum[i]),
            .cout()
        );
    end
endgenerate

endmodule // anticipated_carry_adder
