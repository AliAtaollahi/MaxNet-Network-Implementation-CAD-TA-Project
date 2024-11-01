`timescale 1ns / 1ps

module tb_max_pool();
  parameter N = 5;  // Image size (N*N)
  parameter K = 2;  // Kernel size (K*K)

  reg clk;
  reg rst;
  reg [N-1:0][N-1:0][7:0] image_in;
  wire [N/K-1:0][N/K-1:0][7:0] image_out;

  max_pool #(.N(N), .K(K)) max_pool_inst (
    .clk(clk),
    .rst(rst),
    .image_in(image_in),
    .image_out(image_out)
  );

  always begin
    #5 clk = ~clk;
  end

  initial begin
    image_in[0][0] = 8'h00;
    image_in[0][1] = 8'h01;
    image_in[0][2] = 8'h02;
    image_in[0][3] = 8'h03;
    image_in[0][4] = 8'h04;

    image_in[1][0] = 8'h05;
    image_in[1][1] = 8'h06;
    image_in[1][2] = 8'h07;
    image_in[1][3] = 8'h08;
    image_in[1][4] = 8'h09;

    image_in[2][0] = 8'h0A;
    image_in[2][1] = 8'h0B;
    image_in[2][2] = 8'h0C;
    image_in[2][3] = 8'h0D;
    image_in[2][4] = 8'h0E;

    image_in[3][0] = 8'h0F;
    image_in[3][1] = 8'h10;
    image_in[3][2] = 8'h11;
    image_in[3][3] = 8'h12;
    image_in[3][4] = 8'h13;

    clk = 0;
    rst = 1;

    #10 rst = 0;

    #50;

    $display("Result");
    $display("[0][0]: %0d",image_out[0][0]);
    $display("[0][1]: %0d",image_out[0][1]);
    $display("[1][0]: %0d",image_out[1][0]);
    $display("[1][1]: %0d",image_out[1][1]);
    
    #1000
    $stop;
  end
endmodule
