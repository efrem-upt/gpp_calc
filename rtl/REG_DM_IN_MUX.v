module REG_DM_IN_MUX(
  input [15:0] in_X,
  input [15:0] in_Y,
  input [15:0] in_ACC,
  input [15:0] in_PC,
  input X_select,Y_select,ACC_select,PC_select,S,
  output reg [15:0] in
);

always @(*) begin
  if (S && X_select)
    in <= in_X;
  else if (S && Y_select)
    in <= in_Y;
  else if (S && ACC_select)
    in <= in_ACC; 
  else if (S && PC_select)
    in <= in_PC;
end

endmodule

