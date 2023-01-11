module FACT_CNT_tb;
reg [8:0] cnt;
reg clk, rst, w;
wire [8:0] out;
wire FACT_END;

FACT_CNT instantaFACT_CNT(.cnt(cnt), .clk(clk), .rst(rst), .w(w), .out(out), .FACT_END(FACT_END));

initial begin
  rst = 1'd0;
  #1
  rst = 1'd1;
  w = 1'd1;
  clk = 1'd1;
  cnt = 9'd3;
  #5
  w = 1'd0;
  CNT1;
  #5
  CNT2;
  #5
  CNT3;
  #5
  CNT4;
  #5
  CNT5;
  $stop;
  $finish;

end

task CNT1;
  begin
    #5
    if (out == 9'd3 && FACT_END == 1'b0) 
      $write("Test 1 passed\n");
    else
      $write("Test 1 error: expected %b %b actual %b %b\n",16'd3,1'd0,out,FACT_END);  
    #10 clk = 1'd0;
  end
endtask

task CNT2;
  begin
    #10 clk = 1'd1;
    #5
    if (out == 9'd2 && FACT_END == 1'b0) 
      $write("Test 2 passed\n");
    else
      $write("Test 2 error: expected %b %b actual %b %b\n",9'd2,1'd0,out,FACT_END);  
    #10 clk = 1'd0;
  end
endtask

task CNT3;
  begin
    #10 clk = 1'd1;
    #5
    if (out == 9'd1 && FACT_END ==  1'b1) 
      $write("Test 3 passed\n");
    else
      $write("Test 3 error: expected %b %b actual %b %b\n",9'd1,1'b1,out,FACT_END); 
    #10 clk = 1'd0;
  end
endtask

task CNT4;
  begin
    #10 clk = 1'd1;
    #5
    if (out == 9'd0 && FACT_END == 1'b0) 
      $write("Test 4 passed\n");
    else
      $write("Test 4 error: expected %b %b actual %b %b\n",9'd0,1'b0,out,FACT_END);  
    #10 clk = 1'd0;
  end
endtask

task CNT5;
  begin
    #10 clk = 1'd1;
    #5
    if (out == 9'd0 &&  FACT_END == 1'b0) 
      $write("Test 5 passed\n");
    else
      $write("Test 5 error: expected %b %b actual %b %b\n",9'd0,1'b0,out,FACT_END);  
    #10 clk = 1'd0;
  end
endtask

endmodule