module SE9x16_tb;
reg [8:0] in;
wire [15:0] out;

SE9x16 ImmediateSignExtend(.in(in),.out(out));

initial begin
  in <= 9'b000010101;
  #50 in <= 9'b100101101;
end

always begin
  #100 in[8] = ~in[8];
end

endmodule
