module reg_1 ( input						Clk, Reset, Load,
					input					D,
					output logic 			Data_Out);
					
		always_ff @ (posedge Clk)
		begin
				// Setting the output Q[16..0] of the register to zeros as Reset is pressed
				if(Reset) //notice that this is a synchronous reset
					Data_Out <= 1'b0;
				// Loading D into register when load button is pressed (will eiher be switches or result of sum)
				else if(Load)
					Data_Out <= D;
		end
		
endmodule