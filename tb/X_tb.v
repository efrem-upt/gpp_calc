module X_tb;
reg [15:0] in;
reg clk, rst, w;
wire [15:0] out;

X instantaX(.in(in), .clk(clk), .rst(rst), .w(w), .out(out));

initial begin
  rst = 1'd0;
	#5
  X1;
  #50;
  rst = 1'd1;
  #5
  X2;
  #5
  X3;
  #5
  X4;
  #5
  X5;
end

task X1;
  begin
    in <= 16'b0110101010110011;
    #10 clk = 1'd0;
    w = 1;
    #5
    if (out == 16'b0000000000000000) 
      $write("Test 1 passed\n");
    else
      $write("Test 1 error: expected %b actual %b\n",16'b0000000000000000,out);  
    #10 clk = 1'd1;
  end
endtask

task X2;
  begin
    in <= 16'b0110101010110011;
    #10 clk = 1'd0;
    w = 1;
    #5
    if (out == 16'b0110101010110011) 
      $write("Test 2 passed\n");
    else
      $write("Test 2 error: expected %b actual %b\n",16'b0110101010110011,out);  
    #10 clk = 1'd1;
  end
endtask

task X3;
  begin
    in <= 16'b0000000000000001;
    #10 clk = 1'd0;
    w = 1;
    #5
    if (out == 16'b0000000000000001) 
      $write("Test 3 passed\n");
    else
      $write("Test 3 error: expected %b actual %b\n",16'b0000000000000001,out);  
    #10 clk = 1'd1;
  end
endtask

task X4;
  begin
    in <= 16'b1111111111111111;
    #10 clk = 1'd0;
    w = 1;
    #5
    if (out == 16'b1111111111111111) 
      $write("Test 4 passed\n");
    else
      $write("Test 4 error: expected %b actual %b\n",16'b1111111111111111,out);  
    #10 clk = 1'd1;
  end
endtask

task X5;
  begin
    in <= 16'b1001010111001101;
    #10 clk = 1'd0;
    w = 0;
    #5
    if (out == 16'b1111111111111111) 
      $write("Test 5 passed\n");
    else
      $write("Test 5 error: expected %b actual %b\n",16'b1111111111111111,out);  
    #10 clk = 1'd1;
  end
endtask

endmodule