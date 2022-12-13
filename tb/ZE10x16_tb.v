module ZE10x16_tb;
reg [9:0] in;
wire [15:0] out;

ZE10x16 instantaZE(.in(in),.out(out));

initial begin
  ZE1;
  #5
  ZE2;
  #5
  ZE3;
  #5
  ZE4;
  #5
  ZE5;
end

task ZE1;
  begin
    in <= 10'b1101100110;
    #5
    if (out == 16'b0000001101100110) 
      $write("Test 1 passed\n");
   else
      $write("Test 1 error: expected %b actual %b\n",16'b0000001101100110,out);  
  end
endtask

task ZE2;
  begin
    in <= 10'b1111111111;
    #5
    if (out == 16'b0000001111111111) 
      $write("Test 2 passed\n");
   else
      $write("Test 2 error: expected %b actual %b\n",16'b0000001111111111,out);  
  end
endtask

task ZE3;
  begin
    in <= 10'b1000000000;
    #5
    if (out == 16'b0000001000000000) 
      $write("Test 3 passed\n");
   else
      $write("Test 3 error: expected %b actual %b\n",16'b0000001000000000,out);  
  end
endtask

task ZE4;
  begin
    in <= 10'b0111111111;
    #5
    if (out == 16'b0000000111111111) 
      $write("Test 4 passed\n");
   else
      $write("Test 4 error: expected %b actual %b\n",16'b0000000111111111,out);  
  end
endtask

task ZE5;
  begin
    in <= 10'b1010101010;
    #5
    if (out == 16'b0000001010101010) 
      $write("Test 5 passed\n");
   else
      $write("Test 5 error: expected %b actual %b\n",16'b0000001010101010,out);  
  end
endtask

endmodule
