module IM_tb;
reg [9:0] addr;
reg rst;
wire [15:0] out;

IM InstructionMemory(.addr(addr),.rst(rst),.out(out));

initial begin
  $readmemb("test.mem", InstructionMemory.rom); 
  addr <= 1'd0;
  rst <= 1'd1;
  #2 rst <= 1'd0;
  #1 rst <= 1'd1;
end

always begin
  #6 addr <= addr + 10'd1;
end

always begin
  #50 addr <= 1'd0;
end

endmodule