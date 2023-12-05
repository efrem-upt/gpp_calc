module SP(
  input clk,rst,inc,dec,
  output reg [15:0] out);
  
  always @(negedge clk, negedge rst)
  begin
     if (!rst) begin
        out <= 16'b0000000111111111;
     end   
   else if (dec && out > 16'b0000000100000000) begin
        out <= out - 16'd1;
   end 
  else if (inc && out < 16'b0000000111111111) begin
        out <= out + 16'd1;  
  end
  end
  
endmodule
