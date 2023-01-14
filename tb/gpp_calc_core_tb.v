module gpp_calc_core_tb;
reg clk;
reg rst;
integer i;
integer f;

gpp_calc_core GPP(.clk(clk),.rst(rst));

initial begin
   $readmemb("test.fic", GPP.InstructionMemory.rom); 
   $display("rom load successfully\n");
   reset_dm;
   $display("RAM has been initalised\n");
   rst <= 1'b1;
   clk <= 1'b0;
   #2 rst <= 1'b0;
   #1 rst <= 1'b1;
   $display("CPU has been initialised\n");
   for(i=0;i<10000;i=i+1) begin
     #3 clk = ~clk;
   end
   display_all_regs;
   display_dm;
end

task display_all_regs;
		begin
			$display("display_all_regs:");
			$display("------------------------------");
			$display("   ACC      X      Y  ");
			$write("%d ",GPP.ACC_value);
			$write("%d ",GPP.X_value);
			$write("%d \n",GPP.Y_value);
			$display("------------------------------");
			$display("FLAGS\n");
			$display("Z\tN\tC\tO\n");
			$display("%d\t%d\t%d\t%d\n",GPP.FlagsRegister.ZERO,GPP.FlagsRegister.NEGATIVE,GPP.FlagsRegister.CARRY,GPP.FlagsRegister.OVERFLOW);
		end
	endtask
	
task reset_dm;
    begin
      for(i=0;i<512;i=i+1) begin
          GPP.DataMemory.ram[i] = 16'd0;
      end
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
