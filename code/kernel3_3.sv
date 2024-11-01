module convolution2D #(parameter int N = 8, parameter int K = 3) (
    input logic clk,
    input logic rst_n,
    input logic start,
    input logic [7:0] image[N][N],
    input logic [7:0] kernel[K][K],
    output logic done,
    output logic signed [15:0] result[N-K+1][N-K+1]
);

    logic [15:0] product;
    logic signed [31:0] acc;
    int i, j, k, l;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            done <= 1'b0;
            for (i = 0; i < N-K+1; i++) begin
                for (j = 0; j < N-K+1; j++) begin
                    result[i][j] <= 16'h0000;
                end
            end
        end else if (start) begin
            done <= 1'b0;
            for (i = 0; i < N-K+1; i++) begin
                for (j = 0; j < N-K+1; j++) begin
                    acc = 32'h0000_0000;
                    for (k = 0; k < K; k++) begin
                        for (l = 0; l < K; l++) begin
                            product = image[i+k][j+l] * kernel[k][l];
                            acc += product;
                        end
                    end
                    result[i][j] <= acc[15:0];
                end
            end
            done <= 1'b1;
        end
    end

endmodule
