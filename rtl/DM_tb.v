module DM_tb;
reg [15:0] in;
reg [8:0] addr;
reg clk;
reg rst;
reg w;
wire [15:0] out;

DM DataMemory(.in(in),.addr(addr),.clk(clk),.rst(rst),.w(w),.out(out));

initial begin
  in <= 16'd0;
  addr <= 9'd0;
  clk <= 1'd0;
  rst <= 1'd1;
  w <= 1'd1;
  #2 rst <= 1'd0;
  #1 rst <= 1'd1;
  forever #3 clk <= ~clk;
end

always begin
  #6
  in <= in + 16'd2;
  addr <= addr + 9'd1;
end

always begin
  #45
  w <= ~w;
end

always begin
  #50 addr <= 9'd0;
end

endmodule
