module IR_tb;
reg [15:0] in;
reg clk, rst, w;
wire [15:0] out;
wire [5:0] opcode;
wire RA;
wire [9:0] BA;
wire [8:0] IMM;
wire [1:0] RA_stack;

IR instantaIR(.in(in), .clk(clk), .rst(rst), .w(w), .out(out), .opcode(opcode), .RA(RA), .BA(BA), .IMM(IMM), .RA_stack(RA_stack));

initial begin
  w = 1'd0;
  in <= 16'b0110101010110011;
  
  #5
  IR1;
  #5
  IR2;
  #5
  IR3;
  
end

task IR1;
  begin
    clk = 1'd1;
    rst = 1'd0;
    #5
    if (out == 16'd0 && RA == 1'd0 && BA == 10'd0 && IMM == 9'd0 && RA_stack == 2'd0) 
      $write("Test 1 passed\n");
    else
      $write("Test 1 error: expected %b %b %b %b %b, actual %b %b %b %b %b\n",16'b0000000000000000,1'b0,10'b0000000000,9'b000000000,2'b00,out,RA,BA,IMM,RA_stack);  
    #10 clk = 1'd0;
  end
endtask

task IR2;
  begin
    #10 clk = 1'd1;
    rst = 1'd1;
    w = 1'd1;
    #5
    if (out == 16'b0110101010110011 && opcode == 6'b011010 && RA == 1'b1 && BA == 10'b1010110011 && IMM == 9'b010110011 && RA_stack == 2'b10) 
      $write("Test 2 passed\n");
    else
      $write("Test 2 error: expected %b %b %b %b %b %b, actual %b %b %b %b %b %b\n",16'b0110101010110011,6'b011010,1'b1,10'b1010110011,9'b010110011,2'b10,out,opcode,RA,BA,IMM,RA_stack);  
    #10 clk = 1'd0;
  end
endtask

task IR3;
  begin
    in <= 16'b0001011011110100;
    #10 clk = 1'd1;
    rst = 1'd1;
    w = 1'd0;
    #5
    if (out == 16'b0110101010110011 && opcode == 6'b011010 && RA == 1'b1 && BA == 10'b1010110011 && IMM == 9'b010110011 && RA_stack == 2'b10) 
      $write("Test 3 passed\n");
    else
      $write("Test 3 error: expected %b %b %b %b %b %b, actual %b %b %b %b %b %b\n",16'b0110101010110011,6'b011010,1'b1,10'b1010110011,9'b010110011,2'b10,out,opcode,RA,BA,IMM,RA_stack);  
    #10 clk = 1'd0;
  end
endtask

endmodule
