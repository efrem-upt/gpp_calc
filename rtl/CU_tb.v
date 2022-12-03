module CU_tb;
reg [5:0] opcode;
reg clk;
reg rst;
wire ALU;
wire BRA;
wire L;
wire S;
wire TR;
wire IMM;
wire STACK;
wire MOV;

CU ControlUnit(.opcode(opcode),.clk(clk),.rst(rst),.ALU(ALU),.BRA(BRA),.L(L),.S(S),.TR(TR),.IMM(IMM),.STACK(STACK),.MOV(MOV));

initial begin
  opcode <= 6'b111111;
  clk <= 1'd0;
  rst <= 1'd1;
  #2 rst <=  1'd0;
  #1 rst <= 1'd1;
  forever #3 clk <= ~clk;
end

always begin
  #6 opcode <= opcode + 6'd1;
end

endmodule