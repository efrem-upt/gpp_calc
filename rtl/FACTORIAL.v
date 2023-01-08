module FACTORIAL(
  input [8:0] val,
  input clk, rst, FACT, 
  input [15:0] ALU_mul,
  output reg FACT_END
  );
  
wire [8:0] current_iteration;
wire [15:0] fact_out;
wire FACT_END_CNT;
FACT_CNT counter(.cnt(val),.clk(clk),.rst(rst), .w(~(| current_iteration) & FACT), .out(current_iteration), .FACT_END(FACT_END_CNT));
FACT_reg factreg(.in(ALU_mul),.clk(clk),.rst(rst & (| current_iteration)),.w(~FACT_END & (| current_iteration)),.out(fact_out));


always @(*) begin
    FACT_END = FACT_END_CNT;
end
endmodule

