module slc3Test();

timeunit 10ns;
timeprecision 1ns;

logic [9:0] SW;
logic Clk;
logic Run, Continue; // active low
logic [6:0] HEX0, HEX1, HEX2, HEX3;
logic [9:0] LED;
logic [15:0] tb_MAR, tb_MDR, tb_PC, tb_IR;
logic [7:0] stateNum; // FOR DEBUGGING
logic [15:0] Data_to_CPU; // FOR DEBUGGING
logic LD_MDR; // FOR DEBUGGING
logic [15:0] Data_from_SRAM;
logic [15:0] ADDR;
logic [15:0] DEBUGADDR_1, DEBUGADDR_2, SR1_Out, SR2_Out, Bus, R0, R1, R2, R3, R4, R5, R6, R7; // FOR DEBUGGING
logic [1:0] BUSMUX; // FOR DEBUGGING


slc3_testtop s(.*);

always begin : CLOCK_GENERATION
#1 Clk = ~Clk;
end

initial begin: CLOCK_INITIALIZATION
    Clk = 0;
end 

initial begin: TEST_VECTORS
Continue = 1'b0; // low activate
SW = 10'h14;
Run = 1'b0;

#6 Continue = 1'b1;

#4 Run = 1'b1;

#100 Continue = 1'b0;

#3 Continue = 1'b1;

#100 SW = 10'h14; 

#6 Continue = 1'b0;

#3 Continue = 1'b1;



//#10 Run = 1'b1;
//
//#3 Run = 1'b0;
//
//#10 Run = 1'b1;
//
//#3 Run = 1'b0;

end

endmodule
