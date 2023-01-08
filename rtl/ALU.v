module ALU(
  input [15:0] ACC,X,Y,Immediate,fact_reg,fact_val,
  input [5:0] opcode,
  input en,clk,rst,RA,
  output reg [15:0] res,
  output reg [3:0] flags);
  
  reg [15:0] value_before_operation;
  reg sign_before_operation, same_sign;
  reg [15:0] rotate_cnt;
  
  always @(negedge rst) begin
    if (!rst) begin
      res <= 16'd0;
      flags <= 4'd0;
    end
end

always @(*) begin
    #1
    if (clk && en) begin
      case (opcode)
        6'b001101: begin
          if (Immediate == 16'd0) begin
          sign_before_operation = ACC[15];
          value_before_operation = ACC;
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
          if (same_sign == 1'd1 && sign_before_operation != res[15]) /* overflow */
              flags[0] = 1'd1;
        else
              flags[0] = 1'd0; 
            if (res < value_before_operation) // carry
              flags[1] = 1'd1;
            else
              flags[1] = 1'd0;
            if  (res ==  16'd0) //  zero
              flags[3] = 1'd1;
          else 
              flags[3] = 1'd0;
            if (res[15] == 1'd1) /* negative */
              flags[2] = 1'd1;
          else
              flags[2] = 1'd0;
       end
    else begin
          sign_before_operation = Immediate[15];
          value_before_operation = Immediate;
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
          if (same_sign == 1'd1 && sign_before_operation != res[15])
              flags[0] = 1'd1;
        else
              flags[0] = 1'd0; 
            if (res < value_before_operation) 
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
        6'b001110: begin
          if (Immediate == 16'd0) begin
          sign_before_operation = ACC[15];
          value_before_operation = ACC;
          if (RA == 1'd0) begin
            if (ACC[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = ACC - X;
         end
          else begin
            if (ACC[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = ACC - Y;
          end
          if (same_sign == 1'd1 && sign_before_operation != res[15]) /* overflow */
              flags[0] = 1'd1;
        else
              flags[0] = 1'd0; 
            if (res > value_before_operation) // borrow
              flags[1] = 1'd1;
            else
              flags[1] = 1'd0;
            if  (res ==  16'd0) //  zero
              flags[3] = 1'd1;
          else 
              flags[3] = 1'd0;
            if (res[15] == 1'd1) /* negative */
              flags[2] = 1'd1;
          else
              flags[2] = 1'd0;
       end
    else begin
          sign_before_operation = Immediate[15];
          value_before_operation = Immediate;
          if (RA == 1'd0) begin
            if (Immediate[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = X - Immediate;
         end
          else begin
            if (Immediate[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = Y - Immediate;
          end
          if (same_sign == 1'd1 && sign_before_operation != res[15])
              flags[0] = 1'd1;
        else
              flags[0] = 1'd0; 
            if (res > value_before_operation) 
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
        6'b001111: begin
          if (Immediate == 16'd0) begin
          sign_before_operation = ACC[15];
          value_before_operation = ACC;
          if (RA == 1'd0) begin
            if (ACC[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = ACC >> X;
         end
          else begin
            if (ACC[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = ACC >> Y;
          end
            flags[0] = 1'd0;
            flags[1] = 1'd0;
            if  (res ==  16'd0) //  zero
              flags[3] = 1'd1;
          else 
              flags[3] = 1'd0;
            if (res[15] == 1'd1) /* negative */
              flags[2] = 1'd1;
          else
              flags[2] = 1'd0;
       end
    else begin
          sign_before_operation = Immediate[15];
          value_before_operation = Immediate;
          if (RA == 1'd0) begin
            if (Immediate[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = X >> Immediate;
         end
          else begin
            if (Immediate[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = Y >> Immediate;
          end
            flags[0] = 1'd0;
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
        6'b010000: begin
          if (Immediate == 16'd0) begin
          sign_before_operation = ACC[15];
          value_before_operation = ACC;
          if (RA == 1'd0) begin
            if (ACC[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = ACC << X;
         end
          else begin
            if (ACC[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = ACC << Y;
          end
            flags[0] = 1'd0;
            flags[1] = 1'd0;
            if  (res ==  16'd0) //  zero
              flags[3] = 1'd1;
          else 
              flags[3] = 1'd0;
            if (res[15] == 1'd1) /* negative */
              flags[2] = 1'd1;
          else
              flags[2] = 1'd0;
       end
    else begin
          sign_before_operation = Immediate[15];
          value_before_operation = Immediate;
          if (RA == 1'd0) begin
            if (Immediate[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = X << Immediate;
         end
          else begin
            if (Immediate[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = Y << Immediate;
          end
            flags[0] = 1'd0;
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
        6'b010001: begin
          if (Immediate == 16'd0) begin
          sign_before_operation = ACC[15];
          value_before_operation = ACC;
          if (RA == 1'd0) begin
            if (ACC[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = ACC * X;
         end
          else begin
            if (ACC[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = ACC * Y;
          end
          if (same_sign == 1'd1 && sign_before_operation != res[15]) /* overflow */
              flags[0] = 1'd1;
        else
              flags[0] = 1'd0; 
            if (res < value_before_operation) // carry
              flags[1] = 1'd1;
            else
              flags[1] = 1'd0;
            if  (res ==  16'd0) //  zero
              flags[3] = 1'd1;
          else 
              flags[3] = 1'd0;
            if (res[15] == 1'd1) /* negative */
              flags[2] = 1'd1;
          else
              flags[2] = 1'd0;
       end
    else begin
          sign_before_operation = Immediate[15];
          value_before_operation = Immediate;
          if (RA == 1'd0) begin
            if (Immediate[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = Immediate * X;
         end
          else begin
            if (Immediate[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = Immediate * Y;
          end
          if (same_sign == 1'd1 && sign_before_operation != res[15])
              flags[0] = 1'd1;
        else
              flags[0] = 1'd0; 
            if (res < value_before_operation) 
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
        6'b010010: begin
          if (Immediate == 16'd0) begin
          sign_before_operation = ACC[15];
          value_before_operation = ACC;
          if (RA == 1'd0) begin
            if (ACC[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = ACC / X;
         end
          else begin
            if (ACC[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = ACC / Y;
          end
            flags[0] = 1'd0;
            flags[1] = 1'd0;
            if  (res ==  16'd0) //  zero
              flags[3] = 1'd1;
          else 
              flags[3] = 1'd0;
            if (res[15] == 1'd1) /* negative */
              flags[2] = 1'd1;
          else
              flags[2] = 1'd0;
       end
    else begin
          sign_before_operation = Immediate[15];
          value_before_operation = Immediate;
          if (RA == 1'd0) begin
            if (Immediate[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = X / Immediate;
         end
          else begin
            if (Immediate[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = Y / Immediate;
          end
            flags[0] = 1'd0;
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
        6'b010011: begin
          if (Immediate == 16'd0) begin
          sign_before_operation = ACC[15];
          value_before_operation = ACC;
          if (RA == 1'd0) begin
            if (ACC[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = ACC % X;
         end
          else begin
            if (ACC[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = ACC % Y;
          end
            flags[0] = 1'd0;
            flags[1] = 1'd0;
            if  (res ==  16'd0) //  zero
              flags[3] = 1'd1;
          else 
              flags[3] = 1'd0;
            if (res[15] == 1'd1) /* negative */
              flags[2] = 1'd1;
          else
              flags[2] = 1'd0;
       end
    else begin
          sign_before_operation = Immediate[15];
          value_before_operation = Immediate;
          if (RA == 1'd0) begin
            if (Immediate[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = X % Immediate;
         end
          else begin
            if (Immediate[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = Y % Immediate;
          end
            flags[0] = 1'd0;
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
       6'b010100: begin
          if (Immediate == 16'd0) begin
          sign_before_operation = ACC[15];
          value_before_operation = ACC;
          if (RA == 1'd0) begin
            if (ACC[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = ACC - X;
         end
          else begin
            if (ACC[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = ACC - Y;
          end
          if (same_sign == 1'd1 && sign_before_operation != res[15]) /* overflow */
              flags[0] = 1'd1;
        else
              flags[0] = 1'd0; 
            if (res > value_before_operation) // borrow
              flags[1] = 1'd1;
            else
              flags[1] = 1'd0;
            if  (res ==  16'd0) //  zero
              flags[3] = 1'd1;
          else 
              flags[3] = 1'd0;
            if (res[15] == 1'd1) /* negative */
              flags[2] = 1'd1;
          else
              flags[2] = 1'd0;
       end
    else begin
          sign_before_operation = Immediate[15];
          value_before_operation = Immediate;
          if (RA == 1'd0) begin
            if (Immediate[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = X - Immediate;
         end
          else begin
            if (Immediate[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = Y - Immediate;
          end
          if (same_sign == 1'd1 && sign_before_operation != res[15])
              flags[0] = 1'd1;
        else
              flags[0] = 1'd0; 
            if (res > value_before_operation) 
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
        6'b010101: begin
          sign_before_operation = 1'b0;
          value_before_operation = 16'd1;
          if (RA == 1'd0) begin
            if (1'd0 == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = X + 16'd1;
         end
          else begin
            if (1'd0 == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = Y + 16'd1;
          end
          if (same_sign == 1'd1 && sign_before_operation != res[15])
              flags[0] = 1'd1;
        else
              flags[0] = 1'd0; 
            if (res < value_before_operation) 
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
       6'b010110: begin
          sign_before_operation = 1'b0;
          value_before_operation = 16'd1;
          if (RA == 1'd0) begin
            if (1'd0 == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = X - 16'd1;
         end
          else begin
            if (1'd0 == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = Y - 16'd1;
          end
          if (same_sign == 1'd1 && sign_before_operation != res[15])
              flags[0] = 1'd1;
        else
              flags[0] = 1'd0; 
            if (res > value_before_operation) 
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
    6'b010111: begin
          if (Immediate == 16'd0) begin
          sign_before_operation = ACC[15];
          value_before_operation = ACC;
          if (RA == 1'd0) begin
            if (ACC[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = ACC & X;
         end
          else begin
            if (ACC[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = ACC & Y;
          end
            flags[0] = 1'd0;
            flags[1] = 1'd0;
            if  (res ==  16'd0) //  zero
              flags[3] = 1'd1;
          else 
              flags[3] = 1'd0;
            if (res[15] == 1'd1) /* negative */
              flags[2] = 1'd1;
          else
              flags[2] = 1'd0;
       end
    else begin
          sign_before_operation = Immediate[15];
          value_before_operation = Immediate;
          if (RA == 1'd0) begin
            if (Immediate[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = X & Immediate;
         end
          else begin
            if (Immediate[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = Y & Immediate;
          end
             flags[0] = 1'd0;
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
     6'b011000: begin
          if (Immediate == 16'd0) begin
          sign_before_operation = ACC[15];
          value_before_operation = ACC;
          if (RA == 1'd0) begin
            if (ACC[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = ACC | X;
         end
          else begin
            if (ACC[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = ACC | Y;
          end
            flags[0] = 1'd0;
            flags[1] = 1'd0;
            if  (res ==  16'd0) //  zero
              flags[3] = 1'd1;
          else 
              flags[3] = 1'd0;
            if (res[15] == 1'd1) /* negative */
              flags[2] = 1'd1;
          else
              flags[2] = 1'd0;
       end
    else begin
          sign_before_operation = Immediate[15];
          value_before_operation = Immediate;
          if (RA == 1'd0) begin
            if (Immediate[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = X | Immediate;
         end
          else begin
            if (Immediate[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = Y | Immediate;
          end
             flags[0] = 1'd0;
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
      6'b011001: begin
          if (Immediate == 16'd0) begin
          sign_before_operation = ACC[15];
          value_before_operation = ACC;
          if (RA == 1'd0) begin
            if (ACC[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = ACC ^ X;
         end
          else begin
            if (ACC[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = ACC ^ Y;
          end
            flags[0] = 1'd0;
            flags[1] = 1'd0;
            if  (res ==  16'd0) //  zero
              flags[3] = 1'd1;
          else 
              flags[3] = 1'd0;
            if (res[15] == 1'd1) /* negative */
              flags[2] = 1'd1;
          else
              flags[2] = 1'd0;
       end
    else begin
          sign_before_operation = Immediate[15];
          value_before_operation = Immediate;
          if (RA == 1'd0) begin
            if (Immediate[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = X ^ Immediate;
         end
          else begin
            if (Immediate[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = Y ^ Immediate;
          end
             flags[0] = 1'd0;
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
      6'b011010: begin
          if (RA == 1'd0) begin
            res = ~X;
         end
          else begin
            res = ~Y;
          end
             flags[0] = 1'd0;
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
     6'b011011: begin
          if (Immediate == 16'd0) begin
          sign_before_operation = ACC[15];
          value_before_operation = ACC;
          if (RA == 1'd0) begin
            if (ACC[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
              res = ACC;
              rotate_cnt = X;
              while (rotate_cnt > 0) begin
                res = {res[0], res[15:1]}; 
                rotate_cnt = rotate_cnt - 16'd1;
 
           
  end
         end
          else begin
            if (ACC[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = ACC;
            rotate_cnt = Y;
            while (rotate_cnt > 0) begin
              res = {res[0], res[15:1]};
              rotate_cnt = rotate_cnt - 16'd1;
  
         
  end
          end
            flags[0] = 1'd0;
            flags[1] = 1'd0;
            if  (res ==  16'd0) //  zero
              flags[3] = 1'd1;
          else 
              flags[3] = 1'd0;
            if (res[15] == 1'd1) /* negative */
              flags[2] = 1'd1;
          else
              flags[2] = 1'd0;
       end
    else begin
          sign_before_operation = Immediate[15];
          value_before_operation = Immediate;
          if (RA == 1'd0) begin
            if (Immediate[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = X;
            rotate_cnt = Immediate;
            while (rotate_cnt > 0) begin
              res = {res[0], res[15:1]};  
              rotate_cnt = rotate_cnt - 16'd1;
         
  end
         end
          else begin
            if (Immediate[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = Y;
            rotate_cnt = Immediate;
            while (rotate_cnt > 0) begin
              res = {res[0], res[15:1]};
              rotate_cnt = rotate_cnt - 16'd1;
  
         
  end
          end
             flags[0] = 1'd0;
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
     6'b011100: begin
          if (Immediate == 16'd0) begin
          sign_before_operation = ACC[15];
          value_before_operation = ACC;
          if (RA == 1'd0) begin
            if (ACC[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
              res = ACC;
              rotate_cnt = X;
              while (rotate_cnt > 0) begin
                res = {res[14:0],res[15]}; 
                rotate_cnt = rotate_cnt - 16'd1;
 
           
  end
         end
          else begin
            if (ACC[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = ACC;
            rotate_cnt = Y;
            while (rotate_cnt > 0) begin
              res = {res[14:0],res[15]}; 
              rotate_cnt = rotate_cnt - 16'd1;
         
  end
          end
            flags[0] = 1'd0;
            flags[1] = 1'd0;
            if  (res ==  16'd0) //  zero
              flags[3] = 1'd1;
          else 
              flags[3] = 1'd0;
            if (res[15] == 1'd1) /* negative */
              flags[2] = 1'd1;
          else
              flags[2] = 1'd0;
       end
    else begin
          sign_before_operation = Immediate[15];
          value_before_operation = Immediate;
          if (RA == 1'd0) begin
            if (Immediate[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = X;
            rotate_cnt = Immediate;
            while (rotate_cnt > 0) begin
              res = {res[14:0],res[15]}; 
              rotate_cnt = rotate_cnt - 16'd1;
         
  end
         end
          else begin
            if (Immediate[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = Y;
            rotate_cnt = Immediate;
            while (rotate_cnt > 0) begin
              res = {res[14:0],res[15]}; 
              rotate_cnt = rotate_cnt - 16'd1;
         
  end
          end
             flags[0] = 1'd0;
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
    6'b011101: begin
          sign_before_operation = fact_reg[15];
          value_before_operation = fact_reg;
            if (fact_reg[15] == fact_val[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            if (fact_val == 16'd0)
              res = fact_reg;
            else
              res = fact_reg * fact_val;
             if (same_sign == 1'd1 && sign_before_operation != res[15]) /* overflow */
              flags[0] = 1'd1;
            else
              flags[0] = 1'd0; 
            if (res < value_before_operation) // carry
              flags[1] = 1'd1;
            else
              flags[1] = 1'd0;
            if  (res ==  16'd0) //  zero
              flags[3] = 1'd1;
          else 
              flags[3] = 1'd0;
            if (res[15] == 1'd1) /* negative */
              flags[2] = 1'd1;
          else
              flags[2] = 1'd0;
    end
      endcase
    end
  end
  
endmodule