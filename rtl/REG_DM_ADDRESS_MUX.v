module REG_DM_ADDRESS_MUX(
  input [8:0] in_LS_immediate,
  input [8:0] in_SP_val,
  input L,S,STACK_PSH,STACK_POP,
  output reg [8:0] in
);

always @(*) begin
  if ((L || S) && ~(STACK_PSH || STACK_POP))
    in <= in_LS_immediate;
  else if (STACK_PSH || STACK_POP)
    in <= in_SP_val;
end

endmodule


