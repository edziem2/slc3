module reg_3 ( input						Clk, Reset, Load,
					input					[2:0] D,
					output logic 			[2:0] Data_Out);
					
		always_ff @ (posedge Clk)
		begin
				// Setting the output Q[2..0] of the register to zeros as Reset is pressed
				if(Reset) //notice that this is a synchronous reset
					Data_Out <= 3'b000;
				// Loading D into register when load button is pressed (will eiher be switches or result of sum)
				else if(Load)
					Data_Out <= D;
		end
		
endmodule