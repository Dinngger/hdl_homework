module prefix_tree_adder #(
    parameter width = 4
)(
    input  wire [width-1 : 0] a,
                              b,
           wire               cin,
    output wire [width-1 : 0] sum,
           wire               cout
);

function integer clogb2 (
    input integer depth
);
    begin
        for (clogb2 = 0; depth > 0; clogb2 = clogb2+1) 
            depth = depth >> 1;                          
    end
endfunction

localparam depth = clogb2(width+1);

reg [width : 0] g [0 : depth],
                p [0 : depth];

assign cout = g[depth][width];

always @(*) begin : prefix_tree
    integer i, j, src;
    g[0][width : 1] = a & b;
    p[0][width : 1] = a ^ b;
    g[0][0] = 1'b0;
    p[0][0] = 1'b0;
    for (i = 1; i < depth+1; i = i+1) begin
        for (j = 0; j < width+1; j = j+1) begin
            src = j - (j & ((1 << (i-1)) - 1)) - 1;
            if ((j >> (i-1)) & 1 == 1) begin
                g[i][j] = g[i-1][j] | (g[i-1][src] & p[i-1][j]);
                p[i][j] = p[i-1][j] & p[i-1][src];
            end else begin
                g[i][j] = g[i-1][j];
                p[i][j] = p[i-1][j];
            end
        end
    end
end

genvar gen_i;
generate
    for (gen_i = 0; gen_i < width; gen_i = gen_i+1) begin : full_adders
        full_adder fa(
            .a(a[gen_i]),
            .b(b[gen_i]),
            .cin(g[depth][gen_i]),
            .sum(sum[gen_i]),
            .cout()
        );
    end
endgenerate

endmodule // prefix_tree_adder
