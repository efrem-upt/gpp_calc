module FACT_CNT(
  input [8:0] cnt,
  input clk, rst, w,
  output reg [8:0] out,
  output reg FACT_END);
  
  always @(posedge clk, negedge rst) begin
    if (!rst) begin
      out = 9'd0; 
      FACT_END = 1'd0; 
    end
    else begin
       if (w) begin
          if (cnt == 9'd0) begin
            // tratarea cazului in care se calculeaza factorial de 0
            out = cnt;
            FACT_END = 1'd1;
            #6 FACT_END = 1'd0;
          end  
        else begin
          out = cnt;  
        end
       end
       else if (out > 9'd0) out = out - 9'd1; 
       
       if (out == 9'd1) FACT_END = 1'd1; // calculul factorialului se incheie cand timer-ul ajunge la 1
       else if (out == 9'd0) FACT_END = 1'd0;
    end
  end
    
endmodule
