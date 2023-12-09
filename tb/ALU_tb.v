module ALU_tb;
// Inputs
reg signed [15:0] ACC,X,Y,Immediate;
reg [15:0] fact_reg, fact_val;
reg [5:0] opcode;
reg en,clk,rst,RA;

//Outputs
wire signed [15:0] res;
wire [3:0] flags;

// Instantiate the Unit Under Test (UUT)
ALU ArithmeticLogicUnit(.ACC(ACC), .X(X), .Y(Y), .Immediate(Immediate), .fact_reg(fact_reg), .fact_val(fact_val), .opcode(opcode), .en(en), .clk(clk), .rst(rst), .RA(RA), .res(res), .flags(flags));

initial begin
		// Initialize Inputs
		opcode = 6'd0;
		clk = 1'd0;
		rst = 1'd0;
		Immediate = 16'd0;
		RA = 1'd0;
		en = 1'd0;
		ACC = 16'd0;
		// Wait 30 ns for global reset to finish
		#30;
		rst = 1'd1;
		en = 1'd1;
		// Add stimulus here
		#5
			test_ADD_X;
			test_ADD_Y;
			test_ADD_Y_OVERFLOW;
			test_ADD_Y_ZERO_AND_CARRY;
			test_ADD_Y_NEGATIVE;
			test_ADD_X_Immediate;
			test_ADD_Y_Immediate;
			
			test_SUB_X;
			test_SUB_Y_BORROW;
			test_SUB_Y_OVERFLOW;
			test_SUB_Y_ZERO;
			test_SUB_Y_NEGATIVE;
			test_SUB_X_Immediate;
			test_SUB_Y_Immediate;
			
			test_LSR_X;
			test_LSR_Y;
			test_LSR_Y_ZERO;
			test_LSR_Y_NEGATIVE;
			test_LSR_X_Immediate;
			test_LSR_Y_Immediate;
			
			test_LSL_X;
			test_LSL_Y;
			test_LSL_Y_ZERO;
			test_LSL_Y_NEGATIVE;
			test_LSL_X_Immediate;
			test_LSL_Y_Immediate;
			
			test_MUL_X;
			test_MUL_Y;
			test_MUL_Y_OVERFLOW;
			test_MUL_Y_ZERO;
			test_MUL_Y_NEGATIVE;
			test_MUL_X_Immediate;
			test_MUL_Y_Immediate_CARRY;
			
			test_DIV_X;
			test_DIV_Y;
			test_DIV_Y_ZERO;
			test_DIV_Y_NEGATIVE;
			test_DIV_X_Immediate;
			test_DIV_Y_Immediate;
			
			test_MOD_X;
			test_MOD_Y;
			test_MOD_Y_ZERO;
			test_MOD_Y_NEGATIVE;
			test_MOD_X_Immediate;
			test_MOD_Y_Immediate;
			
			test_CMP_ACC_X_OVERFLOW_AND_BORROW;
			test_CMP_ACC_Y_ZERO;
			test_CMP_ACC_Y_NEGATIVE;
			test_CMP_Immediate_X_OVERFLOW_AND_BORROW;
			test_CMP_Immediate_Y_ZERO;
			test_CMP_Immediate_Y_NEGATIVE;
			
			test_INC_X;
			test_INC_Y;
			test_INC_Y_CARRY_AND_ZERO;
			test_INC_Y_NEGATIVE_AND_OVERFLOW;
			
			test_DEC_X_BORROW;
			test_DEC_Y;
			test_DEC_Y_ZERO;
			test_DEC_Y_NEGATIVE_AND_OVERFLOW;
			
			test_AND_X;
			test_AND_Y;
			test_AND_Y_ZERO;
			test_AND_Y_NEGATIVE;
			test_AND_X_Immediate;
			test_AND_Y_Immediate;
			
			test_OR_X;
			test_OR_Y;
			test_OR_Y_ZERO;
			test_OR_Y_NEGATIVE;
			test_OR_X_Immediate;
			test_OR_Y_Immediate;
			
			test_XOR_X;
			test_XOR_Y;
			test_XOR_Y_ZERO;
			test_XOR_Y_NEGATIVE;
			test_XOR_X_Immediate;
			test_XOR_Y_Immediate;
			
			test_NOT_X;
			test_NOT_Y;
			test_NOT_Y_ZERO;
			test_NOT_Y_NEGATIVE;
			
			test_RSR_X;
			test_RSR_Y;
			test_RSR_Y_ZERO;
			test_RSR_Y_NEGATIVE;
			test_RSR_X_Immediate;
			test_RSR_Y_Immediate;
			
			test_RSL_X;
			test_RSL_Y;
			test_RSL_Y_ZERO;
			test_RSL_Y_NEGATIVE;
			test_RSL_X_Immediate;
			test_RSL_Y_Immediate;
			
		$stop;
		$finish;
	end
	
task test_ADD_X;
begin
  #10 clk = 1'd1;
  $write(" ALU_ADD_X \t");
  opcode = 6'd13;
  Immediate = 16'd0;
  X = 16'd5;
  RA = 1'd0;
  #2
  if (res == 16'd5)
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, 16'd5);
	$write("\n");
	#10 clk = 1'd0;
end
endtask


task test_ADD_Y;
begin
  #10 clk = 1'd1;
  $write(" ALU_ADD_Y \t");
  opcode = 6'd13;
  Immediate = 16'd0;
  ACC = 16'd2;
  Y = 16'd14;
  RA = 1'd1;
  #2
  if (res == 16'd16)
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, 16'd16);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_ADD_Y_OVERFLOW;
begin
  #10 clk = 1'd1;
  $write(" ALU_ADD_Y_OVERFLOW\t");
  opcode = 6'd13;
  Immediate = 16'd0;
  ACC = 16'b0111111111111110;
  Y = 16'd2;
  RA = 1'd1;
  #2
  if (res == 16'b1000000000000000 && flags[0] == 1'd1)
    $write("ok ");
  else
		$write("error @ %t , get %d %d, expect %d %d", $time, res, flags[0], 16'b1000000000000000, 1'd1);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_ADD_Y_ZERO_AND_CARRY;
begin
  #10 clk = 1'd1;
  $write(" ALU_ADD_Y_ZERO_AND_CARRY \t");
  opcode = 6'd13;
  Immediate = 16'd0;
  ACC = 16'b0000000000000011;
  Y = 16'b1111111111111101;
  RA = 1'd1;
  #2
  if (res == 16'b0000000000000000 && flags[1] == 1'd1 && flags[3] == 1'd1)
    $write("ok ");
  else
		$write("error @ %t , get %d %d %d, expect %d %d %d", $time, res, flags[1], flags[3], 16'b0000000000000000, 1'd1, 1'd1);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_ADD_Y_NEGATIVE;
begin
  #10 clk = 1'd1;
  $write(" ALU_ADD_Y_NEGATIVE \t");
  opcode = 6'd13;
  Immediate = 16'd0;
  ACC = 16'b0000000000000011;
  Y = 16'b1111111111111100;
  RA = 1'd1;
  #2
  if (res == 16'b1111111111111111 && flags[2] == 1'd1)
    $write("ok ");
  else
		$write("error @ %t , get %d %d, expect %d %d", $time, res, flags[2], 16'b11111111111111111, 1'd1);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_ADD_X_Immediate;
begin
  #10 clk = 1'd1;
  $write(" ALU_ADD_X_Immediate \t");
  opcode = 6'd13;
  Immediate = 16'b0101010101010101;
  X = 16'b0010101010101010;
  RA = 1'd0;
  #2
  if (res == X + Immediate)
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, X+Immediate);
	$write("\n");
	#10 clk = 1'd0;
end
endtask


task test_ADD_Y_Immediate;
begin
  #10 clk = 1'd1;
  $write(" ALU_ADD_Y_Immediate \t");
  opcode = 6'd13;
  Immediate = 16'b1111100000111110;
  Y = 16'b1000001111000000;
  RA = 1'd1;
  #2
  if (res == Y + Immediate)
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, Y+Immediate);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_SUB_X;
begin
  #10 clk = 1'd1;
  $write(" ALU_SUB_X \t");
  opcode = 6'd14;
  Immediate = 16'd0;
  ACC = 16'b0011111111111111;
  X = 16'b0000000000111000;
  RA = 1'd0;
  #2
  if (res == ACC - X)
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, ACC - X);
	$write("\n");
	#10 clk = 1'd0;
end
endtask


task test_SUB_Y_BORROW;
begin
  #10 clk = 1'd1;
  $write(" ALU_SUB_Y_BORROW \t");
  opcode = 6'd14;
  Immediate = 16'd0;
  ACC = 16'b0001111111010101;
  Y = 16'b0111111101011100;
  RA = 1'd1;
  #2
  if (res == ACC - Y && flags[1] == 1'd1)
    $write("ok ");
  else
		$write("error @ %t , get %d %d, expect %d %d", $time, res, flags[1], ACC - Y, 1'd1);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_SUB_Y_OVERFLOW;
begin
  #10 clk = 1'd1;
  $write(" ALU_SUB_Y_OVERFLOW\t");
  opcode = 6'd14;
  Immediate = 16'd0;
  ACC = 16'b1111111111110011;
  Y = 16'b1000000000000001;
  RA = 1'd1;
  #2
  if (res == ACC - Y && flags[0] == 1'd0)
    $write("ok ");
  else
		$write("error @ %t , get %d %d, expect %d %d", $time, res, flags[0], ACC - Y, 1'd1);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_SUB_Y_ZERO;
begin
  #10 clk = 1'd1;
  $write(" ALU_SUB_Y_ZERO \t");
  opcode = 6'd14;
  Immediate = 16'd0;
  ACC = 16'b0000000000000011;
  Y = 16'b0000000000000011;
  RA = 1'd1;
  #2
  if (res == ACC - Y && flags[3] == 1'd1)
    $write("ok ");
  else
		$write("error @ %t , get %d %d, expect %d %d", $time, res, flags[3], ACC - Y, 1'd1);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_SUB_Y_NEGATIVE;
begin
  #10 clk = 1'd1;
  $write(" ALU_SUB_Y_NEGATIVE \t");
  opcode = 6'd14;
  Immediate = 16'd0;
  ACC = 16'b0000000000000011;
  Y = 16'b0000000000111000;
  RA = 1'd1;
  #2
  if (res == ACC - Y && flags[2] == 1'd1)
    $write("ok ");
  else
		$write("error @ %t , get %d %d, expect %d %d", $time, res, flags[2], ACC - Y, 1'd1);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_SUB_X_Immediate;
begin
  #10 clk = 1'd1;
  $write(" ALU_SUB_X_Immediate \t");
  opcode = 6'd14;
  Immediate = 16'b1111111111110001;
  X = 16'b1111111111111111;
  RA = 1'd0;
  #2
  if (res == X - Immediate)
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, X - Immediate);
	$write("\n");
	#10 clk = 1'd0;
end
endtask


task test_SUB_Y_Immediate;
begin
  #10 clk = 1'd1;
  $write(" ALU_SUB_Y_Immediate \t");
  opcode = 6'd14;
  Immediate = 16'b0110000001110100;
  Y = 16'b1000001111000000;
  RA = 1'd1;
  #2
  if (res == Y - Immediate)
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, Y - Immediate);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_LSR_X;
begin
  #10 clk = 1'd1;
  $write(" ALU_LSR_X \t");
  opcode = 6'd15;
  Immediate = 16'd0;
  ACC = 16'b0011111111111111;
  X = 16'b0000000000000011;
  RA = 1'd0;
  #2
  if (res == ACC >> X)
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, ACC >> X);
	$write("\n");
	#10 clk = 1'd0;
end
endtask


task test_LSR_Y;
begin
  #10 clk = 1'd1;
  $write(" ALU_LSR_Y \t");
  opcode = 6'd15;
  Immediate = 16'd0;
  ACC = 16'b1111111111010101;
  Y = 16'b0000000000000111;
  RA = 1'd1;
  #2
  if (res == ACC >> Y)
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, ACC >> Y);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_LSR_Y_ZERO;
begin
  #10 clk = 1'd1;
  $write(" ALU_LSR_Y_ZERO \t");
  opcode = 6'd15;
  Immediate = 16'd0;
  ACC = 16'b0000000000000111;
  Y = 16'b0000000000000011;
  RA = 1'd1;
  #2
  if (res == ACC >> Y && flags[3] == 1'd1)
    $write("ok ");
  else
		$write("error @ %t , get %d %d, expect %d %d", $time, res, flags[3], ACC >> Y, 1'd1);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_LSR_Y_NEGATIVE;
begin
  #10 clk = 1'd1;
  $write(" ALU_LSR_Y_NEGATIVE \t");
  opcode = 6'd15;
  Immediate = 16'd0;
  ACC = 16'b1110000000000011;
  Y = 16'b0000000000000000;
  RA = 1'd1;
  #2
  if (res == ACC >> Y && flags[2] == 1'd1)
    $write("ok ");
  else
		$write("error @ %t , get %d %d, expect %d %d", $time, res, flags[2], ACC >> Y, 1'd1);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_LSR_X_Immediate;
begin
  #10 clk = 1'd1;
  $write(" ALU_LSR_X_Immediate \t");
  opcode = 6'd15;
  Immediate = 16'b00000000000001;
  X = 16'b1111111111111111;
  RA = 1'd0;
  #2
  if (res == X >> Immediate)
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, X >> Immediate);
	$write("\n");
	#10 clk = 1'd0;
end
endtask


task test_LSR_Y_Immediate;
begin
  #10 clk = 1'd1;
  $write(" ALU_LSR_Y_Immediate \t");
  opcode = 6'd15;
  Immediate = 16'b0000000000000111;
  Y = 16'b1000001111000000;
  RA = 1'd1;
  #2
  if (res == Y >> Immediate)
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, Y >> Immediate);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_LSL_X;
begin
  #10 clk = 1'd1;
  $write(" ALU_LSL_X \t");
  opcode = 6'd16;
  Immediate = 16'd0;
  ACC = 16'b0011110000001111;
  X = 16'b0000000000000001;
  RA = 1'd0;
  #2
  if (res == ACC << X)
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, ACC << X);
	$write("\n");
	#10 clk = 1'd0;
end
endtask


task test_LSL_Y;
begin
  #10 clk = 1'd1;
  $write(" ALU_LSL_Y \t");
  opcode = 6'd16;
  Immediate = 16'd0;
  ACC = 16'b1001111111010101;
  Y = 16'b0000000000000111;
  RA = 1'd1;
  #2
  if (res == ACC << Y)
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, ACC << Y);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_LSL_Y_ZERO;
begin
  #10 clk = 1'd1;
  $write(" ALU_LSL_Y_ZERO \t");
  opcode = 6'd16;
  Immediate = 16'd0;
  ACC = 16'b0011000010000000;
  Y = 16'b0000000000001001;
  RA = 1'd1;
  #2
  if (res == ACC << Y && flags[3] == 1'd1)
    $write("ok ");
  else
		$write("error @ %t , get %d %d, expect %d %d", $time, res, flags[3], ACC << Y, 1'd1);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_LSL_Y_NEGATIVE;
begin
  #10 clk = 1'd1;
  $write(" ALU_LSL_Y_NEGATIVE \t");
  opcode = 6'd16;
  Immediate = 16'd0;
  ACC = 16'b0010010011100011;
  Y = 16'b0000000000000101;
  RA = 1'd1;
  #2
  if (res == ACC << Y && flags[2] == 1'd1)
    $write("ok ");
  else
		$write("error @ %t , get %d %d, expect %d %d", $time, res, flags[2], ACC << Y, 1'd1);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_LSL_X_Immediate;
begin
  #10 clk = 1'd1;
  $write(" ALU_LSL_X_Immediate \t");
  opcode = 6'd16;
  Immediate = 16'd13;
  X = 16'b1111111111111111;
  RA = 1'd0;
  #2
  if (res == X << Immediate)
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, X << Immediate);
	$write("\n");
	#10 clk = 1'd0;
end
endtask


task test_LSL_Y_Immediate;
begin
  #10 clk = 1'd1;
  $write(" ALU_LSL_Y_Immediate \t");
  opcode = 6'd16;
  Immediate = 16'd8;
  Y = 16'b1000001111000000;
  RA = 1'd1;
  #2
  if (res == Y << Immediate)
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, Y << Immediate);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_MUL_X;
begin
  #10 clk = 1'd1;
  $write(" ALU_MUL_X \t");
  opcode = 6'd17;
  Immediate = 16'd0;
  ACC = 16'b0011111111111111;
  X = 16'b0000000000111000;
  RA = 1'd0;
  #2
  if (res == ACC * X)
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, ACC * X);
	$write("\n");
	#10 clk = 1'd0;
end
endtask


task test_MUL_Y;
begin
  #10 clk = 1'd1;
  $write(" ALU_MUL_Y \t");
  opcode = 6'd17;
  Immediate = 16'd0;
  ACC = 16'd17;
  Y = 16'd11;
  RA = 1'd1;
  #2
  if (res == ACC * Y)
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, ACC * Y);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_MUL_Y_OVERFLOW;
begin
  #10 clk = 1'd1;
  $write(" ALU_MUL_Y_OVERFLOW\t");
  opcode = 6'd17;
  Immediate = 16'd0;
  ACC = 16'b0101010111101011;
  Y = 16'b0111101100010111;
  RA = 1'd1;
  #2
  if (res == ACC * Y && flags[0] == 1'd1)
    $write("ok ");
  else
		$write("error @ %t , get %d %d, expect %d %d", $time, res, flags[0], ACC * Y, 1'd1);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_MUL_Y_ZERO;
begin
  #10 clk = 1'd1;
  $write(" ALU_MUL_Y_ZERO \t");
  opcode = 6'd17;
  Immediate = 16'd0;
  ACC = 16'b0101111000000011;
  Y = 16'b0000000000000000;
  RA = 1'd1;
  #2
  if (res == ACC * Y && flags[3] == 1'd1)
    $write("ok ");
  else
		$write("error @ %t , get %d %d, expect %d %d", $time, res, flags[3], ACC * Y, 1'd1);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_MUL_Y_NEGATIVE;
begin
  #10 clk = 1'd1;
  $write(" ALU_MUL_Y_NEGATIVE \t");
  opcode = 6'd17;
  Immediate = 16'd0;
  ACC = 16'b0000000000010011;
  Y = 16'b1000000000001000;
  RA = 1'd1;
  #2
  if (res == ACC * Y && flags[2] == 1'd1)
    $write("ok ");
  else
		$write("error @ %t , get %d %d, expect %d %d", $time, res, flags[2], ACC * Y, 1'd1);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_MUL_X_Immediate;
begin
  #10 clk = 1'd1;
  $write(" ALU_MUL_X_Immediate \t");
  opcode = 6'd17;
  Immediate = 16'b1111111111110001;
  X = 16'b1111111111111110;
  RA = 1'd0;
  #2
  if (res == X * Immediate)
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, X * Immediate);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_MUL_Y_Immediate_CARRY;
begin
  #10 clk = 1'd1;
  $write(" ALU_MUL_Y_Immediate_CARRY \t");
  opcode = 6'd17;
  Immediate = 16'b0110000001110100;
  Y = 16'b0000000011001010;
  RA = 1'd1;
  #2
  if (res == Y * Immediate && flags[1] == 1'd1)
    $write("ok ");
  else
		$write("error @ %t , get %d %d, expect %d %d", $time, res, flags[1], Y * Immediate, 1'd1);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_DIV_X;
begin
  #10 clk = 1'd1;
  $write(" ALU_DIV_X \t");
  opcode = 6'd18;
  Immediate = 16'd0;
  ACC = 16'b0011100101111111;
  X = 16'b0000000010100001;
  RA = 1'd0;
  #2
  if (res == ACC / X)
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, ACC / X);
	$write("\n");
	#10 clk = 1'd0;
end
endtask


task test_DIV_Y;
begin
  #10 clk = 1'd1;
  $write(" ALU_DIV_Y \t");
  opcode = 6'd18;
  Immediate = 16'd0;
  ACC = 16'b1111111111010101;
  Y = 16'b1111111111010101;
  RA = 1'd1;
  #2
  if (res == ACC / Y)
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, ACC / Y);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_DIV_Y_ZERO;
begin
  #10 clk = 1'd1;
  $write(" ALU_DIV_Y_ZERO \t");
  opcode = 6'd18;
  Immediate = 16'd0;
  ACC = 16'b0000000000000000;
  Y = 16'b0000011100000011;
  RA = 1'd1;
  #2
  if (res == ACC / Y && flags[3] == 1'd1)
    $write("ok ");
  else
		$write("error @ %t , get %d %d, expect %d %d", $time, res, flags[3], ACC / Y, 1'd1);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_DIV_Y_NEGATIVE;
begin
  #10 clk = 1'd1;
  $write(" ALU_DIV_Y_NEGATIVE \t");
  opcode = 6'd18;
  Immediate = 16'd0;
  ACC = 16'b1111111111000011;
  Y = 16'b0000000000000010;
  RA = 1'd1;
  #2
  if (res == ACC / Y && flags[2] == 1'd1)
    $write("ok ");
  else
		$write("error @ %t , get %d %d, expect %d %d", $time, res, flags[2], ACC / Y, 1'd1);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_DIV_X_Immediate;
begin
  #10 clk = 1'd1;
  $write(" ALU_DIV_X_Immediate \t");
  opcode = 6'd18;
  Immediate = 16'b1111111111111101;
  X = 16'b0000000000010110;
  RA = 1'd0;
  #2
  if (res == X / Immediate)
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, X / Immediate);
	$write("\n");
	#10 clk = 1'd0;
end
endtask


task test_DIV_Y_Immediate;
begin
  #10 clk = 1'd1;
  $write(" ALU_DIV_Y_Immediate \t");
  opcode = 6'd18;
  Immediate = 16'b1111111111111100;
  Y = 16'b1111111100001111;
  RA = 1'd1;
  #2
  if (res == Y / Immediate)
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, Y / Immediate);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_MOD_X;
begin
  #10 clk = 1'd1;
  $write(" ALU_MOD_X \t");
  opcode = 6'd19;
  Immediate = 16'd0;
  ACC = 16'b0111100101111111;
  X = 16'b0000000010100001;
  RA = 1'd0;
  #2
  if (res == ACC % X)
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, ACC % X);
	$write("\n");
	#10 clk = 1'd0;
end
endtask


task test_MOD_Y;
begin
  #10 clk = 1'd1;
  $write(" ALU_MOD_Y \t");
  opcode = 6'd19;
  Immediate = 16'd0;
  ACC = 16'b1111111111010101;
  Y = 16'b0000000011010101;
  RA = 1'd1;
  #2
  if (res == ACC % Y)
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, ACC % Y);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_MOD_Y_ZERO;
begin
  #10 clk = 1'd1;
  $write(" ALU_MOD_Y_ZERO \t");
  opcode = 6'd19;
  Immediate = 16'd0;
  ACC = 16'b0000000000000000;
  Y = 16'b0000011100000011;
  RA = 1'd1;
  #2
  if (res == ACC % Y && flags[3] == 1'd1)
    $write("ok ");
  else
		$write("error @ %t , get %d %d, expect %d %d", $time, res, flags[3], ACC % Y, 1'd1);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_MOD_Y_NEGATIVE;
begin
  #10 clk = 1'd1;
  $write(" ALU_MOD_Y_NEGATIVE \t");
  opcode = 6'd19;
  Immediate = 16'd0;
  ACC = 16'b1111110000000011;
  Y = 16'b0000000000000010;
  RA = 1'd1;
  #2
  if (res == ACC % Y && flags[2] == 1'd1)
    $write("ok ");
  else
		$write("error @ %t , get %d %d, expect %d %d", $time, res, flags[2], ACC % Y, 1'd1);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_MOD_X_Immediate;
begin
  #10 clk = 1'd1;
  $write(" ALU_MOD_X_Immediate \t");
  opcode = 6'd19;
  Immediate = 16'b1111110101110001;
  X = 16'b0000101000000110;
  RA = 1'd0;
  #2
  if (res == X % Immediate)
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, X % Immediate);
	$write("\n");
	#10 clk = 1'd0;
end
endtask


task test_MOD_Y_Immediate;
begin
  #10 clk = 1'd1;
  $write(" ALU_MOD_Y_Immediate \t");
  opcode = 6'd19;
  Immediate = 16'b1111111100001111;
  Y = 16'b1000001111000000;
  RA = 1'd1;
  #2
  if (res == Y % Immediate)
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, Y % Immediate);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_CMP_ACC_X_OVERFLOW_AND_BORROW;
begin
  #10 clk = 1'd1;
  $write(" ALU_CMP_ACC_X_OVERFLOW_AND_BORROW \t");
  opcode = 6'd20;
  Immediate = 16'd0;
  ACC = 16'b0000011100111000;
  X = 16'b0111111111111111;
  RA = 1'd0;
  #2
  if (flags[0] == 1'd1)
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, flags[0], 1'd1);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_CMP_ACC_Y_ZERO;
begin
  #10 clk = 1'd1;
  $write(" ALU_CMP_ACC_Y_ZERO \t");
  opcode = 6'd20;
  Immediate = 16'd0;
  ACC = 16'b0001111111010101;
  Y = 16'b0001111111010101;
  RA = 1'd1;
  #2
  if (flags[3] == 1'd1)
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, flags[3], 1'd1);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_CMP_ACC_Y_NEGATIVE;
begin
  #10 clk = 1'd1;
  $write(" ALU_CMP_ACC_Y_NEGATIVE \t");
  opcode = 6'd20;
  Immediate = 16'd0;
  ACC = 16'b0000000011101101;
  Y = 16'b0011111101011100;
  RA = 1'd1;
  #2
  if (flags[2] == 1'd1)
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, flags[2], 1'd1);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_CMP_Immediate_X_OVERFLOW_AND_BORROW;
begin
  #10 clk = 1'd1;
  $write(" ALU_CMP_Immediate_X_OVERFLOW_AND_BORROW \t");
  opcode = 6'd20;
  Immediate = 16'b0000011100000000;
  X = 16'b0000000000111000;
  RA = 1'd0;
  #2
  if (flags[0] == 1'd1)
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, flags[0], 1'd1);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_CMP_Immediate_Y_ZERO;
begin
  #10 clk = 1'd1;
  $write(" ALU_CMP_Immediate_Y_ZERO \t");
  opcode = 6'd20;
  Immediate = 16'b1101111111010101;
  Y = 16'b1101111111010101;
  RA = 1'd1;
  #2
  if (flags[3] == 1'd1)
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, flags[3], 1'd1);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_CMP_Immediate_Y_NEGATIVE;
begin
  #10 clk = 1'd1;
  $write(" ALU_CMP_Immediate_Y_NEGATIVE \t");
  opcode = 6'd20;
  Immediate = 16'b0000011101011100;
  Y = 16'b0000000000101101;
  RA = 1'd1;
  #2
  if (flags[2] == 1'd1)
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, flags[2], 1'd1);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_INC_X;
begin
  #10 clk = 1'd1;
  $write(" ALU_INC_X \t");
  opcode = 6'd21;
  X = 16'b0000000000111000;
  RA = 1'd0;
  #2
  if (res == X + 1'd1)
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, X + 1'd1);
	$write("\n");
	#10 clk = 1'd0;
end
endtask


task test_INC_Y;
begin
  #10 clk = 1'd1;
  $write(" ALU_INC_Y \t");
  opcode = 6'd21;
  Y = 16'b1111111101011100;
  RA = 1'd1;
  #2
  if (res == Y + 1'd1)
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, Y + 1'd1);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_INC_Y_CARRY_AND_ZERO;
begin
  #10 clk = 1'd1;
  $write(" ALU_INC_Y_CARRY_AND_ZERO\t");
  opcode = 6'd21;
  Y = 16'b1111111111111111;
  RA = 1'd1;
  #2
  if (res == Y + 1'd1 && flags[1] == 1'd1 && flags[3] == 1'd1)
    $write("ok ");
  else
		$write("error @ %t , get %d %d %d, expect %d %d %d", $time, res, flags[1], flags[3], Y + 1'd1, 1'd1, 1'd1);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_INC_Y_NEGATIVE_AND_OVERFLOW;
begin
  #10 clk = 1'd1;
  $write(" ALU_INC_Y_NEGATIVE_AND_OVERFLOW \t");
  opcode = 6'd21;
  Y = 16'b0111111111111111;
  RA = 1'd1;
  #2
  if (res == Y + 1'd1 && flags[2] == 1'd1 && flags[0] == 1'd1)
    $write("ok ");
  else
		$write("error @ %t , get %d %d %d, expect %d %d %d", $time, res, flags[2], flags[0], Y + 1'd1, 1'd1, 1'd1);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_DEC_X_BORROW;
begin
  #10 clk = 1'd1;
  $write(" ALU_DEC_X_BORROW \t");
  opcode = 6'd22;
  X = 16'b0000000000111000;
  RA = 1'd0;
  #2
  if (res == X - 1'd1 && flags[1])
    $write("ok ");
  else
		$write("error @ %t , get %d %d, expect %d %d", $time, res, flags[1], X - 1'd1, 1'd1);
	$write("\n");
	#10 clk = 1'd0;
end
endtask


task test_DEC_Y;
begin
  #10 clk = 1'd1;
  $write(" ALU_DEC_Y \t");
  opcode = 6'd22;
  Y = 16'b1111111101011100;
  RA = 1'd1;
  #2
  if (res == Y - 1'd1)
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, Y - 1'd1);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_DEC_Y_ZERO;
begin
  #10 clk = 1'd1;
  $write(" ALU_DEC_Y_ZERO\t");
  opcode = 6'd22;
  Y = 16'b0000000000000001;
  RA = 1'd1;
  #2
  if (res == Y - 1'd1 && flags[3] == 1'd1)
    $write("ok ");
  else
		$write("error @ %t , get %d %d, expect %d %d", $time, res, flags[3], Y - 1'd1, 1'd1);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_DEC_Y_NEGATIVE_AND_OVERFLOW;
begin
  #10 clk = 1'd1;
  $write(" ALU_DEC_Y_NEGATIVE_AND_OVERFLOW \t");
  opcode = 6'd22;
  Y = 16'b0000000000000000;
  RA = 1'd1;
  #2
  if (res == Y - 1'd1 && flags[2] == 1'd1 && flags[0] == 1'd1)
    $write("ok ");
  else
		$write("error @ %t , get %d %d %d, expect %d %d %d", $time, res, flags[2], flags[0], Y - 1'd1, 1'd1, 1'd1);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_AND_X;
begin
  #10 clk = 1'd1;
  $write(" ALU_AND_X \t");
  opcode = 6'd23;
  Immediate = 16'd0;
  ACC = 16'b0011100101111111;
  X = 16'b0000000010100001;
  RA = 1'd0;
  #2
  if (res == (ACC & X))
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, ACC & X);
	$write("\n");
	#10 clk = 1'd0;
end
endtask


task test_AND_Y;
begin
  #10 clk = 1'd1;
  $write(" ALU_AND_Y \t");
  opcode = 6'd23;
  Immediate = 16'd0;
  ACC = 16'b1111111111010101;
  Y = 16'b1100000111010101;
  RA = 1'd1;
  #2
  if (res == (ACC & Y))
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, ACC & Y);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_AND_Y_ZERO;
begin
  #10 clk = 1'd1;
  $write(" ALU_AND_Y_ZERO \t");
  opcode = 6'd23;
  Immediate = 16'd0;
  ACC = 16'b0000000000000000;
  Y = 16'b1110011100000011;
  RA = 1'd1;
  #2
  if (res == ACC & Y && flags[3] == 1'd1)
    $write("ok ");
  else
		$write("error @ %t , get %d %d, expect %d %d", $time, res, flags[3], ACC & Y, 1'd1);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_AND_Y_NEGATIVE;
begin
  #10 clk = 1'd1;
  $write(" ALU_AND_Y_NEGATIVE \t");
  opcode = 6'd23;
  Immediate = 16'd0;
  ACC = 16'b1111111111000011;
  Y = 16'b1000001000000010;
  RA = 1'd1;
  #2
  if (res == (ACC & Y) && flags[2] == 1'd1)
    $write("ok ");
  else
		$write("error @ %t , get %d %d, expect %d %d", $time, res, flags[2], ACC & Y, 1'd1);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_AND_X_Immediate;
begin
  #10 clk = 1'd1;
  $write(" ALU_AND_X_Immediate \t");
  opcode = 6'd23;
  Immediate = 16'b1111111111111101;
  X = 16'b0000001000010110;
  RA = 1'd0;
  #2
  if (res == (X & Immediate))
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, X & Immediate);
	$write("\n");
	#10 clk = 1'd0;
end
endtask


task test_AND_Y_Immediate;
begin
  #10 clk = 1'd1;
  $write(" ALU_AND_Y_Immediate \t");
  opcode = 6'd23;
  Immediate = 16'b0000000101010111;
  Y = 16'b1111111100001111;
  RA = 1'd1;
  #2
  if (res == (Y & Immediate))
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, Y & Immediate);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_OR_X;
begin
  #10 clk = 1'd1;
  $write(" ALU_OR_X \t");
  opcode = 6'd24;
  Immediate = 16'd0;
  ACC = 16'b0011100101111111;
  X = 16'b0000000010100001;
  RA = 1'd0;
  #2
  if (res == (ACC | X))
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, ACC | X);
	$write("\n");
	#10 clk = 1'd0;
end
endtask


task test_OR_Y;
begin
  #10 clk = 1'd1;
  $write(" ALU_OR_Y \t");
  opcode = 6'd24;
  Immediate = 16'd0;
  ACC = 16'b1100111111010101;
  Y = 16'b1100000111010101;
  RA = 1'd1;
  #2
  if (res == (ACC | Y))
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, ACC | Y);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_OR_Y_ZERO;
begin
  #10 clk = 1'd1;
  $write(" ALU_OR_Y_ZERO \t");
  opcode = 6'd24;
  Immediate = 16'd0;
  ACC = 16'b0000000000000000;
  Y = 16'b0000000000000000;
  RA = 1'd1;
  #2
  if (res == ACC | Y && flags[3] == 1'd1)
    $write("ok ");
  else
		$write("error @ %t , get %d %d, expect %d %d", $time, res, flags[3], ACC | Y, 1'd1);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_OR_Y_NEGATIVE;
begin
  #10 clk = 1'd1;
  $write(" ALU_OR_Y_NEGATIVE \t");
  opcode = 6'd24;
  Immediate = 16'd0;
  ACC = 16'b1111111111000011;
  Y = 16'b0000001000000010;
  RA = 1'd1;
  #2
  if (res == (ACC | Y) && flags[2] == 1'd1)
    $write("ok ");
  else
		$write("error @ %t , get %d %d, expect %d %d", $time, res, flags[2], ACC | Y, 1'd1);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_OR_X_Immediate;
begin
  #10 clk = 1'd1;
  $write(" ALU_OR_X_Immediate \t");
  opcode = 6'd24;
  Immediate = 16'b1111010011111101;
  X = 16'b0000001000010110;
  RA = 1'd0;
  #2
  if (res == (X | Immediate))
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, X | Immediate);
	$write("\n");
	#10 clk = 1'd0;
end
endtask


task test_OR_Y_Immediate;
begin
  #10 clk = 1'd1;
  $write(" ALU_OR_Y_Immediate \t");
  opcode = 6'd24;
  Immediate = 16'b0000000101010111;
  Y = 16'b1111100000001111;
  RA = 1'd1;
  #2
  if (res == (Y | Immediate))
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, Y | Immediate);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_XOR_X;
begin
  #10 clk = 1'd1;
  $write(" ALU_XOR_X \t");
  opcode = 6'd25;
  Immediate = 16'd0;
  ACC = 16'b0011100101111111;
  X = 16'b0000000010100001;
  RA = 1'd0;
  #2
  if (res == (ACC ^ X))
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, ACC ^ X);
	$write("\n");
	#10 clk = 1'd0;
end
endtask


task test_XOR_Y;
begin
  #10 clk = 1'd1;
  $write(" ALU_XOR_Y \t");
  opcode = 6'd25;
  Immediate = 16'd0;
  ACC = 16'b1100111111010101;
  Y = 16'b1100000111010101;
  RA = 1'd1;
  #2
  if (res == (ACC ^ Y))
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, ACC ^ Y);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_XOR_Y_ZERO;
begin
  #10 clk = 1'd1;
  $write(" ALU_XOR_Y_ZERO \t");
  opcode = 6'd25;
  Immediate = 16'd0;
  ACC = 16'b1111100001000111;
  Y = 16'b1111100001000111;
  RA = 1'd1;
  #2
  if (res == ACC ^ Y && flags[3] == 1'd1)
    $write("ok ");
  else
		$write("error @ %t , get %d %d, expect %d %d", $time, res, flags[3], ACC ^ Y, 1'd1);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_XOR_Y_NEGATIVE;
begin
  #10 clk = 1'd1;
  $write(" ALU_XOR_Y_NEGATIVE \t");
  opcode = 6'd25;
  Immediate = 16'd0;
  ACC = 16'b1111111111000011;
  Y = 16'b0000001000000010;
  RA = 1'd1;
  #2
  if (res == (ACC ^ Y) && flags[2] == 1'd1)
    $write("ok ");
  else
		$write("error @ %t , get %d %d, expect %d %d", $time, res, flags[2], ACC ^ Y, 1'd1);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_XOR_X_Immediate;
begin
  #10 clk = 1'd1;
  $write(" ALU_XOR_X_Immediate \t");
  opcode = 6'd25;
  Immediate = 16'b1111010011111101;
  X = 16'b0000001000010110;
  RA = 1'd0;
  #2
  if (res == (X ^ Immediate))
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, X ^ Immediate);
	$write("\n");
	#10 clk = 1'd0;
end
endtask


task test_XOR_Y_Immediate;
begin
  #10 clk = 1'd1;
  $write(" ALU_XOR_Y_Immediate \t");
  opcode = 6'd25;
  Immediate = 16'b0000000101010111;
  Y = 16'b1000000100001111;
  RA = 1'd1;
  #2
  if (res == (Y ^ Immediate))
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, Y ^ Immediate);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_NOT_X;
begin
  #10 clk = 1'd1;
  $write(" ALU_NOT_X \t");
  opcode = 6'd26;
  X = 16'b0000001110100001;
  RA = 1'd0;
  #2
  if (res == (~X))
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, ~X);
	$write("\n");
	#10 clk = 1'd0;
end
endtask


task test_NOT_Y;
begin
  #10 clk = 1'd1;
  $write(" ALU_NOT_Y \t");
  opcode = 6'd26;
  Y = 16'b1100000111010101;
  RA = 1'd1;
  #2
  if (res == (~Y))
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, ~Y);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_NOT_Y_ZERO;
begin
  #10 clk = 1'd1;
  $write(" ALU_NOT_Y_ZERO \t");
  opcode = 6'd26;
  Y = 16'b1111111111111111;
  RA = 1'd1;
  #2
  if (res == (~Y) && flags[3] == 1'd1)
    $write("ok ");
  else
		$write("error @ %t , get %d %d, expect %d %d", $time, res, flags[3], ~Y, 1'd1);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_NOT_Y_NEGATIVE;
begin
  #10 clk = 1'd1;
  $write(" ALU_NOT_Y_NEGATIVE \t");
  opcode = 6'd26;
  Y = 16'b0000001000000010;
  RA = 1'd1;
  #2
  if (res == (~Y) && flags[2] == 1'd1)
    $write("ok ");
  else
		$write("error @ %t , get %d %d, expect %d %d", $time, res, flags[2], ~Y, 1'd1);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_RSR_X;
begin
  #10 clk = 1'd1;
  $write(" ALU_RSR_X \t");
  opcode = 6'd27;
  Immediate = 16'd0;
  ACC = 16'b0011100101111111;
  X = 16'd4;
  RA = 1'd0;
  #2
  if (res == 16'b1111001110010111)
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, 16'b1111001110010111);
	$write("\n");
	#10 clk = 1'd0;
end
endtask


task test_RSR_Y;
begin
  #10 clk = 1'd1;
  $write(" ALU_RSR_Y \t");
  opcode = 6'd27;
  Immediate = 16'd0;
  ACC = 16'b1100111111010101;
  Y = 16'd17;
  RA = 1'd1;
  #2
  if (res == 16'b1110011111101010)
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, 16'b1110011111101010);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_RSR_Y_ZERO;
begin
  #10 clk = 1'd1;
  $write(" ALU_RSR_Y_ZERO \t");
  opcode = 6'd27;
  Immediate = 16'd0;
  ACC = 16'b0000000000000000;
  Y = 16'd2;
  RA = 1'd1;
  #2
  if (res == 16'b0000000000000000 && flags[3] == 1'd1)
    $write("ok ");
  else
		$write("error @ %t , get %d %d, expect %d %d", $time, res, flags[3], 16'b0000000000000000, 1'd1);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_RSR_Y_NEGATIVE;
begin
  #10 clk = 1'd1;
  $write(" ALU_RSR_Y_NEGATIVE \t");
  opcode = 6'd27;
  Immediate = 16'd0;
  ACC = 16'b0011111111000011;
  Y = 16'd8;
  RA = 1'd1;
  #2
  if (res == 16'b1100001100111111 && flags[2] == 1'd1)
    $write("ok ");
  else
		$write("error @ %t , get %d %d, expect %d %d", $time, res, flags[2], 16'b1100001100111111, 1'd1);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_RSR_X_Immediate;
begin
  #10 clk = 1'd1;
  $write(" ALU_RSR_X_Immediate \t");
  opcode = 6'd27;
  Immediate = 16'd16;
  X = 16'b0111111111111111;
  RA = 1'd0;
  #2
  if (res == 16'b0111111111111111)
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, 16'b0111111111111111);
	$write("\n");
	#10 clk = 1'd0;
end
endtask


task test_RSR_Y_Immediate;
begin
  #10 clk = 1'd1;
  $write(" ALU_RSR_Y_Immediate \t");
  opcode = 6'd27;
  Immediate = 16'd213;
  Y = 16'b0000000101010111;
  RA = 1'd1;
  #2
  if (res == 16'b1011100000001010)
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, 16'b1011100000001010);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_RSL_X;
begin
  #10 clk = 1'd1;
  $write(" ALU_RSL_X \t");
  opcode = 6'd28;
  Immediate = 16'd0;
  ACC = 16'b0011100101111111;
  X = 16'd4;
  RA = 1'd0;
  #2
  if (res == 16'b1001011111110011)
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, 16'b1001011111110011);
	$write("\n");
	#10 clk = 1'd0;
end
endtask


task test_RSL_Y;
begin
  #10 clk = 1'd1;
  $write(" ALU_RSL_Y \t");
  opcode = 6'd28;
  Immediate = 16'd0;
  ACC = 16'b1100111111010101;
  Y = 16'd25;
  RA = 1'd1;
  #2
  if (res == 16'b1010101110011111)
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, 16'b1010101110011111);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_RSL_Y_ZERO;
begin
  #10 clk = 1'd1;
  $write(" ALU_RSL_Y_ZERO \t");
  opcode = 6'd28;
  Immediate = 16'd0;
  ACC = 16'b0000000000000000;
  Y = 16'd2;
  RA = 1'd1;
  #2
  if (res == 16'b0000000000000000 && flags[3] == 1'd1)
    $write("ok ");
  else
		$write("error @ %t , get %d %d, expect %d %d", $time, res, flags[3], 16'b0000000000000000, 1'd1);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_RSL_Y_NEGATIVE;
begin
  #10 clk = 1'd1;
  $write(" ALU_RSL_Y_NEGATIVE \t");
  opcode = 6'd28;
  Immediate = 16'd0;
  ACC = 16'b0011111111000011;
  Y = 16'd3;
  RA = 1'd1;
  #2
  if (res == 16'b1111111000011001 && flags[2] == 1'd1)
    $write("ok ");
  else
		$write("error @ %t , get %d %d, expect %d %d", $time, res, flags[2], 16'b1111111000011001, 1'd1);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_RSL_X_Immediate;
begin
  #10 clk = 1'd1;
  $write(" ALU_RSL_X_Immediate \t");
  opcode = 6'd28;
  Immediate = 16'd1032;
  X = 16'b0111111101111110;
  RA = 1'd0;
  #2
  if (res == 16'b0111111001111111)
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, 16'b0111111001111111);
	$write("\n");
	#10 clk = 1'd0;
end
endtask


task test_RSL_Y_Immediate;
begin
  #10 clk = 1'd1;
  $write(" ALU_RSL_Y_Immediate \t");
  opcode = 6'd28;
  Immediate = 16'd256;
  Y = 16'b1111111111111110;
  RA = 1'd1;
  #2
  if (res == 16'b1111111111111110)
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, 16'b1111111111111110);
	$write("\n");
	#10 clk = 1'd0;
end
endtask

endmodule
