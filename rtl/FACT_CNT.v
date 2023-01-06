module FACT_CNT(
  input [8:0] cnt,
  input clk, rst, w,
  output reg [8:0] out,
  output reg FACT_END);
  
  always @(posedge clk, negedge rst) begin
    if (!rst) begin
      out = 9'd0; 
      FACT_END = 1'd0; 
    end
    else begin
       if (w) out = cnt;
       else if (out > 9'd0) out = out - 9'd1; 
       
       if (out == 9'd1) FACT_END = 1'd1;  
       else if (out == 9'd0) FACT_END = 1'd0;
    end
  end
  
  
  
endmodule
