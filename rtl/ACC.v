module ACC(
  input [15:0] in,
  input clk,rst,w,
  output reg [15:0] out);
  
  always @(negedge clk, negedge rst)
  begin
     if (!rst) begin
        out <= 16'd0;
     end   
   else if (w) begin
        out <= in;  
   end
  end
  
endmodule


