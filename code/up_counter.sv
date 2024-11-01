module bit_counter (
  input clk,
  input reset,
  input cin,
  output reg [3:0] count,
  output reg co
);

parameter M = 15;

always @(posedge clk) begin
    co = 1'b0;
    if (reset) begin
        count <= 0;
    end else begin
        if (count == M) begin
            count <= 0;
            co = 1'b1;
        end else begin
            count <= count + cin;
        end
    end
end

endmodule
