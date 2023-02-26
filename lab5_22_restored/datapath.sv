module datapath (
	input logic LD_REG,
					LD_PC,
					LD_LED, // for PAUSE instruction
					GatePC,
					GateMDR,
					GateALU,
					GateMARMUX,
					DRMUX,
					SR1MUX,
					SR2MUX,
					ADDR1MUX,
					MIO_EN,
	input logic	[2:0] CC,
	input logic [1:0]  PCMUX,ADDR2MUX,
	input logic [15:0] PC, // gated signals to go on bus
							 MDR,
							 Data_to_CPU,
							 IR,
							 ALU,
	output logic [15:0] PC_In,
							  Bus,
							  MDR_In,
							  ALU_B,
	output logic BEN_In
);

logic [15:0] pc_plus_one;
logic [1:0] BUSMUX;

mux4_1_16 BUS_MUX (.S(BUSMUX), .A_In(PC), .B_In(MDR), .C_In(ADDR_Adder), .D_In(ALU), .Q_Out(Bus));

mux4_1_16 PC_MUX (.S(PCMUX), .A_In(pc_plus_one), .B_In(ADDR_Adder), .C_In(Bus), .D_In(16'b0), .Q_Out(PC_In));
mux2_1_16 MDR_MUX (.S(MIO_EN), .A_In(Bus), .B_In(Data_to_CPU), .Q_Out(MDR_In));
mux4_1_16 ADDR2_MUX (.S(ADDR2MUX), .A_In(16'b0), .B_In({IR[10], IR[10], IR[10], IR[10], IR[10], IR[10:0]}), .C_In({IR[8], IR[8], IR[8], IR[8], IR[8], IR[8], IR[8], IR[8:0]}), .D_In({IR[5], IR[5], IR[5], IR[5], IR[5], IR[5], IR[5], IR[5], IR[5], IR[5], IR[5:0]}), .Q_Out(ADDR2));
mux2_1_16 ADDR1_MUX (.S(ADDR1MUX), .A_In(PC), .B_In(16'b0), .Q_Out(ADDR1));
mux2_1_16 SR2_MUX (.S(SR2MUX), .A_In(16'b0), .B_In({IR[4],IR[4],IR[4],IR[4],IR[4],IR[4],IR[4],IR[4],IR[4],IR[4],IR[4],IR[4:0]}), .Q_Out(ALU_B));

lookahead_adder _ADDR_Adder (.A(ADDR1), .B(ADDR2), .cin(1'b0), .S(ADDR_Adder), .cout());

always_comb
begin
	pc_plus_one = PC + 16'b1;
	
	BUSMUX = 2'bxx;
	if (GatePC & ~(GateMDR | GateMARMUX | GateALU))
		BUSMUX = 2'b00;
	else if (GateMDR & ~(GatePC | GateMARMUX | GateALU))
		BUSMUX = 2'b01;
	else if (GateMARMUX & ~(GateMDR | GatePC | GateALU))
		BUSMUX = 2'b10;
	else if (GateALU & ~(GateMDR | GateMARMUX | GatePC))
		BUSMUX = 2'b11;	
		
	// CC to BEN_In logic
	BEN_In = (IR[11] & CC[2]) | (IR[10] & CC[1]) | (IR[9] & CC[0]);
	
end


endmodule 
