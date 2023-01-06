module F2(
  input [15:0] in,
  input clk,rst,w,
  output reg [15:0] out);
  
  always @(negedge clk, negedge rst)
  begin
     if (!rst) begin
        out <= 16'd1;
     end   
   else if (w) begin
        #1
        out <= in;  
   end
  end
  
endmodule

