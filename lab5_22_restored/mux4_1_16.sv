module mux4_1_16	(input				[1:0] S,
						input					[15:0] A_In,
						input 				[15:0] B_In,
						input					[15:0] C_In,
						input 				[15:0] D_In,
						output logic		[15:0] Q_Out);
						
		// 16 bit parallel multiplexer implemented using case statement
		always_comb
		begin
				unique case(S)
						2'b00	:	Q_Out <= A_In;
						2'b01	:	Q_Out <= B_In;
						2'b10	:	Q_Out <= C_In;
						2'b11	:	Q_Out <= D_In;
				endcase
		end
		
		
endmodule 