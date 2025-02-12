module mac_manual #(
	parameter N = 16
    )(
    input clk,sclr,ce,
    input [N-1:0] a,
    input [N-1:0] b,
    input [N-1:0] c,
    output reg [N-1:0] p
    );

    assign p = a*b+c;
endmodule

