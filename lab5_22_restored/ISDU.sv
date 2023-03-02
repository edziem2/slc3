//------------------------------------------------------------------------------
// Company:          UIUC ECE Dept.
// Engineer:         Stephen Kempf
//
// Create Date:    17:44:03 10/08/06
// Design Name:    ECE 385 Lab 6 Given Code - Incomplete ISDU
// Module Name:    ISDU - Behavioral
//
// Comments:
//    Revised 03-22-2007
//    Spring 2007 Distribution
//    Revised 07-26-2013
//    Spring 2015 Distribution
//    Revised 02-13-2017
//    Spring 2017 Distribution
//------------------------------------------------------------------------------

`include "SLC3_2.sv"
import SLC3_2::*;

module ISDU (   input logic         Clk, 
									Reset,
									Run,
									Continue,
									
				input logic[3:0]    Opcode, 
				input logic         IR_5,
				input logic         IR_11,
				input logic         BEN,
				  
				output logic        LD_MAR,
									LD_MDR,
									LD_IR,
									LD_BEN,
									LD_CC,
									LD_REG,
									LD_PC,
									LD_LED, // for PAUSE instruction
									
				output logic        GatePC,
									GateMDR,
									GateALU,
									GateMARMUX,
									
				output logic [1:0]  PCMUX,
				output logic        DRMUX,
									SR1MUX,
									SR2MUX,
									ADDR1MUX,
				output logic [1:0]  ADDR2MUX,
									ALUK,
				  
				output logic        Mem_OE,
									Mem_WE,
				output logic [7:0] stateNum // FOR DEBUGGING
				);

	enum logic [7:0] {  Halted, 
						PauseIR1, 
						PauseIR2, 
						S_18, 
						S_33_1, S_33_2, S_33_3, S_33_4, 
						S_35, 
						S_32, 
						S_01,
						S_05,
						S_09,
						S_06_1, S_06_2, S_06_3, S_06_4, S_06_5, S_06_6,
						S_07_1, S_07_2, S_07_3, S_07_4, S_07_5, S_07_6,
						S_04_1, S_04_2,
						S_12,
						S_00_1, S_00_2}   State, Next_state;   // Internal state logic
	
		
	
	
	always_ff @ (posedge Clk)
	begin
		if (Reset) 
			State <= Halted;
		else 
			State <= Next_state;
	end
   
	always_comb
	begin 
		unique case (State)
			S_18 :
				stateNum = 8'h18;
			S_33_1 :
				stateNum = 8'h33;
			S_33_2 :
				stateNum = 8'h33;
			S_33_3 :
				stateNum = 8'h33;
			S_33_4 :
				stateNum = 8'h33;
			S_35 :
				stateNum = 8'h35;
			S_32 :
				stateNum = 8'h32;
			S_01 :
				stateNum = 8'h01;
			S_05 :
				stateNum = 8'h05;
			S_09 :
				stateNum = 8'h09;
			S_06_1, S_06_2, S_06_3, S_06_4, S_06_5, S_06_6 :
				stateNum = 8'h06;
			S_07_1, S_07_2, S_07_3, S_07_4, S_07_5, S_07_6 :
				stateNum = 8'h07;
			S_04_1, S_04_2 :
				stateNum = 8'h04;
			S_12 :
				stateNum = 8'h12;
			S_00_1, S_00_2 :
				stateNum = 8'h00;
			PauseIR1 :
				stateNum = 8'hf1;
			PauseIR2 :
				stateNum = 8'hf2;
			Halted :
				stateNum = 8'hf3;
			default: stateNum = 8'hff;
		endcase 
	
		// Default next state is staying at current state
		Next_state = State;
		
		// Default controls signal values
		LD_MAR = 1'b0;
		LD_MDR = 1'b0;
		LD_IR = 1'b0;
		LD_BEN = 1'b0;
		LD_CC = 1'b0;
		LD_REG = 1'b0;
		LD_PC = 1'b0;
		LD_LED = 1'b0;
		 
		GatePC = 1'b0;
		GateMDR = 1'b0;
		GateALU = 1'b0;
		GateMARMUX = 1'b0;
		 
		ALUK = 2'b00;
		 
		PCMUX = 2'b00;
		DRMUX = 1'b0;
		SR1MUX = 1'b0;
		SR2MUX = 1'b0;
		ADDR1MUX = 1'b0;
		ADDR2MUX = 2'b00;
		 
		Mem_OE = 1'b0;
		Mem_WE = 1'b0;
	
		// Assign next state
		unique case (State)
			Halted : 
				if (Run) 
					Next_state = S_18;                      
			S_18 : 
				Next_state = S_33_1;
			// Any states involving SRAM require more than one clock cycles.
			// The exact number will be discussed in lecture.
			S_33_1 : 
				Next_state = S_33_2;
			S_33_2 : 
				Next_state = S_33_3;
			S_33_3 : 
				Next_state = S_33_4;
			S_33_4 : 
				Next_state = S_35;
			S_35 : 
				Next_state = S_32;
			// PauseIR1 and PauseIR2 are only for Week 1 such that TAs can see 
			// the values in IR.
			PauseIR1 : 
				if (~Continue) 
					Next_state = PauseIR1;
				else 
					Next_state = PauseIR2;
			PauseIR2 : 
				if (Continue) 
					Next_state = PauseIR2;
				else 
					Next_state = S_18;
			S_32 : 
				case (Opcode)
					op_ADD :
						Next_state = S_01;
					op_AND :
						Next_state = S_05;
					op_NOT :
						Next_state = S_09;
					op_LDR:
						Next_state = S_06_1;
					op_STR:
						Next_state = S_07_1;
					op_JSR:
						Next_state = S_04_1;
					op_JMP:
						Next_state = S_12;
					op_BR:
						Next_state = S_00_1;
					op_PSE:
						Next_state = PauseIR1;

					// You need to finish the rest of opcodes.....

					default : 
						Next_state = S_18;
				endcase
			S_01, S_05, S_09, S_06_6, S_07_6, S_04_2, S_12, S_00_2:
				Next_state = S_18;
			// You need to finish the rest of states.....
			S_06_1:
				Next_state = S_06_2;
			S_06_2:
				Next_state = S_06_3;
			S_06_3:
				Next_state = S_06_4;
			S_06_4:
				Next_state = S_06_5;
			S_06_5:
				Next_state = S_06_6;
			S_07_1:
				Next_state = S_07_2;
			S_07_2:
				Next_state = S_07_3;
			S_07_3:
				Next_state = S_07_4;
			S_07_4:
				Next_state = S_07_5;
			S_07_5:
				Next_state = S_07_6;
			S_04_1:
				Next_state = S_04_2;
			S_00_1:
				Next_state = S_00_2;

			default : ;

		endcase
		
		// Assign control signals based on current state
		case (State)
			Halted: ;
			S_18 : 
				begin 
					GatePC = 1'b1;
					LD_MAR = 1'b1;
					PCMUX = 2'b00;
					LD_PC = 1'b1;
				end
			S_33_1 : 
				Mem_OE = 1'b1; // By default gets data from Mem2IO
			S_33_2, S_33_3, S_33_4 : 
				begin 
					Mem_OE = 1'b1;
					LD_MDR = 1'b1;
				end
			S_35 : 
				begin 
					GateMDR = 1'b1;
					LD_IR = 1'b1;
				end
			PauseIR1: ;
			PauseIR2: ;
			S_32 : 
				LD_BEN = 1'b1;
			S_01 : // ADD
				begin 
					SR2MUX = IR_5; // IR[5] chooses SR2 Out(0) or SEXT(imm5)(1)
					ALUK = 2'b00; // ALU selects ADD op
					GateALU = 1'b1; // Output of ALU drives the bus
					LD_REG = 1'b1; // Load register SR1 and SR2
					DRMUX = 1'b0; // DRMUX selects DR
					SR1MUX = 1'b0; // SR1MUX selects SR1
					LD_CC = 1'b1; // Load CC
				end
			S_05 : // AND
				begin
					GateALU = 1'b1; // Ouput of ALU drives the bus
					ALUK = 2'b01; // ALU selects AND op
					LD_REG = 1'b1; // Load register SR1 and SR2
					SR1MUX = 1'b0; // SR1MUX selects SR1
					DRMUX = 1'b0; // DRMUX selects DR
					SR2MUX = IR_5; // IR[5] chooses SR2 Out(0) or SEXT(imm5)(1)
					LD_CC = 1'b1; // Load CC
					
				end
			S_09 : // NOT
				begin
					GateALU = 1'b1; // Ouput of ALU drives the bus
					ALUK = 2'b10; // ALU selects AND op
					LD_REG = 1'b1; // Load register SR1 and SR2
					SR1MUX = 1'b0; // SR1MUX selects SR1
					DRMUX = 1'b0; // DRMUX selects DR
					SR2MUX = 1'b1; // SR2MUX selects SEXT(imm5)(1)
					LD_CC = 1'b1; // Load CC
				end
			S_06_1 : // LDR
				begin
					GateMARMUX = 1'b1; // Output of MAR Computation drives the bus
					LD_MAR = 1'b1; // Load MAR
					ADDR2MUX = 1'b01; // ADDR2MUX selects SEXT[5:0]
					ADDR1MUX = 1'b1; // ADDR1MUX selects SR1 Out
					SR1MUX = 1'b0; // SR1MUX selects SR1 (aka BaseR)
				end
			S_06_2 : // Load MDR from address specified by MAR
				Mem_OE = 1'b1;
			S_06_3, S_06_4, S_06_5 : 
				begin 
					Mem_OE = 1'b1;
					LD_MDR = 1'b1;
				end
			S_06_6 :
				begin
					GateMDR = 1'b1; // Output of MDR drives the bus
					DRMUX = 1'b0; // DRMUX selects DR
					LD_REG = 1'b1; // Load the registers (specifically DR)
					LD_CC = 1'b1; // Load CC
				end
			S_07_1: // STR
				begin // Below is IDENTICAL to S_06_1
					GateMARMUX = 1'b1; // Output of MAR Computation drives the bus
					LD_MAR = 1'b1; // Load MAR
					ADDR2MUX = 1'b01; // ADDR2MUX selects SEXT[5:0]
					ADDR1MUX = 1'b1; // ADDR1MUX selects SR1 Out
					SR1MUX = 1'b0; // SR1MUX selects SR1 (aka BaseR)
				end
			S_07_2:
				begin
					Mem_OE = 1'b0; // Pull input to MDR off the bus
					LD_MDR = 1'b1; // Load MDR
					ALUK = 2'b11; // Hotwire SR1
					GateALU = 1'b1; // Allow SR1 to drive the bus
					SR1MUX = 1'b1; // Let SR (DR) be selected by SR1MUX
				end
			S_07_3 :
					Mem_OE = 1'b1;
			S_07_4, S_07_5, S_07_6 :
				begin
					Mem_OE = 1'b1;
					LD_MDR = 1'b1;
				end
			S_04_1:
				begin
					GatePC = 1'b1; // Let PC Drive the bus
					DRMUX = 1'b1; // Set DR to R7
					LD_REG = 1'b1; // Load DR (R7)
				end
			S_04_2:
				begin
					PCMUX = 2'b01; // PCMUX selects computation of PC + off11
					ADDR1MUX = 1'b0; // Selects PC
					ADDR2MUX = 2'b11; // Selects off11
					LD_PC = 1'b1; // Load PC
				end
			S_12:
				begin
					ALUK = 2'b11; // Hotwire BaseR (SR1)
					GateALU = 1'b1; // Let ALU output drive the bus
					SR1MUX = 1'b0; // Let BaseR (SR1) be selected by SR1MUX
					PCMUX = 2'b10; // PC pulls directly off the bus
					LD_PC = 1'b1; // Load contents to PC
				end
			S_00_1: ; // Make a decision abt next state
			S_00_2:
				begin
				PCMUX = 2'b01; // Compute next PC
				ADDR1MUX = 1'b0; // Get PC
				ADDR2MUX = 1'b10; // Selects off9
				LD_PC = 1'b1; // Load PC
				end
			// You need to finish the rest of states.....

			default : ;
		endcase
	end 

	
endmodule
