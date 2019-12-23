module multiplier #(
    parameter width = 4
)(
    input  wire [width-1 : 0] a,
                              b,
    output wire [2*width-1 : 0] res
);

wire [2*width-1 : 0] sum [0 : width];
assign sum[0] = 0;
assign res = sum[width];

genvar i;
generate
    for (i=0; i<width; i = i+1) begin : adders
        prefix_tree_adder #(
            .width(2*width)
        ) pt_adder (
            .a((b & (1 << i)) ? a << i : 0),
            .b(sum[i]),
            .cin(1'b0),
            .sum(sum[i+1]),
            .cout()
        );
    end
endgenerate

endmodule // multiplier