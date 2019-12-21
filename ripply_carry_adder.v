module ripply_carry_adder #(
    parameter width = 4
)(
    input  wire [width-1 : 0] a,
                [width-1 : 0] b,
                              cin,
    output wire [width-1 : 0] sum,
                              cout
);

wire [width-2 : 0] c;

full_adder fa_0(
    .a(a[0]),
    .b(b[0]),
    .cin(cin),
    .sum(sum[0]),
    .cout(c[0])
);

full_adder fa_width_1(
    .a(a[width-1]),
    .b(b[width-1]),
    .cin(c[width-2]),
    .sum(sum[width-1]),
    .cout(cout)
);

genvar i;
generate
    for (i=1; i<width-1; i = i+1) begin : full_adders
        full_adder fa(
            .a(a[i]),
            .b(b[i]),
            .cin(c[i-1]),
            .sum(sum[i]),
            .cout(c[i])
        );
    end
endgenerate

endmodule // ripply_carry_adder
