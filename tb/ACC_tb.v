module ACC_tb;
reg [15:0] in;
reg clk, rst, w;
wire [15:0] out;

ACC instantaACC(.in(in), .clk(clk), .rst(rst), .w(w), .out(out));

initial begin
  
	#5
  ACC1;
  #5
  ACC2;
  #5
  ACC3;
  #5
  ACC4;
  #5
  ACC5;
end

task ACC1;
  begin
    in <= 16'b0110101010110011;
    #10 clk = 1'd0;
    w = 0;
    rst = 0;
    #5
    if (out == 16'b0000000000000000) 
      $write("Test 1 passed\n");
    else
      $write("Test 1 error: expected %b actual %b\n",16'b0000000000000000,out);  
    #10 clk = 1'd1;
  end
endtask

task ACC2;
  begin
    in <= 16'b0110101010110011;
    #10 clk = 1'd0;
    w = 1;
    rst = 1;
    #5
    if (out == 16'b0110101010110011) 
      $write("Test 2 passed\n");
    else
      $write("Test 2 error: expected %b actual %b\n",16'b0110101010110011,out);  
    #10 clk = 1'd1;
  end
endtask

task ACC3;
  begin
    in <= 16'b0000100000000000;
    #10 clk = 1'd0;
    w = 0;
    rst = 1;
    #5
    if (out == 16'b0110101010110011) 
      $write("Test 3 passed\n");
    else
      $write("Test 3 error: expected %b actual %b\n",16'b0110101010110011,out);  
    #10 clk = 1'd1;
  end
endtask

task ACC4;
  begin
    in <= 16'b0000111100000000;
    #10 clk = 1'd0;
    w = 1;
    rst = 1;
    #5
    if (out == 16'b0000111100000000) 
      $write("Test 4 passed\n");
    else
      $write("Test 4 error: expected %b actual %b\n",16'b0000111100000000,out);  
    #10 clk = 1'd1;
  end
endtask

task ACC5;
  begin
    in <= 16'b0000111100000000;
    #10 clk = 1'd0;
    w = 1;
    rst = 0;
    #5
    if (out == 16'b0000000000000000) 
      $write("Test 5 passed\n");
    else
      $write("Test 5 error: expected %b actual %b\n",16'b0000000000000000,out);  
    #10 clk = 1'd1;
  end
endtask

endmodule
