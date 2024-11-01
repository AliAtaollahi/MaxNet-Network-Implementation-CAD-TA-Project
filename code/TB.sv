`timescale 1ns/1ps

module tb_convolution2D();
    localparam int N = 5;
    localparam int K = 3;
    
    logic clk;
    logic rst_n;
    logic start;
    logic done;
    logic [7:0] image[N][N] = '{'{8'h00, 8'h01, 8'h02, 8'h03, 8'h03},
                                '{8'h04, 8'h05, 8'h06, 8'h07, 8'h07},
                                '{8'h08, 8'h09, 8'h0A, 8'h0B, 8'h0B},
                                '{8'h0C, 8'h0D, 8'h0E, 8'h0F, 8'h0F},
                                '{8'h00, 8'h01, 8'h02, 8'h03, 8'h03}};
    logic [7:0] kernel[K][K] = '{'{8'h00, 8'h01, 8'h02},
                                '{8'h03, 8'h04, 8'h05},
                                '{8'h06, 8'h07, 8'h08}};
    logic signed [15:0] result[N-K+1][N-K+1];

    convolution2D #(.N(N), .K(K)) conv2D (
        .clk(clk),
        .rst_n(rst_n),
        .image(image),
        .kernel(kernel),
        .start(start),
        .done(done),
        .result(result)
    );

    always begin
        #10 clk = ~clk;
    end

    initial begin
        clk = 1'b0;
        rst_n = 1'b0;
        start = 1'b0;
        
        #10;
        rst_n = 1'b1;
        
        @(negedge clk);
        start = 1'b1;

        @(posedge done);
        start = 1'b0;

        #1000
        
        // Print the result
        $display("Result:");
        for (int i = 0; i < (N-K+1); i++) begin
            for (int j = 0; j < (N-K+1); j++) begin
                $display("[%0d][%0d]: %0d", i, j, result[i][j]);
            end
        end

        #1000
        $stop;
    end

endmodule
