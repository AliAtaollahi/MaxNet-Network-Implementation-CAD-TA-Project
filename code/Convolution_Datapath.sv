module Convolution_Datapath(
    input clk,
    input [7:0] image_in[0:9][0:9],
    input [7:0] weights[0:2][0:2],
    input rst, input logic cin, input logic out_sel, input logic in_sel, input start,
    output ready , output conv_done, output max_pool_done,
    output [15:0] conv_result[0:7][0:7]
);

    logic [3:0] i;
    logic [3:0] j;
    wire co;
    // We use these two counters to iterate through N-K+1
    bit_counter #(.M(8)) (clk,reset,co,i,conv_done);
    bit_counter #(.M(8)) (clk,reset,cin,j,co);

    // Window Selector

    logic [7:0] window[0:2][0:2];

    window_selector_KxK  #(.K(10),.M(3)) (clk,image_in, window, i, j);

    // Conv
    logic [15:0] res[0:7][0:7];
    convolution2D #(.N(10), .K(3)) (clk,rst,start,image_in,weights,conv_done,res);

    // Shift Register for Conv
    wire [7:0] d_in;
    shift_register #(.M(10)) (clk, reset, res, d_in, conv_result);
endmodule
