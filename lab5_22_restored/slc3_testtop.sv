//SLC-3 Top level module for both simulation and synthesis using test_memory
//All synchronizers go here (both inputs and outputs)

module slc3_testtop(
	input logic [9:0] SW,
	input logic	Clk, Run, Continue,
	output logic [9:0] LED,
	output logic [6:0] HEX0, HEX1, HEX2, HEX3,
	output logic [15:0] tb_MAR,
	output logic [15:0] tb_PC,
	output logic [15:0] tb_MDR,
	output logic [15:0] tb_IR,
	//output logic       CE, UB, LB, OE, WE,
	//output logic [19:0] ADDR,
	//inout wire [15:0] Data 
	output logic [7:0] stateNum, // FOR DEBUGGING
	output logic [15:0] Data_to_CPU, // FOR DEBUGGING
	output logic LD_MDR, // FOR DEBUGGING
	output logic [15:0] Data_from_SRAM, // FOR DEBUGGING
	output logic [15:0] ADDR, // FOR DEBUGGING
	output logic [15:0] DEBUGADDR_1, DEBUGADDR_2, SR1_Out, SR2_Out, Bus, R0, R1, R2, R3, R4, R5, R6, R7, // FOR DEBUGGING
	output logic [1:0] BUSMUX // FOR DEBUGGING
);
// Input button synchronizer to cross clock domain
logic RUN_S, CONTINUE_S;
sync button_sync[1:0] (Clk, {Run, Continue}, {RUN_S, CONTINUE_S});

//logic [15:0] Data_from_SRAM;
//logic [15:0] ADDR;
logic [15:0] Data_to_SRAM; //needs to be wire since bidirectional
logic OE, WE;


// Declaration of push button active high signals	
logic Reset_ah, Continue_ah, Run_ah;

//assign Reset_ah = ~RESET_S;
assign Reset_ah = ~RUN_S & ~CONTINUE_S;
assign Run_ah = ~RUN_S;
assign Continue_ah = ~CONTINUE_S;

slc3 slc(.Reset(Reset_ah), .Continue(Continue_ah), .Run(Run_ah), .*);
test_memory mem(.Reset(Reset_ah), .Clk(Clk), .data(Data_to_SRAM), .address(ADDR[9:0]), .rden(OE), .wren(WE), .readout(Data_from_SRAM) );

endmodule
