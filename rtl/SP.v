module SP(
  input clk,rst,inc,dec,
  output reg [15:0] out);
  
  always @(negedge clk, negedge rst)
  begin
     if (!rst) begin
        out <= 16'b0000000111111111;
     end   
   else if (dec) begin
        out <= out - 16'd1;
   end 
  end
  
  always @(*) begin
    if (clk && inc && out < 16'b0000000111111111) begin
        out <= out + 16'd1;  
   end
  end
  
endmodule
