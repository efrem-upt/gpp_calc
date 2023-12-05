module IR(
  input [15:0] in,
  input clk,rst,w,
  output reg [15:0] out,
  output reg [5:0] opcode,
  output reg RA,
  output reg [9:0] BA,
  output reg [8:0] IMM,
  output reg [1:0] RA_stack
);

always @(negedge clk, negedge rst) begin
    if (!rst) begin
      out <= 16'd0;
      RA <= 1'd0;
      BA <= 10'd0;
      IMM <= 9'd0;
      RA_stack <= 2'd0;
  end
    else if (w) begin
      out <= in;
      opcode <= in[15:10];
      RA <= in[9];
      RA_stack <= in[9:8];
      BA <= in[9:0];
      IMM <= in[8:0];
    end
end

endmodule      