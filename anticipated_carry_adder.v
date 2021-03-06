module adder_block #(
    parameter block_width = 4
)(
    input  wire [block_width-1 : 0] a,
                                    b,
           wire                     cin,
    output wire [block_width-1 : 0] sum,
           wire                     cout
);

wire [block_width : 0] c;
wire [block_width-1 : 0] p, g, g_all;
wire p_all;

assign c[0] = cin;
assign p = a ^ b;
assign g = a & b;
assign p_all = &p;
assign g_all[0] = g[0];
assign g_all[block_width-1 : 1] = (p[block_width-1 : 1] & g_all[block_width-2 : 0]) | g[block_width-1 : 1];
assign cout = (cin & p_all) | g_all[block_width-1];

genvar i;
generate
    for (i=0; i<block_width; i=i+1) begin : full_adders
        full_adder fa(
            .a(a[i]),
            .b(b[i]),
            .cin(c[i]),
            .sum(sum[i]),
            .cout(c[i+1])
        );
    end
endgenerate

endmodule // carry_block


module anticipated_carry_adder #(
    parameter block_width = 4,
    parameter width = 32
)(
    input  wire [width-1 : 0] a,
                              b,
           wire               cin,
    output wire [width-1 : 0] sum,
           wire               cout
);

localparam block_num = width / block_width;
wire [block_num : 0] c;
assign c[0] = cin;
assign cout = c[block_num];

genvar i;
generate
    for (i = 0; i < block_num; i = i+1) begin : adder_blocks
        adder_block #(
            .block_width(block_width)
        ) ab (
            .a(a[(i+1)*block_width-1 : i*block_width]),
            .b(b[(i+1)*block_width-1 : i*block_width]),
            .cin(c[i]),
            .sum(sum[(i+1)*block_width-1 : i*block_width]),
            .cout(c[i+1])
        );
    end
endgenerate

endmodule // anticipated_carry_adder
