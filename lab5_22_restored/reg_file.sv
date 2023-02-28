module reg_file (
	input [15:0] Bus,
	input [2:0] DR, SR1, SR2,
	input LD_REG, Clk,
	output [15:0] SR1_Out, SR2_Out
);

logic L0, L1, L2, L3, L4, L5, L6, L7; // load for each register
logic R0, R1, R2, R3, R4, R5, R6, R7; // Outputs of each register

reg_16 _R0 (.Clk(Clk), .Reset(), .Load(L0), .D(Bus), .Data_Out(R0));
reg_16 _R1 (.Clk(Clk), .Reset(), .Load(L1), .D(Bus), .Data_Out(R1));
reg_16 _R2 (.Clk(Clk), .Reset(), .Load(L2), .D(Bus), .Data_Out(R2));
reg_16 _R3 (.Clk(Clk), .Reset(), .Load(L3), .D(Bus), .Data_Out(R3));
reg_16 _R4 (.Clk(Clk), .Reset(), .Load(L4), .D(Bus), .Data_Out(R4));
reg_16 _R5 (.Clk(Clk), .Reset(), .Load(L5), .D(Bus), .Data_Out(R5));
reg_16 _R6 (.Clk(Clk), .Reset(), .Load(L6), .D(Bus), .Data_Out(R6));
reg_16 _R7 (.Clk(Clk), .Reset(), .Load(L7), .D(Bus), .Data_Out(R7));

mux8_1_16 SR1OUT (.S(SR1), .A_In(R0), .B_In(R1), .C_In(R2), .D_In(R3), .E_In(R4), .F_In(R5), .G_In(R6), .H_In(R7), .Q_Out(SR1_Out));
mux8_1_16 SR2OUT (.S(SR2), .A_In(R0), .B_In(R1), .C_In(R2), .D_In(R3), .E_In(R4), .F_In(R5), .G_In(R6), .H_In(R7), .Q_Out(SR2_Out));

always_comb 
begin
	L0=1'b0;L1=1'b0;L2=1'b0;L3=1'b0;L4=1'b0;L5=1'b0;L6=1'b0;L7=1'b0;
	
	if (LD_REG == 1'b1) begin 
		if (DR == 3'b000)
			L0 = 1'b1;
		else if (DR == 3'b001)
			L1 = 1'b1;
		else if (DR == 3'b010)
			L2 = 1'b1;
		else if (DR == 3'b011)
			L3 = 1'b1;
		else if (DR == 3'b100)
			L4 = 1'b1;
		else if (DR == 3'b101)
			L5 = 1'b1;
		else if (DR == 3'b110)
			L6 = 1'b1;
		else if (DR == 3'b111)
			L7 = 1'b1;
	end

end

endmodule 