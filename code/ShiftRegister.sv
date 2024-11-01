module shift_register #(parameter M = 10) (input clk, input reset, input [7:0] data_in, output reg [7:0] data_out, output [7:0] PO[0:M-1]);
  reg [7:0] cells[0:M-1];
  integer i;

    always @(posedge reset) begin
        for (i = 0; i < M; i++)
            cells[i] <= 0;
    end

    always @(posedge clk) begin
        for (i = M-1; i > 0; i--)
            cells[i] <= cells[i-1];
        cells[0] <= data_in;
    end

    assign data_out = cells[M-1];
    assign PO = cells;
endmodule