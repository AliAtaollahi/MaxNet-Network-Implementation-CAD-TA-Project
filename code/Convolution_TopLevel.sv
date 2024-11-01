module Conv3x3(
    input clk,
    input [7:0] image_in[0:9][0:9],
    input [7:0] weights[0:2][0:2],
    output [15:0] conv_result[0:7][0:7]
);
    wire  rst, cin, out_sel, in_sel, start, ready , conv_done, max_pool_done;


    
endmodule