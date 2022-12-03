module gcc_calc_core_tb;
reg clk;
reg rst;
integer i;
integer f;

gpp_calc_core GPP(.clk(clk),.rst(rst));

initial begin
   $readmemb("test.fic", GPP.InstructionMemory.rom); 
   $display("rom load successfully\n");
   rst <= 1'b1;
   clk <= 1'b0;
   #2 rst <= 1'b0;
   #1 rst <= 1'b1;
   $display("CPU has been initialised\n");
   for(i=0;i<19;i=i+1) begin
     #3 clk = ~clk;
     if (!clk) begin
       $display("current pc: %d\n", GPP.PC_value);
     end
   end
   display_all_regs;
   display_dm;
end

task display_all_regs;
		begin
			$display("display_all_regs:");
			$display("------------------------------");
			$display("ACC\tX\tY");
			$write("%d\t",GPP.ACC_value);
			$write("%d\t",GPP.X_value);
			$write("%d\n",GPP.Y_value);
		end
	endtask
	
task display_dm;
    begin
      f = $fopen("mem.txt","w");
      $display("Writing Data Memory contents to file..");
      for(i=0;i<512;i=i+1) begin
          $fwrite(f,"%d : %d\n",i,GPP.DataMemory.ram[i]);
      end
    end
endtask

endmodule
