module PC_tb;
reg [15:0] in;
reg clk, rst, w, BRA, STACK_POP;
wire [15:0] out;

PC instantaPC(.in(in), .clk(clk), .rst(rst), .w(w), .BRA(BRA), .STACK_POP(STACK_POP), .out(out));

initial begin
  w = 1'd0;
  BRA = 1'd0;
  STACK_POP = 1'd0;
  in <= 16'b0110101010110011;
  
  PC1;
  #5
  PC2;
  #5
  PC3;
  #5
  PC4;
  #5
  PC5;
  #5
  PC6;
  #5
  PC7;
  #5
  PC8;
  
end

task PC1;
  begin
    clk = 1'd0;
    rst = 1'd0;
    #5
    if (out == 16'b0000000000000000) 
      $write("Test 1 passed\n");
    else
      $write("Test 1 error: expected %b actual %b\n",16'b0000000000000000,out);  
    #10 clk = 1'd1;
  end
endtask

task PC2;
  begin
    #10 clk = 1'd0;
    rst = 1'd1;
    #5
    if (out == 16'b0000000000000001) 
      $write("Test 2 passed\n");
    else
      $write("Test 2 error: expected %b actual %b\n",16'b0000000000000001,out);  
    #10 clk = 1'd1;
  end
endtask

task PC3;
  begin
    #10 clk = 1'd0;
    rst = 1'd1;
    BRA = 1'd1;
    #5
    if (out == 16'b0000000000000010) 
      $write("Test 3 passed\n");
    else
      $write("Test 3 error: expected %b actual %b\n",16'b0000000000000010,out);  
    #10 clk = 1'd1;
  end
endtask

task PC4;
  begin
    #10 clk = 1'd0;
    rst = 1'd1;
    BRA = 1'd1;
    w = 1'd1;
    #5
    if (out == 16'b0110101010110011) 
      $write("Test 4 passed\n");
    else
      $write("Test 4 error: expected %b actual %b\n",16'b0110101010110011,out);  
    #10 clk = 1'd1;
  end
endtask

task PC5;
  begin
    in <= 16'b1000011110101011;
    #10 clk = 1'd0;
    rst = 1'd1;
    BRA = 1'd0;
    STACK_POP = 1'd1;
    w = 1'd1;
    #5
    if (out == 16'b1000011110101101) 
      $write("Test 5 passed\n");
    else
      $write("Test 5 error: expected %b actual %b\n",16'b1000011110101101,out);  
    #10 clk = 1'd1;
  end
endtask

task PC6;
  begin
    in <= 16'b1000010000000000;
    #10 clk = 1'd0;
    rst = 1'd1;
    BRA = 1'd0;
    STACK_POP = 1'd0;
    w = 1'd1;
    #5
    if (out == 16'b1000011110101110) 
      $write("Test 6 passed\n");
    else
      $write("Test 6 error: expected %b actual %b\n",16'b1000011110101110,out);  
    #10 clk = 1'd1;
  end
endtask

task PC7;
  begin
    in <= 16'b1000010000000000;
    #10 clk = 1'd0;
    rst = 1'd0;
    BRA = 1'd0;
    STACK_POP = 1'd0;
    w = 1'd1;
    #5
    if (out == 16'b0000000000000000) 
      $write("Test 7 passed\n");
    else
      $write("Test 7 error: expected %b actual %b\n",16'b0000000000000000,out);  
    #10 clk = 1'd1;
  end
endtask

task PC8;
  begin
    in <= 16'b1000010000000000;
    #10 clk = 1'd0;
    rst = 1'd1;
    BRA = 1'd0;
    STACK_POP = 1'd1;
    w = 1'd0;
    #5
    if (out == 16'b0000000000000001) 
      $write("Test 8 passed\n");
    else
      $write("Test 8 error: expected %b actual %b\n",16'b0000000000000001,out);  
    #10 clk = 1'd1;
  end
endtask

endmodule