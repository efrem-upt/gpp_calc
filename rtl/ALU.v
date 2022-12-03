module ALU(
  input [15:0] ACC,X,Y,Immediate,
  input [5:0] opcode,
  input en,clk,rst,RA,
  output reg [15:0] res,
  output reg [3:0] flags);
  
  reg [15:0] value_before_add;
  reg sign_before_add, same_sign;
  
  always @(negedge rst) begin
    if (!rst) begin
      res <= 16'd0;
      flags <= 4'd0;
    end
end

always @(*) begin
    if (clk && en) begin
      case (opcode)
        6'b001101: begin
          if (Immediate == 16'd0) begin
          sign_before_add = ACC[15];
          value_before_add = ACC;
          if (RA == 1'd0) begin
            if (ACC[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = ACC + X;
         end
          else begin
            if (ACC[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = ACC + Y;
          end
          if (same_sign == 1'd1 && sign_before_add != res[15])
              flags[0] = 1'd1;
        else
              flags[0] = 1'd0; 
            if (res < value_before_add) 
              flags[1] = 1'd1;
            else
              flags[1] = 1'd0;
            if  (res ==  16'd0) 
              flags[3] = 1'd1;
          else 
              flags[3] = 1'd0;
            if (res[15] == 1'd1)
              flags[2] = 1'd1;
          else
              flags[2] = 1'd0;
       end
    else begin
          sign_before_add = Immediate[15];
          value_before_add = Immediate;
          if (RA == 1'd0) begin
            if (Immediate[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = Immediate + X;
         end
          else begin
            if (Immediate[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = Immediate + Y;
          end
          if (same_sign == 1'd1 && sign_before_add != res[15])
              flags[0] = 1'd1;
        else
              flags[0] = 1'd0; 
            if (res < value_before_add) 
              flags[1] = 1'd1;
            else
              flags[1] = 1'd0;
             if  (res ==  16'd0) 
              flags[3] = 1'd1;
          else 
              flags[3] = 1'd0;
            if (res[15] == 1'd1)
              flags[2] = 1'd1;
          else
              flags[2] = 1'd0;
    end
       end
      endcase
    end
  end
  
endmodule
