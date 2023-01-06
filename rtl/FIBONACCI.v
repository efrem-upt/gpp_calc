module FIBONACCI(
  input [8:0] pos,
  input clk, rst, FIB, 
  input [15:0] ALU_sum,
  output reg FIB_END
  );
  
wire [8:0] current_iteration;
wire [15:0] F1_out;
wire [15:0] F2_out;
wire [15:0] F3_out;
wire FIB_END_CNT;
FIB_CNT counter(.cnt(pos),.clk(clk),.rst(rst), .w(~(| current_iteration) & FIB), .out(current_iteration), .FIB_END(FIB_END_CNT));
F1 F1(.in(F2_out),.clk(clk),.rst(rst & (| current_iteration)),.w(~FIB_END & (| current_iteration)),.out(F1_out));
F2 F2(.in(F3_out),.clk(clk),.rst(rst & (| current_iteration)),.w(~FIB_END & (| current_iteration)),.out(F2_out));
F3 F3(.in(ALU_sum),.clk(clk),.rst(rst & (| current_iteration)),.w(~FIB_END & (| current_iteration)),.out(F3_out));

always @(*) begin
    FIB_END = FIB_END_CNT;
end
endmodule
