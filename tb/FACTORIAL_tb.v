module FACTORIAL_tb;
reg [8:0] val;
reg clk, rst, FACT;
wire [15:0] ALU_mul;
wire FACT_END;

ALU ArithmeticLogicUnit(.ACC(16'd0),.X(16'd0),.Y(16'd0),.Immediate(16'd0),.fact_reg(instantaFACTORIAL.fact_out),.fact_val({ {7{1'b0}}, instantaFACTORIAL.current_iteration[8:0] }),.opcode(6'b011101),.en(1'd1),.clk(clk),.rst(rst),.RA(1'd0),.res(ALU_mul));
FACTORIAL instantaFACTORIAL(.val(val), .clk(clk), .rst(rst), .FACT(FACT), .ALU_mul(ALU_mul), .FACT_END(FACT_END));

initial begin
  val = 9'd5;
  clk = 1'd0;
  rst = 1'd0;
  FACT = 1'd1;
  #15
  rst = 1'd1;
  #5
  test_FACT_ITERATION_1;
  test_FACT_ITERATION_2;
  test_FACT_ITERATION_3;
  test_FACT_ITERATION_4;
  $stop;
  $finish;
end

task test_FACT_ITERATION_1;
begin
  #10 clk = 1'd1;
  $write(" FACT_ITERATION_1 \t");
  #2
  if (ALU_mul == 16'd5)
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, ALU_mul, 16'd5);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_FACT_ITERATION_2;
begin
  #10 clk = 1'd1;
  $write(" FACT_ITERATION_2 \t");
  #2
  if (ALU_mul == 16'd20)
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, ALU_mul, 16'd20);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_FACT_ITERATION_3;
begin
  #10 clk = 1'd1;
  $write(" FACT_ITERATION_3 \t");
  #2
  if (ALU_mul == 16'd60)
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, ALU_mul, 16'd60);
	$write("\n");
	#10 clk = 1'd0;
end
endtask


task test_FACT_ITERATION_4;
begin
  #10 clk = 1'd1;
  $write(" FACT_ITERATION_4 \t");
  #2
  if (ALU_mul == 16'd120)
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, ALU_mul, 16'd120);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

endmodule