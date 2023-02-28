module mux8_1_16	(input				[2:0] S,
						input					[15:0] A_In,
						input 				[15:0] B_In,
						input					[15:0] C_In,
						input 				[15:0] D_In,
						input					[15:0] E_In,
						input 				[15:0] F_In,
						input					[15:0] G_In,
						input 				[15:0] H_In,
						output logic		[15:0] Q_Out);
						
		// 16 bit parallel multiplexer implemented using case statement
		always_comb
		begin
				unique case(S)
						3'b000	:	Q_Out <= A_In;
						3'b001	:	Q_Out <= B_In;
						3'b010	:	Q_Out <= C_In;
						3'b011	:	Q_Out <= D_In;
						3'b100	:	Q_Out <= E_In;
						3'b101	:	Q_Out <= F_In;
						3'b110	:	Q_Out <= G_In;
						3'b111	:	Q_Out <= H_In;
				endcase
		end
		
		
endmodule 