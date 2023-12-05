module CU(
  input [5:0] opcode,
  input RA, clk, rst,
  input [1:0] RA_stack,
  input [8:0] Immediate,
  input FACT_END,
  output reg IF, ID, EX, MEM, WB,
  output reg ALU, BRA, COND_BRA, COND_BRA_REQUIRES_ZERO, COND_BRA_REQUIRES_NEGATIVE, COND_BRA_REQUIRES_CARRY, COND_BRA_REQUIRES_OVERFLOW, L, S, TR, STACK_PSH,STACK_POP, MOV, flag_select, ACC_select, X_select, Y_select,PC_select,
  output reg FACT
);

// Define the states
parameter S_IF = 3'b001,
          S_ID = 3'b010,
          S_EX = 3'b011,
          S_MEM = 3'b100,
          S_WB = 3'b101;

// State register
reg [2:0] current_state = 3'b001, next_state = S_IF;

// Sequential logic to update the state
always @(negedge clk or negedge rst) begin
    if (!rst) begin
        current_state <= 3'b001; // Reset to S_IF
    end else begin
        #1
        current_state <= next_state;
    end
end

// Combinational logic to determine the next state
always @(*) begin
    case (current_state)
        S_IF: next_state = S_ID;
        S_ID: next_state = S_EX;
        S_EX: next_state = (FACT == 1'b1) ? S_EX : S_MEM; // Remain in S_EX if FACT is 1
        S_MEM: next_state = S_WB;
        S_WB: next_state = S_IF;
        default: next_state = S_IF;
    endcase
end

// Output logic
always @(current_state) begin
    IF = (current_state == S_IF);
    ID = (current_state == S_ID);
    EX = (current_state == S_EX);
    MEM = (current_state == S_MEM);
    WB = (current_state == S_WB);
end

always @(posedge FACT_END) begin
  FACT<= 0;
end


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
      FACT <= 1'd0;
    end
end

always @(negedge clk) begin
    if (ID)  begin
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
           FACT <= 1'd0;
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
           FACT <= 1'd0;
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
           FACT <= 1'd0;
       
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
            FACT <= 1'd0;
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
            FACT <= 1'd0;
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
   
    else if  (opcode < 6'b011110) begin
   
        if  (opcode == 6'b010100) begin // CMP
    
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
            FACT <= 1'd0;
          end
        else if (opcode == 6'b010101 || opcode == 6'b010110) begin // INC si DEC
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
            if (RA == 1'b0) begin
                  X_select <= 1'b1;
                  Y_select <= 1'b0;  
              end
            else if (RA == 1'b1) begin
                X_select <= 1'b0;
                Y_select <= 1'b1; 
            end
            PC_select <= 1'd0;
            FACT <= 1'd0;
        end
      else if (opcode == 6'b011101) begin // Factorial
                  if (RA == 1'd0) begin
                    X_select <= 1'd1;
                    Y_select <= 1'd0;
                  end
                  else begin
                    X_select <= 1'd0;
                    Y_select <= 1'd1;
                  end

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
            PC_select <= 1'd0;
            FACT <= 1'd1;
      end
    else  if  (opcode == 6'b011010) begin // NOT
    
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
            if (RA == 1'd0) begin
                X_select <= 1'd1;
                Y_select <= 1'd0;
            end
            else begin
                X_select <= 1'd0;
                Y_select <= 1'd1;
            end
            PC_select <= 1'd0;
            FACT <= 1'd0;
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
            FACT <= 1'd0;
          end
 
      end
      
        else if (opcode == 6'b011110) begin
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
            FACT <= 1'd0;
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
            FACT <= 1'd0;
        end
      end
end

endmodule
