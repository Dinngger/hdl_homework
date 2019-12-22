module ripply_carry_adder #(
    parameter width = 4
)(
    input  wire [width-1 : 0] a,
                [width-1 : 0] b,
                              cin,
    output wire [width-1 : 0] sum,
                              cout
);

wire [width : 0] c;
assign c[0] = cin;
assign cout = c[width];

genvar i;
generate
    for (i = 0; i < width; i = i+1) begin : full_adders
        full_adder fa(
            .a(a[i]),
            .b(b[i]),
            .cin(c[i]),
            .sum(sum[i]),
            .cout(c[i+1])
        );
    end
endgenerate

endmodule // ripply_carry_adder
