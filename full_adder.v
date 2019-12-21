module full_adder(
    input wire a, b, cin,
    output wire sum, cout
);

wire p, g;

assign p = a ^ b;
assign g = a & b;
assign sum = p ^ cin;
assign cout = g | (p & cin);

endmodule // full_adder
