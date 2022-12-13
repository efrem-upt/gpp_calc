module Y_tb;
reg [15:0] in;
reg clk, rst, w;
wire [15:0] out;

Y instantaX(.in(in), .clk(clk), .rst(rst), .w(w), .out(out));

initial begin
	#5
  Y1;
  #50;
  rst = 1'd1;
  #5
  Y2;
  #5
  Y3;
  #5
  Y4;
  #5
  Y5;
end

task Y1;
  begin
    in <= 16'b1011110010100010;
    #10 clk = 1'd0;
    rst = 1'd0;
    w = 1;
    #5
    if (out == 16'b0000000000000000) 
      $write("Test 1 passed\n");
    else
      $write("Test 1 error: expected %b actual %b\n",16'b0000000000000000,out);  
    #10 clk = 1'd1;
  end
endtask

task Y2;
  begin
    in <= 16'b1011110010100010;
    #10 clk = 1'd0;
    w = 1;
    #5
    if (out == 16'b1011110010100010) 
      $write("Test 2 passed\n");
    else
      $write("Test 2 error: expected %b actual %b\n",16'b1011110010100010,out);  
    #10 clk = 1'd1;
  end
endtask

task Y3;
  begin
    in <= 16'b0000000000000111;
    #10 clk = 1'd0;
    rst = 0;
    w = 1;
    #5
    if (out == 16'b0000000000000000) 
      $write("Test 3 passed\n");
    else
      $write("Test 3 error: expected %b actual %b\n",16'b0000000000000000,out);  
    #10 clk = 1'd1;
  end
endtask

task Y4;
  begin
    in <= 16'b1111111111111111;
    #10 clk = 1'd0;
    rst = 1;
    w = 1;
    #5
    if (out == 16'b1111111111111111) 
      $write("Test 4 passed\n");
    else
      $write("Test 4 error: expected %b actual %b\n",16'b1111111111111111,out);  
    #10 clk = 1'd1;
  end
endtask

task Y5;
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
