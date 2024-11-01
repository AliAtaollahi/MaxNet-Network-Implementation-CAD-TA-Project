
module Conv_TopLevel_Controller
(input clk, input ready , input conv_done, input max_pool_done, 
output logic rst, output logic cin, output logic out_sel, output logic in_sel);

  logic [3:0] ps, ns;

  parameter [3:0] Idle = 0, start = 1, Kernel_Conv = 2, Max_Pool = 3;

  
  always @(ps, ready,conv_done,max_pool_done) begin
    ns = Idle;
    case(ps)
    Idle: begin 
        rst = 1 ; ns = ready ? start : Idle; 
    end
    start: begin 
        rst = 0 ; ns = start ? start : Kernel_Conv; 
    end
    Kernel_Conv: begin 
        cin = 1'b1;
        out_sel = 1'b0;
        in_sel = 1'b0;
        ns = conv_done ? Max_Pool : Kernel_Conv; 
    end

    Max_Pool: begin 
        cin = 1'b1;
        out_sel = 1'b1;
        in_sel = 1'b1;
        ns = max_pool_done ? Idle : Max_Pool; 
    end
      default: ns = Idle;
    endcase
  end

  always @(posedge clk)begin
    ps <= ns;
  end
  
endmodule