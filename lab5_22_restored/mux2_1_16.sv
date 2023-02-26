module mux2_1_16	(	input				S,
						input					[15:0] A_In,
						input 				[15:0] B_In,
						output logic		[15:0] Q_Out);
						
		// 16 bit parallel multiplexer implemented using case statement
		always_comb
		begin
				unique case(S)
						1'b0	:	Q_Out <= A_In;
						1'b1	:	Q_Out <= B_In;
				endcase
		end
		
		
endmodule