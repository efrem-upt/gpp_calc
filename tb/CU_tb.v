module CU_tb;
// Inputs
reg [5:0] opcode;
reg clk;
reg [8:0] Immediate;
reg rst;
reg RA;
reg [1:0] RA_stack;
reg FACT_END;

//Outputs
wire ALU, BRA, COND_BRA, COND_BRA_REQUIRES_ZERO, COND_BRA_REQUIRES_NEGATIVE, COND_BRA_REQUIRES_CARRY, COND_BRA_REQUIRES_OVERFLOW, L, S, TR, STACK_PSH,STACK_POP, MOV, flag_select, ACC_select, X_select, Y_select,PC_select, FACT;
// Instantiate the Unit Under Test (UUT)
CU ControlUnit(.opcode(opcode),.RA(RA),.RA_stack(RA_stack), .FACT_END(FACT_END), .Immediate(Immediate),.clk(clk),.rst(rst),.ALU(ALU),.BRA(BRA),.COND_BRA(COND_BRA),.COND_BRA_REQUIRES_ZERO(COND_BRA_REQUIRES_ZERO),.COND_BRA_REQUIRES_NEGATIVE(COND_BRA_REQUIRES_NEGATIVE),.COND_BRA_REQUIRES_CARRY(COND_BRA_REQUIRES_CARRY),.COND_BRA_REQUIRES_OVERFLOW(COND_BRA_REQUIRES_OVERFLOW),.L(L),.S(S),.TR(TR),.STACK_PSH(STACK_PSH),.STACK_POP(STACK_POP),.MOV(MOV),.flag_select(flag_select),.ACC_select(ACC_select),.X_select(X_select),.Y_select(Y_select),.PC_select(PC_select), .FACT(FACT));

initial begin
		// Initialize Inputs
		opcode = 6'd0;
		clk = 1'd0;
		rst = 1'd0;
    Immediate = 9'd0;
    RA = 1'd0;
    RA_stack = 2'd0;
		// Wait 100 ns for global reset to finish
		#100;
    rst = 1'd1;
		// Add stimulus here
		#5
			test_TRX;
			test_TRY;
			
			test_LDR_X;
			test_LDR_Y;
			
			test_STR_X;
			test_STR_Y;
			
			test_PSH_X;
			test_PSH_Y;
			test_PSH_ACC;
			test_PSH_PC;
			
			test_POP_X;
			test_POP_Y;
			test_POP_ACC;
			test_POP_PC;
			
			test_BRZ;
			test_BRN;
			test_BRC;
			test_BRO;
			test_BRA;
			
			test_ADD_X_OR_Y;
			test_ADD_X_Immediate;
			test_ADD_Y_Immediate;
			test_SUB_X_OR_Y;
			test_SUB_X_Immediate;
			test_SUB_Y_Immediate;
			test_LSR_X_OR_Y;
			test_LSR_X_Immediate;
			test_LSR_Y_Immediate;
			test_LSL_X_OR_Y;
			test_LSL_X_Immediate;
			test_LSL_Y_Immediate;
			test_MUL_X_OR_Y;
			test_MUL_X_Immediate;
			test_MUL_Y_Immediate;
			test_DIV_X_OR_Y;
			test_DIV_X_Immediate;
			test_DIV_Y_Immediate;
			test_MOD_X_OR_Y;
			test_MOD_X_Immediate;
			test_MOD_Y_Immediate;
			
			test_INC_X;
			test_INC_Y;
			test_DEC_X;
			test_DEC_Y;
			
			test_CMP;
			
			test_MOV_X;
			test_MOV_Y;
			
		$stop;
		$finish;
	end
	
task test_TRX;
begin
  #10 clk = 1'd1;
  $write(" CU_TRX \t");
  opcode = 6'd0;
  #1
  if (TR == 1'd1 && X_select == 1'd1)
    $write("ok ");
  else
				$write("error @ %t , get %d %d, expect %d %d", $time, TR,X_select, 1'd1,1'd1);
		$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_TRY;
begin
  #10 clk = 1'd1;
  $write(" CU_TRY \t");
  opcode = 6'd1;
  #1
  if (TR == 1'd1 && Y_select == 1'd1)
    $write("ok ");
  else
				$write("error @ %t , get %d %d, expect %d %d", $time, TR,Y_select, 1'd1,1'd1);
		$write("\n");
		#10 clk = 1'd0;
end
endtask

task test_LDR_X;
begin
  #10 clk = 1'd1;
  $write(" CU_LDR_X \t");
  opcode = 6'd2;
  RA = 1'd0;
  #1
    if (L == 1'd1 && X_select == 1'd1)
      $write("ok ");
    else
				$write("error @ %t , get %d %d, expect %d %d", $time, L, X_select, 1'd1,1'd1);
  
		$write("\n");
		#10 clk = 1'd0;
end
endtask

task test_LDR_Y;
begin
  #10 clk = 1'd1;
  $write(" CU_LDR_Y \t");
  opcode = 6'd2;
  RA = 1'd1;
  #1
    if (L == 1'd1 && Y_select == 1'd1)
      $write("ok ");
    else
				$write("error @ %t , get %d %d, expect %d %d", $time, L,Y_select, 1'd1,1'd1);
  
		$write("\n");
		#10 clk = 1'd0;
end
endtask

task test_STR_X;
begin
  #10 clk = 1'd1;
  $write(" CU_STR_X \t");
  opcode = 6'd3;
  RA = 1'd0;
  #1
    if (S == 1'd1 && X_select == 1'd1)
      $write("ok ");
    else
				$write("error @ %t , get %d %d, expect %d %d", $time, L, X_select, 1'd1,1'd1);
  
		$write("\n");
		#10 clk = 1'd0;
end
endtask

task test_STR_Y;
begin
  #10 clk = 1'd1;
  $write(" CU_STR_Y \t");
  opcode = 6'd3;
  RA = 1'd1;
  #1
    if (S == 1'd1 && Y_select == 1'd1)
      $write("ok ");
    else
        $write("error @ %t , get %d %d, expect %d %d", $time, L,Y_select, 1'd1,1'd1);
  
    $write("\n");
    #10 clk = 1'd0;
end
endtask

task test_PSH_X;
begin
  #10 clk = 1'd1;
  $write(" CU_PSH_X \t");
  opcode = 6'd4;
  RA_stack = 2'd0;
  #1
    if (STACK_PSH == 1'd1 && S == 1'd1 && X_select == 1'd1)
      $write("ok ");
    else
				$write("error @ %t , get %d %d %d, expect %d %d %d", $time, STACK_PSH, S, X_select, 1'd1, 1'd1, 1'd1);
  
		$write("\n");
		#10 clk = 1'd0;
end
endtask

task test_PSH_Y;
begin
  #10 clk = 1'd1;
  $write(" CU_PSH_Y \t");
  opcode = 6'd4;
  RA_stack = 2'd1;
  #1
    if (STACK_PSH == 1'd1 && S == 1'd1 && Y_select == 1'd1)
      $write("ok ");
    else
				$write("error @ %t , get %d %d %d, expect %d %d %d", $time, STACK_PSH, S, Y_select, 1'd1, 1'd1, 1'd1);
  
		$write("\n");
		#10 clk = 1'd0;
end
endtask
  
task test_PSH_ACC;
begin
  #10 clk = 1'd1;
  $write(" CU_PSH_ACC \t");
  opcode = 6'd4;
  RA_stack = 2'd2;
  #1
    if (STACK_PSH == 1'd1 && S == 1'd1 && ACC_select == 1'd1)
      $write("ok ");
    else
				$write("error @ %t , get %d %d %d, expect %d %d %d", $time, STACK_PSH, S, ACC_select, 1'd1, 1'd1, 1'd1);
  
		$write("\n");
		#10 clk = 1'd0;
end
endtask

task test_PSH_PC;
begin
  #10 clk = 1'd1;
  $write(" CU_PSH_PC \t");
  opcode = 6'd4;
  RA_stack = 2'd3;
  #1
    if (STACK_PSH == 1'd1 && S == 1'd1 && PC_select == 1'd1)
      $write("ok ");
    else
				$write("error @ %t , get %d %d %d, expect %d %d %d", $time, STACK_PSH, S, PC_select, 1'd1, 1'd1, 1'd1);
  
		$write("\n");
		#10 clk = 1'd0;
end
endtask

task test_POP_X;
begin
  #10 clk = 1'd1;
  $write(" CU_POP_X \t");
  opcode = 6'd5;
  RA_stack = 2'd0;
  #1
    if (STACK_POP == 1'd1 && L == 1'd1 && X_select == 1'd1)
      $write("ok ");
    else
				$write("error @ %t , get %d %d %d, expect %d %d %d", $time, STACK_POP, L, X_select, 1'd1, 1'd1, 1'd1);
  
		$write("\n");
		#10 clk = 1'd0;
end
endtask

task test_POP_Y;
begin
  #10 clk = 1'd1;
  $write(" CU_POP_Y \t");
  opcode = 6'd5;
  RA_stack = 2'd1;
  #1
    if (STACK_POP == 1'd1 && L == 1'd1 && Y_select == 1'd1)
      $write("ok ");
    else
				$write("error @ %t , get %d %d %d, expect %d %d %d", $time, STACK_POP, L, Y_select, 1'd1, 1'd1, 1'd1);
  
		$write("\n");
		#10 clk = 1'd0;
end
endtask
  
task test_POP_ACC;
begin
  #10 clk = 1'd1;
  $write(" CU_POP_ACC \t");
  opcode = 6'd5;
  RA_stack = 2'd2;
  #1
    if (STACK_POP == 1'd1 && L == 1'd1 && ACC_select == 1'd1)
      $write("ok ");
    else
				$write("error @ %t , get %d %d %d, expect %d %d %d", $time, STACK_POP, L, ACC_select, 1'd1, 1'd1, 1'd1);
  
		$write("\n");
		#10 clk = 1'd0;
end
endtask

task test_POP_PC;
begin
  #10 clk = 1'd1;
  $write(" CU_POP_PC \t");
  opcode = 6'd5;
  RA_stack = 2'd3;
  #1
    if (STACK_POP == 1'd1 && L == 1'd1 && PC_select == 1'd1)
      $write("ok ");
    else
				$write("error @ %t , get %d %d %d, expect %d %d %d", $time, STACK_POP, L, PC_select, 1'd1, 1'd1, 1'd1);
  
		$write("\n");
		#10 clk = 1'd0;
end
endtask

task test_BRZ;
begin
  #10 clk = 1'd1;
  $write(" CU_BRZ \t");
  opcode = 6'd6;
  #1
  if (BRA == 1'd1 && COND_BRA == 1'd1 && COND_BRA_REQUIRES_ZERO == 1'd1)
    $write("ok ");
  else
				$write("error @ %t , get %d %d %d, expect %d %d %d", $time, BRA, COND_BRA, COND_BRA_REQUIRES_ZERO, 1'd1, 1'd1, 1'd1);
		$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_BRN;
begin
  #10 clk = 1'd1;
  $write(" CU_BRN \t");
  opcode = 6'd7;
  #1
  if (BRA == 1'd1 && COND_BRA == 1'd1 && COND_BRA_REQUIRES_NEGATIVE == 1'd1)
    $write("ok ");
  else
				$write("error @ %t , get %d %d %d, expect %d %d %d", $time, BRA, COND_BRA, COND_BRA_REQUIRES_NEGATIVE, 1'd1, 1'd1, 1'd1);
		$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_BRC;
begin
  #10 clk = 1'd1;
  $write(" CU_BRC \t");
  opcode = 6'd8;
  #1
  if (BRA == 1'd1 && COND_BRA == 1'd1 && COND_BRA_REQUIRES_CARRY == 1'd1)
    $write("ok ");
  else
				$write("error @ %t , get %d %d %d, expect %d %d %d", $time, BRA, COND_BRA, COND_BRA_REQUIRES_CARRY, 1'd1, 1'd1, 1'd1);
		$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_BRO;
begin
  #10 clk = 1'd1;
  $write(" CU_BRO \t");
  opcode = 6'd9;
  #1
  if (BRA == 1'd1 && COND_BRA == 1'd1 && COND_BRA_REQUIRES_OVERFLOW == 1'd1)
    $write("ok ");
  else
				$write("error @ %t , get %d %d %d, expect %d %d %d", $time, BRA, COND_BRA, COND_BRA_REQUIRES_OVERFLOW, 1'd1, 1'd1, 1'd1);
		$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_BRA;
begin
  #10 clk = 1'd1;
  $write(" CU_BRA \t");
  opcode = 6'd10;
  #1
  if (BRA == 1'd1)
    $write("ok ");
  else
				$write("error @ %t , get %d, expect %d", $time, BRA, 1'd1);
		$write("\n");
	#10 clk = 1'd0;
end
endtask

task test_ADD_X_OR_Y;
begin
  #10 clk = 1'd1;
  $write(" CU_ADD_X_OR_Y \t");
  opcode = 6'd13;
  Immediate = 9'd0;
  #1
    if (ALU == 1'd1 && flag_select == 1'd1 && ACC_select == 1'd1)
      $write("ok ");
    else
				$write("error @ %t , get %d %d %d, expect %d %d %d", $time, ALU, flag_select, ACC_select, 1'd1, 1'd1, 1'd1);
		$write("\n");
		#10 clk = 1'd0;
end
endtask

task test_ADD_X_Immediate;
begin
  #10 clk = 1'd1;
  $write(" CU_ADD_X_Immediate \t");
  opcode = 6'd13;
  Immediate = 9'd1;
  RA = 1'd0;
  #1
    if (ALU == 1'd1 && flag_select == 1'd1 && X_select == 1'd1)
      $write("ok ");
    else
				$write("error @ %t , get %d %d %d, expect %d %d %d", $time, ALU, flag_select, X_select, 1'd1, 1'd1, 1'd1);
		$write("\n");
		#10 clk = 1'd0;
end
endtask

task test_ADD_Y_Immediate;
begin
  #10 clk = 1'd1;
  $write(" CU_ADD_Y_Immediate \t");
  opcode = 6'd13;
  Immediate = 9'd215;
  RA = 1'd1;
  #1
    if (ALU == 1'd1 && flag_select == 1'd1 && Y_select == 1'd1)
      $write("ok ");
    else
				$write("error @ %t , get %d %d %d, expect %d %d %d", $time, ALU, flag_select, Y_select, 1'd1, 1'd1, 1'd1);
		$write("\n");
		#10 clk = 1'd0;
end
endtask

task test_SUB_X_OR_Y;
begin
  #10 clk = 1'd1;
  $write(" CU_SUB_X_OR_Y \t");
  opcode = 6'd14;
  Immediate = 9'd0;
  #1
    if (ALU == 1'd1 && flag_select == 1'd1 && ACC_select == 1'd1)
      $write("ok ");
    else
				$write("error @ %t , get %d %d %d, expect %d %d %d", $time, ALU, flag_select, ACC_select, 1'd1, 1'd1, 1'd1);
		$write("\n");
		#10 clk = 1'd0;
end
endtask

task test_SUB_X_Immediate;
begin
  #10 clk = 1'd1;
  $write(" CU_SUB_X_Immediate \t");
  opcode = 6'd14;
  Immediate = 9'd12;
  RA = 1'd0;
  #1
    if (ALU == 1'd1 && flag_select == 1'd1 && X_select == 1'd1)
      $write("ok ");
    else
				$write("error @ %t , get %d %d %d, expect %d %d %d", $time, ALU, flag_select, X_select, 1'd1, 1'd1, 1'd1);
		$write("\n");
		#10 clk = 1'd0;
end
endtask

task test_SUB_Y_Immediate;
begin
  #10 clk = 1'd1;
  $write(" CU_SUB_Y_Immediate \t");
  opcode = 6'd14;
  Immediate = 9'd65;
  RA = 1'd1;
  #1
    if (ALU == 1'd1 && flag_select == 1'd1 && Y_select == 1'd1)
      $write("ok ");
    else
				$write("error @ %t , get %d %d %d, expect %d %d %d", $time, ALU, flag_select, Y_select, 1'd1, 1'd1, 1'd1);
		$write("\n");
		#10 clk = 1'd0;
end
endtask

task test_LSR_X_OR_Y;
begin
  #10 clk = 1'd1;
  $write(" CU_LSR_X_OR_Y \t");
  opcode = 6'd15;
  Immediate = 9'd0;
  #1
    if (ALU == 1'd1 && flag_select == 1'd1 && ACC_select == 1'd1)
      $write("ok ");
    else
				$write("error @ %t , get %d %d %d, expect %d %d %d", $time, ALU, flag_select, ACC_select, 1'd1, 1'd1, 1'd1);
		$write("\n");
		#10 clk = 1'd0;
end
endtask

task test_LSR_X_Immediate;
begin
  #10 clk = 1'd1;
  $write(" CU_LSR_X_Immediate \t");
  opcode = 6'd15;
  Immediate = 9'd1;
  RA = 1'd0;
  #1
    if (ALU == 1'd1 && flag_select == 1'd1 && X_select == 1'd1)
      $write("ok ");
    else
				$write("error @ %t , get %d %d %d, expect %d %d %d", $time, ALU, flag_select, X_select, 1'd1, 1'd1, 1'd1);
		$write("\n");
		#10 clk = 1'd0;
end
endtask

task test_LSR_Y_Immediate;
begin
  #10 clk = 1'd1;
  $write(" CU_LSR_Y_Immediate \t");
  opcode = 6'd15;
  Immediate = 9'd2;
  RA = 1'd1;
  #1
    if (ALU == 1'd1 && flag_select == 1'd1 && Y_select == 1'd1)
      $write("ok ");
    else
				$write("error @ %t , get %d %d %d, expect %d %d %d", $time, ALU, flag_select, Y_select, 1'd1, 1'd1, 1'd1);
		$write("\n");
		#10 clk = 1'd0;
end
endtask

task test_LSL_X_OR_Y;
begin
  #10 clk = 1'd1;
  $write(" CU_LSL_X_OR_Y \t");
  opcode = 6'd16;
  Immediate = 9'd0;
  #1
    if (ALU == 1'd1 && flag_select == 1'd1 && ACC_select == 1'd1)
      $write("ok ");
    else
				$write("error @ %t , get %d %d %d, expect %d %d %d", $time, ALU, flag_select, ACC_select, 1'd1, 1'd1, 1'd1);
		$write("\n");
		#10 clk = 1'd0;
end
endtask

task test_LSL_X_Immediate;
begin
  #10 clk = 1'd1;
  $write(" CU_LSL_X_Immediate \t");
  opcode = 6'd16;
  Immediate = 9'd3;
  RA = 1'd0;
  #1
    if (ALU == 1'd1 && flag_select == 1'd1 && X_select == 1'd1)
      $write("ok ");
    else
				$write("error @ %t , get %d %d %d, expect %d %d %d", $time, ALU, flag_select, X_select, 1'd1, 1'd1, 1'd1);
		$write("\n");
		#10 clk = 1'd0;
end
endtask

task test_LSL_Y_Immediate;
begin
  #10 clk = 1'd1;
  $write(" CU_LSL_Y_Immediate \t");
  opcode = 6'd16;
  Immediate = 9'd2;
  RA = 1'd1;
  #1
    if (ALU == 1'd1 && flag_select == 1'd1 && Y_select == 1'd1)
      $write("ok ");
    else
				$write("error @ %t , get %d %d %d, expect %d %d %d", $time, ALU, flag_select, Y_select, 1'd1, 1'd1, 1'd1);
		$write("\n");
		#10 clk = 1'd0;
end
endtask

task test_MUL_X_OR_Y;
begin
  #10 clk = 1'd1;
  $write(" CU_MUL_X_OR_Y \t");
  opcode = 6'd17;
  Immediate = 9'd0;
  #1
    if (ALU == 1'd1 && flag_select == 1'd1 && ACC_select == 1'd1)
      $write("ok ");
    else
				$write("error @ %t , get %d %d %d, expect %d %d %d", $time, ALU, flag_select, ACC_select, 1'd1, 1'd1, 1'd1);
		$write("\n");
		#10 clk = 1'd0;
end
endtask

task test_MUL_X_Immediate;
begin
  #10 clk = 1'd1;
  $write(" CU_MUL_X_Immediate \t");
  opcode = 6'd17;
  Immediate = 9'd9;
  RA = 1'd0;
  #1
    if (ALU == 1'd1 && flag_select == 1'd1 && X_select == 1'd1)
      $write("ok ");
    else
				$write("error @ %t , get %d %d %d, expect %d %d %d", $time, ALU, flag_select, X_select, 1'd1, 1'd1, 1'd1);
		$write("\n");
		#10 clk = 1'd0;
end
endtask

task test_MUL_Y_Immediate;
begin
  #10 clk = 1'd1;
  $write(" CU_MUL_Y_Immediate \t");
  opcode = 6'd17;
  Immediate = 9'd120;
  RA = 1'd1;
  #1
    if (ALU == 1'd1 && flag_select == 1'd1 && Y_select == 1'd1)
      $write("ok ");
    else
				$write("error @ %t , get %d %d %d, expect %d %d %d", $time, ALU, flag_select, Y_select, 1'd1, 1'd1, 1'd1);
		$write("\n");
		#10 clk = 1'd0;
end
endtask

task test_DIV_X_OR_Y;
begin
  #10 clk = 1'd1;
  $write(" CU_DIV_X_OR_Y \t");
  opcode = 6'd18;
  Immediate = 9'd0;
  #1
    if (ALU == 1'd1 && flag_select == 1'd1 && ACC_select == 1'd1)
      $write("ok ");
    else
				$write("error @ %t , get %d %d %d, expect %d %d %d", $time, ALU, flag_select, ACC_select, 1'd1, 1'd1, 1'd1);
		$write("\n");
		#10 clk = 1'd0;
end
endtask

task test_DIV_X_Immediate;
begin
  #10 clk = 1'd1;
  $write(" CU_DIV_X_Immediate \t");
  opcode = 6'd18;
  Immediate = 9'd10;
  RA = 1'd0;
  #1
    if (ALU == 1'd1 && flag_select == 1'd1 && X_select == 1'd1)
      $write("ok ");
    else
				$write("error @ %t , get %d %d %d, expect %d %d %d", $time, ALU, flag_select, X_select, 1'd1, 1'd1, 1'd1);
		$write("\n");
		#10 clk = 1'd0;
end
endtask

task test_DIV_Y_Immediate;
begin
  #10 clk = 1'd1;
  $write(" CU_DIV_Y_Immediate \t");
  opcode = 6'd18;
  Immediate = 9'd7;
  RA = 1'd1;
  #1
    if (ALU == 1'd1 && flag_select == 1'd1 && Y_select == 1'd1)
      $write("ok ");
    else
				$write("error @ %t , get %d %d %d, expect %d %d %d", $time, ALU, flag_select, Y_select, 1'd1, 1'd1, 1'd1);
		$write("\n");
		#10 clk = 1'd0;
end
endtask

task test_MOD_X_OR_Y;
begin
  #10 clk = 1'd1;
  $write(" CU_MOD_X_OR_Y \t");
  opcode = 6'd19;
  Immediate = 9'd0;
  #1
    if (ALU == 1'd1 && flag_select == 1'd1 && ACC_select == 1'd1)
      $write("ok ");
    else
				$write("error @ %t , get %d %d %d, expect %d %d %d", $time, ALU, flag_select, ACC_select, 1'd1, 1'd1, 1'd1);
		$write("\n");
		#10 clk = 1'd0;
end
endtask

task test_MOD_X_Immediate;
begin
  #10 clk = 1'd1;
  $write(" CU_MOD_X_Immediate \t");
  opcode = 6'd19;
  Immediate = 9'd3;
  RA = 1'd0;
  #1
    if (ALU == 1'd1 && flag_select == 1'd1 && X_select == 1'd1)
      $write("ok ");
    else
				$write("error @ %t , get %d %d %d, expect %d %d %d", $time, ALU, flag_select, X_select, 1'd1, 1'd1, 1'd1);
		$write("\n");
		#10 clk = 1'd0;
end
endtask

task test_MOD_Y_Immediate;
begin
  #10 clk = 1'd1;
  $write(" CU_MOD_Y_Immediate \t");
  opcode = 6'd19;
  Immediate = 9'd2;
  RA = 1'd1;
  #1
    if (ALU == 1'd1 && flag_select == 1'd1 && Y_select == 1'd1)
      $write("ok ");
    else
				$write("error @ %t , get %d %d %d, expect %d %d %d", $time, ALU, flag_select, Y_select, 1'd1, 1'd1, 1'd1);
		$write("\n");
		#10 clk = 1'd0;
end
endtask

task test_INC_X;
begin
  #10 clk = 1'd1;
  $write(" CU_INC_X \t");
  opcode = 6'd21;
  RA = 1'd0;
  #1
    if (ALU == 1'd1 && flag_select == 1'd1 && X_select == 1'd1)
      $write("ok ");
    else
				$write("error @ %t , get %d %d %d, expect %d %d %d", $time, ALU, flag_select, X_select, 1'd1, 1'd1, 1'd1);
  
		$write("\n");
		#10 clk = 1'd0;
end
endtask

task test_INC_Y;
begin
  #10 clk = 1'd1;
  $write(" CU_INC_Y \t");
  opcode = 6'd21;
  RA = 1'd1;
  #1
    if (ALU == 1'd1 && flag_select == 1'd1 && Y_select == 1'd1)
      $write("ok ");
    else
				$write("error @ %t , get %d %d %d, expect %d %d %d", $time, ALU, flag_select, Y_select, 1'd1, 1'd1, 1'd1);
  
		$write("\n");
		#10 clk = 1'd0;
end
endtask

task test_DEC_X;
begin
  #10 clk = 1'd1;
  $write(" CU_DEC_X \t");
  opcode = 6'd22;
  RA = 1'd0;
  #1
    if (ALU == 1'd1 && flag_select == 1'd1 && X_select == 1'd1)
      $write("ok ");
    else
				$write("error @ %t , get %d %d %d, expect %d %d %d", $time, ALU, flag_select, X_select, 1'd1, 1'd1, 1'd1);
  
		$write("\n");
		#10 clk = 1'd0;
end
endtask

task test_DEC_Y;
begin
  #10 clk = 1'd1;
  $write(" CU_DEC_Y \t");
  opcode = 6'd22;
  RA = 1'd1;
  #1
    if (ALU == 1'd1 && flag_select == 1'd1 && Y_select == 1'd1)
      $write("ok ");
    else
				$write("error @ %t , get %d %d %d, expect %d %d %d", $time, ALU, flag_select, Y_select, 1'd1, 1'd1, 1'd1);
  
		$write("\n");
		#10 clk = 1'd0;
end
endtask

task test_CMP;
begin
  #10 clk = 1'd1;
  $write(" CU_CMP \t");
  opcode = 6'd20;
  #1
    if (ALU == 1'd1 && flag_select == 1'd1)
      $write("ok ");
    else
				$write("error @ %t , get %d %d, expect %d %d", $time, ALU, flag_select, 1'd1, 1'd1);
  
		$write("\n");
		#10 clk = 1'd0;
end
endtask

task test_MOV_X;
begin
  #10 clk = 1'd1;
  $write(" CU_MOV_X \t");
  opcode = 6'b011110;
  RA = 1'd0;
  #1
    if (MOV == 1'd1 && X_select == 1'd1)
      $write("ok ");
    else
				$write("error @ %t , get %d %d, expect %d %d", $time, MOV, X_select, 1'd1, 1'd1);
  
		$write("\n");
		#10 clk = 1'd0;
end
endtask

task test_MOV_Y;
begin
  #10 clk = 1'd1;
  $write(" CU_MOV_Y \t");
  opcode = 6'b011110;
  RA = 1'd1;
  #1
    if (MOV == 1'd1 && Y_select == 1'd1)
      $write("ok ");
    else
				$write("error @ %t , get %d %d, expect %d %d", $time, MOV, Y_select, 1'd1, 1'd1);
  
		$write("\n");
		#10 clk = 1'd0;
end
endtask


endmodule