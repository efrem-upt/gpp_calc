module IM(
  input [9:0] addr,
  input rst,
  output reg [15:0] out
);

reg [15:0] rom [1023:0];

always @(negedge rst) begin
  if (!rst) begin
    out <= rom[0];   
 end
end

always @(*) begin
    out <= rom[addr];
end

endmodule
