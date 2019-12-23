module traffic_light (
    input wire clk,
               rstn,
    output wire green,
                red,
                yellow
);

reg [7 : 0] cnt;
wire [7 : 0] cnt_next;
reg [2 : 0] state;  // one-hot
wire change_state;

assign green = state[2];
assign red = state[1];
assign yellow = state[0];

assign change_state = ((state[2] == 1'b1) && (cnt == 8'd27)) ||
                      ((state[1] == 1'b1) && (cnt == 8'd30)) ||
                      ((state[0] == 1'b1) && (cnt == 8'd3));

prefix_tree_adder #(
    .width(8)
) pta (
    .a(cnt),
    .b(8'b1),
    .cin(1'b0),
    .sum(cnt_next),
    .cout()
);

always @(posedge clk or negedge rstn) begin
    if (rstn == 1'b0) begin
        state <= 3'b001;
    end else begin
        if (change_state)
            state <= {state[1 : 0], state[2]};
        else
            state <= state;
    end
end

always @(posedge clk or negedge rstn) begin
    if (rstn == 1'b0 || change_state) begin
        cnt <= 8'b0;
    end else begin
        cnt <= cnt_next;
    end
end

endmodule // traffic_light
