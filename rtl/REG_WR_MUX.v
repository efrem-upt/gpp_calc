module REG_WR_MUX(
  input [15:0] in_ALU,
  input [15:0] in_MOV,
  input [15:0] in_DM,
  input [15:0] in_ACC_TRANSFER,
  input ALU,MOV,L,TR,
  output reg [15:0] in
);

always @(*) begin
  if (ALU)
    in <= in_ALU;
  else if (MOV)
    in <= in_MOV;
  else if (L)
    in <= in_DM; 
  else if (TR)
    in <= in_ACC_TRANSFER;
end

endmodule
