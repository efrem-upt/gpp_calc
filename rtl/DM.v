module DM(
  input signed [15:0] in,
  input [8:0] addr,
  input clk,rst,w,
  output reg signed [15:0] out
);

reg signed [15:0] ram [511:0];

always @(negedge rst) begin
  if (!rst) begin
    out <= ram[0];   
 end
end

always @(*) begin
  out <= ram[addr];
end

always @(negedge clk) begin
  if (w) begin
    ram[addr] <= in;
 end
end

endmodule