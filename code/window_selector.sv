module window_selector_KxK #(parameter K = 3,parameter M = 3) (input clk,input [7:0] A[0:M-1][0:M-1], output reg [7:0] B[0:K-1][0:K-1], input i, j);
  reg [7:0] temp [0:K-1][0:K-1];

  // Compute the window based on the start position (i, j)
  always @(posedge clk) begin
    for (int x = 0; x < K; x++)
      for (int y = 0; y < K; y++)
        temp[x][y] = A[i+x][j+y];
  end

  // Assign the computed window to the output
  always @(posedge clk) begin
    B = temp;
  end
endmodule