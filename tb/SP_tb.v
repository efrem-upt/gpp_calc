module SP_tb;
reg clk, rst, inc, dec;
wire [15:0] out;

SP instantaSP(.clk(clk), .rst(rst), .inc(inc), .dec(dec), .out(out));

initial begin
  
  SP1;
  #5
  SP2;
  #5
  SP3;
  #5
  SP4;
  #5
  SP5;
  
end

task SP1;
  begin
    #10 clk = 1'd0;
    inc = 0;
    dec = 0;
    rst = 0;
    #5
    if (out == 16'b0000000111111111) 
      $write("Test 1 passed\n");
    else
      $write("Test 1 error: expected %b actual %b\n",16'b0000000111111111,out);  
    #10 clk = 1'd1;
  end
endtask

task SP2;
  begin
    #10 clk = 1'd0;
    rst = 1;
    inc = 0;
    dec = 1;
    #5
    if (out == 16'b0000000111111110) 
      $write("Test 2 passed\n");
    else
      $write("Test 2 error: expected %b actual %b\n",16'b0000000111111110,out);  
    #10 clk = 1'd1;
  end
endtask

task SP3;
  begin
    #10 clk = 1'd0;
    rst = 1;
    inc = 0;
    dec = 0;
    #5
    if (out == 16'b0000000111111110) 
      $write("Test 3 passed\n");
    else
      $write("Test 3 error: expected %b actual %b\n",16'b0000000111111110,out);  
    #10 clk = 1'd1;
  end
endtask

task SP4;
  begin
    #10 clk = 1'd0;
    rst = 1;
    inc = 1;
    dec = 0;
    #5
    if (out == 16'b0000000111111110) 
      $write("Test 4 passed\n");
    else
      $write("Test 4 error: expected %b actual %b\n",16'b0000000111111110,out); 
    #10 clk = 1'd1; 
  end
endtask

task SP5;
  begin
    #10 clk = 1'd0;
    rst = 1;
    inc = 1;
    dec = 0;
    #5
    if (out == 16'b0000000111111111) 
      $write("Test 5 passed\n");
    else
      $write("Test 5 error: expected %b actual %b\n",16'b0000000111111111,out);  
    #10 clk = 1'd1; 
  end
endtask

endmodule
