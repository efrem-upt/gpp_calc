module CU(
  input [5:0] opcode,
  input RA, clk, rst,
  input [1:0] RA_stack,
  input [8:0] Immediate,
  output reg ALU, BRA, COND_BRA, COND_BRA_REQUIRES_ZERO, COND_BRA_REQUIRES_NEGATIVE, COND_BRA_REQUIRES_CARRY, COND_BRA_REQUIRES_OVERFLOW, L, S, TR, STACK_PSH,STACK_POP, MOV, flag_select, ACC_select, X_select, Y_select,PC_select
);

always @(negedge rst) begin
    if (!rst) begin
      ALU <= 1'd0;
      BRA<=  1'd0;
      COND_BRA <= 1'd0;
      COND_BRA_REQUIRES_ZERO <= 1'd0;
      COND_BRA_REQUIRES_NEGATIVE <= 1'd0;
      COND_BRA_REQUIRES_CARRY <= 1'd0;
      COND_BRA_REQUIRES_OVERFLOW <= 1'd0;
      L <= 1'd0;
      S <= 1'd0;
      TR <= 1'd0;
      STACK_PSH <= 1'd0;
      STACK_POP <= 1'd0;
      MOV <= 1'd0;
      flag_select <= 1'd0;
      ACC_select <= 1'd0;
      X_select <= 1'd0;
      Y_select <= 1'd0;
      PC_select <= 1'd0;
    end
end

always @(*) begin
      if (clk) begin
        if (opcode < 6'b000010) begin
            TR <= 1'd1;
            ALU <= 1'd0;
            BRA <= 1'd0;
            COND_BRA <= 1'd0;
            COND_BRA_REQUIRES_ZERO <= 1'd0;
            COND_BRA_REQUIRES_NEGATIVE <= 1'd0;
            COND_BRA_REQUIRES_CARRY <= 1'd0;
            COND_BRA_REQUIRES_OVERFLOW <= 1'd0;
            L <=  1'd0;
            S <= 1'd0;
            STACK_PSH <= 1'd0;
            STACK_POP <= 1'd0; 
            MOV <= 1'd0;
            flag_select <= 1'd0;
            ACC_select <= 1'd0;
            if (opcode == 6'b000000) begin
               X_select <= 1'd1;
               Y_select <= 1'd0;
            end
            else if (opcode == 6'b000001) begin
              X_select <= 1'd0;
              Y_select <= 1'd1;
           end
           PC_select <= 1'd0;
        end
        else if (opcode < 6'b000011) begin
            L <= 1'd1;
            ALU <= 1'd0;
            BRA <= 1'd0;
            COND_BRA <= 1'd0;
            COND_BRA_REQUIRES_ZERO <= 1'd0;
            COND_BRA_REQUIRES_NEGATIVE <= 1'd0;
            COND_BRA_REQUIRES_CARRY <= 1'd0;
            COND_BRA_REQUIRES_OVERFLOW <= 1'd0;
            S <= 1'd0;          
            TR <= 1'd0;                      
            STACK_PSH <= 1'd0;
            STACK_POP <= 1'd0;
            MOV <= 1'd0;
            flag_select <= 1'd0;
            ACC_select <= 1'd0;
            if (RA == 1'd0) begin
               X_select <= 1'd1;
               Y_select <= 1'd0;
            end
            else begin
              X_select <= 1'd0;
              Y_select <= 1'd1;
           end
           PC_select <= 1'd0;
        end
        else  if (opcode < 6'b000100) begin
            S <= 1'd1;
            ALU <= 1'd0;
            BRA <= 1'd0;
            COND_BRA <= 1'd0;
            COND_BRA_REQUIRES_ZERO <= 1'd0;
            COND_BRA_REQUIRES_NEGATIVE <= 1'd0;
            COND_BRA_REQUIRES_CARRY <= 1'd0;
            COND_BRA_REQUIRES_OVERFLOW <= 1'd0; 
            L <= 1'd0;          
            TR <= 1'd0;                      
            STACK_PSH <= 1'd0;
            STACK_POP <= 1'd0;
            MOV <= 1'd0;
            flag_select <= 1'd0;
            ACC_select <= 1'd0;
            if (RA == 1'd0) begin
               X_select <= 1'd1;
               Y_select <= 1'd0;
            end
            else begin
              X_select <= 1'd0;
              Y_select <= 1'd1;
           end
           PC_select <= 1'd0;
       
end
       
else if (opcode < 6'b000110) begin
      
            if (opcode == 6'b000100) begin
                STACK_PSH <= 1'd1;
                STACK_POP <= 1'd0; 
                L <= 1'd0;
                S <= 1'd1; 
            end
            else if (opcode == 6'b000101) begin
                STACK_PSH <= 1'd0;
                STACK_POP <= 1'd1;
                L <= 1'd1;
                S <= 1'd0;
            end 
            ALU <= 1'd0;
            BRA <= 1'd0;
            COND_BRA <= 1'd0;
            COND_BRA_REQUIRES_ZERO <= 1'd0;
            COND_BRA_REQUIRES_NEGATIVE <= 1'd0;
            COND_BRA_REQUIRES_CARRY <= 1'd0;
            COND_BRA_REQUIRES_OVERFLOW <= 1'd0;
            TR <= 1'd0;
            MOV <= 1'd0;
            flag_select <= 1'd0;
             if (RA_stack == 2'd0) begin
               X_select <= 1'd1;
               Y_select <= 1'd0;
               ACC_select <= 1'd0;
               PC_select <= 1'd0;
            end
            else if (RA_stack == 2'd1) begin
               X_select <= 1'd0;
               Y_select <= 1'd1;
               ACC_select <= 1'd0;
               PC_select <= 1'd0;
           end
         else if (RA_stack == 2'd2) begin
               X_select <= 1'd0;
               Y_select <= 1'd0;
               ACC_select <= 1'd1;
               PC_select <= 1'd0;
        end
        else if (RA_stack == 2'd3) begin
               X_select <= 1'd0;
               Y_select <= 1'd0;
               ACC_select <= 1'd0;
               PC_select <= 1'd1;
        end
      else begin
               X_select <= 1'd0;
               Y_select <= 1'd0;
               ACC_select <= 1'd0;
               PC_select <= 1'd0;
      end
           
  end
     
  else if (opcode  <  6'b001101) begin
            BRA <=  1'd1;
            if (opcode == 6'b000110) begin
                COND_BRA <= 1'd1;
                COND_BRA_REQUIRES_ZERO <= 1'd1;
                COND_BRA_REQUIRES_NEGATIVE <= 1'd0;
                COND_BRA_REQUIRES_CARRY <= 1'd0;
                COND_BRA_REQUIRES_OVERFLOW <= 1'd0;
            end
            else if (opcode == 6'b000111) begin
                COND_BRA <= 1'd1;
                COND_BRA_REQUIRES_ZERO <= 1'd0;
                COND_BRA_REQUIRES_NEGATIVE <= 1'd1;
                COND_BRA_REQUIRES_CARRY <= 1'd0;
                COND_BRA_REQUIRES_OVERFLOW <= 1'd0;
            end
          else if (opcode == 6'b001000) begin
                COND_BRA <= 1'd1;
                COND_BRA_REQUIRES_ZERO <= 1'd0;
                COND_BRA_REQUIRES_NEGATIVE <= 1'd0;
                COND_BRA_REQUIRES_CARRY <= 1'd1;
                COND_BRA_REQUIRES_OVERFLOW <= 1'd0;
          end
          else if (opcode == 6'b001001) begin
                COND_BRA <= 1'd1;
                COND_BRA_REQUIRES_ZERO <= 1'd0;
                COND_BRA_REQUIRES_NEGATIVE <= 1'd0;
                COND_BRA_REQUIRES_CARRY <= 1'd0;
                COND_BRA_REQUIRES_OVERFLOW <= 1'd1;
          end
          else if (opcode == 6'b001010) begin
                COND_BRA <= 1'd0;
                COND_BRA_REQUIRES_ZERO <= 1'd0;
                COND_BRA_REQUIRES_NEGATIVE <= 1'd0;
                COND_BRA_REQUIRES_CARRY <= 1'd0;
                COND_BRA_REQUIRES_OVERFLOW <= 1'd0;
          end
            ALU <= 1'd0;
            STACK_PSH <= 1'd0;
            STACK_POP <= 1'd0;
            L <= 1'd0;
            S <= 1'd0;
            TR <= 1'd0;
            MOV <= 1'd0;
            flag_select <= 1'd0;
            ACC_select <= 1'd0;
            X_select <= 1'd0;
            Y_select <= 1'd0;
            PC_select <= 1'd0;
   
    end 
   
    else if  (opcode < 6'b010111) begin
   
        if  (opcode == 6'b010100) begin

            ALU <=  1'd1;
            BRA <= 1'd0;
            COND_BRA <= 1'd0;
            COND_BRA_REQUIRES_ZERO <= 1'd0;
            COND_BRA_REQUIRES_NEGATIVE <= 1'd0;
            COND_BRA_REQUIRES_CARRY <= 1'd0;
            COND_BRA_REQUIRES_OVERFLOW <= 1'd0;
            STACK_PSH <= 1'd0;
            STACK_POP <= 1'd0;
            L <= 1'd0;
            S <= 1'd0;
            TR <= 1'd0;
            MOV <= 1'd0;
            flag_select <= 1'd1;
            ACC_select <= 1'd0;
            X_select <= 1'd0;
            Y_select <= 1'd0;
            PC_select <= 1'd0;
 
          end
 
          else begin
 
            ALU <=  1'd1;
            BRA <= 1'd0;
            COND_BRA <= 1'd0;
            COND_BRA_REQUIRES_ZERO <= 1'd0;
            COND_BRA_REQUIRES_NEGATIVE <= 1'd0;
            COND_BRA_REQUIRES_CARRY <= 1'd0;
            COND_BRA_REQUIRES_OVERFLOW <= 1'd0;
            STACK_PSH <= 1'd0;
            STACK_POP <= 1'd0;
            L <= 1'd0;
            S <= 1'd0;
            TR <= 1'd0;
            MOV <= 1'd0; 
            flag_select <= 1'd1;
            if (Immediate == 16'd0) begin
              ACC_select <= 1'd1;
              X_select <= 1'd0;
              Y_select <= 1'd0;
            end
            else begin
              ACC_select <= 1'd0;
              if (RA == 1'b0) begin
                  X_select <= 1'b1;
                  Y_select <= 1'b0;  
              end
            else if (RA == 1'b1) begin
                X_select <= 1'b0;
                Y_select <= 1'b1; 
          end
            end
            
            PC_select <= 1'd0;
          end
 
      end
        else if (opcode == 6'b010111) begin
            ALU <=  1'd0;
            BRA <= 1'd0;
            COND_BRA <= 1'd0;
            COND_BRA_REQUIRES_ZERO <= 1'd0;
            COND_BRA_REQUIRES_NEGATIVE <= 1'd0;
            COND_BRA_REQUIRES_CARRY <= 1'd0;
            COND_BRA_REQUIRES_OVERFLOW <= 1'd0;
            STACK_PSH <= 1'd0;
            STACK_POP <= 1'd0;
            L <= 1'd0;
            S <= 1'd0;
            TR <= 1'd0;
            MOV <= 1'd1; 
            flag_select <= 1'd0;
            ACC_select <= 1'd0;
            if (RA == 1'd0) begin
               X_select <= 1'd1;
               Y_select <= 1'd0;
            end
            else begin
              X_select <= 1'd0;
              Y_select <= 1'd1;
           end
            PC_select <= 1'd0;
        end
        else begin
            ALU <=  1'd0;
            BRA <= 1'd0;
            STACK_PSH <= 1'd0;
            STACK_POP <= 1'd0;
            L <= 1'd0;
            S <= 1'd0;
            TR <= 1'd0;
            MOV <= 1'd0; 
            flag_select <= 1'd0;
            ACC_select <= 1'd0;
            X_select <= 1'd0;
            Y_select <= 1'd0;
            PC_select <= 1'd0;
        end
    end
end

endmodule
