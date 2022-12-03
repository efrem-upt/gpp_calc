module IR_tb;
reg [15:0] in;
reg clk;
reg rst;
reg w;
wire [15:0] out;
wire [5:0] opcode;
wire RA;
wire [9:0] BA;
wire [8:0] IMM;
wire [1:0] RA_stack;

IR InstructionRegister (.in(in),.clk(clk),.rst(rst),.w(w),.out(out),.opcode(opcode),.RA(RA),.BA(BA),.IMM(IMM),.RA_stack(RA_stack));

initial begin
  in <= 16'd0;
  clk <= 1'd0;
  rst <= 1'd1;
  w <= 1'd0;
  forever #2 clk <= ~clk;
end

always begin
  #2 in <= in + 16'd1;
  #10 w <= 1'd1;
end

endmodule