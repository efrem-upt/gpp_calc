module SE9x16_tb;
reg [8:0] in;
wire [15:0] out;

SE9x16 instantaSE(.in(in),.out(out));

initial begin
  SE1;
  #5
  SE2;
  #5
  SE3;
  #5
  SE4;
  #5
  SE5;
  #5
  SE6;
end

task SE1;
  begin
    in <= 9'b101100110;
    #5
    if (out == 16'b1111111101100110) 
      $write("Test 1 passed\n");
   else
      $write("Test 1 error: expected %b actual %b\n",16'b1111111101100110,out);  
  end
endtask

task SE2;
  begin
    in <= 9'b001011110;
    #5
    if (out == 16'b0000000001011110) 
      $write("Test 2 passed\n");
   else
      $write("Test 2 error: expected %b actual %b\n",16'b0000000001011110,out);  
  end
endtask

task SE3;
  begin
    in <= 9'b011111111;
    #5
    if (out == 16'b0000000011111111) 
      $write("Test 3 passed\n");
   else
      $write("Test 3 error: expected %b actual %b\n",16'b0000000011111111,out);  
  end
endtask

task SE4;
  begin
    in <= 9'b111111111;
    #5
    if (out == 16'b1111111111111111) 
      $write("Test 4 passed\n");
   else
      $write("Test 4 error: expected %b actual %b\n",16'b1111111111111111,out);  
  end
endtask

task SE5;
  begin
    in <= 9'b100000001;
    #5
    if (out == 16'b1111111100000001) 
      $write("Test 5 passed\n");
   else
      $write("Test 5 error: expected %b actual %b\n",16'b1111111100000001,out);  
  end
endtask

task SE6;
  begin
    in <= 9'b100000000;
    #5
    if (out == 16'b1111111100000000) 
      $write("Test 6 passed\n");
   else
      $write("Test 6 error: expected %b actual %b\n",16'b1111111100000000,out);  
  end
endtask

endmodule
