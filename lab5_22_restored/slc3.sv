//------------------------------------------------------------------------------
// Company: 		 UIUC ECE Dept.
// Engineer:		 Stephen Kempf
//
// Create Date:    
// Design Name:    ECE 385 Lab 5 Given Code - SLC-3 top-level (Physical RAM)
// Module Name:    SLC3
//
// Comments:
//    Revised 03-22-2007
//    Spring 2007 Distribution
//    Revised 07-26-2013
//    Spring 2015 Distribution
//    Revised 09-22-2015 
//    Revised 06-09-2020
//	  Revised 03-02-2021
//------------------------------------------------------------------------------


module slc3(
	input logic [9:0] SW,
	input logic	Clk, Reset, Run, Continue,
	output logic [9:0] LED,
	input logic [15:0] Data_from_SRAM,
	output logic OE, WE,
	output logic [6:0] HEX0, HEX1, HEX2, HEX3,
	output logic [15:0] ADDR,
	output logic [15:0] Data_to_SRAM,
	output logic [15:0] tb_MAR,
	output logic [15:0] tb_PC,
	output logic [15:0] tb_MDR,
	output logic [15:0] tb_IR,
	output logic [7:0] stateNum, // FOR DEBUGGING
	output logic [15:0] Data_to_CPU, // FOR DEBUGGING
	output logic LD_MDR, LD_CC, // FOR DEBUGGING
	output logic [15:0] DEBUGADDR_1, DEBUGADDR_2, SR1_Out, SR2_Out, Bus, R0, R1, R2, R3, R4, R5, R6, R7, // FOR DEBUGGING
	output logic [1:0] BUSMUX, // FOR DEBUGGING
	output logic BEN, // FOR DEBUGGING
	output logic [2:0] CC, CC_In // FOR DEBUGGING
);


// An array of 4-bit wires to connect the hex_drivers efficiently to wherever we want
// For Lab 1, they will direclty be connected to the IR register through an always_comb circuit
// For Lab 2, they will be patched into the MEM2IO module so that Memory-mapped IO can take place
logic [3:0] hex_4[3:0]; 
HexDriver hex_drivers[3:0] (hex_4, {HEX3, HEX2, HEX1, HEX0});
// This works thanks to http://stackoverflow.com/questions/1378159/verilog-can-we-have-an-array-of-custom-modules




// Internal connections
// logic LD_MDR, BEN, LD_CC;
// logic [15:0] Data_to_CPU, SR1_Out, SR2_Out;
// logic [2:0] CC, CC_In;
logic LD_MAR, LD_IR, LD_BEN, LD_REG, LD_PC, LD_LED;
logic GatePC, GateMDR, GateALU, GateMARMUX;
logic SR2MUX, ADDR1MUX, MARMUX;
logic MIO_EN, DRMUX, SR1MUX;
logic [1:0] PCMUX, ADDR2MUX, ALUK;
logic [15:0] MDR_In, PC_In, ALU_B;
logic [15:0] MAR, MDR, IR, PC, ALU;
logic [2:0] SR1, DR; // for Reg file
logic BEN_IN;


// Bus
// logic [15:0] Bus;


// Connect MAR to ADDR, which is also connected as an input into MEM2IO
//	MEM2IO will determine what gets put onto Data_CPU (which serves as a potential
//	input into MDR)
assign ADDR = MAR; 
assign MIO_EN = OE;
// Connect everything to the data path (you have to figure out this part)
datapath d0 (.*);

// Our SRAM and I/O controller (note, this plugs into MDR/MAR)

Mem2IO memory_subsystem(
    .*, .Reset(Reset), .ADDR(ADDR), .Switches(SW),
    .HEX0(hex_4[0][3:0]), .HEX1(hex_4[1][3:0]), .HEX2(hex_4[2][3:0]), .HEX3(hex_4[3][3:0]),
    .Data_from_CPU(MDR), .Data_to_CPU(Data_to_CPU),
    .Data_from_SRAM(Data_from_SRAM), .Data_to_SRAM(Data_to_SRAM)
);

// State machine, you need to fill in the code here as well
ISDU state_controller(
	.*, .Reset(Reset), .Run(Run), .Continue(Continue),
	.Opcode(IR[15:12]), .IR_5(IR[5]), .IR_11(IR[11]),
   .Mem_OE(OE), .Mem_WE(WE)
);


// special purpose registers
reg_16 _MAR (.Clk(Clk), .Reset(Reset), .Load(LD_MAR), .D(Bus), .Data_Out(MAR));
reg_16 _MDR (.Clk(Clk), .Reset(Reset), .Load(LD_MDR), .D(MDR_In), .Data_Out(MDR));
reg_16 _IR (.Clk(Clk), .Reset(Reset), .Load(LD_IR), .D(Bus), .Data_Out(IR));
reg_16 _PC (.Clk(Clk), .Reset(Reset), .Load(LD_PC), .D(PC_In), .Data_Out(PC));
reg_3 _CC (.Clk(Clk), .Reset(Reset), .Load(LD_CC), .D(CC_In), .Data_Out(CC)); // condition code register. B0 = P, B1 = Z, B2 = N
reg_1 _BEN (.Clk(Clk), .Reset(Reset), .Load(LD_BEN), .D(BEN_In), .Data_Out(BEN)); // Branch Enable register

// ALU
alu _ALU (.A(SR1_Out), .B(ALU_B), .ALUK(ALUK), .ALU(ALU));

// Register file
reg_file rf (.*, .SR2(IR[2:0]));

// SRAM WE register
//logic SRAM_WE_In, SRAM_WE;
//// SRAM WE synchronizer
//always_ff @(posedge Clk or posedge Reset_ah)
//begin
//	if (Reset_ah) SRAM_WE <= 1'b1; //resets to 1
//	else 
//		SRAM_WE <= SRAM_WE_In;
//end

// TEST HEX DISPLAYS
//assign hex_4[0][3:0] = IR[3:0];
//assign hex_4[1][3:0] = IR[7:4];
//assign hex_4[2][3:0] = IR[11:8];
//assign hex_4[3][3:0] = IR[15:12];

//TESTBENCH SIGNALS
assign tb_MAR = MAR;
assign tb_MDR = MDR;
assign tb_PC = PC;
assign tb_IR = IR;
endmodule
