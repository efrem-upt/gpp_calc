module PCInputDecider(
   input [15:0] POP_input,
   input [15:0] BRA_input,
   input STACK_POP, BRA,
   output reg [15:0] PC_in
);

always @(*) begin
    if (STACK_POP) begin
      PC_in <= POP_input; 
    end
    else if (BRA) begin
      PC_in <= BRA_input;
    end
end

endmodule
