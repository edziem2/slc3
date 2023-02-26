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
	input logic [1:0]  PCMUX,ADDR2MUX, ALUK,
	input logic [15:0] PC,
							 MDR,
							 Data_to_CPU,
							 IR,
	output logic [15:0] PC_In,
							  Bus,
							  MDR_In,
	output logic BEN_In
);

logic [15:0] pc_plus_one;
logic [1:0] BUSMUX;

mux4_1_16 PC_MUX (.S(PCMUX), .A_In(pc_plus_one), .B_In(16'b0), .C_In(Bus), .D_In(16'b0), .Q_Out(PC_In));
mux4_1_16 BUS_MUX (.S(BUSMUX), .A_In(PC), .B_In(MDR), .C_In(16'b0), .D_In(16'b0), .Q_Out(Bus));
mux2_1_16 MDR_MUX (.S(MIO_EN), .A_In(Bus), .B_In(Data_to_CPU), .Q_Out(MDR_In));
mux4_1_16 ADDR2_MUX (.S(ADDR2MUX), .A_In(16'b0), .B_In({IR[10], IR[10], IR[10], IR[10], IR[10], IR[10:0]}), .C_In({IR[10], IR[10], IR[10], IR[10], IR[10], IR[10], IR[10], IR[8:0]}), .D_In({IR[10], IR[10], IR[10], IR[10], IR[10], IR[10], IR[10], IR[10], IR[10], IR[10], IR[5:0]}), .Q_Out(ADDR2));

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
