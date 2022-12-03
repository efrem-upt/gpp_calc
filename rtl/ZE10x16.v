module ZE10x16(
  input [9:0] in,
  output reg [15:0] out
);

always @(*) begin
  out <= { {6{1'b0}}, in[9:0] };
end

endmodule

