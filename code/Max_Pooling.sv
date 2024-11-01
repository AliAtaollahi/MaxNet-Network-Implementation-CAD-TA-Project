module max_pool #(
    parameter N = 32,  // Image size (N*N)
    parameter K = 2    // Kernel size (K*K)
)(
  input wire clk,
  input wire rst,
  input wire [N-1:0][N-1:0][7:0] image_in,
  output wire [N/K-1:0][N/K-1:0][7:0] image_out
);

  generate
    genvar i, j;
    for (i = 0; i < N/K; i++) begin
      for (j = 0; j < N/K; j++) begin
        logic [7:0] max_pixel;

        always @(posedge clk or posedge rst) begin
          integer m, n;
          if (rst) begin
            max_pixel <= '0;
          end else begin
            max_pixel <= '0;
            for (m = 0; m < K; m++) begin
              for (n = 0; n < K; n++) begin
                if (image_in[i*K+m][j*K+n] > max_pixel)
                  max_pixel <= image_in[i*K+m][j*K+n];
              end
            end
          end
        end

        assign image_out[i][j] = max_pixel;
      end
    end
  endgenerate

endmodule
