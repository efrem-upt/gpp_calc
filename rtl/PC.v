module PC(
  input [15:0] in,
  input clk,rst,w,BRA,STACK_POP,
  output reg [15:0] out
);

always @(negedge clk, negedge rst) begin
  if (!rst) begin
    out <= 16'd0;
  end
  else if (w && STACK_POP) begin
    #1
    out <= in + 16'd2;
  end
  else if (w && BRA) begin
    out <= in;
  end
  else begin
    out <= out + 16'd1;
  end
end

endmodule