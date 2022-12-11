module DM(
  input [15:0] in,
  input [8:0] addr,
  input clk,rst,w,
  output reg [15:0] out
);

reg [15:0] ram [511:0];

always @(negedge rst) begin
  if (!rst) begin
    out <= ram[0];   
 end
end

always @(*) begin
  if (clk && w) begin
    ram[addr] <= in;
 end
  out <= ram[addr];
end

endmodule