module IM(
  input [9:0] addr,
  input en,
  input rst,
  output reg [15:0] out
);

reg [15:0] rom [1023:0];

always @(negedge rst) begin
  if (!rst) begin
    out <= 16'bx;  
 end
end

always @(*) begin
	 if (rst & en) begin
		out <= rom[addr];
	 end
end

endmodule
